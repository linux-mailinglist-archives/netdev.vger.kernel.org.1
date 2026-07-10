Return-Path: <netdev+bounces-306722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c7eZED17UWrQFQMAu9opvQ
	(envelope-from <netdev+bounces-306722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 01:07:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E0C73FB48
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 01:07:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=PApXLIuW;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306722-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306722-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42C03300D1E9
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9B93F927B;
	Fri, 10 Jul 2026 23:07:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5F3F8883
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 23:07:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783724855; cv=none; b=TVDpdruK5WD4ph5q1HtXs4Uu28XQn9sjXPVCD8vrr6p6XyXhy6rjMXjEzFSbrHxfaDBqYDr1ZYZtKz/bLkC6kVtzEOOBOm69r5UTUkB5yf1S46+sx5UjQaYC+tu2+etsk4JQu94AEgfnOCTcHOPYpkKONINs8pfajNC3cJLU0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783724855; c=relaxed/simple;
	bh=lKsYa42aL4Ei336BgabWgnSeHZrvwq4Zr4Q/JLNaa8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOFKHWVhlBFagquvVP2qZGgZIMpcThgHI28bpURC5RQ5dSdXOS51078YHZdXED3dxp6FoHVJGWC2OiEIhDp68/Aplu9IO9NVEqzVf5p2zhvpV24KfCHRQYp3YcbkYegTqsd4X/7nr3UKMKysSJUovHlDC6Pz/DJPYq4IB8ra6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=PApXLIuW; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacd69a9c0so15521155ad.1
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783724853; x=1784329653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WLB8zFNRH3nQr6RoRadithpdPEcyDjfC4QcMcMwhYBw=;
        b=PApXLIuWzSRJfOzOSEWj7pdyljHlSToHjJzLMxv8qhPzDF5msU6xp3qN+oVbl/EsK6
         Ge3FZYOGRX6c14oLDtrPFxvvaEycfjO1f860brey5DKDEE0DzZ3XFKYwPym1kAjxoBPi
         KvOy+a4yRxnODxQY8GpO9gfqFWkj6usAmo4U6erzn1inJCEv43MSTL77MyObkS7ZyKrC
         410YRq0BPHmIloYcFD8x4sQwxLj0EEeaqrlKrQ28r7V93TPhcLtZeQhvyCJUWFtYUWOo
         DS7qDzdwdEEjThG1O/w2G5J7HgrmxeyO6o1llMJ+20+xYc2y5v3Vj4msZYTAaNMpPVqt
         0Iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783724853; x=1784329653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLB8zFNRH3nQr6RoRadithpdPEcyDjfC4QcMcMwhYBw=;
        b=bMJcfD/tV41k06Gcu7FArTII46xdjdHQxSumz2Stgn2nT2AR9E85fLH1W9y4SN0NsB
         2E6OnvY1eBJj5ICxYrIaNJHKO66Kn//ZWFn+eW60MCgxTXkarIKt5Q3T+CMp0tOTXtGO
         WoLr9N9Okn0sv2cvA3YFf//3fVOXtxbjig8hMTrWiIABen/vNFWGtuHSs+xjWKrZGqob
         6TxyYHkb8Laqvq8zlgc3zCG6rntDK2XleZmM1oscI53T0K6zUJRIOY2P/yplygXc6SFv
         ef2fYFyGEW7LVg6gAIIOxRzftWGDlIpK1d3fz05R6tyUapc19xA1k2WxLyWWlMrl0A/J
         8LwA==
X-Forwarded-Encrypted: i=1; AHgh+RoZ1sRb3bgwa9kVioPuAQYj5/F0WBgkX6I7U0nWJImOWSgTXsAu/qq7UgYjrN6zzq8yk9vSy7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxyf/JNeKPlQfbpD0DUhaTiQqPARLWyGG8No3MsiY7kc6SZxJB
	F/gJ5iJbcQ0/LZEHgroVetaWTSCKgS/0PiytUx2kKGFfe+p+BQ3eE3OiTLqraY99WA==
X-Gm-Gg: AfdE7cn1Q8pd5VcaxjvsEgxoyralxW5R3suZPdZskc8CvZX+GpacuOewo8Z0+cRqbYA
	/EezZf1rYL4Sd/FwCOaILS6SdgCjNgrZjYa8GxL2a8c68wlyQPM6XUF0M/fQNwwLGG4scX6FZgm
	NoAuyuK4vS/9CROT129pLOrlJdf/2MMCs/WW1PLDME9h/OKDSH8v8bwjlIL9DT/PuG7fDiC2xCD
	ffK2sUfV8vSBDMBtk5GPPbhJmdhnxqDVCBaMQlTJKOV4mOOTlwof9pa3ABRIA0aiCtZkPdo4MZo
	WwbBPhWSBVzjVyuYHNyQ6x+7UDZWV+JUm7As5aYSloaxV49aODedhx06XjqICaSSsYa01/ZvL3T
	QEf3zO0azJvkjDMM/DKJnirT0QhQZeHAEnpplvWGocFQalDTlLW5RJY0IsP0RWsBrgM6YYndBj3
	Co48g7hf8nzIdAzRCJYg==
X-Received: by 2002:a05:6a20:b7a7:b0:3bf:6edd:9e2a with SMTP id adf61e73a8af0-3c1108bdcf3mr939801637.19.1783724853152;
        Fri, 10 Jul 2026 16:07:33 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm53175028c88.8.2026.07.10.16.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 16:07:32 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH net] gtp: check skb_pull_data() return in gtp1u_send_echo_resp()
Date: Fri, 10 Jul 2026 23:07:24 +0000
Message-ID: <20260710230724.942574-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-306722-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:wojciech.drewek@intel.com,m:anthony.l.nguyen@intel.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E8E0C73FB48

gtp1u_send_echo_resp() ignores skb_pull_data()'s return value. Its
caller gtp1u_udp_encap_recv() only guarantees 16 bytes (udphdr +
gtp1_header), but the pull requests 20 (gtp1_header_long + udphdr). For
a 16-19 byte echo request the pull fails and returns NULL without
advancing skb->data; execution continues, and the following skb_push()
plus the IP header pushed by iptunnel_xmit() move skb->data below
skb->head, tripping skb_under_panic().

Fix it by dropping the packet when skb_pull_data() fails.

  skbuff: skb_under_panic: ...
  kernel BUG at net/core/skbuff.c:214!
  Call Trace:
   skb_push (net/core/skbuff.c:2648)
   iptunnel_xmit (net/ipv4/ip_tunnel_core.c:82)
   gtp_encap_recv (drivers/net/gtp.c:701 drivers/net/gtp.c:808 drivers/net/gtp.c:920)
   udp_queue_rcv_one_skb (net/ipv4/udp.c:2388)
   ...
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 9af41cc33471 ("gtp: Implement GTP echo response")
Reported-by: AutonomousCodeSecurity@microsoft.com
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 drivers/net/gtp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index a60ef32b35b8..f8c7b532b10c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -669,8 +669,9 @@ static int gtp1u_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 		return -1;
 
 	/* pull GTP and UDP headers */
-	skb_pull_data(skb,
-		      sizeof(struct gtp1_header_long) + sizeof(struct udphdr));
+	if (!skb_pull_data(skb, sizeof(struct gtp1_header_long) +
+				sizeof(struct udphdr)))
+		return -1;
 
 	gtp_pkt = skb_push(skb, sizeof(struct gtp1u_packet));
 	memset(gtp_pkt, 0, sizeof(struct gtp1u_packet));
-- 
2.43.0


