Return-Path: <netdev+bounces-302605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /i4SHDNoQmr+6QkAu9opvQ
	(envelope-from <netdev+bounces-302605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:42:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E46DA69E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:42:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="kefDkK/M";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302605-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302605-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423DB32A9F7C
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D991406290;
	Mon, 29 Jun 2026 12:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC8406285
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:33:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736388; cv=none; b=oSxBM37vqQNZ62F+54T+WBXgXUMMlcRxd6iNKr3MNINjRxzBeO5Z0VbWZbXGZQpMpXG+hTiTNU3OxOR8WJYvuJDaxNV4HLKQMh1DTQVi8dmjCsJkksm5V/opVmD/KQkTNsgjBfy65lzWOEDhGnYr2ih8TzDNMuWH1qfpSNvOFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736388; c=relaxed/simple;
	bh=mM7T15Z9HB8xLCpzDyCHSZPcHgPKPfrCug4yAJDcmQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E3mpT+dMZljhqMl+dp2h3liqdLKUD/L5F0Lu628UcEawMuB1bD0LcsKOIYPTO3OQ0iFkhHuOpR7/MM8Hk9xz2B38c8/0DrOybvTQug/iEXiWyhtKU82iYXuYONMs73hnO5WjRIw9UBiW/k1GfawnQsIp5ir6BUlfXeo0uGHUW+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kefDkK/M; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c12620ed112so127050866b.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736385; x=1783341185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W6yfFGpGsowdA7nocV8Q2ZeGgDt/heljVkQt2pc3Sqk=;
        b=kefDkK/M/ejh8bFCNS87F0UIv2FohaVYlIztWiGxN4B16ZJT/KHQAuVXF7k4mnqe3M
         S/KCDfz97cx+Y6MLs94zFlGxp3FVBnD4I1EN0WyF5Lx+lmpKi1HnrIjBRFWdTZWwY7/R
         3ifU+4n9iVhEoHU451hs/YHwamFolsgi7knnDU21f8F2sij2V96CGKpXO1uEMbBrwNFf
         r6zn1XmQ96GkZ4lonZ4Tf3CP1w2/5oS79I8v8u/arW3w8mLhLoP8AiJ5OCZawb7OxbuK
         D4IDn4UWXr/1VTOvv3YxIcvzklehp7yEqYM3XFNulvD37tWRSPnrAg/s3kNNta8wwQo5
         61/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736385; x=1783341185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6yfFGpGsowdA7nocV8Q2ZeGgDt/heljVkQt2pc3Sqk=;
        b=WFfCiADaefX24hHV5rqHcYLK/QyhctHKvuch+yjTC/lI9H8X2BqpS6ozBRkB4XEL4Z
         QRb1Vyi/qWoYH0+nPldz3SqkA2BCZTSlAOQgkg7HPQWbNFC11rWSZhpj1t2Nv7gsYphG
         UsmDRMwaV6gc9EvM1jdgiTq2s2u+tYOB6EZIJdxKlvlIccffiWQms0UTRMXGYPAPmGpy
         9Er+sGaQPv6WdIo29vDyrtF9MR6GFa05CRb9FkkcjvgTo0t0Iuyk7YTk/+2GR+TDu4Am
         Qw6rBGE6u4tPTAtYoDu+GrKr4AMNOJie5eZcjhTR4qZh4FO/OzWjwMI9mgFUPwbHzU52
         a0cg==
X-Forwarded-Encrypted: i=1; AHgh+Rozd6lhOkYPI0jNlS1rOsPdyNTObT2/TkRBIVA/BRhYmtjomiiWZVqbQsIdJJkWjYcMcpBJ6nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBh7vhKn75RVd7/Zj5fzUqHD13Isj1YjpydtVKa/dcJJxo6hPV
	nwjRGLb0rMDNP8hnHLbJ6CqatfDc8kxLN4ap9CByl1TXXyMbi1PUk7tR
X-Gm-Gg: AfdE7ckFuBlA5Up2uFRIBWIvqGu7jaoQTT1NVKdtrHrdm5JwRofnuB7mpQ/mp6MMlTG
	gzFTy78YA5zmoMID2/UC18DyJEwDa676OEhpwVfGMnLa20Ma3glPIssh9kr0ImMHJFKzkysFXPu
	xO0N267MyC/WC6ALnngGQW9nTSXmvXi8OHXbB5qZiOpvciHTB4pBr/7xtANCxdWgZVrNZN8gI38
	bBYDcPBmF4r4wpw916+qQjtdRrcSXnFF/ESR+bnNmm8aj2d8uhG5JqnicNZdjioodZv0ycN3XUm
	3s6jPEWbLHsn642ekKbXLmuIG6szze6BCg6ReveNbuMZeYnk0TGsZb27Nd+bRa4mHE7+rdUGMzJ
	QtPowOo6t6TlQx00Mh0Y66R8YISgGTRf84WiYYnvu09FfxijQiIGSzJFx2QcGlfjbf807/RB1S/
	VGg7Fdwj0=
X-Received: by 2002:a17:906:f116:b0:c12:2b66:352b with SMTP id a640c23a62f3a-c123342a062mr351983366b.5.1782736384619;
        Mon, 29 Jun 2026 05:33:04 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm773866566b.39.2026.06.29.05.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:33:04 -0700 (PDT)
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
Subject: [PATCH 0/5] netfilter: nf_flow_table_path: L2 bridge offload
Date: Mon, 29 Jun 2026 14:32:48 +0200
Message-ID: <20260629123253.1912621-1-pawlik.dan@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302605-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:netdev@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:razor@blackwall.org,m:idosch@nvidia.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:bridge@lists.linux.dev,m:coreteam@netfilter.org,m:linux-mediatek@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:rchen14b@gmail.com,m:lorenzo@kernel.org,m:pawlik.dan@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,m:pawlikdan@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,blackwall.org,nvidia.com,gmail.com,collabora.com,lists.linux.dev,lists.infradead.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 091E46DA69E

This series adds L2 bridge offload support to nft_flow_offload, allowing
bridged IPv4/IPv6 flows to be accelerated by the flowtable fast path
without requiring L3 routing.

Background
----------
Hardware flow offload engines (e.g. MediaTek PPE) can accelerate bridged
traffic but require that nft_flow_offload detect and handle bridged flows
differently from routed ones: no routing table lookup, MAC addresses from
the Ethernet header, and VLAN context pre-populated from the bridge port.

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
     and a dst leak fix (allocation references in dsts[] were never
     released after nft_default_forward_path() transferred ownership).
     nft_flow_route() becomes a thin dispatcher.

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
 net/bridge/br_fdb.c                |  32 +++++
 net/bridge/br_vlan.c               |  45 +++++++
 net/core/dev.c                     |  32 +++--
 net/netfilter/nf_flow_table_path.c | 201 +++++++++++++++++++++++++++--
 6 files changed, 312 insertions(+), 23 deletions(-)

-- 
2.54.0


