Return-Path: <netdev+bounces-130574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039898ADD5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0403B21054
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3A1A0BCB;
	Mon, 30 Sep 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCDxmZaR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0221A0BD1
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727218; cv=none; b=Y7vBg7Qz4gEspffs/i04OnBuzQ6Ovp+Dt4tdlJoytISfHRwC3mL+qrU5L590euZetWeYR2YUeTHiwAkXjW0A9yePnJmm1NsCo6ij+1XaYpvSTkVG/2ZgqxbIwxsVRwgUSJziowkz7NbqiuyrXmDrriMNJYt8dQHDtNqOv3sQaP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727218; c=relaxed/simple;
	bh=9yDRc3wPCUrp0i76mtqpG8ZDoXOR6iaGx3MMC+lXl04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hfx7HkBAOYRiSdeHzGUZH9vHqVd9mtDoEDeec6NzU7EwsKyiuhbY+oJV/MDa4ovn32NHAZbu5skd/zfiXbUmRH9XAX98mQ3tzFlrF3v3Emj+QrQNdkuEp17JFexjCRIxEKClMwc4aWKmsT6p3ri71OF73ssRVhQr44e+kyDRAMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCDxmZaR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J1HYpi0EPkbDCrHqRKZ4Ui9sKzkVqwsiKn/4RHTZN9g=;
	b=PCDxmZaR4OtET6eXEhtVx8B+eNrp9dHCpMtzjgX4Bi2zBeWXEDnQJdCIRYGGydOcNhiMN/
	a6ysti+5oYYUN/Hj3XZBrdh2oSso2/ZxQck28hpUmouBBGs5UEQmnU0IghIpdnOfehl9lx
	OZ4hYq/ngVd5R4ayFh8WdS5IzumHVgk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-o0-TT3SbOj-Pf_lmTt16kQ-1; Mon,
 30 Sep 2024 16:13:30 -0400
X-MC-Unique: o0-TT3SbOj-Pf_lmTt16kQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C9C419626C0;
	Mon, 30 Sep 2024 20:13:28 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.45.224.53])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF72E19560AA;
	Mon, 30 Sep 2024 20:13:24 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Manish Chopra <manishc@marvell.com>,
	netdev@vger.kernel.org
Cc: Caleb Sander <csander@purestorage.com>,
	Alok Prasad <palok@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/4] qed: 'ethtool -d' faster, less latency
Date: Mon, 30 Sep 2024 22:13:03 +0200
Message-ID: <20240930201307.330692-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Here is a patch to make 'ethtool -d' on a qede network device a lot
faster and 3 patches to make it cause less latency for other tasks on
non-preemptible kernels.

Michal Schmidt (4):
  qed: make 'ethtool -d' 10 times faster
  qed: put cond_resched() in qed_grc_dump_ctx_data()
  qed: allow the callee of qed_mcp_nvm_read() to sleep
  qed: put cond_resched() in qed_dmae_operation_wait()

 drivers/net/ethernet/qlogic/qed/qed_debug.c |  1 +
 drivers/net/ethernet/qlogic/qed/qed_hw.c    |  1 +
 drivers/net/ethernet/qlogic/qed/qed_mcp.c   | 45 ++++++++-------------
 3 files changed, 18 insertions(+), 29 deletions(-)

-- 
2.46.2


