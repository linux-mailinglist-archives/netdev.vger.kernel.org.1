Return-Path: <netdev+bounces-50677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E67F69D2
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFED1281A33
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B78219D;
	Fri, 24 Nov 2023 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="etBESr/f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03410DC
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b399314aaso2435725e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785656; x=1701390456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=etBESr/f2VjgTzn3inyxg6UneJVdC7Fa4+ZseWqcIoQa8GewJeDwQDA3HYFuxRB7fI
         0LAxLNIUbwvexclfq8uBGaPwZSXlEiuzScqSyw//F7FjpdlRZ+ClBQ6nNQX/bos2V9j/
         JT5/CP6QKt1OJPinehlPoykwSwpt7MBEm/tr/WicarrcBYpV07aZYvetxz/EB98bYH/Z
         gQMQvCHBY8ldHRySoSojBfgwt3XCJsSrcltFcNMcpxB+Fs/xfF+vQdM2leIW3bTKD8tY
         95pj82MZTo9+nwfz8PYDV8HNfDBKrrUY2ozWng3VIafR0GYcaS2BdLZ+Hu/3dwtcmsEp
         gT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785656; x=1701390456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1zqOorwszBSy7715/FfAd+B6Hz5TxCnBSal1fxWdU4=;
        b=sbW53fi6jXKWkV1xbYuhXtBvdhsqH9KtdmQoduFfgDg1I8M/zlwgKf7vZ7wuPhRClw
         oII5ZvY3snLGBuCnHhnTxbdWugAl9K3cDnR1J9OWp1MHEXD7sqaKsr7F93BvnB1QZHpK
         PjCpPLaeWOa5rU2fQq/V2QZCjHOoUfP+6lQD+Ba1kuTGqNPq9huQ4RtkZBVLUL1b4cUj
         rFOqDba/i15g5eR29r6/HnuoYji2dmmHj+IDwM7BQYmrVPM3fIN0WfLEpkca7Ez7EuWv
         Q8yOLFfzZOwfiZEBdzZzFnJq4bjLf5TcfWpEGjB97mQbsIJksInVSj1T7zgoaWAP3/o1
         0hvg==
X-Gm-Message-State: AOJu0Yxqtaeyb74qTPblCWfu4G3nklBZKxYQoHNeJNJcqCUCRa+LGF2Z
	AteeTsf6c/d7HFCEEQt9MjjtSrCujCfC4G+J6cs=
X-Google-Smtp-Source: AGHT+IGZzgd8txvbEnx/qem7XVY1WoQcmi+WWFOs5wKmthWsn/NDewmniq56CwG6us8dLSqITcBg2w==
X-Received: by 2002:a05:600c:3ba5:b0:409:325:e499 with SMTP id n37-20020a05600c3ba500b004090325e499mr957416wms.32.1700785656074;
        Thu, 23 Nov 2023 16:27:36 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:35 -0800 (PST)
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
Subject: [PATCH v2 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date: Fri, 24 Nov 2023 00:27:18 +0000
Message-ID: <20231124002720.102537-6-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the connection was established, don't allow adding TCP-AO keys that
don't match the peer. Currently, there are checks for ip-address
matching, but L3 index check is missing. Add it to restrict userspace
shooting itself somewhere.

Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp_ao.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index bf41be6d4721..2d000e275ce7 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1608,6 +1608,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.43.0


