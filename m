Return-Path: <netdev+bounces-304081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uXE4Aw04RmoWMAsAu9opvQ
	(envelope-from <netdev+bounces-304081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 696216F59FB
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:06:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=aLjcRPU4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304081-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304081-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3626E30237C0
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645FD4C957B;
	Thu,  2 Jul 2026 09:43:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B03480DF7
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:43:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985419; cv=none; b=VVFEa8fUYp44nyL2wUh6NYLckyd01ZHIb5vB6dNvUrSaAIs+jdOatrzkTHKk7GenrnDMn79eyF/NdSjjxsoPuUFpqKn85gfxf2Srszf1+pkb14Y/GB7A+Ha68rrhzckE8bkDF8TowlRRvsREeRzyEu0dI+GCCKwojZ5QYARi5kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985419; c=relaxed/simple;
	bh=sE1MMwuei0bnoPr9OlUojbQFY55tHp1vHZni08PhMw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GkJaKyhH0ZFBpnTBOJuBaNZzNUrV9LByRxTedAc+MsOg3dK/0V2ivoROwjNe0Anpl/5/XgYj62F+1AUmEES6JE+SH5kKJLXjDsBXmr6l9Tgxp3fz7884UzGzwTNw6rUKMeDUGyH9rMsHFMrLaxKdYOTyc1c1UYQEip/f0ENy51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLjcRPU4; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782985417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2sGg4OBS6CN7124EJJITMq2eEDKkf+5K6FHNSHoUPw=;
	b=aLjcRPU484DSsIPPu4Nh3qFxn7pa78mWA+ORylAEUPAmF5MOotm5fEP/jQCywfmLNa8Zxs
	nKnGHGTQaWZAHBPy23ny5bwsdOabOoZMWRjwOmM9IrlSIIDuTRY0Ey7Tx0gbq2AJR6BDP8
	Ni4cJFGJSfJYGfAyk2dtd3Qkh77tROM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-K8alePmjMR-EvfqRDx9BhA-1; Thu,
 02 Jul 2026 05:43:31 -0400
X-MC-Unique: K8alePmjMR-EvfqRDx9BhA-1
X-Mimecast-MFC-AGG-ID: K8alePmjMR-EvfqRDx9BhA_1782985409
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C189E1945CAC;
	Thu,  2 Jul 2026 09:43:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 98BC018007F3;
	Thu,  2 Jul 2026 09:43:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 net-next 10/10] net/nebula-matrix: add common dev start/stop operation
Date: Thu,  2 Jul 2026 11:43:19 +0200
Message-ID: <20260702094319.111426-1-pabeni@redhat.com>
In-Reply-To: <20260630010718.4346-11-illusion.wang@nebula-matrix.com>
References: <20260630010718.4346-11-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-304081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:illusion.wang@nebula-matrix.com,m:dimon.zhao@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 696216F59FB

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net/nebula-matrix: add common dev start/stop operation

This patch wires up nbl_dev_start() and nbl_dev_stop() to configure
the MSI-X map, allocate vectors, and request/enable the mailbox IRQ.
It also adds a workqueue in nbl_dev_init() for the new IRQ handler.

(Note: Due to recitation restrictions, the standard inline diff quoting format
has been replaced with a free-form summary of the findings below.)

[Severity: High]
In drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c, looking at
nbl_dev_configure_msix_map(), the loop that calculates msix_not_net_num
explicitly starts at NBL_MSIX_MAILBOX_TYPE.

Does this calculation omit NBL_MSIX_VIRTIO_TYPE entirely?

If the virtio type is skipped, will the hardware map table lack sufficient
entries, potentially leading to memory corruption or an inability to map
VIRTIO interrupts since disp_ops->configure_msix_map() is called with an
undersized sum?

[Severity: High]
This is a pre-existing issue, but it is exposed by wiring up the new dynamic
start and stop paths in this patch.

In drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c, looking at
nbl_res_intr_destroy_msix_map(), it sets msix_map_table->base_addr and the
interrupts pointers to NULL, but does not appear to free the device-managed
allocations created by dmam_alloc_coherent() and devm_kcalloc().

When nbl_dev_start() subsequently calls nbl_res_intr_configure_msix_map(),
it will allocate entirely new buffers because the old pointers were lost.
Could this introduce a persistent memory and DMA space leak on every
start/stop cycle, such as when bringing the network interface up and down?
-- 
This is an AI-generated review.


