Return-Path: <netdev+bounces-126509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55117971A5C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E8C1C22A02
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D35A1B9B30;
	Mon,  9 Sep 2024 13:08:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D41B9B22;
	Mon,  9 Sep 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887291; cv=none; b=CMBZD5S75FbMVYumRhTfZUZj5FwRyVfcvTmFE0LoHAuAEVeAgjcRvN/b4fRPA5383AeyabSwwGZ8pw77NAi5KQWS7oHyefsqnoKuYFKe9jLimLMFmI156lNVLrnKsLB/bPHMZdADvGaQk9Oaa1sZoZjaRzez96fzfaPEpOHr9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887291; c=relaxed/simple;
	bh=pRaK3Ku3IkQXoZTZoJ3KsKO2/UXaI4WyWbGGP/VRtPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKyMmOs5ws8UHSrjAmIeEQz8fUeTVUskpBIXiPqBNrRnGpcXSAlC60xpExi45yi1IdvRKsuOHMqHKWRHInCaESJv0jP7jEghfmZYjQARI58EceYjUk43oNbrFvkee/5r7kfUJMpo5MHuffjXUlyQPgmBlvzqV09garb88KW2WbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5365cf5de24so2474552e87.1;
        Mon, 09 Sep 2024 06:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725887287; x=1726492087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEjz2XP772fB6v2V8zpQRQxhqoxNSwh9E/XJx/MNIPQ=;
        b=X+/zJa0tRh8xRbGhMePaFb/x0GDPbZMd8v7Tq6CmLvwe17BusFInRAzQjVrhgUCqn1
         Ijb2hohzWPPtkgHrVe3YK32PKFXdJ5wcZNoZyHHBMG2QRcgiN5Y71ejcZzkTg5oonJUt
         NvImTuyNgtcdOp4BWFasFMZE9E0XBfz95dKi/Oy/7IT3RBJ2lzyVw9UnVtHGxggLmy5p
         s4Z36ZMUoq6baDg8uUcCTqhD7mJqUl2bSL/xEIpY6Gy3X50eK0bmpzd8IipeiH5RqvQR
         iClagb3s280wG7OAacTFIwV4Oy7TEq18y1lJwwCa0SMN3s/gFV8c8ISwlyVdO/x6b3Iw
         7ijA==
X-Forwarded-Encrypted: i=1; AJvYcCWRqQ3GKmMHbKGkVWPOtxqWlCNnNyRqGKJ0Fcj5y9YxNF0MTNzfJAnpBP3HqM/qrD28gPNNSFG7@vger.kernel.org, AJvYcCXhrhN6sOs7ZLlQOhrmzY9OtzkAmqQoWD4m1AnDWjNDBtHz4p7akM+PRRMnMlqRT7iLvHq+sVrYlHfIYIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMsHw/YS2vlKlkCEU6tomhqLWt+wDNgX1il7vhbv0y/CFn0wO
	jdkfUheXBcCx8ICHsBuuZ6Kb921FBD1ccF3mzE0IInPo/Tchy9tL
X-Google-Smtp-Source: AGHT+IEJBqpHVWtqlpvZ/Q0u/cQd0lbEGSJxVNB3EVR8pTi1XvjfhTBr1VM800Q+48zT8hF1hSksgQ==
X-Received: by 2002:a05:6512:694:b0:536:545c:bbfa with SMTP id 2adb3069b0e04-536587ac1e7mr5159796e87.20.1725887286492;
        Mon, 09 Sep 2024 06:08:06 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd41cedsm3012821a12.5.2024.09.09.06.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:08:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com
Subject: [PATCH net-next v2 01/10] net: netconsole: remove msg_ready variable
Date: Mon,  9 Sep 2024 06:07:42 -0700
Message-ID: <20240909130756.2722126-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240909130756.2722126-1-leitao@debian.org>
References: <20240909130756.2722126-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable msg_ready is useless, since it does not represent anything. Get
rid of it, using buf directly instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 01cf33fa7503..03150e513cb2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1075,7 +1075,6 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	const char *header, *body;
 	int offset = 0;
 	int header_len, body_len;
-	const char *msg_ready = msg;
 	const char *release;
 	int release_len = 0;
 	int userdata_len = 0;
@@ -1105,8 +1104,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     MAX_PRINT_CHUNK - msg_len,
 					     "%s", userdata);
 
-		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		netpoll_send_udp(&nt->np, buf, msg_len);
 		return;
 	}
 
-- 
2.43.5


