Return-Path: <netdev+bounces-248590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC15D0C245
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 21:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6631E3004F0C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179F2E6CC0;
	Fri,  9 Jan 2026 20:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="aGUUvou/";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="d1ZF9ih8"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A061B4F2C
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 20:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989424; cv=none; b=lxrqDDyzg7/jsUqwZboIaGT9tlKGYQwb+HNBDPhCTb9d8VFxou1G3IovglBBQBB9SsG2zepLgHquWE4BHgRDG6Xr4mNig8K6aSUA29t4pJb9jpSKUGR64+dPy9Bgy4XoK5R8kYULsgMdSf7y5jSaNzuEUMdYrOsbAq3IKDa2To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989424; c=relaxed/simple;
	bh=gUqw4oTauouFUKrLSatSb0LvIYRghad8VKuK5pYXTVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShD8IxMVAJzAhUVgOnUAQ9ETQ7bsooW2NC2Fxg5RbgXsBzwINgfVil/35zBnFizAbPetulRSfU/rURl0gZlRj/vhbflYQCyWCnjzcS4E1+WGDtSjDhfYgzqBeqYT70O1rwu1A/f/QdIdnErBo7zwaHWyKF4Y/RiHq6ggoJCiWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=aGUUvou/; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=d1ZF9ih8; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=aGUUvou/yEufDOlW9Y9UGbuF099UYclEFtdyel1rDPICvUnKYiiarNBsFJNaP6pjGwLmxCtBk38BWb+xo04B43PYoG4sLDVSM72bE3ECrGOhYM1dAfaxVUbTes1N7Mezx5N02KwzCOO6eVMWYRZub+k4h+kHQoREbTVKFzUPtzpTyWEcYUVvwq/t/6GMi9LqWEJytPnyk+FH51oVSKtyCra5z0zqxNHzzYFXZaeuk1vkOeycQym4xEURym43BDSbhT9L3P3+5QucEyUn5kQ2iVKL+RmVb1CYwQSaGoIj4A6Zb8j0flvzYAN3m8aP+HUX/vbKbTDggrvFhVIkM+E7Mw==; s=purelymail2; d=tinyisr.com; v=1; bh=gUqw4oTauouFUKrLSatSb0LvIYRghad8VKuK5pYXTVE=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=d1ZF9ih8cupmxMPC5Z8CpDJSCpM6mJQ+T9g+X6kY0nxRuCADBZojDDQRJkaqgH7iFmEwYSIuBcORelkbig18M3mgcBbh9PYFcVSuqQCincVU7g00G2QS6siChD1UVCbvTtOkdf4W+XCCwjheycOSZAxunKVdR7YxZ6ZE87ufJV2JOQ5DnDNrGc73DOfq70chcGkHBuoZ7dQguBeuN5u9E9SxraRaR8Dv57uelTY+chydXsp5cdj7diR4+bEZiof8zIV3QmHUKiX9lWO90Z6NFMvyTCKittts9eDWQmxB1RjM/YrIFf3/ocJrzeWCw3G/KwobNGJWFgJ0wSvr7lSeXA==; s=purelymail2; d=purelymail.com; v=1; bh=gUqw4oTauouFUKrLSatSb0LvIYRghad8VKuK5pYXTVE=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1270081648;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 09 Jan 2026 20:10:04 +0000 (UTC)
Date: Fri, 9 Jan 2026 22:09:49 +0200
From: Joris =?utf-8?B?VmFpxaF2aWxh?= <joey@tinyisr.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, nbd@nbd.name, 
	sean.wang@mediatek.com, lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH v2] net: ethernet: mtk_eth_soc: avoid writing to ESW
 registers on MT7628
Message-ID: <aWE9Nt0bmXpRCPAT@plutus>
References: <20260106052845.1945352-1-joey@tinyisr.com>
 <20260108150457.GI345651@kernel.org>
 <20260108083530.6169b627@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108083530.6169b627@kernel.org>

Hi Simon and Jakub, 
Thank you for the review.

> registering alternate phy ops for MT7628. This would push the conditional
> handling to probe rather than calback execution time. And I suspect it
> would lead to a cleaner implementation.

I wanted to keep the fix minimal and overlooked this as a potential
solution. This will make the next revision way easier to follow.

> Plus the commit message says: "Existing drivers never use the affected
> features, so this went unnoticed." which makes it sound like user will
> not notice the bad writes today?
> 
> So perhaps we can go for the cleaner approach and stick to net-next
> (without fixing the older kernels?). Sorry for not reading the commit
> message closely enough on v1.

Yes, current users should not be affected by the bug. I only ran into it
while kernel hacking. The fix is not necessary to add to older kernels.

Following your suggestions, v3 will target net-next and use separate phy
ops for clarity.

