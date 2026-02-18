Return-Path: <netdev+bounces-259205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nhDhAHtMlWmiOAIAu9opvQ
	(envelope-from <netdev+bounces-259205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:22:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B41531A5
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 06:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BED03026C0D
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 05:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA822DF6F6;
	Wed, 18 Feb 2026 05:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="Gu41qDqW";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="sMpz7Rjb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b="clwL5u56"
X-Original-To: netdev@vger.kernel.org
Received: from e240-1.smtp-out.eu-north-1.amazonses.com (e240-1.smtp-out.eu-north-1.amazonses.com [23.251.240.1])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598F26CE39;
	Wed, 18 Feb 2026 05:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771392116; cv=none; b=d4ozHWnQNfHLeax3OWEMU2ut0n6JcHmjB2mojINaq/vVznaImYTcTPfijtnEAg9wZQNlpFA3QC3Fc50Rm1TC3BchYVAxUehdzrDfxRH+XOtqwkK8irS6+j9YoQ0WGEERHHqBg46C3QfI0se2JIGrwh9IU3EK57iky49Mt8+LNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771392116; c=relaxed/simple;
	bh=7azgNXffK2Lqq7IefrVu7+0+2rJiOeHWv4y/o9pD2Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET6iiRJGBePaG1bqaCAzoCxNFv5wbEwoTJEa/GxmGT9DX+/Db3v0+rXry4UkmOcXdEYw952jlSFByqC8c6OKwVLw0GULIspFcmHadTUYosJA18RkAikE2ApON0m6sb+cKHR44f9swBI6gVIzbuGkjFfvmcv5z7Yxg2Bz4uUmJjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=Gu41qDqW; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=sMpz7Rjb; dkim=fail (0-bit key) header.d=poleshift.se header.i=@poleshift.se header.b=clwL5u56 reason="key not found in DNS"; arc=none smtp.client-ip=23.251.240.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=poleshift.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=n6aiayff3zq3manwyovyvpolm4pou2ef; d=poleshift.se; t=1771392110;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7azgNXffK2Lqq7IefrVu7+0+2rJiOeHWv4y/o9pD2Pk=;
	b=Gu41qDqWxyul5vU9nauP7yZiw6/3mvoFJNzAVhv5FRPdfPtAQV2NnUh2nx2VnzhL
	PfIrXJy8vydsj+BI7Ee84o9QeyXYmhDrIQy/DRL0sRZ+9LvYw0w75KNfZUSZYpBPrqE
	wD7rDc1f5jVlRznj2kqZXIZ0WrSibs7kYkDYXewyBODkrMu84Rh3GWkaP8IeJ5WDU+y
	lEZhCZwGmbO3dkQS65aC9mTAmAcxqZDiGpaSCpg37VVd3jlVII7SskSOMFe7I1q3nxe
	00S25L4epdZpCTTVeL0Exir3Q2CjLACNrLCBM49ztYJxDLS6fk0mzIiqbLY8JtBXwSy
	utTSM7+xtA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=icdr7g7fbtu2nwxgaimytihkt42k3kiy; d=amazonses.com; t=1771392110;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=7azgNXffK2Lqq7IefrVu7+0+2rJiOeHWv4y/o9pD2Pk=;
	b=sMpz7RjbjqKOx1YZpBh89OcDld+wGwyYdKB7dDQgwKbrRrjSVUZe/mh34ysT8GhZ
	jRgzaNpD9u33NwIPQuXx61Oj6jufYFR5VncWV7CTgnoe40ZbP0nKKdCEAM9XBeiYsdG
	BB1gjjVmaPkcecl6IB90ZofUs97u0BcItkBAG99M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poleshift.se;
	s=20230429; t=1771392108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fgLTBXGpjx+ncbUReD6njrkxhcK2IaVx6gNnSoMgmQ=;
	b=clwL5u56emVefyfgJ4JJvSBDq9paHSwdLsI250BR7HT5zgT1F30UUasVHHRT8M36QWaZAr
	7T8XevjqTAMUruDtAcw/n+cYi469WjS1QC7Iz2KQR+xa49XjBh60zpYauQngVj05zRyYi9
	lN+nZnHXvWkSE370tNdUC8bWBgMB3n4=
Message-ID: <0110019c6f328fff-fbfd5eff-d329-4707-a278-8ba8ef406f96-000000@eu-north-1.amazonses.com>
Date: Wed, 18 Feb 2026 05:21:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] net: usb: lan78xx: scan all MDIO addresses on LAN7801
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, 
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>, 
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <0110019c64da3c2a-d4a4adbe-c78b-4051-a95b-e7ed5db247a1-000000@eu-north-1.amazonses.com>
 <b598aad8-5151-47b2-949f-321b87baa638@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Martin_P=C3=A5lsson?= <martin@poleshift.se>
Organization: Poleshift AB
In-Reply-To: <b598aad8-5151-47b2-949f-321b87baa638@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-north-1.nVsitYrO9p3qnPLcZXP017jV0c/PN62ZbS4lYSSQpnA=:AmazonSES
X-SES-Outgoing: 2026.02.18-23.251.240.1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[poleshift.se,reject];
	R_DKIM_ALLOW(-0.20)[poleshift.se:s=n6aiayff3zq3manwyovyvpolm4pou2ef,amazonses.com:s=icdr7g7fbtu2nwxgaimytihkt42k3kiy];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-259205-lists,netdev=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[poleshift.se:s=20230429];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin@poleshift.se,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[poleshift.se:+,amazonses.com:+,poleshift.se:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazonses.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,poleshift.se:email,poleshift.se:dkim]
X-Rspamd-Queue-Id: 4B2B41531A5
X-Rspamd-Action: no action

Hi Maxime,

Thanks for pointing that out. Ran a quick test with the assignment 
removed and the module behaves as desired. A third version of the patch 
coming in a few moments.

Best regards

Martin

On 2/16/26 11:34 AM, Maxime Chevallier wrote:
> Hi Martin,
>
> On 16/02/2026 06:09, Martin Pålsson wrote:
>> The LAN7801 is designed exclusively for external PHYs (unlike the
>> LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
>> restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
>> ~(0xFF). This prevents discovery of external PHYs wired to addresses
>> outside that range.
>>
>> One such case is the DP83TC814 100BASE-T1 PHY, which is typically
>> configured at MDIO address 10 via PHYAD bootstrap pins and goes
>> undetected with the current mask.
>>
>> Set phy_mask to 0 for the LAN7801 so that all 32 MDIO addresses are
>> scanned during bus registration, allowing any external PHY to be
>> discovered regardless of its address.
>>
>> Fixes: 02dc1f3d613d ("lan78xx: add LAN7801 MAC only support")
>>
>> Signed-off-by: Martin Pålsson <martin@poleshift.se>
>> ---
>> Changes in v2:
>> - Added Fixes: tag
>> - Link to v1: https://lore.kernel.org/r/20260214-lan78xx-phy-mask-fix-v1-1-3baa100861e4@poleshift.se
>> ---
>>   drivers/net/usb/lan78xx.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
>> index 00397a807393..9d8f1ff7028d 100644
>> --- a/drivers/net/usb/lan78xx.c
>> +++ b/drivers/net/usb/lan78xx.c
>> @@ -2094,8 +2094,8 @@ static int lan78xx_mdio_init(struct lan78xx_net *dev)
>>   		dev->mdiobus->phy_mask = ~(1 << 1);
>>   		break;
>>   	case ID_REV_CHIP_ID_7801_:
>> -		/* scan thru PHYAD[2..0] */
>> -		dev->mdiobus->phy_mask = ~(0xFF);
>> +		/* scan all 32 MDIO addresses for external PHYs */
>> +		dev->mdiobus->phy_mask = 0;
> As this is the default behaviour for mdio bus controllers, and the
> default value for the mask is 0, I think you can simply discard that
> assignment.
>
> I don't even think we need a comment, as the other cases for 7800/7850
> already have a comment explaining why they are special cases.
>
> Maxime
>
-- 
Best regards / Bästa hälsningar / Mit freundlichen Grüßen

Martin Pålsson
Poleshift AB - Local Automotive Ethernet Solutions
+46 706 26 49 90
martin@poleshift.se


