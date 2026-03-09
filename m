Return-Path: <netdev+bounces-265472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHUsEI+irmk9HAIAu9opvQ
	(envelope-from <netdev+bounces-265472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:35:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA0237329
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 11:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA3BE304F20A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 10:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA23803C9;
	Mon,  9 Mar 2026 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="F0rlH0zl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfTt2LRH"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06753793DA
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052398; cv=none; b=T4D+Gez+LQ4ih6YWPR2HpNUaNNwXq45vjr+wpImFTTGOKIg7AHBHC5LCbiWaCyFvP9A65kPHj8OLxHP6c4ClMivBCI2o35PW1/cPKebJBgGXKSW/npPaP43fqP/Z9isVADn60N1N7xpYexDwSN7rC651f6XN6j9aEc3ckfl3fug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052398; c=relaxed/simple;
	bh=Rp4GBk8Zur9oSE8s+OsFnfgIMoXfjHODDFxqEAI+0+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLpTveU5TjtykhXF2st8F1JP0y73odd/0/t5hqlQVIE00mt8/87PbuZj4hPc+0to180s7MMI87BzfENF9ZPgd0zsr3DPwUcC76wzLpOl5cq89SwSV3/lor2+xpNkFpWBQbO39fm0BDZXwJ5zoUlKl0/VPUKcK1izfrgProZqSKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=F0rlH0zl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfTt2LRH; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBD257A0119;
	Mon,  9 Mar 2026 06:33:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 06:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773052396; x=
	1773138796; bh=d3owRFBkRApo1R7jmjIfWshF74adbRS4/XOceeoqThw=; b=F
	0rlH0zl2QVNI2WkYwVmj7BTpsxakO+qNS7cV/yHO0RpFzKc9nMLrEv9eSPfoxJnp
	VEEERaAdraWbfztZjLzBzvgpnG4C+rg1DpSZ4/C0loAJ1NnZ0a9T+neOVUns9o1T
	s6HXKDn1UATlS1diAn+D5RaXAD6BcvS85cC62qw2eEDnK0whLuPM9k4AsUhhteIt
	ai/7O1SPCiMq+hg/dbyEcSaci+3F3Xi4oHbj84vaKGCB/MQHFlie6OubE67KgJ3E
	MZtg/Bvtsz2lbHlIah1HBpMl3fBWw5cD860M7uc0/s0dJ+0YW3AwedzkwVnasz7p
	23Azbx6e1YJRAh19JDQuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773052396; x=1773138796; bh=d
	3owRFBkRApo1R7jmjIfWshF74adbRS4/XOceeoqThw=; b=cfTt2LRHOpCPxkq1F
	yZ/k4VTWisPzd3/32c1e5Nr2sRrGDrGIKzl/LIOs1/x0JV1mnotyC1HF+X8yg5Ns
	PIS6ne9LsbREsBG33bqUK3VDSOAVFp+FY336Lu415EwTfdJH0/LNma/xq0kuj3W2
	IMBeYwb8fatWtuv/QN3LSYzE+6fx8Velqia3NerReM0ky2U77AwXN80O4HNLKxHK
	/o/8BKHxhD35zzTxHpDuBHMs9PXulqrGFWKhs2xi3JYzZZxfdiu4+6HGodk9SmeQ
	m0SABvp/3bkiG7+EqmnyuxdIm1T/E3dQsJ+EZssj8FL9D+/HjrDAX9QfuyelUjIf
	HqDNg==
X-ME-Sender: <xms:7KGuaWPLyz-f3r2-LLg6MXXRkh4oBPNuFDGWPYNQqh1cJEkaztUXNA>
    <xme:7KGuaQbZWuolz6fPrvqFxVH15lmekMtmY0ljbeLZs9r0PIwKfnekSuvxJOrCrzGlr
    jJLLyjvFDtYgoZgPwda6EpcUaqp6CcVSIz5aaRIcQdu8r5OtWqoj9A>
X-ME-Received: <xmr:7KGuaQzfHDWyE4uGjOgUmLg27zNaYLtf8q_t3oJ7gJZy_ibJpKA9YN3bx4KC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeejkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrshhsvghrthesshgvtghunhgv
    thdrtghomhdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdroh
    hrghdrrghupdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvght
X-ME-Proxy: <xmx:7KGuabKm7K_drfjGl1UJAQcvHI84Agvdw9VG-f778b8D3jTBrjkKsQ>
    <xmx:7KGuaap4sTBYzMgUmlIeBIDb952dgLeX6U_m-h2_J62bt6cDrRjldQ>
    <xmx:7KGuaaJGUlzBayWgJrJy52nGnqUPB8UnzNplCbW3F45S7UnTxBpG6g>
    <xmx:7KGuafRb6wgqMtQYOI00Eg0v6hAI2CCdbRvCr27GM9IWF8VEW3CamA>
    <xmx:7KGuacBsZ4spGF5VwTDcZWJCy2_ZvKu4gNBYURIvS-IpO_PSRaecy2rd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 06:33:16 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next 10/10] xfrm: avoid RCU warnings around the per-netns netlink socket
Date: Mon,  9 Mar 2026 11:32:43 +0100
Message-ID: <6d736a2ef85c47f901f6d3a51a7744d52c50b417.1773051558.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0EA0237329
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

net->xfrm.nlsk is used in 2 types of contexts:
 - fully under RCU, with rcu_read_lock + rcu_dereference and a NULL check
 - in the netlink handlers, with requests coming from a userspace socket

In the 2nd case, net->xfrm.nlsk is guaranteed to stay non-NULL and the
object is alive, since we can't enter the netns destruction path while
the user socket holds a reference on the netns.

After adding the __rcu annotation to netns_xfrm.nlsk (which silences
sparse warnings in the RCU users and __net_init code), we need to tell
sparse that the 2nd case is safe. Add a helper for that.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/netns/xfrm.h |  2 +-
 net/xfrm/xfrm_user.c     | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 23dd647fe024..b73983a17e08 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -59,7 +59,7 @@ struct netns_xfrm {
 	struct list_head	inexact_bins;
 
 
-	struct sock		*nlsk;
+	struct sock		__rcu *nlsk;
 	struct sock		*nlsk_stash;
 
 	u32			sysctl_aevent_etime;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..88fdbdc099a3 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -35,6 +35,15 @@
 #endif
 #include <linux/unaligned.h>
 
+static struct sock *xfrm_net_nlsk(const struct net *net, const struct sk_buff *skb)
+{
+	/* get the source of this request, see netlink_unicast_kernel */
+	const struct sock *sk = NETLINK_CB(skb).sk;
+
+	/* sk is refcounted, the netns stays alive and nlsk with it */
+	return rcu_dereference_protected(net->xfrm.nlsk, sk->sk_net_refcnt);
+}
+
 static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type,
 			  struct netlink_ext_ack *extack)
 {
@@ -1727,7 +1736,7 @@ static int xfrm_get_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_spdinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
 
 static inline unsigned int xfrm_sadinfo_msgsize(void)
@@ -1787,7 +1796,7 @@ static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_sadinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
 
 static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1807,7 +1816,7 @@ static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (IS_ERR(resp_skb)) {
 		err = PTR_ERR(resp_skb);
 	} else {
-		err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+		err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 	}
 	xfrm_state_put(x);
 out_noput:
@@ -1897,7 +1906,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 
 out:
 	xfrm_state_put(x);
@@ -2542,7 +2551,7 @@ static int xfrm_get_default(struct sk_buff *skb, struct nlmsghdr *nlh,
 	r_up->out = net->xfrm.policy_default[XFRM_POLICY_OUT];
 	nlmsg_end(r_skb, r_nlh);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, portid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, portid);
 }
 
 static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -2608,7 +2617,7 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (IS_ERR(resp_skb)) {
 			err = PTR_ERR(resp_skb);
 		} else {
-			err = nlmsg_unicast(net->xfrm.nlsk, resp_skb,
+			err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb,
 					    NETLINK_CB(skb).portid);
 		}
 	} else {
@@ -2781,7 +2790,7 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_aevent(r_skb, x, &c);
 	BUG_ON(err < 0);
 
-	err = nlmsg_unicast(net->xfrm.nlsk, r_skb, NETLINK_CB(skb).portid);
+	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, NETLINK_CB(skb).portid);
 	spin_unlock_bh(&x->lock);
 	xfrm_state_put(x);
 	return err;
@@ -3483,7 +3492,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto err;
 		}
 
-		err = netlink_dump_start(net->xfrm.nlsk, skb, nlh, &c);
+		err = netlink_dump_start(xfrm_net_nlsk(net, skb), skb, nlh, &c);
 		goto err;
 	}
 
-- 
2.51.2


