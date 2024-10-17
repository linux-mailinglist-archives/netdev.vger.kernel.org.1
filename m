Return-Path: <netdev+bounces-136353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3341A9A175C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5E21C22013
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 00:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C4118AEA;
	Thu, 17 Oct 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VtKr7Hro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204714F98
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729126672; cv=none; b=R4vr9RHGEpDAxX5NILKDhzQyXmFifaMrJSyK7bcEXDr2pBAnARKA0PXBXvP59+XWv1TWXv/ltB0JoGMFMq3hZicARUSl8O7Dny2oPSJf8I7ZCfJZj1e/X+mauBT7wDyaVGZi9D26RnfnI//xoX9kodhLFZv7ndBe0osQqT8k75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729126672; c=relaxed/simple;
	bh=ztsoP4yQAbLU/sfeMzZ8pioaFukXTCLQpdoYvLrX7YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GwiLrgWLhEnrbXCNpGpTtu+++KN+5CPzddZ+o7cW7LnNcQEBKOhrUHjL9SMPjBIg0jwqYqmCu4IOQ10BTr7iyt+1TMF9tD9H+rGuwOD6bCfPSHYEl0aaZjIk7XFWRgNxN673naMVOc1CHBgjMFXSIMyh0Va8HxnhgFSifu8+9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VtKr7Hro; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b13fe8f4d0so28557585a.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729126666; x=1729731466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOR+dpc8DM6A1a+IpLEzndQfTbrXfpiIyBadcQkr28U=;
        b=VtKr7Hrov7II2TnTw+mDt9kaPYOqbcX5QceOMfWwzeS0Yc+JO3+KX7aSp+wrZKqUdG
         tTtezpujxdasXmlK8Ab1qhnjZ1U3i75XXzRUcJHG3sYUlBA0uFujZeZoznO19F41RGNI
         dsIYfR1YdX0NV1OBWpA2KY3DpyAaExlBE3cE9E0XOnT0laLhhaNXqHKzhumkxkttQzqm
         IhOaRf9rHo2YgkbAYwq9pjN1TdmQqiwsKtXTr9b2upW+BAYf1E+NJNGFtFudsAIFxrSm
         gcF8feV6OPfG0iTU6hY/a/f4HM68t7UlfgiPQ/87i2A9Lwpy+8w+zhU1Stw5AjjmJpXP
         UOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729126666; x=1729731466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOR+dpc8DM6A1a+IpLEzndQfTbrXfpiIyBadcQkr28U=;
        b=t/7FvhLCRekLftkQ/+Ipl3H8zRxcl5sZtjOKGIHgmG43Y8pG/rVkBH6nwk6zwhgfw+
         DR6cixN6jWLrebPWboNKGirJ1VhfEE/IocR/FZAmDdRlAw7EiNmgtNQMNqWn4Xyory5A
         D3rxtLm+t0ytTSk+xc4FIGRqPPi7fxr18KdlWY94NFg5G9BCT6yKuzJQFa1+m5EUSLoy
         hRBTQFAzi730Ml+GWifLcwyBzN1S/5VTWNAjL3bukHAoBpcoZjxDlQBHH0Ka12ufyydT
         IklwxrNgeurnKc4FpFjbA9wr1Ml3v2TnRKmUCgODNgh7WJYGZdg+0wN0OMZ4DXsjnTeu
         0KYw==
X-Forwarded-Encrypted: i=1; AJvYcCWmnaIhU3ItVAZ0N9GuId0spPfbfJY0hSXLb0gxPRf1JZqJMIu1Gnmk4cHGqo6Jnjb+z5Z4qH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkBwaOhamQgcKnsNVrUSkpqExBANF4SL98WJq7ioa3UyqdItO
	ITkQwO3D++k4v9Jf8c7WCOSgk3gWvT3yhNYEXIUVxTy1j/LSzTekedmNsLEpN+Q=
X-Google-Smtp-Source: AGHT+IGPcsrIhdZmOFUuDVFXb2vJJhYiEmCRPKZpP6JFr1v4IdZGhQfebiZvqMyqBCPt9cU/h/j+KA==
X-Received: by 2002:a05:620a:4493:b0:7b1:500b:b7ff with SMTP id af79cd13be357-7b1500bbbdamr68192485a.27.1729126665919;
        Wed, 16 Oct 2024 17:57:45 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13617a23esm242466685a.60.2024.10.16.17.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 17:57:45 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	cong.wang@bytedance.com,
	zijianzhang@bytedance.com
Subject: [PATCH bpf 0/2] tcp_bpf: update the rmem scheduling for ingress redirection
Date: Thu, 17 Oct 2024 00:57:40 +0000
Message-Id: <20241017005742.3374075-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

We should do sk_rmem_schedule instead of sk_wmem_schedule in function
bpf_tcp_ingress. We also need to update sk_rmem_alloc accordingly to
account for the rmem.

Cong Wang (1):
  tcp_bpf: charge receive socket buffer in bpf_tcp_ingress()

Zijian Zhang (1):
  tcp_bpf: add sk_rmem_alloc related logic for ingress redirection

 include/linux/skmsg.h | 11 ++++++++---
 include/net/sock.h    | 10 ++++++++--
 net/core/skmsg.c      |  6 +++++-
 net/ipv4/tcp_bpf.c    |  6 ++++--
 4 files changed, 25 insertions(+), 8 deletions(-)

-- 
2.20.1


