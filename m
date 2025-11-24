Return-Path: <netdev+bounces-241209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986CC818EE
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87621346953
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604C3168FA;
	Mon, 24 Nov 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WSfYZC2o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413443161AF
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001757; cv=none; b=C2hgy77gLBbPWVvIKgSJEiDTIeRhUEqgoVYzzc8UKz5LI/COvV9cL9sAvIxvPq+9vgad3ybKEDBG9iXJOzdfrPKT7zkh5yRQIVe9zumSBFCRjKR9DNpZIZqhdwOST3TRFOJee1i8qbqz6HLD7pTQtq3I3Z9r4itFWQRWVITXoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001757; c=relaxed/simple;
	bh=Jw4sZlwfvlCw9U70oFYHFDt2JUDMKantZkYZjOZFw6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BoD+GRSqLQetADwhACEVC7gW3cBVdF7QtZglynI98JSabHAXIjtw6uc4/dU27dsDC4TlZ7Te0g017FY7oNWwk8+wIUAX5dVe5NmSQYr1/7InZa4kBpAOfcSEJt37cRJy2pe+AOZbow3pex/TVULNE1rOGymGkrdlwf/ctL2TzGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WSfYZC2o; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso21236a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001753; x=1764606553; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=WSfYZC2o9IYtrkP5kLVbiTx8FFhr5GAP8/74SplmWS+FAaNAZrIEm2ePw77E6FZN/l
         jjMfG7UhuXMuep5mzJSFmxQZc+xdHV3dXEYvKReCV0mBk18kH/3iEq4NhcAJt1KmzW8A
         WuvblIHyqxYPmR1xxEWnJ83517XTda8WiJ58WUmuKnqwc2ZXJtiNQkl/nj89hABEs6iN
         mPe9qP2FiM36Vi/EicA9CYmNGicmTYOd/G1gcZrIyFDTFosrsDzEBQL2/OQ/N+dTZ/B2
         fA7KmwUE4hUdvL7khfrZlXhEn4paqq2B8/VFTXxG02Y20YIAdEhgwieqX4Cz10qns0RA
         P6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001753; x=1764606553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT0a9okVqQVqG4JPUviJUmT9EW1WnhugEMsAcr4nqg8=;
        b=n5bq8icE2SKcB9GqXHqkINUq8ic7+V79Mha/TBHP5xx5p4Xd2zMRODMY/HrKBCmFv6
         jzEX6tqMu4lZnWyChWNXFHKS/2HAA9bLRsjgtevhcLVVjKmo2nDvVqLBhBHFBoQJwfCT
         0rrs0++K/WIwDyeAkNCuuBD28AURuyk4ayVlPOGWHzcxnTiSKPf0eprKE/kGBnIsKDUs
         kuWT4KbOb5ww8RdMFg6GjMUWX8+pIFjFsPyr1ulJbCii6GJt/w0RooQeaThmfKPIx0zw
         AkouexRXcWepnhKn3NAAlP9ZX6diR9WgU2diz+qBD1aeqKlyvXPjzin+qr7Mfj8ag3LB
         hMUQ==
X-Gm-Message-State: AOJu0YyQYaUcz/xpIaQu1cvkTs41GSIlFavKG44ROOQ8Q2uaIVVwzQNY
	ci7jbbH9RrN0jK5jUyTy83aYmjZWMG62Tw0guo3SppEeiJjaogtX8HRfwTz9ozi0KBA=
X-Gm-Gg: ASbGncucdI+2oZ0w5d+VhInj+tgzPUx4vaJD7sYEXS0BqjYe7Lend4ODWLUCAmgi0Td
	5JLVM4iLRHZLhAFoO8aiwKYwFqSF4UexCiz6rO7hg+Rn1PnjePuPVzavTAgH+Hen3tvb8CB1pWd
	4YBTYAS/fxO4eQVC88l5k5mEmYhWbIJeZf1AajVfvpSWomautO4pLGuS/pw1xwLrEuqsu+OjJUK
	ZXJdRd9zrEGPR+o3SP9W81QS7TqvjwDmJBswTZg6EDxkvcwyqvWb/R9BQrIaEfQREgxjucB3cMC
	XH9XLrvl5fv1MaKo2f8XZ+ENLP2GUEgT2qXbaUq213t0sE/C7a/Xkx4j5aRgCj70k61VTMInBGu
	I1HLyJm44J+vKmxwSbyhlx2oKIKg0R+8aWPcP60gMo79ucQHRC4JxxBn0mXNloeE/E2aKt/bZqY
	oyOGb2KNEt56vFLKfPuLLhfXG0mC1Yk5AIGf/c+V++QVLV/T91yN5sNdNK
X-Google-Smtp-Source: AGHT+IEEmnCNnt5w49ydTTn6t2HeNn4PxEGho4FAfkYth0YmUOYGocOk/Ic7gQ4x6EifblEC6MIjWw==
X-Received: by 2002:a17:906:7314:b0:b72:b433:1bb2 with SMTP id a640c23a62f3a-b76715434bfmr1302008766b.7.1764001753420;
        Mon, 24 Nov 2025 08:29:13 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765f840a30sm1173487066b.58.2025.11.24.08.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:13 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:39 +0100
Subject: [PATCH RFC bpf-next 03/15] igb: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-3-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
already points past the metadata area.

Adjust the driver to pull from skb->data before calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/ethernet/intel/igb/igb_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index 30ce5fbb5b77..9202da66e32c 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -284,8 +284,8 @@ static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
 	       ALIGN(totalsize, sizeof(long)));
 
 	if (metasize) {
-		skb_metadata_set(skb, metasize);
 		__skb_pull(skb, metasize);
+		skb_metadata_set(skb, metasize);
 	}
 
 	return skb;

-- 
2.43.0


