Return-Path: <netdev+bounces-169887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D541FA46422
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAF3188BEE0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918422257D;
	Wed, 26 Feb 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="IW05DA0T"
X-Original-To: netdev@vger.kernel.org
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90322222C9;
	Wed, 26 Feb 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582518; cv=none; b=makh8imfjP4K9eNKDBwMoNKLzjlRUrQqXM5r3WoRjBUdqboSArYYEyLCyKhT/sHHBk7emgQJ/hf5ismXz2oD8UniH7WzTXi7epvGr87aHsIESZz/S+rlCEvKdTl2phBuXGdUPBr4VQAQ7Qj+Vc7ExgkZ9pCNZ3xRFJ4XV57vuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582518; c=relaxed/simple;
	bh=XC4CoAOtpcdCWitRC86lJSVmMf2M60ZyiNsaJQyjcPo=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=toten300iA5bEV1jN5ghDrukOM0sM/7cJB1F3p7bFlmnbVkpLZ/QxzUlXkmaq+G0WngOb3M2p07I8jk0ICufm+2lgdp3KtRNzipe1cdBiNdzvhZwPikL8ZfKuCysE7tn2vWHiqfC6VgHGJnBN4d8QDsuLnqMThJQr6WGpcRGZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=IW05DA0T; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=916645903c=ms@dev.tdt.de>)
	id 1tnIkK-00EV0r-Iw; Wed, 26 Feb 2025 15:50:48 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1tnIkJ-00Bs3D-J1; Wed, 26 Feb 2025 15:50:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1740581447;
	bh=wbgWqnP45V/0QnMauvuVxU6kL8PYNnce0PZGrp8aK2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IW05DA0TCwK2pOqmT8Zl9htARI7UYWNstHfUtGZ0P3fQzrOHEJcr0YEWl2cOjtvu/
	 d5xQzvB5FFr6Pt3akRWlHcGrT5yQg8uaxuLfJdCPOcL+yymyVNXfcPS1UksXFTN+YT
	 Pw1PazMh8lR4qu9m8fxS2xMDUDOqkCd7TBEZtPua0Vflj3g0D4iuYdygEDip3FtA6M
	 diEe/wNSo5GZuzvYncH2yWtLffBdSuv5tkGq0rjlCyT7KsdQrnDcRqYHXkwq5WUh8H
	 kdF6eeKSvxhYfm0EKeciqg7mMqBVraHbNGYXFuhYm4+xCtxiRO8+DIuyKAUJFkwj38
	 eqKNpPHB7X/XQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2319C240041;
	Wed, 26 Feb 2025 15:50:47 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 1C874240036;
	Wed, 26 Feb 2025 15:50:47 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id A2F4F238E5;
	Wed, 26 Feb 2025 15:50:46 +0100 (CET)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Feb 2025 15:50:46 +0100
From: Martin Schiller <ms@dev.tdt.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sfp: add quirk for FS SFP-10GM-T copper
 SFP+ module
Organization: TDT AG
In-Reply-To: <Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
References: <20250226141002.1214000-1-ms@dev.tdt.de>
 <Z78neFoGNPC0PYjt@shell.armlinux.org.uk>
Message-ID: <d03103b9cab4a1d2d779b3044f340c6d@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1740581448-096E7976-E8DE8542/0/0
X-purgate: clean
X-purgate-type: clean

On 2025-02-26 15:38, Russell King (Oracle) wrote:
> On Wed, Feb 26, 2025 at 03:10:02PM +0100, Martin Schiller wrote:
>> Add quirk for a copper SFP that identifies itself as "FS" 
>> "SFP-10GM-T".
>> It uses RollBall protocol to talk to the PHY and needs 4 sec wait 
>> before
>> probing the PHY.
>> 
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> ---
>>  drivers/net/phy/sfp.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
>> index 9369f5297769..15284be4c38c 100644
>> --- a/drivers/net/phy/sfp.c
>> +++ b/drivers/net/phy/sfp.c
>> @@ -479,9 +479,10 @@ static const struct sfp_quirk sfp_quirks[] = {
>>  	// PHY.
>>  	SFP_QUIRK_F("FS", "SFP-10G-T", sfp_fixup_fs_10gt),
>> 
>> -	// Fiberstore SFP-2.5G-T uses Rollball protocol to talk to the PHY 
>> and
>> -	// needs 4 sec wait before probing the PHY.
>> +	// Fiberstore SFP-2.5G-T and SFP-10GM-T uses Rollball protocol to 
>> talk
>> +	// to the PHY and needs 4 sec wait before probing the PHY.
>>  	SFP_QUIRK_F("FS", "SFP-2.5G-T", sfp_fixup_fs_2_5gt),
>> +	SFP_QUIRK_F("FS", "SFP-10GM-T", sfp_fixup_fs_2_5gt),
> 
> Which makes sfp_fixup_fs_2_5gt mis-named. Please rename.

OK, I'll rename it to sfp_fixup_rollball_wait.

