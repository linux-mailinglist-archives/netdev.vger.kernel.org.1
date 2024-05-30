Return-Path: <netdev+bounces-99406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CCF8D4C50
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B591F2245B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF57183068;
	Thu, 30 May 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOSQ4Ome"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1017F50C
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074810; cv=none; b=szU/hQQXJMnXK7IMwl15kHSFdx1XxMl/LmqvMq5P85JyXXM/FhiyPdoMOfhd0lpclhlqkndU1O8vt3y+gXVhPvAhtvY9g+a7zSbfJCLzzGa/4N3zMr32RfiGkv/jLctOWOa6bvit8+zjbRYeIMeXdoqA2b08e7KlJ2OrzELei4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074810; c=relaxed/simple;
	bh=LidcF8t23URacHF1pQU5vSKTvOluPtJzGS+Vnc5xckQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mjX4kUg9G0deYWVFIG9my4MgijwDKzIfN7hjHMZ0PEb2hYOK5y4IkwUXSYJJ6TyMVD4tXId0o4hnslq7+pDFh4NXIN9t/fImxuQOAodMn/tq80dw4mBrN7SasEYgghXSkV77jt9+Hs663Jv6RBZmrVC+pjTwZ5B41vXALxc1rqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOSQ4Ome; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f61f775738so4056655ad.2
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717074807; x=1717679607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJygBmIY79fvAAP7C8AynPmuHSE1Ops4q9w/nT6BOSk=;
        b=OOSQ4Omea/Viu+8Amr3aKsn/7R3E84Ye5z7uHaNSS+BHBQyfdiWW0dNs9N2U3l2qmW
         E8lX8bR+KwKo5w18hnH19j8eoEcdtA9yiUw25TDNIis4iU16lZdWNp6pO1UIlO3a6ppl
         Ra7IX0fKkJD4KgvYG0Yu8VW/EESxNNMY2v+OgZYYHoSwRbLagM+36PxKjEMtWS3VL46e
         9/PlwsI/lTBYJfnaXzH20oVU3wQaeIrBtsnKeM9OH2a/h34daEB9hJZ3N3H9XJ/ZVMel
         gPfgpxDEvb6PndF97WMzC5OsY4z8WCbSAMa/U8X6ieeij8kdWmZAOzCC+havTSCNi55M
         QIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074807; x=1717679607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJygBmIY79fvAAP7C8AynPmuHSE1Ops4q9w/nT6BOSk=;
        b=jeCTE4tZGS9Bej83tGLusztSOZdjrGcb2A4WpUEV6bC311b28xKkOWyfFGNP6Z1Pcm
         q6FT4iHAT/+uPDBecIqBgVuNnQO2Gragyv848fsE4h+EwuD5DtGHv36wGL4tyvI3l5v+
         BphE/cwO08WaXFDox4W9URhE1MIb8Hhh1AVbVTPBsD0XX/9CKM2+Ff4TXyvM30wezQ9d
         odjX4RXpT+C55ahx/kP0B9LBb1COTQoqKwx5LN4utaFBGdC5v1S70OsfYrP5T4yP3WUu
         XscWn38OU7k4rlfe4BKFfN5sWDso/wZtIWn9M3vMbf8PsxfUZe583Orrto/TI4IyFZIV
         KW1Q==
X-Gm-Message-State: AOJu0YzH5azSBDinTvmso75I8XFPlx7GZ6maZ1hDgh71jzwjtg9zTh/6
	HDw2FgbJI8oa/uLe3+ws5ssuax+fd9+DTQ6ZIdEVi3adw4LphVD4
X-Google-Smtp-Source: AGHT+IF8nAXNCvLE9crt3PfaxaIFi+g17LgND85Olc9PfykOagHx5MHvCbDNWyRXyhTcUeNv7yzCMA==
X-Received: by 2002:a17:902:d2c9:b0:1f4:7d8b:cd87 with SMTP id d9443c01a7336-1f61a4d5390mr22175345ad.67.1717074807565;
        Thu, 30 May 2024 06:13:27 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c75de6dsm117814885ad.6.2024.05.30.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:13:26 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
Date: Thu, 30 May 2024 21:13:08 +0800
Message-Id: <20240530131308.59737-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240530131308.59737-1-kerneljasonxing@gmail.com>
References: <20240530131308.59737-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like previous patch does in TCP, we need to adhere to RFC 1213:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

So let's consider CLOSE-WAIT sockets.

The logic of counting
When we increment the counter?
a) Only if we change the state to ESTABLISHED.

When we decrement the counter?
a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
from CLOSE-WAIT to LAST-ACK.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d44196ec5b6..6d59c1c4baba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 		break;
-
+	case TCP_CLOSE_WAIT:
+		break;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3


