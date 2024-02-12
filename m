Return-Path: <netdev+bounces-70858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BB4850D5E
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C150B1F24233
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 05:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A153A1;
	Mon, 12 Feb 2024 05:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPyHckbW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA67462
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707715528; cv=none; b=G53zilbX+4aUV5VUsYEBcFzPUn3XilbOJtW1kLkiMv6En2gDaoHXRzy/w3WB/yxdmwL4VCVLbtkrQHwcB97rGtt9JVPU72O2IRO/MqtOZiHqyY8dzwZ3upVx3400HwSSKU2UELqbqYLWI48DurJuYpPZYgrGDFSEo1sJV3OVGLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707715528; c=relaxed/simple;
	bh=+5JBWXuQzWSXoy+VirZ922BpVxUNjkc0aeGEGyhk3qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UyTiNMlRMH+N7Lt/VXbUaCqVt4xcWNd5uQMrEbT7fW4ETq9IkdGv59ZaNAryA6A3MrYd5cHNAmefGqy5oJ72kSz8cIk8T7uAwOc5FHldLtcKfscqd7aAQZfQ4NuWH8OUT8iN3pMn/4HY1fPEaSYVj9rWdhIzEh4gCwo5ukx0cgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPyHckbW; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59a146e8c85so1637377eaf.0
        for <netdev@vger.kernel.org>; Sun, 11 Feb 2024 21:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707715525; x=1708320325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUSZvmq0U6JoERhs+vDRZ1zQo1A6eNx/aTru7yBYU8Y=;
        b=gPyHckbW4LoWLIb9M12uldfOZbXnxkcZ/dQS1kQ130lx8zAhId7E1VIXJLhyf7kDlg
         Dd7SQBsat4XvQcay97EWGLf2OrSISrDuRQ6ZegF360akczytsOs86/U+H6DMXCih4JvK
         FUhgNCo9oZ0fdkQ+SNzgTYxtXv5hMdG7IDW5KE1z92BB1CHYt5nq+DWgqvSuhK8SDvJf
         3qeG1ugf75UHj9MDRW28NJrTSI4dCFXyy3w8PGJx7I2VUQDchju88rLM/2t/Y7SjfLUo
         Ky2t0MUc1U4kCvjjxXecTbI829ORpRorgenoP4fMdEqADDFaRvhRUrsBFvJ6OTW23KmP
         ik9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707715525; x=1708320325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUSZvmq0U6JoERhs+vDRZ1zQo1A6eNx/aTru7yBYU8Y=;
        b=kEDDH0MgJW4YnHlY5Pc5eVZjg4Bczi0xr/WrjlKlRSG9xqxA+B841AZPSfaKst4+WG
         0NY37fQPOG4VeRFpKXmNZXcFsMvR2NnaWEnrrN8FAI/K8j6EcB16HY6zGQgMgZ1oltZn
         U2P7oWu6deKPvP7bhGEaGK1ax0Jsr7EEBd5vzO/yFCT42WTRMDTBqHxR54gVJXzlgFkx
         9XaX/a/tFBL8hIWTmIllWtQzxJG5pfu0zmMD2Wu9QjVf7Yg48WF0TbXODZiKf+UF27mV
         FSnm3dvzPnaj1ZAsHg2ZhfePjTj9K9tOHnyd2QP6phfoxypf+OSuyjWaevsG7CDFua5T
         n2Tw==
X-Gm-Message-State: AOJu0YwmxY1GXzRJibV0e/nGStd5HckJcLsMGDmRzPMpzN2qQXo81fsD
	MJXcPODdI8aEvL15ljJ+etIp5W+UnVNXUn9KjGCitokvCQF825m9
X-Google-Smtp-Source: AGHT+IHPaNjx5mh6OJovbmjpHo9Wot1qcW7PKTxnG1APidD8RYL7JdA6Edqab9j7cjEhHYr3+O85+w==
X-Received: by 2002:a05:6358:5292:b0:175:4f0f:bbab with SMTP id g18-20020a056358529200b001754f0fbbabmr6683187rwa.22.1707715525542;
        Sun, 11 Feb 2024 21:25:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUP/1ypqBk/lPWMWx32D5HcUwtPJSjcOFx645OeO75+bAYi7FA9P0IBk0+nxBnZYQaNXwfu6p34qArZPg/ff+CEFxehDV41z1CpZhszzs/cwjUJ04P6WTBF61hDqfeAA++N2/1fGEU2LLCjkctX3zjBIW/HbbOpPogtbiH+esPhm/703RFN2ijCgXS2eIvlLS+4P1M8DEENUzuWZidIP+J+VhEmisfUuBs/nCIUdm0=
Received: from KERNELXING-MB0.tencent.com ([14.108.143.251])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a001aca00b006da2aad58adsm4725291pfv.176.2024.02.11.21.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 21:25:25 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/5] introduce drop reasons for cookie check
Date: Mon, 12 Feb 2024 13:25:08 +0800
Message-Id: <20240212052513.37914-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was debugging the reason about why the skb should be dropped in
syn cookie mode, I found out that this NOT_SPECIFIED reason is too
general. Thus I decided to refine it.

Previously I submitted one patch serie which is too large/risky, so I
split that one serie into two seires. For another one, I will submit
later.

Summary
1. introduce all the dropreasons we need, [1/5] patch.
2. use new dropreasons in ipv4 cookie check, [2/5],[3/5] patch.
3. use new dropreasons ipv6 cookie check, [4/5],[5/5] patch.

v3:
Link: https://lore.kernel.org/all/CANn89iK40SoyJ8fS2U5kp3pDruo=zfQNPL-ppOF+LYaS9z-MVA@mail.gmail.com/
1. Split that patch into some smaller ones as suggested by Eric.

v2:
Link: https://lore.kernel.org/all/20240204104601.55760-1-kerneljasonxing@gmail.com/
1. change the title of 2/2 patch.
2. fix some warnings checkpatch tool showed before.
3. use return value instead of adding more parameters suggested by Eric.

Jason Xing (5):
  tcp: add dropreasons definitions and prepare for cookie check
  tcp: directly drop skb in cookie check for ipv4
  tcp: use drop reasons in cookie check for ipv4
  tcp: directly drop skb in cookie check for ipv6
  tcp: use drop reasons in cookie check for ipv6

 include/net/dropreason-core.h | 21 +++++++++++++++++++++
 net/ipv4/syncookies.c         | 20 ++++++++++++++++----
 net/ipv4/tcp_ipv4.c           |  2 +-
 net/ipv6/syncookies.c         | 18 +++++++++++++++---
 net/ipv6/tcp_ipv6.c           |  7 +++++--
 5 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.37.3


