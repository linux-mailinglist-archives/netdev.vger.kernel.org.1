Return-Path: <netdev+bounces-99404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0358D4C4E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0111284181
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6072617F51E;
	Thu, 30 May 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0Z6n6rb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A08C17CA1C
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074802; cv=none; b=T4Vxz0MsMNC1jsIPgEZkEy8SFMF/5c0WUJArNwYf3DSFHHCNq3Sq6WnssL0h6o6L4JFfCmlWAqVawRqlDvBXDUXsr84e8dvtAq2oq2LThiPFPlsWayHfc0U8KzI6FtsCcHOLjGA1m+cqxptBA7/AlBTq7xYPbHA/puEtIFoaVZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074802; c=relaxed/simple;
	bh=eOKx/4aIiAljifHHB8rj3d8FTVHdq9xwCwuX+rhfkV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyR/d9dvmr2amc21B1Ix4UTXTVJOSg9SvlUpGch3sdWs5iBeU/PUC+iepAHm5Y05/rggmf1rCkVbPtG3ZAXBoYZ/L5kqHcGMQHvSXA6Fbi+1hwAFYplWdw9zAe0Ed4hFcXluKdiy/xaxXCFznpcoqc3Txa1NJio4dbni+nuNtW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0Z6n6rb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f62a628b4cso1254525ad.1
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 06:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717074800; x=1717679600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn6/3adWE70qZaluvT2NQrezYGVsLoxoeSVhjQrx1ik=;
        b=V0Z6n6rbwJbcUSXTM7GE3MftaQy39iaV5l3bEk7XRnf9VUIjE5r92LIqcDizShQyvj
         uGeIW9zTOKDLD7AuOUpwkfRz6qzorlVpg+uGajU4IONJjfw6SsV7YoEhfPQyM7svYHJy
         O2sJtPejOzxKvmOZPqg/BnDHH20VPDLRIDm93/MrS7uXewoPysyHdirShOPHHEcz89gD
         www8Q5H2eoWNZZOaOUGgnh280Qlu7a9FRhEZU6rafGtyd//ZC7R1SeB5EnluWyBV63qQ
         27sqGDClbPbogA9/BblXJNc7nZcLuJkKkY4Q6pxAMtZmZObNKMDEe1yoXvMV6BWNJaV6
         ilLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074800; x=1717679600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rn6/3adWE70qZaluvT2NQrezYGVsLoxoeSVhjQrx1ik=;
        b=MqcBw/jISCjmZcCa1ZtZ6u/emWdS6aCVATNPOldcr6OVohdjiQX3pg+9JuLGnb2SrD
         utZDDntFtLN/AndJMHp634qP31lU1sZolt2SpnPLBqHn/GY2wMtp66+igc2vIYPBbQpC
         I/qdnmhtw05H5P9YDlcBBOS9TuzFVq8u7eleDU4GL4+8vj4e7o82vNU9WU4A9fg/uSDf
         pCEfMOaD5YtTeIEtTzSEe9uKyBplMev9h7+ytQ3FZ0zue4zknCarZoYp4yeBvY+SbXt7
         TUWRUOR3bSCac0LT4xjK2sSYUe7xEs0YFYaqTOEjT/YmDYhBZXyybfVqDQAW4TvAK6xT
         tQug==
X-Gm-Message-State: AOJu0YzU9AOrJ/a56Y3nFZYmu58eb7OzUPzAKKuvg83sW03T4v+KgDda
	6RCvyXgK5fR0FlyKmhrO0dxWFsGjNDrszo+HXjEplIP8KhPDxxCr
X-Google-Smtp-Source: AGHT+IF1HjS6GCWnZWXM1RVikObrMN2t9GvykuhPwBY7+yxa+8GpHVBMiLfFToSs+apcXCJrjw9BAQ==
X-Received: by 2002:a17:902:c951:b0:1f4:5477:4be6 with SMTP id d9443c01a7336-1f619733939mr24856605ad.41.1717074800247;
        Thu, 30 May 2024 06:13:20 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75de6dsm117814885ad.6.2024.05.30.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:13:19 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Date: Thu, 30 May 2024 21:13:06 +0800
Message-Id: <20240530131308.59737-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Taking CLOSE-WAIT sockets into CurrEstab counters is in accordance with RFC
1213, as suggested by Eric and Neal.

Previous discussion
Link: https://lore.kernel.org/all/20240529033104.33882-1-kerneljasonxing@gmail.com/

Jason Xing (2):
  tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
  mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

 net/ipv4/tcp.c       | 6 +++++-
 net/mptcp/protocol.c | 5 +++--
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.37.3


