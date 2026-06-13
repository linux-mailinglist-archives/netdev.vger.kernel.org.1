Return-Path: <netdev+bounces-298830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +/CVJvCgLGohUAQAu9opvQ
	(envelope-from <netdev+bounces-298830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:14:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1834B67D363
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:14:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=K2QTy7U0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298830-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298830-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 747FF300B465
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8D62AD10;
	Sat, 13 Jun 2026 00:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233D6FC3
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:10:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309416; cv=none; b=HbwxpD8PerNlC5cQNE+PpO3Bsh+/2uViCO97VHVAQ5MXMGsaDBKBZ3atC+l+Sh/dqGl+rNxEVFG1Gh5CgFUImdW0Va00B3ya1KoggL0Ljz1hSCzKyo1simhAycCVcm7QInvbZlCA+/46qThk+97mE14xrT7YUihaTAIqQZw00DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309416; c=relaxed/simple;
	bh=2xA7UwrmgSAiT4AAGXdHKe3DLcEVpuJqqL8PXChttXs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GbiU5yAwUMn1y/4cNL7Mg0lwnzQHB+rbYfYhq/Bij9PMNRYDsswh8XcKp8sbh8+nQ9spVtWRvCwjcVU1b39RM2evLpB0G3DdJRd2FXmiTOgMPSnnVBxB918vR5PqRZCUqQZppgpQsbcAEYNN/bFqzFKRwgPql2hI0zrg/u85Aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2QTy7U0; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso2070106a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309415; x=1781914215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDW2+QBWaKIKD14o7O9QPMJy941RQm/F5fPpz4Pl5f4=;
        b=K2QTy7U0UNtGpShyhPW/DSl2Jnr2jPUsBYNE3lDTQRn4/cBKqmOYEzQ64jETguc81n
         LpgQPveIxPH1fPc5dLI3Hdur5dMoh94qmh0yff23cPFuBFCatjuIo+tNRYUjLVVCliih
         Gy6gphYzUYL+cGrhX25sNJ7O9ieJxsgJVjb97w8mSgzy2dNhsFwoc+cFdy97Z0SeajJK
         cxarM4btSww0TenEoJBh64ikccRefL1c/xj8lZSqiDvXqaqexCyfBqaiO+Wxk5pYypDv
         JKPpbC4ckNoRO5VBnsHYjiQNkVN/jNPFK4S01mjDQuCSCBWa+U/Q6CHuXcSWuCt0W55G
         nWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309415; x=1781914215;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDW2+QBWaKIKD14o7O9QPMJy941RQm/F5fPpz4Pl5f4=;
        b=UUjzWn7kVV7t7BIM4SLjn6hVV2WqSvorg/0JbOUZfWfm27bcEYFcnJ7qNphFU+d/n/
         iyAN86LI1azNvOmQNy5bdp2cKhJVZ+W+AGGbefz6xuT1a9yZhynKxjGDKBp/cwk3g7Ts
         MqpevMoWYRLnwVXlFJyD4ldPxlQji6Kh78narvruTLFktDM4AwxZbZFPfXyo6+JScyd9
         fGDp8uvd7DCSLEQIN+8K5PZ3KU6rQaxjyC66eWSntOVicKzo0PhZnSDes1r7CtTcBnwn
         R3zmCKm2hXwcpMMAz5YyD8e+fbBivzyd77irhdzrif5W7/tGkwUVbx1UJqvmkGwyybU9
         jpiQ==
X-Gm-Message-State: AOJu0YzaiajhQESkyST+j/nAPraZqwSuEnAgzjDjJWH4FjBriDWH0Tja
	Te5il/c9fDUO4/Z7tHeLf5hfeoHTL0S+Xct1lpCDunuNjUMFLkP3oe2ePF5/fZCrrUnqzg7Sm5m
	61eU9XqtrgXLS87U4pAaGS3x/zpPDOkQxzZP3ab4ZtzXAk6ZBdkQFLMHx7E1gY8Df8pGpzLIo49
	q3Q/MSq2J/thegKrUJI2tBAcbOGUF4vcw=
X-Received: from pjbco19.prod.google.com ([2002:a17:90a:fe93:b0:36b:7407:9b73])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:580c:b0:35b:8d89:719b
 with SMTP id 98e67ed59e1d1-37c2bc6f158mr1545724a91.1.1781309414535; Fri, 12
 Jun 2026 17:10:14 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000953.467473-1-tavip@google.com>
Subject: [PATCH net v2 0/2] vsock/virtio: fix msg_iter desync on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:akpm@linux-foundation.org,m:avkrasnov@salutedevices.com,m:davem@davemloft.net,m:edumazet@google.com,m:eperezma@redhat.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:kvm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mst@redhat.com,m:pabeni@redhat.com,m:horms@kernel.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:tavip@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tavip@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298830-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tavip@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1834B67D363

This series fixes a msg_iter desync issue in the virtio vsock transport
that can lead to warnings and eventual -ENOMEM under specific failure
scenarios (e.g. partial GUP failure during MSG_ZEROCOPY transmission).

To fix this, we need to restore the msg_iter state on transmission failure.
However, since virtio vsock transport can be built as a module, we first
need to export iov_iter_restore.

Patch 1 exports iov_iter_restore.
Patch 2 implements the msg_iter restoration in virtio vsock.

Changes in v2:
- Use iov_iter_savestate()/iov_iter_restore() (Stefano)
- Use a single restore point (Stefano)
- Reverse xmas tree (Stefano)
- Added comments in the code (Stefano)

v1: https://lore.kernel.org/all/20260609004809.1285028-1-tavip@google.com/

Octavian Purdila (2):
  iov_iter: export iov_iter_restore
  vsock/virtio: restore msg_iter on transmission failure

 lib/iov_iter.c                          |  1 +
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.54.0.1136.gdb2ca164c4-goog


