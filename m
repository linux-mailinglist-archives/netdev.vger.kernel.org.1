Return-Path: <netdev+bounces-179652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4CBA7DFD9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B4C1883C88
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80F19006F;
	Mon,  7 Apr 2025 13:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A81A18787F;
	Mon,  7 Apr 2025 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744033261; cv=none; b=OOx/m5R5Gat8NnTZ2mprMjEDWeMGci/6wG+6z03yUKzCmffybD2zasPpeLHnphA090nVaqtdaEXSqGfPoWgQ08D3okVz2rHna3PYeWMj9KbJCmweibaF1ATEXCE89+JSx9Ppw6f1vWmT474zG9Qu/hpsn6XK9inOrB212dLg+5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744033261; c=relaxed/simple;
	bh=DV9BHzMxrR/ZwOVP/ZKccx7rQ8ZuAbaW1IUu6qvr/HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eoJjV6xItIvIxdg8NHXeCMnFpdoKI5PleJ/PGsdmlcRh9QRgIfTA572nZaQsdafoXRnGhJqRRhkEMYnn6fv6XJWihHCb54VF1EdXRVd2JPh+xOLzMrBDsHOlfuxpHEIvbPQO+G0IQXa3ofl1+cZeF4iBkuBOsz0HMSDTOIXPv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so45817766b.3;
        Mon, 07 Apr 2025 06:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744033258; x=1744638058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KYeBP1E2i5zOPP9AKVmLtU8AJBSi6KLc5+vFOzRCmU=;
        b=ZtHxO7BBHMFvqJo2qJfsoYpfn/AzUm1jT+eMJrKYMA2p6BjsW4XPm5UE0q+wPsJhtX
         EUcyOC+QbhXqJG6A54KSz+l8ljxIDDN1h9aJ836ZTgGSqKgzhcmK0jdkG3ZzpVf/uhVB
         S9KJt7dAWrlFNxlWJXKm9XpvxIJ0zPtlzytzx3ICA8mTZTO1tDVCnhRuDJDxEmvkhUnQ
         0M4XD/yPAVrZ2CnU33tBJ+vadPmyd+WEwlRbg1UdiO525E1imMc+Me01kgCeKRIgjFSy
         0qaVzUrrJ9Xv/80luzV1JqTkZhiOK/7kQZSREM3eX4YekA8ckbWWg4PoVYiX1atZ8jqN
         wWqg==
X-Forwarded-Encrypted: i=1; AJvYcCUBH+dd33HIDAHt1pQDOS1lYzkTOxYZfVmxu3lPTCCD7ozDuCjifoAiqgJ2DKOBK1bPD35qA0eA@vger.kernel.org, AJvYcCVWrUdbhBPTgN4vEHcbDpR7LaNnG8GK+YD0OvvkmR5WZxUwCkhrg4PZ2sTPR0YIbprwpuCxi/P1OSIKG+gpCchsKBrP@vger.kernel.org, AJvYcCVegKoDH4o2TPnEvUEGMn/PXsf2RJ222hnpTHfsD4TQ8jmlPGgf6QqUYewGWkvp30ECVsCZv7mKCPMaED0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGhiRIh9N6yJ0NQBjj68ngadun1bWMjCPdhaEmTRUl0uhgbXum
	UHNHlTXUxBhmqII+zYwoH3QlKyReuWF1pGBotGhHR5PUwyv6kqVu
X-Gm-Gg: ASbGncvmnZ/2gmntquuxNqAceET4uf2VsrtWGxDQAdAUiPgM7JOQdKbbLbTsiPlkz5/
	1AqfrMXLu4qzQo8H14lRhQLGO/Rydm3miKIrgYmhjdG6RAOBtGq8g8+2+nlqLnkA366EvEgC8dA
	YAoozn+DSTcCp+YfU8Sj7f7ejHux5gU4bfvzvW/BDlUQCetAvKx2jZnLINTyXHDozJC0ZevTGrZ
	yFRvUHgbIKgB4xeF8LkmXML8LXeINNkM/UjIWVu4s9YGNjovE/EXS2Zd+UY1Jbaf3+hDkqsD0HH
	jJa9UG1aZqBdiOv0ppdPr/tgQy3U0H0Df//v
X-Google-Smtp-Source: AGHT+IGH9anxuIuZHLzehkaKAk0F8a1rO2GZQtUYp5N0N6TNh4e74UGeQS6842NIP7aMI8pRFVp+sA==
X-Received: by 2002:a17:907:2d0b:b0:ac2:fd70:dd98 with SMTP id a640c23a62f3a-ac7d18a1f49mr982760966b.22.1744033257561;
        Mon, 07 Apr 2025 06:40:57 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c0184d30sm748692466b.133.2025.04.07.06.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 06:40:57 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 07 Apr 2025 06:40:43 -0700
Subject: [PATCH net-next v2 1/2] net: pass const to msg_data_left()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-tcpsendmsg-v2-1-9f0ea843ef99@debian.org>
References: <20250407-tcpsendmsg-v2-0-9f0ea843ef99@debian.org>
In-Reply-To: <20250407-tcpsendmsg-v2-0-9f0ea843ef99@debian.org>
To: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=885; i=leitao@debian.org;
 h=from:subject:message-id; bh=DV9BHzMxrR/ZwOVP/ZKccx7rQ8ZuAbaW1IUu6qvr/HY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn89XmK5Gjz/NxHS6gQIk8KPjqaCoRDgwrEjv0g
 XsuJmojagSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/PV5gAKCRA1o5Of/Hh3
 bRdPD/925iDb5ftD46wG2LTDwegSmRG0EvHvKa82Kz0ZzuqFu/E4Z+ljQHzAJyOWau0qrXOuAHt
 cEDRn7zJjuNzpsdNVIoeuVvA6s3xrsXt+haGv/zlVwQn1xrb5sXY0GPutz7iM0BwNcTho1HxRPu
 mKFcAZMk84CPMF+TltdAZ+dkF3BICU+UPX0ABYJWHB75CoVkoABtxIuGpcE87W5rSCY6OaxVXI1
 gyzb30iaUoC0kKwH8jmp9fJLJiQC2ifUhwwUUJJ5fT/Cw/kYjK0TgGCV5GJxZlntP1raF8lwzvr
 wv6gKzdVKJXv0XeOwH2Lv7SeOvUotD18neTm2hBxmkFr2m4l1KzUBjFeFNTTLlG0gr0HhRi5NLk
 cBsJgQ0JaICrZERLoY/XKlG3vVD8f1fBvL/AvhJ6JOnb2cwO8tZAwnJDKZuyQmY7u+RjF44i8AN
 9V78IhX1AQ+JlMAk+jyCLP0NRM0b1AMpwyNcp5ijs3RDOS1atIRnpipQh5//G9hrlYibJ+3nKHz
 PEoq3UEsnQETQGq54Tl0Dz5ovkQVCwQER9R1XhzjY+rudgbWUtKpNF0/vDhTHGwzDEHroha/y9Y
 odEna69p0xgjnQ+dlWFjgODY1B0YSxNFe9X1g9DtvAfl8AnKHPxiAOOlsm33AvxlrGtZ5/e00Fe
 46J0mbCA+A8aDVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The msg_data_left() function doesn't modify the struct msghdr parameter,
so mark it as const. This allows the function to be used with const
references, improving type safety and making the API more flexible.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index c3322eb3d6865..3b262487ec060 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -168,7 +168,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
 	return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
 }
 
-static inline size_t msg_data_left(struct msghdr *msg)
+static inline size_t msg_data_left(const struct msghdr *msg)
 {
 	return iov_iter_count(&msg->msg_iter);
 }

-- 
2.47.1


