Return-Path: <netdev+bounces-177702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FB0A7151E
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3883B5709
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE41C84DE;
	Wed, 26 Mar 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTfFB6kl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7C4A29;
	Wed, 26 Mar 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986373; cv=none; b=BRIFua751LnCAP7ejN4OI8X9J6CY3A2orcyXqeE7nvCnDpw/r2yghPtHkGd4n7Q5JOOt2f4Q7Ochd62Dg2WwpdbUybk7JmZZOdStxNwg9LCQOeniLYT+F10EJXX9k2UMCMXhMERKLBGnEPE+GuEr/RqkZR2Y0CNabdwpkghuDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986373; c=relaxed/simple;
	bh=Djiuh0TTQ+OQMWUiqRkRsKWbVm7hMusiXM1xRsAVliM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JLpLnKEKKiOBekp3bvgZjLhrC5nVUX16JXAo36oA+tsxSC0367eezPwgHpeM1qDVf51ZwdZmsY7nConTei4rrZEvPTgWXAqs3grk1ZoWVLL2CY9yGhe8P7gbtYBxDL8gc5+0T+i96l3b4Nay8rUsPCzThFzL3ihL/9JEDlNbWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTfFB6kl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223f4c06e9fso14561685ad.1;
        Wed, 26 Mar 2025 03:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742986371; x=1743591171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwRuOYtlCLzRZmhCJLfT7hvVNcHg1UTJcmJVtwUdAw0=;
        b=CTfFB6kly2Pb3PAeWdu4wMQhxUmp/090nSRuGKz17qA4JJp4440pdc5LEslt4+veXt
         Pb1KVKtvi6S+HCm9uoNmrctFdOEranZ04C7YhmwxkVtLQrIaNj/wBXEBTiFurqbWpJS+
         GwrKTsmKfwWrRdAGPj7Ntc6y1ZnA+XJmJ6gwmb0IMRPLg/LPiTqgHgrXQloVR+P6u0X9
         EO7PJA9lEIKflW+ptLUJZJJzUh/l35tHUyB9Sb26s7tCVnPbgzPSn6332ic5skdo8Uyl
         8ipV50z+SP03ct390u1w0GlmSr85RMGw3qVCpXn4y2Ak5A6uL4YBfF1KbLXSwKAFV7AH
         6J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742986371; x=1743591171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwRuOYtlCLzRZmhCJLfT7hvVNcHg1UTJcmJVtwUdAw0=;
        b=Eta6x3rccQ1C9CSW4BxSdxwjiQenKGkUA0pIFmRlxSKuOx/nsulQCIUZFXk2JlJIAk
         S2YuYwZkTqfs4X8uOmMu1u6gPrLdi4VOjXHtyVx/+d9ZWawkeXxA79jCQ26k9uq91/y5
         z5X7X7OHgpHPGJ4S+JnPxfqOWvzCRdZNAXY9/KS1B2nn2ltwVgZroxGoj95KMsO1o2+8
         HSeUTfLB99oYoyreswRXHVqOiBnmQN9yytg4s+RDINZkFffmOMaXmdnz1BM+ikyaoO7z
         lEHu3D22itKDyO5BCwDD/2zNU2mRzJwUQhEgoh6kCRqTibnoRopPXP4htVXZASHOTHsN
         yZsw==
X-Forwarded-Encrypted: i=1; AJvYcCVXzzeaB4S/frp3/koGSgIzrunAiMcCxWIsFetF21yWPTAPpf+04ruELoBT4IPjvhXzT88R1AED@vger.kernel.org, AJvYcCWa61y+iVRi/8utEGF4prvKftshkJdXWhqbPHYd0reQkVLG5s+JtouZIRkqQ3I9l0sPCNLcyfO5oRoy3vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc0jce/jV0IEnvHBu1u/s9X/IXVmR3zqzD2tUhCR2fXdFsi/dD
	/1k641Aufi9PckLt6hvHIvWTOn8OPmHn0Spf+GKndnqMLg+5vHL1
X-Gm-Gg: ASbGncu8aPFvSb7oon/GYvc7B2TXfegmPrgg97qKUNwCjTdEPNzdC1ePkacA+r3vLhn
	bizvdSh+53PcT8X0Q9SXRa1DlT4rIsj4+67aPi+RRkATYlJEK9GI7Z4olozWb+jrg9uxIu4hZ5f
	UiCuhqy+oVcSL+K3Eu/PREEs5AdBUvRKX8mQAP8FqWyrIRBMoTjGDahRf4MrsIsrVpXaLcJN7Qt
	ASqKKVYVvCaLwCh3ReE2PmC9F7Yjrt+cQDslBwwC2REjjnR+LbmmB3vW6myqzPva7y+aoNAOnoc
	nKyy0hi7IQxWzWNPMjQ7agYK3BcC1jA+nfiaVkucjakYAdNpKvS3d5LKEIqhhsDmT6Yz+9592Ug
	=
X-Google-Smtp-Source: AGHT+IE4QXqhpL4pCNd808nbhmu+o/NuYs7Ewl82eJ04YX9HoXM/cdykFs9gadLeiRj9Zk9KT9O3lQ==
X-Received: by 2002:a17:902:e946:b0:220:e91f:4408 with SMTP id d9443c01a7336-227efb817ebmr55076935ad.22.1742986371125;
        Wed, 26 Mar 2025 03:52:51 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4599fsm107516005ad.67.2025.03.26.03.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 03:52:50 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] net: ipv6: Fix NULL dereference in ipv6_route_check_nh
Date: Wed, 26 Mar 2025 16:22:15 +0530
Message-Id: <20250326105215.23853-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
net/ipv6/route.c:3427 ip6_route_check_nh() error:
we previously assumed '_dev' could be null

Ensure _dev and idev are checked for NULL before dereferencing in
ip6_route_check_nh. Assign NULL explicitly when fib_nh_dev is NULL
to prevent unintended dereferences.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 net/ipv6/route.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index ef2d23a1e3d5..ad5b3098eba0 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3424,9 +3424,20 @@ static int ip6_route_check_nh(struct net *net,
 		if (dev != res.nh->fib_nh_dev)
 			err = -EHOSTUNREACH;
 	} else {
-		*_dev = dev = res.nh->fib_nh_dev;
-		netdev_hold(dev, dev_tracker, GFP_ATOMIC);
-		*idev = in6_dev_get(dev);
+		if (res.nh->fib_nh_dev) {  /* Ensure fib_nh_dev is valid */
+			dev = res.nh->fib_nh_dev;
+
+			if (_dev)  /* Only assign if _dev is not NULL */
+				*_dev = dev;
+
+			netdev_hold(dev, dev_tracker, GFP_ATOMIC);
+			*idev = in6_dev_get(dev);
+		} else {
+			if (_dev)
+				*_dev = NULL;  /* Explicitly set NULL */
+			if (idev)
+				*idev = NULL;  /* Explicitly set NULL */
+		}
 	}
 
 	return err;
-- 
2.34.1


