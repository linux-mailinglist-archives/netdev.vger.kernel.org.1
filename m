Return-Path: <netdev+bounces-111173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 571ED9302CF
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA751F244F5
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDE68BEA;
	Sat, 13 Jul 2024 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UI0iAbYi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203F78BE0;
	Sat, 13 Jul 2024 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831454; cv=none; b=RjSyXW1j411QSDwzCJWV6SeGlzYcGQ7mJjRVxhEzhdieOPvoR4OjhgMugKX96SLRFHjkc8WrD9GNOBPGnPMA+F3ascwbVvQeWS5umxaHvlG9m+i1Jf1VTATIpXwTfcBr0EPM6SsrEEqEUGT0uE83NCfEL4p9RENKl64k6rnhxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831454; c=relaxed/simple;
	bh=0lSa+n1Wc+bgtWh/RKM9tBEzcuOC65FzEuQ+kr/8ZLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZ1YeTFtdL9u0ytLLKeQ4ohXaQrOLdaO+OkRUOjMquWav56l9cbfBxbdk6mjniCmjgY3q8QmxGoq1YjsQKiDPMqgD26FLtOhWqiV+djSQz28dTMpc4SbK8TLntzNp5Jf+fHbMW5GbaMU1zKBcodkYa9ZmJoe+zKjoJEIO/soP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UI0iAbYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEEFC32782;
	Sat, 13 Jul 2024 00:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720831453;
	bh=0lSa+n1Wc+bgtWh/RKM9tBEzcuOC65FzEuQ+kr/8ZLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UI0iAbYi5E7uUZgRhG3Gn+4Invx7bV2ZeTk2JO7xt7WonHuHq3T8MPLfZXbk82RG6
	 BTKeacCW0QE/UBeomCzoVqpNKZgfNTRwDPWdMJ+sk5IbUEpgYRKwbjt0xswaVFFcDn
	 qt1xLUoP8C61PqLg937dJtMKF3Znbc2ODPLj9T6gsAXj1VsFx5vz22w0LZCsiCzkkb
	 +o50H0RaE3HfysDWDJ8kTFPVhzVP77rb/hw8NBBKNduQ+IjE9fjwOTmAvZTOpMRhbZ
	 ZIZO55u9omXaIAw4Vj9vXHA8dgDXOjEefJofZL6FJ93gD6CwVmEXPiI0bTn5kp943+
	 SJgQf6fBqkARg==
Date: Fri, 12 Jul 2024 17:44:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: xiujianfeng <xiujianfeng@huawei.com>, <netdev@vger.kernel.org>, Linux
 kernel mailing list <linux-kernel@vger.kernel.org>, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev
Subject: Re: [BUG REPORT] kernel BUG at lib/dynamic_queue_limits.c:99!
Message-ID: <20240712174412.5226dd28@kernel.org>
In-Reply-To: <20240712174321.603b4436@kernel.org>
References: <08227db9-6ed7-4909-838d-ce9a0233fba3@huawei.com>
	<8036617e-62f3-17cb-f43a-80531e10e241@huawei.com>
	<20240712174321.603b4436@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 17:43:21 -0700 Jakub Kicinski wrote:
> CC: virtio_net maintainers and Jiri who added BQL

Oh, sounds like the fix may be already posted:
https://lore.kernel.org/all/20240712080329.197605-2-jean-philippe@linaro.org/

