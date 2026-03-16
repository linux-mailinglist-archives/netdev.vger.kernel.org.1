Return-Path: <netdev+bounces-268187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCzWG+kfuGlYZAEAu9opvQ
	(envelope-from <netdev+bounces-268187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:21:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5229C2E0
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3865305624B
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F583A1E7F;
	Mon, 16 Mar 2026 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="GFU3sjQH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708253A1D0A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674162; cv=none; b=b2+eL5xWY3PAMR1jV5YYLqqVFXwFmoJf+RU9vX60uxDEpYF4Hdu3/tLSG6gJOVPbmseURmeAuxUtkBzwuvaXlLRhI5WTtu6hR+G1dxdwYpxqr3+KZEVi40Kbj3drcsJGJkfUWMQbmbwTAtUCVjc+E/Zi7fZPQt+Ep64BJ3bZ4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674162; c=relaxed/simple;
	bh=mPv1alicbNfO5ZT97r+vW90N+4T9V37S+/8vB5Ju2lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LHIXqCVoAzt69onyPFMPofivw+cA2aXZpNFEKA/nTiM66NYMxyZ7WDpsRvDkJCVjOt1UUH7phgW5oS7XBfYXUlKG/8OIxe5L7i2hGn2io9tYM7JEdlAKibftaBZ0Lfls1M1QQClwochoPOkrd/595TZ3i6rrCg01q7J/1Mx+uA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=GFU3sjQH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4855dbfc129so22736285e9.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773674159; x=1774278959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmUzIWhvYQPmLKIFrKQ+CmNW3KoiMo1xA15Z136wUAM=;
        b=GFU3sjQHFKJzcqlSdDtP6B8voW53yHHz4+riZoadtnhfGCUsMZVonHWE1xCZYGOiyP
         cEMjKCzCs2tppcNRRsb0SaRp1PdtKGbRCc0avxAEbWidsJHw2Njbt8V4gINOZDnpGlpi
         V4/WPB4omsBcL+q02+1VGM0hBG/9Q1qz0D67sPQ4wsUGWIwJVzyTtm/r9FN1rt0NOKvE
         IORVvKuP8b9aeob2urBQfgRyfo/cchw1qh1K46VypM/08X8BNcKoCCAeGe4q7hA/iYJ6
         3XihWK6AjR9UgyQt/3uPhsvz2+GyghCQehKVCkIkN7tlA50jyhsbJb2saqrBGqPSbMkn
         ACPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674159; x=1774278959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmUzIWhvYQPmLKIFrKQ+CmNW3KoiMo1xA15Z136wUAM=;
        b=l0S8TLfcoytdZwgSsDF88pUH9a5x2wG7oXyNnMjmEmm3itmQhgKraGKS8v94JpWa1N
         K1n7mrjduRUFPkFj2pND+e02+ExIWJga87NhtDhwsfE4uaG9gwqmIz1gGb56gsMxJzMn
         4jGBKd8u+qn9TYbM8U3iQvEIKIHZ2Pne6QoF7tLGssDBJAUPWBZFPxdI9tvydCbcq4Ry
         Z/FVxpVaVTt9Zd0XXNeEGp5u+pSMWxMVY1UZ6JKwEcc+DHPJg8gC1D3eDBA9Ck3liGI/
         jjffIiXluDPSjRdM3vAdK6MZZZ2KAh6/WWEFbvp6BGNxHrsQsJIxPFWREdBHePJe7PId
         vsRw==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZMYpcvnKpbExpiHNq3hWLzQqn/uhy6gnzURpR8OLRrHE4zOmKp41bEjVD2qU9gXK5KvaRIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAwiH9wJ4XS/eHcRYNldl2kgCQ2MgLvR9mlaWK8oOZTq5F9CV
	wFXwe7vPzGmxaSsXUJZlPEqJ6IWKHdp+OXbMwhMyKI8d66mCsM1OgiocbVqhR5Of1LE=
X-Gm-Gg: ATEYQzzmle3VECf3W9sEm7nhf1nKodCan439LTGkgMIwwO65aTWSY1pTqPXVJLc5h6k
	sCmQco1M4I4Aw6O7KstPX3PJSglB+oISOoYpP7CaAFeWqNjHj6odxMSG6NGvzLuw21CrDvSeUNF
	yPp420DKDASrEMyZDuFsYZSmZQC1Y02qbpcq0YNyNPehaivYAfNtOt+Bo9eGgfyXAPxJg9edRhG
	cn+w1mx6tfRGD1TRSMSq82uzWYMwiIGQ/fZnGzlUv3o2r42C9m0FSftjU2sWQoTmwZPmKsrJhnP
	B6eUalBIM2KV0+EXpBTq3/0uVNknQshtwJPPfcfDzbPMWPISn+FIlG+Om5jJF3dI0G3QtrVvHlk
	JGxPQ88oY1hWLc2KOlyEGBCWcrgJnzxUq6pFVqrZQsv+G34wEpkW/7e6PFzjjYGN4B/jeGfk45T
	wtMsUFXr7CyfwGQX3oEZZbrry+dI1Rh/AD5BT9QtbArtNfCVeDIOY5pD61z22Kw3ElACZn4jRMe
	v4fL7LCtuMPpC8Dg5mebg==
X-Received: by 2002:a05:600c:3b14:b0:485:17a7:b9c7 with SMTP id 5b1f17b1804b1-485566d5178mr225381115e9.10.1773674158634;
        Mon, 16 Mar 2026 08:15:58 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bd9csm42594654f8f.21.2026.03.16.08.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:15:58 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] genetlink: add multi-version family support for protocol negotiation
Date: Mon, 16 Mar 2026 16:15:06 +0100
Message-ID: <20260316151507.3958299-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linbit-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linbit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268187-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linbit-com.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christoph.boehmwalder@linbit.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linbit.com:email,linbit.com:mid,linbit-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 75B5229C2E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the genetlink infrastructure to allow families to advertise a
range of supported protocol versions [min_version, max_version]. This
enables a single kernel module to serve both old and new userspace by
letting userspace discover the maximum version via CTRL_ATTR_MAX_VERSION
and select the desired protocol dialect in genlmsghdr.version.

Rename genl_family.version to .min_version across all families (pure
rename, no behavioral change). This avoids updating all callers.

Add genl_family.max_version. When 0 (default) the family behaves
exactly as before. When > min_version, the controller advertises
CTRL_ATTR_MAX_VERSION in CTRL_CMD_GETFAMILY replies.

When sending a reply, echo the request's genlmsghdr.version, so
userspace receives responses in the protocol version it spoke.
Notifications (where info->nlhdr is NULL) continue to use min_version.

Add genlmsg_put_ver() for families that need to stamp a specific
version on notifications.

The immediate motivation is upstreaming DRBD 9 (genl family v1)
while keeping unmodified DRBD 8 userspace (family v2) working. The
DRBD family would register with min_version=1, max_version=2 and
handle both protocol dialects.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 include/net/genetlink.h        | 27 +++++++++++++++++------
 include/uapi/linux/genetlink.h |  1 +
 net/netlink/genetlink.c        | 39 ++++++++++++++++++++++++++++------
 3 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 7b84f2cef8b1..7e306bf8436a 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -38,7 +38,11 @@ struct genl_info;
  * struct genl_family - generic netlink family
  * @hdrsize: length of user specific header in bytes
  * @name: name of family
- * @version: protocol version
+ * @version: Only supported version (alias of min_version)
+ * @min_version: lowest protocol version supported
+ * @max_version: highest protocol version supported; when set and
+ *	greater than @min_version the family accepts versions
+ *	[@min_version, @max_version] from userspace
  * @maxattr: maximum number of attributes supported
  * @policy: netlink policy
  * @netnsok: set to true if the family can handle network
@@ -78,7 +82,11 @@ struct genl_info;
 struct genl_family {
 	unsigned int		hdrsize;
 	char			name[GENL_NAMSIZ];
-	unsigned int		version;
+	union {
+		unsigned int	version;
+		unsigned int	min_version;
+	};
+	unsigned int		max_version;
 	unsigned int		maxattr;
 	u8			netnsok:1;
 	u8			parallel_ops:1;
@@ -335,12 +343,19 @@ void genl_notify(const struct genl_family *family, struct sk_buff *skb,
 
 void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
 		  const struct genl_family *family, int flags, u8 cmd);
+void *genlmsg_put_ver(struct sk_buff *skb, u32 portid, u32 seq,
+		      const struct genl_family *family, int flags,
+		      u8 cmd, u8 version);
 
 static inline void *
 __genlmsg_iput(struct sk_buff *skb, const struct genl_info *info, int flags)
 {
-	return genlmsg_put(skb, info->snd_portid, info->snd_seq, info->family,
-			   flags, info->genlhdr->cmd);
+	u8 version = info->nlhdr ? info->genlhdr->version
+				 : info->family->version;
+
+	return genlmsg_put_ver(skb, info->snd_portid, info->snd_seq,
+			       info->family, flags, info->genlhdr->cmd,
+			       version);
 }
 
 /**
@@ -442,8 +457,8 @@ static inline void *genlmsg_put_reply(struct sk_buff *skb,
 				      const struct genl_family *family,
 				      int flags, u8 cmd)
 {
-	return genlmsg_put(skb, info->snd_portid, info->snd_seq, family,
-			   flags, cmd);
+	return genlmsg_put_ver(skb, info->snd_portid, info->snd_seq, family,
+			       flags, cmd, info->genlhdr->version);
 }
 
 /**
diff --git a/include/uapi/linux/genetlink.h b/include/uapi/linux/genetlink.h
index ddba3ca01e39..659aa31592ff 100644
--- a/include/uapi/linux/genetlink.h
+++ b/include/uapi/linux/genetlink.h
@@ -66,6 +66,7 @@ enum {
 	CTRL_ATTR_POLICY,
 	CTRL_ATTR_OP_POLICY,
 	CTRL_ATTR_OP,
+	CTRL_ATTR_MAX_VERSION,
 	__CTRL_ATTR_MAX,
 };
 
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index a23d4c51c089..50ba0c99f648 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -880,18 +880,24 @@ int genl_unregister_family(const struct genl_family *family)
 EXPORT_SYMBOL(genl_unregister_family);
 
 /**
- * genlmsg_put - Add generic netlink header to netlink message
+ * genlmsg_put_ver - Add generic netlink header with explicit version
  * @skb: socket buffer holding the message
  * @portid: netlink portid the message is addressed to
  * @seq: sequence number (usually the one of the sender)
  * @family: generic netlink family
  * @flags: netlink message flags
  * @cmd: generic netlink command
+ * @version: protocol version to stamp on the message
  *
- * Returns pointer to user specific header
+ * Like genlmsg_put() but allows the caller to specify the version field
+ * in the genetlink header.  Useful for families that support multiple
+ * protocol versions and need to send notifications in a specific version.
+ *
+ * Returns: pointer to user specific header, or %NULL on failure.
  */
-void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
-		  const struct genl_family *family, int flags, u8 cmd)
+void *genlmsg_put_ver(struct sk_buff *skb, u32 portid, u32 seq,
+		      const struct genl_family *family, int flags,
+		      u8 cmd, u8 version)
 {
 	struct nlmsghdr *nlh;
 	struct genlmsghdr *hdr;
@@ -903,11 +909,30 @@ void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
 
 	hdr = nlmsg_data(nlh);
 	hdr->cmd = cmd;
-	hdr->version = family->version;
+	hdr->version = version;
 	hdr->reserved = 0;
 
 	return (char *) hdr + GENL_HDRLEN;
 }
+EXPORT_SYMBOL(genlmsg_put_ver);
+
+/**
+ * genlmsg_put - Add generic netlink header to netlink message
+ * @skb: socket buffer holding the message
+ * @portid: netlink portid the message is addressed to
+ * @seq: sequence number (usually the one of the sender)
+ * @family: generic netlink family
+ * @flags: netlink message flags
+ * @cmd: generic netlink command
+ *
+ * Returns pointer to user specific header
+ */
+void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
+		  const struct genl_family *family, int flags, u8 cmd)
+{
+	return genlmsg_put_ver(skb, portid, seq, family, flags, cmd,
+			       family->version);
+}
 EXPORT_SYMBOL(genlmsg_put);
 
 static struct genl_dumpit_info *genl_dumpit_info_alloc(void)
@@ -1237,7 +1262,9 @@ static int ctrl_fill_info(const struct genl_family *family, u32 portid, u32 seq,
 
 	if (nla_put_string(skb, CTRL_ATTR_FAMILY_NAME, family->name) ||
 	    nla_put_u16(skb, CTRL_ATTR_FAMILY_ID, family->id) ||
-	    nla_put_u32(skb, CTRL_ATTR_VERSION, family->version) ||
+	    nla_put_u32(skb, CTRL_ATTR_VERSION, family->min_version) ||
+	    (family->max_version > family->min_version &&
+	     nla_put_u32(skb, CTRL_ATTR_MAX_VERSION, family->max_version)) ||
 	    nla_put_u32(skb, CTRL_ATTR_HDRSIZE, family->hdrsize) ||
 	    nla_put_u32(skb, CTRL_ATTR_MAXATTR, family->maxattr))
 		goto nla_put_failure;

base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.53.0


