Return-Path: <netdev+bounces-44032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F627D5E54
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE35A281AA8
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B620B0F;
	Tue, 24 Oct 2023 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hS0nCv4q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407D1DDEE
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5AEC433C7;
	Tue, 24 Oct 2023 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698187182;
	bh=MdrQ0drZMhMlMKUB/NpYgz/Yd6ojmydmi+DwKzo0HpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hS0nCv4qtaXnuQBu6YTzMXeouIrX6Y3a8J4jbdYabJ5Z1MBlYHEaS0SwFUU31XRE5
	 NkyML23UfWNXg/vBnPMLTt3PyEyo0RY7XHzYAHfuaUEP8dYgq1VBbPr5WjvfPyCnuc
	 jS6mU0+/ocMfRQPEddpOgLQd4Apo2Z9NSbj0O82B55qDbvPV2+VpC/eE9XlxXgZKZG
	 ykuUNH5FbisEL6ZMMzI8HSv20H+pFiNacTg1z8D852Ym5E86EE+j4QKE+6L9dtIUVe
	 HpaNYSHY5bKSSVolL0NPI4L8cbljWC+7oyQwBgeuiQafIZI5nQPA0W81OuvAdAEb20
	 cEgCsW4kk5J5w==
Date: Tue, 24 Oct 2023 15:39:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v6 06/10] netdev-genl: Add netlink framework
 functions for napi
Message-ID: <20231024153941.4c05da4b@kernel.org>
In-Reply-To: <169811123039.59034.9768807608201356902.stgit@anambiarhost.jf.intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
	<169811123039.59034.9768807608201356902.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 18:33:50 -0700 Amritha Nambiar wrote:
> +	rcu_read_lock();
> +
> +	napi = napi_by_id(napi_id);
> +	if (napi)
> +		err = netdev_nl_napi_fill_one(rsp, napi, info);
> +	else
> +		err = -EINVAL;
> +
> +	rcu_read_unlock();

Is rcu_read_lock always going to be sufficient here?
Reading of the thread, for example, without much locking could
potentially get problematic.

