Return-Path: <netdev+bounces-115735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892D6947A1A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3181C211CA
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5D15573A;
	Mon,  5 Aug 2024 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fR3JF2OZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB1154BE4
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855442; cv=none; b=HZ4ofzb6uDZXcZfSF1YHS/JfiZ3fnHYawwy0ixBC8jUpL6f5UZkIOZS8Gl7cwhkcmuMC56JYjkbiL3a3n76KTqBas2KotURPccHnivPmuJfpAMP5O1q6TIDVMezqE0LcMfo6sNJO/cvhnpgew7r9ZptGVWguVhm3YFTq4f+eXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855442; c=relaxed/simple;
	bh=awncP+NbvdzC4cT4Ugklak4GH4LxTINDlQi4Kzk3Y1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcBTmhkUi9SEd6qZLiUIHh0mTKkPhUzlU94n26N166qewFjOU5xza5oCxp7ej9nhpJv/1JvgOGp+f9z1WEDeaeOgVCCoGj/0ax0Y59FheC1lLDOyzP0NAlSJWJPttLAKytY4dj6Otfcwi1lq7c7YqhUwdAb8dSsYoX1P00jcOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fR3JF2OZ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1d024f775so651315785a.2
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722855439; x=1723460239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+8wRwU8tWwhWYpBIsJnKE89P/+rgqOTvwYqNON+ucs=;
        b=fR3JF2OZSpctz0kjl573m4cFqoODlrq6IEeR/EZgSW/wLxXgooHjWSk6O9pRnx52aS
         wb+ExPHIOJ8qz/ZdQDqhI5ixSFPZUcegqDzQRhWZWmZjLxsjBZAxNmIV3IrsWRz6KPMv
         OnSWzaknnEceAVaeD/XOcaOynSkkM84ylOFKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855439; x=1723460239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+8wRwU8tWwhWYpBIsJnKE89P/+rgqOTvwYqNON+ucs=;
        b=EX7TDyvh/ql83wO0kNtVGSgQ+F2XzKTRonZVStMS4I9Yq842Z+XjySULMrQ95x7aV0
         lHYH/OK3NG//k7wJtjeHid8FlnDsQu3DaOEM0hba0TGHQmbvqj3Z+aAV/9/Uy+/YXSU4
         iA+24XXW0w5xKvG7Ry6RnAAkCalGoGINnlsKKCowuK6SenkH/+JW0l9J+mTxgATZie66
         CM1+Nu2JyR32ICLBTYOZQ+cmFFC+lDAKAaQA3PaOHlX3uKDX6Q3fU/4guWz2nREtr/v1
         tq3/Fhq2ysEdHquN5PY/4wn1xpQIbncDwJOSWyKE7zb5BJwP3sCzX/+2jXZLHcda8pAb
         aa3Q==
X-Gm-Message-State: AOJu0YzlS0fhXcpTfZj2Cj64yr6WrIJ4wLtm7DQj577wEXkOp6tJd4l7
	atZdRxfAf4iRy0LEiOp4qctt08tgrv2USapggWP7BSbvYrLDu8BM0/qX9bru1FCi/4zs8BRf3fI
	2c0m7LVwhFkpAv+Qu6vcUMXVWkpOpTI9hBmiAhI4MM5CAfVw/pz+BGx8uSVi2DgUVNY+vuKteAz
	LZYj0xwQzKuEFnmi217JZnp0Xjg+jTK8gh3Ld5nX4KW1T8gtuP
X-Google-Smtp-Source: AGHT+IEdEjv2ni5DoSRb5xkTGxVJpDpnNgTP3dFWjWHv8VlKMY/CZGn0s4RBr2Vi489i5lpBOM3woQ==
X-Received: by 2002:a05:620a:f14:b0:7a1:dc75:5293 with SMTP id af79cd13be357-7a34efc902bmr1461622785a.58.1722855438580;
        Mon, 05 Aug 2024 03:57:18 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fb785sm332890785a.56.2024.08.05.03.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:57:18 -0700 (PDT)
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
Subject: [PATCH net-next 5/5] act_vlan: adjust network header
Date: Mon,  5 Aug 2024 13:56:49 +0300
Message-ID: <20240805105649.1944132-6-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
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


