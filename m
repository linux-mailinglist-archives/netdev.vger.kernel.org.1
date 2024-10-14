Return-Path: <netdev+bounces-135260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E9E99D398
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735DA1C231D8
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D80B1B85F8;
	Mon, 14 Oct 2024 15:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Vad1vHip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A95D1BD01F
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920313; cv=none; b=d0BlHqQAnrJZk+cK8MZRdzoxZLbL0Rc3ki+8vYIr85ky0qfaHbkOKZwXkIbyvsUIZCbgSXQllECD6iRPzaddCnSYm/o4daK7o+Kchwipowywg8Vso+NKrTlhZpVoTCDELP9D+Xm5tPCCPMUOx4ndKHeoZ6qAIWCxlIlJ+1T5Cm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920313; c=relaxed/simple;
	bh=VxIucDQGPpRIS63YRPMZymbS4KIO0Xi6qKhd8KI+CEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YDgwAdFaiX+u4deaqemutxqezcqhlaApSTn69lH0On9QhquEXLc/5a4reInl+2708t/+iuQNJFK+PCHhGO0cIulMbPCgqWDuhjEhnOYQ/vY3y3aPN9vlNao7+G2FHG65610suD4GGkPQU+qtWN686Ch1scDYj0Iym4bWktPuMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Vad1vHip; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2896448f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920310; x=1729525110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6Xk7yX7Ph55Lc4GYMDFLX+bnVww2jUFr9G7tdaf2DM=;
        b=Vad1vHipC/p2/XtODd31RqwRkdJZEMHRVgRy9SG4NqIzw1iQazmgdAiU4BluBxi13O
         ftd3QpSLOHPqR++Xq91lCMX5jl1KHqq+pILVUmMwKHrAypQ1BQmsRoGfkirLF/dZqKiV
         McsooJuI1ae0ZKXKTeDZv9PtB34ff3ZYUsX2irH515TPamHMYR9uPxkr66Tivz0kJlGh
         LJOfy+pzwCFZleHT5d2X3rfkWSc2X//UmxQ/6KE87y3twdOwy0wAa6E6NDeIXNPeqSBz
         FwUjPSZ4QY14yW3hxgOda15xCEpEgb2RbDLPp3tDGtTp+fQ/wHe6y3hS3N2MmorCWg3E
         u+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920310; x=1729525110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6Xk7yX7Ph55Lc4GYMDFLX+bnVww2jUFr9G7tdaf2DM=;
        b=Pw4PSQu5Nt1SwFfFiEOAx5nYBQifpSrldkK06bFDr78WdFUuOS/LqxHstK5OPluxmp
         Wu0LNdoJIPOGkCHtaY7U/N/hYjtqAE+0Lw94PWNmbPlFLGvI/u47ddP9TzErDrhgoOd1
         rn5YH9o/tyxkQKqjjWlUfeemWRnXMiHUGERGDooY7dMTfA+61ut8c8k+bDYEoEZVGo90
         IjoXiTauURirlFukutYfJbUvAzq0FMddkXLl4DcRu1DjNiijpISlPaHvHRkycpHyQa8/
         FQ2Z3hHoRVL6GcKmG7MZ5qDnl/fTccNHxCs1vrXvfD2kfkEDn7dD7vD0QH04HTaktZLX
         JjFg==
X-Forwarded-Encrypted: i=1; AJvYcCX+fCFajzjroXWnKbhCCQwkgORsVS59xSEwvKS0ZUqMYtXYHyEolLHSdNFCy2DcOly5ivOFXsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UU1uxMnZ/1/PvtjnvcUOGW8nUQTeT1L/vbc91HuFuV2CVCY7
	PZXuzOzQkenAY0+o//FY52dtT8n16RaxoPs6m9JniW1ADeTCFFtS2fuVcol9xfo=
X-Google-Smtp-Source: AGHT+IFOjny/ZC5vM2XSWOXaR36r1j+H8geu/8duRN5SiAObjYA/9oL5xKSu3VUf7L1WrDRmThqGmA==
X-Received: by 2002:a5d:6687:0:b0:374:b3a3:3f83 with SMTP id ffacd0b85a97d-37d552cb66cmr10142454f8f.53.1728920309727;
        Mon, 14 Oct 2024 08:38:29 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:29 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH net-next v3 4/9] net: af_can: do not leave a dangling sk pointer in can_create()
Date: Mon, 14 Oct 2024 16:38:03 +0100
Message-Id: <20241014153808.51894-5-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On error can_create() frees the allocated sk object, but sock_init_data()
has already attached it to the provided sock object. This will leave a
dangling sk pointer in the sock object and may cause use-after-free later.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 net/can/af_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 707576eeeb58..01f3fbb3b67d 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -171,6 +171,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 		/* release sk on errors */
 		sock_orphan(sk);
 		sock_put(sk);
+		sock->sk = NULL;
 	}
 
  errout:
-- 
2.39.5


