Return-Path: <netdev+bounces-266175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMs5EDI5sGlbhQIAu9opvQ
	(envelope-from <netdev+bounces-266175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:30:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DDC253901
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F3F230E9B40
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACD13921F8;
	Tue, 10 Mar 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="esL0Yqqf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0438AC94
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773151892; cv=none; b=fNYp1VtrGyAClkz/wChLSEqVNqZI3p9anXiiZPUcO3YaEL9VaQaWaO8Wl5ETVYO/P66EeBGPBfOd9zZO6nFeHT700N06x2QFWl+aKo3XfjuRxLSvQIZV4L/xMilN7VjZWrw2gRs47Q6oZe6YjJQYmTlyAn9r0tiwT2OZvwnvU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773151892; c=relaxed/simple;
	bh=/e0Er9UMsp4nVY02ymMZVqoTdEP4pEcuQfKkK/1Wua0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QZ/lxkx8BCRztrbGYI3Sl/bQc39pKa3CX8IdchexfsF+CkcGrEVpGMDEn8V+1EszDjK/qbba7aQqkB/4V6SfbcaX3sp3MRwNzzA/jjL8/hd7LVKX9meSCjbIfjAmbfG85q5M/qKZFwr3AhuNC1fzed0g+8dm5qWJuHuVA/KqNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=esL0Yqqf; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-662b5bf4b10so2015415a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773151889; x=1773756689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3WvA+8MkiDJ2EsC15H4tJdtSOI/qr2U5yiZLHPf8Hk=;
        b=esL0YqqfuRWnGjKoffWxGrN2qQi7uMOELjoeggtm4/fN6iP5HzHc3ox4WIkxieNB1Z
         OY/Zq4ENZ9kt/OqPSF8quLCGjXlI9wiraRal9SSm5qMHLY4x4HxP406w132ttUTrYuOA
         57Clx2Xe/qdwc4zrNkR25K+B34QzB5+2xm0VacvKtoWbTEfQRcb+f+75Lx7gUT1RbMlO
         jKui0zAsXVmLSh6vcF0k3DnpzlcWEgu4hbSZKIPnuNeEbMWFhLI+n0ra3nI51vYKmCIF
         zms+N1KH0cb3yC2HPpbvoajxTskaCqINm0Xlqu0aOK38/vLk0iV1R+95yCyVwGlVmpbr
         CGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773151889; x=1773756689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3WvA+8MkiDJ2EsC15H4tJdtSOI/qr2U5yiZLHPf8Hk=;
        b=M73JmuM1Huw94yDwHpvq3iPNsUg7oPrSXDSNS8ALRl+VEstRQdSyy8jL0lw7HXv8Nl
         xiu9fL40N/87DPOTtTTtzSyFAFF2o+8CcQm7ZWbzup+UamXYb4G7RzwUdUS0o0kjR0+F
         NkClg6rSF/wwC6AtWcoh7QHJtiY7Mrc4R5CEYX3CrwvgKwCenHDhMJLdcgIRkHPuWzCX
         aiY/ovsgwUIj1LQS5KFSy4Swd8ZuwEqtebePhVmRLE/dC8vYGGMwRatcn3PIOUI79U/n
         AYX0lvNdv9lBeZ1eRF4TOyk1ykfGzFpuZeero6UQgyIs0e4WjmzF5K/iOKygicB8CAHs
         qNKw==
X-Gm-Message-State: AOJu0Yx8W8kVP0oE0xjwkgMYi7EHTBNE1mSJ+wih86SuImY3V/2dWae2
	qisAYm81aGc2JAw3Kgr7jUuAfwHNWPF8AR60udNy5zMs+IwElAmvvXwu6//jf8bXgBbr5vCJQJm
	ezfeG+3pc9GI5AFnO0bFHMIClLxBchTZBdOmP
X-Gm-Gg: ATEYQzxGjI+tpdiEqyJSXZfh4EQ5m62c727nWn6k9uEhPNLVpYhrs0VP3R38uJtV3UY
	M1BP/mpdiGLcwU3FoELQ/GhUZL/+uJMynhwYBM5k0oqHjPBtRizCE0GyVj4f+ttLLOcwDO12dQa
	h+Pbxk3urSk/rhGSiRlDJaBAwMdfhv3GAS3pOeisfFAUb0CxUsqU3XCNudmKWW0oFNrETJr8kFC
	o8JLLlcFHdj7zxnkVhLqKNviOxVMw9rfgoaryzf0WUQ0SItqcZZr1Zxyj0Fp3dkivwTyaCUcDVY
	oHhepxNQFkvGe/w4KnQbX+eEIDMzRzJ4hClcMBtujtA9tJbUz42rytgn+u3c2JxY4ZqGfLTAtRZ
	LRLRXqLvKARVOP6Xl1rCTLTj1jiCRop+/Ujq+OoTM+GZmxOXjbCToG5GzgEO+TwPXzKUvq21JCA
	==
X-Received: by 2002:a17:907:1c9d:b0:b8e:6d3:ecf9 with SMTP id a640c23a62f3a-b942df80f9fmr916202366b.40.1773151888546;
        Tue, 10 Mar 2026 07:11:28 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b942ef8f80fsm112478666b.36.2026.03.10.07.11.28;
        Tue, 10 Mar 2026 07:11:28 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id 0567C16375;
	Tue, 10 Mar 2026 15:11:28 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH net-next] seg6: add per-route tunnel source address
Date: Tue, 10 Mar 2026 15:10:57 +0100
Message-Id: <20260310141057.3353333-1-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36DDC253901
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,6wind.com];
	TAGGED_FROM(0.00)[bounces-266175-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
tunnel source address. Make seg6_iptunnel handle the new attribute
correctly. It has priority over the configured per-netns tunnel
source address, if any.

Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 include/uapi/linux/seg6_iptunnel.h |  1 +
 net/ipv6/seg6_iptunnel.c           | 79 ++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
index ae78791372b8..485889b19900 100644
--- a/include/uapi/linux/seg6_iptunnel.h
+++ b/include/uapi/linux/seg6_iptunnel.h
@@ -20,6 +20,7 @@
 enum {
 	SEG6_IPTUNNEL_UNSPEC,
 	SEG6_IPTUNNEL_SRH,
+	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
 	__SEG6_IPTUNNEL_MAX,
 };
 #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 3e1b9991131a..4c4c11cd6638 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -49,6 +49,7 @@ static size_t seg6_lwt_headroom(struct seg6_iptunnel_encap *tuninfo)
 
 struct seg6_lwt {
 	struct dst_cache cache;
+	struct in6_addr tunsrc;
 	struct seg6_iptunnel_encap tuninfo[];
 };
 
@@ -65,6 +66,7 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 
 static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
 	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
+	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 };
 
 static int nla_put_srh(struct sk_buff *skb, int attrtype,
@@ -87,23 +89,32 @@ static int nla_put_srh(struct sk_buff *skb, int attrtype,
 }
 
 static void set_tun_src(struct net *net, struct net_device *dev,
-			struct in6_addr *daddr, struct in6_addr *saddr)
+			struct in6_addr *daddr, struct in6_addr *saddr,
+			struct seg6_lwt *slwt)
 {
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 	struct in6_addr *tun_src;
 
-	rcu_read_lock();
-
-	tun_src = rcu_dereference(sdata->tun_src);
-
-	if (!ipv6_addr_any(tun_src)) {
-		memcpy(saddr, tun_src, sizeof(struct in6_addr));
+	/* Priority order:
+	 *  - per route tunnel source address
+	 *  - per network namespace source address
+	 *  - dynamic resolution
+	 */
+	if (!ipv6_addr_any(&slwt->tunsrc)) {
+		memcpy(saddr, &slwt->tunsrc, sizeof(struct in6_addr));
 	} else {
-		ipv6_dev_get_saddr(net, dev, daddr, IPV6_PREFER_SRC_PUBLIC,
-				   saddr);
-	}
+		rcu_read_lock();
+		tun_src = rcu_dereference(sdata->tun_src);
+
+		if (!ipv6_addr_any(tun_src)) {
+			memcpy(saddr, tun_src, sizeof(struct in6_addr));
+		} else {
+			ipv6_dev_get_saddr(net, dev, daddr,
+					   IPV6_PREFER_SRC_PUBLIC, saddr);
+		}
 
-	rcu_read_unlock();
+		rcu_read_unlock();
+	}
 }
 
 /* Compute flowlabel for outer IPv6 header */
@@ -182,7 +193,8 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 	isrh->nexthdr = proto;
 
 	hdr->daddr = isrh->segments[isrh->first_segment];
-	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr,
+		    seg6_lwt_lwtunnel(dst->lwtstate));
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
@@ -272,7 +284,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 	if (skip_srh) {
 		hdr->nexthdr = proto;
 
-		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
+		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr,
+			    seg6_lwt_lwtunnel(dst->lwtstate));
 		goto out;
 	}
 
@@ -308,7 +321,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 srcaddr:
 	isrh->nexthdr = proto;
-	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr,
+		    seg6_lwt_lwtunnel(dst->lwtstate));
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (unlikely(!skip_srh && sr_has_hmac(isrh))) {
@@ -678,6 +692,10 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 		if (family != AF_INET6)
 			return -EINVAL;
 
+		if (tb[SEG6_IPTUNNEL_SRC]) {
+			NL_SET_ERR_MSG(extack, "unexpected tunsrc with inline");
+			return -EINVAL;
+		}
 		break;
 	case SEG6_IPTUN_MODE_ENCAP:
 		break;
@@ -702,13 +720,21 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	slwt = seg6_lwt_lwtunnel(newts);
 
 	err = dst_cache_init(&slwt->cache, GFP_ATOMIC);
-	if (err) {
-		kfree(newts);
-		return err;
-	}
+	if (err)
+		goto free_lwt_state;
 
 	memcpy(&slwt->tuninfo, tuninfo, tuninfo_len);
 
+	if (tb[SEG6_IPTUNNEL_SRC]) {
+		slwt->tunsrc = nla_get_in6_addr(tb[SEG6_IPTUNNEL_SRC]);
+
+		if (ipv6_addr_any(&slwt->tunsrc)) {
+			err = -EINVAL;
+			NL_SET_ERR_MSG(extack, "tunsrc cannot be ::");
+			goto free_dst_cache;
+		}
+	}
+
 	newts->type = LWTUNNEL_ENCAP_SEG6;
 	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
 
@@ -720,6 +746,12 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 	*ts = newts;
 
 	return 0;
+
+free_dst_cache:
+	dst_cache_destroy(&slwt->cache);
+free_lwt_state:
+	kfree(newts);
+	return err;
 }
 
 static void seg6_destroy_state(struct lwtunnel_state *lwt)
@@ -730,11 +762,18 @@ static void seg6_destroy_state(struct lwtunnel_state *lwt)
 static int seg6_fill_encap_info(struct sk_buff *skb,
 				struct lwtunnel_state *lwtstate)
 {
-	struct seg6_iptunnel_encap *tuninfo = seg6_encap_lwtunnel(lwtstate);
+	struct seg6_lwt *slwt = seg6_lwt_lwtunnel(lwtstate);
+	int err;
 
-	if (nla_put_srh(skb, SEG6_IPTUNNEL_SRH, tuninfo))
+	if (nla_put_srh(skb, SEG6_IPTUNNEL_SRH, slwt->tuninfo))
 		return -EMSGSIZE;
 
+	if (!ipv6_addr_any(&slwt->tunsrc)) {
+		err = nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
-- 
2.39.2


