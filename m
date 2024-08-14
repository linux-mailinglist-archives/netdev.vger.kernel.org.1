Return-Path: <netdev+bounces-118468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A53951B60
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778A4282331
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6778C1B1411;
	Wed, 14 Aug 2024 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d/tMg0nB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6211AED2E
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640821; cv=none; b=uspWyi12Yh6Q+Vf9XxEEIPW4zwAypKuomgWbFcu6wOvoA5iXNr9qc7PqZ45LKH/phRxNH2i8kBsd6w2d33RzEtRtUMgpnyElXHvmUtYHFZN1eijsziboN5Xlptao1HL3XJFnptrBhZXY9jVKOFAEXAaq+gZntLG8pFBFeRZLd/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640821; c=relaxed/simple;
	bh=awncP+NbvdzC4cT4Ugklak4GH4LxTINDlQi4Kzk3Y1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4XkRLe7BEE+L7PyO54ZxvSyYO+QJBOLaFuB8M7ZdVP5diqPSeYTt4FAFqcgWsQMDSjZfwrLDc7YyoXjhIsnp9qZ54EsZEc9EjKIJqgbzWHdO3Z6HVgPgFNw0ooGdbWIC7DclBiajfTjZ1VcCJIYVVhECnb8PWspXfxx6Pfu4cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d/tMg0nB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so4688729b3a.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640819; x=1724245619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+8wRwU8tWwhWYpBIsJnKE89P/+rgqOTvwYqNON+ucs=;
        b=d/tMg0nBMqleBi5I2/qrkm3x7VpzYFVtkL7FK7XS8Knq8ik0yTpeS2r7TQNbhqXfox
         QHhNz9YWs2Q2bcLbesMIhPVzFlzagYBA8+5TFqy8p6b9P6Cvt4bOtCFZesvG9i7GRdm6
         pbtkQ85J4w41f/zvCkKoVogjPdVTBqquVUMBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640819; x=1724245619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+8wRwU8tWwhWYpBIsJnKE89P/+rgqOTvwYqNON+ucs=;
        b=psl8EYAVIZNtkl6IVaRNXnwGevgKE5QJw5osZA4FzvVvYepoke+Z0g2DA4cGLKVU+0
         iDFRV68nKQGgaffCrL2xumx8x5PaH9PE9UV30RI6uPo6GGrP5Ntdeeo8qKC5m5I3qTuU
         pP7I1cJqecRhDJrr0QTYujsH3EvgpLtVGxdRHNuk5nvzHSoaoIIi4QgW/UEqLjgBv7P1
         T9RV/3CtdLepTjGPIAZ4i84LyZPix5JyeYWTDNH+zUAsx6W/F4+5tzi/5dTR3r/jBIkI
         DsalSoqw5O0TXgQm3py7xg6j4kPWuJeyKjffsSzvPkKYU+AWVqp1TjvFMMNGieNbQTTn
         g7DA==
X-Gm-Message-State: AOJu0Yywc/sL9c8aJSHi0Q3olOZsv7Hf2IYMma9J8BJeYieX9D7c76pM
	KlrIE742PbiRVGURnIVY/Z47hbDNtSS/HLBtRwEDwYA0uTk4csI83SLbAlEuWfYvOfqjHWSoH0I
	GVXINGo0aBDDTDXM5QG+QjGv4yJdpEun/ZYoPCWxfidVYAUmAqN/CLN/SLu3IquQCS+R0m9JvNZ
	gfcleSmyqF0TqrGltJM5kW5tLJBJvmjqKfRZk2Z33PdB/oRT5s
X-Google-Smtp-Source: AGHT+IHLsvZ9uxUhCbWDraEppjMGzCyB1fcQYQGKk299s0XvtoUHR1kzCLkSxE575LGj2u3tKeqCEg==
X-Received: by 2002:a05:6a00:3a25:b0:70a:f57c:fa27 with SMTP id d2e1a72fcca58-712673ac923mr2911907b3a.19.1723640818422;
        Wed, 14 Aug 2024 06:06:58 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-711841effe9sm4904543b3a.31.2024.08.14.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:06:57 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next v2 5/6] act_vlan: adjust network header
Date: Wed, 14 Aug 2024 16:06:17 +0300
Message-ID: <20240814130618.2885431-6-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consider the following shell script snippet configuring TC rules on the
veth interface:

ip link add veth0 type veth peer veth1
ip link set veth0 up
ip link set veth1 up

tc qdisc add dev veth0 clsact

tc filter add dev veth0 ingress pref 10 chain 0 flower \
	num_of_vlans 2 cvlan_ethtype 0x800 action goto chain 5
tc filter add dev veth0 ingress pref 20 chain 0 flower \
	num_of_vlans 1 action vlan push id 100 \
	protocol 0x8100 action goto chain 5
tc filter add dev veth0 ingress pref 30 chain 5 flower \
	num_of_vlans 2 cvlan_ethtype 0x800 action simple sdata "success"

Sending double-tagged vlan packet with the IP payload inside:

cat <<ENDS | text2pcap - - | tcpreplay -i veth1 -
0000  00 00 00 00 00 11 00 00 00 00 00 22 81 00 00 64   ..........."...d
0010  81 00 00 14 08 00 45 04 00 26 04 d2 00 00 7f 11   ......E..&......
0020  18 ef 0a 00 00 01 14 00 00 02 00 00 00 00 00 12   ................
0030  e1 c7 00 00 00 00 00 00 00 00 00 00               ............
ENDS

will match rule 10, goto rule 30 in chain 5 and correctly emit "success" to
the dmesg.

OTOH, sending single-tagged vlan packet:

cat <<ENDS | text2pcap - - | tcpreplay -i veth1 -
0000  00 00 00 00 00 11 00 00 00 00 00 22 81 00 00 14   ..........."....
0010  08 00 45 04 00 2a 04 d2 00 00 7f 11 18 eb 0a 00   ..E..*..........
0020  00 01 14 00 00 02 00 00 00 00 00 16 e1 bf 00 00   ................
0030  00 00 00 00 00 00 00 00 00 00 00 00               ............
ENDS

will match rule 20, will push the second vlan tag but will *not* match
rule 30. IOW, the match at rule 30 fails if the second vlan was freshly
pushed by the kernel.

Lets look at  __skb_flow_dissect working on the double-tagged vlan packet.
Here is the relevant code from around net/core/flow_dissector.c:1277
copy-pasted here for convenience:

	if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX &&
	    skb && skb_vlan_tag_present(skb)) {
		proto = skb->protocol;
	} else {
		vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
					    data, hlen, &_vlan);
		if (!vlan) {
			fdret = FLOW_DISSECT_RET_OUT_BAD;
			break;
		}

		proto = vlan->h_vlan_encapsulated_proto;
		nhoff += sizeof(*vlan);
	}

The "else" clause above gets the protocol of the encapsulated packet from
the skb data at the network header location. printk debugging has showed
that in the good double-tagged packet case proto is
htons(0x800 == ETH_P_IP) as expected. However in the single-tagged packet
case proto is garbage leading to the failure to match tc filter 30.

proto is being set from the skb header pointed by nhoff parameter which is
defined at the beginning of __skb_flow_dissect
(net/core/flow_dissector.c:1055 in the current version):

		nhoff = skb_network_offset(skb);

Therefore the culprit seems to be that the skb network offset is different
between double-tagged packet received from the interface and single-tagged
packet having its vlan tag pushed by TC.

Lets look at the interesting points of the lifetime of the single/double
tagged packets as they traverse our packet flow.

Both of them will start at __netif_receive_skb_core where the first vlan
tag will be stripped:

	if (eth_type_vlan(skb->protocol)) {
		skb = skb_vlan_untag(skb);
		if (unlikely(!skb))
			goto out;
	}

At this stage in double-tagged case skb->data points to the second vlan tag
while in single-tagged case skb->data points to the network (eg. IP)
header.

Looking at TC vlan push action (net/sched/act_vlan.c) we have the following
code at tcf_vlan_act (interesting points are in square brackets):

	if (skb_at_tc_ingress(skb))
[1]		skb_push_rcsum(skb, skb->mac_len);

	....

	case TCA_VLAN_ACT_PUSH:
		if (skb_vlan_tag_present(skb)) {
			int err = skb_vlan_flush(skb);
			if (err)
				goto drop;

[2]			skb->mac_len += VLAN_HLEN;
		}
		break;

	....

out:
	if (skb_at_tc_ingress(skb))
[3]		skb_pull_rcsum(skb, skb->mac_len);

Lets look at what happens with skb->data of the single-tagged packet at
each of the above points:

1. As a result of the skb_push_rcsum, skb->data is moved back to the start
   of the packet.

2. First VLAN tag is moved from the skb into packet buffer, skb->mac_len is
   incremented, skb->data still points to the start of the packet.

3. As a result of the skb_pull_rcsum, skb->data is moved forward by the
   modified skb->mac_len, thus pointing to the network header again.

Then __skb_flow_dissect will get confused by having double-tagged vlan
packet with the skb->data at the network header.

The same bug happens also on the egress path. The root cause there is that
skb->network_header is in disagreement with skb->mac_len.

This patch fixes both of the above problems by adjusting
skb->network_header rather than skb->mac_vlan. skb->mac_vlan is being reset
accordingly after skb_pull_rcsum is done.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 net/sched/act_vlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 84b79096df2a..c113f8026f1f 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -54,7 +54,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 			if (err)
 				goto drop;
 
-			skb->mac_len += VLAN_HLEN;
+			skb->network_header -= VLAN_HLEN;
 		}
 		__vlan_hwaccel_put_tag(skb, p->tcfv_push_proto, p->tcfv_push_vid |
 				    (p->tcfv_push_prio << VLAN_PRIO_SHIFT));
@@ -101,6 +101,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 	if (skb_at_tc_ingress(skb))
 		skb_pull_rcsum(skb, skb->mac_len);
 
+	skb_reset_mac_len(skb);
 	return action;
 
 drop:
-- 
2.42.0


