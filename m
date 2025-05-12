Return-Path: <netdev+bounces-189716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A17EAB3579
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CB58628CD
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB6B268FCC;
	Mon, 12 May 2025 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD6qfBig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2DC267B85
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047439; cv=none; b=DPzRwmdrgRM7cYqdpkKirB4p48CbJRff3QR10P7P8yXXvdBjkx+1ikYA7CBrnkZ/G/5FZ3CwYHoq/8s6GkrTk0M87hVWJLNzsZ0Opp5IuoE6ULEuwAj23ryuOor3+JSWJTGzfJJrG6Z4g+CJlNP9BeV48n6qOq/JXK2r1JQwChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047439; c=relaxed/simple;
	bh=i5ebpQwlcAkg+tah6S03pf4Ve/4SNna4Barm0m9q+jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/HQ0RF3KMTpdUK31JyUKxFQHfH2abFD9sUp8NNpB1U/A7lxoBX6p3Nxces5EImYCKnlpc0cnqSQqs2Xfn5FNS2T0Lt8hUpLzIIDXhcxZCa3r5SNH+5D4Y0ol4Z4uhjJWmFeOAyJ8DFM35voQqlbmDWM4uP3JQY7rm3BnlZ7avM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD6qfBig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBDCC4CEE7;
	Mon, 12 May 2025 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747047436;
	bh=i5ebpQwlcAkg+tah6S03pf4Ve/4SNna4Barm0m9q+jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iD6qfBigbnHp2TbJamlOS3nVy6AGmXgIpzkEHqONZQj0XpjU6DA8NRRqY3bjrr3gq
	 nQ+kjXi84LIUk8+JGth6xlbnpTmjP6mK+8uJYZ/i6WVI/jJ0iJiw1oxRd/BcGKAMwK
	 v1npwUOmH7okvODEcxBkiZoktNOBMD77518njWZNEaYAlIieKscoVm0u8Gc0oiMl79
	 EXf5eKyKRUU2HAWSrjX/4poiWfjP02dDYcTQOSBr46b7RedtLA0VYMVZLDMP9EMDFu
	 3rlnI6djhdXaiL60YKmzix7SE1S0jHku8+7deZNVquE91FFGtfxaK/crYFU2Em+f1a
	 HlQs3zd9NQCfA==
Date: Mon, 12 May 2025 11:57:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com
Subject: Re: [PATCH net 2/2] net: libwx: Fix firmware interaction failure
Message-ID: <20250512105712.GW3339421@horms.kernel.org>
References: <20250509100003.22361-1-jiawenwu@trustnetic.com>
 <F2122F5E9DA92C07+20250509100003.22361-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2122F5E9DA92C07+20250509100003.22361-3-jiawenwu@trustnetic.com>

On Fri, May 09, 2025 at 06:00:03PM +0800, Jiawen Wu wrote:
> There are two issues that need to be fixed on the new SW-FW interaction.
> 
> The timeout waiting for the firmware to return is too short. So that
> some mailbox commands cannot be completed. Use the 'timeout' parameter
> instead of fixed timeout value for flexible configuration.
> 
> Missing the error return if there is an unknown command. It causes the
> driver to mistakenly believe that the interaction is complete. This
> problem occurs when new driver is paired with old firmware, which does
> not support the new mailbox commands.

Hi Jiawen Wu,

Please split this patch so that each issue is fixed in a separate patch:
the rule of thumb is one patch per fix.

> 
> Fixes: 2e5af6b2ae85 ("net: txgbe: Add basic support for new AML devices")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_hw.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> index 3c3aa5f4ebbf..de06467898de 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> @@ -435,7 +435,7 @@ static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
>  	wr32m(wx, WX_SW2FW_MBOX_CMD, WX_SW2FW_MBOX_CMD_VLD, WX_SW2FW_MBOX_CMD_VLD);
>  
>  	/* polling reply from FW */
> -	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 1000, 50000,
> +	err = read_poll_timeout(wx_poll_fw_reply, reply, reply, 2000, timeout * 1000,
>  				true, wx, buffer, send_cmd);

nit: Please line-wrap so that lines remain no wider than 80 columns.

>  	if (err) {
>  		wx_err(wx, "Polling from FW messages timeout, cmd: 0x%x, index: %d\n",
> @@ -443,6 +443,12 @@ static int wx_host_interface_command_r(struct wx *wx, u32 *buffer,
>  		goto rel_out;
>  	}
>  
> +	if (hdr->cmd_or_resp.ret_status == 0x80) {
> +		wx_err(wx, "Unknown FW command: 0x%x\n", send_cmd);
> +		err = -EINVAL;
> +		goto rel_out;
> +	}
> +
>  	/* expect no reply from FW then return */
>  	if (!return_data)
>  		goto rel_out;

-- 
pw-bot: changes-requested

