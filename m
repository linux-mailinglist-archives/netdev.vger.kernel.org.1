Return-Path: <netdev+bounces-118463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06356951B5B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8952C1F23BED
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021971AED2E;
	Wed, 14 Aug 2024 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LbiwJv0d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3308F1109
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640796; cv=none; b=aNL1efXDH+Vi8G8nn51m4LPwxtODaxnWm4aFUW4masl6xs+9RM2VqYh2isr4wTPA4ZAeag06tNsUUgkjXP/FgMOdh+8ZDNLiKc0EVn9wne0iMERXwCLPH6TRmRfFYB4fpAgFZV6x1lOE3uvhhU9ZkFv6AdmuJJnN5ISpyp2H/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640796; c=relaxed/simple;
	bh=gvdtm+x/U1EFEgJT04Hh8fiZkjIEvzAJ89d7XSrLkUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UD7Bk79N5UN+sRNuN9aTH4afZBWXe11XaJgM7Su7BF5/hIZvvWi3OmI5Pz76X8/liXVKlX6nqhethA8f28Z8kPMHFf16O5Jn0s1x/rr6akN5AMGHEGA0HReR8lXiBi2IvZIGBv7FYBc9XE+Fg45Qlcgr5l7CZBKR5unh2HrQXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LbiwJv0d; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d28023accso5303671b3a.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640794; x=1724245594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6HoN464ahMlnHnNoGzSGItWS0vo11BXE09zi0AeEArk=;
        b=LbiwJv0dbXMN++y+loha2r6J2cf952qwJGk/ivjlJJcTaFRVb/orjRkSzKnLnwqQxt
         FB+y3MYOMmYCE0/61z+CvVMIdIum8SKYnqdypCJ+XPd/6721UDsniGi+ENC97qTmkVBM
         rrPRqGhI9QvFaW1PNwda2wTbu6u4rxFGxngSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640794; x=1724245594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6HoN464ahMlnHnNoGzSGItWS0vo11BXE09zi0AeEArk=;
        b=LSQB5OCjhQUGjNn/zPqEaMiP+0AldOWzrk0UfDq0EwyS1Pt1v87K+/gbhmgknRhtTz
         G6uc6PpN5srRsHv2i3qk5Es0xXF0o+qUjQ2FIXB1WqOYkUNewXGOakVuzmIJm6AQGPYw
         4pPKooLifx6OFBbDyFpXIA6CFmVKmXgV1On3DFN741aeS4MeOu/Nbt8dya4/iCdvs3tV
         rJTKScPX7p+0/Tx9UxzyOWRNb+nSzUgQSsNGtY43Ox9QtanFv4WpsYx7BOAVTFaW1ITJ
         NUEtIkyu+vUYCorVHLLHxmzIcSTjQ3oCTBchqF8WAeqt5TbPn2cBSwND2oPALHma/pll
         p1Tg==
X-Gm-Message-State: AOJu0YzAWurND0wpCMc65/1uibbD6Y20ygYoBN19xBkdRr1XQ0Q3TVb+
	rIJjIU5+YPMFw9PZpf2SIfrDPf33oxgG3hpOG4sAd2HKxKsB09sc/vGbl6xaeOQwrlJynWQe5Xz
	ET/wiS88KFfr+YxcHnf0iUihLk54dOtAa5LVjY48FSY19qiJXIb40rBYd0UKtqhbbBbB3/ceXSw
	MJDRrPFgS40y2H/iG7yO+9iX08PSSUnS4sB/HZUYsCERgrrf8B
X-Google-Smtp-Source: AGHT+IFMbYekOC+ymTuJCU4XsDX67jFSkwDlRv2AJkUNP9+QjwRqyNrfnq0yWjxp/H2nbL5FaxOTbQ==
X-Received: by 2002:a05:6a00:4fd6:b0:710:6f54:bc9c with SMTP id d2e1a72fcca58-712670f78d2mr3577411b3a.2.1723640793532;
        Wed, 14 Aug 2024 06:06:33 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-711841effe9sm4904543b3a.31.2024.08.14.06.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:06:32 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/6] tc: adjust network header after 2nd vlan push
Date: Wed, 14 Aug 2024 16:06:12 +0300
Message-ID: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
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

Our solution for the bug is to preserve "skb->data at second vlan header"
semantics in the act_vlan.c. We do this by manipulating skb->network_header
rather than skb->mac_len in act_vlan.c. skb_reset_mac_len is done at the
end.

More about the patch series:

* patches 1-3 refactor skb_vlan_push to make skb_vlan_flush helper
* patch 4 open codes skb_vlan_push in act_vlan.c
* patch 5 contains the actual fix
* patch 6 adds test to tc_action.sh selftests

Thanks,
Boris.

v2:
    - add test to tc_actions.sh

Boris Sukholitko (6):
  skb: add skb_vlan_flush helper
  skb: move mac_len adjustment out of skb_vlan_flush
  skb: export skb_vlan_flush
  act_vlan: open code skb_vlan_push
  act_vlan: adjust network header
  selftests: forwarding: tc_actions: test vlan flush

 include/linux/skbuff.h                        |  1 +
 net/core/skbuff.c                             | 38 ++++++++++++-------
 net/sched/act_vlan.c                          | 12 ++++--
 .../selftests/net/forwarding/tc_actions.sh    | 22 ++++++++++-
 4 files changed, 55 insertions(+), 18 deletions(-)

-- 
2.42.0


