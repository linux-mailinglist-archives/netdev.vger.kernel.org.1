Return-Path: <netdev+bounces-115730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC4947A15
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14B5B20F86
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030FB1547C5;
	Mon,  5 Aug 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E890kYeX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C31311AC
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855424; cv=none; b=Q2Uy+TMzQrKRuf3ziBZSp/QoRzDuhIyafXDEkn5J23EGatu+Pk5acyjwsQtys/XVmXoLui2N12+KK7eDE4PJY/nMHkr+vQAx7POi+x/yC/c3/9Z9ZU5XUSf4H6k/nqIIimgNb5JN3kLSWOW3LZ2jKusEz1w4tkN2PJEiwXxHZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855424; c=relaxed/simple;
	bh=R8T/5mc1Tr1x7sVkcOFWTC6VMU093KIz86/XKSpklqs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1RkDBUesB4GwTD6wW0OxvpNWN97LJxI42+gw3msI+UKX3bNsPuKE0rlwwr7KZ0IvomszFGNZ81u3sCuJ2X9G111Plzoygtpjj1GwVs/o1E0TY1IEVJvcDJxa8THZ0aKYi5Hfl+9CBmObyqsRdKZ+hiJYCLQ6rEh5f7/arVh3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E890kYeX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d067d5bbso657770585a.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722855421; x=1723460221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IdQroutnmhBv9xeGPNOIUUS9wtxWbsAhZHC2PCdlsZ4=;
        b=E890kYeX7OwaH5kFmWbosNkeRtI200suwogel5AqXXpwzlQ9sjJ3Y3i/9JDbU70jt6
         ijURdLHQNDhDkn3n65bWnanhMoByOcEzXPre2YK5Rkp4wEC2MxwnfPJwqvL6iDwcX1aI
         ZU2ILYEFyTffPBTyzcuUB/7UD4ycizDPv2Io8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855421; x=1723460221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdQroutnmhBv9xeGPNOIUUS9wtxWbsAhZHC2PCdlsZ4=;
        b=BMJ28WWkhgbtFaRJ+I/8siK5PlOP++YPbpMMtY68peIvoYkzvK/cf5Dqfp6hD628Z0
         0lM5vLW2UUKavdzFMQ8NsHAAsNWbFJ3D0QwWKbhQx6UCJDkMByAjWxm+RJwnziTCPDgt
         GGgF749qvsED0+vwwofzbtrLuDMsbg/d7vo+/5viU8vy9Ytgd8Hc2MPISEv6r9W6FVLt
         3UStuf9IxUpEocQgdI8eSitfXqNu9BQYzvSZdNjqNxXiBU3mZHVHZ1EwoPHTSj1sEoZ7
         w9uUpKKylLZY0NS4w/ukyiYlKp6xt+dhGepcPgE0UszASqgCl/seAcMocvHoEf1z11M1
         2y6A==
X-Gm-Message-State: AOJu0YzL0F/Qyt0LYkd+ZnhNSUae8Sqzht0qzGP+SofyPhXhyqgYG1uh
	Hlu1dIwlkXTYYlovRNZOnRycfpxLNNBxC6Dg+1jRnirDOFAhj3uxBslCR1TblnJDd5bFJhc8I/M
	Jzy5rP9xyIictM9k9AvqW+lfXoHsTD4T0RC55MSIiRIR54mJPCVyYBaKgkmQ2Gha0GLXSdRiV6D
	k5jliOS1gu9u3wXN9FcmushFZfAQguCb/dF4pv13jbzbWODXb9
X-Google-Smtp-Source: AGHT+IEGbxsbFSytjR8xmT3KBrYE8RdYU/kO88C1B0xpLs3Zh/ZYKeCSvL+JbsG7b5s+nkw7xpVYRw==
X-Received: by 2002:a05:620a:2588:b0:79f:436:7e3a with SMTP id af79cd13be357-7a34ef9e614mr1419112785a.48.1722855421479;
        Mon, 05 Aug 2024 03:57:01 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fb785sm332890785a.56.2024.08.05.03.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:57:01 -0700 (PDT)
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
Subject: [PATCH net-next 0/5] tc: adjust network header after second vlan push
Date: Mon,  5 Aug 2024 13:56:44 +0300
Message-ID: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
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

Thanks,
Boris.

Boris Sukholitko (5):
  skb: add skb_vlan_flush helper
  skb: move mac_len adjustment out of skb_vlan_flush
  skb: export skb_vlan_flush
  act_vlan: open code skb_vlan_push
  act_vlan: adjust network header

 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 38 ++++++++++++++++++++++++--------------
 net/sched/act_vlan.c   | 12 +++++++++---
 3 files changed, 34 insertions(+), 17 deletions(-)

-- 
2.42.0


