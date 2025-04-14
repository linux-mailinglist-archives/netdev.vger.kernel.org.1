Return-Path: <netdev+bounces-182214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5DCA881DC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A2D1897B5A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F6B27586C;
	Mon, 14 Apr 2025 13:24:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16E253953;
	Mon, 14 Apr 2025 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637089; cv=none; b=WFp9vLRxQwCX3nk/oV6JGJllXk4fMs7gmuiKQeGu8cPzEdY5Z2m9w3S5ZZH5FJ607pKAU8wUuirLMrGuhe3kLj9WVjUrZelW/rJwQXuO5M0V1ptbE++0zT4h7HEWblahqy48jmJW0ZSX2Sf3+6o/PeWJI2EtVR/QiRj+9WPQmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637089; c=relaxed/simple;
	bh=RcTBEKTPFJ5T/ILitl1DJk8clpZbZgc5WWpG2zoR5iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxIUV9GiAtL0cnErxd7WBFbiGIi/EGnyp9E6i6KaREkORUxu4bEc2gazmwZNRrBAhn/wc9cH1dOTuY0SPPPU/qeb0mBe+qyWdt9kQTkswBUlzhd9PBjsHzBuJ4VFJ9jBEKPZF1CFfc/jD5YEtAQJxfQrJd04IY4kTomqcJ9kaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac29fd22163so684017766b.3;
        Mon, 14 Apr 2025 06:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637086; x=1745241886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3koL07yK6bzyFRSB6cDLpngM37ULVLmyCPPSP64O7I=;
        b=dLnNfaujRebAT3uHKgrMz13nGUO6SLiCvXIrC6OzhIJ2oReLNTMSCbbif5Q9e38SuB
         mgebp09FPPSx9AavJdAN/7n9Y2c0rU9COvosEYIwZ0gk0S6hgnCuFwWWq8+54x20LWm+
         ze2/itXqIcvKyEYcvChIvtMlGuEumR7OYC/qfYlNPZ21GR246+WLxN0PPxUQ0znGI1Ww
         XHxRgq1hzTb73e2ifjqM0Tx4fmchx45sv0wpY6+ZIjvJVbVqFZo0hY3oRB1iJR5fibMI
         AkBKpZduCbBPTuIWr2rQT+ciTPUoSbzREFTlulVZfmjbuyCP/ygdsyn66B8KahhBsZmy
         N62w==
X-Forwarded-Encrypted: i=1; AJvYcCUPfSQwT6WUZGjFrQO6m26Wf0nqRME4ZaBciTi/Y3HBuMJQkh88msSwqOhWmNm+G2XD/Cx4x7oNNsN1K28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+bQtFvVWAor7t2L+QMylJy3yLAgv+I9JNvLFVn2mGGsBsMvo
	U6SHkQgCgfv9xTbhQSzIGnnXxFnUYPeNqvN11LO1JcD81wMGEH41
X-Gm-Gg: ASbGnctbExWfycKHPfjKWgxCNCIAfjRSznOwnGMXqH3JwoMbKX7PvJ+QGfogqtWP1QG
	yhJLn4fRMTQuR/IH/iJLN8zV6XNodW681Zkz0Cx6ByxwEFVU+AXPPYfm6qyquNjy8jrmp4jGRBP
	TzPIgKWuBIq2fTkqvr1njJZfRW35Fr9rxEWVbhqAuer1j4U5Bt4oaH+bjc9mgXY86uMQzo6BUOZ
	6LWbEbl9J1rQmmP4PVMAYGokAag7ZEjO0OfAjZd73Z2HHfyzZIHpXFXnW2eHqZ8t0hW5SsSayUJ
	Sp6I3TiRrgW5mPa+iZyRrkym+59+Yiq8OV0pTWPbHQ==
X-Google-Smtp-Source: AGHT+IEchQeIHdLjWaJ+ImMbxhPU93jorw9zZlelRxJiEiOxsNpF7jAH+WV02i+x1nLasrz6R/Otsg==
X-Received: by 2002:a17:907:7247:b0:abf:6d24:10bb with SMTP id a640c23a62f3a-acad36a08bamr946303166b.44.1744637085646;
        Mon, 14 Apr 2025 06:24:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd255sm897451566b.156.2025.04.14.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:45 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:15 -0700
Subject: [PATCH net-next v2 09/10] net: fib_rules: Use nlmsg_payload in
 fib_valid_dumprule_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-9-3d90cb42c6af@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=leitao@debian.org;
 h=from:subject:message-id; bh=RcTBEKTPFJ5T/ILitl1DJk8clpZbZgc5WWpG2zoR5iA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyOkuwTAE/K6yal6HFF0j23gItUFnv7yu8du
 tW6+MtqWr+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 berID/4xwXPUq3WwlgCs6duc6CE+cZjFzhVXg0piuy2MZTQ4VqUDIsGhUy4d5evUu9wxzPredRO
 t0eWguB17lKdrqlJK7UO9XLRiCk7Ex51lYzOJI9KkjwnpEmIE9n7+iU/1UvTNQfodHBcuNAuhIU
 p0qDEhB8fkCMQvVYLx3/aq6nbgx3ooTYdyFOoRInUkVaJiSqQXLVoHNwYo4UC76L9heOAZ5APZ3
 I91Db0Cfz3vhN+NdmIHxMqx6pydwPdL+HFcXLosINbSZ9kuIlkHEjXh8dJRvqgYaCXcM1OWZcil
 bzOxMTRe6lmCrUuuhuwrdAuSxRiUdmVp/C0qHfBvgZzhHByEWUXsnk8c+MROholw8zD1r+TUGPu
 ADtoQ5TcPvU1vS7qf3MJz0/KUqh64giskOfIRows8XIQbLzJHzz5JbYglX3MEyo7g4kh04NQ0h6
 1v9qzMT9e++YTUgew/HH5UJflXyKKPkZup15Hz7+bzRKm/rJCGGnQVyFDdcrr4gQ52OduYXrjIZ
 WIzGolXHw/43myhhcYw21ryqlAFClL/zjytPfAgTLwpwNpaHCAunQRijHbLgZUAYnlpZNQyhhxO
 CvOZvHJWmXt/UQCRxHczM3KjAZHnhnUO1mqO8jfONaa2MB/XRNrGDeqCRX6Jd1359rXsYm39aih
 2AiR+iA2F0fe5dA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 4bc64d912a1c0..6a7a28bf631c2 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1238,12 +1238,12 @@ static int fib_valid_dumprule_req(const struct nlmsghdr *nlh,
 {
 	struct fib_rule_hdr *frh;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
+	frh = nlmsg_payload(nlh, sizeof(*frh));
+	if (!frh) {
 		NL_SET_ERR_MSG(extack, "Invalid header for fib rule dump request");
 		return -EINVAL;
 	}
 
-	frh = nlmsg_data(nlh);
 	if (frh->dst_len || frh->src_len || frh->tos || frh->table ||
 	    frh->res1 || frh->res2 || frh->action || frh->flags) {
 		NL_SET_ERR_MSG(extack,

-- 
2.47.1


