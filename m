Return-Path: <netdev+bounces-181712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB36DA863F8
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FF68C2044
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48522D4F9;
	Fri, 11 Apr 2025 17:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FA221DB2;
	Fri, 11 Apr 2025 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390882; cv=none; b=MtsiC4+Lr6J9FX+hijY3KqbwxWmDJfwowimjCRrApdLZhaURc85aHwsz5loqr3bf9/L5RAgpeTviky7lp2NG1sHZrfQSw9t7Z2ABnI2SQRGNx4Xf2JtFHNcVoskgPodzM5QW4WStDCsASK+i5YqoYQIPm3amEi3CX1xiJeaf9aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390882; c=relaxed/simple;
	bh=Jl1Jg8xNHOI4OK1xiJ1wJZ2es8NvAYy656lwndBWZJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XP4k8h0Dv6ahfqxvreh87tbYYrpXzlOdDLcwlJBIrAGpUiS3Pjm2J8n5nQozOtOENtmNib66+2eih90FFdJQLuu7Bw0QJUIAlIlOa46z9EUQuakks0jl4UnsIobaGgYuqse7MA89Yn2883NCmFOiIF0WLzDmzTss7GsutFJ0hOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f0c8448f99so4489538a12.1;
        Fri, 11 Apr 2025 10:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390877; x=1744995677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjW+JjoOHsvH7l3Mahbgsn/34UGIGL+Ev+ltWUAL9eQ=;
        b=Zlz6yqrvYFKNxGh3PVDIW2x0P5W+sneYRspFA40oLLGTS4jLyLXGOnRBh5F1IAb9eR
         YlRhd/vfdd8e18yq4GvMS9Fraz38IXMwXYUU4ymi2KAz4+/nh2o8BL3ddmvxuifEPC/N
         Dnf4UWidqZZYP0k3HawIBEfi6cRr7mJqKtnDbIxIGOq/eP1OaAzb3Bf8IZO8vuUP8BmO
         zddZPe9Ax5rkJKWo69fZXYJXZlGZgGKAGZ8d+zKpg5AhpEesTUbtMr490KpEMA0Uzb6D
         +R3nNR62WSyXIHC9rDi/53IlVtvh30Lg13yqKbKKlY0nVELJvWV4+hUdLSWrjYCUuMwP
         iZFg==
X-Forwarded-Encrypted: i=1; AJvYcCWrR7rjAl6b+W50Xiov5UPvgzX6m1q6E0wrwbNZE9VgOJRDTVGihioV/AYEo9zTyKabMOgO1UGz4ldfMYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+vlwAexqnWbt24vDq7+cD1rJB1N0GSB+8Qb6vOLl6w4vsBr8
	VlKkX5VJPHYrFTOE24md0wWY+YWYNHm1ISq67XjnWter5OvrdUlH
X-Gm-Gg: ASbGncurTdfK2scG6YODGQ4X3p44AntdR4ANiv9IRkBbV+/A1bu9B9r1dGSnuvVyJv6
	Fi4VbBnR4Szytio1S4giqqLy969311FzQGneQBrEaKkx2m1YlZmDxcoP1Y3Bjj9gelWdONkPoHa
	eKeO6dvMR+uiOxuOftKxXFatrDOh/4COrmfDf6Mnegg9Q2gSGn9ejXfLuWleq3KY8Tq7DDvCoih
	XGG14Wq8sJ0lBXcDiS0s6p4a4pF4rKiLiXArK4Ol1dTtzsKgKQchIvxjfR03wR3r2IVCyqoAEju
	oOUUvIX4oWfej4CqsfUefjoSSTi+DjU=
X-Google-Smtp-Source: AGHT+IFpaJPhU2bzSnky9/L17bHdlvHEFKtZ4lDqKgvrNAEVCmFdTt0hcs3VY+DhBPxsj3gZIXmOSw==
X-Received: by 2002:a05:6402:26cb:b0:5e5:bbd5:676a with SMTP id 4fb4d7f45d1cf-5f36ff04a05mr2783352a12.22.1744390876546;
        Fri, 11 Apr 2025 10:01:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54d84sm1228361a12.8.2025.04.11.10.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:51 -0700
Subject: [PATCH net-next 4/9] rtnetlink: Use nlmsg_payload in
 valid_fdb_dump_strict
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-4-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=leitao@debian.org;
 h=from:subject:message-id; bh=Jl1Jg8xNHOI4OK1xiJ1wJZ2es8NvAYy656lwndBWZJA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrUWBAQrK8NwdsCQqV7Ma4ZAXBvPtyybnnFP
 /qRjlpYkjCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK1AAKCRA1o5Of/Hh3
 bWzMD/9hH3f03/Dj7emGaBBrMVd7VrKjWOhZ0IHelNTSnYMRN+pm8ShqCPixLzKqXTQ9T2p09AP
 7L2a2KDTv3H1tBB1oaF3BAsE/QypB9VwG6l/MIfEvO39aQtzwa5KNb+DVj8TVGYZhLbwMhDCD8r
 uSN8VXdtslyJrvYvy6ipiW9YyOHrpYS1nD6zLBohw/G7K9wSG7e0t4/gQgYB1fiRgV/wl72xOx0
 YAFMbTJMO1x/GErxtiDoOL9aXAyPvrc8lbOtbRkGReOaPN9UTzKwhqfGRXcCtaqhzZaT7QTDyfm
 142Y5CLJqc+v7piWa4uubZm5Tsq19l/KoFzPH5tPgD6vRKHI4M8L5kg3UOH6pL/9QvlHZbg8vwQ
 W295FobL/S1AP/eSgZhd7BrC3lbhWMxf/CIB+XZe5Y1NfQTw4U9Y2G6UTOUZGKL74fWaCe9gdTy
 u/C9txmdKjXFS/Jf5FWW1j8m5Tctum4XEe1DBwjPbIj+sfkm/cCl7FbTAIw2X7V8Qxp9l8G72d3
 XS8SahGSGveraOKa2BNxKixelFERTxNjnTMyqB9PSVMefduKCk+6kewJJOxC9R99dp9o8fxIhT+
 Un9v3n3tcKTxFVK6kbKjtsfef6GQYlv2Jupaf+f4FcrWbaOWBuRHUwKasWZIg8GT2ln6R53ol/0
 HzWYIuReelI8Z2Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 39a5b72e861f6..31addd26b5570 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4886,12 +4886,12 @@ static int valid_fdb_dump_strict(const struct nlmsghdr *nlh,
 	struct ndmsg *ndm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ndm))) {
+	ndm = nlmsg_payload(nlh, sizeof(*ndm));
+	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for fdb dump request");
 		return -EINVAL;
 	}
 
-	ndm = nlmsg_data(nlh);
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_flags || ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for fdb dump request");

-- 
2.47.1


