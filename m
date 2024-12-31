Return-Path: <netdev+bounces-154610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250169FEC5B
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 03:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215C118828F9
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEEE487BF;
	Tue, 31 Dec 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jj63OoeX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9CF1EEE6
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735611112; cv=none; b=mzBp5VBuKlB5eb3nJSEzMOvTnf2XwKrNooKhu32mTzD024qAyei0Mr44KyAlSQV3sfxL+g+X2e9ckvLQReW0X7wb8THQxQ5dfKQbYxS4630pKraCR3D5LclmUocaxhv5LWnF6faZuJxbWxE8MCMssfXuHuwOOqJ7dzJvep7Frco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735611112; c=relaxed/simple;
	bh=01EXBqRKO4oE6MGImjvwytlDuhkItA9ipBwxWSXvBUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkjB0wHcOPQ3C/j9GeqnKDZtuXjpMLHRZFmpSPnfeU8RTuU4Tlbd90J8f/2BF5OG1vK3Oej0f1+Ur8Kj5amg4juAvn0+e6biEWFYzzGldPTUTnUcAmDZhQqECwswydfIT9FqTVnoAkPpdSvm0ZzKxCmNTm/9vjA2LePiUnZ4mUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jj63OoeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B99C4CED0;
	Tue, 31 Dec 2024 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735611111;
	bh=01EXBqRKO4oE6MGImjvwytlDuhkItA9ipBwxWSXvBUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jj63OoeXb0XqyjhSgIPkEeTAMdtmydlTgKX9KdzVbMPoY6x8mojBAHVp/omrZ/9u7
	 /nx4fR6stfTJgYzNBb6lHbEI35Eqi5OB88BmLTIkbclUf/DEPFhSpM0cRvti6ZhiWk
	 epHzDTKiPsTss5QJL9uAcGmyR4TdfSRQQr4+RRBa6DYqSAU/cuDqpiXDeKG46NVq9o
	 lvBFn6LXs+syMdxUQOCbeo43QAVMthFw2wp2NDGAPgMMTYpxzUxAdov5SRCXXQ5b16
	 qfAnZ8FpVh/mWs1OwMzIy9f91WtAPafDf2FOJcyeSxtWWP0cd5s2/hCdX76K49qrF9
	 GniMGbhX7LD3A==
Date: Mon, 30 Dec 2024 18:11:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net] net: libwx: fix firmware mailbox abnormal return
Message-ID: <20241230181150.3541a364@kernel.org>
In-Reply-To: <20241226031810.1872443-1-jiawenwu@trustnetic.com>
References: <20241226031810.1872443-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Dec 2024 11:18:10 +0800 Jiawen Wu wrote:
> Firmware writes back 'firmware ready' and 'unknown command' in the mailbox
> message if there is an unknown command sent by driver. It tends to happen
> with the use of custom firmware. So move the check for 'unknown command'
> out of the poll timeout for 'firmware ready'. And adjust the debug log so
> that mailbox messages are always printed when commands timeout.

The commit message doesn't really explain what the problem is, 
just what the code does. What is the problem you're solving 
and how does it impact the user?

> Fixes: 1efa9bfe58c5 ("net: libwx: Implement interaction with firmware")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 1bf9c38e4125..7059e0100c7c 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -334,27 +334,25 @@ int wx_host_interface_command(struct wx *wx, u32 *buffer,
>  	status = read_poll_timeout(rd32, hicr, hicr & WX_MNG_MBOX_CTL_FWRDY, 1000,
>  				   timeout * 1000, false, wx, WX_MNG_MBOX_CTL);
>  
> +	buf[0] = rd32(wx, WX_MNG_MBOX);
> +	if ((buf[0] & 0xff0000) >> 16 == 0x80) {
> +		wx_dbg(wx, "It's unknown cmd.\n");
> +		status = -EINVAL;
> +		goto rel_out;
> +	}

Why check this before the status check? If the poll timed out doesn't
it mean the FW did not respond?

>  	/* Check command completion */
>  	if (status) {
>  		wx_dbg(wx, "Command has failed with no status valid.\n");
> -
> -		buf[0] = rd32(wx, WX_MNG_MBOX);
> -		if ((buffer[0] & 0xff) != (~buf[0] >> 24)) {
> -			status = -EINVAL;
> -			goto rel_out;
> -		}
> -		if ((buf[0] & 0xff0000) >> 16 == 0x80) {
> -			wx_dbg(wx, "It's unknown cmd.\n");
> -			status = -EINVAL;
> -			goto rel_out;
> -		}
> 
> +		wx_dbg(wx, "check: %x %x\n", buffer[0] & 0xff, ~buf[0] >> 24);
> +		if ((buffer[0] & 0xff) != (~buf[0] >> 24))
> +			goto rel_out;

Inverse question here, I guess. Why is it only an error for FW not 
to be ready if cmd doesn't match?
-- 
pw-bot: cr

