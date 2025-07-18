Return-Path: <netdev+bounces-208205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ECEB0A95C
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4FA1C81221
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945A0239591;
	Fri, 18 Jul 2025 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQCJdiiR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A11C7017
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859540; cv=none; b=onE/FEZBp7BKyX5lstyoSXgbaZ72hpPRxeC5/5mwnlFQSpI9M2Xc45mM4I+N19GhMQdSuqU4+UZ3Sw36EFSatsU/plE1urny7+rqB6kIipBpJ9JRV+ZUZU71iKP0FiNSI39IpLBMJksgsiHZAWcGsYZJf5pS6V3d9ZxCVNnF6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859540; c=relaxed/simple;
	bh=g9aunl7TugelcW9oQZquiGh6UJyfoAj/1Si7c+GEe6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRuChNvXF+VsU2TBbBJBBKhU3d0A77kSyIkN/fRY9ziAF+qLdvnWWLFrbGRaMKyKTx/fOny3A7jI3hGzX5lu1pJVo4R3BT5X5xhoLKMGPXYxxVyDXdSHzFZLnWbSItUUjsLTRL6h9U36Ep70XWgP7NktvpmtPrRyX54xuaK4b3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQCJdiiR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752859537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=umVCgirYX8eNqzl/YYdn1aUmNWGRyD5/nlAzTeLXnQk=;
	b=HQCJdiiR89Qc+p/wvkh6VxxfWyQIITEMNUod08IsPWvzoYp1wjPGGo4DStAJxOFluuNVoC
	0lbEehLPpQKvoCtRRv05hw36tRJ1zzPwH3gJoxPV6namDTtDg3n9C+7D8UViTB3/IJrLWM
	KF46fs0IVOj0LoDdheP0+6yDR8YJggI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-MgP6E5xTOPGp6Kylapa62Q-1; Fri,
 18 Jul 2025 13:25:32 -0400
X-MC-Unique: MgP6E5xTOPGp6Kylapa62Q-1
X-Mimecast-MFC-AGG-ID: MgP6E5xTOPGp6Kylapa62Q_1752859530
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8769F18004A7;
	Fri, 18 Jul 2025 17:25:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72404180035E;
	Fri, 18 Jul 2025 17:25:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH net-next 0/2] tcp: a couple of fixes
Date: Fri, 18 Jul 2025 19:25:11 +0200
Message-ID: <cover.1752859383.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series includes a couple of follow-up for the recent tcp receiver
changes, addressing issues outlined by the nipa CI and the mptcp
self-tests.

Note that despite the affected self-tests where MPTCP ones, the issues
are really in the TCP code, see patch 1 for the details.

Paolo Abeni (2):
  tcp: do not set a zero size receive buffer
  tcp: do not increment BeyondWindow MIB for old seq

 net/ipv4/tcp_input.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

-- 
2.50.0


