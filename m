Return-Path: <netdev+bounces-226359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFEB9F705
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEFB3B58CB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6844212548;
	Thu, 25 Sep 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJcTKW8H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA011FAC34
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805823; cv=none; b=cIRxzzsGjn1n9NjzAsVg+USdeTV8Wvzkx+WBxCPt0vzCi8w7gzopBcZXAKmg9yPDBm+fQ+5URbOw93DgQUpVbWqV+MOPGpar+u6bD4paoKv0tNwS9TLNt7tcDsvVQgFjQc0b6/GVPRKKoHhpzcTRpAhOelSy1yffo/DH4RsT5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805823; c=relaxed/simple;
	bh=0B43x3hO60s/q7zuJq3RHOjXfJvIsP5KZNO4MN7Tppc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NQZKOvJfN0cFQIPWgd3/9DD4TOT+87KPtIqXKUfrKmYbn488r7fKMY6GE/frwjPiBoXreYVoLYq1EC1vA/raplSmoMEahFfy3goPKFD0F9slgf/sAbwfSoB+p6DZjnYBT/PbU4aI26hvycRhFnkesTC6D70ym0VdQcHFrcnjWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJcTKW8H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758805821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
	b=dJcTKW8H9rH09DHUJqXo+C8BlH0wNXeAmoWYliHaKW9scwcg0QskEZIkdEu/lj3gjTb4GO
	G6EejAqKwQwCqDEz4TFA53CaWYJ7KZl/sK5uB8Q0Zq83WJcr4ObLccM0Nl0nPUa1U1hwcB
	1OXJ/vPfTcjLzeJ5bK2pjyLsi30c8RQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-yRPlMO4fPx2SU4_FAyPC5Q-1; Thu, 25 Sep 2025 09:10:17 -0400
X-MC-Unique: yRPlMO4fPx2SU4_FAyPC5Q-1
X-Mimecast-MFC-AGG-ID: yRPlMO4fPx2SU4_FAyPC5Q_1758805816
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so632741f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805816; x=1759410616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
        b=fi1AQ/LfiUTmaV7pKBm2EbhvDnhnCMR+/VcY5qUT/m0QeDB86PdzgmdTc4rSE/iqN3
         KyvnSrEbzmZH9rT8wEkfUezSw64DB60YFQ4Lscf333xGGE1Q9iBG1rohbZQKBVZXEk/+
         EBhd858fXxd1HQU365nuJnxo4lIKKrNpXcSQMiYGHELsM3ic7zBdqtaX0h+VxsnrsMQE
         I9B7OHYyvFskrYHaIG9VhTKNxT7gNrCzi4/OlvTw1SEwH8Ormj7L7fnSGgzsrfPc/oTm
         QXBQTv4D504lYvnQUsjpnB4TmxdhD+T6KWSn4si8VssYGWbGCsdCMirmrjjzzJCwxyX8
         2TlA==
X-Forwarded-Encrypted: i=1; AJvYcCVREP9V0FgerXjBucBUD0HslKU0NrisBRujqCQLykhOhIK1GJxJwOtpEZxeOfAkPWVF8U1y8jM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/OAZlwydUzBqMaDU/GJcM1KCJkRgJmMPqwRxDWnxPegPwixQ
	3JFMOcZQXdiX+rX361BkjttSNoKbkrjrLzWKKDIbYNnlyuC48Zin4GlQK/O5TRCbi41QYExr1j7
	FJY3T4CQdBNbtnyNWwN6Vq5xsXuoZwbPXAdMl3S5K3pBHiAO9nLlPXuiS7Q==
X-Gm-Gg: ASbGncv1Kiy2TO1WOsLC5xEAwPdsaAZdKAqZjauLMXA+apZZ2i9Tw/dEm6KxO2JFfMv
	XV5ZCZ130256KZNve6AUTB5KCD/FOvM4FvrJ6opCQtF6I/23r9zW4yW1bhv63tVxTIwFUf7qFBX
	QFKyzSEo5rNftpBbLlG4QRnqkcebXydBT0rVfRqro7OXCiUjX1f1Tp7vHrUyhoBpyOY/8zbsMR3
	4vO4+MXMjuzmia72nHXZPA+jsdEeDYttjS6g7emu6cuYNkqyW8vcM3ZzIxP3Dpj+MWndqqN16Ge
	Ap3i+esmTV0KV5qhpNHPegNAQyKi8bJ45Q==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216279f8f.49.1758805816377;
        Thu, 25 Sep 2025 06:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzU/fT07/taXxNhpSlgViOVy92VqAS1NyA0bx0hGfqPg/L3VBSKrQfSmeVvB7FScm07URuig==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216242f8f.49.1758805815830;
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm3112468f8f.13.2025.09.25.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:10:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, bigeasy@linutronix.de,
	hi@alyssa.is, jasowang@redhat.com, jon@nutanix.com, mst@redhat.com,
	peter.hilber@oss.qualcomm.com, seanjc@google.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250925091012-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

I have a couple more fixes I'm testing but the issues have
been with us for a long time, and they come from
code review not from the field IIUC so no rush I think.

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cde7e7c3f8745a61458cea61aa28f37c3f5ae2b4:

  MAINTAINERS, mailmap: Update address for Peter Hilber (2025-09-21 17:44:20 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this fixes crashes and hangs in
vhost-net.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Jason Wang (2):
      vhost-net: unbreak busy polling
      vhost-net: flush batched before enabling notifications

Michael S. Tsirkin (1):
      Revert "vhost/net: Defer TX queue re-enable until after sendmsg"

Peter Hilber (1):
      MAINTAINERS, mailmap: Update address for Peter Hilber

Sebastian Andrzej Siewior (1):
      vhost: Take a reference on the task in struct vhost_task.

 .mailmap                      |  1 +
 MAINTAINERS                   |  2 +-
 drivers/vhost/net.c           | 40 +++++++++++++++++-----------------------
 drivers/vhost/scsi.c          |  2 +-
 include/linux/virtio_config.h | 11 ++++++-----
 include/uapi/linux/vduse.h    |  2 +-
 kernel/vhost_task.c           |  3 ++-
 7 files changed, 29 insertions(+), 32 deletions(-)


