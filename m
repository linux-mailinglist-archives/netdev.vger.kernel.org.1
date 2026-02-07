Return-Path: <netdev+bounces-257682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L6TFMKShmm6OwQAu9opvQ
	(envelope-from <netdev+bounces-257682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:17:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1CF1046F4
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533553014945
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 01:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C3821771C;
	Sat,  7 Feb 2026 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzOro2v9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E91E633C
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427065; cv=none; b=dOYEahQxYUxkp5JeeNkh5wpNfWPAvEgQYMzjwuq45bntClaSc8cyX39Kvof8FG9wwg+8xSKTdVpqmZiPAUeyfiAmjaQ1c12zvj0Q/M/2cL/W0ewcAvHsWmDqZsMtN2O81a/+vFcTKje7dp0pTGCMJ+O2WbvS3w13/AsUUsVR4DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427065; c=relaxed/simple;
	bh=LTsf/TSVwNz2cEvFv4s9dRHVQIZcvh2GlQOpDb95vG8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jxotbjX1tvecv7P3/hkJ4lNxZpcGRzVCRc2liD9il8A8dIuXyKc4wxGAi4oMNJuvaeMVEHH6TsijHbw60hpnHy4JHbxeKiL8ibe1eu9H6zMLQ4MMlY1D/r9W1a16W4KpW3e1HJPyzUtRID4A29kVTPSngNtRWnxKtffsXLfAE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzOro2v9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a07fa318fdso27921535ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 17:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770427065; x=1771031865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YB5D6QwebSMgwOJ7AC6KacMWb4KznbLOlhBY6c43cc4=;
        b=hzOro2v95F39yru+fuZafY2SxHDluTqH/L0Kfj+42yuQvlA8ZUWWtIl8GGDW6IBrDA
         1AT7hmD8GpeHeg44Y89Al8JpN5FoTmCHeF5TK3a62FOb4zkQLm6Ysngs4SVULyduOMco
         UoM2lSnpW41C0b5uSL4US/aqSqcneeIvO8fJ98E6PoZjx5ifY06zOEWizXT8l1k8elGe
         zjkfFa2i5uTi2ZFdLmeYJBr5gIgUYFrNaB2hTx/lvJPpVPzapWcYeB8YcAQSJaFfZj6M
         09ymDXXgw0KKJNKBwPfEU/NTdfmiKFM6qDrYzK5SEEfEhXhQPlLEkLSAplDDJm6B0Kxg
         ad6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427065; x=1771031865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB5D6QwebSMgwOJ7AC6KacMWb4KznbLOlhBY6c43cc4=;
        b=s0mFtkMtrRnogyffgCuOWd8G520jBQ0R4Vnoz9Vspa4J9jFcNfOiB0vGsfqnHvHJLt
         jq2YOsyuudsl8BEXN2cIixOu/5TPXJR6Sd5jV3OdqyRPZjzTEuZH5Gl5BzLwc/mjbGKZ
         z7Mm122/CUaNOrukB43Exhvgqe+qbTlXfdJI/HJ4DovZZAwzO1S9MAM6/+xQUc0MtEpD
         EBEv4yo6eS5myZsE9+Z6N9fLoSYWIXuznDV65C0OMwHpl9WjRd2eFQrHbFi8mKlwpmoS
         iHw3rPFaLUh8/Aj9C+RMQI+kEGJ335HbjnJ0YwMB2Nb3NSPK0LfY8ZpEUfpePFte9Rh2
         I1dQ==
X-Gm-Message-State: AOJu0YzsyQTD9j+3oslaCbOqIj0Mwe8jZVKDdIBevRKcCm3B7I6fWYC5
	q7J2TJMiU6xNFR4yigY4NbUGCpXx6JnS0UwFLTgqe264KcRhx/OLlme8vWQudG+emQDgvtGIC+L
	AnPIwn2+pHzGQ5eEvO/E1D8wdN1b7obMErbt/DKZHbYa5pTr3eX0JyfpWxXaXaOIDB+iAy/Jj2x
	Ky1YtIdDPNQDHds4uDZBBGwBbSNGIsdx9vEzKZMnncLT7hK/M=
X-Received: from plbms7.prod.google.com ([2002:a17:903:ac7:b0:2a7:80f3:ce5a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1904:b0:2a9:629d:b618 with SMTP id d9443c01a7336-2a9629db74cmr8441995ad.15.1770427064788;
 Fri, 06 Feb 2026 17:17:44 -0800 (PST)
Date: Fri,  6 Feb 2026 17:17:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207011734.437205-1-joshwash@google.com>
Subject: [PATCH net-next 0/2] gve: Support larger ring sizes in DQO-QPL mode
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, John Fraker <jfraker@google.com>, 
	Matt Olson <maolson@google.com>, Bailey Forrest <bcf@google.com>, Tim Hostetler <thostet@google.com>, 
	Jordan Rhee <jordanrhee@google.com>, linux-kernel@vger.kernel.org, 
	Max Yuan <maxyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257682-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB1CF1046F4
X-Rspamd-Action: no action

From: Max Yuan <maxyuan@google.com>

This patch series updates the gve driver to improve Queue Page List (QPL)
management and enable support for larger ring sizes when using the DQO-QPL
queue format.

Previously, the driver used hardcoded multipliers to determine the number
of pages to register for QPLs (e.g., 2x ring size for RX). This rigid
approach made it difficult to support larger ring sizes without potentially
exceeding the "max_registered_pages" limit reported by the device.

The first patch introduces a unified and flexible logic for calculating QPL
page requirements. It balances TX and RX page allocations based on the
configured ring sizes and scales the total count down proportionally if it
would otherwise exceed the device's global registration limit.

The second patch leverages this new flexibility to stop ignoring the
maximum ring size supported by the device in DQO-QPL mode. Users can now
configure ring sizes up to the device-reported maximum, as the driver will
automatically adjust the QPL size to stay within allowed memory bounds.

Matt Olson (2):
  gve: Update QPL page registration logic
  gve: Enable reading max ring size from the device in DQO-QPL mode

 drivers/net/ethernet/google/gve/gve.h                 | 18 ++++++--------
 drivers/net/ethernet/google/gve/gve_adminq.c          | 18 ++++----------
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c            | 40 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c          |  6 ++---
 drivers/net/ethernet/google/gve/gve_tx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c          |  4 +---
 8 files changed, 57 insertions(+), 41 deletions(-)

-- 
2.53.0.239.g8d8fc8a987-goog


