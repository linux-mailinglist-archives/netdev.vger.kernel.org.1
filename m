Return-Path: <netdev+bounces-140586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB439B7189
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DB5281F67
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CF727702;
	Thu, 31 Oct 2024 01:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Feh0XcDG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C21EB31
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337431; cv=none; b=nbIC2ZJzFLRybQ3dHDFu9NGVyN1uh7DADmBpaZ8C7Paeq3/bts/P170fcdVrbg0DSSvdRM7Le6Xvgh9rHzK49Rft6OIh7tqcgqMRjGw4wEXQeQ0bU7HfIkRTmXQQgYEp1+RhV9e82+WIgDC1fcE3RWFzU++TsO8Bsx0fVrlGw2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337431; c=relaxed/simple;
	bh=aJ7Gjg+kX75Ji3y12sNo8oWtAZFkofxhsbFuwKqaUWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewyX5v+zwqNJxrxcBpbh+nj9mTQBwJRrPN1+PSLqFRibQ39WaXCpBz98nxmtBYNmiK/jFh7SJS4UKzmzfgB2JvBCuDKXHP+Xa2a7bnNXL/+dBX2Xxj0GY1XTOPRDf4pK/rqYsUf0uBQtXM5IQRKfVTshZKzsCrEWaK65r6a09SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Feh0XcDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DD9C4CECE;
	Thu, 31 Oct 2024 01:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730337430;
	bh=aJ7Gjg+kX75Ji3y12sNo8oWtAZFkofxhsbFuwKqaUWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Feh0XcDGyLihUvtPcgcVvratbbVuR1y88whzZUIah9qztLNVgjbr5/A8nmwddyrAl
	 ItYuDuex3TMzv0cM0lyRFog6+igWBNUO1rYhTXDz/y6sKXM9NDwv242cQqH73NkbIg
	 X4B8IS42HEM6j10ul3K//SoaIJncmPMr0zo67lBFhjpVekGL2kKrUd2j1wAA5I+4N4
	 3rVZJxY3QMNPIRhKkb86Vg8I3wCSu2cYFo/2PK4skWbIzamVXSK95HpLJxPY5I1Q9T
	 TchV3bnbo0LL4eso129URWl9y/paK0KcSEJoVuhiZyGRC2sJ0Bt9+YLk3MowSdvz+E
	 wwopWPklpuWmQ==
Date: Wed, 30 Oct 2024 18:17:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
 <kory.maincent@bootlin.com>, <horms@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <chenjun102@huawei.com>
Subject: Re: [PATCH net 0/2] Get the device_node before calling
 of_find_node_by_name()
Message-ID: <20241030181709.24ae5efb@kernel.org>
In-Reply-To: <20241024015909.58654-1-zhangzekun11@huawei.com>
References: <20241024015909.58654-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 09:59:07 +0800 Zhang Zekun wrote:
> of_find_node_by_name() will decrease the refount of the device node.
> Get the device_node before call to it.

Doing some quick grepping I think Andrew is completely right.
Most callers either get this wrong or call get() immediately prior.
Maybe add a new helper with more suitable semantics?

The goal is not to fix the bugs but to prevent them in the first place.
-- 
pw-bot: cr

