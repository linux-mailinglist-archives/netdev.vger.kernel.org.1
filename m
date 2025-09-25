Return-Path: <netdev+bounces-226491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E45BA102A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2D94C19B6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE623164D7;
	Thu, 25 Sep 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxYIUFpz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9C314B7A
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824852; cv=none; b=GfPd4CAqpatQi7YlSNvYvE8fXcYPOop1LLbf5nLwwVj0/8smq03TNixD7BS/8YvcfyHD6cn0lWwJt3tzL9SqNj//NA0Ry8MmVeTe+3Uh/qsaDdb+us+lBhxszMSmTLZ1Ew0KjXBBxGLiT/1WnAl1Wsk4+5t8DrlBAXZs6Aq8RO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824852; c=relaxed/simple;
	bh=75KsYv7BtyENqAQQa4FaHI1uarpE05MwNpGTXwEeZXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a81THoxU0jhZ8X8OdK6i2e9GiEGfHS8wG0hrhQpy5/5hUW3heoySHjUwQ3vxlldWyOy66iiB+/t2rxIPUvWJ8Q+Jpmf/bp3gQgAP1q6IbAuEBHsHKmpX/5zCJ+wL/1kdX9+z9qBJ6ONWvkKtns+4L9dNEs0Ku98RL32bQSX+Y40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxYIUFpz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-634b6f67742so62050a12.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758824849; x=1759429649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFmthaKkdRuO6Ia14S4ylMSVHOARqVNgJmPBWByR8UI=;
        b=QxYIUFpzKeCDeu+ATOLHqLZE4CKTe50FiWN0obkbU5jhZZVeRX4yfDMgetL4rokjed
         eShxMzVTD+ysyl+N/7TkYvx12lpj2b9ecDy9EWtQx+5BQEXw3yLNqoP6of9jkTrbRalr
         byxAg5/S4+JkJO+XE+Of2mgHabHmVRiW0qPycmTI+XoCDTRuYQiHvHeDlPvX6UHrzTyf
         cFLScFQKvIZDHL7y1OoSzrSKi68z2GqcHK/LJ/4llgA3BwBJXTtX1O5IIM4P1pdwuwJX
         /1Kfpkhxg/P08Ge4l7W7KNVSOG43XEdeCwdvws1BwL929G/Hg8pqoeeFF2jYSiCdRFBi
         EYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758824849; x=1759429649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFmthaKkdRuO6Ia14S4ylMSVHOARqVNgJmPBWByR8UI=;
        b=end8QeM676TnblIqua3MRnA/Hv4l6RFb0qaw2vReIfwvVWx7Juty9OD71WfNCu/Z9E
         n6XgrtqjLBw02Ri4Vw+e8tn9aapcFxB+FWf20XpIizV8tKlYnobDyVeAi8Yb12siYhW+
         ycFTI/TfvAYJOse5yRqVeagM+McuMWLMMZohyPUyDqBYl/2vR6VE0tHbHuQAqm1H+wFi
         NV8Bet8KuU1otYoqxN0Kv18jpOFbVUazZfJhkUBOoon/jj5SBaSlaqkjsnjFpPJNKIma
         beYYMLkqd34ywpRXR5XZyUJpBXaxIy0jkwfPuXKybRgRkMzD6o4rBMPLruzr2pFA04qG
         F2GA==
X-Forwarded-Encrypted: i=1; AJvYcCUnwUSV3w6h6hoUh+mTH0YZSv1NEIzonOYN6bYNTt0xlMSfsG2AY6sH5RfKDR5/KW8kNto5tAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfFAJb9Xy+dDLAY/p+uFM3q03ZykJmA+0xXguanIR4lIbucLvp
	Y2n7dQXdtjfYNh2A6ozKa3itg4qpwzXQbCHRCfXxz+XPpczpQxybIjop
X-Gm-Gg: ASbGncuCpvTDnULH5IcPq1H1h0NBB2fj/qEfV7vsoQF+GbhotCENO98bs65usQdhPGb
	kJn8+lMqde6n+XeCYxHOwGhWsE4d7DFF2Lecdcc9blAmKAqVqXFhvodQ8+tqsp/d2rkTwUnsDVa
	mZC+i68bAfeDx7AuowVV4KQ8wzAnF6UH6gZ+m2sJcOVptaPO3udAwG4vfETqu0I0S5kUvgXxJcv
	gxY+LcEhV1/uoGcVuiWmiS6Qi3KifNPePxXMmUHtYQCAeLt84q+NMC4gqTppXujeFCFbV4cr9/Y
	caQ4qIJeVvKGtTAjVDatsqjx7IMXcTwK5GazB0Cpak1vVdDhtcvnYogUxFqQ8UPzrLLXTygnuZw
	ePzsMVVemgsgd+9B6+HA4Tzs/TfNah2nAZGhXVA+4QWuF5cXGBlmcV2v7lnqOUnV2tREJCFhYV0
	b6dhwRitlAR308RrTe+w==
X-Google-Smtp-Source: AGHT+IExIcGrCo7xdVZgfjD/gWQ++tf7y1kOVCVrC2R7tQkGQdQHzY+422ZK9hGlUWIHAsdsCiye6Q==
X-Received: by 2002:aa7:cd67:0:b0:633:d0b7:d6c3 with SMTP id 4fb4d7f45d1cf-6349f9cab40mr3139172a12.5.1758824848942;
        Thu, 25 Sep 2025 11:27:28 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3650969sm1572902a12.19.2025.09.25.11.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 11:27:27 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v4 nf-next 1/2] netfilter: flow: Add bridge_vid member
Date: Thu, 25 Sep 2025 20:26:22 +0200
Message-ID: <20250925182623.114045-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250925182623.114045-1-ericwouds@gmail.com>
References: <20250925182623.114045-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store the vid used on the bridge in the flow_offload_tuple, so it can be
used later to identify fdb entries that relate to the tuple.

The bridge_vid member is added to the structures nft_forward_info,
nf_flow_route and flow_offload_tuple. It can now be passed from
net_device_path->bridge.vlan_id to flow_offload_tuple->out.bridge_vid.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_flow_table.h | 2 ++
 net/netfilter/nf_flow_table_core.c    | 1 +
 net/netfilter/nft_flow_offload.c      | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index c003cd194fa2..bac3b0e9e3a1 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -146,6 +146,7 @@ struct flow_offload_tuple {
 		struct {
 			u32		ifidx;
 			u32		hw_ifidx;
+			u16		bridge_vid;
 			u8		h_source[ETH_ALEN];
 			u8		h_dest[ETH_ALEN];
 		} out;
@@ -212,6 +213,7 @@ struct nf_flow_route {
 		struct {
 			u32			ifindex;
 			u32			hw_ifindex;
+			u16			bridge_vid;
 			u8			h_source[ETH_ALEN];
 			u8			h_dest[ETH_ALEN];
 		} out;
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 9441ac3d8c1a..992958db4a19 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -128,6 +128,7 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
 		flow_tuple->out.hw_ifidx = route->tuple[dir].out.hw_ifindex;
+		flow_tuple->out.bridge_vid = route->tuple[dir].out.bridge_vid;
 		dst_release(dst);
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
index 2148c4cde9e4..788bffbfac78 100644
--- a/net/netfilter/nft_flow_offload.c
+++ b/net/netfilter/nft_flow_offload.c
@@ -85,6 +85,7 @@ struct nft_forward_info {
 		__u16	id;
 		__be16	proto;
 	} encap[NF_FLOW_TABLE_ENCAP_MAX];
+	u16 bridge_vid;
 	u8 num_encaps;
 	u8 ingress_vlans;
 	u8 h_source[ETH_ALEN];
@@ -159,6 +160,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
 			case DEV_PATH_BR_VLAN_KEEP:
 				break;
 			}
+			info->bridge_vid = path->bridge.vlan_id;
 			info->xmit_type = FLOW_OFFLOAD_XMIT_DIRECT;
 			break;
 		default:
@@ -223,6 +225,7 @@ static void nft_dev_forward_path(struct nf_flow_route *route,
 		memcpy(route->tuple[dir].out.h_dest, info.h_dest, ETH_ALEN);
 		route->tuple[dir].out.ifindex = info.outdev->ifindex;
 		route->tuple[dir].out.hw_ifindex = info.hw_outdev->ifindex;
+		route->tuple[dir].out.bridge_vid = info.bridge_vid;
 		route->tuple[dir].xmit_type = info.xmit_type;
 	}
 }
-- 
2.50.0


