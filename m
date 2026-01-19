Return-Path: <netdev+bounces-251047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B63BD3A670
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 12:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 042F7307E2D7
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2493590B2;
	Mon, 19 Jan 2026 11:07:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA83590BF
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820838; cv=none; b=rtFUP+f3XwirOiXO4VwAtiCOvSxLE1dL7dzUURsx8VJ6/Puh/gR3sI4g/r9PDJ1ZS3qRZLp2OBHNeA03m6BKLPXbjWnowk1EMnHKJu18aDBAABovrOuXuU0LuxNgixWsx1w9HC4vGBAj0ikBSEcqMTWqgrtt3XQATwuOBIMGUmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820838; c=relaxed/simple;
	bh=JxpIY4EchlNe2VL+m6J7zI5ZdKqmiwL1UI5pv3EsdLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVjT1++GV3MpxU36zye+lvAgczf+7tbb2wZaHCVXMPqrkHzXpQyI6z3EWXTDSbG4A1nRtFtfme71AJxh+lygisvWnE25P2ytS26X15xEOPSdHqnOlXR04E2cRjeuw4OC2gZ8kAwMEUYpKIXMFUDSbfRrdI3B+xjuh7xWfDUFG/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-65f66d72b3fso2924603eaf.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 03:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820835; x=1769425635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS2moVsLFS8R82B6LKNK6mphxLmcNhEidNAZl37HgzY=;
        b=G0P7skySEQCE0sSBRU071Y+oHiV6EmnjDIiGaHC0U9GNhjhKsm63gn35pzkfylAmjI
         KDRd/wsSpxbSJHzni5Vr5GPZVsswVbth6tL4+cJnyvi7zuKZxrVIo6vQLK6p2pkKs7WT
         MfUBN986tgbmU6s/7lGA0xvt3BLnsm8dsXswhBjOmsPh7LtTt0wTAWr+nCIg7Pdv8Vgl
         D28ODZ9xX7sDUDUYCjKmPScQ9vokxEZIbUY0+h+cN0S9kqfHbI9AKaBw4aakQf4pPyTc
         B/Aw9m7cDhROJyUARODliwZh6+kpjzMPCMociV46vIRig856kekzCGxn0Od5RQRh0ymP
         KDyw==
X-Forwarded-Encrypted: i=1; AJvYcCW7n6U6Jyvi37i4bqbrnmOCLWqYRnP1r1di2vhXvAiV1+ZtDDTJCxHzSzNOsMQ9iMpazwElbYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdiDJ8cbqKEaqDlc1JQdjAo7WwMO4RF1GY2LqzJUY2GuM1MzJC
	JepzNPsl7dSVFGY6et3/LUybmrRshp+Gs54a2SPxV63kxWWkErr67ekl
X-Gm-Gg: AY/fxX6Mu3zDQVK4RaLtsbo/eewqnndYZ6CVjw++Jx59rZRPZxRfYohq1cgW6ZT8Oco
	bs6OZWy+sVxZsNvPInNQnDXCgNcVjQZYWN0kHOsjjMZTejxyoyqinrPzWwU6fjtWjJ0Ii+db236
	okb3TE6G9p6coVa5vQ58LcLEqisQLxdhgHycdVphYQxcJFFWKmA5ChUZxi94eQlh3S38g8R+9yb
	pQHKr17rYusTOZv7Ur4RnAw49cyACKhCJm7Ko7DHyhjWUo7/7/xoiJxa0UbWOp7X54oegzUVGyq
	HVR8EYmBffJ96OhR7V8MyWkkvHA82z/kV+8mIordd6tEIjyc9xDJauuUhsynJ95y/aKwSVjZwY0
	cm9W6ioW+BBTOQjmMKiCSahQCn4jjxdpGyK13p1ZAG2jBmaa4rza045ErnMU+F/TCGMsOuVJQcI
	ZBlAVUwMZrTPcM
X-Received: by 2002:a05:6820:448b:b0:65f:54b1:a9af with SMTP id 006d021491bc7-661179b6b61mr3226026eaf.42.1768820835533;
        Mon, 19 Jan 2026 03:07:15 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bda443asm6804809fac.22.2026.01.19.03.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:07:14 -0800 (PST)
Date: Mon, 19 Jan 2026 03:07:12 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Bryan Whitehead <bryan.whitehead@microchip.com>, 
	UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Raju Rangoju <Raju.Rangoju@amd.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 1/9] net: benet: convert to use
 .get_rx_ring_count
Message-ID: <ziyd3327jr7miqgv2e252w4wpizphomkvxxge6nbjwtg4pyvf4@gvwwi2r7rykl>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
 <20260115-grxring_big_v2-v1-1-b3e1b58bced5@debian.org>
 <20260117181551.0b139ca1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117181551.0b139ca1@kernel.org>

Hello Jakub,

On Sat, Jan 17, 2026 at 06:15:51PM -0800, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 06:37:48 -0800 Breno Leitao wrote:
> > -static int be_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
> > -			u32 *rule_locs)
> > -{
> > -	struct be_adapter *adapter = netdev_priv(netdev);
> > -
> > -	if (!be_multi_rxq(adapter)) {
> > -		dev_info(&adapter->pdev->dev,
> > -			 "ethtool::get_rxnfc: RX flow hashing is disabled\n");
> > -		return -EINVAL;
> > -	}
> 
> I think we need to add this check to set_rxfh now. The error coming
> from get_rxnfc/GRXRINGS effectively shielded the driver from set_rxfh
> calls ever happening when there's only 1 ring. Now they will happen.

You are absolutely correct. The ethtool core calls
get_rxnfc(ETHTOOL_GRXRINGS) _before_ allowing RSS configuration via
set_rxfh, and if it fails, ethtool_set_rxfh() will fail as well. And
with the current change, ethtool_set_rxfh() will not fail if the adapter
is not multi-queue.

Thanks for the heads-up. I will send a v2 shortly.
--breno

