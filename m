Return-Path: <netdev+bounces-53598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20253803DF1
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CCA28117E
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2630FA6;
	Mon,  4 Dec 2023 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LJ1MGQVl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1C2107
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:00:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a186e5d1056so619368366b.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716454; x=1702321254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=LJ1MGQVlwAtkjU4Ku120jh+vw9q8rexA2ETFL/QP+d/i8tjeMk9bzZSmMhk3Cj7RXs
         1NTGAEv31a2k8mGm0RSMe6CRyA5Vh4r6U5nA665TYS2yug/w4bdqShqYTq07Te4bNbi+
         yX8ZCHjOeuOClFtMCBIIF622wlbmYWqLSmv4ji4DpGR61kqaa9bVPzmkE7oqe/2VWBAT
         S68z299WZJvA/bTCVUbRUD2d1MdvRRvQXLfu/taF17hiQNm49fIyyEWU3v+SppxJyHqN
         UT+yNFlKf0gWBLTs8lXbnjID7V08/E2a6ryQDCqzdVtTfcUtHu7VTfCvCNncNRdP/NWZ
         8oKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716454; x=1702321254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haVpn9fvl3FQKPXQqTZq8l5X+Z7fEQLSNTR+x6poikY=;
        b=fObj/a5WAR398ZOr+sAve9BoBcz77fgWYYWzSwKPFubizBlHWGr2wQVZAPlpztNtfn
         8zKUqpH7BEKZN7/2ScCfSQVOqem0ukgQGF9W4yK2ODdfxXYzCUYVDrph3ElIff58o3Sl
         /hWUNwZDwvIBs92fJgrLJ3blBaH62mBIMuaU+nCJ6whtzPdv0tNFzseYwW+Qv/nbzjUM
         ElcEr5yp2MYDNB7e/AeCcGs0enOMlkWDAXUiGElBQwtkxHhJJq4n+pr8vGGZgYGXf7RS
         aPLZb8nvcjnq1J3L4NlY7v3b0rDoRSGFxFVWJ6lSZ9WYoUshjqF77hj+N/mtcatGd7SQ
         mwkA==
X-Gm-Message-State: AOJu0YwGFdblfVHWZb30bMORvZhBQv4vzSquP5Uf30I3cNld02yVXS22
	1FT+LFujgxVnbZCZivjT+3j63w==
X-Google-Smtp-Source: AGHT+IEBSRn3oKvt5apwbQOiHdDXP4js5GvWCvcA+RT5ywwGc9MIO2ZiEaQ9HWp6znRjwgNDnQys6g==
X-Received: by 2002:a17:907:38f:b0:a19:a19b:55c2 with SMTP id ss15-20020a170907038f00b00a19a19b55c2mr3409428ejb.82.1701716454475;
        Mon, 04 Dec 2023 11:00:54 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:00:53 -0800 (PST)
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
Subject: [PATCH v5 1/5] Documentation/tcp: Fix an obvious typo
Date: Mon,  4 Dec 2023 19:00:40 +0000
Message-ID: <20231204190044.450107-2-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204190044.450107-1-dima@arista.com>
References: <20231204190044.450107-1-dima@arista.com>
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
2.43.0


