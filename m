Return-Path: <netdev+bounces-120914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACFD95B2FC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E2FB21D8D
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D9183CA5;
	Thu, 22 Aug 2024 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ObA5RvOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94AA181334
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322931; cv=none; b=pTnNKhBOqHUH7eOK+Le/0df4acJdT8HnFbRoeI+ZYrrubEhAJT2AoGBExdmt2anQhZ4RFb5XyvN1iGmo34ddJQqgppP76/WqV1TKFPvu49WXi2Zb/+7aekW5G3pUvkiLohlOKpfKXGUGgjo0vMv9mei+GvZ1F47o6ucBvGfT7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322931; c=relaxed/simple;
	bh=twAOZ3u+vWDjrLsrJhX3ZPPGiqTlz6ngvMNw5u6Q+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmEaF1UVz3UzYNV9SzBp95EL9W5F1JHkba129c12ZZ66B1Zt6CZBD6EnWiVdgNaVwqN3QJOD93uPPHIZTm8GuOPevO34723b9MW1NGnrxuLk/cj869jLaDDtd1e4tkZcqmPmC9jwv4IHk5fkHv4ItvJCmVxG0cgHBjZZfHzZkF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ObA5RvOM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71423704ef3so541198b3a.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724322929; x=1724927729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sbq+yLenr8Y7ZavyBd5ufSbriAzixSYEeVnLf/6Orjk=;
        b=ObA5RvOMoJQHe+FplHtK5eghMygf/KM0QWtCi8EWhoTccQ5CSd62SlJoYEyvD3ek9Q
         H4Gf0O90zxl53uUp0oEp1bn/PwuAIsH64gurP5xEpKmAXQ4BBQXI0KADP1rU932xsXgf
         3+nh76im0+6LfJyOdeiJRWqDHbMa86tJZLJmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322929; x=1724927729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sbq+yLenr8Y7ZavyBd5ufSbriAzixSYEeVnLf/6Orjk=;
        b=ft1D0MhR7cpfsUyoHAPVgrxvpd0kHU9/iiO0h+pSIwlIAbGbVLefna3LRwK2GEI6+T
         ubD5jXq85sce6gV3IHgnQ3JbzD3wZzUrrTanoHlFK1h+0uEZFdIGKSRVvYHhN6pAXNqc
         61exxdxlJ35JZzwavx7IFNrmhUHJTymooDd1AjDo7MEqjbifwu7H6LoxsPD8qnhKoIUl
         tCwn/R5tOGkhGNgPInq97A9FJ+bYedA4UJ13BaU40tfEn7nhWPneUN9WN5bNIwb6FNTx
         glIqe6LVo+CpFAH5I33Tj1/+KDcvAplg55zawfpFnAfC/QqcHc+bANSCAkHWFz5gDWfr
         f/xA==
X-Gm-Message-State: AOJu0YwhqTJAVtJQFdltA6J6TnI6EUBEco5wlzZNOvX5fO6rmncPCe2N
	r/5yI38enhAWuZrK9VTAEGm6YGhtBJBquLX3GzPvJ7d42dfwlVQRMWdDuUmRp+rqV/TkEnPafcg
	B7SVgUgugxa7gRi+3eVlYDgnLmKYC1ZBHpnBgSFnb6B8MmgSm+hyUDqcL3r8F5MSdhtT5hrL/6h
	SjLGMipCGCtgMYUY/swwqMG4sPxZhp9wV/6XvyAXXhfoYQLp25
X-Google-Smtp-Source: AGHT+IG1mjvCpTclyEyHK39KPWcMvtDgRXpnNiT6Zd9XMOhkrieFWibYVgN4dnUjtVOrYt7RkaTpeA==
X-Received: by 2002:a05:6a00:10c4:b0:706:29e6:2ed2 with SMTP id d2e1a72fcca58-71436488fd8mr1476865b3a.5.1724322928315;
        Thu, 22 Aug 2024 03:35:28 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cda0ada9adsm495546a12.26.2024.08.22.03.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:35:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 0/3] tc: adjust network header after 2nd vlan push
Date: Thu, 22 Aug 2024 13:35:07 +0300
Message-ID: <20240822103510.468293-1-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
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

More about the patch series:

* patch 1 fixes skb_vlan_push and the callers
* patch 2 adds ingress tc_actions test
* patch 3 adds egress tc_actions test

Thanks,
Boris.

v4:
    - s/skb_reset_mac_header/skb_reset_mac_len/ typo in act_vlan.c

v3:
    - rewrite to fix skb_vlan_push amending the callers
    - fix ingress tc_actions test as suggested by Ido
    - add egress tc_actions test

v2:
    - add test to tc_actions.sh

Boris Sukholitko (3):
  tc: adjust network header after 2nd vlan push
  selftests: tc_actions: test ingress 2nd vlan push
  selftests: tc_actions: test egress 2nd vlan push

 net/core/filter.c                             |  1 +
 net/core/skbuff.c                             |  2 +-
 net/openvswitch/actions.c                     |  8 +++-
 net/sched/act_vlan.c                          |  1 +
 .../selftests/net/forwarding/tc_actions.sh    | 46 ++++++++++++++++++-
 5 files changed, 54 insertions(+), 4 deletions(-)

-- 
2.42.0


