Return-Path: <netdev+bounces-261056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCOWMTg/n2laZgQAu9opvQ
	(envelope-from <netdev+bounces-261056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:28:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F1819C42B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82ED9317DB32
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 18:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056F32F260E;
	Wed, 25 Feb 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cEjz7bZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6712F0C79
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772043825; cv=none; b=FlCYTJbAQoe56lN9bwvE8x40rGHjXeJHqBSHOYnDW6jWL8NRdmYeYPGR8Sep/cddJUabdTRkhp5uL+pBrJoIPl/zWRc8dlVmc+30HqYgpJDs2hQjPZNLgz4f0+Z8aBQ87sCRJZ0Pmny5nw2zLHn8oOsfCVKBxvhIwjXoVfG7wmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772043825; c=relaxed/simple;
	bh=zbbAb4hbGZG9ZX0c/X+ExzY3EiH2KjgoJF/y/bXgQT0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SOaTR1/Em0Vfyn/fD90ktSQoxeHdah+V0G9/Azq1tpQjwtEWm1Ua7KvwoFSEqiZMuWYkbb0+8DPr6koq/5aFMiiDz0BL+rkLa1BWhfm0FRUXGgA80KIUwhrw/mZbWm9hlKRdWrcIQLBgh7bB3kbQa8lKO1H5ZhBuc4NynJ/PoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cEjz7bZA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-824bbce0a44so128112b3a.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772043824; x=1772648624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ktu6SeGgYKKiMVsHnqdxWPPUmtvwSDIR8ap7D3L+YXA=;
        b=cEjz7bZAOWntpjzS0pUYyB0h2bPxwkqpCT2XRYXjwZf+UdDQeo81EpJ7PvcKJ97HGG
         4GD4Uym2jO2n+7BfUXOTlPuaCyk3SX5hcsT5rk87ZVBGkMZjo27hbYU33u73FM0PDi6d
         G8owm7+Gs5jpnu6D/Z5qo/a+igOnBNQBYUckCmjrP1P8UYlO1pLaeJgPz6v537ctMuff
         MWqb1TS0j76rRKnpwqMeJk5YiOGf/X+ZJYfrjG7BIyEmrcZePwNJcltVsoNzq9t3Xn5a
         4Tit/Xh0jN2XboUHmqOra8GZMM+p4SkeAHzoWHPn6Vy49JE1zDCraie5b4fmdDiD2lUg
         ilJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772043824; x=1772648624;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktu6SeGgYKKiMVsHnqdxWPPUmtvwSDIR8ap7D3L+YXA=;
        b=CyT1lsY43MfAplU5OVtU3cCrK5lagEsTccpe8MVGPwWpvqkNg/I152jAl0EuxEUBWn
         3GgiLnPwjW9HQaCKeB38nzoO5kQ+Id0tXGA+xDJ8IZV2hgWQbpu2g2u2fe5DD/NngZPv
         W0P51FR9sNuSJZssFOeQ6AHVXfluuVds5gatwJ4VxA7WL50sGOVsXYDyE+bb7zF879u0
         IJVkMckinUa9RE+TXXb4aMrNilG9Xx4dKZyC7hcQUYSSD+yWw2t8nPEtGDO8j9wX8qvI
         HGZY7ODxntD2/+PLPz0t75vKFrc3GyKGDNVjqjQ1kRHf1uHa4u1+GnHhP+rIU2R0MYP8
         Xggw==
X-Gm-Message-State: AOJu0YxQo/Wpg4NIk2aN+A9BznyJd1acqR3CEUsTCg0oJ85P11hkOaMd
	/dTiSkBsSu45pbXbnUSqKXy0CH/pgwPtaYD7MvignzRhOzHjaogVf22lGMg4ZVvluC3tzCmzlcr
	+7/mUdEZfYi7wuOmYVh5RFJ+OY29shQCNgaLe9TKMLIlBhCnmUa+J91H59JjBTTomlmsbTdi0ek
	Ty0v8U3Y28XXBjPjmgIlC8hP+HDuwgRz3UUHURdf4T9vYuJQ0=
X-Received: from pfnr15.prod.google.com ([2002:aa7:844f:0:b0:81e:87c3:f7a6])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e85:b0:7b9:420:cc0f with SMTP id d2e1a72fcca58-826da8ee344mr14377279b3a.14.1772043823762;
 Wed, 25 Feb 2026 10:23:43 -0800 (PST)
Date: Wed, 25 Feb 2026 10:23:40 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225182342.1049816-1-joshwash@google.com>
Subject: [PATCH net-next v2 0/2] gve: Support larger ring sizes in DQO-QPL mode
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	John Fraker <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	Matt Olson <maolson@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bailey Forrest <bcf@google.com>, Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-261056-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31F1819C42B
X-Rspamd-Action: no action

From: Max Yuan <maxyuan@google.com>

This patch series updates the gve driver to improve Queue Page List
(QPL) management and enable support for larger ring sizes when using the
DQO-QPL queue format.

Previously, the driver used hardcoded multipliers to determine the
number of pages to register for QPLs (e.g., 2x ring size for RX). This
rigid approach made it difficult to support larger ring sizes without
potentially exceeding the "max_registered_pages" limit reported by the
device.

The first patch introduces a unified and flexible logic for calculating
QPL page requirements. It balances TX and RX page allocations based on
the configured ring sizes and scales the total count down proportionally
if it would otherwise exceed the device's global registration limit.

The second patch leverages this new flexibility to stop ignoring the
maximum ring size supported by the device in DQO-QPL mode. Users can now
configure ring sizes up to the device-reported maximum, as the driver
will automatically adjust the QPL size to stay within allowed memory
bounds.

Changes in v2:
   - Fixed 32-bit compilation issue by using div64_u64 and div_u64 instead
     of division operator. (Paolo Abeni)

Matt Olson (2):
  gve: Update QPL page registration logic
  gve: Enable reading max ring size from the device in DQO-QPL mode

 drivers/net/ethernet/google/gve/gve.h                 | 18 ++++++--------
 drivers/net/ethernet/google/gve/gve_adminq.c          | 18 ++++----------
 drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c |  2 +-
 drivers/net/ethernet/google/gve/gve_main.c            | 41 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c          |  6 ++---
 drivers/net/ethernet/google/gve/gve_tx.c              |  5 +---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c          |  4 +---
 8 files changed, 58 insertions(+), 41 deletions(-)

--
2.53.0.273.g2a3d683680-goog


