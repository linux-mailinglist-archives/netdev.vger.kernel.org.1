Return-Path: <netdev+bounces-119672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC9D9568FB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635961C2156D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5131667C2;
	Mon, 19 Aug 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LdBfj9Oe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AE6166318
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065594; cv=none; b=DByrZUOd633FMlQtRhv4cYGH/9ZuxUKP2zUqMxJ0rnPVA6ve2vtgy50BwEn4LBVlqfJuXydgjU5wrevkX3ToMHjs1LAqUgbaM6UbqwLdX8mycPyVP3c+dWpme3xIrRQRcS6n6+TfZ7gwZqFqBtvPf+Pwgd8Bl/5OxOCZ+5JZpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065594; c=relaxed/simple;
	bh=GGSo+oioPJd5pCibS8o1K0y/bCRre+gZJC3nbaun8qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqPdgojsyJ1v9M0zYrmDgLOu5b29ib224wIqABLZUmyd5rLlPUwa6b0WcWkd+V+CpX2AfpF/L/Dmds0b68hECoMv8AAHEjmmaLhs8/gndZsGKmWu5ExKggZ76BtVoiCyfWByfRCOkAcZDj30gCxpkh5SGmmO8FMxXHJvIeGkqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LdBfj9Oe; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44ff7cc5432so32875551cf.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724065591; x=1724670391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7vNWvfsSX0MUcWWRVZHBIIv5oFl0x4bbuu1/Fj1paQ=;
        b=LdBfj9OeEdh6bbe/3gdk0ZfeWXPfizkFncg2ezEt7uDlhHeZDZoZxzcYRBujti4u5B
         oRaj7Zy1FfxC0GS4jVoyZdouLr649UFvpRGpr6l6UvCuCBDDJsJ7EDOHhol5xwtL6sON
         UReeHDfK1mIisIPB0WNZxnpjhcZ3VPlPtHFjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724065591; x=1724670391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7vNWvfsSX0MUcWWRVZHBIIv5oFl0x4bbuu1/Fj1paQ=;
        b=FEGbfWAXoRlR6EHR4It7PcESkDwuZT4hdVGvq4+y/sn2TZeNsTjDDCEdFGO+687xLu
         /JQfTnXV2Oho9Z36qxVkKKrXa3fH9iIyrCg8HLtlZaWykLRyl9zvWaocowU1vPDsEZKM
         LJTuiz1UdUmEoH/Xjl5YmbEaxIlysF9xeW29KaBxOt/mQmR5/+KJQ7tphfSdTMW7c8LL
         cpAUE1YQVLUrHhgqyqucvfUpmrI+K1/e/CRZB3FRv/X0YeRS6IcGCFgiUkZojl0naov7
         V1T3Tzp0E4NsjWxoalMD8N+x2nTguBAqIHyfNa0gVabGaRyIO8cLnVpK4lIJqlxTy67m
         pp2Q==
X-Gm-Message-State: AOJu0YwuwG7H0uHt9Ed1z051bkAd2f0bgXcH3bV94g9ypEooETWszdxZ
	uf9+RK9PfATw7uFm+c/P+3TBq9uYiwsAToSkazrTt1jDMshB+RiX+vbNAhhBCdTI+y9jOxxhXCs
	gGjiW1RAYZqTT2XhtUiIsta54xivccEWqjWNC6F1tp86QRxJqYw/R/vzysEVuN8rfSGAfvXARdc
	Fnwvw5+ewkcKVYnNbpe1bgtQv05YXr0917TGIxM8OwrIlUs+IR
X-Google-Smtp-Source: AGHT+IGXWbsIdyFfXIkoN4dRfEksACFVFr7ukp6Eg7fVS92nfQCiuCp/XRgimz/jmJPhemlOEBp4pw==
X-Received: by 2002:a05:622a:5e16:b0:446:39f9:1491 with SMTP id d75a77b69052e-4537435a20cmr134746501cf.42.1724065591364;
        Mon, 19 Aug 2024 04:06:31 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a072237sm38751911cf.86.2024.08.19.04.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:06:30 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/3] tc: adjust network header after 2nd vlan push
Date: Mon, 19 Aug 2024 14:06:06 +0300
Message-ID: <20240819110609.101250-1-boris.sukholitko@broadcom.com>
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


