Return-Path: <netdev+bounces-226699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 561EEBA42F0
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBC01C05E19
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6821CA0C;
	Fri, 26 Sep 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faz99MWC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C41CEADB
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896518; cv=none; b=jxac1MKHKZPQbNxpcX+kZhYyL5hXsS7o5lm/dINF8AY+m3xMT01DodIOP/2b1JD68w9TgpQtAnY4pJA0VzYtkM1nX99zTg/t1PTzT4Jb2w9I5BHfocarZomZ5qBz3PvIvwe2X3OqraNQeoiphhb17CdJfblJAcl0FFOqKL8NBQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896518; c=relaxed/simple;
	bh=RnKcmoeHBKd3CUe+vQc5sjhoXPbftsIZXm1dF7XwSXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C4/6rrYX+dc5pTcOUSBeCizpLlHHeSy69CoL77N3ofJA6yXYhbLrnFu7BeW/MALBLQb3wf9G5Rw70eWx8PbA3lVEHJMwHRoyEU8eF7Af3sgemPBJ1Ux51BNd6Q+r7pgVQYofyHQmYHiEr+UAS6lUryfauzG4qcCiBufnkM2CnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faz99MWC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758896516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nsN01LKDLcHLmc/GegJIUZlWnYgrx427bBm7VdUWpDU=;
	b=faz99MWCmn2mpIWMwooIalPF31OskYuecKl21XoX2qyMza7xuoTjj7FxCFf+DBI0JqmdMM
	+NTSss/slfxbQXWtRzWx0cp26J0v6NErJxPs5PNDXPe5B0r7mLoUMHsF049meloRwWS3C9
	VQ3HN/6t1w8NrjEegxwA0CbpDBis1S4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-EA8s8hQ4PFaQlpfy0bsMSg-1; Fri,
 26 Sep 2025 10:21:53 -0400
X-MC-Unique: EA8s8hQ4PFaQlpfy0bsMSg-1
X-Mimecast-MFC-AGG-ID: EA8s8hQ4PFaQlpfy0bsMSg_1758896508
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59BA91956055;
	Fri, 26 Sep 2025 14:21:47 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.247])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 851FC30001B7;
	Fri, 26 Sep 2025 14:21:41 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 0/3] dpll: add phase offset averaging factor
Date: Fri, 26 Sep 2025 16:21:37 +0200
Message-ID: <20250926142140.691592-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

For some hardware, the phase shift may result from averaging previous values
and the newly measured value. In this case, the averaging is controlled by
a configurable averaging factor.

Add new device level attribute phase-offset-avg-factor, appropriate
callbacks and implement them in zl3073x driver.

Ivan Vecera (3):
  dpll: add phase-offset-avg-factor device attribute to netlink spec
  dpll: add phase_offset_avg_factor_get/set callback ops
  dpll: zl3073x: Allow to configure phase offset averaging factor

 Documentation/driver-api/dpll.rst     | 18 ++++++-
 Documentation/netlink/specs/dpll.yaml |  6 +++
 drivers/dpll/dpll_netlink.c           | 76 ++++++++++++++++++++++++---
 drivers/dpll/dpll_nl.c                |  5 +-
 drivers/dpll/zl3073x/core.c           | 38 ++++++++++++--
 drivers/dpll/zl3073x/core.h           | 15 +++++-
 drivers/dpll/zl3073x/dpll.c           | 59 +++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.h           |  2 +
 include/linux/dpll.h                  |  6 +++
 include/uapi/linux/dpll.h             |  1 +
 10 files changed, 210 insertions(+), 16 deletions(-)

-- 
2.49.1


