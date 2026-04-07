Return-Path: <netdev+bounces-275919-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENGJHJvL1GmtxgcAu9opvQ
	(envelope-from <netdev+bounces-275919-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:17:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F923ABD39
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 183F9305930C
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B693A6B73;
	Tue,  7 Apr 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6MUXma3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYxOQrie"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE739B979
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553250; cv=none; b=AI6Sck4t8RCpQT2icuYby5V+Cmh/yAybfD9q47QOoyP+B692NgFOreRyMIjzOcqPmeSRjpOGR0W68TIc5B3hMDJthihuZBh4tpN8SjzfTUMa5jiAvo9wIb6vUAROryNch6o7bYcGajepGJoOqkg9RZtDKjlmGHJkOOkMwLnxBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553250; c=relaxed/simple;
	bh=WrKcD5DGESE+UFTxVGGlNaua3CHVe5XplrOEYz1KMWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S8plEtf/vfesQkCHdl5QVK+PyGj49AxPRRYO3nq9fOibeu/bDUipJA2iBKmnF7EsFBNKVZBLFWpwnxANak3K1Bl6bsEavmFVAmElvYBs3y34ciNNCxwewjEbd8JWLy+zgF2E7OhpjyKHpx0nyJRC6kPPtgtBiqNa8v4OZItXaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6MUXma3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYxOQrie; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775553244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
	b=O6MUXma3dtz0hj0+liQquyyclOunb7m5Bc3fyO4WKXLdK6YcA4Y2GkqZ91I00WlaalTCKV
	g2pRtmKh2MhHK2/M611kvnitGnv/JwB3zDOxY/FaOP4UrrAvWq8ePHWK5HwMdtCyq+1mbJ
	97fiF3LhEUq8lv3vXEI8/Mtm/a1jm/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-ZZOJxy9jMTCuQ4iQbstZiA-1; Tue, 07 Apr 2026 05:14:03 -0400
X-MC-Unique: ZZOJxy9jMTCuQ4iQbstZiA-1
X-Mimecast-MFC-AGG-ID: ZZOJxy9jMTCuQ4iQbstZiA_1775553242
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1bfbd219so3780437f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775553242; x=1776158042; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
        b=RYxOQrieZg7yiRz++0cwRPPavRy498vitmpcpW5U7sjHmeKeOuCpGp0q6ZncJK7FWg
         IIX/QtRzSEzoSIhbbDR3je1xfD1afDvrsqC6AZEKiwyHg8d9/AjfEe5trNfRsn/24Z6+
         jw7gJiIHmS2PGNWFCG8A9Mi1Ugz7s70XxGwi8CJKzuOqwxi4opjJYEwt6XyCOzpNgqqU
         0pcivo8BegBdvlVWSiPB+yOeoJPwZw4sw89N6hzN0Klec0C7my0UWCYoGR1sX2y83top
         U0C7dObm4pnL18IYYZ8rJNegq8PZ6P2Jr9hFGWyQUbzfJL7V5U5SMfOvK9nNUd2988ur
         O7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775553242; x=1776158042;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkyC2WPd3q09yVYMuwvcFXlfB6s2u063IAioO/76CZw=;
        b=NJVc8UuXvus04hw/tUqEc6AvecDsrzTOvy5lvc9Fpbaxw9FM/arDFegGeqPE19om70
         Dh7jItEje58fgy/OVAYouRoejTS2thK221sRD7RrwNZ+ihD8awsgySk8+Qio2gQRLoQB
         /kHFbAm8ssW3hpk8b6MyxqKj/tF+CyyJkK/92AAURVtCTjUVnjV+SOhVYS7TH54GeZ2g
         7u1GgWrwLaLBswZSCqLHo9Z8WvR2PjRhuiXckqa6saF5EqrOJktYATmE6YZyzTeSXeav
         4bsBM9uxVAYTLSm0xmG+5gcizyAwZlyJi1QBHE12pMf7+aKm8Gtig0+mlUH5MGsUgDfb
         9BFg==
X-Forwarded-Encrypted: i=1; AJvYcCV0udRMLi2dK8tzAdjiOyL6jJ5AOpgDnVmTJ6Y4WiYmwe8bs/YmMrCxaJdj1yBS/vmc1c+pjmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXd/lQv8gZU9dIZDNH+OW4aMcHLO0BhAAH5FVs37fRT3mXdRV
	1kqWSfXD0iK9tpK08Sq7GgPfGZtoT9oDAYqA/s/Z491gN3PDUuGbTo7JsoUcLWazsCIdMxO2lk4
	hmHdT+k0WL11KQnV+O7qOC7lOjHhCx5Ken6RU74KF/1W+1NSiXu8Jqe8N9or8cCTwXjL04tT208
	IHRT5S/+bPwswrV8ZUmwBoM+0qFwEf4GB3JKaZobgjzsXt
X-Gm-Gg: AeBDies/3gCl3cODW95EAxaM/15WsRzAi7RzxQgiA4/aG7pHkYnmu+0X5xQaLuoN02F
	L+n1uPei1TSpT/TT62kTVrgkCRFeSVwbZlS8gQAZNO/g+kmqEbieiCtYLHc+kRtsjWrRqHp5HmZ
	l8SuV19Tcak+QO3wi6V5AqnxDJYkKPidfk8VjX4/1m+tnVxDjR/56wiawhlxg7gWb8oQn2ZRDFr
	YZm2Y67hNgDS+bN/PKWM09hAgD9eFAiUwsXIfv32sIKx2gQLUz88xQjwni81kxGFRttXBIBAAZx
	VkcF1PY6TZx/TdUOVQCLYIkT1Y5FIJEyDX/CkVoUsIt41IbwUYkd50WtJ7kW+oEsbuSPCXiVe8s
	H6zhEei3pjKAd2tfDcu17j8cJ8yDAPPrJonb3D5rPjB7NYibiSwL54vxFqT+6
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr218429195e9.13.1775553241735;
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3544:b0:486:fd5c:2b35 with SMTP id 5b1f17b1804b1-48899735bb2mr218428565e9.13.1775553241110;
        Tue, 07 Apr 2026 02:14:01 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48895e19c10sm342892015e9.8.2026.04.07.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 02:14:00 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v2 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Tue, 07 Apr 2026 11:13:54 +0200
Message-Id: <20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0WMywrDIBQFfyXcdS0+gqZd5T9KKEm8VinVoCItI
 f9ekUKXc+YwOySMDhNcux0iFpdc8BX4qYPVzv6BxOnKwCmXtKeMGPe+b4hPIgehlkH08oIC6n2
 LWF1L3cBjhqmO1qUc4qflC2vqV+L/UmGEkllz1ZsVjVLLGFHbOZ/X8ILpOI4vE0qtOKYAAAA=
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-275919-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9F923ABD39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_stream_do_peek`, when calculating the number of bytes to
copy, didn't consider the `offset`, caused by partial reads that happened
before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commits.

Commit 1 introduces the fix
Commit 2 introduces some preliminary work for adding a test
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- Addressed reviewers comment
    - Test now uses the recv_buf utils.
    - Removed unnecessary barrier
    - Checkpatch warnings.
- Added new commit that allows to use recv_buf with MSG_PEEK
- Picked up RoBs
- Link to v1: https://lore.kernel.org/r/20260402-fix_peek-v1-0-ad274fcef77b@redhat.com

---
Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: handle MSG_PEEK in `recv_buf`
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++-
 tools/testing/vsock/util.c              |  8 +++++
 tools/testing/vsock/vsock_test.c        | 56 ++++++++++++++++++++++++++-------
 3 files changed, 54 insertions(+), 15 deletions(-)
---
base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


