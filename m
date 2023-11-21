Return-Path: <netdev+bounces-49497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410AA7F2368
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B701C2163E
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BEC8C6;
	Tue, 21 Nov 2023 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fL8c107b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96744ED
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:21 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40839652b97so19539705e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532080; x=1701136880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tx+xbR7vEy8WvypRwvrmxjfGzTQ6Jn5Kk2hdbYBJd1Q=;
        b=fL8c107bXMmME29r9Xb1RTi6RMMSXEhkw+rLp7U2zQhu85/QVhH71RNmBuK2EBpkYd
         ygdJ7KiN9QhI3AC+kjseww52CcUhpmq2z3Q5uCigxgCzPPjPkoH/G45Bzfz398/VNi3N
         ulNxk/tW03fAmU7852yNBIoF+YwauXcmDzmNW/gbYp09XYOI5lhV9bCuYf8+F9l+reNU
         zS04aatpJSkHZ6p2bPTTnFikRrSoatV+Hw6ZdvRAy7aryd4lbv9kH/tLCiC3uQL4/BO3
         nOmlFMFrqvl/QYn8cdbOmpAEvYWAVQDu8H/LdoG7s8HuATOU9ZGm47o8B6ljyH1u90Jr
         3/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532080; x=1701136880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tx+xbR7vEy8WvypRwvrmxjfGzTQ6Jn5Kk2hdbYBJd1Q=;
        b=IkSp27tmVP1TlkvPpUvYGALIsAvHf6/k7mcX1wbSDMGfpd9upoN3LhptWkEYmel1sO
         UafBtnSPHmc6x+20IbQKTe/cyxjpboHh3XQTrC9+y5iSuXFSnuZTdyNqciOlXghP2H0a
         ZUcJsgN0rv61xEk62jxUfg+Qj4crBlUN7zasNv6sqNW9+pD5JdvnU6KOOLJiuEki3DlK
         anhWAQDvm+SVcwJv104XLHbeYWvnJKvRlM5ZIuzbnMf5MUbPSTBZs1yOMXOLGAu1mSw7
         HVwx+dSfEEPaieJ6gFS5f/wnDh9lc64ddRs/OjBKCma01W11IrWKy0HGTZx0IgRN85+S
         1b/w==
X-Gm-Message-State: AOJu0Yxneo6FGvx47EjHD9B6Xz/2ctUFu0BAZP+pNVA4yi6CkZQ/d4kG
	uyA8kmwUJNOiKmQN9UZwMucb3Q==
X-Google-Smtp-Source: AGHT+IFKYDDZbYD7cqEdBrYbT7HZyrZmC0KpUYqH0Iwjou5g1nBYVJ4Qi5oQbDlIMr0oJ/5Pz+iE2Q==
X-Received: by 2002:a05:600c:4fcc:b0:408:5ba9:d707 with SMTP id o12-20020a05600c4fcc00b004085ba9d707mr8592956wmq.16.1700532079960;
        Mon, 20 Nov 2023 18:01:19 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:19 -0800 (PST)
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
	netdev@vger.kernel.org,
	Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/7] Documentation/tcp: Fix an obvious typo
Date: Tue, 21 Nov 2023 02:01:05 +0000
Message-ID: <20231121020111.1143180-2-dima@arista.com>
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

Yep, my VIM spellchecker is not good enough for typos like this one.

Fixes: 7fe0e38bb669 ("Documentation/tcp: Add TCP-AO documentation")
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reported-by: Markus Elfring <Markus.Elfring@web.de>
Closes: https://lore.kernel.org/all/2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 Documentation/networking/tcp_ao.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/tcp_ao.rst b/Documentation/networking/tcp_ao.rst
index cfa5bf1cc542..8a58321acce7 100644
--- a/Documentation/networking/tcp_ao.rst
+++ b/Documentation/networking/tcp_ao.rst
@@ -99,7 +99,7 @@ also [6.1]::
    when it is no longer considered permitted.
 
 Linux TCP-AO will try its best to prevent you from removing a key that's
-being used, considering it a key management failure. But sine keeping
+being used, considering it a key management failure. But since keeping
 an outdated key may become a security issue and as a peer may
 unintentionally prevent the removal of an old key by always setting
 it as RNextKeyID - a forced key removal mechanism is provided, where
-- 
2.42.0


