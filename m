Return-Path: <netdev+bounces-118997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75760953CDC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A11C22260
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84E14B092;
	Thu, 15 Aug 2024 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="H7nkpzKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7C24AEE0
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758375; cv=none; b=JDSTojvBTQH0oSMagnqPZs3oRhaJKtqFi68A09AydlLJzw2JRUSZzpEuIWZS2w0n87EC/WEu3rD0NpLdirPV2yx23OP5wueDqJYDV/Topu0nFppOAnzeuSxt0R7auNd9xrUXzaAdXhTWY2Pu5mIfINRPF1WS7qoBUXrMnq+92/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758375; c=relaxed/simple;
	bh=mwUshcnsI4J5ao0Xb7G3kis/C/OjCskQqdgH6istNOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iq43i71a6yM5v5NTZrEp+B8Aec/5Z/+D2xEltJY168UA1/XPbttt52zdqYYz0ampaj3mrPj5QG/5Z72GCzVrAYtJL18S32vhDTKctWajHMZAh2weAQ/iMwEj/IusJb4LZPb66o/jCSAYB0gh+oD4G/z03dWi9B2GJcAwgIaUUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=H7nkpzKg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d1daa2577bso1022559a91.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723758372; x=1724363172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQJzWtgO7mVF7Lm7VCopqbFYg5pClOx8ymNZm52Kszc=;
        b=H7nkpzKgRQd5N0VXBAT267r82ebV722DwzY++AVEGy1+h7fR18DlrjGwXnmHsNZ9Fq
         TUo5ABdlXRwSnOiER5DGg1qsYn5NptZ1EtNPfT6B1ODvv0lUxJWiN0q/M3OgEigh7js9
         hGW+WMrZ8/PHwKXM/XLnDrSaokeQiyTkMZC0rgE5KpL/EdXswMb89QpE0+tlPehXkZNC
         eimb28/9vM+F7QKA1i5TlADLiNtFRJNm9lzDkpZALx9TvR3eBicGsJXw1CyyaRmwvOwU
         BZAI2gLPRQTLLi8LJM8Ua0zmjTgfsVaUrUfo1tD5WN6T0II6khVZAOGwc49Fvf0jDn+J
         o9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758372; x=1724363172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQJzWtgO7mVF7Lm7VCopqbFYg5pClOx8ymNZm52Kszc=;
        b=m5Mj4Po6hjqm/5HfPw7K693bpVSdSpG55Nw+CTHsyoL0hzv/pvndwDgGyxzDj53KgO
         U8sUE4VkTo8mlTosABZFk8Oq+awX2Z/+vtQBP5vkgjsLPB0BsUOGmSpOLAPPuwUe2tXG
         x3mmmnyQfMjLMmRl69pJAgCYzA6WSxhFWg/NuILEvp8RaUgzHGP2rC47z6KQ1PODoaGf
         RjonchUIVrpTwBtFiQQhOAynkpJfhpSoWluEyZSwy+o5TAcVpA+I2rz4Sa/XzWd6gqUK
         ia5DdspGjDBxXZVDQA36qsa2BO8Cpq788xqs4zvpHOiKcJome3DgCd3hug7rQMQRePku
         Eitw==
X-Forwarded-Encrypted: i=1; AJvYcCWZyhjm5rfeF6oZ+peYC9idAAxDVppcoGvailgKMCLD5qamMPfbLx8EQwbnGm8DcYgnK49fdZY92URplvdFazFCTLPvvc/J
X-Gm-Message-State: AOJu0YwGgqJfSD+XhibhS/qjL8znYx/7NPN75TCIkWgprmmnmrFDBq3W
	/Vqz4CJ+TpCf0rA8PPQSm0M3IWyhwo2MYuRseA4Ht8etwWyexVo8Ll16WR6HRA==
X-Google-Smtp-Source: AGHT+IF25UJmXUah3eG2Tj8TMnWVHJWuWauxJsyawmcLHqiaA++XBwoSouWNuRPwohZxTtV2x95KHQ==
X-Received: by 2002:a17:90b:2bd1:b0:2c9:4c3:3128 with SMTP id 98e67ed59e1d1-2d3dfacd3c7mr1141313a91.0.1723758371999;
        Thu, 15 Aug 2024 14:46:11 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:99b4:e046:411:1b72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2c652ffsm303288a91.10.2024.08.15.14.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:46:11 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v2 00/12] flow_dissector: Dissect UDP encapsulation protocols
Date: Thu, 15 Aug 2024 14:45:15 -0700
Message-Id: <20240815214527.2100137-1-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support in flow_dissector for dissecting into UDP
encapsulations like VXLAN. __skb_flow_dissect_udp is called for
IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing
of UDP encapsulations. If the flag is set when parsing a UDP packet then
a socket lookup is performed. The offset of the base network header,
either an IPv4 or IPv6 header, is tracked and passed to
__skb_flow_dissect_udp so that it can perform the socket lookup.
If a socket is found and it's for a UDP encapsulation (encap_type is
set in the UDP socket) then a switch is performed on the encap_type
value (cases are UDP_ENCAP_* values)

Changes in the patch set:

- Unconstantify struct net argument in flowdis functions so we can call
  UDP socket lookup functions
- Dissect ETH_P_TEB in main flow dissector loop, move ETH_P_TEB check
  out of __skb_flow_dissect_gre and process it in main loop
- Add UDP_ENCAP constants for tipc, fou, gue, sctp, rxe, pfcp,
  wireguard, bareudp, vxlan, vxlan_gpe, geneve, and amt
- For the various UDP encapsulation protocols, Instead of just setting
  UDP tunnel encap type to 1, set it to the corresponding UDP_ENCAP
  constant. This allows identify the encapsulation protocol for a
  UDP socket by the encap_type
- Add function __skb_flow_dissect_udp in flow_dissector and call it for
  UDP packets. If a UDP encapsulation is present then the function
  returns either FLOW_DISSECT_RET_PROTO_AGAIN or
  FLOW_DISSECT_RET_IPPROTO_AGAIN
- Add flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS that indicates UDP
  encapsulations should be dissected
- Add __skb_flow_dissect_vxlan which is called when encap_type is
  UDP_ENCAP_VXLAN or UDP_ENCAP_VXLAN_GPE. Dissect VXLAN and return
  a next protocol and offset
- Add __skb_flow_dissect_fou which is called when encap_type is
  UDP_ENCAP_FOU. Dissect FOU and return a next protocol and offset
- Add support for ESP, L2TP, and SCTP in UDP in __skb_flow_dissect_udp.
  All we need to do is return FLOW_DISSECT_RET_IPPROTO_AGAIN and the
  corresponding IP protocol number
- Add __skb_flow_dissect_geneve which is called when encap_type is
  UDP_ENCAP_GENEVE. Dissect geneve and return a next protocol and offset
- Add __skb_flow_dissect_gue which is called when encap_type is
  UDP_ENCAP_GUE. Dissect gue and return a next protocol and offset
- Add __skb_flow_dissect_gtp which is called when encap_type is
  UDP_ENCAP_GTP. Dissect gtp and return a next protocol and offset

Tested: Verified fou, gue, vxlan, and geneve are properly dissected for
IPv4 and IPv6 cases. This includes testing ETH_P_TEB case

v2:
- Add #if IS_ENABLED(CONFIG_IPV6) around IPv6 cases when dissecting UDP.
  Also, c all ipv6_bpf_stub->udp6_lib_lookup instead of udp6_lib_lookup
  directly since udp6_lib_lookup in the IPv6 module
- Drop patch to unconstantify struct net argument in flowdis functions,
  edumazet added const to ne argument in UDP socket lookup functions
- As support in flowdis ipproto switch for no-next-hdr. Just exit
  flowdis on good result when this is seen
- Merge patches that move TEB processing out of GRE and moved into
  main protocol switch
- Rename bpoff in UDP flow dissector functions to be base_nhoff for
  clarity
- Parse GTPv1 extension headers (part of this is moving
  gtp_parse_exthdrs to a header file
- Exit flowdis on good result if NPDU or SEQ GTPv1 flags are set


Tom Herbert (12):
  flow_dissector: Parse ETH_P_TEB and move out of GRE
  udp_encaps: Add new UDP_ENCAP constants
  udp_encaps: Set proper UDP_ENCAP types in tunnel setup
  flow_dissector: UDP encap infrastructure
  flow_dissector: Parse vxlan in UDP
  flow_dissector: Parse foo-over-udp (FOU)
  flow_dissector: Parse ESP, L2TP, and SCTP in UDP
  flow_dissector: Parse Geneve in UDP
  flow_dissector: Parse GUE in UDP
  gtp: Move gtp_parse_exthdrs into net/gtp.h
  flow_dissector: Parse gtp in UDP
  flow_dissector: Add case in ipproto switch for NEXTHDR_NONE

 drivers/infiniband/sw/rxe/rxe_net.c |   2 +-
 drivers/net/amt.c                   |   2 +-
 drivers/net/bareudp.c               |   2 +-
 drivers/net/geneve.c                |   2 +-
 drivers/net/gtp.c                   |  37 ---
 drivers/net/pfcp.c                  |   2 +-
 drivers/net/vxlan/vxlan_core.c      |   3 +-
 drivers/net/wireguard/socket.c      |   2 +-
 include/net/flow_dissector.h        |   1 +
 include/net/fou.h                   |  16 +
 include/net/gtp.h                   |  38 +++
 include/uapi/linux/udp.h            |  13 +
 net/core/flow_dissector.c           | 448 ++++++++++++++++++++++++++--
 net/ipv4/fou_core.c                 |  19 +-
 net/sctp/protocol.c                 |   2 +-
 net/tipc/udp_media.c                |   2 +-
 16 files changed, 502 insertions(+), 89 deletions(-)

-- 
2.34.1


