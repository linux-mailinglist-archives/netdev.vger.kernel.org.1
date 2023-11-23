Return-Path: <netdev+bounces-50565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456F7F6218
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E328C281D6F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D566624B5B;
	Thu, 23 Nov 2023 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgV/xjR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921D168C6
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 14:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D04C433C7;
	Thu, 23 Nov 2023 14:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700751252;
	bh=YK0LUD04cuvQoOBrtXXrTqH2YJwsfl7f009IH441lm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgV/xjR4YVg59DCbosScV2ONIgS8vO/767G74QbkOpW8PwIkVNMWCLu8XSicrDpGG
	 3QKLJi+xO3ZAGIS6X3G7aoSYWgRAYHdOHxwBBNIlNOcgWvrJ4JJ/1kOZwjMw5DhScL
	 a1QILHXBMJMwmG87+oVFn+cvw2jjNRi7tumqPsTbuIpyZD98uUZ8OJogwgtau4eBpd
	 5UoHc90KTZhxk6tSKVWbPuFa3G31mzmgCMVOoEa+ke9ahkAsRV2VS7nl8cigUO3N8N
	 xp4ks7WZMDmzQDwd7Znt36BAUw1Jg87kn4u+mMLM01QdD5hXrHzvzuNNvah5+obwiD
	 BDq5zD22YBKug==
Date: Thu, 23 Nov 2023 14:54:07 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove not needed check in
 rtl_fw_write_firmware
Message-ID: <20231123145407.GK6339@kernel.org>
References: <52f09685-47ba-4cfe-8933-bf641c3d1b1d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f09685-47ba-4cfe-8933-bf641c3d1b1d@gmail.com>

On Thu, Nov 23, 2023 at 10:53:26AM +0100, Heiner Kallweit wrote:
> This check can never be true for a firmware file with a correct format.
> Existing checks in rtl_fw_data_ok() are sufficient, no problems with
> invalid firmware files are known.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_firmware.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_firmware.c b/drivers/net/ethernet/realtek/r8169_firmware.c
> index cbc6b846d..ed6e721b1 100644
> --- a/drivers/net/ethernet/realtek/r8169_firmware.c
> +++ b/drivers/net/ethernet/realtek/r8169_firmware.c
> @@ -151,9 +151,6 @@ void rtl_fw_write_firmware(struct rtl8169_private *tp, struct rtl_fw *rtl_fw)
>  		u32 regno = (action & 0x0fff0000) >> 16;
>  		enum rtl_fw_opcode opcode = action >> 28;
>  
> -		if (!action)
> -			break;
> -

Hi Heiner,

I could well be wrong, but this does seem to guard against the following case:

1. data = 0
2. regno = 0
3. opcode = 0 (PHY_READ)

Which does not seem to be checked in rtl_fw_data_ok().

It's unclear to me if there is any value in this guard.

>  		switch (opcode) {
>  		case PHY_READ:
>  			predata = fw_read(tp, regno);
> -- 
> 2.43.0
> 

