Return-Path: <netdev+bounces-237694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF64AC4F097
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A003C189AE8A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F676209F5A;
	Tue, 11 Nov 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFVXQoSD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9336B06B
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878612; cv=none; b=QVGla02lgSsYdjjZ1w9aer9WaPqQVoO7HVzABpd0xjtA2GWQKuSsDunE3L4lyJDdKIHoS/QQ2uGWKMySREXHcY+YHNUk6EC9pWja+9+UDGUFe2PPyxh3rf1cq68GkBPcBQ4xKv1Pv81WSJSs8lrOdc2qcRqMgdEoTuO63WBSuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878612; c=relaxed/simple;
	bh=0WNTeFejub6c1zInmTHVyDazTAWM72+9B5YWUZr7Vd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljJo8fSKOPXKKYQExlQlULvKbUAYyxGzy6mva5dJXu/JVBJ/amjhB33fy8i0L9f+2KZ4HyEzbJhdHYHcohaIZVMAwo4W0JtHn4fzA4DpAqqNnrC/4B8a+tTmD5PeyiFMEclkttkR45LDZyGAvF4cfK+FRHbBvhTz16NxPh9a++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFVXQoSD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762878608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ixaV9iYj1Sqo2pjJ13lYgm+JG4V4p4hjJTrNwFCCV0g=;
	b=OFVXQoSDBE7Lz0La0jOJitWQLNT5RHvAjL6m7gyyznBt8fVsOkpBGadpzHEILaaRbzahX2
	rnAZ4RcNiL2k27+qsoG8vL+CzZcliS+gN5gbb8lVbFCT0gqDMegg8ZTLpPMt5t4yKepQ5c
	YE1nko9Hg7YfdFt29r9i/MrNDiucZrA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-YAX_wG9CNYaMnxrgcrwVTw-1; Tue,
 11 Nov 2025 11:30:05 -0500
X-MC-Unique: YAX_wG9CNYaMnxrgcrwVTw-1
X-Mimecast-MFC-AGG-ID: YAX_wG9CNYaMnxrgcrwVTw_1762878598
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0B101800250;
	Tue, 11 Nov 2025 16:29:58 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B49D180035F;
	Tue, 11 Nov 2025 16:29:55 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: liuhangbin@gmail.com,
	m-karicheri2@ti.com,
	arvid.brodin@alten.se,
	bigeasy@linutronix.de
Subject: [PATCH net 0/2] hsr: Send correct HSRv0 supervision frames
Date: Tue, 11 Nov 2025 17:29:31 +0100
Message-ID: <cover.1762876095.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hangbin recently reported that the hsr selftests were failing and noted
that the entries in the node table were not merged, i.e., had
00:00:00:00:00:00 as MacAddressB forever [1].

This failure only occured with HSRv0 because it was not sending
supervision frames anymore. While debugging this I found that we were
not really following the HSRv0 standard for the supervision frames we
sent, so I additionally made a few changes to get closer to the standard
and restore a more correct behavior we had a while ago.

The selftests can still fail because they take a while and run into the
timeout. I did not include a change of the timeout because I have more
improvements to the selftests mostly ready that change the test duration
but are net-next material.

[1]: https://lore.kernel.org/netdev/aMONxDXkzBZZRfE5@fedora/

Felix Maurer (2):
  hsr: Fix supervision frame sending on HSRv0
  hsr: Follow standard for HSRv0 supervision frames

 net/hsr/hsr_device.c  |  5 ++++-
 net/hsr/hsr_forward.c | 22 +++++++++++++++-------
 2 files changed, 19 insertions(+), 8 deletions(-)

--
2.51.0


