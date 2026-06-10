Return-Path: <netdev+bounces-297558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0pSQGBMvKWpbSAMAu9opvQ
	(envelope-from <netdev+bounces-297558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:32:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC99A667DDC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:32:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aDIU+FUs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297558-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 683E53062C2D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9AD3B9D99;
	Wed, 10 Jun 2026 09:13:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F310F0
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:13:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082827; cv=none; b=TFzCQxollvGnG+5Lj8eTm6XxrvDgzyd6qNXvh9WojVBDsb4ERqHsnbTsPotMit6F36Od0g63gBAmRq3Y3hYYfVxkbLYONxj2c0ZfynvLaRNpoAbsu5bDJMMk8m6JHFM/n/+97L0ABFyjB+pBfKNm6vjB1iC/6SlQbLyk9tYClCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082827; c=relaxed/simple;
	bh=W463cXGnAz82EOi9NNWV1+60CJES5ZJg/EZH0EXdgIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dsNA9cmnCMhfeW9pVNHhErG7LyIfZHtCA3IEs4pLwqnxYdFVJ5XFLPhK5fjYVwIMBKpnxiggI8p5hD0xNom8JLW4QLd+/s362B3Y9gEavAyuznjCOdcIEauEXYQ8mDviVNGa2jRmrHcarePm73oHKA/bWPLJ6Mf+jeZJR26/Md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDIU+FUs; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c132ac5ec2so64473965ad.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082826; x=1781687626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIQzRtgrJxYlcRBc/QwiLdrLM17LYdrQBecKZn+GnnI=;
        b=aDIU+FUsWL8XxMy7M1xDdbgHGvuKDjHNng75+uwsr55Icx0PckCTuP0fWP07UTJiPb
         vrxL0uh8Xa3amThiHeQINpHcQ57e3rFK4qP16VQHSBms1WKtzCTmwxrRRfssG2oF2GUY
         kUsuCs6+XnW9qDuZvVOKKKRz48QrgpqIgOxmx3adI55MelSQmJHO8lqKf5ipPv5caWEo
         If5mkRJoy0oIc4qP/xqc1d8kK2f/crZZ+JrFX7mb1hEx/9PbH0o9fD81GzkZPKRiG3js
         3EdFmrpqb2GrR08TOuSX45TcQxEJ9qVkLkvhUWAIG7gKIdmwqQI7DJ9PpGAn8vZIFACH
         nSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082826; x=1781687626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIQzRtgrJxYlcRBc/QwiLdrLM17LYdrQBecKZn+GnnI=;
        b=aMyRZYsrOVehIeVHcRJfnE08iggvLxyWNGv5NGcKLBxlNfEvsUK9s4FGiiwJz6IVo+
         x8e+1/sM7v2tq3uKXaKd7GKbh5WWrdllKrYn+YYG9ecEK6ZnTZsROsf7LRtSFPnUfAjS
         7EF8HR1ApoPawZZw0DoE3coHjUc2VKaUICicgYv/yA8d+8Md913EDaXZk6qdIZPiVjHE
         Gmlmgx+iWqjNyy9+ZUOxdaVtA4pKdupeVO8rvWQ0y9k5AA0NrBLUHhKGJiXdiUSufV+r
         Oavob5fJZ+tMFKdFoRs4Nk2ElAvvYuPadA9ldLOs6HxYwl6Pdm4BxfoEkeZVSNtpadq5
         +usw==
X-Gm-Message-State: AOJu0YyTovxSm1DkAyUbOdcm/f3Kl+LTeDDfcZ74cEIoCRST/DBi5GMB
	/dcg9JsqRBAAOIDYB/tuRvwq12SiF1B+iwWNsS5bRsvtG4yd48qPA77gh2Br9aUW3g==
X-Gm-Gg: Acq92OEeS1d3PrKTzhq3vtLTTPr6qOqfCIxquzmNozh53unM/C2Cgv46aYqOLnozli5
	LA2ORmDjgYNSr5OvGIUso7UHBcjKu0CMUwh4rbmCwgIoSVtj7uZ1ponwp4k3eZmvrEUlyGAeM6y
	HlGVSbZYo4I78XTUFi0n5inOLyobAJChOU59vTgMRCkirhnzpjhtAidu294XW0skyM1YGhVwRfJ
	TNecz0AG/3YzcNsG5cRaUN1YpobcE8ylyLyAlH/5hXOFAKCDFePcLAGdqR/rnVTE9l/gAIXKUtp
	wEZ3R9p0Uyl4k2kYSjJ+/2ef/bdkrNMZXenQeboBnxWuPtqidStyClaARQ0aWnIlx5qsJcfaLCn
	X1imMAtkXG83BTZKkVmY255lYsFA2uUHzuljLMsYCQe6eNx4QhCXWvRrAyQJZH+75UyKRmPyr00
	Z7ANYbDlcAoX8r7cd1Zv1Tizc75n4p61i1WGiRs0oWOXxAod1OZnFi2n6EOt7z1K/liYcl4J0uQ
	enRw3McYs0vmWMQ
X-Received: by 2002:a17:903:248:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2c1e7b35a28mr281851875ad.1.1781082826002;
        Wed, 10 Jun 2026 02:13:46 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm242991765ad.44.2026.06.10.02.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 02:13:45 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	Raf Dickson <rafdog35@gmail.com>
Subject: [PATCH net-next 0/2] vsock: fold acceptq accounting into core helpers
Date: Wed, 10 Jun 2026 09:11:19 +0000
Message-ID: <20260610091121.213324-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,broadcom.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297558-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:rafdog35@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC99A667DDC

These two patches follow up on commit c05fa14db43e
("vsock/vmci: fix sk_ack_backlog leak on failed handshake")
by folding sk_acceptq_added() and sk_acceptq_removed() into
vsock_enqueue_accept() and vsock_remove_pending() respectively,
as suggested by Paolo Abeni and Stefano Garzarella.

This makes the accounting automatic and prevents future callers
from forgetting it.

Raf Dickson (2):
  vsock: fold sk_acceptq_added() into vsock_enqueue_accept()
  vsock: fold sk_acceptq_removed() into vsock_remove_pending()

 net/vmw_vsock/af_vsock.c                | 4 ++--
 net/vmw_vsock/hyperv_transport.c        | 1 -
 net/vmw_vsock/virtio_transport_common.c | 1 -
 net/vmw_vsock/vmci_transport.c          | 6 +-----
 4 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.54.0


