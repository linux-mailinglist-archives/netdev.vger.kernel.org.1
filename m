Return-Path: <netdev+bounces-302995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AgccMPtoQ2pDYAoAu9opvQ
	(envelope-from <netdev+bounces-302995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574076E0EE7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 08:58:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cCVuaW1H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302995-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302995-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C401130087E6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B28394797;
	Tue, 30 Jun 2026 06:57:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA1391E60
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 06:57:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802679; cv=none; b=ZZ1VKWzapbtzifGnD8KIasItuoMQVXt5GyPWFTMtBku3yeOy2p3z9IoqEyobuveGJRZau+QeZ4Pwk2Tuf2aiHdtsV/eN6ep6tW1YtRWsy9Ex6+8nJ8AUmkLecHnM/2+sph8dm0/3qyfACMx1UfZ+0agdaMpL1JFR36oRi/nG4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802679; c=relaxed/simple;
	bh=AF8EzTYcmcfCcEiaIWGwus0xlZ0pc2RcYzxYiJaqerg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mbl562rSAHCmNAI7tt4AYaXpQkEbH33bErtKkPubuJ9MAhhf5G8hrXEjaDhpvB1icMaJ5v2rlwYjA9GZegFFXtkWgj1bi16uqX6bwkT4okL/Ejznh9S+nEXLEq3UUChbN1mq98yZNv5wzLW8wjKgLOwyj8AEFaELfFawLcZxGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCVuaW1H; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-475881b9a4bso464848f8f.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782802677; x=1783407477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wg2/qe+4da0BF+gj2Y7cJKdG+hCpLIZ0UIJ4logHsQY=;
        b=cCVuaW1Hc3GEjSZ9G8+DVAh1lcVhdi99+Twl9qDjyU+zwLx3PqxVsx8Znfu64qA89G
         MCFGYITxwjktV+AL55aC1m6YxTAQT5XCJ/hJUq20AksHxBtMuW4LEmuC4pmvME0CGDMY
         4n1yZdhIH1FNzy4EPnwFM2nUk6cSm0+jt84oAm+ahABrhTnIsd+z5LIGgwylA59hR9L9
         TC9d0IxD2mQ0ZXXzzgPUQKC9Cz3AIaNeisRR95xZN1GL92yYrA+bpWeM6Sg1sL8a58Dp
         UGz1p3d2N007cFmF5whnyQQGDWfPcEbbg/jIrMRNpEFzoCbcNGq3CXAiecbPr4L21O4n
         Gu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782802677; x=1783407477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wg2/qe+4da0BF+gj2Y7cJKdG+hCpLIZ0UIJ4logHsQY=;
        b=InmbTCoXzqRzGdeiWeHz5ixDgzerRUYEFW+PQy5xCsYtD8x+w4ZXRccmyXywHWCXNr
         t0bnfHlSHQYw0tpZpwYCGGCMh1VCnvEsOUqaSyVwCCo3UT2s6PSFz9YQ0YAb/2QAxd6A
         k/Qn7vuTs/ICtltl1LNS+W2hizToMlXnKUVXFVSM2gD9INkDQvgnBeP3YUsxL7KWN8Sm
         iCH163XrBiGqiu+LAFA5eRLA/lqevVPyWTk6AV+g9Xx9g3ZG+6Zdce6Bk3ik9QFjr/6+
         CXDGF6r1W8hKXZZBxjBrN1Na1VsPSblHeaRYkwgd7ovkhdng8lfdz0wxlc2aBBFFEDf1
         6Hqw==
X-Forwarded-Encrypted: i=1; AHgh+RpoyIi/FLDU+H5ZZYTCrsx30L2jikYmQRfhJ0+JZ1b8uhljKcbylF6keqAF7PZ0LLCUyZM4yHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHa8AVO45NIZ6DyXbMExKCLJ9R6KC7jHgmFkAIKkXB/NVwWlba
	gf5FLg/uIKd66qfGuEAnQIomDCiqPZzlslGEneR5qL1bAizk6UcKUYLw
X-Gm-Gg: AfdE7cks2a7kEE6fuYf5cD8h6dOX5lRs0W+lqHYmvdL83d0jPv7fgqU92mYIQtRt5Fl
	mzWoCkJW+wKKXRJ4FUHe8UuPYhx5w4q/McqIFvvGChvhYuacufyL7Uw19q/3i6BffGo4chuB3f2
	QU7qYMqUdYac8sUHjBS6jb4kqetRXXNHUGH26nIKpdkbu4ljbKjupmz++MNEa0offw7PGzTcrbR
	TCd9cTnryFIKLSuXVvBV1kGLDICeFwR9Oapblvdz4iZmEIR1RvI2OzvzwJjeyEh3nsQedHzbun2
	CKSO5ThJaj/jI5Hqvh2e3PrIGn2CLcHodm6vdCkI65H6PlTmg4ArtIAhG9WI3aHX2acZBXGpdiq
	P/kMQbB0impHpNs/gHvrYzoyr3HUpQm3ji/5x6ehXuU+CZ2EaVn1clcofr9D2UF2IJaI1CZGRtK
	6YnQ1Qt4I=
X-Received: by 2002:a05:6000:2dc4:b0:474:6a5b:85f8 with SMTP id ffacd0b85a97d-475506e98aemr3116459f8f.6.1782802676618;
        Mon, 29 Jun 2026 23:57:56 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cf26sm4570949f8f.19.2026.06.29.23.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:57:56 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH v2 0/5] netfilter: nf_flow_table_path: L2 bridge offload
Date: Tue, 30 Jun 2026 08:57:30 +0200
Message-ID: <20260630065735.3341614-1-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302995-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:netdev@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:razor@blackwall.org,m:idosch@nvidia.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:bridge@lists.linux.dev,m:coreteam@netfilter.org,m:linux-mediatek@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:rchen14b@gmail.com,m:lorenzo@kernel.org,m:pawlik.dan@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,m:pawlikdan@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,blackwall.org,nvidia.com,gmail.com,collabora.com,lists.linux.dev,lists.infradead.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mediatek.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 574076E0EE7

This series adds L2 bridge offload support to nft_flow_offload, allowing
bridged IPv4/IPv6 flows to be accelerated by the flowtable fast path
without requiring L3 routing.

Background
----------
Hardware flow offload engines (e.g. MediaTek PPE) can accelerate bridged
traffic but require that nft_flow_offload detect and handle bridged flows
differently from routed ones: no routing table lookup, MAC addresses from
the Ethernet header, and VLAN context pre-populated from the bridge port.

v2: Fix missing Returns: tags in kernel-doc comments for the three new
    bridge helpers (br_fdb_has_forwarding_entry_rcu,
    br_vlan_get_offload_info_rcu, br_vlan_is_enabled_rcu).

Patches
-------
1/5  net: export __dev_fill_forward_path
     Refactors dev_fill_forward_path() to expose __dev_fill_forward_path()
     which accepts a caller-supplied net_device_path_ctx, needed to
     pre-populate VLAN state before the forward path walk.

2/5  net: bridge: add flow offload helpers
     Adds br_fdb_has_forwarding_entry_rcu(), br_vlan_get_offload_info_rcu()
     and br_vlan_is_enabled_rcu() to expose bridge state to nft_flow_offload
     without requiring inclusion of net/bridge/br_private.h.

3/5  netfilter: nf_flow_table_path: add L2 bridge offload
     Core of the series. Adds nft_flow_offload_is_bridging() detection,
     nft_flow_route_bridging() which avoids nf_route() (fails for
     bridged-only subnets), MAC/VLAN pre-population for bridged flows,
     and a dst leak fix. nft_flow_route() becomes a thin dispatcher.

4/5  netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
     Fixes zero-source-MAC in PPE entries when a bridged flow traverses
     MT7996/MT7915 WiFi WDMA hardware.

5/5  netfilter: nf_flow_table_path: add VLAN passthrough support
     Records VLAN encap info for passthrough-mode bridge ports so hardware
     offload entries include the correct VLAN tag.

Rebase note
-----------
Originally developed against OpenWrt pending-6.18 patches by Ryan Chen
<rchen14b@gmail.com> and Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
Rebased to current upstream: path discovery infrastructure moved to
nf_flow_table_path.c in commit 93d7a7ed0734 ("netfilter: flowtable: move
path discovery infrastructure to its own file"), so all netfilter changes
now land in that file rather than nft_flow_offload.c.

How to enable bridge offload
-----------------------------
1. Load kmod-br-netfilter so that bridged IP traffic traverses the
   netfilter forward chain.

2. Enable netfilter hooks on the bridge:
     echo 1 > /sys/class/net/<br>/bridge/nf_call_iptables
     echo 1 > /sys/class/net/<br>/bridge/nf_call_ip6tables

3. Register bridge member interfaces in the nft flowtable:
     table inet filter {
         flowtable f {
             hook ingress priority filter
             devices = { eth0, wlan0 }
         }
         chain forward {
             type filter hook forward priority filter
             meta l4proto { tcp, udp } flow add @f
         }
     }

Daniel Pawlik (1):
  net: bridge: add flow offload helpers

Ryan Chen (4):
  net: export __dev_fill_forward_path
  netfilter: nf_flow_table_path: add L2 bridge offload
  netfilter: nf_flow_table_path: handle DEV_PATH_MTK_WDMA in path info
  netfilter: nf_flow_table_path: add VLAN passthrough support

 include/linux/if_bridge.h          |  23 ++++
 include/linux/netdevice.h          |   2 +
 net/bridge/br_fdb.c                |  34 +++++
 net/bridge/br_vlan.c               |  47 +++++++
 net/core/dev.c                     |  32 +++--
 net/netfilter/nf_flow_table_path.c | 201 +++++++++++++++++++++++++++--
 6 files changed, 316 insertions(+), 23 deletions(-)

-- 
2.54.0


