Return-Path: <netdev+bounces-120915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D550095B2FD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA89B21D59
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC581802AB;
	Thu, 22 Aug 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IjcYCVUA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE217F394
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322941; cv=none; b=h/644wzrtlgdBUcCgbb1Uum/14QUEQg3TACkkgJfogXO9MhXe9KskGmEllILIgmQTXWymKXR4UGC1mMT8DuFITCMUGmkgc0cBSdPIbeKjDmJXAa1+azgjNjCIzbWBS2pLxv/WYqkTOe+SKziYEjj1fIjfM9i0w4c5oniVgMjGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322941; c=relaxed/simple;
	bh=o1FFmcpCPrRJuA/Mc7pu8b3WWwfP4v3JSesaIqq9qqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjUzApAUkjLKDS6JrI1n8zs41soZY3A2W6Yl/8jX4DgCbBUI1hlQtF3Uv+8bQdJn5RxRxbIhFfEA1ikborVzzvSajZR4FKjtLa6Sud1RbXChPv3uIYM/zCOwzmG5PlOn2q/J3KASI4qn1QqWgZkwfSkETSlGgXSqQgH55Iw98N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IjcYCVUA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7142e002aceso517990b3a.2
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724322938; x=1724927738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0DVBOwUntzNeLVR8GkwsegWyScNk/DPnfEbpS4i7pw=;
        b=IjcYCVUAOKrp69GSbV2BjDMFPWybsahC2hcl0koDoe1SE3yq6fCIS1SqPvt29tTWO/
         2xturZdyrhVlqSHxIMD1v4m6V7XEgLjF+EdLaS9ECR6Uju+w5GCN64sINQlwAyCw31Xy
         GJCqc9+WdqndFf8zKVGJv9Fxy5vrl/H/Y7vwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322938; x=1724927738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0DVBOwUntzNeLVR8GkwsegWyScNk/DPnfEbpS4i7pw=;
        b=O801akcFpiU9y8VVffWxHUCOAk+v0jSvrZmIAFV4QxRzCQsbGRZ1hutYgKYytM5nYP
         TVf/gQEP0HGOBG9vqZALP7P6XKp1qHusQTfam+oUc3bTd4DuJHNv6aee7aQdkNvQeYfi
         Sg2t6HgVPYqIVb3v459utGktPgjyQsF/iCN/0jYsSU14ZxhLdPJ6+wDKI7xXzvywNzMq
         L/deU3CtC6ByULvo5G/9dJP+o1ehSAboOiC9ORbSq0B2HtEepBgVppsZNXoOi9qUnK+E
         /308+6tK86IWsVZScbIazuSDDHQ1zrIbVmQr83g6fyJuOmk2sW4FITkX9FLD1A5NCR0R
         4+0Q==
X-Gm-Message-State: AOJu0Yx3q/YZIMjXvoCrwx53Rl3iLUdr1VHENxaPqjsTonAJim6fQSS7
	NXR6P4TPJX3djKlR7T6piyHPqjn8tKX1aFzLqieHdXfOHKfpvYAnlGJjeMKw6Y5P7RSXNrhYReF
	Vvgw1hrSGcZJ9d/Fetu5QhOOapqa/d8wKohXcqkrmHTync7t1XFZxkbiHMwQ/yLKzkIdKhxuumY
	+Hu2jSZ0mmCp7Fp892eKJS7Qhzw7ijAe0AEuEkbVVbtTkSC4Xx
X-Google-Smtp-Source: AGHT+IFZJ1ahyG2Ca+doAKjQ8pJGrsK5yqgHCaBXBfAN01l2PN/1cfHzuvZ87hNB2SOoWoPlZg+sOw==
X-Received: by 2002:a05:6a00:10c1:b0:713:e70e:f7ea with SMTP id d2e1a72fcca58-71423484c49mr5684637b3a.7.1724322937777;
        Thu, 22 Aug 2024 03:35:37 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cda0ada9adsm495546a12.26.2024.08.22.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:35:37 -0700 (PDT)
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
Subject: [PATCH net-next v4 1/3] tc: adjust network header after 2nd vlan push
Date: Thu, 22 Aug 2024 13:35:08 +0300
Message-ID: <20240822103510.468293-2-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240822103510.468293-1-boris.sukholitko@broadcom.com>
References: <20240822103510.468293-1-boris.sukholitko@broadcom.com>
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
index 22f4b1e8ade9..383bf18b6862 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -96,6 +96,7 @@ TC_INDIRECT_SCOPE int tcf_vlan_act(struct sk_buff *skb,
 	if (skb_at_tc_ingress(skb))
 		skb_pull_rcsum(skb, skb->mac_len);
 
+	skb_reset_mac_len(skb);
 	return action;
 
 drop:
-- 
2.42.0


