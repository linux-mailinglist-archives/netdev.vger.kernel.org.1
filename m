Return-Path: <netdev+bounces-49502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C27F2375
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D5E1F260EA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30414ABC;
	Tue, 21 Nov 2023 02:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="dm8J7qBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49398E7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40859dee28cso23817205e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532085; x=1701136885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRv390KZg85B3wbZ2TCp60L17ZYyL9mQWzXIk/oqbtw=;
        b=dm8J7qBSgjKUheRrTjDGEdwDRR/0fWw05/DnqQugslvUNkacXpJtXUS0IT8iJGb1Mw
         1NSHzihLf9h6y3oKNygxigaS+wqy+P7IfFZ5kQX25qvz+AiAkYNd3IvEXpoGpoh5koW3
         Q/rrR9Ewb+2LZXEW5MeTh29mNYU2aKzou37pHVDBhKXUUZMNb6djJT+7abDGihCC1fep
         2637JzWf+8cf+ob/GQlJoNi+XY5C3jbXXFE6/S8hMYBWjCqMYmw1DkfWTi5lOaQWNR/Y
         XDYY0OozDJO4W2axIBtzrn7D/aDzbSV5U4bzk+VYWrYcijdJ3ePqxtW4oPRm/BoWBMyP
         uocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532085; x=1701136885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRv390KZg85B3wbZ2TCp60L17ZYyL9mQWzXIk/oqbtw=;
        b=MGhNcQ82LSiS5lf7sLsXPF6340gK28R+uStkDFrk1Z2p7e/zK/DcFo4xW3BchKVGJ8
         KhiyK71gyxIEcgA4vuszfrQZCQsoE3h2ih5Yncb7C1kneaPdybFPu/ZTSAPajNitrU81
         uDDwzChVk/BEXKXXrkYoxMxj94/Yds1JZ7NBcs9J83UKXmFjQwruNacacd74wbTU5p9V
         RyI6v1EG6W3G9NuqsTf8memxq0QKBoMmWFJPBcb9C9PXk4gK7iDzuv/NGaXRtntqFVXu
         9IkTjJiH88QgMYu5D3liGEXSMePxM//4FXAzVpmSacDXUKHgi/98eB6fRfm2lM0lbfu0
         OG6A==
X-Gm-Message-State: AOJu0YwHbsGbnwPiMwk61YkUcT1kKJydRngKb4tgYGGtAKbwcKlK1W34
	WwBUZ+k6Cl1ZmbMd0NqkgORyWw==
X-Google-Smtp-Source: AGHT+IHmAhpILijZy4DBKFQ50xDkp/1JWygHEaw2KLxD4bp3sk2gYc+RAFu6ZFb9Q4bdj006JBHNtg==
X-Received: by 2002:a05:6000:1147:b0:32d:a476:5285 with SMTP id d7-20020a056000114700b0032da4765285mr6146461wrx.31.1700532085689;
        Mon, 20 Nov 2023 18:01:25 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:25 -0800 (PST)
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
Subject: [PATCH 5/7] net/tcp: Don't add key with non-matching VRF on connected sockets
Date: Tue, 21 Nov 2023 02:01:09 +0000
Message-ID: <20231121020111.1143180-6-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
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
index 71c8c9c59642..122ff58168ee 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1622,6 +1622,9 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 		if (!dev || !l3index)
 			return -EINVAL;
 
+		if (!((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
+			return -EINVAL;
+
 		/* It's still possible to bind after adding keys or even
 		 * re-bind to a different dev (with CAP_NET_RAW).
 		 * So, no reason to return error here, rather try to be
-- 
2.42.0


