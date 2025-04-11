Return-Path: <netdev+bounces-181711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95294A863F7
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70619C5C2F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5512B221F03;
	Fri, 11 Apr 2025 17:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97124221730;
	Fri, 11 Apr 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390882; cv=none; b=koUVuHGnsdkaLPq4D/TkjG0HfzP0dTKpjjPPd0DmoShWEPtRUaovaKKgx2Bl3MNWhEWYXDFgusiCfSVgugDRMx0Nazqoor8tm8N7PTk2e5sK0cYHFnWthnyLkJNiqvmXf8E9uXNb5PcpSt/QcXXNs+35nTsBVigyHs/j2jMw9k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390882; c=relaxed/simple;
	bh=LkKbG7mBW1nBa3rIzXBPWQRGLBKmqnkuELzeBvOUWsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YeNcvsjCtv0CKLRkWARvWeJBEg8O0vpJfur551LGwfbVsIC7gwweFSfEZULVNR7WkxLcLlddyEVQBK3oIDeraYyGS11bj/gbi7hrnGsKXRliMFBnTfYwBJQAHwwp5zIJi6g+TOBoDHWEtUzLIVWtgDSEzFZcOlQ0iUgKgkG31sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso373527266b.1;
        Fri, 11 Apr 2025 10:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390879; x=1744995679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQJdK7pWNGAO1N3US6hhCsS+d/YXVzKHaSs7dhJL6eI=;
        b=JYOvkjJ1PGcwjYXICK2BQ21iZqVwNjj41QZ9DX45xKxAV4uuMySSKCDVTWT8vtohVa
         GH96sqDC6agZvOEgO3wYBsoH7Ot3vaOujEMXTAlGjdtskW8T1c94EyHUO+UeYFcRLqke
         FlzpC6a41Q5s2477H7zicCnx0xPg1TRiYzhIs5y9owpj+Xrg9lPWiEYzoVGG8sfioS8k
         Cu4gp0nkd1iMN8TuCUP8+m+XjXpEFH6LusPxELY/m+vf+EAiYRrnvdCufasbdy4yi008
         xO2stNV/EAoOsNsT3yhgnAWmOjSRhL8SHGfuq2ha5Cj8RIbjWgvrua/wKPNNqIUHPHDq
         K4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT+R5enuMG/7XnysT/wNXXk+jgfV6vyxK22420mOIpKzUEJN+PHJ01VwZXskgUqa/JVtATC5jRFcmUUN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpprCCdOs/mxuJ4aChS9Whlyy6rIWRGe6K7+7I/UK1p0ME0pVw
	XxXVszOi8tDmhVlZtwKwNSu6vkeX4aVa5/2vyvfSpj5lbmfjIRCm
X-Gm-Gg: ASbGncvT4kF5NfRn7mXKJRd+hOhtkJEyv4cH1Zb9UDfXveptipllzahNVEmReJvrc8Q
	+kG163HPZ7X6gzUpAK1LdW8kQLN4DFLnotH5qfiB8nYb2FeLyeltz8OxOoz9qEkGJ4vhbhbR3A+
	XkB/OO/nBsCFaAkKGoNFNFhhJ6pMw+LWTzpnPanr0siMFLhyyBvqz8nbvzeTvC+xkmnQytph+X+
	Q6Jm9lU0coHOFfcZmB0/36bEcc5bMRPccqQFRd5rPo5llg4wRBe/KAstcaMOxIGhqDyFhdSKLHx
	0gyurSQbjhhY4Fv1G9W7f+ziEE/QF6W9
X-Google-Smtp-Source: AGHT+IGEAP/y3VxuIYYyHAM+9ZlDagbzQCkDP4bFRg5FhVudcEXAozpCj8kZi+6xHWOVGsW0earNCg==
X-Received: by 2002:a17:907:d92:b0:ac2:af42:4719 with SMTP id a640c23a62f3a-acad34960camr287700066b.21.1744390878360;
        Fri, 11 Apr 2025 10:01:18 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:43::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acad99c4456sm82905066b.110.2025.04.11.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:17 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:52 -0700
Subject: [PATCH net-next 5/9] mpls: Use nlmsg_payload in
 mpls_valid_fib_dump_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-5-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=953; i=leitao@debian.org;
 h=from:subject:message-id; bh=LkKbG7mBW1nBa3rIzXBPWQRGLBKmqnkuELzeBvOUWsw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrUM3ubDo8oz3MedYafDsVqjXYw3iV30IJIV
 NnsT0GOd+mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK1AAKCRA1o5Of/Hh3
 bYAiD/oDtn9YbF8tLeegy9qOTh93EJIh5sVQuVqQcG2IXGaWXXu0WhbtD2X5JW06hFN7EYKHo2s
 Fco+fa5RI7amoyITt2CucKMitlXCtAh0JUcbZuxFt2Ssf2SWK/TM6gvS5QVU+8Dnjd2Y4feDXHz
 7fm6Liz1zbknLcaF3wLrYCoCUbaGUN0TmLqQbQneL/vx2j1xVvRwpt5rIgN52FIhfKgw2RHlIJ2
 eiyabDqotJrrX1ZUBXnS7ybz+JJ/RFPGnD0ksysaAWJC7VkCCcVWUzeJ31wU6slmOE6urIqukyS
 Htws5QiAp+8TKv9PT/Hl0fFF9pwFTzM/Q1Y7CKxRCQlq+ZzIEdWq0XcvW7P6MnBgojPUg3kEuaY
 pwJNVO205ETC3NBI4jLGT35WCttBAjLoLCCKsadBgReotfJuLFi74Jrx9V50bWqIGOpP7uRy7GI
 LPVg29lFFSX8LCgv3omlbRyg2exQTGHsErA4zsNY0xPGvvFqqgk00SCIiofx0g8H+8MVPdRyH3G
 0+sM7izNiX+2P4XOvrgnmyMANfzbfGpTdCgTvoKOtVUuBRmGneoBIt5vP85cWYF2gE++yHhXnpG
 GtTTyGnSmsrzHjTG+J5JtAHpjM3/nzGOoA+1w6Zw32F9cMJkBBICZsPjuzPk23jtckl3wIAZIvG
 GIgYLCqSvRYFSwg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/mpls/af_mpls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 1f63b32d76d67..bf7cd290c2369 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2095,12 +2095,12 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
 	struct rtmsg *rtm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
 		NL_SET_ERR_MSG_MOD(extack, "Invalid header for FIB dump request");
 		return -EINVAL;
 	}
 
-	rtm = nlmsg_data(nlh);
 	if (rtm->rtm_dst_len || rtm->rtm_src_len  || rtm->rtm_tos   ||
 	    rtm->rtm_table   || rtm->rtm_scope    || rtm->rtm_type  ||
 	    rtm->rtm_flags) {

-- 
2.47.1


