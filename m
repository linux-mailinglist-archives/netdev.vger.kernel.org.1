Return-Path: <netdev+bounces-219944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A3BB43D23
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ED11B27290
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7A3054DC;
	Thu,  4 Sep 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5aJZ1aU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348EC304BB6
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992365; cv=none; b=i8w6tKtDdfSn7VuTgcKb0HBicqXriZtxL+VGl8xdGehvrGYciPmR6mxNp+n4xlR8h/MPHjv2NM88V0dPb2pNqopBzLkw+yy8bTiir5rCV60YqbbwNOjfnyPD+7x2WaqsoLFgljRToZKxiihHhiTGqAm9CaodVV4rALALNgkbqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992365; c=relaxed/simple;
	bh=hn5hBfv0EdJJdbSLJaTwIPaUxJLEh85b7k/Bb0h+kzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ai6mAD1OB+ohmio3HTPsEXfoJV0bAK/8F5Nc7EXVX1+fytgO/lPZU9vQVwYxBviAqRTsiTpth9YmJG999VxuZ0bMDg6AcbB/177KcfzDDmi03d4TjzpX1T4kCabP19BdXrVLs9LTxo3O57aMCwMwg1ffcni/GPGVnKop7iXjGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5aJZ1aU; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b5d58d226cso19191901cf.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 06:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756992363; x=1757597163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FfuzqubmVzaQ86bkmfs5xukcevqyqOWQnCgx51Y3kw=;
        b=W5aJZ1aU5zOMQUaLh8bXKDPtHP9VhO36G4kzmzkyXMO028yCJfMaEJoW1DH7QMM/vv
         CKb/bmaGkir9+V98qE05/dn27277hygIE7Jgmc1cNUZDP2mFn8TBTQZeoumipjWS2C4a
         kStJy9oOIyOsKdB9frWx0vD258HOw3FQJHTkV2SDxTEYA8wfPrenu5xtovYCbfYu8JMz
         J0KCQzxcFSKtWCxPVqcnRAF8oaCytWfEtdgABTWQCdRN4u+qLd7yE4oQbimuMnYyfkvK
         Pu8oi6blAc+TTlTYAu9dVb2uhOBTmdOxaYFGHKTmIrSQEKdJ4UDT2/FcHVqXoJd3vtVy
         POIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992363; x=1757597163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FfuzqubmVzaQ86bkmfs5xukcevqyqOWQnCgx51Y3kw=;
        b=HiFHMMFJiHnyrx82+vnjQblJKu2IGUHemNGGy396qX1G6rHKBYgQ1ZcpYg0sE/69cC
         Kw6yUzmQySqQWRT0IUyGNlmO6g+KNei6LQfCLrrwwStC9mk4cJlW1YSi8TKp8Ptc2zoy
         cswBx3EGvpqA2NMatQnYqWNYABxriQxh26Nz5/yQnCzwVtQIW3rDs9PSwinNlO4Ah4rd
         cRQ8/+hRdHMPO4rsBRdMMiarP25iVkZmpWjWan1ll9Sq80xG/gn3WiP6lSY6nJoStHPK
         PmkjHZCj4JvW+ouT9xWBCAZJzhAcPvxa0cZDPWjHLoWwBsQyrLDrL6G91lh/5w4Ny1yC
         VVmg==
X-Forwarded-Encrypted: i=1; AJvYcCVdxJbgppjTSolsiHP7ooN6U/xNNBbircOE1cghBH0jPkjlg6B2htkJIAeMQ4TlWwk9q/aioeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAm1w4vgwcMcttx9H8KqNZa4IBnY43H0V332czMaj0aj0aodDj
	0KVM8vDk8h+Pn12np0Qzl5Nd4iz5zYdgAE5PWiM3IVu9a0lhcsbg+1u3XwmjCGKDDVo+lmkUwI8
	UeBjoMu7cBpdKzg==
X-Google-Smtp-Source: AGHT+IFaGB1zgryJA8/ZXSoNEdgr5fbuNRE0jPpQgKdgejaEq0lqHFNKcc26iUYdQ/TqmSVFRQWFAxsXYjaJIQ==
X-Received: from qtbg4.prod.google.com ([2002:ac8:7d04:0:b0:4b3:4bfc:fcf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a19:b0:4b5:e15e:d5ef with SMTP id d75a77b69052e-4b5e15ed670mr7972101cf.49.1756992362787;
 Thu, 04 Sep 2025 06:26:02 -0700 (PDT)
Date: Thu,  4 Sep 2025 13:25:53 +0000
In-Reply-To: <20250904132554.2891227-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904132554.2891227-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904132554.2891227-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] ipv6: snmp: do not track per idev ICMP6_MIB_RATELIMITHOST
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Blamed commit added a critical false sharing on a single
atomic_long_t under DOS, like receiving UDP packets
to closed ports.

Per netns ICMP6_MIB_RATELIMITHOST tracking uses per-cpu
storage and is enough, we do not need per-device and slow tracking.

Fixes: d0941130c9351 ("icmp: Add counters for rate limits")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Cc: Abhishek Rawal <rawal.abhishek92@gmail.com>
---
 net/ipv6/icmp.c | 3 +--
 net/ipv6/proc.c | 6 +++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 95cdd4cacb00..56c974cf75d1 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -230,8 +230,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	}
 	rcu_read_unlock();
 	if (!res)
-		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
-				  ICMP6_MIB_RATELIMITHOST);
+		__ICMP6_INC_STATS(net, NULL, ICMP6_MIB_RATELIMITHOST);
 	else
 		icmp_global_consume(net);
 	dst_release(dst);
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index 6dc06a11e05a..6e8d70b34a7e 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -94,6 +94,7 @@ static const struct snmp_mib snmp6_icmp6_list[] = {
 	SNMP_MIB_ITEM("Icmp6OutMsgs", ICMP6_MIB_OUTMSGS),
 	SNMP_MIB_ITEM("Icmp6OutErrors", ICMP6_MIB_OUTERRORS),
 	SNMP_MIB_ITEM("Icmp6InCsumErrors", ICMP6_MIB_CSUMERRORS),
+/* ICMP6_MIB_RATELIMITHOST needs to be last, see snmp6_dev_seq_show(). */
 	SNMP_MIB_ITEM("Icmp6OutRateLimitHost", ICMP6_MIB_RATELIMITHOST),
 };
 
@@ -242,8 +243,11 @@ static int snmp6_dev_seq_show(struct seq_file *seq, void *v)
 			      snmp6_ipstats_list,
 			      ARRAY_SIZE(snmp6_ipstats_list),
 			      offsetof(struct ipstats_mib, syncp));
+
+	/* Per idev icmp stats do not have ICMP6_MIB_RATELIMITHOST */
 	snmp6_seq_show_item(seq, NULL, idev->stats.icmpv6dev->mibs,
-			    snmp6_icmp6_list, ARRAY_SIZE(snmp6_icmp6_list));
+			    snmp6_icmp6_list, ARRAY_SIZE(snmp6_icmp6_list) - 1);
+
 	snmp6_seq_show_icmpv6msg(seq, idev->stats.icmpv6msgdev->mibs);
 	return 0;
 }
-- 
2.51.0.338.gd7d06c2dae-goog


