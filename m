Return-Path: <netdev+bounces-199949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A509AE27D4
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C584F17E6E6
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90501C5D57;
	Sat, 21 Jun 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8xiYplK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E2A1A5B92;
	Sat, 21 Jun 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750492159; cv=none; b=eAvLjPjECO/J6uPdNot+W6t1gvDlEIe1t18kWQZ9r2rdzq2qXTTC4JiuQbkAP2ImePWq6jUIE+20l+EB2dNzMunrqWvcpzm13oybCBNEUMfeGuJ3lsVnhpXzw/RCkA7c/nqLRrZTWmCj1fXm33fTeiYV7hZEvtIr72cM94/VUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750492159; c=relaxed/simple;
	bh=D92eT9Xx7A/mwCmvtvVyVvyYZrjSeDvGxSVWf/q13Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqIja9+KSXIKrwrk17NHSqNMyrAV2x0uiPrKNZbngRB7PVXBhuR0Zoj1ek0yGmliJ6TdTNttYy2YvVmdkaEa26L9S8MsfxJkDlR3omXhRTDaec/JgDQriD4fZczh/DxrLMHpgRHFAcicyuCmKBfDIB5hVdP+6BiHS0HNTO4etdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8xiYplK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C9AC4CEE7;
	Sat, 21 Jun 2025 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750492159;
	bh=D92eT9Xx7A/mwCmvtvVyVvyYZrjSeDvGxSVWf/q13Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8xiYplKeHRRT583dTNY3TeIFIgxYTewhGYVSF5BzXeVTfy4kV7BqkR87eyo+mGt5
	 62IxdOEPJ681ntY/t/sDb1BUMSSXoZWfYhf+fXMAcw3LbCl05r9etlDomF54O3mVbZ
	 FVmbBXn2BoT5QKT+2p0Ff/Vwekvc9hmM/TPtRJLxZDGXaXZiWYsv+NK082wt4jsOkd
	 PQB9zGdmzS6R8UdYbbNurKh8laxo2V0NDRRud3QvuK31LVGJf+mypuw6uxFBJT0RQf
	 IYRWePpJdT/SEaUuoDZ3mVsfxDOsrDREdkPQ2A88Xt6W6Gw1f+XLgiwVgt32Pe7wwu
	 ZYntXXfDXoN6g==
Date: Sat, 21 Jun 2025 08:49:15 +0100
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] myri10ge: avoid uninitialized variable use
Message-ID: <20250621074915.GG9190@horms.kernel.org>
References: <20250620112633.3505634-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620112633.3505634-1-arnd@kernel.org>

On Fri, Jun 20, 2025 at 01:26:28PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While compile testing on less common architectures, I noticed that gcc-10 on
> s390 finds a bug that all other configurations seem to miss:
> 
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_set_multicast_list':
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:391:25: error: 'cmd.data0' is used uninitialized in this function [-Werror=uninitialized]
>   391 |  buf->data0 = htonl(data->data0);
>       |                         ^~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:25: error: '*((void *)&cmd+4)' is used uninitialized in this function [-Werror=uninitialized]
>   392 |  buf->data1 = htonl(data->data1);
>       |                         ^~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c: In function 'myri10ge_allocate_rings':
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:392:13: error: 'cmd.data1' is used uninitialized in this function [-Werror=uninitialized]
>   392 |  buf->data1 = htonl(data->data1);
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data1' was declared here
>  1939 |  struct myri10ge_cmd cmd;
>       |                      ^~~
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:393:13: error: 'cmd.data2' is used uninitialized in this function [-Werror=uninitialized]
>   393 |  buf->data2 = htonl(data->data2);
> drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1939:22: note: 'cmd.data2' was declared here
>  1939 |  struct myri10ge_cmd cmd;
> 
> It would be nice to understand how to make other compilers catch this as
> well, but for the moment I'll just shut up the warning by fixing the
> undefined behavior in this driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

That is a lovely mess.

Curiously I was not able to reproduce this on s390 with gcc 10.5.0.
Perhaps I needed to try harder. Or perhaps the detection is specific to a
very narrow set of GCC versions.

Regardless I agree with your analysis, but I wonder if the following is
also needed so that .data0, 1 and 2 are always initialised when used.

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index f9d6ba381361..4743064bc6d4 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -809,6 +809,7 @@ static int myri10ge_update_mac_address(struct myri10ge_priv *mgp,
 		     | (addr[2] << 8) | addr[3]);
 
 	cmd.data1 = ((addr[4] << 8) | (addr[5]));
+	cmd.data2 = 0;
 
 	status = myri10ge_send_cmd(mgp, MXGEFW_SET_MAC_ADDRESS, &cmd, 0);
 	return status;
@@ -820,6 +821,9 @@ static int myri10ge_change_pause(struct myri10ge_priv *mgp, int pause)
 	int status, ctl;
 
 	ctl = pause ? MXGEFW_ENABLE_FLOW_CONTROL : MXGEFW_DISABLE_FLOW_CONTROL;
+	cmd.data0 = 0,
+	cmd.data1 = 0,
+	cmd.data2 = 0,
 	status = myri10ge_send_cmd(mgp, ctl, &cmd, 0);
 
 	if (status) {

...

