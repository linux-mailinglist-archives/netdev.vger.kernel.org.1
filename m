Return-Path: <netdev+bounces-81564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC74388A4E8
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595C2C015B5
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7751B7F7A;
	Mon, 25 Mar 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw5SQsG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB813CA9C
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362566; cv=none; b=D1xkS4bndoFxa5mWQj1RpVlyv1PvGOS2F9QpnwKLdph2oIBfeozu/2Ef/Q8z9f2TNNvhh/YqiYFnnPgUYQNXHfFpzf/turbmZO1MqXyH7nMK55r/OOF+wNz4l6tyFRbt0vAo6yzPdoBPxkR8ZpFMDpLgNcShXYa/9jJPYP/WPj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362566; c=relaxed/simple;
	bh=leLbNoEgcsKolTpqiCYS2LjBfGGuPRSQLucSZYp3HJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5/lVlNyASZtWvYDPdGENxusReb0DWiwrisNFKyKZD0SFBozWs+3eP4HkASp6ERtIUPH1O70OV/BJOCVIab/VvTnAg72FuhIWH1ctMqmBJug/Fte1Zf+a7fkjNFHtQeF5a+mB31xq+3AZ5t7r28aTwvAYvwsPiupD1Y8yNZOsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nw5SQsG3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4147c4862caso23936025e9.0
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 03:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711362563; x=1711967363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hbZRFFdx7aQrsE2QRSID7qCvUK1DThMd3eA8TiXfS/I=;
        b=Nw5SQsG3D3zKlwNMUthkC37qChuKFzPfXHUmxPrNFH+9YYtIXCXMjJNphan+zgmPT6
         me+0ZuH4Cpsqe0fPdnMEOo/4Wn8TbqSrDJi+J2zqph4SfzTX4f91RmVU/9OxuYx030g5
         fMMY8EtdKs5B14WD9k3VpeQMg0MNAjurbbgo6lHR/RSXtpOe/+0AqD4nplEMtk6lbqpP
         RkpdLD9frsGE1Hr0/dYU3fLwkQXgzG3azhgTXiZbZ+O6EVU6mv405PgfqcMl6kNk7HQO
         rhpltNTah/HAd8DKLkuRCSOTFoNcQtE/fNTUnY8+37l6KyDomJbWcfMsBG5Aai4Q6Q+E
         51DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362563; x=1711967363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbZRFFdx7aQrsE2QRSID7qCvUK1DThMd3eA8TiXfS/I=;
        b=kqtRWySXl0L79CBtFDoCqJrNSUcLllUOpfdgc0r8fTH2BA/qvvHhK07DABZdPTgDp5
         BQGu+2zgXZVZbmZtck/8yCyqni6H88iTZnuyOj5/OF4wcqRGUplUXb2yi4NIg7WitzIY
         jxcMZs7rdUlK+u8Ds36bn8Iapqv82FqRupYaotyqWBLaBecz+LiWqN+TyizvawlS3m9o
         aNxvgEtzSWfQsLg58dV+mnOAH0GKtiuic/SFGu2+wVv/7l2P7sR+mDLkfCMNV2Sfml4U
         in4TuOf6/Q/+cyx0VBy+N4DTFZfjoevuIN6KgBbvS+0eic87UDqvk+NmgbPqA+t17k4A
         Kwkw==
X-Forwarded-Encrypted: i=1; AJvYcCXPUwIkJ8swwlkhrxoF/NN3xOHdyVb+0zdiG+MUcv+kTQbTkSlH6hyF+hUXQKIRy3IaHbusVLljyAsdUJi8Hb4BpdmsOZA4
X-Gm-Message-State: AOJu0YzKhyYCQ+YbUaVUrhWx/o4+mmH6IwNgAbeEFVMDPR5pZ49aXWrT
	Nu+wjgoCfA4zlagkAag3O0kIby3jujRoYc/8wwtM8eWowAPKdtku
X-Google-Smtp-Source: AGHT+IGHohmOFY3An5lXzOfCdA6nKJIFvbDQaUMGKXWJSbMkqhOdswMEtFQpIs/7JBVZ6/tSPx0Xsg==
X-Received: by 2002:adf:c681:0:b0:33d:73de:cd95 with SMTP id j1-20020adfc681000000b0033d73decd95mr5659243wrg.17.1711362562479;
        Mon, 25 Mar 2024 03:29:22 -0700 (PDT)
Received: from localhost.localdomain (91-83-10-45.pool.digikabel.hu. [91.83.10.45])
        by smtp.gmail.com with ESMTPSA id bq22-20020a5d5a16000000b00341d0458950sm1394958wrb.15.2024.03.25.03.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:29:21 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: kerneljasonxing@gmail.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next v3 0/2] Add IP/port information to UDP drop tracepoint
Date: Mon, 25 Mar 2024 11:29:16 +0100
Message-Id: <cover.1711356377.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

In our use-case we would like to recover the properties of dropped UDP
packets. Unfortunately the current udp_fail_queue_rcv_skb tracepoint
only exposes the port number of the receiving socket.

This patch-set will add the source/dest ip/port to the tracepoint, while 
keeping the socket's local port as well for compatibility.

Thanks for the review comments by Jason and Kuniyuki, they helped me a lot
and I tried to address all of their comments in this new iteration.

v3 updates:
  * Dropped "lport" as suggested by Jason Xing <kerneljasonxing@gmail.com>
  * Clear saddr/daddr fields using memset() before populating the fields as
    suggested by Jason Xing.

v2 updates:
  * Addressed review notes by Kuniyuki Iwashima <kuniyu@amazon.com>

Balazs Scheidler (2):
  net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
  net: udp: add IP/port data to the tracepoint
    udp/udp_fail_queue_rcv_skb

 include/trace/events/net_probe_common.h | 41 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 include/trace/events/udp.h              | 29 +++++++++++++---
 net/ipv4/udp.c                          |  2 +-
 net/ipv6/udp.c                          |  3 +-
 5 files changed, 70 insertions(+), 50 deletions(-)

-- 
2.40.1


