Return-Path: <netdev+bounces-114635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B7D9434E9
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A75228AF9D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546EA1B140E;
	Wed, 31 Jul 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="IWENG9Az"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C161A71EF
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446632; cv=none; b=uWKTXpiDmvdAEqx+adG6tnplvcbyPa9QnngJHc8InWVfAQBy6UzzDYjMYjHbS03uwVUN7mRy8Bg+nML/QWQuwYVm3W5QFZfjFM/OkU+5Z3MU5tSqQBJUO2Nbe1n09XbIj3A3dPSHYf3YvhcoKWkv/MTrL28UHlA9jPa03bdTzzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446632; c=relaxed/simple;
	bh=zqeowdWCnvDiwcnfqOigrX3NnbSz+D2+thwBIXtmTok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=muf7OsHu2nnJrplQv4tlgUJUtzd9bWNiZZydiK87BxLq0Gz2ktDSU8JFRh9aUNQoLNzJuuUKYar02gwZkdEcgGIV5O0ZMyHgjG8rwm7JnIH2ID3OD1yxUIg24BOBT9iQBkDv/adDw1HsAHvZb+SpyBnG6DD3uRj2GP08AUOIy6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=IWENG9Az; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d399da0b5so5249415b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 10:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1722446630; x=1723051430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EFXAC3En+nby7BnSIGL4HNcfIMrPErA046em3CKx/dw=;
        b=IWENG9Azs7Jr8dkAYKet/cXSmEsaqKFaQj/SMipulBbT0eHeHaQ9pQZKY44xLPs/R+
         3E9M9W952oF1r/y8CAMrzTNNGhuZQXdDbdyZngIdBNwuMe3HTiteUq4CDd24IWHM7KhF
         BwtRwhTHXf67levVdfbOZKHwqKl5U+WugZDWNbFnzlKITi7kMESpdDmr/23KnxbL0Rr5
         zIOc0pX5bSVx+inRsReq3ts5RiBlaL7nQP+bcIlNHi+7TUgik7y7QOqJ1K9LnIWXNbOk
         J9oXfwIWsZ+s9/5wmKrS92LObj37DWY85ZkeGGjm7fZU1V/0O5Do79O/2tzjUJkm61mR
         u0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722446630; x=1723051430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFXAC3En+nby7BnSIGL4HNcfIMrPErA046em3CKx/dw=;
        b=ikmxJepr/hDSuYFZY2F865VoHap7DVEbqYykrU0fPjDbVVcpXMSdPibWp39kON2ztj
         IK9E2kfs/TJgcrj1fzjkiYxCOTFTmWDt7rvPLQBTnBuw7HdaspUh7wO4yV1Jq42M1VhO
         0VN3ySgElKwI/hOOHG7t0pcSyAwWHI6t73PqDY96uuANfCslb1iG9vd6Hc77cSiLUOqI
         6CMjoPRdb4+12erXflKH8hKjhZWdoF5Wpae8pQSqgup3sJPCwPT/godEZYbs94Ot0MoI
         kPiTLCmsHPMzpbW+ewVzoObnyM4tWYAgolP44Nng+sVrkxfiuHdARfJTNAG2BuHEJ25Y
         AZlw==
X-Forwarded-Encrypted: i=1; AJvYcCXXQYhgOh8MbLdFHaOS1OAsxZvrxAOPOy5Xq2VxNrjw+Wm+UBOISzmXvPuel+dGw4RZ+2VNFtQdvdxR6s1mojPLnhivLK8I
X-Gm-Message-State: AOJu0YwtD7uVSXLcO1GIXkRzpAMMz3QhpBlpnk/BfHxqMttK/sqhkSih
	/DPpK1HSLFTMALKFc0GAsScXdGeyggFf7XLBUWBJdjhyXjo91AzE2S4rwcEScA==
X-Google-Smtp-Source: AGHT+IEXob9KuKgKPMiX/KWWUHXzZoUy9a7C1F2o2DE7MHH7ePXltEw/lgEk0vA0rDTS7Yyfz7aqYQ==
X-Received: by 2002:a05:6a00:21c7:b0:70d:14d1:1bb7 with SMTP id d2e1a72fcca58-70ecedb305dmr19035745b3a.28.1722446629767;
        Wed, 31 Jul 2024 10:23:49 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:be07:e41f:5184:de2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72ab97sm10487203b3a.92.2024.07.31.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:23:49 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH 00/12] flow_dissector: Dissect UDP encapsulation protocols
Date: Wed, 31 Jul 2024 10:23:20 -0700
Message-Id: <20240731172332.683815-1-tom@herbertland.com>
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

Tom Herbert (12):
  skbuff: Unconstantify struct net argument in flowdis functions
  flow_dissector: Parse ETH_P_TEB
  flow_dissector: Move ETH_P_TEB out of GRE
  udp_encaps: Add new UDP_ENCAP constants
  udp_encaps: Set proper UDP_ENCAP types in tunnel setup
  flow_dissector: UDP encap infrastructure
  flow_dissector: Parse vxlan in UDP
  flow_dissector: Parse foo-over-udp (FOU)
  flow_dissector: Parse ESP, L2TP, and SCTP in UDP
  flow_dissector: Parse Geneve in UDP
  flow_dissector: Parse GUE in UDP
  flow_dissector: Parse gtp in UDP

 drivers/infiniband/sw/rxe/rxe_net.c |   2 +-
 drivers/net/amt.c                   |   2 +-
 drivers/net/bareudp.c               |   2 +-
 drivers/net/geneve.c                |   2 +-
 drivers/net/pfcp.c                  |   2 +-
 drivers/net/vxlan/vxlan_core.c      |   3 +-
 drivers/net/wireguard/socket.c      |   2 +-
 include/linux/skbuff.h              |  10 +-
 include/net/flow_dissector.h        |   1 +
 include/net/fou.h                   |  16 +
 include/uapi/linux/udp.h            |  13 +
 net/core/flow_dissector.c           | 434 ++++++++++++++++++++++++++--
 net/ipv4/fou_core.c                 |  19 +-
 net/sctp/protocol.c                 |   2 +-
 net/tipc/udp_media.c                |   2 +-
 15 files changed, 452 insertions(+), 60 deletions(-)

-- 
2.34.1


