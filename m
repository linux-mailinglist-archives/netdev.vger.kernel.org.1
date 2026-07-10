Return-Path: <netdev+bounces-306467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BDhOMl+3UGq63wIAu9opvQ
	(envelope-from <netdev+bounces-306467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5578B738E36
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:11:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=geQfQL1T;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306467-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306467-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE39312BC5B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2763D79FB;
	Fri, 10 Jul 2026 08:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C23D6690
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:58:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673908; cv=none; b=K+vZ/jfO2k0ji8cAroCarfaHB/q8L7jpvYLBjYI3dTS4fxP4wTT70PueuotAI5WCjkT9wqAkywKqC0J2cKs7QEuB8ie8zHo9MvKLRLoashC73J2tGP4A8Q6PkFExRk21A/QLoL0Ii6eYZoCw1gY0721Rp1eQ9B22GESl9Z9TeN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673908; c=relaxed/simple;
	bh=8b0YWFl1jOZkSbsJYVqgUyLVLRAENO/JZu2ZKO4uNSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVBhZkIsLbLzjH0K9i7Pk60p36QscYFRCLpCAfKPFb15Avwo7Ys1Moi14rWMCRNuSKTonQ0FQemzYxb7rDoA2QRzTAvoM4SMFzFKw510xoEvWKQgwSvS+e1JapXXY0t6lJ1MI/j/VN34Iegp64WOGSO+SPrF+tCzT7XvDXLaBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geQfQL1T; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab973140bso7560065ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783673904; x=1784278704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1IJVmQhNbSpmwt5Gbasi/oFpMc5bPEoaKCJfi/iAHg=;
        b=geQfQL1TAB4Lz5msWMZoOvSMDZ1C9JhbKHFF5snek1ahhtZa+GU7kliBQ+GzWWwnJZ
         eunnhcCSlr0GJ0SZg8lN9kQV0QS4B52OY7iKgFCh8Z3w2LmyvujGcTLl3rIHYPQT7C72
         N5BN5o1mJgdCWxwnd+itGpUsW+PZ31FP0PoMcgSvoht+W7/v2e+DyvhcfC8swa0gukC3
         kZp8w9yDqa02HbupobsTQPIZp7TIwwDx6F7CncWSf9mq+WNZSAJfrAt+wdyQZz6FMvlV
         lVcLOQxauNVkBLNkX5vpijzaNTgivNUb9QSjbrlGiXulcEJXqCeuFW/q445seNhO8zLu
         ORNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783673904; x=1784278704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I1IJVmQhNbSpmwt5Gbasi/oFpMc5bPEoaKCJfi/iAHg=;
        b=DiV//DSstHDQU3+ZR55NSQcf52L4JJLgxWrGUE1yr84ZY5SOa6NWx5MeBbaJTTpGjZ
         qtRAGfIgYy6juybh3GM5k1zeDWjY+YqJr9WKiMRnWO15ueDS7Lqj0NPrXF3ZF6uwQG9C
         UNOuZndI/f3kvTLl3dTLeOUJDWYO+NmBgGl/bWI7URxHibloft2lNOLOMp/bJD20KR4u
         Z0zrtZTDZJJwCKShURn7kWBJ53N74BQrgUdi4ZNlWnveCvkvSzCoVOMIJasdF92CX4or
         MD4rn5WpGwSeG5EID0BR0gg4hYpOowr97bV1ZYtdwxHlNcNQ2ZWETi1/tMuNrNfEBsH0
         EEBQ==
X-Forwarded-Encrypted: i=1; AHgh+RpubRcnTTCAx1APg7Ppv5ltaTmHWBzkQDB/qghi5JsCqvMdLS5oLofxOjCKbIbOiPufb/QHjyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1I14HMGqhRl1lmUdbpnYsGLwMyIMIq6LB9BbxnN4ZEztHJd8j
	hVjyO2GR85oLjXjdThRyGBWoSnMHsizFw9UVCTLM8qsyL+og6pqnaXJS
X-Gm-Gg: AfdE7ckqLVOIOb0GN+itExrPWTRhupvqPgHDyqG+t4qtzmEN/kZymfgpx54FEzwMfb3
	JyEZs9jk4j4OXD7/trxojZOwMQ2ETkh8/FOzpWYJ7HUCMbTd+ak6RpkoTlO7MYWAPxZnJVbxTtE
	xN7ezIPvc1ZzsGAoEW4FPbRtTx04G9QPTm0smIbp0rd5MphGLJ/CzxinKtHzevG6HtIpySw1zWj
	rpByubMJPnQD0lIGjw8FxmsAB13KMJm0eW1CFEO8KnCeGQq2mkxyy51Kuf5b+f+Geh0LoFK/JN7
	o2eJ6NafDCifrMDudnPSFll9chDI2hJ8hm1dOdf4y5+eGUYbodoC3GdV36Yj/A0zSDMyZXWOMEZ
	CBhY7I4g5uPlbBBVRRW8RNrJ2O7IhYNTydbtazMtJgpqPTimTR/W44yDKLqXLSKkOnWqDxO4Glb
	h2zWjQLQWSr2hUw8yskCbb6g4=
X-Received: by 2002:a17:903:1a87:b0:2cc:e620:e307 with SMTP id d9443c01a7336-2ccea3b0e71mr109533785ad.20.1783673903567;
        Fri, 10 Jul 2026 01:58:23 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3da55sm56674275ad.71.2026.07.10.01.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:58:22 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 10 Jul 2026 17:58:16 +0900
Subject: [PATCH RFC net-next 1/2] seg6: add support for the SRv6 End.MAP
 behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-seg6-mobile-end-map-v1-1-99be02d68143@gmail.com>
References: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
In-Reply-To: <20260710-seg6-mobile-end-map-v1-0-99be02d68143@gmail.com>
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 Andrea Mayer <andrea@common-net.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27649;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=8b0YWFl1jOZkSbsJYVqgUyLVLRAENO/JZu2ZKO4uNSM=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqULQoU9/9h5TQbXTOfPtR62wfWv7Q9hKmjSg2q
 sppwcV4kDmJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCalC0KAAKCRAq19F1Kl0b
 TdAfEACIyTU2CJMnzMzYtS/5uFlQNGgUSly6/cll2arNBW12bAkFUS8Idxy4Sz7AE7WEimWa9BC
 rTL5A3SK0UReVSGPpVwujsnyBuBPypAc/JAYl01NfBAa90QppeWUrEsa+uo4qOHzx/86lBSh2zN
 /CDopZcZtKBkKJeJJnlri0jqDsfQKkOR9HWNeKf/uh2naY8aTL6sxvFCZx+a0rDGlmZCtBEgzMd
 u9ohN1gEGvqfgmK8V6BjVc6VhDr+qfjBf+en9aAumg62zWdyuTWjTQMwxp8m/FJlkHk7Gc0xaYj
 dS3a/rHjDzDYY8xKGW3nzIhslxeZqibI7Sf2JpFrV2X6hOPYbqzcB8aKOBfvbxSMaZl4O0lEdAC
 WXOrazv8UrGmehApN9E046Piz5FL7lm+iucop4VPBBlGgg9HNLYcAjbfJ1cTZKJz+oZOOGOc2UL
 pTB0yY9ynKoCH+LHhO8L3q9z4OfogBynU+AQvaNEesHk29oU5DoLWMi8KzkhNbSPba/MdSHGnyl
 AvWr1Ic3x1dKM4JVTwUPBG1l+UNFjQE2ug50QQ18ATCWvxGqsckYx39Kx1craSk0pNE8dMthw5T
 c4o6yYmeIkdF0ZJ5J6ubATPegmsez6ggCfJzhTwdp64XO7El+KEuBRAzw/7qFqlm5HfrDPfmV6C
 RsFkyRwZMNdpw1A==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-306467-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrea.mayer@uniroma2.it,m:andrea@common-net.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:yuya.kusakabe@gmail.com,m:yuyakusakabe@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5578B738E36

SRv6 End.MAP is defined in RFC 9433 [1].

The SRv6 End.MAP is an SRv6 endpoint that replaces the IPv6
destination address with a configured next SID and forwards the
packet via the IPv6 FIB without consuming the SRH.

The SRv6 End.MAP Linux implementation is the first behavior of the
SRv6 Mobile User Plane and introduces a dedicated
LWTUNNEL_ENCAP_SEG6_MOBILE encap type, a CONFIG_IPV6_SEG6_MOBILE
build option and a net/ipv6/seg6_mobile.c file that hosts the
action dispatch table.  The user-space ABI lives in
include/uapi/linux/seg6_mobile.h under a SEG6_MOBILE_* namespace,
kept separate from SEG6_LOCAL_* so that attributes whose semantics
differ between behaviors do not overload the same UAPI table.

The SRv6 End.MAP behavior can be instantiated using a command
similar to the following:

 $ ip -6 route add 2001:db8:f::/64 encap seg6mobile action End.MAP \
     nh6 2001:db8:2::e dev eth0

We introduce the "seg6mobile" extension in iproute2 in a following
patch.

[1] https://www.rfc-editor.org/rfc/rfc9433.html

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/net/seg6.h               |   8 +
 include/uapi/linux/lwtunnel.h    |   1 +
 include/uapi/linux/seg6_mobile.h |  58 ++++
 net/core/lwtunnel.c              |   2 +
 net/ipv6/Kconfig                 |  12 +
 net/ipv6/Makefile                |   1 +
 net/ipv6/seg6.c                  |   7 +
 net/ipv6/seg6_mobile.c           | 725 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 814 insertions(+)

diff --git a/include/net/seg6.h b/include/net/seg6.h
index 82b3fbbcbb93..789e9bcc4773 100644
--- a/include/net/seg6.h
+++ b/include/net/seg6.h
@@ -64,6 +64,14 @@ static inline int seg6_local_init(void) { return 0; }
 static inline void seg6_local_exit(void) {}
 #endif
 
+#ifdef CONFIG_IPV6_SEG6_MOBILE
+extern int seg6_mobile_init(void);
+extern void seg6_mobile_exit(void);
+#else
+static inline int seg6_mobile_init(void) { return 0; }
+static inline void seg6_mobile_exit(void) {}
+#endif
+
 extern bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced);
 extern struct ipv6_sr_hdr *seg6_get_srh(struct sk_buff *skb, int flags);
 extern void seg6_icmp_srh(struct sk_buff *skb, struct inet6_skb_parm *opt);
diff --git a/include/uapi/linux/lwtunnel.h b/include/uapi/linux/lwtunnel.h
index 229655ef792f..6e48f79c548e 100644
--- a/include/uapi/linux/lwtunnel.h
+++ b/include/uapi/linux/lwtunnel.h
@@ -16,6 +16,7 @@ enum lwtunnel_encap_types {
 	LWTUNNEL_ENCAP_RPL,
 	LWTUNNEL_ENCAP_IOAM6,
 	LWTUNNEL_ENCAP_XFRM,
+	LWTUNNEL_ENCAP_SEG6_MOBILE,
 	__LWTUNNEL_ENCAP_MAX,
 };
 
diff --git a/include/uapi/linux/seg6_mobile.h b/include/uapi/linux/seg6_mobile.h
new file mode 100644
index 000000000000..bb6fd5189138
--- /dev/null
+++ b/include/uapi/linux/seg6_mobile.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  SRv6 Mobile User Plane implementation
+ */
+#ifndef _UAPI_LINUX_SEG6_MOBILE_H
+#define _UAPI_LINUX_SEG6_MOBILE_H
+
+enum {
+	SEG6_MOBILE_UNSPEC,
+	SEG6_MOBILE_ACTION,
+	SEG6_MOBILE_NH6,
+	SEG6_MOBILE_COUNTERS,
+	__SEG6_MOBILE_MAX,
+};
+
+#define SEG6_MOBILE_MAX	(__SEG6_MOBILE_MAX - 1)
+
+enum {
+	SEG6_MOBILE_ACTION_UNSPEC	= 0,
+	/* swap IPv6 DA with the next SID, leave SRH untouched */
+	SEG6_MOBILE_ACTION_END_MAP	= 1,
+
+	__SEG6_MOBILE_ACTION_MAX,
+};
+
+#define SEG6_MOBILE_ACTION_MAX	(__SEG6_MOBILE_ACTION_MAX - 1)
+
+/* SRv6 Mobile Behavior counters are encoded as netlink attributes
+ * guaranteeing the correct alignment.
+ * Each counter is identified by a different attribute type (i.e.
+ * SEG6_MOBILE_CNT_PACKETS).
+ *
+ * - SEG6_MOBILE_CNT_PACKETS: identifies a counter that counts the number
+ *   of packets that have been CORRECTLY processed by an SRv6 Behavior
+ *   instance (i.e., packets that generate errors or are dropped are NOT
+ *   counted).
+ *
+ * - SEG6_MOBILE_CNT_BYTES: identifies a counter that counts the total
+ *   amount of traffic in bytes of all packets that have been CORRECTLY
+ *   processed by an SRv6 Behavior instance (i.e., packets that generate
+ *   errors or are dropped are NOT counted).
+ *
+ * - SEG6_MOBILE_CNT_ERRORS: identifies a counter that counts the number
+ *   of packets that have NOT been properly processed by an SRv6 Behavior
+ *   instance (i.e., packets that generate errors or are dropped).
+ */
+enum {
+	SEG6_MOBILE_CNT_UNSPEC,
+	SEG6_MOBILE_CNT_PACKETS,
+	SEG6_MOBILE_CNT_BYTES,
+	SEG6_MOBILE_CNT_ERRORS,
+	SEG6_MOBILE_CNT_PAD,		/* pad for 64 bits values */
+	__SEG6_MOBILE_CNT_MAX,
+};
+
+#define SEG6_MOBILE_CNT_MAX	(__SEG6_MOBILE_CNT_MAX - 1)
+
+#endif /* _UAPI_LINUX_SEG6_MOBILE_H */
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index b01a395d9a96..4476293ccb37 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -53,6 +53,8 @@ static const char *lwtunnel_encap_str(enum lwtunnel_encap_types encap_type)
 	case LWTUNNEL_ENCAP_XFRM:
 		/* module autoload not supported for encap type */
 		return NULL;
+	case LWTUNNEL_ENCAP_SEG6_MOBILE:
+		return "SEG6MOBILE";
 	case LWTUNNEL_ENCAP_IP6:
 	case LWTUNNEL_ENCAP_IP:
 	case LWTUNNEL_ENCAP_NONE:
diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index c3806c6ac96f..ba984c8b8fc7 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -314,6 +314,18 @@ config IPV6_SEG6_BPF
 	depends on IPV6_SEG6_LWTUNNEL
 	depends on IPV6 = y
 
+config IPV6_SEG6_MOBILE
+	bool "IPv6: SRv6 Mobile User Plane (RFC 9433) behaviors"
+	depends on IPV6_SEG6_LWTUNNEL
+	help
+	  Support for the SRv6 Mobile User Plane behaviors defined by
+	  RFC 9433.  These behaviors translate between SRv6 and GTP-U,
+	  or operate on SRv6 packets carrying mobile-user-plane traffic,
+	  and are exposed via the LWTUNNEL_ENCAP_SEG6_MOBILE lightweight
+	  tunnel encapsulation.
+
+	  If unsure, say N.
+
 config IPV6_RPL_LWTUNNEL
 	bool "IPv6: RPL Source Routing Header support"
 	depends on IPV6
diff --git a/net/ipv6/Makefile b/net/ipv6/Makefile
index 5b0cd6488021..515ac8d9d120 100644
--- a/net/ipv6/Makefile
+++ b/net/ipv6/Makefile
@@ -24,6 +24,7 @@ ipv6-$(CONFIG_SYN_COOKIES) += syncookies.o
 ipv6-$(CONFIG_NETLABEL) += calipso.o
 ipv6-$(CONFIG_IPV6_SEG6_LWTUNNEL) += seg6_iptunnel.o seg6_local.o
 ipv6-$(CONFIG_IPV6_SEG6_HMAC) += seg6_hmac.o
+ipv6-$(CONFIG_IPV6_SEG6_MOBILE) += seg6_mobile.o
 ipv6-$(CONFIG_IPV6_RPL_LWTUNNEL) += rpl_iptunnel.o
 ipv6-$(CONFIG_IPV6_IOAM6_LWTUNNEL) += ioam6_iptunnel.o
 
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 62a7eb779202..14626b15abd5 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -525,10 +525,16 @@ int __init seg6_init(void)
 	if (err)
 		goto out_unregister_iptun;
 
+	err = seg6_mobile_init();
+	if (err)
+		goto out_unregister_local;
+
 	pr_info("Segment Routing with IPv6\n");
 
 out:
 	return err;
+out_unregister_local:
+	seg6_local_exit();
 out_unregister_iptun:
 	seg6_iptunnel_exit();
 out_unregister_genl:
@@ -540,6 +546,7 @@ int __init seg6_init(void)
 
 void seg6_exit(void)
 {
+	seg6_mobile_exit();
 	seg6_local_exit();
 	seg6_iptunnel_exit();
 	genl_unregister_family(&seg6_genl_family);
diff --git a/net/ipv6/seg6_mobile.c b/net/ipv6/seg6_mobile.c
new file mode 100644
index 000000000000..b2263c778b00
--- /dev/null
+++ b/net/ipv6/seg6_mobile.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  SRv6 Mobile User Plane implementation
+ *
+ *  Author:
+ *  Yuya Kusakabe <yuya.kusakabe@gmail.com>
+ */
+
+#include <linux/icmpv6.h>
+#include <linux/in6.h>
+#include <linux/ipv6.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/tcp.h>
+#include <linux/types.h>
+#include <linux/udp.h>
+#include <net/checksum.h>
+#include <net/ipv6.h>
+#include <net/lwtunnel.h>
+#include <net/seg6.h>
+#ifdef CONFIG_IPV6_SEG6_HMAC
+#include <net/seg6_hmac.h>
+#endif
+#include <uapi/linux/seg6_mobile.h>
+
+#define SEG6_MOBILE_F_ATTR(i)		BIT(i)
+#define SEG6_F_MOBILE_COUNTERS		SEG6_MOBILE_F_ATTR(SEG6_MOBILE_COUNTERS)
+
+struct seg6_mobile_lwt;
+
+struct seg6_mobile_action_desc {
+	int action;
+	unsigned long attrs;
+	unsigned long optattrs;
+	int (*input)(struct sk_buff *skb, struct seg6_mobile_lwt *slwt);
+};
+
+struct seg6_mobile_action_param {
+	int (*parse)(struct nlattr **attrs, struct seg6_mobile_lwt *slwt,
+		     struct netlink_ext_ack *extack);
+	int (*put)(struct sk_buff *skb, struct seg6_mobile_lwt *slwt);
+	int (*cmp)(struct seg6_mobile_lwt *a, struct seg6_mobile_lwt *b);
+
+	/* optional destroy() callback to release resources acquired in
+	 * the corresponding parse() function.
+	 */
+	void (*destroy)(struct seg6_mobile_lwt *slwt);
+};
+
+struct pcpu_seg6_mobile_counters {
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t errors;
+
+	struct u64_stats_sync syncp;
+};
+
+/* User-space aggregate format for the per-CPU counters.  Kept private
+ * to the kernel; userspace receives the values through SEG6_MOBILE_CNT_*
+ * nested netlink attributes.
+ */
+struct seg6_mobile_counters {
+	__u64 packets;
+	__u64 bytes;
+	__u64 errors;
+};
+
+#define seg6_mobile_alloc_pcpu_counters(__gfp)				\
+	__netdev_alloc_pcpu_stats(struct pcpu_seg6_mobile_counters,	\
+				  ((__gfp) | __GFP_ZERO))
+
+struct seg6_mobile_lwt {
+	int action;
+	struct in6_addr nh6;
+	const struct seg6_mobile_action_desc *desc;
+	struct pcpu_seg6_mobile_counters __percpu *pcpu_counters;
+
+	/* required attrs are tracked by desc->attrs; optional attrs that
+	 * the user actually configured are tracked here so that fill_encap
+	 * / cmp / destroy can iterate only over what was parsed.
+	 */
+	unsigned long parsed_optattrs;
+};
+
+static struct seg6_mobile_lwt *seg6_mobile_lwtunnel(struct lwtunnel_state *lwt)
+{
+	return (struct seg6_mobile_lwt *)lwt->data;
+}
+
+enum seg6_mobile_srh_state {
+	SEG6_MOBILE_SRH_ABSENT,
+	SEG6_MOBILE_SRH_PRESENT,
+	SEG6_MOBILE_SRH_MALFORMED,
+};
+
+/* Return the SRH if present and valid.  @state separates ABSENT from
+ * MALFORMED so End.MAP can forward an SRH-less packet while still
+ * dropping a malformed one.
+ */
+static struct ipv6_sr_hdr *
+seg6_mobile_get_and_validate_srh(struct sk_buff *skb,
+				 enum seg6_mobile_srh_state *state)
+{
+	struct ipv6_sr_hdr *srh;
+	unsigned int srhoff = 0;
+	int hdr_proto;
+	int flags = 0;
+
+	srh = seg6_get_srh(skb, 0);
+	if (srh) {
+#ifdef CONFIG_IPV6_SEG6_HMAC
+		if (!seg6_hmac_validate_skb(skb)) {
+			*state = SEG6_MOBILE_SRH_MALFORMED;
+			return NULL;
+		}
+#endif
+		*state = SEG6_MOBILE_SRH_PRESENT;
+		return srh;
+	}
+
+	hdr_proto = ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, &flags);
+	*state = hdr_proto == -ENOENT ? SEG6_MOBILE_SRH_ABSENT
+				      : SEG6_MOBILE_SRH_MALFORMED;
+	return NULL;
+}
+
+/* Length of the L4 header that must be made writable so its checksum
+ * field can be patched when the IPv6 DA changes.  Returns 0 for L4
+ * protocols whose checksum does not cover the IPv6 pseudo-header.
+ */
+static int seg6_mobile_l4_csum_hlen(u8 nexthdr)
+{
+	switch (nexthdr) {
+	case IPPROTO_TCP:
+		return sizeof(struct tcphdr);
+	case IPPROTO_UDP:
+		return sizeof(struct udphdr);
+	case IPPROTO_ICMPV6:
+		return sizeof(struct icmp6hdr);
+	}
+	return 0;
+}
+
+/* Return a pointer to the L4 checksum field that needs the IPv6 DA
+ * diff applied, or NULL if patching must be skipped.  Must be called
+ * after the L4 header has been made writable.
+ */
+static __sum16 *seg6_mobile_l4_csum(struct sk_buff *skb, int l4_off,
+				    u8 nexthdr)
+{
+	switch (nexthdr) {
+	case IPPROTO_TCP:
+		return &((struct tcphdr *)(skb->data + l4_off))->check;
+	case IPPROTO_UDP: {
+		struct udphdr *uh = (struct udphdr *)(skb->data + l4_off);
+
+		/* A zero UDPv6 checksum on a fully assembled skb signals
+		 * "no checksum" (e.g. tunneled UDP); patching it would
+		 * invent a spurious non-zero value.
+		 */
+		if (!uh->check && skb->ip_summed != CHECKSUM_PARTIAL)
+			return NULL;
+		return &uh->check;
+	}
+	case IPPROTO_ICMPV6:
+		return &((struct icmp6hdr *)(skb->data + l4_off))->icmp6_cksum;
+	}
+	return NULL;
+}
+
+/* Rewrite the IPv6 destination address with @nh.  When @srh_present is
+ * false the packet has no routing header, so the receiver delivers it
+ * straight to the transport: walk any Hop-by-Hop / Destination Options /
+ * Fragment chain to the L4 header and, when that transport uses the IPv6
+ * pseudo-header, patch its checksum by the DA diff.  When a routing
+ * header is present the receiver first advances the SID list (SRv6
+ * restores DA to segments[0]) before delivering to L4, so the original
+ * checksum stays valid and only skb->csum needs maintenance for
+ * CHECKSUM_COMPLETE skbs.
+ */
+static int seg6_mobile_advance_da(struct sk_buff *skb,
+				  const struct in6_addr *nh, bool srh_present)
+{
+	int l4_off = 0, l4_hlen = 0;
+	struct in6_addr old_da;
+	struct ipv6hdr *ip6h;
+	__be16 frag_off;
+	u8 nexthdr = 0;
+	__sum16 *csum;
+	int write_len;
+
+	if (!pskb_may_pull(skb, sizeof(*ip6h)))
+		return -EINVAL;
+
+	ip6h = ipv6_hdr(skb);
+	write_len = sizeof(*ip6h);
+
+	if (!srh_present) {
+		nexthdr = ip6h->nexthdr;
+		l4_off = ipv6_skip_exthdr(skb, sizeof(*ip6h), &nexthdr,
+					  &frag_off);
+		if (l4_off < 0)
+			return -EINVAL;
+
+		/* Non-first fragments carry no L4 header at @l4_off (the
+		 * Fragment header reports a non-zero offset); only the
+		 * first fragment, which holds the transport header, is
+		 * patched.
+		 */
+		if (frag_off == 0)
+			l4_hlen = seg6_mobile_l4_csum_hlen(nexthdr);
+		if (l4_hlen)
+			write_len = l4_off + l4_hlen;
+	}
+
+	if (skb_ensure_writable(skb, write_len))
+		return -ENOMEM;
+
+	/* skb_ensure_writable() may change skb pointers; evaluate ip6h again */
+	ip6h = ipv6_hdr(skb);
+	old_da = ip6h->daddr;
+
+	csum = l4_hlen ? seg6_mobile_l4_csum(skb, l4_off, nexthdr) : NULL;
+	if (csum) {
+		inet_proto_csum_replace16(csum, skb, old_da.s6_addr32,
+					  nh->s6_addr32, true);
+		/* A real UDPv6 checksum of 0x0000 is illegal, replace it
+		 * with 0xffff.  inet_proto_csum_replace16() keeps skb->csum
+		 * consistent for CHECKSUM_COMPLETE because the IPv6 DA diff
+		 * and the L4 csum diff cancel each other.
+		 */
+		if (nexthdr == IPPROTO_UDP && !*csum)
+			*csum = CSUM_MANGLED_0;
+	} else if (skb->ip_summed == CHECKSUM_COMPLETE) {
+		update_csum_diff16(skb, old_da.s6_addr32, (__be32 *)nh);
+	}
+
+	ip6h->daddr = *nh;
+	skb_clear_hash(skb);
+
+	return 0;
+}
+
+/* seg6_lookup_nexthop() releases the original dst itself, so no
+ * skb_dst_drop() is needed before the call.
+ */
+static int seg6_mobile_forward(struct sk_buff *skb)
+{
+	seg6_lookup_nexthop(skb, NULL, 0);
+	return dst_input(skb);
+}
+
+static int input_action_end_map(struct sk_buff *skb,
+				struct seg6_mobile_lwt *slwt)
+{
+	enum seg6_mobile_srh_state srh_state;
+
+	seg6_mobile_get_and_validate_srh(skb, &srh_state);
+	if (srh_state == SEG6_MOBILE_SRH_MALFORMED)
+		goto drop;
+
+	if (seg6_mobile_advance_da(skb, &slwt->nh6,
+				   srh_state == SEG6_MOBILE_SRH_PRESENT))
+		goto drop;
+
+	return seg6_mobile_forward(skb);
+
+drop:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static int parse_nla_nh6(struct nlattr **attrs, struct seg6_mobile_lwt *slwt,
+			 struct netlink_ext_ack *extack)
+{
+	memcpy(&slwt->nh6, nla_data(attrs[SEG6_MOBILE_NH6]),
+	       sizeof(struct in6_addr));
+
+	return 0;
+}
+
+static int put_nla_nh6(struct sk_buff *skb, struct seg6_mobile_lwt *slwt)
+{
+	if (nla_put_in6_addr(skb, SEG6_MOBILE_NH6, &slwt->nh6))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int cmp_nla_nh6(struct seg6_mobile_lwt *a, struct seg6_mobile_lwt *b)
+{
+	return memcmp(&a->nh6, &b->nh6, sizeof(struct in6_addr));
+}
+
+static const struct
+nla_policy seg6_mobile_counters_policy[SEG6_MOBILE_CNT_MAX + 1] = {
+	[SEG6_MOBILE_CNT_PACKETS]	= { .type = NLA_U64 },
+	[SEG6_MOBILE_CNT_BYTES]		= { .type = NLA_U64 },
+	[SEG6_MOBILE_CNT_ERRORS]	= { .type = NLA_U64 },
+};
+
+static int parse_nla_counters(struct nlattr **attrs,
+			      struct seg6_mobile_lwt *slwt,
+			      struct netlink_ext_ack *extack)
+{
+	struct pcpu_seg6_mobile_counters __percpu *pcounters;
+	struct nlattr *tb[SEG6_MOBILE_CNT_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested_deprecated(tb, SEG6_MOBILE_CNT_MAX,
+					  attrs[SEG6_MOBILE_COUNTERS],
+					  seg6_mobile_counters_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	/* basic support for SRv6 Behavior counters requires at least:
+	 * packets, bytes and errors.
+	 */
+	if (!tb[SEG6_MOBILE_CNT_PACKETS] || !tb[SEG6_MOBILE_CNT_BYTES] ||
+	    !tb[SEG6_MOBILE_CNT_ERRORS])
+		return -EINVAL;
+
+	/* counters are always zero initialized */
+	pcounters = seg6_mobile_alloc_pcpu_counters(GFP_KERNEL);
+	if (!pcounters)
+		return -ENOMEM;
+
+	slwt->pcpu_counters = pcounters;
+
+	return 0;
+}
+
+static int seg6_mobile_fill_nla_counters(struct sk_buff *skb,
+					 struct seg6_mobile_counters *counters)
+{
+	if (nla_put_u64_64bit(skb, SEG6_MOBILE_CNT_PACKETS, counters->packets,
+			      SEG6_MOBILE_CNT_PAD))
+		return -EMSGSIZE;
+
+	if (nla_put_u64_64bit(skb, SEG6_MOBILE_CNT_BYTES, counters->bytes,
+			      SEG6_MOBILE_CNT_PAD))
+		return -EMSGSIZE;
+
+	if (nla_put_u64_64bit(skb, SEG6_MOBILE_CNT_ERRORS, counters->errors,
+			      SEG6_MOBILE_CNT_PAD))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int put_nla_counters(struct sk_buff *skb, struct seg6_mobile_lwt *slwt)
+{
+	struct seg6_mobile_counters counters = { 0, 0, 0 };
+	struct nlattr *nest;
+	int rc, i;
+
+	nest = nla_nest_start(skb, SEG6_MOBILE_COUNTERS);
+	if (!nest)
+		return -EMSGSIZE;
+
+	for_each_possible_cpu(i) {
+		struct pcpu_seg6_mobile_counters *pcounters;
+		u64 packets, bytes, errors;
+		unsigned int start;
+
+		pcounters = per_cpu_ptr(slwt->pcpu_counters, i);
+		do {
+			start = u64_stats_fetch_begin(&pcounters->syncp);
+
+			packets = u64_stats_read(&pcounters->packets);
+			bytes = u64_stats_read(&pcounters->bytes);
+			errors = u64_stats_read(&pcounters->errors);
+
+		} while (u64_stats_fetch_retry(&pcounters->syncp, start));
+
+		counters.packets += packets;
+		counters.bytes += bytes;
+		counters.errors += errors;
+	}
+
+	rc = seg6_mobile_fill_nla_counters(skb, &counters);
+	if (rc < 0) {
+		nla_nest_cancel(skb, nest);
+		return rc;
+	}
+
+	return nla_nest_end(skb, nest);
+}
+
+static int cmp_nla_counters(struct seg6_mobile_lwt *a,
+			    struct seg6_mobile_lwt *b)
+{
+	/* tunnels with counters enabled and disabled are different. */
+	return (!!((unsigned long)a->pcpu_counters)) ^
+		(!!((unsigned long)b->pcpu_counters));
+}
+
+static void destroy_attr_counters(struct seg6_mobile_lwt *slwt)
+{
+	free_percpu(slwt->pcpu_counters);
+}
+
+static const struct seg6_mobile_action_desc seg6_mobile_action_table[] = {
+	{
+		.action		= SEG6_MOBILE_ACTION_END_MAP,
+		.attrs		= SEG6_MOBILE_F_ATTR(SEG6_MOBILE_NH6),
+		.optattrs	= SEG6_F_MOBILE_COUNTERS,
+		.input		= input_action_end_map,
+	},
+};
+
+static const struct seg6_mobile_action_param
+seg6_mobile_action_params[SEG6_MOBILE_MAX + 1] = {
+	[SEG6_MOBILE_NH6] = {
+		.parse	= parse_nla_nh6,
+		.put	= put_nla_nh6,
+		.cmp	= cmp_nla_nh6,
+	},
+	[SEG6_MOBILE_COUNTERS] = {
+		.parse		= parse_nla_counters,
+		.put		= put_nla_counters,
+		.cmp		= cmp_nla_counters,
+		.destroy	= destroy_attr_counters,
+	},
+};
+
+static const struct nla_policy
+seg6_mobile_policy[SEG6_MOBILE_MAX + 1] = {
+	[SEG6_MOBILE_ACTION]	= { .type = NLA_U32 },
+	[SEG6_MOBILE_NH6]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[SEG6_MOBILE_COUNTERS]	= { .type = NLA_NESTED },
+};
+
+static const struct seg6_mobile_action_desc *
+seg6_mobile_get_action_desc(int action)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(seg6_mobile_action_table); i++) {
+		if (seg6_mobile_action_table[i].action == action)
+			return &seg6_mobile_action_table[i];
+	}
+
+	return NULL;
+}
+
+/* call the destroy() callback (if available) for each set attribute in
+ * @parsed_attrs, starting from the first attribute up to the @max_parsed
+ * (excluded) attribute.
+ */
+static void __destroy_attrs(unsigned long parsed_attrs, int max_parsed,
+			    struct seg6_mobile_lwt *slwt)
+{
+	const struct seg6_mobile_action_param *param;
+	int i;
+
+	for (i = SEG6_MOBILE_ACTION + 1; i < max_parsed; i++) {
+		if (!(parsed_attrs & SEG6_MOBILE_F_ATTR(i)))
+			continue;
+
+		param = &seg6_mobile_action_params[i];
+		if (param->destroy)
+			param->destroy(slwt);
+	}
+}
+
+static void destroy_attrs(struct seg6_mobile_lwt *slwt)
+{
+	unsigned long attrs = slwt->desc->attrs | slwt->parsed_optattrs;
+
+	__destroy_attrs(attrs, SEG6_MOBILE_MAX + 1, slwt);
+}
+
+static int seg6_mobile_parse_attrs(struct nlattr **attrs,
+				   struct seg6_mobile_lwt *slwt,
+				   struct netlink_ext_ack *extack)
+{
+	const struct seg6_mobile_action_param *param;
+	const struct seg6_mobile_action_desc *desc;
+	unsigned long parsed_optattrs = 0;
+	int i, err;
+
+	desc = slwt->desc;
+
+	if (WARN_ON_ONCE(desc->attrs & desc->optattrs))
+		return -EINVAL;
+
+	for (i = SEG6_MOBILE_ACTION + 1; i <= SEG6_MOBILE_MAX; i++) {
+		bool required = desc->attrs & SEG6_MOBILE_F_ATTR(i);
+		bool optional = desc->optattrs & SEG6_MOBILE_F_ATTR(i);
+
+		if (!required && !optional)
+			continue;
+
+		if (required && !attrs[i]) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "missing required attribute");
+			err = -EINVAL;
+			goto err;
+		}
+
+		if (!attrs[i])
+			continue;
+
+		param = &seg6_mobile_action_params[i];
+		err = param->parse(attrs, slwt, extack);
+		if (err < 0)
+			goto err;
+
+		if (optional)
+			parsed_optattrs |= SEG6_MOBILE_F_ATTR(i);
+	}
+
+	slwt->parsed_optattrs = parsed_optattrs;
+
+	return 0;
+
+err:
+	__destroy_attrs(desc->attrs | parsed_optattrs, i, slwt);
+	return err;
+}
+
+static bool seg6_mobile_counters_enabled(struct seg6_mobile_lwt *slwt)
+{
+	return slwt->parsed_optattrs & SEG6_F_MOBILE_COUNTERS;
+}
+
+static void seg6_mobile_update_counters(struct seg6_mobile_lwt *slwt,
+					unsigned int len, int err)
+{
+	struct pcpu_seg6_mobile_counters *pcounters;
+
+	pcounters = this_cpu_ptr(slwt->pcpu_counters);
+	u64_stats_update_begin(&pcounters->syncp);
+
+	if (likely(!err)) {
+		u64_stats_inc(&pcounters->packets);
+		u64_stats_add(&pcounters->bytes, len);
+	} else {
+		u64_stats_inc(&pcounters->errors);
+	}
+
+	u64_stats_update_end(&pcounters->syncp);
+}
+
+static int seg6_mobile_input(struct sk_buff *skb)
+{
+	struct dst_entry *orig_dst = skb_dst(skb);
+	struct seg6_mobile_lwt *slwt;
+	unsigned int len = skb->len;
+	int rc;
+
+	if (skb->protocol != htons(ETH_P_IPV6)) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	slwt = seg6_mobile_lwtunnel(orig_dst->lwtstate);
+
+	rc = slwt->desc->input(skb, slwt);
+
+	if (seg6_mobile_counters_enabled(slwt))
+		seg6_mobile_update_counters(slwt, len, rc);
+
+	return rc;
+}
+
+static int seg6_mobile_build_state(struct net *net, struct nlattr *nla,
+				   unsigned int family, const void *cfg,
+				   struct lwtunnel_state **ts,
+				   struct netlink_ext_ack *extack)
+{
+	const struct seg6_mobile_action_desc *desc;
+	struct nlattr *tb[SEG6_MOBILE_MAX + 1];
+	struct lwtunnel_state *newts;
+	struct seg6_mobile_lwt *slwt;
+	int err;
+
+	if (family != AF_INET6)
+		return -EINVAL;
+
+	err = nla_parse_nested_deprecated(tb, SEG6_MOBILE_MAX, nla,
+					  seg6_mobile_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[SEG6_MOBILE_ACTION]) {
+		NL_SET_ERR_MSG_MOD(extack, "missing SEG6_MOBILE_ACTION");
+		return -EINVAL;
+	}
+
+	desc = seg6_mobile_get_action_desc(nla_get_u32(tb[SEG6_MOBILE_ACTION]));
+	if (!desc) {
+		NL_SET_ERR_MSG_MOD(extack, "unknown SRv6 Mobile action");
+		return -EOPNOTSUPP;
+	}
+
+	newts = lwtunnel_state_alloc(sizeof(*slwt));
+	if (!newts)
+		return -ENOMEM;
+
+	slwt = seg6_mobile_lwtunnel(newts);
+	slwt->action = desc->action;
+	slwt->desc = desc;
+
+	err = seg6_mobile_parse_attrs(tb, slwt, extack);
+	if (err < 0) {
+		kfree(newts);
+		return err;
+	}
+
+	newts->type = LWTUNNEL_ENCAP_SEG6_MOBILE;
+	newts->flags = LWTUNNEL_STATE_INPUT_REDIRECT;
+
+	*ts = newts;
+
+	return 0;
+}
+
+static void seg6_mobile_destroy_state(struct lwtunnel_state *lwt)
+{
+	destroy_attrs(seg6_mobile_lwtunnel(lwt));
+}
+
+static int seg6_mobile_fill_encap(struct sk_buff *skb,
+				  struct lwtunnel_state *lwt)
+{
+	struct seg6_mobile_lwt *slwt = seg6_mobile_lwtunnel(lwt);
+	const struct seg6_mobile_action_param *param;
+	unsigned long attrs;
+	int i, err;
+
+	if (nla_put_u32(skb, SEG6_MOBILE_ACTION, slwt->action))
+		return -EMSGSIZE;
+
+	attrs = slwt->desc->attrs | slwt->parsed_optattrs;
+	for (i = SEG6_MOBILE_ACTION + 1; i <= SEG6_MOBILE_MAX; i++) {
+		if (!(attrs & SEG6_MOBILE_F_ATTR(i)))
+			continue;
+
+		param = &seg6_mobile_action_params[i];
+		err = param->put(skb, slwt);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int seg6_mobile_get_encap_size(struct lwtunnel_state *lwt)
+{
+	struct seg6_mobile_lwt *slwt = seg6_mobile_lwtunnel(lwt);
+	unsigned long attrs;
+	int nlsize;
+
+	nlsize = nla_total_size(sizeof(u32)); /* SEG6_MOBILE_ACTION */
+
+	attrs = slwt->desc->attrs | slwt->parsed_optattrs;
+	if (attrs & SEG6_MOBILE_F_ATTR(SEG6_MOBILE_NH6))
+		nlsize += nla_total_size(sizeof(struct in6_addr));
+
+	if (attrs & SEG6_F_MOBILE_COUNTERS)
+		nlsize += nla_total_size(0) + /* nest SEG6_MOBILE_COUNTERS */
+			  /* SEG6_MOBILE_CNT_PACKETS */
+			  nla_total_size_64bit(sizeof(__u64)) +
+			  /* SEG6_MOBILE_CNT_BYTES */
+			  nla_total_size_64bit(sizeof(__u64)) +
+			  /* SEG6_MOBILE_CNT_ERRORS */
+			  nla_total_size_64bit(sizeof(__u64));
+
+	return nlsize;
+}
+
+static int seg6_mobile_cmp_encap(struct lwtunnel_state *a,
+				 struct lwtunnel_state *b)
+{
+	struct seg6_mobile_lwt *slwt_a = seg6_mobile_lwtunnel(a);
+	struct seg6_mobile_lwt *slwt_b = seg6_mobile_lwtunnel(b);
+	const struct seg6_mobile_action_param *param;
+	unsigned long attrs_a, attrs_b;
+	int i;
+
+	if (slwt_a->action != slwt_b->action)
+		return 1;
+
+	attrs_a = slwt_a->desc->attrs | slwt_a->parsed_optattrs;
+	attrs_b = slwt_b->desc->attrs | slwt_b->parsed_optattrs;
+
+	if (attrs_a != attrs_b)
+		return 1;
+
+	for (i = SEG6_MOBILE_ACTION + 1; i <= SEG6_MOBILE_MAX; i++) {
+		if (!(attrs_a & SEG6_MOBILE_F_ATTR(i)))
+			continue;
+
+		param = &seg6_mobile_action_params[i];
+		if (param->cmp(slwt_a, slwt_b))
+			return 1;
+	}
+
+	return 0;
+}
+
+static const struct lwtunnel_encap_ops seg6_mobile_ops = {
+	.build_state	= seg6_mobile_build_state,
+	.destroy_state	= seg6_mobile_destroy_state,
+	.input		= seg6_mobile_input,
+	.fill_encap	= seg6_mobile_fill_encap,
+	.get_encap_size	= seg6_mobile_get_encap_size,
+	.cmp_encap	= seg6_mobile_cmp_encap,
+	.owner		= THIS_MODULE,
+};
+
+int __init seg6_mobile_init(void)
+{
+	BUILD_BUG_ON(SEG6_MOBILE_MAX + 1 > BITS_PER_TYPE(unsigned long));
+
+	return lwtunnel_encap_add_ops(&seg6_mobile_ops,
+				      LWTUNNEL_ENCAP_SEG6_MOBILE);
+}
+
+void seg6_mobile_exit(void)
+{
+	lwtunnel_encap_del_ops(&seg6_mobile_ops, LWTUNNEL_ENCAP_SEG6_MOBILE);
+}

-- 
2.50.1


