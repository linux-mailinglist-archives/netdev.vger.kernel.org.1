Return-Path: <netdev+bounces-225709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3E0B976D9
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B31B2022E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D463A21B9E0;
	Tue, 23 Sep 2025 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcNpm8dZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342035959
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758657641; cv=none; b=bRGQ+5NS07T+DhnxBPFN2lekSjHraP4w5uxFBhK6ixt+L78hG2vaUq+ZCIhu4irrlXNTAyaF5ruKQ3N/cHjz2d1qZu5v8zk67GAY6OoHDbVr6S5iN6n7QCxzMRsQlnSiucXOt1FNAQhXQ6jN0XlSco13dMuKryGl5aJ5bdEb8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758657641; c=relaxed/simple;
	bh=DUqNL0BxXw9yb60YTESlG8jt6nJyQ3pOZOLBywKCkqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8b8Oru+FYMWcquF4LKCeTm21ok2dUbr5yCOwyCWY+DNZhLlShdwX9x+RXCy78bK333otUCsA3eK9Fi3fHWLZtDL1J1nkilaWTIDiG+9pmwYynn+w4WqnWQpCBD3PTDhiR+Mze/YNOmMyDhCuIUx+8mJX5jRuEzD+XRR+r1cnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcNpm8dZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b2b8b6a1429so44645366b.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758657639; x=1759262439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MMlXrZQAEQaYYcackbMrUxU4ktpxJHOJCKry2TD8zSM=;
        b=lcNpm8dZWF5OfS0HG6HWS+OcptiMhZrL5K7rWXoxiO0aYfHbsyU/vb4j/BZKPfbGDB
         nf+iZ+DO8U9onqu2AJ3rvCsoSBDcPlM3+HW9dv5hy8TknhnbSVWSheHg6jE41UDG6bOC
         sY06ZNBeBKk2KTzH2SMfYAOahulTaDuUeYyNDviGKQBPh4AuzsHncPwaFaW/bq+1Lyz0
         i9BTGA1m65P/qxGjyAwLOKNac3Bm5vv0Z4E2GXTMSSiEF463dSLINFpOY641UUcP9XUH
         Gb9FXnd5IkJbLzTzuzxYkFOtw6DcsKVAQay1fPoKtGIK6ARKIAwoqHLa8HymNyBlp++2
         WbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758657639; x=1759262439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMlXrZQAEQaYYcackbMrUxU4ktpxJHOJCKry2TD8zSM=;
        b=xEHnIenz32ms9A/4kkXo5B6ttMWsXsApMGW9vFQBVWR8AzUJmj5J5NaESPxEUQc+Nr
         I/nD1o41vi3KXZZ07cAHH3Y2mwqMoz/u74DY3zaaKYTd0sx/ftSPeuPxu/aANezQL/sv
         M8MoEBLxH6S6rsH+w5bLvxZS5KWexCTGqLhpk4fnVZ3qRt8dsswXCABM6mbXEyyr/P03
         jP1gHs7iLuM6DTJOS/xjJTmF6zleZ3Fs6jAxLrrWRDwHzb8Hs5V53W4FCvyLG56iC291
         D7VEEEMQD6eGxFpitz69ZlMnPGn3fc2JddkQ+J9jwE+TcG0kIpPSAsQTO43d4w9msyam
         t8nA==
X-Forwarded-Encrypted: i=1; AJvYcCWdnB6Ua1iWyPJIHE4am4xArC4/XZx/3w/f2OXHNCPvYPGgtafVgLHK8sWA1j4EI4oKf0iec8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzaNZH+r9fl6Cvbsj+pmbtPzHsZjUY5Wcf0cjqrbweU5Ms06K
	UXDU3YQKd0fX0zjto+9sGY2eKogch1kyQlQRhhQoMKkrvy9f7ryY6xMf
X-Gm-Gg: ASbGncvOqp1Uy5s59xjWBEbHF0ah/jvBGkXhDnuyjYlYJKNeE7ZuGWiST/vUPy02FJw
	vZX6Xoj+HTYzvGb03+4PaZaMK8/th0oKcPFUsyNH4XlZL6/PGD/u+wOmf85toQx8n5C+/BNjnNO
	9GBnEsESJBPiTv7gQ/0To2VHuE+z89+7F8Y5reMuUSyeyYuVbnzCQA+sFuB6CSY6/DEHJ8Tnrip
	Fwix7Yg7qtVk9kEyObssbGnCsmuUuyxE0E+9uiBq4cAJPoeEyfYl2B2vD6u/y4tNxnwPii00A2y
	HDkq/4feD+4yesAwgeQI8vPbLGwXTw4zC4yn7zQBQW4KWXeIs104t3Z8k7fTge+LQ5s7MSOM44C
	E63Vrg5xFRCBTk8Z3kzW6sRLE
X-Google-Smtp-Source: AGHT+IHN5XcNp/1KJalZXV/5R5ZCq+blsOxXx3/x4YcOoDnXFZxHCB5DKHENkTDjUloqq8JYpW2v8w==
X-Received: by 2002:a17:907:7b8c:b0:afe:ae6c:4141 with SMTP id a640c23a62f3a-b302689ce0emr142054966b.2.1758657638404;
        Tue, 23 Sep 2025 13:00:38 -0700 (PDT)
Received: from bhk ([165.50.1.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2ac72dbe92sm672074066b.111.2025.09.23.13.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:00:38 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	jdamato@fastly.com,
	skhawaja@google.com,
	dw@davidwei.uk,
	mkarsten@uwaterloo.ca,
	yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org
Cc: horms@kernel.org,
	sdf@fomichev.me,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
Date: Tue, 23 Sep 2025 22:00:11 +0100
Message-ID: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
Mehdi Ben Hadj Khelifa (4):
  netlink: specs: Add XDP RX queue index to XDP metadata
  net: xdp: Add xmo_rx_queue_index callback
  uapi: netdev: Add XDP RX queue index metadata flags
  net: veth: Implement RX queue index XDP hint

 Documentation/netlink/specs/netdev.yaml |  5 +++++
 drivers/net/veth.c                      | 12 ++++++++++++
 include/net/xdp.h                       |  5 +++++
 include/uapi/linux/netdev.h             |  3 +++
 net/core/xdp.c                          | 15 +++++++++++++++
 tools/include/uapi/linux/netdev.h       |  3 +++
 6 files changed, 43 insertions(+)
 ---
 base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
 this is the commit of tag: v6.17-rc7 on the mainline.
 This patch series is intended to make a base for setting
 queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
 the right index. Although that part I still didn't figure
 out yet,I m searching for my guidance to do that as well
 as for the correctness of the patches in this series.
 
 Best Regards,
 Mehdi Ben Hadj Khelifa
-- 
2.51.0


