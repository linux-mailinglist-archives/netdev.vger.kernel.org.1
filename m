Return-Path: <netdev+bounces-262518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EI/EyEopWla4wUAu9opvQ
	(envelope-from <netdev+bounces-262518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:03:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A251D35AE
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0742300071B
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0195375ADE;
	Mon,  2 Mar 2026 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7qPq3QZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C233C32572D
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772431388; cv=none; b=izdOPxZovVjPi8MPWJpr8/OEnp3/Za2McTr1HraNCiFyL1d0gQuVgzC6uxj2YHiGrHJqF0iCYDawLnwFQo3vogykofku0ninnOIUgA/z3AoET4R5jFJX+kB4UI+LjPMAAzdZlg8eCtTx9lInLQ0GEmhxSP1XfY9zrCbZ6e0oQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772431388; c=relaxed/simple;
	bh=UMbmZ++93Ph/NbVyX9t23zZtrAjeMmfIxj4l+jZAYNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtDD/zD2cIr8aHdBUHoCYz2y1JtmdryK3G4nKckWtxpQVqmYnw7Cx/fL0Fe+jj+zzDCGIYSd5BtNb/qqAz/dPppmNKwKYCC9U93KGoR8tddjBqp3uEosFEFYMrufTM68maX1DK2Z2negD1wkdHorHo3zSSdE7DK+uQulUjtoi1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7qPq3QZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824a3509a12so1808608b3a.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 22:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772431381; x=1773036181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wSCMIgFyPDN8ZsWOziBhAMpjDkgcKvVXQMlKIyyHF0=;
        b=c7qPq3QZqfTWYiVrpTlnQ4EUA8LeutFk2nliRNCIEc85lyNKk73QTD1OLZ7cl7X4zN
         VCwlU3ZhZbKcs8r8nKZ98jqrXlWcGvCvXHhxA3BUCQugAMYUo7JgtU01MhtlQCbi/4hN
         TRCXJiu0aeF6GcNzWbnNQWEiqtHvBOyi53wT1dbRo9UJCJ9r8hZk+MuQjsPIyAROFZRs
         3mEtCxiie91SlVNrZ7XRb8EfF6xMFjuXAtPx3x5V1FA9vfaRv0+3tvTQb2rNPLq5yVMJ
         IhqFhpf1wio36ZN0lP73E3oSvGkZIr6PaYH/JKM7M6w7E7M8tX7/Ql5kMrB8T+JAvzHd
         BhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772431381; x=1773036181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wSCMIgFyPDN8ZsWOziBhAMpjDkgcKvVXQMlKIyyHF0=;
        b=I99TCUsF2EcvTmhWIzkxgIOVc3uPBy3COKhqgco9tAumqbom3T9Eh9/NWb8io/Qewj
         qQh66QFz5AvykLuzVFwzjJoSRhTNOtvvucsx6Fdm+b0UzEXe/qfJqjzYMdSz15uDQ9DU
         KJJrCbsBKmVGBQ6DY9GTWawRtoStqyTcT52z5GKNZt30DSgDBYmZe6vKzqml9t2xYRo7
         3J8RJ5xU0TVsut+BS5CYZfocqgLlgRbtQ8gyn8olxcSMY6+ef8i9n3I1uo4Yby2hgF00
         lB+gb0pSW/vAyxQYUrgyea/RjmIdcbs3QAEpeKuPReunMTvStrei7vy5cGAGcdzUxyvp
         rYXA==
X-Gm-Message-State: AOJu0YwhhfFzIv0wLLy61Xz85FkhfEQFX5qHiy78obCzSdhAzmns9aSg
	3taM+s26ZudelC11beCRo/kUDEjQ0kkpzXGNtzptWSJMA/zNG1A7AmyL
X-Gm-Gg: ATEYQzwzORTATCmJgwXOKH6Ok6RceVwCen71BmoSDkShnmG2R9KGAgLJLZNEeFanj4S
	hxJeEcgA15dmEcIRp7GzdK6nWwflvGpwGt2ZLFMLjdeVmrdzBQuqtpZPgpb+JEsmC6DIatl0BNJ
	59Aty3GLIKH4EwLItW2WxpaG2qXED/tBZHK+yc2M627KUObjBUlopZJQjBRH1WCK1qvLJ08kM81
	4TkkXzXz68ScOrL9cNz0wcwIdh7sukgT0CCNQTQ82dPqo4xnujiA2l2uLRd7jhSUYoZse5O7lRP
	Nx91hTNR4Fk2Z+PbhB4Yx3AqjU/yuxi0ez3lf6Q35KQvHUhSSR+UP3TNe9p2AGI1IAonew6KH7J
	kBdgBJPl/ni1wzZRWsBPuQVDnzZQzaiOiZUpFpvQo1/qDU+Vgc99OzLyZRgqEKitKvAZIaJjrE4
	CzNQjtAi00s4DGr5gGzrHkoayjJy7MrrvEeCK4H4jNG24M/VMBj1jA5oGXBmSFPv7wrXRJhz78B
	EU9qSUt4PXajE/2hfwKlz+N/+mQPY2k8oG2LWLVbYjIq+3V8bU+HipPDrP4VsaVg3fgWyLmseUy
	GMBSXGssxA==
X-Received: by 2002:a05:6a00:bc83:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-8274d95b7f0mr8512139b3a.16.1772431380848;
        Sun, 01 Mar 2026 22:03:00 -0800 (PST)
Received: from yuu-U24E.. (2001-b400-e3d7-5aaf-ef7e-1255-80c7-27e1.emome-ip6.hinet.net. [2001:b400:e3d7:5aaf:ef7e:1255:80c7:27e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a060331sm11521915b3a.62.2026.03.01.22.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 22:03:00 -0800 (PST)
From: Yung Chih Su <yuuchihsu@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Yung Chih Su <yuuchihsu@gmail.com>
Subject: [PATCH v2] net: ipv4: fix ARM64 alignment fault in multipath hash seed
Date: Mon,  2 Mar 2026 14:02:47 +0800
Message-ID: <20260302060247.7066-1-yuuchihsu@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-262518-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuuchihsu@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7A251D35AE
X-Rspamd-Action: no action

`struct sysctl_fib_multipath_hash_seed` contains two u32 fields
(user_seed and mp_seed), making it an 8-byte structure with a 4-byte
alignment requirement.

In `fib_multipath_hash_from_keys()`, the code evaluates the entire
struct atomically via `READ_ONCE()`:

    mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;

While this silently works on GCC by falling back to unaligned regular
loads which the ARM64 kernel tolerates, it causes a fatal kernel panic
when compiled with Clang and LTO enabled.

Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire
when CONFIG_LTO=y") strengthens `READ_ONCE()` to use Load-Acquire
instructions (`ldar` / `ldapr`) to prevent compiler reordering bugs
under Clang LTO. Since the macro evaluates the full 8-byte struct,
Clang emits a 64-bit `ldar` instruction. ARM64 architecture strictly
requires `ldar` to be naturally aligned, thus executing it on a 4-byte
aligned address triggers a strict Alignment Fault (FSC = 0x21).

Fix the read side by moving the `READ_ONCE()` directly to the `u32`
member, which emits a safe 32-bit `ldar Wn`.

Furthermore, Eric Dumazet pointed out that `WRITE_ONCE()` on the entire
struct in `proc_fib_multipath_hash_set_seed()` is also flawed. Analysis
shows that Clang splits this 8-byte write into two separate 32-bit
`str` instructions. While this avoids an alignment fault, it destroys
atomicity and exposes a tear-write vulnerability. Fix this by
explicitly splitting the write into two 32-bit `WRITE_ONCE()`
operations.

Finally, add the missing `READ_ONCE()` when reading `user_seed` in
`proc_fib_multipath_hash_seed()` to ensure proper pairing and
concurrency safety.

Fixes: 4ee2a8cace3f ("net: ipv4: Add a sysctl to set multipath hash seed")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
---
v2:
  - Split WRITE_ONCE(struct) into two 32-bit WRITE_ONCE()s in 
    proc_fib_multipath_hash_set_seed() to fix a tear-write vulnerability.
  - Add missing READ_ONCE() for user_seed in proc_fib_multipath_hash_seed()
    per Eric Dumazet's suggestion.
  - Update Fixes tag to use the standard 12-char abbreviated format
    per Jakub Kicinski's suggestion.

 include/net/ip_fib.h       | 2 +-
 net/ipv4/sysctl_net_ipv4.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index b4495c38e0a0..318593743b6e 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -559,7 +559,7 @@ static inline u32 fib_multipath_hash_from_keys(const struct net *net,
 	siphash_aligned_key_t hash_key;
 	u32 mp_seed;
 
-	mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;
+	mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed);
 	fib_multipath_hash_construct_key(&hash_key, mp_seed);
 
 	return flow_hash_from_keys_seed(keys, &hash_key);
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 643763bc2142..5654cc9c8a0b 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -486,7 +486,8 @@ static void proc_fib_multipath_hash_set_seed(struct net *net, u32 user_seed)
 			    proc_fib_multipath_hash_rand_seed),
 	};
 
-	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed, new);
+	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.user_seed, new.user_seed);
+	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_seed);
 }
 
 static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
@@ -500,7 +501,7 @@ static int proc_fib_multipath_hash_seed(const struct ctl_table *table, int write
 	int ret;
 
 	mphs = &net->ipv4.sysctl_fib_multipath_hash_seed;
-	user_seed = mphs->user_seed;
+	user_seed = READ_ONCE(mphs->user_seed);
 
 	tmp = *table;
 	tmp.data = &user_seed;
-- 
2.43.0


