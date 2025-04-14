Return-Path: <netdev+bounces-182206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953EEA881BD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEB03AC7CD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9782D1F4B;
	Mon, 14 Apr 2025 13:24:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701B44C77;
	Mon, 14 Apr 2025 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637077; cv=none; b=aRmp+VRN9AQE7i9psUlIxO13W+W5t6OfNDTvQ4C9VOS+J0wjP0SEvSYBHbZtlKGHK/hOXT8aujnqrWLmBVbR0F4fOahK6Dud71xMf+xDSTNFsJafiNo94GJBloOnAg2FvYxLouu+BeLHtvUYY9noW5VAVjgF5vwq7fxuIHp/zKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637077; c=relaxed/simple;
	bh=GlsQ08MjyrgSqf/SRiJCowC1n8P7DiY9zTVTUCcQ7OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czm6QwN56W6NT83AygjnExiH2ffHWa4jn2kpZUb8uSC1N9MkTMniZeZtLZnNkEhWJcQhqS94pAGxzdBFfkzAZCadfXKa2k6CleUTyXLc3o3/c2mRdR42/UGWug3jIWAk+G8lnx9NAumwHOKAPWhhqxbR8dRYLVnJkVK4ZkOpK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso7988034a12.2;
        Mon, 14 Apr 2025 06:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637074; x=1745241874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcR0RCAc7YT2S7CQ5NvY2gzccevK7QUJbHLGjpEDSXg=;
        b=q+mMbIBuZhMHygGLzKdbFuNkR3sf+sg9Rn+0EcSknFnnIrOvhyRVP52daddmoy2lga
         jLnLoWoJrvzRvQUs3QwpHkPPv2lFrogWSkCQ0nNMPQ2M4NdWLmO0ZoKTjTBy5s+FykvE
         U9q2TmmpiWpjBR2vbuv2jX/kS+kJ2mvRyCbTWWu0RBjzegFSASb3dRn1ShT9nf6w6VyP
         Zc+pEw+rFWnvGHFHUn0rq7wKepe8+Ce/l/LjXoVDrhrWWZlMLU0ujgEgwRE0eR8BNQ5F
         pOv8NYMDKDsF7HVH7jvE1SbjPqHjCbOcynPsqIUZ3zOQM51XOpkO1xF1QkSHkbcJOhLq
         2Cag==
X-Forwarded-Encrypted: i=1; AJvYcCX5Smkp7K5UQfounCbHEgMfYOk6Su0VREYDFX8j08YWOMy4Y+hV25NCPiwQwrrq4Qat8+XYS1RXQ2KEEYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd59yYuEm1QF4Ypk911nUEjXaJJ+dUTp9kiPj7Dej68AZu1qNo
	WUjpBZuMVRhSMLwPeGt3H4VWANRGKuZ3K38+Xrihkgf4kIJaBsGa
X-Gm-Gg: ASbGncupwP89ddohdT0WUYQe4DrtmmanUV0XZ+VhP1EiBTOBCD5jNrfvAc6GWXOKjIL
	Hpj+4apXBST0nA9f7lFaVXOVrn2gK/M3dLrs1SCZjfLg00Hd+Gk8zQyH2Uo00U69zfCAfuI10eP
	d5NvCErn3/8LsU3JptoJ3dXrULXzJJGtBEjjCtjsNGxHfsy+FejMmXHw5iKBQ1iXGNWRprVmozu
	VtM9MFuRappKmQCghg/CuHg3uuKm7k1JBk9knvsEFzorf1HHlYraERtMZPPvvmIcS+cgZkRYBaj
	cHKAQzI9FTts7HGepvG/FEYjfTfmcM4=
X-Google-Smtp-Source: AGHT+IGItMyl2cFM3/ZGsCN38SGLo+ErsqtMk/g7pmcDfzf9ilR7VrMcVg7cu6EOYYRCQvx0wgg/2g==
X-Received: by 2002:a17:907:970a:b0:ac7:4d45:f13e with SMTP id a640c23a62f3a-acad3494137mr1040869866b.13.1744637074018;
        Mon, 14 Apr 2025 06:24:34 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1c011e3sm906501766b.77.2025.04.14.06.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:33 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:07 -0700
Subject: [PATCH net-next v2 01/10] netlink: Introduce nlmsg_payload helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-1-3d90cb42c6af@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=leitao@debian.org;
 h=from:subject:message-id; bh=GlsQ08MjyrgSqf/SRiJCowC1n8P7DiY9zTVTUCcQ7OA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyOVbB5AF6sfof3uVb4xIl2UqdPpRy7+h8z7
 Bm9kU4/UKqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bfylD/9CJYDoBZPrquwuHCtYY0psAPoagt3VGUdnt8Rb1SYc/LCOTxEoXuLxqi5w5cIs2wpSz8H
 +NQPeqDccqi3tbUhfKMx/kTsnCbwZxxEmlHNAey5Gt17HPqGtmRY8H4l+XQCqfX3GRd4VhpWFE2
 mrdSd7W7sQ+nmBGyGrcU/e/9m+ekFRShOpOKR4DPdp2cwstIv1A3zyIoY+Vsz5m7m9GXKnhX3Ay
 OomvlkMQY/rALRqkW5L5LWZf84yLux2vv/PNqpZt2Fa+yGwZDyB9PBAWVsWJ69stMIFQItE9Jjo
 AendNBpIOZXd5nH+lXTlIxEknJ7EVTV8YjcO1Ahmz55GqyE8hGA1NdWKCeeL4CP6laKyDYgLggW
 8bm0S6I9+L+2FyDihgsc5t3nlqOCCQm5UFjo2zfKMkAHGK1XAu7EjtaAaISjH5z8wHcSrMCkjhO
 Wz1s9JMsyq/UOkGIW+79dT68mcPFpcZBUteqmhzeDegVOZy0oDnE0FTBvFz8kjVpSjKKCBJ0+PB
 fDaDr9DV3MD9KBKw4AjCsm8UDE8hOht0UJez2eIZWtka6wpPUz1yDXuPYfjreoHtUlpniYliqg1
 9Fdp1Lc4dvxkynVQBtp+5ADLqcR4Ioi2Z2qmwPyURacvgbVKpv5pGAaW9x3jtDniyH7C61PwkNs
 X4eImtIwcTybSLw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Create a new helper function, nlmsg_payload(), to simplify checking and
retrieving Netlink message payloads.

This reduces boilerplate code for users who need to verify the message
length before accessing its data.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/netlink.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 29e0db9403820..82e07e272290a 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -611,6 +611,22 @@ static inline int nlmsg_len(const struct nlmsghdr *nlh)
 	return nlh->nlmsg_len - NLMSG_HDRLEN;
 }
 
+/**
+ * nlmsg_payload - message payload if the data fits in the len
+ * @nlh: netlink message header
+ * @len: struct length
+ *
+ * Returns: The netlink message payload/data if the length is sufficient,
+ * otherwise NULL.
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


