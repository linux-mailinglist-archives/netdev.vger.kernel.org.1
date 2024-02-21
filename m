Return-Path: <netdev+bounces-73660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF0985D75B
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB4B1F22C74
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2121C47A62;
	Wed, 21 Feb 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kjq+PvWd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F747A6C
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516064; cv=none; b=BEkwlZewT/pLXBpb+iDEp21xX+4CcJ869dV6uUrcabzkZHlxwxEP7K6y5scKCfj81gMDdDCUOwJm0ZGn1CD0YMbHklYaxqWdS4jTdeq0CQSKIpie9Y3Eeqt2zuNgIlQ6VCrv7+SXKg1Klhh+V9yh26UbPNuYzxB/nZ80yJ1Mcl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516064; c=relaxed/simple;
	bh=H1opzQmLRRKn1Vlye2CjzNT5GlCrigionNIZr2eecsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZf4DvMmiItrhGMhhStJFAIoRfp62rDvsWOqe+s2St7EU0C6a5iBeibM0oIhv9GMWMzLzpm2bNnNLc73MBDOXAk6kVZOFcju010UUBZT1SSmMl0ObF9Ace+UQ6EONegkNO+AgBNnQIlv833NNDmXQ7PaKLZXstSUfAWzO2YfgKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kjq+PvWd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708516051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vde4xB/Zz/mmmOpaSceLQiqhYFS5iO9FC1cBFRBuQi8=;
	b=Kjq+PvWdHxGdR2IiD+vgjbMVYkO8GP5ykusWJPftsoY21Dom/TKq9d8lb9Zb665qbC1Pij
	sdgrb1RtPl0jrxJerbal3LLJRYtWkIP8P8QScpwvoHpQ9xjy4gAtAvKPRtxbfbaPYYs5bG
	/em5LKKP/FQ/0t3QnveNleyRhneHSQY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-Qm-29FoOP_uxIItQjYGr5g-1; Wed, 21 Feb 2024 06:47:24 -0500
X-MC-Unique: Qm-29FoOP_uxIItQjYGr5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C24C800074;
	Wed, 21 Feb 2024 11:47:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 51DAEC04254;
	Wed, 21 Feb 2024 11:47:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] mptcp: fix another deadlock issue
Date: Wed, 21 Feb 2024 12:46:57 +0100
Message-ID: <cover.1708515908.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Eric reported and diagnosed another possible deadlock problem with
the MPTCP diag code. The first patch address the issue, and the second
adds self-test coverage for the relevant codepath, to get lockdep help
to catch future similar issues.

Paolo Abeni (2):
  mptcp: fix possible deadlock in subflow diag
  selftests: mptcp: explicitly trigger the listener diag code-path

 net/mptcp/diag.c                          |  3 +++
 tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.43.0


