Return-Path: <netdev+bounces-143261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA19C1BC4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 12:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2386B254AB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECB61E32B6;
	Fri,  8 Nov 2024 10:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnjVRB2i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6D1E3793
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063537; cv=none; b=coiZ+tpCf8gea2YcMCu+4d7TKKghbY3CKLICX1Gejzwlj9AcPhzLAxK0d2tIJUs4EuZOE4UOeF6+dr9059rSwYLKA1R4S5R7ELZcxyHRAzxqYXxRRPprZwzqsf7bkSyHclO8rCQEgsCmHcvS3hBmFr4exN1inPMXmn8UGL3QkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063537; c=relaxed/simple;
	bh=SVP1un2WHlgQFTMUVkMXQb1bpew074b55seoGhnpkwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUTTKA8W+NG6tfFVdbjnU1RzCVA9pimjsh7KQeX/N6GjgZ1A/mqq1p4MXHr2P56uCmbl6bRPRJMEjMMGQwhxToER29dA18HdNH3DpnCxu8qyIbsNROYzmHfTXR0Z705gyE2BOmMHaxs1z5hPOjMRgth4J1Uzn6eVerZ5TzEnjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnjVRB2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731063533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=trJgYqh2//IpO7XTeIhQvSS1UJXTy5+llm2zGMIXEOQ=;
	b=KnjVRB2ikPCSLB72QPyYKlydPz0sqWpjeClmWimUqxwRcaGDs9cyCZaj4/cNOnrCs9BTqE
	GjyGdCE6PnJu32W6ZDCfREL8Pf5TBm2YkEfOiIsl4+6Peb1MhueX3U16ikzYNfpjyd8V/r
	Q6WHCh+D0/5mpKHmUThebxWXgzUAlaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-fJzHsmBiOMOzOjfDbPrHaw-1; Fri,
 08 Nov 2024 05:58:50 -0500
X-MC-Unique: fJzHsmBiOMOzOjfDbPrHaw-1
X-Mimecast-MFC-AGG-ID: fJzHsmBiOMOzOjfDbPrHaw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 358641955F08;
	Fri,  8 Nov 2024 10:58:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.90])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EDD271956054;
	Fri,  8 Nov 2024 10:58:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH net 0/2] mptcp: fix a couple of races
Date: Fri,  8 Nov 2024 11:58:15 +0100
Message-ID: <cover.1731060874.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

The first patch addresses a division by zero issue reported by Eric,
the second one solves a similar issue found by code inspection while
investigating the former.

Paolo Abeni (2):
  mptcp: error out earlier on disconnect
  mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

 net/mptcp/protocol.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.45.2


