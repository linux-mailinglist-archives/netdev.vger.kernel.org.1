Return-Path: <netdev+bounces-209708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50381B107C9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F51546831
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2BD26463B;
	Thu, 24 Jul 2025 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcltxR+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93901C84D0;
	Thu, 24 Jul 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352991; cv=none; b=AGFJo+pJFqDw1lplJsP9FhC8oEQYtKESTHw2sBo0VR8zI7yYvkPC34GdQUvaYPKi43mWM51ZGyU9LMzISGnCk13xnvV9cdrWfNOi+Un5yhZsF5YtGNlb7ktlmgy+lTaUokZbDEIAy4JoA/ZI7a9L88Apr/GMJpzlXfX6gV+aE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352991; c=relaxed/simple;
	bh=YpjwabtrvrTpAQfGWaKcQKAcqs3OTRvnI+Zze8Cm6Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cua7LEbWKhz2vFveKN9UEOVOBDIzgTm16WVlcG89vB7BeWJoSdSDD4uZuok45wwxjwEiXswJfzhbW7TqAQI1YSOrfEzBUnykKAI4EHxvXqW30MWQBhbBs9EJPqaDALfQ/neewaqBVZ88VEj4qkCZQJc+nWjGxd13ydsMFtUGZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcltxR+l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2352400344aso6754645ad.2;
        Thu, 24 Jul 2025 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753352989; x=1753957789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=go75kCuhuq2zLowfD2sg0fvWZdvcOHw8ao4aGb5tX7o=;
        b=UcltxR+lBdCUAey+c+/V0g7U260E5W0UshPD3iyF394IXcZ+qsbWPLZ2g2v5AoTekm
         ODj9sVSNUL7fGSfKigw/I/0E21YrAzyAIkkz1bnHdoiL84T1Cv6ajcu8hLhwEe4dc2vW
         08dC/jGAuoAOrwB3oWuV7tNIPhhE/N8j9cZUQMrmAzrheaJvvAYTOIE6cfDJagfXOnz2
         lbb8dUyz8Y4vcTSJFSAcpTrhKwGDXyfaua6ZKtHDG6gOVkLiSC+tkYC0zDVGnk4/LS9F
         8H+ZQEKEfyDftI2iFVJ7gVLlSrrf6ruA+C386SeiG98Bt30UMq/D7Um8M3coAAjYCg+O
         6WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753352989; x=1753957789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go75kCuhuq2zLowfD2sg0fvWZdvcOHw8ao4aGb5tX7o=;
        b=MU8DGuFJFLOvtgbXti5ifoiiui/ZMeuE0E2RdCo9sQhJduN6U2qv5AQNIG1zmKC/FZ
         idFqpynEvgjKPr5W6XzbnvWwKsK+hz/Gh9tt9SLUWMabWqZLJLSTlJV2rAT/X11+uX4a
         H/nJZe+UUVX33Tsi7JoppyBKnRRYBoc3aeQ8VH8j0zIPdO8NU5v7dUbeOgOaj+qnwfU/
         90loit/tQ13y9TQlgF6mYTHbdn9qDkJ2G8RniOMpHDF4ra+XrFVQmSms34a9VGIK46jM
         OBLg5QCi82yedqL8mhvAmdULoOKJNrOEuAryHqxqyM5bhVPyeEOR6XmX3fhEPK5zwGXh
         x6rA==
X-Forwarded-Encrypted: i=1; AJvYcCXDRqurodVT4TYFsrgZegX3+Wq9POsoSuwt4zOVckWcA1vkD9KPq93zvACj93Tb7wVGpqiq3gGqZXjCQ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlRupd8wHAFOk0E6yvPPXzzcsWas5LTC46VVnLdshqC7YRiyo
	KZNuvs1i+Xs8alXXvotR9cg/fDxxuBeadalpLE8ENmPMXMmD0OsI86rN
X-Gm-Gg: ASbGncuMjqhj7+ok6TXe4/2MjfhV+oS+j1m1XOCg1O+5lJjzf2ISBzM6y4HOtQNv/m5
	F41Q7k9dv4kxhQGqfGh4BV6IzYkVK9rNn+prZITlg4PoQ1Lbejk+UB1PSrftU6km4H2KO5gqWg5
	qyROsckLSVrUTV29/F/PvTx7tXLHJWLC02AvlyAHqQLKo6C5IqUc6ZcEvrcJT4g8YEHfM0J6LpW
	zhmTvEgFanGjUzvEzQURkFBWaU4bRFQrY+Ho5lnns5CivOc7WrgNYmgKXHR7ojATj06EF20Vc78
	lZiAgoX2kOdxbOkatKdN0iOvtxyfqF5a1d5Ql+fbfRShyrrgzIEasN2fFqLdpblSoHiBek2Htpf
	52cSVeb+nYfBvKO58dGcGL9vw9nlkxoPuA7CCFA==
X-Google-Smtp-Source: AGHT+IH0WrteCuOt7q0R3GWfqdTnSH0PtK3VeK3mdr0R4Hfn157VsVbABOgDH0/CtI+R/uyOGH1Gsw==
X-Received: by 2002:a17:902:f650:b0:235:f45f:ed53 with SMTP id d9443c01a7336-23f9820366cmr82654595ad.33.1753352989038;
        Thu, 24 Jul 2025 03:29:49 -0700 (PDT)
Received: from C11-068.mioffice.cn ([2408:8607:1b00:c:9e7b:efff:fe4e:6cff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f8a0sm12468905ad.24.2025.07.24.03.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:29:48 -0700 (PDT)
From: Pengtao He <hept.hept.hept@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Michal Luczaj <mhal@rbox.co>,
	Eric Biggers <ebiggers@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengtao He <hept.hept.hept@gmail.com>
Subject: [PATCH net-next v2] net/core: fix wrong return value in __splice_segment
Date: Thu, 24 Jul 2025 18:29:07 +0800
Message-ID: <20250724102907.12159-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return true immediately when the last segment is processed,
avoid to walking once more in the frags loop.

Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
---
v2->v1:
Correct the commit message and target tree.
v1:
https://lore.kernel.org/netdev/20250723063119.24059-1-hept.hept.hept@gmail.com/
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..cc3339ab829a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3114,6 +3114,9 @@ static bool __splice_segment(struct page *page, unsigned int poff,
 		*len -= flen;
 	} while (*len && plen);
 
+	if (!*len)
+		return true;
+
 	return false;
 }
 
-- 
2.49.0


