Return-Path: <netdev+bounces-114595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C6942FE1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9684B1F2B7B8
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171EA19F49A;
	Wed, 31 Jul 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="UAQWzipR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9D1EB3E
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431749; cv=none; b=mQecWx6DnIcmZhKl2V10bgVtKifW+R5KwK/Hr35vd1erbOj6TWKjV4OS1N6xj6HIIdqMaqi7v1upHoCPRssSyA+XfG/LPlfWEeVCPEFFk6DVUwTuPevlduZE28dCUHbTV1Ll/25V6rBGDn4lDwjATA3a1jHVhNRAGNQOM5Fixgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431749; c=relaxed/simple;
	bh=t35pw5QbAc7zE4aVjQu0odFgWmIf85MJqJY5k29MalA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2QFCeBsM6E9fGlRQjs3leM6FbHfcgpxDI2nzXzC4KMHL70M4Kp8lcKzRALy9U0WDJJIT+/69e54YvK4RwXWtmvjqrQbA2L8RQz8JyOsx9EV+W/2791JoVVNwXhXF6idQ3thwVOXmAycPpCUT7ji0S4T2UlLPs7TKn/LAXxvhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=UAQWzipR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so4135812b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722431746; x=1723036546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3SVrM3JzGDqZmr/ukQvjrjCLXejSov7aNR7jzT5VsVU=;
        b=UAQWzipRxSZ48DZeZf2jLUqdAFETkhwZR4LEXFmxsLd9jGRBl2OLhXdfFEVqR7xc6J
         VEHxADDl0aSiGyLCNwh/AsQTEiwApY4N80LtcrhyQI0HT+NKe35CSo7kewNRHyMDNBF3
         qzlQFzr58ps1wgBojvyJk3TIAXhAkCRA5aDlHTBEnqIeiXVJcnDcGpASBueApGDYQtgS
         mQxeheUD8utby1mCP58WoV+WS8y3xzqiZwkMY4PUfRPTzyd9mcOz2tItflQ+k+XcwQ+O
         3h1iONwnGtCM3HH8rb37INcUNt3mID9POWdIIDOfuRfVhaidacono7eqdea2mORn8N35
         JOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431746; x=1723036546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SVrM3JzGDqZmr/ukQvjrjCLXejSov7aNR7jzT5VsVU=;
        b=LFpGqsVRauggqExfqiz4N7vtFQ9iia3Bn4Yx+wbZ37ic2tPSImDOY1CbF9i2bM5ae6
         QabRVqj5PcNDcU+Tz9nux5wbk4TW1uJ6FOVHN6c1YLQgpvMYxnoSkASleyZKIwH8znuv
         G1BkoGkNlr+2lmlHsoYewj1zbV4xEcIhRKd2hVn9GS7wb6pNRmXegJ5adoYqaPh9L/VC
         oGy28m842Se+MwJpbElWyv2MARhXShM8wMUQ7n4RJFqhZ5EIdG6JIriVsPhlz8i0653s
         aiqE42ca1LxoE5bRtdw0tw3BGoUUqNl9D2Hd6cbjLBJcj2yjCBkiI9as3GK1wcqOMdi0
         EtCQ==
X-Gm-Message-State: AOJu0YxLKJtaINULnqTlpQuWGsrtpUrFZOq/0kO8hwFj8ZWzUV/XsrlF
	APjm6NlB0Qx+i4r3/g+uXJ4TCCrRPHcoT64TqQmwNcN3oC7JaEMtpCLZKpGWqjsnOgijIy3lTpc
	27Mk=
X-Google-Smtp-Source: AGHT+IFXlXjJKkynIQXL2rqayGvDXTMn9UzLmogLg9m5jIfw9c3kNQ2GF8TmG6Hjx6BuCQUqQhIgzg==
X-Received: by 2002:a05:6a21:339f:b0:1c4:985a:acc4 with SMTP id adf61e73a8af0-1c4a14d9739mr14639687637.46.1722431746511;
        Wed, 31 Jul 2024 06:15:46 -0700 (PDT)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8751d3sm9959058b3a.168.2024.07.31.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:15:46 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v2 0/3] fix bnxt_en queue reset when queue is active
Date: Wed, 31 Jul 2024 06:15:38 -0700
Message-ID: <20240731131542.3359733-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current bnxt_en queue API implementation is buggy when resetting a
queue that has active traffic. The problem is that there is no FW
involved to stop the flow of packets and relying on napi_disable() isn't
enough.

To fix this, call bnxt_hwrm_vnic_update() with MRU set to 0 for both the
default and the ntuple vnic to stop the flow of packets. This works for
any Rx queue and not only those that have ntuple rules since every Rx
queue is either in the default or the ntuple vnic.

The first patch is from Michael Chan and adds the prerequisite vnic
functions and definitions.

Tested on BCM957504 while iperf3 is active:

1. Reset a queue that has an ntuple rule steering flow into it
2. Reset all queues in order, one at a time

In both cases the flow is not interrupted.

Sending this to net-next as there is no in-tree kernel consumer of queue
API just yet, and there is a patch that changes when the queue_mgmt_ops
is registered.

---
v2:
 - split setting vnic->mru into a separate patch (Wojciech)
 - clarify why napi_enable()/disable() is removed

David Wei (3):
  bnxt_en: set vnic->mru in bnxt_hwrm_vnic_cfg()
  bnxt_en: stop packet flow during bnxt_queue_stop/start
  bnxt_en: only set dev->queue_mgmt_ops if BNXT_SUPPORTS_NTUPLE_VNIC

Michael Chan (1):
  bnxt_en: Add support to call FW to update a VNIC

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 50 ++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 37 ++++++++++++++
 3 files changed, 83 insertions(+), 7 deletions(-)

-- 
2.43.0


