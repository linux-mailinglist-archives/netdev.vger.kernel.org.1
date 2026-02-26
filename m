Return-Path: <netdev+bounces-261298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKO7EqAsoGmLfwQAu9opvQ
	(envelope-from <netdev+bounces-261298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:21:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB61A4FBF
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 109B530E3D1F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1D3644B6;
	Thu, 26 Feb 2026 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQvACxiY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6D36656C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104688; cv=none; b=hX+vKfURARlJ8sv0+ijwNWe2RLvXb+J+MrUvLN4vcQM6DtREneSUI15S5rM4LKO9O9KGQ8+oCNcV60xHkrk9Ib+Bhl/KaYn1IADvO2ys9BBnuXeJKn0jWRMAWvhYc4zUGvsjlWLQU1/ph9iSSuJD/yxnH+3oFJr6xqKCUySrHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104688; c=relaxed/simple;
	bh=Tda3X1h6hjXboAEqtey5KSiQRBdK9Kh2CQJXrLYM4X0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmG9prcIZ0bPveivE/juqMCeRS+PZIWISkwd3cKrn7COZe1vvlkYgAV9Ut8ZdoIbuEmdfMh4I/uBBDkOV5E40Xa9Knqg6a+l9b0SMbbAh/ZCbwhpEHHtt/pFwINXH4R3wEeP8K0ivIkWX33ztEpOoDQEg2kjOEJNpliJ0czjobQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQvACxiY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8272c559597so728995b3a.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772104683; x=1772709483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jV7kecYCTzcrsCFjFw3qK5G5qwWc4nsIa+UHPnJX5do=;
        b=FQvACxiYMZI6OIPAnmHZcBTt3ku9aJujLIk9yLB/cOkVKtFKrRfu56+VfrwALwFFtU
         dud4h9PAysP3MwbkCuP89IAdcs/7md4j280wYF1KwgQaoNTmabeRwHTRJ/HiJRypiW2l
         yIGxZKQ2y86Lzn8vhII4ucqwcd3Rg3zxifmOb67NOfEKMG5B6wB/6RQapeyxReCdAbiD
         UC81/fZyEV0NIIRSq3/oRV9picQcnfZNbX43FD6phGzq4umS3rznexd/KoO6sGi9YJfS
         JSUQLUV3o1u/oq3ECRaGe+gntjOZIbdr9hEyQU9qn9OIkhCSOQ3ZTFM/SeKSVfPKl79H
         GgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772104683; x=1772709483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV7kecYCTzcrsCFjFw3qK5G5qwWc4nsIa+UHPnJX5do=;
        b=UD1Gsye3AnEnwBk5eu8pPWafAX4n8u72/Er9Nf9cz8mE1+PY/ljEjfZmkDj8YE+48R
         VZNaBE442MeZG5Z2lxNuaflWPZ/enQAli1BLc0GEH5YFYTxtvB+XV9zZOcELHay7DN8A
         TxkvQgloQAByQ7lQPjZ4fF5WGY4AOohpGAKbPA/tfnVRxjafUavg+U6A0HRq8gsT/7pP
         fieK7RtD9BqyrZQhQvQVWBQ4jzvNpiwdSZkSfTHZ5OyOuQX3DJVGz6bwawHTjn1o+Tv6
         ZpSyUVsUWEq4N2upNlC5Ws1yPebMBLM25bS2Os7J1Q6L0XrbRRbhBTYW7Ekg2l9G9pF/
         yR/w==
X-Gm-Message-State: AOJu0YxDC5z4jRfgfwF8o73nJAiP8Hw6+iXf1PBpmQQQn2R+/b4Enic4
	O+o/Hy1sYAnv/xJdjn2A/0bFu32/3KZZ1xdmQeIq+KrOoK+kCeMGqPwZ
X-Gm-Gg: ATEYQzyFjnMsGxLijZC4vPmsXoSHwTqFTvnLzgadhvXKpp0VAjF+2XIf456Lo16429B
	hrMvkTaE+rB8Rqr6cOWHp73aPTSmH8RyPKw2FU8aHi90LPb+1qaGTFf2pu6EIoxi2bef813jLll
	mKnnxkjuj1T70XoIoETVWHh7LdQI6P6FCtpr/48vs31pGJPdVFpm1q20+HcrQJFDc1yTU02VcwR
	lk2YYyheEN8CsgrNoJQPJz/ohCbu6cgs4tYu3wK5KORIkLsrIiCLdNy3vpGiy4E5VpTUhxPX/2L
	bV55FzvRfJpLCAJ3QARgdBuambv7R0+i2rbH6rTHCTxyDJ5OyFFncEfpG6u820E+CfVezyOGpEn
	C5bi0pa690cAOSYO9Zz2hsANcRFKtmihmTD30zkxXQfvKOSkWb6TAJkjcWgxYTk5siel09HBOdN
	jBV+NIttX4kYGqnZEx7bxupektyupubAjMUAbs4z++aH5kiD8r7W+xz4NkPbq5TpFNuYBOKmrWh
	URP2PF+mgwun/9vxBbEsLyzpF5tM39DBr389F6u/CpNAiCrwiyOcdy+mZYpKFEnqaG7IZJJl2M+
	xtRhRTyywQ==
X-Received: by 2002:a05:6a00:3e0b:b0:824:a81e:97b5 with SMTP id d2e1a72fcca58-8273bfa235emr2041811b3a.38.1772104683383;
        Thu, 26 Feb 2026 03:18:03 -0800 (PST)
Received: from yuu-U24E.. (2001-b400-e3d7-38de-fa71-5111-1751-cb7a.emome-ip6.hinet.net. [2001:b400:e3d7:38de:fa71:5111:1751:cb7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a088517sm2110831b3a.65.2026.02.26.03.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 03:18:02 -0800 (PST)
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
Subject: [PATCH] net: ipv6: fix ARM64 alignment fault in fib_multipath_hash_from_keys()
Date: Thu, 26 Feb 2026 19:17:21 +0800
Message-ID: <20260226111721.25454-1-yuuchihsu@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-261298-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B9FB61A4FBF
X-Rspamd-Action: no action

struct sysctl_fib_multipath_hash_seed contains two u32 fields (user_seed
and mp_seed), making it an 8-byte structure with a 4-byte alignment requirement.

In fib_multipath_hash_from_keys(), the code evaluates the entire struct
atomically via READ_ONCE():

mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed).mp_seed;
While this silently works on GCC by falling back to unaligned regular loads
(e.g., LDR/LDUR) which the ARM64 kernel tolerates, it causes a fatal kernel
panic when compiled with Clang and LTO enabled.

Commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire when
CONFIG_LTO=y") strengthens READ_ONCE() to use Load-Acquire instructions
(ldar / ldapr) to prevent compiler reordering bugs under Clang LTO.

Since the macro evaluates the full 8-byte struct, Clang emits a 64-bit
ldar instruction. ARM64 architecture strictly requires ldar to be
naturally aligned. Executing a 64-bit ldar on a 4-byte aligned address
(e.g., ending in 0xEC) triggers a strict Alignment Fault (FSC = 0x21).

Fix this by moving the READ_ONCE() directly to the specific u32 member:

mp_seed = READ_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed);
This instructs the compiler to emit a 32-bit load (ldar Wn or ldr Wn),
which perfectly satisfies the 4-byte alignment requirement and resolves
the crash.

Fixes: [4ee2a8cace3fb9a34aea6a56426f89d26dd514f3] ("net: ipv4: Add a sysctl to set multipath hash seed")
Signed-off-by: Yung Chih Su <yuuchihsu@gmail.com>
---
 include/net/ip_fib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.43.0


