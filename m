Return-Path: <netdev+bounces-151427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B789EEC77
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 16:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98DA2837F5
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D319B217679;
	Thu, 12 Dec 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1ROxG+V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCF2139CB
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017691; cv=none; b=tG5whhbPNhC4R0xb4Uhx3Pi/T4t9R+qDBCuiyNbzg7pHTx4Zu0LFp5CaYhrSpFktc9LWfSsTV/GeOB8IaC6hf7/WQRFNwL51b/Jwrk7yePKNGXUzWTaMIs3pbPH0PuBt6nIE0eQem8aHGZMFethxE/V6fTHAmuggKb9t04fLe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017691; c=relaxed/simple;
	bh=LtXuMz+pA1oX13CBqOZSYuQy3RZ2aBi+tMgfO1t0DiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s+7JEvtLXyaoG1D4roAB6rANreRtWpiQTrtdf2ssxnW46I4/PwNDOjZtOhL/gmXAF4J7bAifqOnPD0YfRL7TwwU9Jh/XjbgbGbp0vv4C6v392h0GYo2SRNjrpVhjUONybyEMSwfa4aHDs3TRPfUtYTmNBWfPv4IHm7Lg6si35Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1ROxG+V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734017689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=13o4+w2vc4IAOvLwv/U7eV9+p2jKQE2IuJHiuMKJebc=;
	b=F1ROxG+Vk5MQQXfKlod2e7NdUE6MjskJvdaRvKADbeUNMdU95Llh4htvXBaPs+YvGrDQbN
	99+W3Xyxk7w+Ti3ZcxC5m9i5HwGT4sPcjdwCneze7xG9GTrXhGg0n0T/k0pBsv3C/a1nyx
	9LVwEUtD39204LSpp9V8UwcPbuEqj6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-TDDFPdouMC6x2B9vLguTvg-1; Thu,
 12 Dec 2024 10:34:44 -0500
X-MC-Unique: TDDFPdouMC6x2B9vLguTvg-1
X-Mimecast-MFC-AGG-ID: TDDFPdouMC6x2B9vLguTvg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC96819560AA;
	Thu, 12 Dec 2024 15:34:42 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.224.236])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 691D81955F3C;
	Thu, 12 Dec 2024 15:34:40 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH iwl-next 0/3] ice: GNSS reading improvements
Date: Thu, 12 Dec 2024 16:34:14 +0100
Message-ID: <20241212153417.165919-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This improves the reading of GNSS data. The main change is the lower
latency for received GNSS messages, which helps ts2phc do its job.

Michal Schmidt (3):
  ice: downgrade warning about gnss_insert_raw to debug level
  ice: lower the latency of GNSS reads
  ice: remove special delay after processing a GNSS read batch

 drivers/net/ethernet/intel/ice/ice_gnss.c | 34 ++++++++---------------
 drivers/net/ethernet/intel/ice/ice_gnss.h |  7 +++--
 2 files changed, 16 insertions(+), 25 deletions(-)

-- 
2.47.1


