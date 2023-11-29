Return-Path: <netdev+bounces-52200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2259A7FDDC0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5FBB2112E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B783D0C5;
	Wed, 29 Nov 2023 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Pv4S8DPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB4CBE
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:35 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b4746ae51so28356155e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277054; x=1701881854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=Pv4S8DPZMX5/yJB6NyJjYkxlQmb6aEawoms8eFOetLImorKodqBHQbb4dRD9ES12ua
         xxEkrlFkMLaEGLDY4ygW5OAE68wVYm3/cGKPZR3qCE1r0nspXmSlgEKKR2+lge3lcpjq
         aOXEwW5xrcvf45wyHz5L1MzvN0U9mcipwT/PF3jBPiM+k5vb1S0NuwWb1A1y7TINcZF6
         aOzeNVzSFw+VRIn8pUYuPsV0D5whxrSE/skGnNEB5X2+dQH/pO5FEVRI26iWXlU+ZTrg
         nY6nilz2Ewl5HUk7Bm6BZ/sDAQYVo2Tc459NTJN2h7bQXnP7fqSZtAeNKYqi+ZDSP0XP
         6CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277054; x=1701881854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1xPXn0VYaTrAb1Nt5Hiecyvp9SYb9ivj7o6hsBOhvw=;
        b=GY8E0B6wTaEOvr7LdK6ypO74tl48QKZmaBqFtPEo+77TmBb88x4SDVdySMKoLi2kav
         rXv/F6DBhp/1dfscLopfTpf8YhSokIB0RyZdsN0R/KwlCMU+4BzoKCoXddEhSEegnYyv
         IpP3seCOenLR1w+D7dWgRTAweuuMDsjMGjspT4ux/nWvK/3SupUPG87IkBXHxG6BjQXD
         EofMwN0CzN6rLKzOLKftJX0KySVEsGiI43PbDgBm0NAJPbBSekeTgEfhCvnga18BRSwR
         s8VDy5wxuem1aj4RhS6TM3lLUSJAafr5pWEJTMUX6NrV3mfkzgFJ7vvJW8ZUrFvmDs00
         dQWg==
X-Gm-Message-State: AOJu0YxswOUi8mF/muObUJVwMTaSucYC7b3HqZ1jNywcQuGx2ldjRtPM
	DD9CfrVvKSSQ/aQhik+qiEPwpA==
X-Google-Smtp-Source: AGHT+IFv98Y4Evt6w+wZRYZ89u3q4f4c2LuS+DT8e2Kj7frzoOkMGoBzs8DH8FfxGqGxmfUrJaLBlg==
X-Received: by 2002:a05:600c:4507:b0:40b:338b:5f10 with SMTP id t7-20020a05600c450700b0040b338b5f10mr14391772wmo.32.1701277054520;
        Wed, 29 Nov 2023 08:57:34 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:33 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 4/7] net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
Date: Wed, 29 Nov 2023 16:57:18 +0000
Message-ID: <20231129165721.337302-5-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP_LISTEN sockets are not connected to any peer, so having
current_key/rnext_key doesn't make sense.

The userspace may falter over this issue by setting current or rnext
TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
allow removing a key that is in use (in accordance to RFC 5925), so
it might be inconvenient to have keys that can be destroyed only with
listener socket.

Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index c8be1d526eac..bf41be6d4721 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1818,8 +1818,16 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 		if (!new_rnext)
 			return -ENOENT;
 	}
-	if (cmd.del_async && sk->sk_state != TCP_LISTEN)
-		return -EINVAL;
+	if (sk->sk_state == TCP_LISTEN) {
+		/* Cleaning up possible "stale" current/rnext keys state,
+		 * that may have preserved from TCP_CLOSE, before sys_listen()
+		 */
+		ao_info->current_key = NULL;
+		ao_info->rnext_key = NULL;
+	} else {
+		if (cmd.del_async)
+			return -EINVAL;
+	}
 
 	if (family == AF_INET) {
 		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
-- 
2.43.0


