Return-Path: <netdev+bounces-242505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D66C7C91089
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 08:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3CF9A34BC39
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554832D6E59;
	Fri, 28 Nov 2025 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh8nQMYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B80134CF
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314760; cv=none; b=G4FzhbuBEeNYbcueOMx4V7ia9mPEM6J6Pt7hRwiHfvEztC4EJv6o842JBfNpZ4Rg+oZTSGMhwPCcyY5iptt534mF6PMtmvofbsC7yVr6HAj6ptpBPD3y70Zc1OJM4zOY4itJNyOUJo0J0hRQE6hkVWPw8Zxvffh7c6AEMT+0Wo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314760; c=relaxed/simple;
	bh=+SmCRWTrlc0r2OwCSIE8ha9a6EvaxxlPeScFrc4xL88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lU2fNHF273uUccoEDEFU8AQ9Dt1ECUkCaaWm40Pbb1rP/yCWqmkaVz1NvwFF8iGwUge/Ev/4w7RvXPdd6j8ZOWo9xvB2cFkplTtKXWrcZ/ia7Iqx1JEJBUiJTBd9lzx607B3FIfnh2YCSRMNshcUtotxTkSub+sjkczHDF1MCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh8nQMYx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7380f66a8bso242653366b.2
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 23:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764314757; x=1764919557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPascdlztEnoaiHOFCNuou/ryBuA+8aO9E9qYmSrJSQ=;
        b=Zh8nQMYxAdqfTik7fM0FWmDOKLordzcMdQ5j370cCJUqoA+G5GOcB/dvfz9sA3kHfo
         uL/FMjFuLbTPGkwbjhED8WjebkAr75kky5dojiw+qK5WFEEegZsRX18RjNiFhri5tU5h
         4+TwuqvEUaVq4bB4RnC2YlSk58vy29JUeyR5F+QYzgGxxzUvTLJSA7rh0GUJwO3n+PJW
         bc7Lufhu00q6x61V77u7hW4RmCYUJW2c1ffEz3nzgI37eERVHHip/s7Cjy2Q77P/F0gg
         NCiYLGyDI76Nbj8OyALr8qe+HY8IR/WfY5cdqFkfNIS9KxWpFdPx7XqcbvBABlwG8yu0
         Ac2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764314757; x=1764919557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPascdlztEnoaiHOFCNuou/ryBuA+8aO9E9qYmSrJSQ=;
        b=BQTB718EpCf+m8TlObqeO3kjj5nimc9+r2/74egWx5gifK2Qbky4BfGr5ZiHZkxJXb
         ECyoYfPFsUPODamf8Mjq8Qk+XUb7H8oG5mRXkOF97sW5YigdLg/tpS+VePwM3oTDvMda
         8QEKCIHgS50YgB58U1YANWpi4NSJYzm6ZZSA4kfID1IKylsUCZjgQKgAnSz4kEKQ/kSr
         c/uZnFCw2EPn29+0Vi36CBa+bTEnvwWX/yi5nZZ0YNGNQVpohOdUYcYnutn+j9PqNHfm
         Ho6PoVe9tU5H3InhS8rgcYkPHDCQ6pK+qWme44KxtpgZqwQkQ4/tXuVNCuhaDlLdbbjE
         O5Pg==
X-Gm-Message-State: AOJu0YwTmLWSR3w4qV9SX3s9ULQ+8hUEQOtGn7kyYKiiWgw3dEnIrBBH
	uQSOHI1tyriCc7x5OVNJhPSjhaFqCSNUxUsbM8h+pR3Dga/s2/FTEIhWV5uBvA==
X-Gm-Gg: ASbGncvX+ASd0hLsj6NyQ++nBMNrrNYCS7zQzj6/pnc/floKAp9TEN9e3jLAqZCoUM6
	IToQRFiPaE7jM81Z3vLtWwjea/4gJ5hs8j7vIaRHsGmcb509qFVArpkQmMqhDUOoXD3Mpb8l9pc
	ANWOLhfg33i/PpYlYQiP6lw8pFpXhyfLrNcWkfSnpIsidXr49faCLftSnetkxPmQaOfpXynyw19
	pkxtJoCnzqcBizICKnztuh5LIb77MrJTzfXyJcFb+mUI6DdRQJWoxiLobjncbgcLYgafxgiSdHe
	9/MRqT6CUdGJJvtFfhlvd/M6Cohds4wbUw0lKIirXDj8PXAYYRPYB5jGWENFEkR826W4fKqCuw/
	9xv1VDS7mN6tePrjEihol87vB5iK5mspf2JvkeDjlwT682CDxi777fk6Vdtl6AfFflrlW4/rENQ
	YlYbJjJ6Jby65X5vli8iMmTQ==
X-Google-Smtp-Source: AGHT+IH4lAPY8fQ+r4Wk44TmuRdi25uLpSvjBglMgf1DY7m+zdaalgYzcXk9fjkz1+w5Tljp1kYB5w==
X-Received: by 2002:a17:907:2da8:b0:b72:d8da:7aac with SMTP id a640c23a62f3a-b7671a2a2f4mr2992193166b.56.1764314756676;
        Thu, 27 Nov 2025 23:25:56 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aece0sm363772466b.32.2025.11.27.23.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 23:25:56 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jiri@resnulli.us,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH net-next] team: Add matching error label for failed action
Date: Fri, 28 Nov 2025 09:25:44 +0200
Message-ID: <20251128072544.223645-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the "action" - "err_action" pairing of labels
found across the source code of team net device.

Currently in team_port_add the err_set_slave_promisc
label is reused for exiting on error when setting
allmulti level of the new slave.

Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
Related discussion:
https://lore.kernel.org/netdev/admyw5vnd3hup26xew7yxfwqo4ypr5sfb3esk7spv4jx3yqpxu@g47iffagagah/

 drivers/net/team/team_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 0a41d2b45d8c..4d5c9ae8f221 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1231,7 +1231,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		if (err) {
 			if (dev->flags & IFF_PROMISC)
 				dev_set_promiscuity(port_dev, -1);
-			goto err_set_slave_promisc;
+			goto err_set_slave_allmulti;
 		}
 	}
 
@@ -1258,6 +1258,7 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	return 0;
 
 err_set_dev_type:
+err_set_slave_allmulti:
 err_set_slave_promisc:
 	__team_option_inst_del_port(team, port);
 
-- 
2.51.0


