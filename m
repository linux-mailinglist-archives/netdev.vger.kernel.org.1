Return-Path: <netdev+bounces-164483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A8A2DEBC
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98FCA1881DA9
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806921D5AC3;
	Sun,  9 Feb 2025 15:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0C8F5B
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739114046; cv=none; b=kbuPu7Vh9YtiL+J12RiKwp5iloGxQAmNLvtCyf+0OyffWuO8ejRy5/Q/OPathlosB5UHURJXstRQhqWZEQMxHKAlMTUXNnhdHj+bCTgOBE9Fjsu1DGoBXQloWr/x3pu1lBOyzES0mZWiNo/oWHx+8pcOBWhiqhefoR7hTpWmBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739114046; c=relaxed/simple;
	bh=SUraR9TX5Ck5LJByjn8DKhqVFfe5+VqklwClUvJvtRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdRJIf5VHkjsPgBsXdHzGzYQXSjC+CMDPmUcA73IvUCVHIGYin5eT9pJ2HvRhzCxhsmcWL0YKUfU1guSzNE1KdW6igl6CBfhvAnHAMHB/xloiQWAuejs0BR+pMg8zsjAtIoDy64VMJKEZN8tSkcJrVZaQ8fPsDmKooRVa2x8Ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1th90N-000000007Vv-3jUR;
	Sun, 09 Feb 2025 15:13:55 +0000
Date: Sun, 9 Feb 2025 15:13:51 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
Message-ID: <Z6jGL9oUs5DElOEg@makrotopia.org>
References: <96223803-95a8-4879-8a26-bc13b66a6e6b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96223803-95a8-4879-8a26-bc13b66a6e6b@birger-koblitz.de>

On Sun, Feb 09, 2025 at 12:01:55PM +0100, Birger Koblitz wrote:
> The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
> 2500Base-X. However, in their EEPROM they incorrectly specify:
> Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
> BR, Nominal         : 2500MBd
> 
> Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
> Run-tested on BananaPi R3.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>

> ---
>  drivers/net/phy/sfp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 7dbcbf0a4ee2..9369f5297769 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -515,6 +515,8 @@ static const struct sfp_quirk sfp_quirks[] = {
>   	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
>  	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
> +	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
> +	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
>  	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
>  	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
>  	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
> -- 
> 2.39.5

