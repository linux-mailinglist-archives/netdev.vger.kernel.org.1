Return-Path: <netdev+bounces-241213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93394C81901
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26FE14E715B
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7673191D4;
	Mon, 24 Nov 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LK1QSQZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7B3168EE
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001762; cv=none; b=I/OFKA1FlJ98rSgQ8EaUEQvx6xzlbqoSi6YXCPAC8veDIpdKvAsncxLr6RJhfjW6Ox99XVBsC9p8G03UxZc6CyUqJUNuHtz6N+Efta/A0FcZiVdkHbYZwKOJAwuWHpI+fpkyDpl0LOLPPU5qXUNNsegORdUQhOgMe+7sdNRUCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001762; c=relaxed/simple;
	bh=2TstOQGZI+t6IG/RQmJzivYCP7vC9451vLQeJGKYZwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMz/tQoDaHVhbC2BxlzxVwfoTnH7XOGC+CYD6t8Fsn8HtAVNHN7J7HWgReoklz8iOeNXwajnx909L34yqwRotxo+oCa6o0At9MmQ5MFLfQgVL6KDnDeq1EoPPWceRmxfSYjnvE6DyS17DXPawKdgJEGCACJCQjTFzGdxh/Y0B5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LK1QSQZt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-644fcafdce9so6910248a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001759; x=1764606559; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7GGD3nxk2ZeIfkq5u+0+t/ac19i5zLpF7Qwyc+ASyo=;
        b=LK1QSQZtW+P8Pf5A9uaQxt34qCmx52sD6/7TG39U3ZcpEKmwdQqZR83shIwV5JllIO
         FifLc6///smgSEERkEqWNOg0eqqEwhijZ2mGU7he6/+TC4dViClZ4G6Hh9BnUpzJLz8F
         qOsMNxk9gpnUD3IS667hH9Dt2xAfLO35MbsZxHaMifAVLA8xV3m/zE3iygpXQZhwKgny
         Anwk9/WoPO9wAvvKVauvEzFhkm/msYjGT86s+Rwz+Ujk9cFpdmuMZqV9GukntW35GJdM
         uWJ1Whm0dQx3+/jAbjJ/z4uc7EmFZ+7/Ix93MVz1xuPenUZeIduh4ddtgorRVHAdqUag
         UNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001759; x=1764606559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P7GGD3nxk2ZeIfkq5u+0+t/ac19i5zLpF7Qwyc+ASyo=;
        b=Pp5bCHdLvKybZMSvz3znhlyOVboV5lW5bhDtS1VIQYnnSBFru4AimYfRg25LBCKTiN
         dGuF974J+rInr6xwyKaRL/KFOo2VVHf8z/gSmd6fGTlP4L6VPJvDb7AmFdbyEqQBnJEO
         Nq9mluGADcGvkIzkZDcQIvWlri0Jrc5sT0fJiiighEZ90grZSkx/GQU0+QwOkOblnd3K
         oi53/JtsG6WNlKj1WoEmHEqElayOeEUd5txPktYGQ4ekSgt9SWTU3DPp6SU0QA1UTyRb
         TVW/sISBOxhz7yahMH4vDLCqwxsmAyyBFv970Hj8HSdSa+pCN+/3dK9WCRj1fgqQVVWr
         7N8g==
X-Gm-Message-State: AOJu0Yy1OUlZrBt0JkdOcWj3+IIYrBTK8vifJdow1AyAPK/URRlasbVm
	pR85LfhuFPAPcWoInu/B/j2eWLFt0f7H3ElTKmrvNCChydIVbT/X8lQnANx5jBwfg34=
X-Gm-Gg: ASbGncvGqqC65sE2pDOa8wUvupyMpo3xtR87NpsoK8tuI35Yu1ilUfFJF60oM/Hg5aJ
	8mN+3UQVbuRiGaul6Jhqy2GFaVfwivNeroVxhhlku6v0S5O65qDvTqvvQgPPQjDHCqyRzaErYS8
	OUWg0Oi9NcklzOqh1O2IMLdstXBPG+PHfoD4XEac2c/4Ta2CffXkH9t3t01PF8bwuNCIHI1iFdd
	eD03yWwlbGbI28CrazbBvqceYwkhuTEh6lwkuEm7Q+ar897QB7HtEEYSp41A4JOwo9XRDjiBlWc
	mG1ZElvMM1rQ5Czh7nW0tD4QVjwP9jaQMVhCs+Gt6VKj17+COcRyIGoYsD5v1TaNGWnnMKZFjMf
	l1lY/+MPTsOLanCBS/CBEWO60It4BThbla0CqR2v8Zfw67oKsIfE6OLhj4NZNOHTJrVZSB5cPpi
	SoLvkna2SRRg1LzsWz+CvVCRzZ8QkmJgjTaykmLB8pG5FTwx7MOnYrmL4e
X-Google-Smtp-Source: AGHT+IFNU9Sjiy8GyWZ31945ZZveM/PNlMy7b/lYkNZj5BB1SrOutmeZUgFN9nNnopRohbgsWGoPUw==
X-Received: by 2002:a05:6402:50d4:b0:640:9b62:a8bb with SMTP id 4fb4d7f45d1cf-64554677ab5mr10593555a12.22.1764001758617;
        Mon, 24 Nov 2025 08:29:18 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5e97sm12524775a12.9.2025.11.24.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:18 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:43 +0100
Subject: [PATCH RFC bpf-next 07/15] veth: Call skb_metadata_set when
 skb->data points at metadata end
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-7-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Prepare to track skb metadata location independently of MAC header offset.

Following changes will make skb_metadata_set() record where metadata ends
relative to skb->head. Hence the helper must be called when skb->data
points right past the metadata area.

Unlike other drivers, veth calls skb_metadata_set() after eth_type_trans(),
which pulls the Ethernet header and moves skb->data. This violates the
future calling convention.

Adjust the driver to pull the MAC header after calling skb_metadata_set().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 87a63c4bee77..61f218d83f80 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -876,11 +876,11 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	else
 		skb->data_len = 0;
 
-	skb->protocol = eth_type_trans(skb, rq->dev);
-
 	metalen = xdp->data - xdp->data_meta;
 	if (metalen)
 		skb_metadata_set(skb, metalen);
+
+	skb->protocol = eth_type_trans(skb, rq->dev);
 out:
 	return skb;
 drop:

-- 
2.43.0


