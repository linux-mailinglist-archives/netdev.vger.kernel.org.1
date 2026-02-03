Return-Path: <netdev+bounces-256044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPzuJDdGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:49:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C1FD323C
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E564A30293E8
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851701391;
	Tue,  3 Feb 2026 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="ALT8ToTP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AB214812
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079762; cv=none; b=tbhUzwyXCymBlaGorg+8+f1A8+fqPuIeOIYqwqGYEz+2ndREA96FvF/VfgB404C8zYtdrTwcZFMdFmr6Lnm0ipZ+U2IY5aN1E6MhHp3UqjjnhOFHKSytVnXABcitQKW9w1K1Bt7iaSm5RyVrWUJC3fWWHywS+L5MA7yADb49ExI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079762; c=relaxed/simple;
	bh=/W2h7qSrJKD95QsxjmbKLwHiCyH7RA6BX4Ejs6Czpsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jew4yClH+LZp25GZ3Su1An7ba5kXnrUGd/d9NLf3jakBxpdcU6Wms6HVJOFbLDOpgPgb51BKqcJq5yZtub7/a55bpxyJ+gZt88S9LH4NcFEvc5d6gBt1ul4rw6Rl4ag+A8I7VsBOYZyAnAFivcH8hgiD+wKZDPuaLBTDANKR0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=ALT8ToTP; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-11f36012fb2so5961446c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079760; x=1770684560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=ALT8ToTPYpqvq4L+gVpQwAy3wpBeb1w4NDPJ0McN1pXyx1qvqNHO5d/H/hPkXFoaE+
         Av8GWl9q8TwFckbFRoaYzWxOELJQU4Ln2wMbe/a68lFXJktkMHXDyc48IauaozvJe3gu
         v9THxzsqbnIrlf9kLfD5q0auze4T1NetKtPKwkfwHPTg1kVMI9kNAEU5JWmUYnnA5/yT
         FsugTOjELR96t1s8+DaUIPANkTLYj4eNJgxR37nI96XNXyIlUbixiNhoCFcm7lQ1X+nR
         zgurrkLxeJjvol1j8YWJyPbVZ0LtCEetqJX0qZQggUYK1SqHNmYJC/l9vR+PiDwz4Up1
         u/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079760; x=1770684560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FstFq72HN4LsI2mBA0U2uqbzUPh2nVAMeGBt+tKiwDE=;
        b=PI+iLy4tFisTPTSzxUd59E1sum7Cf5yIW7u7v62+8smLKvfdFwKJHTAQ24c20HQwd5
         IcOUy4smcwHMOn8lPFJNrHtth/aKj0JZCOMWM+c98qrPYgmA2+pfKIFJvqsMPdWE7rj1
         JoX2QJjPU1Z2cD/IpeHELJCptZbLCj4IUd0dRaTwZxJarTFVNO388R6PctLFbN/TTm65
         Nu0BZPS84M6iT7Wkjmn6VJDICCT257+E5X4Orsz5yJSlBOioYDjL7qTcEH6D+vWfoQsk
         xhaqbYCMYikCWkBos+cgjbnPhal53Kyq4eM90Uo2NKsT44OjNryk1g4/ntakLObpbZTx
         GtWA==
X-Forwarded-Encrypted: i=1; AJvYcCVuTm8luIY+YqpDR2q57jGIXb82O/jS+J8Y5Xr1WYV5W7XSEXNYyGueY2klGervnse6ZvnHQS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkiIe3iw5S/Lj1nZAH1F1jILausyqq6zcbsqd2ltC35ksS2k1H
	tVEYGntiCeEP4wQnqEuxe0OSqhORdV/+Y6it7HvqddUngCPMjiOH1WkB4DcuINw+GQ==
X-Gm-Gg: AZuq6aL2b7ZEDAWDBWYJKy7h8szh8qa3M+yvGCAzibgv4gxSZWF2rw17FOSDquEbZYQ
	UGkt9Ht+Q6bo/NohmDw3M9vHSmRguFn4PV34Xot5n6ek66AzxGfAT+2dHKI1E1j7wgN0GYSALNo
	MNcQ/cf0xs/oB7sVfYnPHgHAw7Ptx2j3AuEQusCVuclGuFtzBEkyoXYQ8TqGPdLsHW/0rK3LMTa
	C/gGW4rAHZYoLZU6D4i7eOK6/09kTtEaGbnR8akZ1a4oKztQHQQElF6drv4dQJVfdOwo8p0ZLn7
	NPMrSSxrBzxP18BY0zJEWJ0otDLaV6KtZelRZJA2yP1YyuuzQ8ChebF6bN1XBBzLXv1Fkmr+qVN
	R0U4BT4FANeUyPH5nSkGKmfmM5scB/CWuVVAq6CmqsWLZblTVBbIfC/0TrdVwEEfwIwqb2PMVVH
	Ji4//AYp/4IaSxwvUzZC1mEZidvdFeGQ6ixx5gphM7FAeKnTC78O4fjVKQ
X-Received: by 2002:a05:7300:8ca2:b0:2b7:befe:3743 with SMTP id 5a478bee46e88-2b7c866cf6fmr5684080eec.18.1770079760117;
        Mon, 02 Feb 2026 16:49:20 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:19 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>,
	Justin Iurman <justin.iurman@gmail.com>
Subject: [PATCH net-next v6 02/10] ipv6: Cleanup IPv6 TLV definitions
Date: Mon,  2 Feb 2026 16:48:45 -0800
Message-ID: <20260203004853.94438-3-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
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
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[herbertland.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TAGGED_FROM(0.00)[bounces-256044-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6C1FD323C
X-Rspamd-Action: no action

Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
of the TLV definitions. Label each of the TLV definitions as to whether
they are a Hop-by-Hop option, Destination option, or both.

Signed-off-by: Tom Herbert <tom@herbertland.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
 include/uapi/linux/in6.h        | 21 ++++++++++++++-------
 include/uapi/linux/ip6_tunnel.h |  1 -
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index 5a47339ef7d7..438283dc5fde 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -140,14 +140,21 @@ struct in6_flowlabel_req {
 
 /*
  *	IPv6 TLV options.
+ *
+ *	Hop-by-Hop and Destination options share the same number space.
+ *	For each option below whether it is a Hop-by-Hop option or
+ *	a Destination option is indicated by HBH or DestOpt.
  */
-#define IPV6_TLV_PAD1		0
-#define IPV6_TLV_PADN		1
-#define IPV6_TLV_ROUTERALERT	5
-#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* RFC 9486 */
-#define IPV6_TLV_JUMBO		194
-#define IPV6_TLV_HAO		201	/* home address option */
+#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
+#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
+#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
+#define IPV6_TLV_ROUTERALERT	5	/* HBH */
+#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
+#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
+					 * IOAM sent and rcvd as HBH
+					 */
+#define IPV6_TLV_JUMBO		194	/* HBH */
+#define IPV6_TLV_HAO		201	/* home address option, DestOpt */
 
 /*
  *	IPV6 socket options
diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
index 85182a839d42..35af4d9c35fb 100644
--- a/include/uapi/linux/ip6_tunnel.h
+++ b/include/uapi/linux/ip6_tunnel.h
@@ -6,7 +6,6 @@
 #include <linux/if.h>		/* For IFNAMSIZ. */
 #include <linux/in6.h>		/* For struct in6_addr. */
 
-#define IPV6_TLV_TNL_ENCAP_LIMIT 4
 #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
 
 /* don't add encapsulation limit if one isn't present in inner packet */
-- 
2.43.0


