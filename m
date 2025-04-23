Return-Path: <netdev+bounces-185106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30456A988AC
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FB75A397E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FEF26C3B0;
	Wed, 23 Apr 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFRKD46K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE5FC08;
	Wed, 23 Apr 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408249; cv=none; b=nYjFosT4XeANYXU71+rAAjS6GtA5JPvJ2GL1F5F1yE2w7ek/OiMbYagICl/gLlqCzLv8YvKJ7rgoJ4QmX+bjfZ66tuuqgvtQeUYj2dkGgoNiFJj4kRzLpLIddus6zqsiwmg/LgEXhbFmZaFjfylJe/Lxd8g41bG+wNrcD4UPhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408249; c=relaxed/simple;
	bh=ZOYMbzEXP8RLe+8yWrKjk75zGEZAVkvv3WQseXJv0cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YUIAh0xzBT0Ib9VYPo0XyJgDp3sAIGckBla2XNkuGgoMIuCpSd/eK3rMbfAHajRw3AtNKsmUp9wTQz/HdP4T8nu0Lv9wqcIIUk/rhaGbixOY5G/+pM6H++qZJm7hQkGbFiULA22eoJhUlR29+SorKRtaykAqPW47pRqq2uu8oKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFRKD46K; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso6121145f8f.0;
        Wed, 23 Apr 2025 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745408246; x=1746013046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sOaslwO/iDwgRO6fHWCqrlxeNb4sZEAWfunB5Ekm3Yw=;
        b=CFRKD46KAxCSY0GnRw3hpSW2CTnMcs+t5+zUcvTICIm595UnYv+fNvGC1IaEWX2VGj
         G8Yerid3y+63qAbNBjy5Z91GmvWrdZaFzsz7iXIKQo8UInPK+QIxyUX3BZN6LouKsZ6x
         hR2/zdMHFzkhz4UMykPFcwPAFF6EOwjs3AM7YU1NVLs0shtnkNmiWaJ907yPuKrsGD41
         bnhN0CSgvJtG25s533hJ3HfDRh87ZOZzt1EYdjgbHI//bSZn1DXHi+Cqni1sz7+R5qsD
         2qYxxaNnRHHMID4Ppbw1f7UyUu+V85p8bILHVUxHxj+R5tdktrDpMm25oApGpF9RqMeU
         ag3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745408246; x=1746013046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sOaslwO/iDwgRO6fHWCqrlxeNb4sZEAWfunB5Ekm3Yw=;
        b=ACYaAK8cWKihFAcJvUKTR2pwhutWHqm2J7YMTIoSEVs6dPScAoToHtdf2Rsy7AQnbx
         eqrTM5s7SYlgz0zkmMOQBNK1IC+ANgw2VRPojCfISGA4qMuOgSuBFuYiSHzzW0o4c9zQ
         +ebTMubYIGYeypQiEE+hFCAPvrJwS5gY2RJjHMC2uX1hlcsi0LM3HAnoWZ2vBGSq1IGx
         hq815QSHqzBlBowR3BNdL7VecHPkRjcULaYHWwItSiIkWtFaHv8BRtY95FW3I2iO4hDS
         CUVppMFi4YTNUSu6UAn083mZsAH2ciEWgn2Bvx6idIQrSkVRn6T4QkcbNCQF12aih6UE
         UKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ+w8ahaAOeaWCjBxujFKzv7z9xHuhBeLR1T/tF1LHngzybhGrpvizLQULxGL5YUrEK7qwB/MIBAMHbFM=@vger.kernel.org, AJvYcCVpbCVTde6MIACnQ/zLCt6aOsAKtfSVcavgfCIZ9VzHJZ5Nb0Gihg7ExleBTuw07cHjGvNN8XMr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3sZFMVp1LwJMFx6fiST35JO4Rtx0U1+7dQLPLU/TZYu/rUT+
	G1aWvU6pCykERHSyJNr6QcZ5rFvVqWXK7StdMhNGAvD/1xQpP7jp
X-Gm-Gg: ASbGncv6Gmqr9CjhmDZziqNX9kuuhBwtRCDXtOA0908q1/f7guph0yvnmbdqNKSPr2S
	LEMJsMgWtNo/Wb4Fy93eeIjTYe/zeA/aqYTsVb2441PcHBiakezqC0OQ2F3nml63W0odOE9rYYC
	v3mZ5eaQ84k2FjCqgTZKR/gnuXlu2u3K6sMSohh0QMh7sdthJtmXgeH5GMad8SEaha+Yaqd/NBa
	M/U62SwxS64DnNi1bS1kvzbyztrK3+3EJ49gL2vJgMEUB/X9/7jpAWlCL1CFTsRTXq5ztH1ejcC
	KCAq2g+oWe8FcqejddhYanuYi2MUImLGlRsRxm14aA==
X-Google-Smtp-Source: AGHT+IHSoaSXaAgj53jWAGtI7Z7mMkdXhhLo9jTahymT0NfSoVyVjCueixP+i4S5vMsc6dh5pNJwhw==
X-Received: by 2002:a5d:6d88:0:b0:399:737f:4e02 with SMTP id ffacd0b85a97d-39efbad2f10mr16252645f8f.39.1745408245796;
        Wed, 23 Apr 2025 04:37:25 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa43d22esm18699323f8f.52.2025.04.23.04.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 04:37:25 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: ip_gre: Fix spelling mistake "demultiplexor" -> "demultiplexer"
Date: Wed, 23 Apr 2025 12:37:19 +0100
Message-ID: <20250423113719.173539-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 net/ipv4/gre_demux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/gre_demux.c b/net/ipv4/gre_demux.c
index 6701a98d9a9f..dafd68f3436a 100644
--- a/net/ipv4/gre_demux.c
+++ b/net/ipv4/gre_demux.c
@@ -199,7 +199,7 @@ static const struct net_protocol net_gre_protocol = {
 
 static int __init gre_init(void)
 {
-	pr_info("GRE over IPv4 demultiplexor driver\n");
+	pr_info("GRE over IPv4 demultiplexer driver\n");
 
 	if (inet_add_protocol(&net_gre_protocol, IPPROTO_GRE) < 0) {
 		pr_err("can't add protocol\n");
-- 
2.49.0


