Return-Path: <netdev+bounces-209216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E23F4B0EAAC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14B41C8068E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 06:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8464926E6E3;
	Wed, 23 Jul 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N58Frue8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D84126E158;
	Wed, 23 Jul 2025 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753252312; cv=none; b=LE4KgfUiHohSmO4yZxG2AXq+uT7PBlg94ohiRL/gQzU7+SI0+HCJwRYlb3RY0j1ROb39OK2WwioJB0rS76bmP0m8X5Qsp+ql18EiUeV0Y93k12yQBQ+Ui1Dau/cMV7d1KdrL/P279xyjcopgyMQpxoVRhUF8CRjjwczuucXBMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753252312; c=relaxed/simple;
	bh=7wPZzKUCutOWSDrN29iZqd2GuvbH5yGyfWNh7XiSoc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBqnfb25dDKZHdxcKrcDtWqua2GRBEO/ium/qgPjFEtKWKsfsRTNs5i3CkCKkQWxIxL9CPROpPxgLXA4K9bDDzD+EA6TooDx+jD8kDc7lB0d1nYr9Cpn3cdG9SZ80vfM/mUJaaE8b+S8hU7ZBmxky7HZsgOzTzeDx7nRC3RGoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N58Frue8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234fcadde3eso73562175ad.0;
        Tue, 22 Jul 2025 23:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753252310; x=1753857110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SlOsoYRFjhvvw2blQM4GdnqtjksdBcf86gL/ylrDtaA=;
        b=N58Frue8GpAggNLVNNrJ4SWu8aeRS8WVsuI+2HTExogOfLd2g8ZNEXBDDUVkFR3Xmr
         0ONizAHxer8YFl+/mYd3nC5t6G0AVElFHLrutMN8YGAuIHrPz/NEtHKqyI4hHpWkEDrl
         VCoWLMuSjm9xujJDAw3lT2V0ueKmcO20iX7vNrIAupq2UVE2qfQBIk8JRl2TmVFla/9C
         62zrTxx7nav+6IEZzLHVXqtM7Zz43L1CInVE5GL4AUMqVMxN0wtvzsmM4V8RncbiH1W9
         /cpszdq4QxxoWTVJD97syvz541FRB8zivbUjgig9yVASRwmAJVCe0T7uKJ2fJV//EosR
         Ygsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753252310; x=1753857110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlOsoYRFjhvvw2blQM4GdnqtjksdBcf86gL/ylrDtaA=;
        b=ios4hnOID97vdERshrY051ikEQ+Gk0juofFU+MGCZbShGjSoBCX7ew4TyLs3dbDuy5
         wY9IX1PzsUmrroig3l75XnSbDr7v81g0YzeQwdpjmNnHfoZ/EkM5CzETBcnZbk8DmgLt
         57H/F1iMa0PZYYHPm348l3WWc2rqOC9AFzKzTIBcS+btxh7B9OhYqNi1VzDeEeggDaAm
         4l/l8/XDlyYMikfQ8cHG1bpMROiJJT0QSZV7YIz43BUo9J657XvPL8hpFmcIWTfRaIkX
         braIRpjAKSwTtlcmd369rJKu59Cn09XzhtpdrzY0vNPN5F1AlRv8YosvmHWFuniZGfq1
         INxw==
X-Forwarded-Encrypted: i=1; AJvYcCWNCiGG7chuIXoElEdYjciccgVD8llwtmnsiDClxGFT+Z+yagSgpnmC+owik51luixSnRGJnt0Bph8Ay90=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6sYfWoCHeddb6oAbiHVUuQCByA5olMnH7f4yZon38vp0JZBO
	TKXGVXz80qKcdWdzHWHZK+BmvNM7f170Hb9zHmdC4/Aafq23llsLWd5I
X-Gm-Gg: ASbGncu2fxq9fzO1uNCMJ4vYbw6BwkY6vYe88mAIl3w0ibAgh23KeFeojvpVOPa9Xc6
	szL0z4n5m9NyrMHE68GoSTgsiDPqg4N9QQdo0FGSLFitPVSTKmlHebKWqId1jy1MJ94j5fWYvww
	Ynr9ZjHtzVjzJrdBeQpA7gC/QBejiaRrDSDOYK+UEuqQaPrpUyI7ih3/xXlQ+UHYQW4Kj0/PFj/
	jCPBcRiFQIGH/N58InpavKC9FY4wzopTHM6IR+n5n/dZBN3lM5IyHrNy/YcHyTzBbSbSpawvGRG
	v/pkyvxhkioaeDMWtl5iMtWY2TgyC3/6PWUFg4ftMdBETFw1L2kZUXoy8bB/te27pvy96cvQZek
	DWygilgYRFB57lR6xFjJ9fPVpUCIUxVT46C0o3w==
X-Google-Smtp-Source: AGHT+IF0erTYwksmGNUunkkGnj1FdxqYP5O20Sfan0hwnByjnUy7hQyyvyetFe4ESFwRrHY3wjoU6g==
X-Received: by 2002:a17:902:e845:b0:235:1966:93a9 with SMTP id d9443c01a7336-23f9812b4c5mr28540155ad.3.1753252310276;
        Tue, 22 Jul 2025 23:31:50 -0700 (PDT)
Received: from C11-068.mioffice.cn ([2408:8607:1b00:c:9e7b:efff:fe4e:6cff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e2ccbsm89826735ad.4.2025.07.22.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 23:31:49 -0700 (PDT)
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
Subject: [PATCH] net/core: fix wrong return value in __splice_segment
Date: Wed, 23 Jul 2025 14:31:19 +0800
Message-ID: <20250723063119.24059-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return true immediately when the last segment is processed,
without waiting for the next segment.

Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
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


