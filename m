Return-Path: <netdev+bounces-183747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69625A91D3E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0493D1887745
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A272248875;
	Thu, 17 Apr 2025 13:03:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787122472B9;
	Thu, 17 Apr 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895023; cv=none; b=kzb/HM3rEx71LdwWZ9TOnqyfzr+icuGIhp4HpxEqIGKWEhDrlJLECkVhi+gxOlNhLJ6RPZ3XKbqOygGufWjcFOzbLsKsGyVGOrApFcQkUDXhuq8OaIABLMQcbZP2JWoMsWWzn/J9WW+ICVGgeKkacsJlBKRXyvztQ44deYkXP5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895023; c=relaxed/simple;
	bh=dW+6ehsddfowqd+OBwDcpHmbdIVY34PpDq8DShV0IwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFDuDeWsZQ2PhIS5/BH6vNKMb+1gmn+yl5bw1LHCGL9wazRduYbTTOZZd1MoFo84AoWn52cckqUoLSSsxyNwtZhAnekqYNSC5dlc6aX7A7FJ7rWqIO3MPnVaI1PGvVSk1aa0Wiom163a/iZfuTu1QwAvBYD+0Rwq09j1RJjO1iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac289147833so135916366b.2;
        Thu, 17 Apr 2025 06:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744895019; x=1745499819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGtHcgI2ZJqQoo0xGLy7x1FxjBecvn8O6AL+ZStHHlU=;
        b=Ba/2p9F8ze7qbXIq4zcw2rw7YZj4XzBowF3IJarHvkrngBR93tjb8iaZVpB4AnWlA8
         y0W1iC0+cn6x17vyWqpIsVMb+ASRSWR8yjDFufaXz2dF5vzXEiSZRX+9oFAnz67Ion/2
         TYbTrXbKyGCLOfxFNORobT4/f0WNBmH1SilGMPXRhWA7/PpL1RxeSix/cEnVYyW940gH
         K1RaY5ag0QGir9PyJqKXfwO2LZlDaR4EsrBoJ0C+HryHyg7rLytKOoL0xvrnKc7Ay+VB
         zD/qNPenFeuS++VkJ7IUcouiQQRJqKPtIz7sNY3TjAoS1Mx+WhMarFCTKu0K5HLt62PH
         9Fzg==
X-Forwarded-Encrypted: i=1; AJvYcCVBNkEUp/7/tc2sKgJg2ud3pK05zLllwHZSeb6ZV/nvxae7hnJNPpqRBrQM0+dIIvOhACLXOFR8qh45how=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0j1seKUORG5pIklTddACbVoitc3xbpv/012PaQTwdKX5i6li
	liuuIQ04wo1a4jGw7QygczbXOW9HIanQjlZJ/U44HRrdPGCXJyUYz/jGSQ==
X-Gm-Gg: ASbGncvvZo18CSPO3+MLT+GjyQif5Bn3+3WovS5xNiyHbMnA/0E/AqFM7lIlZeFC23j
	KNFfxMaPB9gRP+/US9IgAUZrKQpuq4nnpwVXUaVTOe1Vj33f8FqvY4f/sRROehpPk4ftJPKWnmW
	YzKR41wvoQg5m7EVBRN9vZSk6nE+tJjTLoL4sv1QRuxJJ9l/we7ILcqbgmfVLHPPMlkzo4Umc4e
	vhUTuuaQxFs6KaomoZQBMBWVHkpcGQ3nN/LqC7wAVcdWsWLFCCZdxM+J62FhJI4pq1xFEUue/U4
	DrasB+c1T/XZqeBDfik2dZy25YhlySHX
X-Google-Smtp-Source: AGHT+IFc+QGP7nfL2JuBzuQZJTF9YsTQkiDo5LYDWo9DEVbee0Xy0uiI9KjP1j19hSpFDf909WUGdw==
X-Received: by 2002:a17:906:16d2:b0:acb:63a4:e8e9 with SMTP id a640c23a62f3a-acb63a4eba1mr150192566b.5.1744895018347;
        Thu, 17 Apr 2025 06:03:38 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3ce598e2sm287304866b.77.2025.04.17.06.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:03:37 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 17 Apr 2025 06:03:07 -0700
Subject: [PATCH net-next 1/2] net: Use nlmsg_payload in neighbour file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-nlmsg_v3-v1-1-9b09d9d7e61d@debian.org>
References: <20250417-nlmsg_v3-v1-0-9b09d9d7e61d@debian.org>
In-Reply-To: <20250417-nlmsg_v3-v1-0-9b09d9d7e61d@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 kuniyu@amazon.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=993; i=leitao@debian.org;
 h=from:subject:message-id; bh=dW+6ehsddfowqd+OBwDcpHmbdIVY34PpDq8DShV0IwQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoAPwm9asW6udsbVUlEWX/FHJxj/PzWG85F4v+k
 Ascfp7D4KuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaAD8JgAKCRA1o5Of/Hh3
 bfyeD/wLBx7mfBSprA9tYzvqw/sgww/Vy83ugZs1AepAAeJlliUFOGUhcyvMzgZa7895qWL/TdF
 QVXku72Wttu4j7/aC4VsMG6SlavnGQoWjeKO/WnT3hqB77DIDcbQuS+W5Xkic5GwuL7Ue1XP3xu
 E1hxteaY8bqv8ankq28lbZ1/8ZCCoT6pK0Uxh8ZhA6S+L2hVgMFxiH5Au0T/Rrfvnw7LSMvDJwO
 RzOMiFLieP/BjR3dTfQ9tdGaB/H+VXqesqQLZkfOh3yHYzmGP40LgDdMld8v4+JsohNvsCxCHFZ
 mLybNJE9NJC9KBWJGl/5VJSn2yW/xTEifTdIcSwICRcpPfCFjhEV19lMeW2dK0MZpVK1zj3Sb87
 JX2VxUW0RDUZWLMTi2E1aqY38EKsN9G9iCZyCAkeJ4elNcaM7lhXCqsLzyKkKZpSDCozFh+F8mQ
 qfZZPwyLaeZ1nS44oPJWspAhgRXg70x2AZ1KiHwAPYrADM0NDi5BTsRq4BFRvMEFa6FoUC7NCah
 inGVIU+JvbQrJlnldUJVA+I3eGWvGOT4/JLNZeABxa95je+XfpjnSuyRzDJP3J258efkr1MXhCv
 E+EnFa1ULGBtJgbzX0wmDTksZHxusOMeD3i13kXGeP9o3Y3+qv4e6YOQlxTW+eZTIck6R9ER1KW
 33iZc/+FRJFyl3Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 65cf582b5dacd..254067b719da3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2747,12 +2747,12 @@ static int neigh_valid_dump_req(const struct nlmsghdr *nlh,
 	if (strict_check) {
 		struct ndmsg *ndm;
 
-		if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ndm))) {
+		ndm = nlmsg_payload(nlh, sizeof(*ndm));
+		if (!ndm) {
 			NL_SET_ERR_MSG(extack, "Invalid header for neighbor dump request");
 			return -EINVAL;
 		}
 
-		ndm = nlmsg_data(nlh);
 		if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_ifindex ||
 		    ndm->ndm_state || ndm->ndm_type) {
 			NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor dump request");

-- 
2.47.1


