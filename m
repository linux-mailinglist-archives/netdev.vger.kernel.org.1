Return-Path: <netdev+bounces-226495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCCEBA1060
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2926E1BC6CAD
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8842C3191DE;
	Thu, 25 Sep 2025 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ5+EDRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF02E1747
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758825062; cv=none; b=hKba7oM1LAlq0xU3hGVeJxsy7U6Jv4OHCaLYdCYbwYgryWCAw3DlKxc9Q8WnHh0eQC2XOT0xn639UrdjqVx4I2Zm/AOx++paGEHZywE/Tp1a2inGdeC9lZvdageBClxG58FCm1bZ2+XP9FT/USPMl9O1wh5qw/40t6a2VUYuocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758825062; c=relaxed/simple;
	bh=mWfnCyX4ZXZBEuQ+MvwGx9mVDI5hxd/cIA20xBbVsbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k2yvnHRG6wgMtErtWvgUMCsZwBlxfyVxZjdx/FZK4gLcLVFg2EZQWd9Qjwcz6y0uJLh/spV+TFWeae+GZr3O+Ia68Dy1I1TTxInUNR378Lv0nhv2uiV+hfRr/XX2oypFIV6O7QLIAYFRPIWCXyyn3zsB0xFKADYhSZa24ATAaqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ5+EDRe; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-631845b51e2so1524119a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758825059; x=1759429859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7V70C2OYgSvApO6vEjdxKmgkWi6ODruqlWoYJimYJ4=;
        b=hZ5+EDReDctyaFWHCfaM4Id+b/7//sW9WhR09jZ4oCFzhZL8MV55Lw1+n3zlIyW+Uf
         uaY9wvrv3yX3mG8G+eM2w6fptZhAGAZHilxjRnto1kxAohdLC3+XsWV+9kLufxdFr6G6
         MdNOHl/mMUO1Tf0RAmN28YlsjyAllYDtl0u7SZGSXnS3Ae0i+rIT8j1Bl8kj67KwF/Ck
         XhPeHG3rQ1tTFABoV+Y6t3BPxZjzbwm+CdMMNVIHOmQtY8y+bZuanVQn590ZVFyrFqm9
         eHGCIH9GCqI1f7qg4L6IuE/MWvrkNsd2HjAx3S+tczVTwihPu/9Z2h7nwnlOTi2+gF6g
         gwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758825059; x=1759429859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7V70C2OYgSvApO6vEjdxKmgkWi6ODruqlWoYJimYJ4=;
        b=RlMQzparlId5Hiby3Ji2gP5JNycZllJJXzSr5my+SZM2FE1IaTdKIdsX1meKwxltNn
         ISY/mIQgl0oCoKrqvM9svwlTsAmUrB9T9DOr/Kjw805D9PtdXQLlZfY+WdOVEk1bimbC
         gWdAVZ/zdaxgpwd0Mg4ed085nVhpbCQ+Ulp+/SlLbc1t7tiBSyHslw+x2uVPFsFuIy/c
         dVum9za68XJxmEFc27zcqc3anBe6q5re+hLmJGOAeOpSqH+vkaL1KRY3SG85V/rquLCy
         jjyFxQDOqv94xmps5LeJy3n4XksHH0qqfgmlEoZrK8RLEFgjgXLynh3Xh/xrjw29/fHS
         tTPg==
X-Forwarded-Encrypted: i=1; AJvYcCWOLmdcTGBPQknUcaKu3mx/mT3iG63MU9JrtDpwd/+U4ZlBnF75Vh0AkXBYVEt8SleUREaxrP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmahkbZXD6ce08vlligkJ64tXz94mkRfibd0ayjNprw+pdht8
	ROiYutm6whmHzOADqcvXggA+KBxKhhz3Akx5itaTZ2vVUWxMcaq8Dp7l
X-Gm-Gg: ASbGncsMYvyOX/e+Derm0E4p/2PuVWoQA6ZAazDM3XP+NSvMUpB4g59k4Bmuzqd35d4
	bP8KUilJiGm6VzVS9zL5Qa8JA/7cx8k8Hb+EtxcIiYb3HD2klF0l7gNyKjKKe67rUbtOzCySiB+
	J+RRvsHmqvcKwAPNst/KwXpZTyCvoc4M1MwGrUJSWVgLGVqMevE6eNQ6+RFHrQOr8TrCDgviTAe
	yuIod+OMNUtsVHDQXhPrs+vwKgAxCS7EiAgLbLycLoOqRbXI0CudYB1aOG4efB/K5krQu/RH7X9
	h9q4Xb0J5CCa5RvZItzrMgezYtv0JMfH9FnG4f8sxPY70S2LAQr+8P+GCho7quPKv88sHu8OMrI
	J5RHysRJdZ+Oe6Gls7yC949K249K3tjO5bHUheQZVvbVIPPAf1Hc1Ko9U2ge1gQ0zWdxuBs6jfN
	RDmqZES7WCwuIto6kMbQ==
X-Google-Smtp-Source: AGHT+IHkLAofooZVh3BAd89JwDIkjnucLG6nJfCAeGHO8bJNdmfj/gTKINUMsN2WpKXV8iwBOnj4tg==
X-Received: by 2002:a17:907:3d4c:b0:b0d:ee43:d762 with SMTP id a640c23a62f3a-b34b9f5b4c4mr419901366b.4.1758825058790;
        Thu, 25 Sep 2025 11:30:58 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545a9c560sm211198666b.107.2025.09.25.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:30:58 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v15 nf-next 0/3] conntrack: bridge: add double vlan, pppoe and pppoe-in-q
Date: Thu, 25 Sep 2025 20:30:40 +0200
Message-ID: <20250925183043.114660-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack bridge only tracks untagged and 802.1q.

To make the bridge-fastpath experience more similar to the
forward-fastpath experience, add double vlan, pppoe and pppoe-in-q
tagged packets to bridge conntrack and to bridge filter chain.

Changes in v15:

- Do not munge skb->protocol.
- Introduce nft_set_bridge_pktinfo() helper.
- Introduce nf_ct_bridge_pre_inner() helper.
- nf_ct_bridge_pre(): Don't trim on ph->hdr.length, only compare to what
   ip header claims and return NF_ACCEPT if it does not match.
- nf_ct_bridge_pre(): Renamed u32 data_len to pppoe_len.
- nf_ct_bridge_pre(): Reset network_header only when ret == NF_ACCEPT.
- nf_checksum(_partial)(): Use of skb_network_offset().
- nf_checksum(_partial)(): Use 'if (WARN_ON()) return 0' instead.
- nf_checksum(_partial)(): Added comments

Changes in v14:

- nf_checksum(_patial): Use DEBUG_NET_WARN_ON_ONCE(
   !skb_pointer_if_linear()) instead of pskb_may_pull().
- nft_do_chain_bridge: Added default case ph->proto is neither
   ipv4 nor ipv6.
- nft_do_chain_bridge: only reset network header when ret == NF_ACCEPT.

Changes in v13:

- Do not use pull/push before/after calling nf_conntrack_in() or
   nft_do_chain().
- Add patch to correct calculating checksum when skb->data !=
   skb_network_header(skb).

Changes in v12:

- Only allow tracking this traffic when a conntrack zone is set.
- nf_ct_bridge_pre(): skb pull/push without touching the checksum,
   because the pull is always restored with push.
- nft_do_chain_bridge(): handle the extra header similar to
   nf_ct_bridge_pre(), using pull/push.

Changes in v11:

- nft_do_chain_bridge(): Proper readout of encapsulated proto.
- nft_do_chain_bridge(): Use skb_set_network_header() instead of thoff.
- removed test script, it is now in separate patch.

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (3):
  netfilter: utils: nf_checksum(_partial) correct data!=networkheader
  netfilter: bridge: Add conntrack double vlan and pppoe
  netfilter: nft_chain_filter: Add bridge double vlan and pppoe

 include/net/netfilter/nf_tables.h          | 48 +++++++++++
 net/bridge/netfilter/nf_conntrack_bridge.c | 97 ++++++++++++++++++----
 net/netfilter/nft_chain_filter.c           | 17 +++-
 net/netfilter/utils.c                      | 28 +++++--
 4 files changed, 164 insertions(+), 26 deletions(-)

-- 
2.50.0


