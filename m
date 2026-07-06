Return-Path: <netdev+bounces-305104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ulf9G1vIS2qtaAEAu9opvQ
	(envelope-from <netdev+bounces-305104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:23:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F735712848
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:23:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pZe97Zap;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305104-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305104-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9385A31B0F81
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2622537105A;
	Mon,  6 Jul 2026 15:02:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A1274B39
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:02:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350140; cv=none; b=DWnf0X8YcUdWKSAzQOSI7x9sa/Pmk4aAGilq6PwtCRe3CNQGj9bqhTeLMT1cX0N1QCegoqT2NtTyxfjGd+JAWxPsX1pZAEg7lBHvjdp8sSEvUGstIcVjQwE643eyapfNP+6TEyUtcNwDzDWmOpFEydub+dOG8LDm3JB7hshm+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350140; c=relaxed/simple;
	bh=Tu1T8CD2gLrLisSnGvRjNH6xqg64dimtg4QpZpNNiRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ebXKX/L06eT+aU0KLPy3xKZUhiMs5jXmMguAOgW7z88+h4A71QXmTAfdDbduhniz5I2XVUj+Bg96FKQ4/JAhZE1ndXmWkF1a3HYofHqvRaoUK0RLuQmOTzKbiZ/0GLLz6DtIEvitMgzhCg+qCfFrcYDCLSoNQlSbDEt1DJ23zM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZe97Zap; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7c61b5292so46168495ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783350138; x=1783954938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LB5HPrejrIhgE2QNFJCFw/424JZb2O52qaJtg8sw1Ew=;
        b=pZe97Zapn0EDrxm/vTHJXREd4FGa+k1xib76tr0CVkYrdy/t4dfFZ0XN17YgVOPF0l
         eI3cwqDHV8ILRCfycZamEjiPAAW4UjxB4F85ARAfwzwTkPCQew207LKkjNeD4PzHzUP+
         BY0z8RsD+dqNwGrvhpRTGEgNUmnpU8AwtDatPXBSGxyg+OhU37Y4gXCZokb0MOMWQals
         kILtPwZM/44w85L9Kx40kjHEGaGiZQJUEGtVZLyBrpdu44J+jRjZa10RLxMgRkUwG7jk
         b8NP/Ilzjf7lOK3qO21q7ukS+ZEb7374q5m1pXhkshrtIBYeFfkfiP9SbZGNLWggFA1D
         34Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350138; x=1783954938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LB5HPrejrIhgE2QNFJCFw/424JZb2O52qaJtg8sw1Ew=;
        b=eiNwMHLz1brlFhgywM5lQK6VasQzd6/tag2EgKYbJ7/XwwEyfRscRY3P8l6fIXdFng
         T5AZyqGgxDOrERR+1+PFNSbEmFPPyiEy9//lvGrObba8jbg400YmUBCdT+OPBtYTUdbi
         uK8eTnD0R5sXchI3tEeS4FkATR8+3fXI4LRDYmXQS0OEPe7H1AuIfVT1al7q7l3X70Pa
         FcJWBW6m2VxkBlSi33Rwhw/YTUmCSRCI/VRMNj74ARjtxoRbUCS0jUzRW1Yj48NSipv3
         UcAYwyjk+x3T8dK0oIb1NS6TEk8wvYE6WRRojoz7l6CZsD0cNxk6Mijy9YeHzse495Dh
         RKsw==
X-Forwarded-Encrypted: i=1; AHgh+RqI6ThQkZGceo99FS3/WMpi55H+zukKwn3a5rHwO0wrZmrRX5VTMB8dzy5b56KBwQe4stsQnwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyK8zz1+HeiypOqx6n6aQgSE3Jku/Ql+7wL6Kwh+4QkFoB5dCj
	4DNAVyY7Zq9qFaeUITHjBR1txnxYD7FXzYXUfQuUE2e+LjbZYKPaWu1u
X-Gm-Gg: AfdE7cmFaHlIVgbK+rQplPlwCVO0J30dL8ExvRAtqLFDtZELVwL2wFNsMq1XMDDmK3H
	1HfU1smjm2Szqm3sZN5obpMLUx8w9odHhom58j0X0CR3s4b0ya4lXUMM0QYBBV3UD/+Q5z3fSvm
	hYspyi30H6E9jFe4lmCejPIVysoX2f7fxGT3mSjya0L55W2vTCkzx//385fDOGXoh2O5BBxnOgN
	DK0WZTBfmjiE3KVmnK0j/FSH6eTBcv7slH8vBX44bmkLR2373/6nIPPA05uyzkrycuv4WNXYBrf
	D7lzMwHy599Hwf++PqJgjACa6hl5fOTyEgmg/v05LHE/3RjBNZleXrgQZ1KXs19unlC8kHnJc4U
	eYWydgp/jdoQKWRHJhr6530nz7PzsbHO9q7ayOskoFWlMzoOx1iUqUN5f+WiNBIw6koz1bULsU6
	CSyiOp8JO6b141hLWLL4OP/LQyMoHf1l+gV0u2VA==
X-Received: by 2002:a17:902:cec2:b0:2c9:c46b:1286 with SMTP id d9443c01a7336-2ccbf07a0ebmr9811045ad.34.1783350137600;
        Mon, 06 Jul 2026 08:02:17 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cb3f5b7090sm41651765ad.26.2026.07.06.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:02:16 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 0/3] octeon_ep, octeon_ep_vf: fix RX skb frags overflow and page leak
Date: Mon,  6 Jul 2026 23:02:05 +0800
Message-Id: <20260706150208.2944898-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305104-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vburru@marvell.com,m:sedara@marvell.com,m:sburla@marvell.com,m:srasheed@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maciej.fijalkowski@intel.com,m:lgs201920130244@gmail.com,m:devnexen@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F735712848

The octeon_ep and octeon_ep_vf RX paths add one skb fragment per buffer
with no bound against MAX_SKB_FRAGS. buff_info->len comes from the device
response header. A long packet needs about 18 fragments. That is one past
the default MAX_SKB_FRAGS of 17, so skb_add_rx_frag() writes past
shinfo->frags[]. Patch 1 bounds octeon_ep. Patch 3 bounds octeon_ep_vf.

Patch 2 is Guangshuo Li's fix for an octeon_ep_vf RX page leak on the
napi_build_skb() failure path. It touches the same drop code as patch 3.
I carry it here so the series applies without conflict, per Maciej. Patch 3
moves that drain loop into a helper. The helper carries the page frees from
patch 2, so the overflow drop path frees its pages too.

octeon_ep has the same leak on its drop path. A separate patch will fix it
once this series lands.

v4:
 - add Guangshuo Li's octeon_ep_vf page leak fix as patch 2, per Maciej.
 - octeon_ep_vf: the fragment count fix now sits on top of patch 2. The drop
   helper octep_vf_oq_drop_rx() frees the head and fragment pages.
 - octeon_ep: no change, keeps Maciej's Reviewed-by.

v1: https://lore.kernel.org/r/20260701112825.1653044-1-maoyixie.tju@gmail.com
v2: https://lore.kernel.org/r/20260702180518.2013324-1-maoyixie.tju@gmail.com
v3: https://lore.kernel.org/r/20260704061511.2350737-1-maoyixie.tju@gmail.com

Guangshuo Li (1):
  octeon_ep_vf: Fix RX page leak on napi_build_skb() failure

Maoyi Xie (2):
  octeon_ep: fix skb frags overflow in the RX path
  octeon_ep_vf: fix skb frags overflow in the RX path

 .../net/ethernet/marvell/octeon_ep/octep_rx.c |  9 ++++
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 49 +++++++++++++------
 2 files changed, 42 insertions(+), 16 deletions(-)

-- 
2.34.1


