Return-Path: <netdev+bounces-167357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD3CA39E66
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29353A2CC2
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B50C269B0B;
	Tue, 18 Feb 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tssv+/zW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF53269B02;
	Tue, 18 Feb 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887930; cv=none; b=t9MbxJu4awrX9dZlQTw/wMe+Od+ANSSamxgIZ0xMqabtDjYeYnTP2+lDUEbvjU94KjI+MD2li85dhf53TVVNzvn4OENGMdMWfockXSbagOFzT0uitoG7erpWzW5h5FlCjKEH1OARjMTFFTTiQ73QoPTvNhZ38umETQbvlyIKbWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887930; c=relaxed/simple;
	bh=5CvKgXsuRBvmykHjC1w18/8tMhy23ucUvHmtEyE59+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ExN2w6ndS7WXRMGt5eSWCmfir7sEzsdKucTb/JeESS/jeNl5LWP+pZp+PtV7irn2xZD6wyF0TkkTjQPL8cuhlU3wPzQy8Wq9kfsipIidJntEXN9N7haBy1juM1E10/76TBYi67tmV0RILmgcMGiJ6OU7vZT6refllxDlr1XUhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tssv+/zW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22100006bc8so57117125ad.0;
        Tue, 18 Feb 2025 06:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739887928; x=1740492728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfLraw7a+Ajw27pFw30ert9XFd7ZiNuKEHFKLdTH9nY=;
        b=Tssv+/zW4j1t5S5ejQYPs3zC/PLPD626jrZzvrlBL6jOO/JlxtPOWXbAi42frqJhJ+
         1N50pLNhtKdFIlH3r+JC/VeeYof0Mk/KgFNTMzRC00c8x59/AeFu3yzmPO9CZbgvocIO
         /wfX1/bOP/B2+aVvt1+aqV2vzwc5yR/hGkRlfId6M7nUl0IrtHS+sIT57GScuyNEQcwt
         VQvXUe4z4wBfSWRjRpOx5Kavb7n2tapVDLR8rxwA7m0qLGSbGQnfXLnjG8qvqeAq4fJ8
         BeQ7XstgGZrAdNmNDSX6EuCtzyAhVw0B/u9SBRi4NmIOnT999nK9UBMJJkvjrDZbcDEY
         ARtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887928; x=1740492728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfLraw7a+Ajw27pFw30ert9XFd7ZiNuKEHFKLdTH9nY=;
        b=OtSt/DmLYaJl8D8fgu6JM8xuJQVFqcOr05BcfGojK2hrIlCW1CbbaeEN2VzBJ3eeW/
         d+SWnuae8aBE0+J/qp3Z+j8DEQSEtSgOPJFPQB06PTDnnjOmPJVCkiSz323Iy32OHzLP
         2fMBTsmFEJypLyX1uux22XPasrN3Gh/P4ArZbGAhfqAeNYFlKwqfr+QxPubhrz3Tv2oZ
         o5s9ClUhXLPGxs5hI4oUBV+LV8ViriRmo2tNvNGsWnL+/QJt+dDDe6aUBnAmoovfVbdf
         p41a4KRCXg0uxTv1DtS/Om2CQGz4zZARnAjgcjQ8yW1raisj5zL+gbbWdheu4/vUCB0E
         X6YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYNn63zeiONi2Lke02Py3BkiAREFHKaBDshqcNhE/5UBkxR4efrd4lwPYybieNqrThEsFFgRQb@vger.kernel.org, AJvYcCWsJioxfbpvjFAEnc5moLxGxwEd8FDfzKN9TB2KcSlnZaiYUDphUJIq8oDZ3rSy0KdXv9487jiu9wUMw8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXSFuaQAWTZzIeInTflgGPnXuynlqmQ3R5ZtUqBrP8rNuQvBC
	sX3KX9GOn4U+bK5beh7nratJbKTiuNOAzln3/qxZt8W6VKhouCJn
X-Gm-Gg: ASbGncsoUY7qRD8SJveWs0zOov1ldjydDaUVyrTNchUpV9eJgv9HAdx58LlLrR4/K9o
	LQn9IPzjXyQ/vCSOfgA49Sa2GOUrmUCWJGplPcYXDLsL9mmp6b/MZqtuq8Uy7OyCY+U6hUD7LHP
	uZSYOhYft97+UbwVDSJV7Goxai8ik3YOcWmGhgymnhxcOxe6l7SrTbRIRQ3Ctb4dQs9X5pOKm2d
	GyXI2Dqeww7jYYXuMLKtmfovwJn/v2ERvpbLOGh/j6mTQGz6nfx9tcxB2PX92rHYeiP0zQUOvFa
	lr8y9Aky9di6wyPYazSf0XJ8lpkseIl2o0bVl44Bv9xVlA==
X-Google-Smtp-Source: AGHT+IFfW78URc0uKz1eSBulFF7DfLoan+pw0pQkguvlBz6MSHawAy10c5CTqETdC7D9zNjk/soOZw==
X-Received: by 2002:a17:902:e890:b0:21f:6885:2b0b with SMTP id d9443c01a7336-221040697ecmr220368935ad.26.1739887928258;
        Tue, 18 Feb 2025 06:12:08 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([152.58.43.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d608sm89396885ad.171.2025.02.18.06.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:12:07 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: skhan@linuxfoundation.org,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH net-next v3] af_unix: Fix undefined 'other' error
Date: Tue, 18 Feb 2025 19:40:45 +0530
Message-Id: <20250218141045.38947-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch static analysis tool where an
"undefined 'other'" error occurs due to `__releases(&unix_sk(other)->lock)`
being placed before 'other' is in scope.

Remove the `__releases()` annotation from the `unix_wait_for_peer()`
function to eliminate the Smatch warning. The annotation references `other`
before it is declared, leading to a false positive error during static
analysis.

Since AF_UNIX does not use Sparse annotations, this annotation is
unnecessary and does not impact functionality.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/lkml/20250209184355.16257-1-purvayeshi550@gmail.com/
V2 - https://lore.kernel.org/all/20250212104845.2396abcf@kernel.org/
V3 - Remove trailing double spaces.

 net/unix/af_unix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 34945de1f..319153850 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1508,7 +1508,6 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 }
 
 static long unix_wait_for_peer(struct sock *other, long timeo)
-	__releases(&unix_sk(other)->lock)
 {
 	struct unix_sock *u = unix_sk(other);
 	int sched;
-- 
2.34.1


