Return-Path: <netdev+bounces-181715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AECA863F5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C951BA25D0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A3232365;
	Fri, 11 Apr 2025 17:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061F221DB3;
	Fri, 11 Apr 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390887; cv=none; b=QomRK/DJVu+b9rivXA1UbUQIcnXhlUwmxs/esp6uLUpxRlIDA3cEOBxNWhQJjFymvaYXnH7qXUu69gVwjTwn6b/ES7M/rC++TruKaEWr//kOfZKhAr4BtGNZ1Z4v+0nzy/mkQHyUNiAO0AjGQZam2e8TAMGsgxU72jb6/YX9FK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390887; c=relaxed/simple;
	bh=lYvzTpSZyygHUXVEDNzAsKHGlcw+uYdnaFaBQjbhfBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A/fucaNWyby16oSMN9Hx8GArZKvLnF3naaSs0mRTVLUH8+gf3PvWM2ef8MHVejmbDUewgRqarrJPI7ehvSHLCXgUsWO2hiqNVo21rCSMZh1w6IIt77Xc/ZDaz0r5OAZSax7wvUs0UYwKz2avJ1EqVlSCHxKoqjFzP6mHvzHoHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaecf50578eso399322566b.2;
        Fri, 11 Apr 2025 10:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390884; x=1744995684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFpqeny572NR+EIPAKNoxaM60b+BChL2Bxy58MvuFdQ=;
        b=VbqBrDRrf56+nPVXrmkkLtLb5x6YHEX+LXFeW8Ow1Rnrd6ld1eFXW5BeSoV9LfeqV2
         EwJ6gp+nttnKlzGZcq04gnwC444veCKpVVJovtQr7KGN1fkm5+Nf+X1EMPfNndUc/tm1
         efNFYojfd9muE3oXheW3MPBqe7j+rA7y8Zh1s2PY/ABeD5snV2a3GPetbdwcav8Q1lG8
         rVd4TxVlSHic8CRGrcqBsMuYzKWGJgcI8sNyqsB7lmZu200nhc0a/g9LLwU+Aqn9Gb6z
         MU9H7YUmmRvyWz0qz/0eGnKx+EV/W7zvZOZ3y1+ki5IjC6+dCssST4E9W8/M1g5QG+mu
         4MhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj2neC7TkadY/ICTwGfhxKYx0SDUlpLPk1lpnSwAlunXOVY/CM2lyoOgQEUuRzAdg7985+9q9ubOZG2f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4JyT+AGpbkq+oogMEQIpRlmruM0IWhNs18/Ahsz1f1Irvkrj2
	b5bGxLO2FuxxuQFjrqut6TYge1CwFjfrWW8Zb1y8DWUwx/tZlGal
X-Gm-Gg: ASbGncuorw3UJlIBmVFT8KEz2mB0Egg12WxfJLS+AHad4Lu3koUTX6SCxtXVkyv33sg
	ssTMqWx252TIOFERYtuAUo99uAQtHTfy+QPSDn1UnWt7GMnXWQespIXbhKicagMh6m7LHuULV+R
	kxIEbR7xovOogPJ9LdYzpq6Rq21EdRljMyBkPy3bWcs5n48nk6kNdLu/haAb0WJCnoK+W92FOTj
	zfLfKda6V/lw/KwH6TFgbF44NlR3OUJ69eBti5SZSjssd4qJEmPo5Mm3wNMqDoh0LT4KKmpOhqc
	mLHbKw3cYM/PgDfpNHNXW/2yvcw16YLNaWIS093roA==
X-Google-Smtp-Source: AGHT+IFg8ifYnWwth8OKuqZKSZ0bcESyagIEiarMOsPQA8T88ixfnSFv2fW3sz8rQqECW+MYeiUuCA==
X-Received: by 2002:a17:907:3f87:b0:ac7:eb12:dc69 with SMTP id a640c23a62f3a-acad34c62e1mr292057766b.28.1744390884043;
        Fri, 11 Apr 2025 10:01:24 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1c00ea9sm472313366b.76.2025.04.11.10.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:55 -0700
Subject: [PATCH net-next 8/9] mpls: Use nlmsg_payload in
 mpls_valid_getroute_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-8-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138; i=leitao@debian.org;
 h=from:subject:message-id; bh=lYvzTpSZyygHUXVEDNzAsKHGlcw+uYdnaFaBQjbhfBc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrUhYJxwtQsx7VL8rWPoQ3PdTFChRtQF57ed
 gAV3iu+FKyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK1AAKCRA1o5Of/Hh3
 bYEUD/9q7I2HJA65wBHcKXNiZNagmhx1BeukU7jCptuL46ITj9gRPqg0RCU76Q/ZEn5zijSWpiu
 JvwA+zbNjd9palCE2z9Bw48bkc1mA6QXnDTowN1NF5YoD4G6camtR5ZMaf0brPFZ+VmouOqsEv5
 she/8lXiooEfQM1RKPvgDWQBwMk/ThNpcUOHi+XKblbwQpfVIAmrDptPcNWuUgtxwmhq7obZ1Fn
 +J3QFY3H14w6AkhhAhQVz8HMdGwlMa8hjZP+5aOSiQgCUb9rj8j4gfmoZjJpZpgkOAw9oay12Qf
 vqERcV89Loy1JNlViTn1TNip51cqpQfuyCXAgTwTmlEuq7UB9CJYTyK6FNAJP/4iR2J3CVPDK42
 mw/JHF5xO6KEf9/9wO0wHn3GvAsD9qgA2yKVN9egZac/qT6zKw2YBVLlqp7SOrLRwnDo687ntKk
 Q0gMH8qq+Uu+yV7Wy433mihnbmls6DEoPmwB5m7Lz+2TqxgfMwJUoZ3s+wWFgDV+mkz25d0W24t
 u/uWQz68R6nDCrsH+c11ywqWa9cLzOeW42cn6kok4/CC9F/IM+5ZaXOC0d7hRQRoWaMM2Az4/Zz
 xj0y8ajbv5WJ8ZddcAHDQIN5pPB7WEws1Ho9xcX9SUsB6yOxjTO9OwFtlc6buqXXcWMuNIQEcFw
 487UE55KNXkyspg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
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


