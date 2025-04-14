Return-Path: <netdev+bounces-182213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEEBA881D7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6ED1791ED
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFB25395C;
	Mon, 14 Apr 2025 13:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35202472A0;
	Mon, 14 Apr 2025 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637087; cv=none; b=RQtfuJUypgI/7jEXfSfNSF855VEZfgBSNSnP4OWKS7mJ7IocF2dIsCYSRNQH9DAXR87Is67zy/KpjJGV3pO00tx7Qt2Qp7HmX+A+o7o/fB6V6VUzXXfGbySkSl3IfmTyEMXo0pKHy1a3Qy2nsKuxV/wBs8/vbgT2T6qtEjMT/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637087; c=relaxed/simple;
	bh=YQg/qWYvHFxoM4f8ermcKKgVE4kd+xFNiuJpBQNR7Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dBNV4bWm4nNcwfPoD1T6Yt/1YimQbzF9UKl+KMDp46GUKtgBwDKXJkFwcyRJNY+qntKlrWmotg0htBdd/LSojN/ShYlhEEnyMVgyePRorSECpbTZiexWXbwyHMAWXSxn7Vuamn2o9F4Z01ObibcA9lueVeEwx5E4zuLrR0l8YVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so7311748a12.2;
        Mon, 14 Apr 2025 06:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637084; x=1745241884;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI6HihxDuZwvoOMZr+bMeFHM8HI0NzjEPZNOZ3+r+C8=;
        b=l4Oa4ksD1/ek2lgsBVoCVvmy1VFlpfY/OJDRcR5SVJ2AK/Cc0iIogjFMeO+gMPf8IB
         whf1TIdJXTarP1Uz2SQr8z30HswJTA9ygeBY2bIQkmlhisGMJ9mm1Ur1HDvo9Uwc7A++
         YC9Ha3xbuJviQMtCXZMuhRHlSsj4a48rYVO3i1CRh+x+Jf8Wq3145tJtJdK7tVuAOPYQ
         WPiftzThzR0Kd8G/KoF13FUH7WIyi1aMzgYxspZir3CDb+NRBuImDjR2ZqLzc8/zeut3
         h/dhLU2jlC7M9XCbgwmyU5ZDuctSpinFrBzlmvB50hNEVTsXArxa02urnaLxShKsQ/kC
         7Uug==
X-Forwarded-Encrypted: i=1; AJvYcCUR6W9QCisXj4E7tu9j//c6k4w+NXBu6QX+kS7YXX6NSQQslhCixlRWk3gTlN+izZxBhFIhfyHlPUWL2Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjGPE1OTCu/VvUXIs0EAOcnc4nAgjux3k7LouEEz1wFaP4p4Hx
	4tn6ym3aVZDQDAHyCRQtdIYLWaPr7egyJUIc3B/hwegdHOFhN6nsk1Q1CA==
X-Gm-Gg: ASbGncsPKOKtWsXobYC8+9Trek4PuU/OHFwlXUtWdvwWLdYMGV9AxZS3OzYzBj006KB
	x6/dcYFJO2CLMDJ/LvrW6aj86NpGrmmAcWEJPH7f0HanNiVDvfGaXenHhGDSFfgap85zI8aS09z
	w6pungkBQy4tu42S6yiKIwvV27NWbwhNWF1uE5ApzWuTadM04gcZgXSd4b/xcfml2rkeOh+KbTh
	Zo+/so2u6OwqIcot5zFbu0yQEt2wGMwn1tM2T/encXGRGZSG85ybSkL21D8Mkg5PGLIskax6NHN
	0QVZnOfbnHnZjZcRI+zDeSr325YupTLx
X-Google-Smtp-Source: AGHT+IExmyzZRYXmO3HjhV9AjkHgDbC4nr/NFSbcShUM12FI+2b/nPKqhAeN67dd51RrpU8z0Q+EeA==
X-Received: by 2002:a17:906:d7c5:b0:acb:107e:95af with SMTP id a640c23a62f3a-acb107e9857mr23014466b.39.1744637084162;
        Mon, 14 Apr 2025 06:24:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb4129sm925470666b.98.2025.04.14.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:43 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:14 -0700
Subject: [PATCH net-next v2 08/10] mpls: Use nlmsg_payload in
 mpls_valid_getroute_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-8-3d90cb42c6af@debian.org>
References: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
In-Reply-To: <20250414-nlmsg-v2-0-3d90cb42c6af@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=leitao@debian.org;
 h=from:subject:message-id; bh=YQg/qWYvHFxoM4f8ermcKKgVE4kd+xFNiuJpBQNR7Fo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyOiR+G0oWH3XRn0rAQBEj1p4pf0a15a3fZO
 g7yu2v13xKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bbFGEACRdGuLdyVGQwuM6QlPKl3v0p2Urcb0G9QDEcdD0qf5Y+LcPGoDQtG6kA+M60PwIK2Rb3m
 D7cfKT230HeZ0bZguRCkWjhlk6eGDe7KxTP5ARijgv/Vmax4VdpXsUozz5sKgruerY4nf782y36
 H6ntzOpP5T1MC3qkGBeuvHSzJj/ib2ZB049dMIlInx2wPSg/+HjikDMyhb2IE/6nO0Eg4oWQ77k
 pmMsihzHs8rwHT755zNS1oGUSSj4Bf13BLeufSa288EbhIkIETGA0CX3a0NBKH+LKRiZNFSC7eO
 CJwH5ByE9RrUopUj7Ahp5FfeIcIP2GcVKB6KGRRBmeaFMQ5FkUIwokOQzbvxIJImNc8vBJZPJxP
 nr1p0TDMQNlWvl0yat/waaGjAOPZ/Psa4vjeB4n4jNqKV0oviFcYDj60dhTkxaF8C3VosIl2QhZ
 TTLxSw92XiWJpDYk+akNpTALY1acZWQ6sdDGjvcfQ1pZ3a9sUNbYrblcCARchzRryCTcB5uCxbP
 hslaN7QBFJs89TjNIZ5NdvEaqZGAX5cvwZ77AHUp/BANtNE+z7WLot0E4WrX66NGpBRVzPH+J5I
 V0QeeecX0+sZvfCxGxEUKRkLx1r//Xw3Pm2/mWJLoOJYS9iN3dk2YV82S+d7JtYlYY9B3eaesTw
 4N2o9hEGxR3tT5Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/mpls/af_mpls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index bf7cd290c2369..d536c97144e9d 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2288,7 +2288,8 @@ static int mpls_valid_getroute_req(struct sk_buff *skb,
 	struct rtmsg *rtm;
 	int i, err;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Invalid header for get route request");
 		return -EINVAL;
@@ -2298,7 +2299,6 @@ static int mpls_valid_getroute_req(struct sk_buff *skb,
 		return nlmsg_parse_deprecated(nlh, sizeof(*rtm), tb, RTA_MAX,
 					      rtm_mpls_policy, extack);
 
-	rtm = nlmsg_data(nlh);
 	if ((rtm->rtm_dst_len && rtm->rtm_dst_len != 20) ||
 	    rtm->rtm_src_len || rtm->rtm_tos || rtm->rtm_table ||
 	    rtm->rtm_protocol || rtm->rtm_scope || rtm->rtm_type) {

-- 
2.47.1


