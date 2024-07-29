Return-Path: <netdev+bounces-113798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A1293FFDA
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 22:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC429283ED5
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 20:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707D18786A;
	Mon, 29 Jul 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xT7zH1CU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68281891B2
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286504; cv=none; b=G5wmOUXzDHyh01++7cQdDhmlEbNLMfSo1ST1AqI4qf2pZN/urOBqp3+XV/DfxC5g3C2Gb8DUvQZSHr9uXcJ04Mn+NEjVRy0xPc2JYy0Q0KC6uROw7aEN105E7c4vvhnIEnZLm4Wcl1/O64S9G6e0yQlB258hK915kX+GwARbILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286504; c=relaxed/simple;
	bh=sJMLU7mEavdOfESZUHrVN8XodJcrv1KNhbdOA0KBKtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kP/zEhp4wlCSiGWMJE97dUgxrIhYFheSfEbcX0v2QL/d1XWiSgzgOmgkEOiN2V46SSEiniUW/ZfA4gSl3j+wDetQLysw3GpMdkM8kLI5LakU936IYnZW6CcTM+bBYGsU4FRck9QHQVg0GURhjG9L0pzJ8PYyivY1OA1gN0/qkvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xT7zH1CU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso2884831a12.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722286502; x=1722891302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ML5fp+yCvwv2SrKSbPgcg7ANXJSeySYvh3gJKc3nS9U=;
        b=xT7zH1CUzna6dSYVQ973msTbaJWIeb6TSENzzN+i0PXV0C7Y7Kel7+Vn9nCI/cZjT9
         SjQMXgXnLvFTuzmTG3wXTyQLHBhjWj1262ESeIqCZ+rPmFnKAdDNU/KDJTX85Dl+6UV7
         Y2B76QvWBm0FgEohMBapYzFvAnaB1cWq4VGE0qIjLR7laX0VGBQotoZ94D6qok14x2HQ
         66YcxmARexo/4F7GBUJn71EjZcKwvPRMtvFthh4RjeE3M89PbFaGknO16mPS/TQBrd53
         5/1/EA2WUAB+6GCsQTgfoMCx4WSTEWzk1GpenzoDe4R1w5pv3ZtZWvRL73di3J1wMyUn
         R0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722286502; x=1722891302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ML5fp+yCvwv2SrKSbPgcg7ANXJSeySYvh3gJKc3nS9U=;
        b=M5NXbx1ZQVZbUPXCCNDPT9hPom2IOTqauyjzDwAxSXU50xPHPUvz5Nq5YzX/hhjCMa
         7jUCfocQ3KgKKZJslXj1kRh+p3R8SmNg8vGLYNFUk1z3JNOND5MymCReWhEvbqEmYzi4
         1kVvpWiU/E+kGxJsADaRZ2Icv5I5d8BKJ80hQuiVJATI3fEo+Glyna5+V5LQrNZqVG0F
         zBHGoAdNfk2JDWjDILCJmVAq9I2dZBWc74osu0SQLDMiBrJki1kAlO2ram+jqpUEkawu
         ZZeBGDJUrosWk/VVERwsS/krFFJrEhBLsrVxY7DrtOOA/9CFs4p1b8ZjyT7Bq4EdoAOO
         5E+g==
X-Gm-Message-State: AOJu0YxXDjAx6JY/UKc53uIPcLmF0eRAv/xsL9PAGMjX3ssTVtUw2HGL
	jQlqdKgOGZU/Dtylc487z/ry5wrSCMxYZ9VNA07tYXDvouauvPPM8JQqmH5wtT1vWERnij4yC9q
	zbX0=
X-Google-Smtp-Source: AGHT+IHteE3LHSXPRstwY03n5vNFeT70FS3342kund+WzG+s9sPAx9yRaX8GqYCbt7Ko16mITdAy1Q==
X-Received: by 2002:a05:6a21:1583:b0:1c1:92f8:d3c6 with SMTP id adf61e73a8af0-1c4a12d0051mr10413477637.27.1722286501741;
        Mon, 29 Jul 2024 13:55:01 -0700 (PDT)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7120f6sm7255041b3a.50.2024.07.29.13.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:55:01 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH net-next v1 0/3] fix bnxt_en queue reset when queue is active
Date: Mon, 29 Jul 2024 13:54:56 -0700
Message-ID: <20240729205459.2583533-1-dw@davidwei.uk>
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

David Wei (2):
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


