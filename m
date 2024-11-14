Return-Path: <netdev+bounces-144915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B419C8C63
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2417286FCD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F226208AD;
	Thu, 14 Nov 2024 14:03:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09614287;
	Thu, 14 Nov 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593027; cv=none; b=t2k1pEUvYVc/XF+zZvqJEZfaOOQ2yyQ65ZBxOXaL0yiKNzDS/DMjOFmIa42GX3S32mCj8/RhmlXE307jC0a805cXzxaX4zyvgLTxDn2H7og4VJUmCq2/MqBMvJvOL7lmTEkT73QL/ucO9EcRoFvkaQKlYbOYjleV7B21qlqDYzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593027; c=relaxed/simple;
	bh=QdA+IH/Qn1gAdF0du8p1YO33j9VfU07Z68IwDPdTkuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6ISyzXXnbSw4+lj4kaVUTxPEqWSpJLX5j4ZFMVlkfxhXg8wLaARaj+eD8fPTLPdpZAXehevcg99k8vy95nE0phKKQMmDLdLV+Ht0oSeNhq4Dr7fiTfYd0lVSXNd5E703N95riaIqqV9boy3oW6P2a7h3L8Xh68AVv96m2gMscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.29.1.246] (unknown [141.14.52.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7162661E5FE05;
	Thu, 14 Nov 2024 15:02:50 +0100 (CET)
Message-ID: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
Date: Thu, 14 Nov 2024 15:02:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/1] ixgbe: Correct BASE-BX10 compliance
 code
To: Tore Amundsen <tore@amundsen.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 Ernesto Castellotti <ernesto@castellotti.net>
References: <20241109232557.189035-1-tore@amundsen.org>
 <20241109232557.189035-2-tore@amundsen.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241109232557.189035-2-tore@amundsen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +Ernesto]

Dear Tore,


Thank you for your patch.

Am 10.11.24 um 00:25 schrieb Tore Amundsen:
> SFF-8472 (section 5.4 Transceiver Compliance Codes) defines bit 6 as
> BASE-BX10. Bit 6 means a value of 0x40 (decimal 64).
> 
> The current value in the source code is 0x64, which appears to be a
> mix-up of hex and decimal values. A value of 0x64 (binary 01100100)
> incorrectly sets bit 2 (1000BASE-CX) and bit 5 (100BASE-FX) as well.
> 
> Signed-off-by: Tore Amundsen <tore@amundsen.org>

Could you add a Fixes: tag?

Fixes: 1b43e0d20f2d (ixgbe: Add 1000BASE-BX support)

> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> index 14aa2ca51f70..81179c60af4e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
> @@ -40,7 +40,7 @@
>   #define IXGBE_SFF_1GBASESX_CAPABLE		0x1
>   #define IXGBE_SFF_1GBASELX_CAPABLE		0x2
>   #define IXGBE_SFF_1GBASET_CAPABLE		0x8
> -#define IXGBE_SFF_BASEBX10_CAPABLE		0x64
> +#define IXGBE_SFF_BASEBX10_CAPABLE		0x40
>   #define IXGBE_SFF_10GBASESR_CAPABLE		0x10
>   #define IXGBE_SFF_10GBASELR_CAPABLE		0x20
>   #define IXGBE_SFF_SOFT_RS_SELECT_MASK		0x8

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

