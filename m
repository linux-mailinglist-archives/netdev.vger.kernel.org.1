Return-Path: <netdev+bounces-266331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Sg/rAqeLsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:22:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CE258345
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425D03018756
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853233C9EE6;
	Tue, 10 Mar 2026 21:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kKkUKGOQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D53C873D
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177764; cv=none; b=mhgacnm0j+vXH7gLzHhCewJ1BpdvGEYYsvCK+DYXxeRucopvCfkYfUbi9+nzYRRPkGy8i11n53gbdAYnDpUbxOYGfWWsqG3rlTxJ6FWfjmoZbt8kyB4soZ8BhFJtcP7gCq0NVbU/FBjXd59c1D/p/OkaQOHbt9acVwyqiWLJxmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177764; c=relaxed/simple;
	bh=2Tsfewli6kOzAqfcjRX+wWMziPIVMge609IlrkkT7k4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slC84On5v0lJTtv9iPQNfpSkNktOK8Kg7XouCLt6AwJLeDETZtoOcIdB6xz+G+sA0fo/JTt7DAsncImlSyELs/UQYjYgKS1OGCe82jQbVd3cMrHgdq6YqfDdsYglJCosZpjZBIfiQL4gl88U7RKP8+jy77x5r8MjDDY1/G94PSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kKkUKGOQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad21f437eeso2680675ad.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177762; x=1773782562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ggoVKtSKOc3N38d3zUE8ZE7aHfSiZIatc4vpDvMzCD8=;
        b=kKkUKGOQYCLRmYHkGLT0+lKG0VuOINw2LtMWynK9Gx6d5DOtgCSPEeXqlwzCyFOLSn
         U7Gw4zj5CCNsRw9mnVYnNiFyo6htJUBO3JO+BJ3qXVRSzeP4ORh0/4sQx/x6eRE/j0EV
         QpngqtJxeLnT0h+OXPRKBaCpezGY8mff3GO086z1v0C4Z3edYEMQ37e2tPaGAPMppI9e
         S1RaerE+mr1lP8NSe33ye78dmT+P3k0sMObVeubMd/x9WOn5Rx/Rp6gxVRLIkralJ9Xg
         cjH0icMbgxHe0C1fGacFQUGFOzZZthfbZpoQZa6o24/twfrgYHhxxSOMPKwusYXrsjIt
         /F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177762; x=1773782562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggoVKtSKOc3N38d3zUE8ZE7aHfSiZIatc4vpDvMzCD8=;
        b=ZVDoOodFz1AzbfAWQ+1B+ZWiyl0Vs1KL864E4cjbbFEdJjbP3gzmwZUJRzpXHguywE
         +wcg17NQxVSd66A/IpALsfy5st5Azxp/uQ1ki4hYiDHsLHoHDba61mQUo0Z7NqDrl3yR
         8DG9DUN4Ojoxs3pYHC7+JnWE73QNXq04HiHXcvtS8UaCwGIRQEsD8JhB0MRa+39wKOT+
         ogKRmLTicjdjGfCQdJYXaZkeW6nmzKqtlUobGhgMEWdWBOhIWoxVrJG+WgPsfcZph8SF
         joFymVexY6s/g99Dxy544lMRrWFsD84DaNoKuAy2gghlZTo3EJD8DNMt3AInHJdKhwsP
         gZ9g==
X-Gm-Message-State: AOJu0YxujfFBsYt6getR0TEHVQ9qdlFoBVPRaDtuXkbOCan7SoZHOyp8
	4DNrNfbBxfo5luaAk/3bM0aGwaggD8im69TJsHtMaMjonctjNlcw2/GvPoUQqVcX2dRIFKVhX3F
	1Qkks6/A=
X-Gm-Gg: ATEYQzydkNqEIneAIz3gBssqueY7POo4y2YOPk4a5KObj4eXtVvh0o6F0h5AWVwDa67
	y3DzGNISPFXlNyRSi6Wl+0T3C3wCVjl0PddLNlTHT66TK85CWqfIaePhPk8XxX/gS2Rzgb6pP7d
	HXDTZKUDtCJbjsRNO+c56V7VSJM9SVeyJRA0cKpS7q0nrtslDsWJUkkqccSUVgIWZgj3DZUPexk
	ygMV20vJEcGFAjKs5XW3sQOZH6l7iqIjIzvLnrqC4HEXq2PL2CPObkz239vm2pzkX4jiN9A0IAs
	MsXC6Sga8wdFdIKmHsfGQ2suMIMjP8S4gDuyz8JrKs1P4hTfC3mleGHZt1bm8epQ8rZlg9q58Tl
	aQ0xbjH+nTBsiclVDykTEVJhNlAQ0imTouPNRFufThgMPTpPOcRJlOUHjU4qMIBm6l3SgWhPjCR
	8D9WCWXHjpw3sbRA==
X-Received: by 2002:a17:903:350f:b0:2ae:478f:2ef with SMTP id d9443c01a7336-2aeaed1ea80mr1249475ad.28.1773177762359;
        Tue, 10 Mar 2026 14:22:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae246fe5sm2091485ad.28.2026.03.10.14.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:41 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [RFC net-next 00/10] Add TSO map-once DMA helpers and bnxt SW USO support
Date: Tue, 10 Mar 2026 14:21:48 -0700
Message-ID: <20260310212209.2263939-1-joe@dama.to>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B9CE258345
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266331-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,dama.to,kernel.org,lunn.ch,iogearbox.net,davemloft.net,google.com,gmail.com,redhat.com,fomichev.me];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Greetings:

This series extends net/tso to add a data structure and some helpers allowing
drivers to DMA map headers and packet payloads a single time. The helpers can
then be used to reference slices of shared mapping for each segment. This
helps to avoid the cost of repeated DMA mappings, especially on systems which
use an IOMMU. N per-packet DMA maps are replaced with a single map for the
entire GSO skb.

The added helpers are then used in bnxt to add support for software UDP
Segmentation Offloading (SW USO) for older bnxt devices which do not have
support for USO in hardware. Since the helpers are generic, other drivers
can be extended similarly.

Early testing shows a ~4x reduction in DMA mapping calls at the same wire
packet rate.

Special care is taken to make bnxt ethtool operations work correctly: the ring
size cannot be reduced below a minimum threshold while USO is enabled and
growing the ring automatically re-enables USO if it was previously blocked.

Thanks,
Joe

Joe Damato (10):
  net: tso: Introduce tso_dma_map
  net: tso: Add tso_dma_map helpers
  net: bnxt: Export bnxt_xmit_get_cfa_action
  net: bnxt: Add a helper for tx_bd_ext
  net: bnxt: Use dma_unmap_len for TX completion unmapping
  net: bnxt: Add TX inline buffer infrastructure
  net: bnxt: Add boilerplate GSO code
  net: bnxt: Implement software USO
  net: bnxt: Add SW GSO completion and teardown support
  net: bnxt: Dispatch to SW USO

 drivers/net/ethernet/broadcom/bnxt/Makefile   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 159 ++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  27 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  19 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 188 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h |  31 +++
 include/net/tso.h                             |  45 +++++
 net/core/tso.c                                | 165 +++++++++++++++
 8 files changed, 601 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
 create mode 100644 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.h

-- 
2.52.0


