Return-Path: <netdev+bounces-130578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF0998ADDB
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D4C1C21D47
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EFF199951;
	Mon, 30 Sep 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCyFHdZG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED71A0BFB
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727228; cv=none; b=ZKaYmT4ixF1A7AqjPZaaGg11UA1/DXM8whwiZ6VV08iE3nSlbgraAGNhhSVXp+I8DKOGSLJ++Mxpj/gZrAAcTyIruFW+AQHt5EolVDaUp5owz8j10ouhW9ES9kkLPaKmoqaKZPjkOXzAwhlH5Wkac7uzNJzIpRXY/+9MJVZRE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727228; c=relaxed/simple;
	bh=XQ71XnM5RENP1ZeK3uEijRqSKcCIm14ZzuO6RwVvoA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVGF7pe9nV3hKKZGNoY1P9ui/d1VJDVUN75LI990ok3hWM+qscqVd7K2x53cnKTFDyjBu+i/Ctn/9OPQ46QrzvI5gVV/ZBZLzjjf4Xn3edKMopM302tGcRoRAxD4Gryj2Q27cgsd9RzDkiq1CJtHYc0nNLwRJbawq9whd1+RWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCyFHdZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727727225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aaUDeqsjhVwNR0DztDYhNSLJtJvLC/H3mGOW8DMWbCE=;
	b=XCyFHdZGsVBZpT1E23DDVyJw6quFr055YHjVcJEX3WWGZDXBsWC5PJu1kia/dAwZV2V/8g
	4l+k0cU0ac7cNe0TFy1P86S0AuShQse5oqKn0lJCgKOLsF4Ho8nf3WpqYpwxWRUUbQY8vH
	CQK4tU04/OcZfD6mPWgVRhr1HWv1Mqc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-twh71N5PM2eVM2t9dXSiXw-1; Mon,
 30 Sep 2024 16:13:44 -0400
X-MC-Unique: twh71N5PM2eVM2t9dXSiXw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47353196A133;
	Mon, 30 Sep 2024 20:13:43 +0000 (UTC)
Received: from rhel-developer-toolbox-latest.redhat.com (unknown [10.45.224.53])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E87B419560AA;
	Mon, 30 Sep 2024 20:13:39 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Manish Chopra <manishc@marvell.com>,
	netdev@vger.kernel.org
Cc: Caleb Sander <csander@purestorage.com>,
	Alok Prasad <palok@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/4] qed: put cond_resched() in qed_dmae_operation_wait()
Date: Mon, 30 Sep 2024 22:13:07 +0200
Message-ID: <20240930201307.330692-5-mschmidt@redhat.com>
In-Reply-To: <20240930201307.330692-1-mschmidt@redhat.com>
References: <20240930201307.330692-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

It is OK to sleep in qed_dmae_operation_wait, because it is called only
in process context, while holding p_hwfn->dmae_info.mutex from one of
the qed_dmae_{host,grc}2{host,grc} functions.
The udelay(DMAE_MIN_WAIT_TIME=2) in the function is too short to replace
with usleep_range, but at least it's a suitable point for checking if we
should give up the CPU with cond_resched().

This lowers the latency caused by 'ethtool -d' from 10 ms to less than
2 ms on my test system with voluntary preemption.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/qlogic/qed/qed_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.c b/drivers/net/ethernet/qlogic/qed/qed_hw.c
index 6263f847b6b9..9e5f0dbc8a07 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hw.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_hw.c
@@ -596,6 +596,7 @@ static int qed_dmae_operation_wait(struct qed_hwfn *p_hwfn)
 	barrier();
 	while (*p_hwfn->dmae_info.p_completion_word != DMAE_COMPLETION_VAL) {
 		udelay(DMAE_MIN_WAIT_TIME);
+		cond_resched();
 		if (++wait_cnt > wait_cnt_limit) {
 			DP_NOTICE(p_hwfn->cdev,
 				  "Timed-out waiting for operation to complete. Completion word is 0x%08x expected 0x%08x.\n",
-- 
2.46.2


