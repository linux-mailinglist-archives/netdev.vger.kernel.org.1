Return-Path: <netdev+bounces-198966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA75ADE713
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53D817D5CC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD892857C9;
	Wed, 18 Jun 2025 09:32:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B3E28F5;
	Wed, 18 Jun 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239174; cv=none; b=NiHofn56x7v1mRIj8UaIJIu0ORKIsEFsRaBFNwjLSmRf8xUUMmPZEjYrQhnREQFUVtCiP1jPk3PUGDx3J6Z9R1Xw+wsUzpWtNezB85hGxRZcsAg1gFe2IG2oMy2DJfC1HInlhkgLWhwxdqE3q4/KrUUm69ZGJP4ux20Umbmpm+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239174; c=relaxed/simple;
	bh=8oSDJXr4MRiC6pfx36kYfYrC7pURwAUL6y1NKD3t6og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flEEkm8AmW7FK9f/L/z3Y+eZU7+rQVDgEPlhaTJBHAQc7Cw9k9IunqZLNc3sK/fR9SDjAQjggwiiFxo4ECzol2kVrBOVjzT8UqS3itUUit+IraTdrpWLcBgsfXAeXFWbEvTwp/OVb5i/KvpWplg1nQDHwhXfH3JQL3M1LQSlFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-607c2b96b29so13108136a12.1;
        Wed, 18 Jun 2025 02:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750239170; x=1750843970;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7B+m3/rWZKz7fhQC9HEioD8ZXYaWHZgndw4mU2cxAA=;
        b=dEU3Exr6WBbxFfRkp+ovlOTYasojcVyl4mJeSnIlDxVM+Tp1d+lJpc3ZvBw/JIIe1K
         cmbreSAIENHZihwAUD++QrzQRetLeuoR6J0DztQ7V0uwKJyid675KR1n6lA0+shV7V6L
         OO3VDS5v1Vy5Tu9DI3TDgWp8wGHhZ1J3NW95DAFzwhyfUvnhg8GBrIIskf2Aoc4wxlRv
         YhzMxQk2zqAV04mtrauqINpT3AssYnKgzFDIqIp59BOS6KIX025JVPEbsDRfkK/94aLu
         oUf07dvBmApBc4HWvMHxWaiTRzULmGPTy6d8XhYaQ/3WMheXss/zS45iTHLikchP7neF
         A9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWiPyZ/qwo+yP4dDjQM+CQve81lUrO8y7/13Hw2I3aW0I2a2FC8HQgDFhBHXAiB6kQ9/HmnDvxC39ncfIE=@vger.kernel.org, AJvYcCXcoL9kERhxyl++aQCy34QgnzUSh16Lo6fharXqcLP5TEYbBzkXqy/dm11XDgsRLGkBTqsbs+0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiBpiFrTzjm4KCmKgTYtzNNVc0Ts52Mu3LZXgesEybX23TRhM
	JfnYijt4Fy90cTxYCenqnXVyqiSivCrWr3HsBPl5dSiwRaVcYoffSvJj
X-Gm-Gg: ASbGncuf2HT08l+hxOl+LqXwbAC6uTCo8ciby+8HjeIj66uKGWsXO0sgH0s15y5iTbf
	PoCscP7XFxg9Gqgv93fpEs0uR1hIA/XQWZLGShYrTpKXTl5DxOE/sr84z+GYzhatiMHL1ZvxbQV
	bcs7xTYRVueY6Ru4mVARkVhyPafERlOc3yYaG+IIWgu5kXV5b1gXVtaMtHXb77CDpAm/vqb6C8Y
	qP/D8ytsBANq19MUtXdmnPxufnW+Gfh5aXpUxLg/AIb/8U2tbNO+vranQvcJdNQyeJspGX7qsDl
	f2k+HKRsnZrHCIpy+fYnsCwtPSN1xeJ7FigrIWJOd38FpXPafL1S
X-Google-Smtp-Source: AGHT+IHD2whKBJT6RHjFj8VOP3UU58/i4PNOoFrxZYRtwP8ae/XSrw9sACv3Z9xAOxasB8pgrwDaaA==
X-Received: by 2002:a17:907:cd02:b0:adf:f3c5:c858 with SMTP id a640c23a62f3a-adff3c5c968mr821668766b.15.1750239170381;
        Wed, 18 Jun 2025 02:32:50 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a5e6f0sm9737680a12.42.2025.06.18.02.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:32:49 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 18 Jun 2025 02:32:45 -0700
Subject: [PATCH 1/3] netpoll: Extract carrier wait function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-netpoll_ip_ref-v1-1-c2ac00fe558f@debian.org>
References: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
In-Reply-To: <20250618-netpoll_ip_ref-v1-0-c2ac00fe558f@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: jv@jvosburgh.ne, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=leitao@debian.org;
 h=from:subject:message-id; bh=8oSDJXr4MRiC6pfx36kYfYrC7pURwAUL6y1NKD3t6og=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUoe/n5Jsl5k4SJPPwVUnGTJGOIS6qnhw2jkrE
 NXwWJybxN+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFKHvwAKCRA1o5Of/Hh3
 bXwoEAChhREsk9QIWU71OCddfwmhLp+t8M4ktJPqb1EZI8pQNxIHJdrM8AOq7CF+xjDKD8EAN14
 hYWfQjRNJOM27UewJWBeuWWWeId9NgRqSjt9XFTD2RgDvaPxA2Dy88Lh1d/je7Eb0McMXY+47Fu
 /18lBlnMTLfusgDrjkqrxK1BnD6cdD4A0zKaP02kgomshmrtiITbx6Z7kIzWoN4w8iOyYCniVth
 V78kn4ng5SXa8kbYP8HqX14bRfkGVLOqCmoXHnhCEJTdP05MLbyYXhplZOpjTRKoaDrSRw+XpHQ
 7Jkb+41+HvCS18chDZ1nczkgYFBadNJq7g4UJ0XNB3wJCaETnEWNQPFHI8MmNOTqwH3THHIZgL/
 CK5xd11n6E24qNYEnVLhQswEUV+fqVqe2+FH0WYc7yt3E4K1benfD+mw5uN9mDJC2hZDcKFRFeC
 lO4Dy3P57fuJVCchqXP6n7q/xXHjEorBxhV15tByy5bnrLT5fHPWM5hmVf2vXp1ao7HpsQRCulp
 z7mZU/PgYd0eS2X8jlR4PMpMqzgKkYuv770RMQSGrWJV4GiQ0Wn0+3EtsKu8GoilKK31rJael5+
 Fc8wT9vOuy/OBFq1obRSo32FwKMI8cClHTgCRQpSiukZi6ku+9VAJpH4ER5Va882ScOqtOTuBIp
 srhFXj8wJdNso5w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Extract the carrier waiting logic into a dedicated helper function
netpoll_wait_carrier() to improve code readability and reduce
duplication in netpoll_setup().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 07c453864a7df..473d0006cca1f 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -583,6 +583,21 @@ static char *egress_dev(struct netpoll *np, char *buf)
 	return buf;
 }
 
+static void netpoll_wait_carrier(struct netpoll *np, struct net_device *ndev,
+				 unsigned int timeout)
+{
+	unsigned long atmost;
+
+	atmost = jiffies + timeout * HZ;
+	while (!netif_carrier_ok(ndev)) {
+		if (time_after(jiffies, atmost)) {
+			np_notice(np, "timeout waiting for carrier\n");
+			break;
+		}
+		msleep(1);
+	}
+}
+
 int netpoll_setup(struct netpoll *np)
 {
 	struct net *net = current->nsproxy->net_ns;
@@ -613,28 +628,17 @@ int netpoll_setup(struct netpoll *np)
 	}
 
 	if (!netif_running(ndev)) {
-		unsigned long atmost;
-
 		np_info(np, "device %s not up yet, forcing it\n",
 			egress_dev(np, buf));
 
 		err = dev_open(ndev, NULL);
-
 		if (err) {
 			np_err(np, "failed to open %s\n", ndev->name);
 			goto put;
 		}
 
 		rtnl_unlock();
-		atmost = jiffies + carrier_timeout * HZ;
-		while (!netif_carrier_ok(ndev)) {
-			if (time_after(jiffies, atmost)) {
-				np_notice(np, "timeout waiting for carrier\n");
-				break;
-			}
-			msleep(1);
-		}
-
+		netpoll_wait_carrier(np, ndev, carrier_timeout);
 		rtnl_lock();
 	}
 

-- 
2.47.1


