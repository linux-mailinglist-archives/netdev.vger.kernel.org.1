Return-Path: <netdev+bounces-100308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3E8D8792
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E8B1C21ED2
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB316133406;
	Mon,  3 Jun 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJHiaAL0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B41304B1
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434165; cv=none; b=iPenXzmui5J3f7gl2eUcuvyfQJ6KgsT7tHzNCsfes2onVolHLtILa4EEUlE4MhThRdm5I/sEHxMSImqFtSAHRjN+UwLvPUjNyQZnCuiXTs6NdD5zUbonz7u3C8en06PVGuQxa0QAeDoj4ilsUeTyevHKMDjemex1U2Gc+F7OIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434165; c=relaxed/simple;
	bh=zISG6yHAh6L1orzXgPMlwLk4EZq0CiQ3ktK1OzoK1Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LY7NFbqtugE4SAf5zH4XGM71hg76acEZBoEkTxHPZD9pP472FXf5DhnWran8rXU9PNbHXPa5Q0IoF3fFilr9cy8n9NfAZCBgiaQDTYYJGXGCQg24JZOwnVSebdpzGFQOWWrfWEqH8GOxv1HOyHgLpOrpGOy1wYQesEkcwZ5i19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJHiaAL0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f60a502bb2so1376775ad.3
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717434163; x=1718038963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUOdVRnefN2TG2DgKbC6vXDKZD70/za0tG8Wz0BIq6A=;
        b=EJHiaAL04mylVE+P4n03gkqrydt99L19NKOr9CWho1/5+dLaeRe9TPbjY6SfNSESXP
         5mdiSZJ2yaCqFfjPo1LVBVkvkGRxRktVfadoiN59lmh23eLqelWMCC46ly2eG9u19eXI
         Y5tP+FffH7zI9l5slzQHxYPJXm2x1DE0gRnmhI9fGxa13TX2Jiu72zfLoYU3S3eY93UN
         /ImWp3GOkHicbG+/KGrN6L95tVtSV6RdZP9WASXgaLmbLJyd4r0a2lebu6t2qIutrf5+
         PNUkrpUnizNT11sFOnvszNXLJXXzfhaJdR8o+qznkfdmTFe5I73AoSi0JIHs5G0ql0bc
         IwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717434163; x=1718038963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUOdVRnefN2TG2DgKbC6vXDKZD70/za0tG8Wz0BIq6A=;
        b=ocus/tQmf+cqyBcbnPs4baQN13QO0r4OJb5GyvRvLxlw7wCEDUzNgpRyX2UzzVnPek
         1WBraAA4sF34apqGASXm+IsVXvvlGneKpX5RSsAngDx+qWURt1kxSuo+U0sZWKY41dwP
         2BsACzBM6nsl5oNzfRwIop3740oHp3ATjGSYlktofwFHLouzDycfjio1OeszY0mnAXYL
         zZaKlrynqe+yQIlUQfp8+zobzsTxOom/8fGsEibH75HoYAyd6peMPocZwRNfSkWSLpZ8
         547Wf2Ckk66ew4Zb3KlOBM45vcq+y05TiC/KZlhU7rM1IIBzgXm6BWbsYHrDfmy2ZKGZ
         1vhw==
X-Gm-Message-State: AOJu0YxuYXWIVpVMWrNzYn+CSIEUqskkpE5u/WGkS8utpn5IibLAXO73
	LWYwaJJemAYoyKYc2afk4kQ0hnfdVF/vHdJqrdMFpbodiQ54Bs/R
X-Google-Smtp-Source: AGHT+IGoFO32AO0kxmqcKniiWCpHNyKylhFLcQXOZjP8QMHGyuhX0TJFSoxIbEpIvxl1zWJd63qh9g==
X-Received: by 2002:a17:90a:ad8b:b0:2c2:4107:1fc3 with SMTP id 98e67ed59e1d1-2c241073a8fmr2419113a91.38.1717434163398;
        Mon, 03 Jun 2024 10:02:43 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e577fsm6460431a91.32.2024.06.03.10.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:02:42 -0700 (PDT)
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
Subject: [PATCH net v5 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
Date: Tue,  4 Jun 2024 01:02:17 +0800
Message-Id: <20240603170217.6243-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240603170217.6243-1-kerneljasonxing@gmail.com>
References: <20240603170217.6243-1-kerneljasonxing@gmail.com>
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

Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/protocol.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d44196ec5b6..96b113854bd3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2916,9 +2916,14 @@ void mptcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 		break;
-
+	case TCP_CLOSE_WAIT:
+		/* Unlike TCP, MPTCP sk would not have the TCP_SYN_RECV state:
+		 * MPTCP "accepted" sockets will be created later on. So no
+		 * transition from TCP_SYN_RECV to TCP_CLOSE_WAIT.
+		 */
+		break;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3


