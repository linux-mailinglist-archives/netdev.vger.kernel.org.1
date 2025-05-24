Return-Path: <netdev+bounces-193194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48FAAC2D9A
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 07:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE933BDD79
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8991A725A;
	Sat, 24 May 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry0zFlNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BFD2DCBFE;
	Sat, 24 May 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748065928; cv=none; b=mWL5Nr576Z8W0gNxJfMwqf8YWfkSk3WRHY0rXldORD99Y7vxhSsleHjwrQPu/Nmy7AbmQZCz07O76tJmTmkEyeE51XLdsZVZ6KY6CaceA+OFP+CGFgvLIqdn7KP6miVRv6/Vd3rY08zG0UWsG99/yyCPIjTMW6L5G63S8BWLvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748065928; c=relaxed/simple;
	bh=FdWjl1ErG93oPcsjFxaQj2C7s+R0GcehBa85jodw+II=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9iIGLUUUYaso+vADRbexdHGYClT1YoHpMf8CXu11y1mWR+2wTu8Y+RemLkYMUab7YqPjVFg0z59buJUpy910jJAxIXn6qKM/HxX3gOAAV+4vynIN63DoaPYVko20gvCSPJ6+4fKsfv2flviNYCWWYL0fWrouaHDdNFTQha8Xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry0zFlNA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6000f2f217dso995299a12.1;
        Fri, 23 May 2025 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748065925; x=1748670725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fWh8IbKY/zP3rW8Cj2HDPpInfGDKXjZkqplO5iz+naE=;
        b=Ry0zFlNALJKg8OpucClbwO3rHcrprrb3x5sDcAabMETmctHZ96F9zDRZi4PnUuib9K
         ICRLe+AJmYPFGQ4ckrzPKVjCQwMVSTg3sC4aRUZQc+CYoFc5+xv777HEd8sS7+ZaO/S3
         bcASnvNvsON2U7LzM4zD6D85cmp9ZfI145Jg3XQmAsAv4gOQEPBR7bi13a3vKM2h9uIf
         yYm7tLYhRzgvCgyx1IbZ/xW7MmR9MhVQ6O7unQZ1LakIPRU0RuVANHRoVk/umYL+oueT
         /Du2zUcvFOIXefZdmyUD8OgnfLUNflkOdayjn1utXSTln/9lWESx1MLAOLbcQ/hmGIz+
         MLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748065925; x=1748670725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWh8IbKY/zP3rW8Cj2HDPpInfGDKXjZkqplO5iz+naE=;
        b=iYfvPbYELQvUTAJQNJGqp+lsFnZh5+g/mhmZD2lKowLBuW+nLeziD1no3BSHAp17vo
         nY7O9GUFFVbAyZwF/Xp79Z7D4K2mOKbNnZXtfntRPHI208B0akdNLb3YqGneoMTE70zY
         tNja7IvLNtlzkVFOTc39zFL+gE5HZAFIlM4D1Fod0IXkhvc8wvpewSJskqnJKQbMs9Rv
         xSy8YOtE3kZzYAsdqoPXoRjkW2dGiwZiBRnkvBl3knr9UOFiBpM3aa93YT9Dxvem0/zC
         gDfrEBUKIsvjS1umMbVuvEcv8iJMj2jmIGhS5FK0lDwYq3f9amC8H09K4UPi5hZu5pG3
         bHJg==
X-Gm-Message-State: AOJu0YzPkpyJDWDOABFz6vb/nEyazvj8ll87DqZ5qgUj5eAZLwd8rQRx
	QAV3jY1FG/8+5aLRnB9SE+3idcZ+AhhwPnDMOsCAF7znq16mb/lpmsu5PPOqlkSw
X-Gm-Gg: ASbGncv5O9R9FIAcXrE+MSAWWVBaGPu1Dr0y9AzUgI/omaQ5qM+m3QtN3x/X0r8oX57
	s15cJuwPNF+Tq9bOKAsU/Nbc4aOtJJIiB/gnEgl+rhjAtd70luP40FEWqMyAvU+hl/XKT9mLUcl
	3papaZr5cE8AJLduNIT+dG1oSE+GrE/XEwHb4q6yqqVilW5CMNISaHJOvUubJ/5oc2VZIid0NaG
	dQ6UIF0yWngzeph+iwUgrJs8SKVl2VGrOi2CSPocHq/PkvbL1DT4jMIllQwXSZLkyMIQcTknMGo
	pfi3s6rsChM9ATUt0GMTd8XPaag4/DJBsZzyRn0mltpsYKfp2ktSjekG8dwYPRYS8pDY9w34lZA
	sh/UJF7jVfRUvfnkRVeTSOjRDTyYuRifvLEQSoploJA==
X-Google-Smtp-Source: AGHT+IEFT6FG6h7tfjwp6aaU7GjUlIxno4NGCn1vxL7j0P907vGQ+YTP9/2jgTBtGvtOaM2AoeRrPg==
X-Received: by 2002:a17:907:c26:b0:ad2:3f1f:7971 with SMTP id a640c23a62f3a-ad85b120179mr138922766b.8.1748065924561;
        Fri, 23 May 2025 22:52:04 -0700 (PDT)
Received: from rafal-Predator-PHN16-71.NAT.wroclaw_krzyki_2.vectranet.pl ([89.151.25.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06dc6csm1365451966b.53.2025.05.23.22.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 22:52:04 -0700 (PDT)
From: Rafal Bilkowski <rafalbilkowski@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Rafal Bilkowski <rafalbilkowski@gmail.com>
Subject: [PATCH]    net: ipv6: sanitize RPL SRH cmpre/cmpre fields to fix taint issue
Date: Sat, 24 May 2025 07:51:59 +0200
Message-ID: <20250524055159.32982-1-rafalbilkowski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

   Coverity flagged that the cmpre and cmpri fields in
   struct ipv6_rpl_sr_hdr are used without proper bounds checking,
   which may allow tainted values to be used as offsets or divisors,
   potentially leading to out-of-bounds access or division by zero.

   This patch adds explicit range checks for cmpre and cmpri before
   using them, ensuring they are within the valid range (0-15) and
   cmpri is non-zero. Coverity was run loccaly

   Fixes:  ("Untrusted value as argument (TAINTED_SCALAR)")

Signed-off-by: Rafal Bilkowski <rafalbilkowski@gmail.com>
---
 net/ipv6/exthdrs.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 02e9ffb63af1..9646738cb872 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -504,6 +504,15 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	}
 
 looped_back:
+
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct ipv6_rpl_sr_hdr)))
+		goto error;
+	// Check if there is enough memory available for the header and hdrlen is in valid range
+	if (skb_tailroom(skb) < ((hdr->hdrlen + 1) << 3) ||
+	    hdr->hdrlen == 0 ||
+	    hdr->hdrlen > U8_MAX)
+		goto error;
+
 	hdr = (struct ipv6_rpl_sr_hdr *)skb_transport_header(skb);
 
 	if (hdr->segments_left == 0) {
@@ -534,7 +543,18 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 		return 1;
 	}
 
+	// Check if cmpri and cmpre are valid and do not exceed 15
+	if (hdr->cmpri > 15 || hdr->cmpre > 15)
+		goto error;
+	// Check if pad value is valid and does not exceed 15
+	if (hdr->pad > 15)
+		goto error;
+
 	n = (hdr->hdrlen << 3) - hdr->pad - (16 - hdr->cmpre);
+	// Check if n is non-negative
+	if (n <= 0)
+		goto error;
+
 	r = do_div(n, (16 - hdr->cmpri));
 	/* checks if calculation was without remainder and n fits into
 	 * unsigned char which is segments_left field. Should not be
@@ -638,6 +658,9 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	dst_input(skb);
 
 	return -1;
+
+error:
+	return -1;
 }
 
 /********************************
-- 
2.43.0


