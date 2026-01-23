Return-Path: <netdev+bounces-252879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN90KGSgc2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:23:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F177786CD
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC7BC302F680
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C0C2D3A89;
	Fri, 23 Jan 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5lxFDcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931672E2F14
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185352; cv=none; b=mMwWwgdGqs2Ja+ZoXtvIMkaU7gbvPBnsaPCOIxk0PJ8nzjCnkgTmaODYWwKC9iXjTAEU0v+HKPttd6qHJdWc21d/kwJ6KYisVwRTV9QOVYaHx83E+zC4ZFXLjwlTKDj0OnGV12n0y5aBcYUt3luAKvV2mJB4rGOEVm7ZJAomvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185352; c=relaxed/simple;
	bh=CWAmd2gDO+bz+iiUcK+EZ5ZuNzlcyN9HRHG8OTxXoro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAMfAZLcVDZyuYvrRTPLsY45YNCg+AhD8nzsZ9geXBj+vmOuJDR48rWgJg5H9m2TBWtfw+mKdWrqYg3/tprsGazxKeoaCCKYqqo/irp2GLaboBtiYt0LEuOHLMWWxj8xog1WT2uQzRJM/jz1U4JcXrFCS8YJG+Zvkt9Dg1ZyYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5lxFDcV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso1575195a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185351; x=1769790151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v74RSchMzcO/nfO8KMHLNyi6DHe8JbEgv9uztbjT94=;
        b=Z5lxFDcVKbEg3CXyyUVQO1roqDKC76Pbn1gu3txOpP8wnDbuEQCE8Hqds2uS3gNic0
         U+ZBe0SOrRvQLRt9nRuffQew107wk42pDDuoMzSES6a0iA0SLxLcCExVN2WeTcZ++W7s
         6VlPOGaJy5GxJ2szjseJY1xqr+63t02Y5ibox3HSnTWG1C9YV6OdzhNuRhrCe+BcLbWw
         e/lSkCnyJZ96jYd80B42dZpMpssAixKlwR/PAA3dZY6FsWh6VMBNafNmEGoQ6wyfkpbP
         akVaSFxH6vhE3Q52htexu2GQdGolMzxjzOTnyMcEyw7djSwloXnWibIBtf1pFyqhepCN
         CvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185351; x=1769790151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/v74RSchMzcO/nfO8KMHLNyi6DHe8JbEgv9uztbjT94=;
        b=A6YXp7gyGz/O/HUApHkByLhPTyMxBPkpphpBiurJ/jO1B25fED7vDUxYTQmsAkNnh+
         Tw750DMmDbHj3eORL3cpELtoFY2E4b5/NadrzBqlK3ddUamaBketQfGY03cYbeuU+FjJ
         crt0FgVwU1tuNqqyFWMYe2ry8tfltqPit0r9bezA67JoihQK58pscal0qr/KYt2YJgML
         zt0OmJBlgnwbuZ6TD4P0pSIECXUnya1zaW8POYc+F1xMGiybr1qm0QQsjWGDw28+LSMu
         AaFbvEkoOMWryt2QaN3hUMO+W62t1cD/3y3W7MYUF5TJhL8gC3hWzacrWe7OCI6YzlHn
         kcAw==
X-Gm-Message-State: AOJu0YzStDIhp8ZL7GZdYeFyvtU5V3k2/EyI4xDrxoUlSwHsViRTBIXm
	Va6ZA0H/0JIy12kfxPwiS4y8u7uxiXwJEvLxNVhe8i68RBHSkbJ1sxrOfph8+w==
X-Gm-Gg: AZuq6aJD96G7dPdPKLgsF3vktJFbI0cxhc5GKtlpwYSHoXj2PEs2W1wdIouwFRCWidB
	wznvBJHp3i3SM6l8Q6DRzVlFAdfgF+unsel7ETrHtXpzDmUfR7BGo/dSqd4PWtzNdEEe/F7hT/O
	6383LMJjKa4WpGi//YGxjk/bLtURJWrDbRW8oLXDgkJ3olMLZKKe5SihLjUY7q/Ufo9YXzKMNFd
	YkoTE/CiZGgsrrd2KqhwFdORUmmFmi4hAIOlNFvKXbYhMlH0p/4GUUFziZLrh1qP2nHmlunAyiP
	SfSrzc0IgpM/lZ+4Repxcml80pe7n5hg+i+GiFXNnF9AxxL9p09zBXK5Y0XT6vePZdBSIoqu1+R
	8+TKsbGK4qJbtm+ibrMa6IZLWedK5YHy1DgcJBKTfv7zjE2OaWWiwRz+b3dBYTltw3EUXf9fr7E
	x9y6F9raXxt/RmpRndKtfp0k2ppcdV0FWfxUgs1qA8hppScqvI6Iy52mGB8K11vo0u
X-Received: by 2002:a17:90b:548d:b0:353:38b3:dccf with SMTP id 98e67ed59e1d1-353688574f4mr3025512a91.23.1769185350618;
        Fri, 23 Jan 2026 08:22:30 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:29 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Breno Leitao <leitao@debian.org>,
	Carolina Jubran <cjubran@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev,
	dev@openvswitch.org
Subject: [PATCH net-next v2 2/7] u64_stats: Doc incorrect usage with plain variables
Date: Sat, 24 Jan 2026 00:21:34 +0800
Message-ID: <20260123162159.2877941-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,nvidia.com,ovn.org,fomichev.me,debian.org,vger.kernel.org,lists.linux.dev,openvswitch.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-252879-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F177786CD
X-Rspamd-Action: no action

On 64-bit architectures, u64_stats does rely on the load/store atomicity
of 64-bit data.

However, users often mistakenly believe that the helpers could also
protect/"lock" plain (64-bit) variables, which can lead to load/store
tearing.

Remove the misleading "non atomic operation" comments and add explicit
examples of incorrect usage.

Users may also be tempted to use memcpy() or struct copying. Doc the
usage of u64_stats_reads() for this case.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/linux/u64_stats_sync.h | 41 ++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 15ea4db2a77b..10f988170e51 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -39,21 +39,44 @@
  *   spin_lock_bh(...) or other synchronization to get exclusive access
  *   ...
  *   u64_stats_update_begin(&stats->syncp);
- *   u64_stats_add(&stats->bytes64, len); // non atomic operation
- *   u64_stats_inc(&stats->packets64);    // non atomic operation
+ *   u64_stats_add(&stats->bytes64, len);
+ *   u64_stats_inc(&stats->packets64);
  *   u64_stats_update_end(&stats->syncp);
  *
  * While a consumer (reader) should use following template to get consistent
  * snapshot for each variable (but no guarantee on several ones)
  *
- * u64 tbytes, tpackets;
- * unsigned int start;
+ *   u64 tbytes, tpackets;
+ *   unsigned int start;
  *
- * do {
- *         start = u64_stats_fetch_begin(&stats->syncp);
- *         tbytes = u64_stats_read(&stats->bytes64); // non atomic operation
- *         tpackets = u64_stats_read(&stats->packets64); // non atomic operation
- * } while (u64_stats_fetch_retry(&stats->syncp, start));
+ *   do {
+ *           start = u64_stats_fetch_begin(&stats->syncp);
+ *           tbytes = u64_stats_read(&stats->bytes64);
+ *           tpackets = u64_stats_read(&stats->packets64);
+ *   } while (u64_stats_fetch_retry(&stats->syncp, start));
+ *
+ * Remember point #2: update_begin()/update_end() and
+ * fetch_begin()/fetch_retry() are no-ops on 64-bit architectures. u64_stats
+ * _cannot_ be used to protect plain variables against tearing.
+ *
+ *   u64 stats64, cnt;
+ *   struct { u64_stats_t stats[10]; } st, buf;
+ *
+ *   u64_stats_update_begin(&stats->syncp);
+ *   stats64 = cnt;  // no
+ *   stats64 += cnt; // no
+ *   stats64++;      // no
+ *   st = buf;                      // no
+ *   memcpy(&st, &buf, sizeof(st)); // no
+ *   u64_stats_update_end(&stats->syncp);
+ *
+ *   do {
+ *           start = u64_stats_fetch_begin(&stats->syncp);
+ *           cnt = stats64; // no
+ *           buf = st;                               // no
+ *           memcpy(&buf, &st, sizeof(st));          // no
+ *           u64_stats_reads(&buf, &st, sizeof(st)); // use this instead
+ *   } while (u64_stats_fetch_retry(&stats->syncp, start));
  *
  *
  * Example of use in drivers/net/loopback.c, using per_cpu containers,
-- 
2.51.0


