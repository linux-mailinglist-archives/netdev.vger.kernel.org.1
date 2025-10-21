Return-Path: <netdev+bounces-231395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2036BF8BE1
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A1EE3466F2
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845427E05E;
	Tue, 21 Oct 2025 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g9AGPSEk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E188AD5A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079231; cv=none; b=AunvzZhkFXu++ofAJlxGxMJRChwPx6lGm0gXvCLYlDSSOp9ujanYU7mhqM5QB6aTAudTiV7QC9hZCiyKwrsanmgoVk9wZFEQe2durdFCLZhOaZWo49DDVXunYFXOIHjYR8LMXFeuRe+NQU/pM0bjRo/up0SkcOrML6ru50PIcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079231; c=relaxed/simple;
	bh=L/9pGBo5ZGdt2qxWJX3hLCaGfiYTr2LeSoZfyu0O6sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljxR6bThY5DlUR876kql9Ew9MhVTRaw2bY23Ku5wTjOZlNwcGGwjrsXeXaQDv45yE75Q0+8Qzj0iG/yZqrbEtlHbl0o9pEpVIPd4YVKhC58tr6wkD9V8srA23lZuj/WPFI/bv+Dr+146+YO56RJQfCH02nlKieBYekfTmY/KKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g9AGPSEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761079229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PJ+lxL9Kg456OCSLKTYwinrFLsE0PMrQ56z1eC1t3gM=;
	b=g9AGPSEkUCdOw4SkKmj7MGnufmVTi+K09ugsRVnKYjGdXGRQAU3Wf4N+wPIDuAhV4LnzoI
	4vNLWgvCh61g6EB3vGLJ+0e1V7XKT/cAuhmkTMZx779HaCIWPrmTTgwd7gzhwdVXSpQaHk
	Ji9wEOHC9sWSqfvnb6PDo+myAHJGdtU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-Vs4ZDHMqM5Sa_7ThiBGZwQ-1; Tue,
 21 Oct 2025 16:40:25 -0400
X-MC-Unique: Vs4ZDHMqM5Sa_7ThiBGZwQ-1
X-Mimecast-MFC-AGG-ID: Vs4ZDHMqM5Sa_7ThiBGZwQ_1761079224
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20C551956089;
	Tue, 21 Oct 2025 20:40:24 +0000 (UTC)
Received: from tc2.redhat.com (unknown [10.44.32.244])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB30218003FC;
	Tue, 21 Oct 2025 20:40:21 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-next 0/3] misc: convert to high-level json_print API
Date: Tue, 21 Oct 2025 22:39:15 +0200
Message-ID: <cover.1761078778.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This patch series converts three utilities in the misc/ directory
(ifstat, nstat, and lnstat) from using the low-level json_writer API to
the high-level json_print API, ensuring they use the same json printing
logic of all the other iproute2 tools.

The JSON output before and after these changes remains the same.

Andrea Claudi (3):
  ifstat: convert to high-level json_print API
  nstat: convert to high-level json_print API
  lnstat: convert to high-level json_print API

 misc/ifstat.c | 85 ++++++++++++++++++++++-----------------------------
 misc/lnstat.c | 17 +++++------
 misc/nstat.c  | 48 +++++++++++++----------------
 3 files changed, 65 insertions(+), 85 deletions(-)

-- 
2.51.0


