Return-Path: <netdev+bounces-119673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCEA9568FC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07CC1F22E0D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ECC1662EC;
	Mon, 19 Aug 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Sb3jLBXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957615535B
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065601; cv=none; b=Li5dE+/gjBvoK39rkqqS2QlN83GTvl0j1pzkFjIDYuYjzLo2QKmqM0IQWTTVcTI70ecCZLYJIaRDyRqRAhXBV8qx9uarMmKWKmDOQt9wxifcuwawTiS0rVqBM+Irrnth31wB88KXQmWsw6j2Rc4RbKf5nYQeAF0fYAn4D8VnCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065601; c=relaxed/simple;
	bh=xEAPvojJgqvr6PvJJHtBhFBxIdKTGTScam8mW+yLFYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMQK1ARAD+4mIfwsKhzzQ3pFCj/g5ppzjkBZrBrk6sqG6FbALNM5YqSM+kwAzx5f16HS/zpjHJeheH5OKB6JmKKb2WezC6dxir7a9rbVn/0lNmAaQfL9pHkHQ2Vu/fGsXSH0lgapY7Gk6d2Afz7n+HST9n7Gu5ESdiT7q5k38QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Sb3jLBXJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44fe58fcf2bso25832691cf.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724065598; x=1724670398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZGFDxagONzXz7FVMHRPtOUOk+m8UJRKia/lDd9q95E=;
        b=Sb3jLBXJAMOO3RrLQMemU85bJX4l6J032RJC7mmctYAn7lkoGAv/bBTJlDrSgeTWwf
         eN+T8jQHVXaqw7MRt+eP95dp8MixtlRqgyp8b0GP1xh0qGvAp73LEPC1x/wKkg9ztXu4
         G2yVly+KN2BBifN7jF++5bCQY80rTa9FtEqmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065598; x=1724670398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZGFDxagONzXz7FVMHRPtOUOk+m8UJRKia/lDd9q95E=;
        b=GShrYaaD74g98TY/xRkPhwGGAipKqgX33y4bLET7ZHmqKXlGkq5ZI8w2Vieoq8jMyO
         +YF1D4AXYDYdRAqKVkru5BJ7y4y1r/7RsbpjrLvs7ZOReAX49U6UQhjcCzlzZb6KmpTF
         Lnx9yMhKSCsNz5pbgshDeA0qabHXeaswVGsKV/LmnR3E+41W8GdaBWWk1/2/k2OQ/Lo/
         NQwG9guY2wktThf/KcHeaFtTltoJskIvTAQ38MjVKQFNOMhLYiXzLofEuPv8TMz5CXNa
         5FgVW11suIHVfj3b2c04Elu8XjIHkAVm/m4oAvc8eoLjkcK8JZvEbCrTOMsaLHk76Yd8
         pYwA==
X-Gm-Message-State: AOJu0YxXd1GOdlZnBD+2+IszZ529ByuzdRkrmgpOEb1CoubkOqnZEDf1
	Jn30eFH053PAAtJlNjg/uMBn62TqRqV9KoWiMBju1K5Sb1xVH5wxI7LVzQrQ+h/Rafu6m43GrYP
	hMS/UV7mDMPDT48hE5cqe3hwq58aZrWnmS7NJ1wmBViuxnNA/A4ScG85ld2IaDofHl6zHJZ1dj3
	bV1H24ES5ACmhJfFCIo3EIwEcSo+Hzfe9UGdCAjTSv51gnO2sW
X-Google-Smtp-Source: AGHT+IFXBuSSPVIEHAX7lrVuAdoXkNg0kj1cCNyYxaj2XgTLVCLTRZwtxYlg0aWhbKB+AahSw6a6TA==
X-Received: by 2002:a05:622a:4ac9:b0:44f:dd14:5cd0 with SMTP id d75a77b69052e-453742facb4mr150315491cf.35.1724065597615;
        Mon, 19 Aug 2024 04:06:37 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072237sm38751911cf.86.2024.08.19.04.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:06:37 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Mina Almasry <almasrymina@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Howells <dhowells@redhat.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Ido Schimmel <idosch@idosch.org>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next v3 1/3] tc: adjust network header after 2nd vlan push
Date: Mon, 19 Aug 2024 14:06:07 +0300
Message-ID: <20240819110609.101250-2-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240819110609.101250-1-boris.sukholitko@broadcom.com>
References: <20240819110609.101250-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<tldr>
skb network header of the single-tagged vlan packet continues to point the
vlan payload (e.g. IP) after second vlan tag is pushed by tc act_vlan. This
causes problem at the dissector which expects double-tagged packet network
header to point to the inner vlan.

The fix is to adjust network header in tcf_act_vlan.c but requires
refactoring of skb_vlan_push function.
</tldr>

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
		err = skb_vlan_push(skb, p->tcfv_push_proto, p->tcfv_push_vid |
				    (p->tcfv_push_prio << VLAN_PRIO_SHIFT),
				    0);
		if (err)
			goto drop;
		break;

	....

out:
	if (skb_at_tc_ingress(skb))
[3]		skb_pull_rcsum(skb, skb->mac_len);

And skb_vlan_push (net/core/skbuff.c:6204) function does:

		err = __vlan_insert_tag(skb, skb->vlan_proto,
					skb_vlan_tag_get(skb));
		if (err)
			return err;

		skb->protocol = skb->vlan_proto;
[2]		skb->mac_len += VLAN_HLEN;

in the case of pushing the second tag. Lets look at what happens with
skb->data of the single-tagged packet at each of the above points:

1. As a result of the skb_push_rcsum, skb->data is moved back to the start
   of the packet.

2. First VLAN tag is moved from the skb into packet buffer, skb->mac_len is
   incremented, skb->data still points to the start of the packet.

3. As a result of the skb_pull_rcsum, skb->data is moved forward by the
   modified skb->mac_len, thus pointing to the network header again.

Then __skb_flow_dissect will get confused by having double-tagged vlan
packet with the skb->data at the network header.

The solution for the bug is to preserve "skb->data at second vlan header"
semantics in the skb_vlan_push function. We do this by manipulating
skb->network_header rather than skb->mac_len. skb_vlan_push callers are
updated to do skb_reset_mac_len.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 net/core/filter.c         | 1 +
 net/core/skbuff.c         | 2 +-
 net/openvswitch/actions.c | 8 ++++++--
 net/sched/act_vlan.c      | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index f3c72cf86099..74d2c906f35a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3189,6 +3189,7 @@ BPF_CALL_3(bpf_skb_vlan_push, struct sk_buff *, skb, __be16, vlan_proto,
 	bpf_push_mac_rcsum(skb);
 	ret = skb_vlan_push(skb, vlan_proto, vlan_tci);
 	bpf_pull_mac_rcsum(skb);
+	skb_reset_mac_len(skb);
 
 	bpf_compute_data_pointers(skb);
 	return ret;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index de2a044cc665..2c8f6f34c545 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6244,7 +6244,7 @@ int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
 			return err;
 
 		skb->protocol = skb->vlan_proto;
-		skb->mac_len += VLAN_HLEN;
+		skb->network_header -= VLAN_HLEN;
 
 		skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
 	}
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 101f9a23792c..16e260014684 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -237,14 +237,18 @@ static int pop_vlan(struct sk_buff *skb, struct sw_flow_key *key)
 static int push_vlan(struct sk_buff *skb, struct sw_flow_key *key,
 		     const struct ovs_action_push_vlan *vlan)
 {
+	int err;
+
 	if (skb_vlan_tag_present(skb)) {
 		invalidate_flow_key(key);
 	} else {
 		key->eth.vlan.tci = vlan->vlan_tci;
 		key->eth.vlan.tpid = vlan->vlan_tpid;
 	}
-	return skb_vlan_push(skb, vlan->vlan_tpid,
-			     ntohs(vlan->vlan_tci) & ~VLAN_CFI_MASK);
+	err = skb_vlan_push(skb, vlan->vlan_tpid,
+			    ntohs(vlan->vlan_tci) & ~VLAN_CFI_MASK);
+	skb_reset_mac_len(skb);
+	return err;
 }
 
 /* 'src' is already properly masked. */
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 22f4b1e8ade9..9e2dbde3cc29 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -96,6 +96,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 	if (skb_at_tc_ingress(skb))
 		skb_pull_rcsum(skb, skb->mac_len);
 
+	skb_reset_mac_header(skb);
 	return action;
 
 drop:
-- 
2.42.0


