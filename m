Return-Path: <netdev+bounces-176422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362F0A6A35F
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57FF1895C5C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2422236F4;
	Thu, 20 Mar 2025 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+94Z5N6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1D23A0
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742465680; cv=none; b=NeMdAEu6Q2bfMhytpLjoBaCPPbrRyupe4LhM9hQG/MNJsj+AenYXdUTw7oHHgaCWZILvTsRDyejh0seheoD3QZDmp7UT0Zgs7tMSspELthdVvSXcG+r6wcZMsg1vCYhRS7ruddx0aqW3mrfVYRopitbFc1WCYwXfe3O85dzpf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742465680; c=relaxed/simple;
	bh=697NEgjQXTQL9nRhPsPrRp6CX5PfeiFm0ywAZtszSXM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qI9KBXFTCcVMiqgtMdBrgaQ4DHO2SclJNVTi3Lyz6hmyctAQFOMN2UpNApaBwQuxbhs0hodA+CyRw/k0/NHegcpBLS6kpBV7FbofNSaG5lVRYJEHbMP0euNjPQG9KE8CwXVIpa9Kx5DaN/gKfHtbBiDmdrAa2K+dg9mrSOO7BiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+94Z5N6; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c09f73873fso114450885a.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742465677; x=1743070477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Hn1hjOfmaAUK1DAPwlszKPoKVJ5beTpgKB15+1LFrA=;
        b=B+94Z5N63HtCQnaUAwd000jg7HLw4CS3YNIi1IyFIMpfH7X7nYQ2X/Sa8PLmpEclNT
         sbVzbj1m0dQ8VkI0sNZvrXx7jHdkpX+E0p5jrc6FBa2PH82lxdhTLuOIwV/CRtF/xG6w
         gSdu2cHZfMDzXuUxvb6Dc+mkeKcsrTyF439SeZY7HwnMdrEqMFXhAYfKJfDukZ0u8Wpk
         vZAJBjZ7iuQP4GmmT/UCvwWHvBckmsjX8J0jbDzffpFz4nZiIp6QPn6fdqD25cXEJ8Z/
         gRI1Dlc+GOO3BPtIhq4hsMR/qtmKjFnIOJo7JgyEpKqpYJn8mFhIExR+oEGxqt710JQ8
         ubug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742465677; x=1743070477;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Hn1hjOfmaAUK1DAPwlszKPoKVJ5beTpgKB15+1LFrA=;
        b=rNgnQlb9LcpgLlomDZ01SQqY7vonszgBLdm+DYDepdE+XGk20YivgswsMVthBpjZhS
         tgK1tFWMBb0uxpepigzDkytbygdZ6WbCqHpOWE9/YHFrQXDbQPQj2UDQp7lbTJHWTL/Q
         4+R1rqBFXffECFzXZzL5tYVfyHl5i4nbhYJs7pkCCsUX3eFAq0qgiPwKqu1Gyf7xuS3I
         II0qq4VLg9JrEZh9Ixn/OLkjoPdq0Cb9J1rieh1g26FJn0BoIbrzJwEWxShmAJUMlPET
         vA6ii6GHKdKYt9axlUYn4n/e1zQ/atFrIdb838B44UW3tiB+vG5hBsJySX+nC0Ay8x3j
         Joyg==
X-Forwarded-Encrypted: i=1; AJvYcCVndWqCmeKXoKDZclAXdla/rpuLf/euCr//H3urCxiizDRZHP7j2gQtXKsMMj7iAUD/aa+tAuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5q6MD9ejj/I+ELz4Vut6nxQlgNO6K4oweomWst9LRU9GYnhXc
	54czuRoPtRltdNuj6UH6JDWjPaO6cmmyOZ8iZXQC/u+kbYMWhxLFGLZ7G8X8Lr0Xs9JpmSu+7Hv
	7ppo22cfqsA==
X-Google-Smtp-Source: AGHT+IGRXYi7+i3EkdXL7UehXhTcTqLYJmu1c3PTXo400vAUFU1nRHW2T58G4mvtiafwR+CYw/HKFW94g0dY0w==
X-Received: from qkpc21.prod.google.com ([2002:a05:620a:2695:b0:7c5:4baa:fca5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:22b9:b0:7c5:aec7:7ecc with SMTP id af79cd13be357-7c5aec780a2mr503381085a.13.1742465677606;
 Thu, 20 Mar 2025 03:14:37 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:14:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320101434.3174412-1-edumazet@google.com>
Subject: [PATCH net-next] net: reorganize IP MIB values (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 14a196807482 ("net: reorganize IP MIB values") changed
MIB values to group hot fields together.

Since then 5 new fields have been added without caring about
data locality.

This patch moves IPSTATS_MIB_OUTPKTS, IPSTATS_MIB_NOECTPKTS,
IPSTATS_MIB_ECT1PKTS, IPSTATS_MIB_ECT0PKTS, IPSTATS_MIB_CEPKTS
to the hot portion of per-cpu data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/uapi/linux/snmp.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index eb9fb776fdc3e50c2ecfc6b36d5472f8f65b5985..ec47f9b68a1bfb1908f2197555c876424481ab1c 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -23,9 +23,14 @@ enum
 	IPSTATS_MIB_INPKTS,			/* InReceives */
 	IPSTATS_MIB_INOCTETS,			/* InOctets */
 	IPSTATS_MIB_INDELIVERS,			/* InDelivers */
-	IPSTATS_MIB_OUTFORWDATAGRAMS,		/* OutForwDatagrams */
+	IPSTATS_MIB_NOECTPKTS,			/* InNoECTPkts */
+	IPSTATS_MIB_ECT1PKTS,			/* InECT1Pkts */
+	IPSTATS_MIB_ECT0PKTS,			/* InECT0Pkts */
+	IPSTATS_MIB_CEPKTS,			/* InCEPkts */
 	IPSTATS_MIB_OUTREQUESTS,		/* OutRequests */
+	IPSTATS_MIB_OUTPKTS,			/* OutTransmits */
 	IPSTATS_MIB_OUTOCTETS,			/* OutOctets */
+	IPSTATS_MIB_OUTFORWDATAGRAMS,		/* OutForwDatagrams */
 /* other fields */
 	IPSTATS_MIB_INHDRERRORS,		/* InHdrErrors */
 	IPSTATS_MIB_INTOOBIGERRORS,		/* InTooBigErrors */
@@ -52,12 +57,7 @@ enum
 	IPSTATS_MIB_INBCASTOCTETS,		/* InBcastOctets */
 	IPSTATS_MIB_OUTBCASTOCTETS,		/* OutBcastOctets */
 	IPSTATS_MIB_CSUMERRORS,			/* InCsumErrors */
-	IPSTATS_MIB_NOECTPKTS,			/* InNoECTPkts */
-	IPSTATS_MIB_ECT1PKTS,			/* InECT1Pkts */
-	IPSTATS_MIB_ECT0PKTS,			/* InECT0Pkts */
-	IPSTATS_MIB_CEPKTS,			/* InCEPkts */
 	IPSTATS_MIB_REASM_OVERLAPS,		/* ReasmOverlaps */
-	IPSTATS_MIB_OUTPKTS,			/* OutTransmits */
 	__IPSTATS_MIB_MAX
 };
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


