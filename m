Return-Path: <netdev+bounces-228424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E0CBCA61E
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E77AB4F8A1D
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 17:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D69C245033;
	Thu,  9 Oct 2025 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcjPQAnr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564E2556E
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031188; cv=none; b=LX3/Q2FeUx/rqEUxcGKpFwIgPBSTSK+du2BtJrZ6oizKrhhBABZMr8E/dQGoEngedo7IDoOTtmJ2te/X05Oq7RIZHSoFFpkGmzPQvQrD3kp0ka9gi3PUYA2FVawe3GuOK9n8TrrjjfcatZJazLCp6pZFzTeUgNxGzPZSg4uwyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031188; c=relaxed/simple;
	bh=9vAUJTKDsrddX0ECgsQNxyK2CN2AgssZKpAoBZkq1Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gA20NI+G1c4fN0D8x84NKrXhZdNFDMFwkMRlJVbCmBXwTK7l45qdMIb4IXVr66mX/GEau3lU+YK/zT+Ji9/JnzsQgSyuHzBNtPvUUvV2hwHSYpGMA0+XNcQP8n2vtRBF+rhohH3HClLbizat0SvLRs7w6GhfLuu0phTCTdh7KNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcjPQAnr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57992ba129eso1418453e87.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 10:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760031183; x=1760635983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLxztCZhFqGeufXzkuXXus/JxbN+hE9UN/bbCDJgNrI=;
        b=VcjPQAnrGgVLeBRfC+uuXGk9pbzHCz+TJp+w3cYNpnU0m8UPJy6bEP8hXrxK2eIM/q
         iCzmNuIjzPH/NF3o987LmRNMcmPBiwhaeWtF6rYhzZK+TMltB59RykpDq3+MJ6AsyiCb
         mfa6J0Jqx7t9SLw8elKeYanX6DmmM64op0Isq71miJrarJPwitzOxZ9ns5FyN+A2wmID
         7iisjgbsvW4XK6na7u0YUt/ET4Lhpmr63SmF89zbwle2su0ylDTnQvfqIqvbp2SvlxUH
         R0j0rVJ8FuirNgR3EhUfnaTvOYVzpNMLnxq87Z1CLxZJvgsWlKXMWWFL4TAAp/RC7weK
         iSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031183; x=1760635983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLxztCZhFqGeufXzkuXXus/JxbN+hE9UN/bbCDJgNrI=;
        b=j+BZ4yJmPZZI7VP+HnA9dT7qopepiow6RkjUGcMQ+aJi9s5YV88H2iqK0LpGqujOA9
         X+1gNZ9ZMbPQkc053UUl+I1oFZurV9Q9N8Pz91g1av/OCpzsUAhpHaTl244dT+3ah9mu
         /BQTAAttLfvMz9qOFul3+MXur9AYSj+QsGygrulNHeew8WrPZotnnF/b1QyeodD1qklr
         d6DUyTN06lYgT7+LtySSwloXFapz6GxLqqiY89qyZ0ra9EcXnTOijFHjcdhrMulJPx5L
         HYmftMpg2YvcFzMhvwcTQxxfxNbFTGWddMZaKHL1avVqLnikYDB0OsjMydravlHmdWf1
         WN7A==
X-Forwarded-Encrypted: i=1; AJvYcCVS5KluFUWOJvZN38kzMn1wR87zw/Q5/+WZfwdhCYkOTVSjHoMgyqXioDXFfD3QTmzk+FnJhCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG59j7+62Hr8CTJ1akAdTsmUpK5xN5EN3y1aVEISSWs09Db6HD
	KuAnZ6rGS23HnuslThD8AtCvJ4FPXc3QM3psqbxdul0R/TjjJuwcHXNl
X-Gm-Gg: ASbGncsnk3p2znDCTWDklCrUz2AuXpSKrfwvl1hHeWRcZsUi1512WSax3cW/KNb7CAQ
	pvsrqjMG7gHZntBmwGC8zoqpylg4ZFYcJSUjlkSSJ6ZtsOz35bx4oHwya0SLuoQVnT6z4By5itt
	fg6BR1Neto+5fwNQi3SMwfIeAY+xmaOczR/uQKwl7aDx3l5x9dN1Vwmymw97HuGoprNLAEfVYB3
	i4kbt5QqlhPLfKn1EFyXzcoaCD5xV+EVQFSE97j47o1hf66k+oW4AUMXCoSPslxUgXxRCWVXKnX
	w9uMd+gh0tpsBgh8m1sWRro/33N0mwr44eG1B5q7l47lf8MqhhNeR3WACVni3tmUi4805duoWU9
	0Tn5pTHDyDcDUT2YRfmpZ2iwi25mk8z6JJfB1nRwgmP8R4ORdMkjz/fmhifA0W5T3tpHRJPTcTQ
	==
X-Google-Smtp-Source: AGHT+IEvKuMOdYtRvPFBMg7RxLA8EnqpMsXl9d+MHkhe21lfjfclec1AQfTv2w3cGrLhXn53i9/gXA==
X-Received: by 2002:a05:651c:982:b0:362:95d5:3858 with SMTP id 38308e7fff4ca-37609cf837cmr25479361fa.3.1760031182940;
        Thu, 09 Oct 2025 10:33:02 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59088577c1bsm26239e87.106.2025.10.09.10.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:33:02 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] sctp: fix null derefer in sctp_sf_do_5_1D_ce()
Date: Thu,  9 Oct 2025 20:32:49 +0300
Message-Id: <20251009173248.11881-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check of new_asoc->peer.adaptation_ind can fail,
leaving ai_ev unitilialized. In that case, the code
can jump to the nomem_authdev label and later call
sctp_ulpevent_free() with a null  ai_ev pointer.
Leading to potential null dereference.

Add check of ai_ev pointer before call of
sctp_ulpevent_free function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_EVENT")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d787..93cac73472c7 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -885,7 +885,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
-- 
2.34.1

I already have sent this patch from another email, but
he wasnt applicable since company mail server corrupt
it.

