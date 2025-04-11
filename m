Return-Path: <netdev+bounces-181707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCFA863EF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A66F9C4266
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E88221730;
	Fri, 11 Apr 2025 17:01:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1134218AA3;
	Fri, 11 Apr 2025 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390875; cv=none; b=Q/6+vUbKdqvd2RGLQHvnq8ldFMMhCAy9Ej4F9cTwRgoLolfNHes0K4/RJFYQRzOsTmbcnaxD7uVcciPI2KaoInuRaclqE7NX0YLy3Bg9FcNEC0VycwyvQKh1C2bOEQqM227sxrWAsnEZFc66zENXsreooSE18UlcGY5PeZ9Tjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390875; c=relaxed/simple;
	bh=ME7ClmMteJ7nDa5z/JxEa2egqSSEhc9E5r8PuiVOl9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLYKSuCOjwOtFAvNxzYUjeEuPI8i1HjxtW8CimS71/Iiad73jYvsUMCo8KazeB5ThrD72q7DXAOEEQer5o5QPb3D1tG1k2dayD/p4bPFvaP6Bvrhny4xkqmxhlkWBRvXYifPcWPecHchArUfcmDPcvrQueDcnFa6lSV9CTwBo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac25520a289so376985766b.3;
        Fri, 11 Apr 2025 10:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390872; x=1744995672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=817YhAaczftGiJDT0IGuOETYiXsxv+uzR0LyvC0my2Q=;
        b=b+2wvbPO7ygGCnE2mp/By7b365uFTXTmPywKwwDGlsS2DQ8evdu1nAW6exdS77qzUS
         lyxC/nWWQKv5TKrbjpm8kkOeMfnTrd4paqoiymskDVAQgqKgCDeUqAhwhBbaiaXXVUvD
         CTK9u3Ga5GI3NR0Si71g21sEH6cLqIrqEnC1DbAaA4C/qhhEUoftqRLyuq9VQQmUQZ/0
         twuz9NVRmcDEY8IwO2QzDitpGv6ag9dRSNaevag76YId5p+Wk/6FVBjTu/J46S77obxO
         28RNfav63TXJo0gTzSNL6xv3KzfKMlKr4P+QeumPQl/Z6BanYHVIcs2Lvd/xVpSRSBmJ
         oAPA==
X-Forwarded-Encrypted: i=1; AJvYcCVel3ZIfJ1h3Kf+2HT1jIkjHMJRFs2BHj2IMtT39DZutGfuDP/AHKHoqUkuK4V6bGXIBszi89BUPXsP/+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCl0hXRecG4sd0asqgjYhsrEMlDMLKR+67F/MlZBYg4Xdf3HLk
	uyYn/yhiwxeJMFnzR+8D2IWny5JRCXf/KDjkS0KET1x00EumvwKO
X-Gm-Gg: ASbGncuvWHXzc56AIZ4EHzaTTcnkMDy1KpjVhWWuKPle4GerP+zmWoYsyX0DJQezjwa
	XEjNuGSkW61vN9vjC6C5KFv3T4QzHomvxsmGbrBaKYJE9r9m9ZX+v9n6Rok8cmD7SgL/hH3PWGu
	GL0YVIGFeZ8zFzy960NwVBpyI73xCHxUwPhuUFSyXYeVoMW4SiFRf7Yg1P+eC5ln2o5o5y3JatB
	xzyVOQ59Y5kNUZOnsxnAUWVQTxa0PFEikc4mFMZ+3ioOONuCLKUV+azGyGvjr6M3dS3kfVx5ntU
	hcvDzeO2fSm0RS3EhDsukrfvMYA8jw0yJTNby/d5UA==
X-Google-Smtp-Source: AGHT+IG5BzDYosurloDcdSU09bzmSf0Krf4PprX7I6P3tGPXgsMk16Rh7dwaQu70f/aCF1kmDIiFUA==
X-Received: by 2002:a17:907:97cd:b0:ac3:3e40:e182 with SMTP id a640c23a62f3a-acad3496730mr291571866b.19.1744390871534;
        Fri, 11 Apr 2025 10:01:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be8d19sm464895066b.45.2025.04.11.10.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:48 -0700
Subject: [PATCH net-next 1/9] netlink: Introduce nlmsg_payload helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-1-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=leitao@debian.org;
 h=from:subject:message-id; bh=ME7ClmMteJ7nDa5z/JxEa2egqSSEhc9E5r8PuiVOl9w=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrTlAsyfVS6GdFs4Sb9c+lm8ZIgQI2QpEm/B
 POZB/LMTImJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK0wAKCRA1o5Of/Hh3
 bR41D/44EkYUkFWlZ3hRtTylLKgxkZ02zYyg70gHYtR/V/nMxXSQT7/aD84w+8ZkB2UIT65LtFL
 fpKYv4OjrzrcCNbuqg3nUFA3L8uobj4fyBXD+vTZTH9rUB9BIjukaqmD2+CDfUmQMSzTJwRXh7f
 lNyK/LyCxeQPDi1DPp8nzOdPv/nVVr/pRy9pEJzvKhZto3im3UlLkVR5MAir+0wb5hiuZpnPkOR
 BhL80lbRTijOVsPxRrllC4U2Lm+0fjob0PjSHV4tYnjf0Da04fes7yZBt8oaQ25f5AYhyIftrk0
 pkXaQVsP4sIQEVhEVyFHZtgKt0Ob/7E+83TMnNpL4s4nVRW6BJmkFJzX/QOz3f8eMItG0h2ssWa
 y9rUbCyXdzhcYOA5iKUSMasbhKc8gx5Af06wnPpnjARjIPrilmopBa3xsKsfDI+SRuUDXXRMn6E
 P6GkrxcwGHydh3QftGNSsfsXPMZdlaHGc6hTcQmSaAiqSfoPwX9dFOGVLyWQlS/IpX6IeC/hTEI
 XuZilyY1jO/xwwg8LOt4tUejXOoMtFzaf9K9OzY3jRJneFB0b0QRtmvd9Kw/HSjDzgkp2G5wA5P
 kVfMtcwOKJobNfAlyEaYhq0qXi32YgGey5Xt0+y8G9kIc6Hh/anF+4YAB8gI/THlh8eFZQALHxK
 jBbFhU2lyOImkXg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Create a new helper function, nlmsg_payload(), to simplify checking and
retrieving Netlink message payloads.

This reduces boilerplate code for users who need to verify the message
length before accessing its data.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/net/netlink.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 29e0db9403820..6343516f131cc 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -611,6 +611,19 @@ static inline int nlmsg_len(const struct nlmsghdr *nlh)
 	return nlh->nlmsg_len - NLMSG_HDRLEN;
 }
 
+/**
+ * nlmsg_payload - message payload if the data fits in the len
+ * @nlh: netlink message header
+ * @len: struct length
+ */
+static inline void *nlmsg_payload(const struct nlmsghdr *nlh, size_t len)
+{
+	if (nlh->nlmsg_len < nlmsg_msg_size(len))
+		return NULL;
+
+	return nlmsg_data(nlh);
+}
+
 /**
  * nlmsg_attrdata - head of attributes data
  * @nlh: netlink message header

-- 
2.47.1


