Return-Path: <netdev+bounces-238421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D49C588CB
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CA3C34DA13
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9C02F363F;
	Thu, 13 Nov 2025 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dTOZUvwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F72F12D1
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048752; cv=none; b=qdkEKRJ0kc/IPWdhSS6e8dTOnUtvI1g3fMFd2wLw5bW8xca8s5+uJ42K0Jtw0llZTdx3agxehD9hHmoEK6CeE0oqk0zBOFnPGZN9SZAXVx/uTXf9KU0CI9+f8dwmoNlBD8BizR8spDOu5ZkoRTE++sv/o1jWIvRIeb0BOuAkuDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048752; c=relaxed/simple;
	bh=iCOgKpIlWHaK+2kiT271clXRT63k6oSVDGcj03I5Wdk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tzJXl1cQZFT2hrj3YUUpjuN6aFCU1nMJQ5WyAdmxCgEurGqmCaLAAZFyX1W/fdOn/E/7DO/PvAONDaoQd/eoSeqO1SDxIhqCWGBKGIlZSCeHRkRBDXuxxoJLEwv1XBa3b0X3ALBFwxYdjX+Y14J2EoXh58JOSfwwzHE4kNsxMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dTOZUvwU; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88238449415so47841536d6.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763048750; x=1763653550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aMCtaSZTkzipqXr640E29rQ4+ntMw4/o/aQIQte0hk8=;
        b=dTOZUvwULkpBz7RG/1sevq0CLcSYpdsiyJ4hgiLSStEVrEY/GuVCYhnRvuvReaWSDA
         i5mKFlbRm00oOMFGUpU6zxWRUzOsULqp/VOoInmKmS1UTY2zGMJjEAjIcubg4lFsdO+k
         1ZOM2LH8m125SWOXJ4pOMaIIcnWX2BxfjGPjybuVJI2MURzKiNSnUx7jEHxyxwuVyOdF
         sZprAjEmpXRymgPm7j8mg3hsEKHx11XZatdrrF5E7ZjflOKtpbmomV0MrEldT/aWB+Ef
         tF1Xcmwq/CoHxLjpy++6jUHhp0SPqJqnF7cTpizGXmfJu2VZGrXC6W0r8zbyeOylY8r5
         oNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763048750; x=1763653550;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aMCtaSZTkzipqXr640E29rQ4+ntMw4/o/aQIQte0hk8=;
        b=XaAI9c+7/D8fFBhuNtTB4jeXHVRgSdL9GtppFX5GcsI7QZERfR4SwKmaLzLSW54NG3
         QRyHpV7fJokbjKqxpE91qeQ2Z+GmP8vx0b5xK5oslmNJbMl0YeeW+57QMYuMWsUg5RQu
         LXtw/yvHGmwzcn8LSNrFLIK224kbNgDPqzXgzbHXCWssxrrZsGnl4TDEM4PZdxVSv3KP
         uWim9dOvwDhKaY1U1oxoj4vF2i7A7rDscgyk9PkYNYse4YbUb5GUqYVcwNY/JCBhMExz
         WOsJ59FCiPjiMb7BTCaw5vZd41ZvtDs9q9UojKFPZ2o9Trwi4oSiYv3L1iCLHi4H9zD0
         9R0g==
X-Forwarded-Encrypted: i=1; AJvYcCVboVllY6yyu/B2P0oUsVMrOauxLGWIdapYCG3bwLFIcOayowxj/yyF21Zh9StJpKFPCeUslQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu46EQIcH7t9lDLv7VPwn9iJB3ipp11RBZtrkQNv6OA8g2TjJh
	YVRTYddJnWDfGDTuI8mQ0VrJggJM7exApORjhaocO2k4DeDjznynRKlCdDUrb7kj2FX2al0MQzj
	qHzRSHBBRtY6YPw==
X-Google-Smtp-Source: AGHT+IF36p0PhkgE+zhcfmB5dD983XZpGkIXaJGToz+oxmcjo9H79ixj6u3F1jHrlPq85X3F/8RV6CKYloNjDQ==
X-Received: from qvbmf19.prod.google.com ([2002:a05:6214:5d93:b0:882:4972:afd9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:19ca:b0:880:51f0:5b8a with SMTP id 6a1803df08f44-8827191f7f1mr103271916d6.15.1763048750104;
 Thu, 13 Nov 2025 07:45:50 -0800 (PST)
Date: Thu, 13 Nov 2025 15:45:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113154545.594580-1-edumazet@google.com>
Subject: [PATCH] x86_64: inline csum_ipv6_magic()
From: Eric Dumazet <edumazet@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Inline this small helper.

This reduces register pressure, as saddr and daddr are often
back to back in memory.

For instance code inlined in tcp6_gro_receive() will look like:

 55a:	48 03 73 28          	add    0x28(%rbx),%rsi
 55e:	8b 43 70             	mov    0x70(%rbx),%eax
 561:	29 f8                	sub    %edi,%eax
 563:	0f c8                	bswap  %eax
 565:	89 c0                	mov    %eax,%eax
 567:	48 05 00 06 00 00    	add    $0x600,%rax
 56d:	48 03 46 08          	add    0x8(%rsi),%rax
 571:	48 13 46 10          	adc    0x10(%rsi),%rax
 575:	48 13 46 18          	adc    0x18(%rsi),%rax
 579:	48 13 46 20          	adc    0x20(%rsi),%rax
 57d:	48 83 d0 00          	adc    $0x0,%rax
 581:	48 89 c6             	mov    %rax,%rsi
 584:	48 c1 ee 20          	shr    $0x20,%rsi
 588:	01 f0                	add    %esi,%eax
 58a:	83 d0 00             	adc    $0x0,%eax
 58d:	89 c6                	mov    %eax,%esi
 58f:	66 31 c0             	xor    %ax,%ax

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 arch/x86/include/asm/checksum_64.h | 45 ++++++++++++++++++++++--------
 arch/x86/lib/csum-wrappers_64.c    | 22 ---------------
 2 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 4d4a47a3a8ab2310d279f7e465032b1463200393..5bdfd2db2b5a573ff8193a4878d372c97b158f47 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -9,6 +9,7 @@
  */
 
 #include <linux/compiler.h>
+#include <linux/in6.h>
 #include <asm/byteorder.h>
 
 /**
@@ -145,6 +146,17 @@ extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
  */
 extern __sum16 ip_compute_csum(const void *buff, int len);
 
+static inline unsigned add32_with_carry(unsigned a, unsigned b)
+{
+	asm("addl %2,%0\n\t"
+	    "adcl $0,%0"
+	    : "=r" (a)
+	    : "0" (a), "rm" (b));
+	return a;
+}
+
+#define _HAVE_ARCH_IPV6_CSUM 1
+
 /**
  * csum_ipv6_magic - Compute checksum of an IPv6 pseudo header.
  * @saddr: source address
@@ -158,20 +170,29 @@ extern __sum16 ip_compute_csum(const void *buff, int len);
  * Returns the unfolded 32bit checksum.
  */
 
-struct in6_addr;
+static inline __sum16 csum_ipv6_magic(
+	const struct in6_addr *_saddr, const struct in6_addr *_daddr,
+	__u32 len, __u8 proto, __wsum sum)
+{
+	const unsigned long *saddr = (const unsigned long *)_saddr;
+	const unsigned long *daddr = (const unsigned long *)_daddr;
+	__u64 sum64;
 
-#define _HAVE_ARCH_IPV6_CSUM 1
-extern __sum16
-csum_ipv6_magic(const struct in6_addr *saddr, const struct in6_addr *daddr,
-		__u32 len, __u8 proto, __wsum sum);
+	sum64 = (__force __u64)htonl(len) + (__force __u64)htons(proto) +
+		(__force __u64)sum;
 
-static inline unsigned add32_with_carry(unsigned a, unsigned b)
-{
-	asm("addl %2,%0\n\t"
-	    "adcl $0,%0"
-	    : "=r" (a)
-	    : "0" (a), "rm" (b));
-	return a;
+	asm("	addq %1,%[sum64]\n"
+	    "	adcq %2,%[sum64]\n"
+	    "	adcq %3,%[sum64]\n"
+	    "	adcq %4,%[sum64]\n"
+	    "	adcq $0,%[sum64]\n"
+
+	    : [sum64] "+r" (sum64)
+	    : "m" (saddr[0]), "m" (saddr[1]),
+	      "m" (daddr[0]), "m" (daddr[1]));
+
+	return csum_fold(
+	       (__force __wsum)add32_with_carry(sum64 & 0xffffffff, sum64>>32));
 }
 
 #define HAVE_ARCH_CSUM_ADD
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index f4df4d241526c64a5ad2eabdcbf5f0d8d56d6fd8..831b7110b041598b9764a6647fa259e1058efef2 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -68,25 +68,3 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
-__sum16 csum_ipv6_magic(const struct in6_addr *saddr,
-			const struct in6_addr *daddr,
-			__u32 len, __u8 proto, __wsum sum)
-{
-	__u64 rest, sum64;
-
-	rest = (__force __u64)htonl(len) + (__force __u64)htons(proto) +
-		(__force __u64)sum;
-
-	asm("	addq (%[saddr]),%[sum]\n"
-	    "	adcq 8(%[saddr]),%[sum]\n"
-	    "	adcq (%[daddr]),%[sum]\n"
-	    "	adcq 8(%[daddr]),%[sum]\n"
-	    "	adcq $0,%[sum]\n"
-
-	    : [sum] "=r" (sum64)
-	    : "[sum]" (rest), [saddr] "r" (saddr), [daddr] "r" (daddr));
-
-	return csum_fold(
-	       (__force __wsum)add32_with_carry(sum64 & 0xffffffff, sum64>>32));
-}
-EXPORT_SYMBOL(csum_ipv6_magic);
-- 
2.51.2.1041.gc1ab5b90ca-goog


