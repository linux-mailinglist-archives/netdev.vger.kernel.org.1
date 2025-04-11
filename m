Return-Path: <netdev+bounces-181710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA34A863DF
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3395F4A255C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8ED22539D;
	Fri, 11 Apr 2025 17:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF7221FD1;
	Fri, 11 Apr 2025 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390878; cv=none; b=FZYMEZ2MeKdhPLxaQrme8Osw30W/BU6CSNnGaAxXKncdujxdOUkNIRvy2tmNjN6Wu5K602x3cC1lp0o9aoiqZiLHckF/atGuBeV3TgDpa6eigNffhIPyULOtndgFWRaKEmcU1IclDKWzC+FgTRqmoEtUc9rH3idZ724TwGoT0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390878; c=relaxed/simple;
	bh=jAnjkX4YrOhRhNYOu9uh8jXBzMfz1KBX4pd4yKauKKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PM1WFQvCg6dLqboUTmcGs+4Uzml4qHGZKwlOMvaHaWhr+dbcgbux8u/YKgpdpHvvlLL5lc/+4cQd8ymJobdN1K4igTlS52jsrFWd1+8N2EZdxSkdfOv2Zrs6MGPr9UJLffTZXMfbIaBcYLN2BrJAXPuZrT7GGCS5CDwAIgJ9kxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so364924366b.1;
        Fri, 11 Apr 2025 10:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744390875; x=1744995675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQXC8rdVYEJK5/GnNV1XkDFI5aEgmK+iXihPheDmHow=;
        b=TkorCZcOYAw+isZx1d6zD1Te1t5Zzb1D0oTkD+6/eYflnXBYwdkLsOBqW+CQQUlHLz
         LZRBrcN1W+zGr4DyK/gscEI4wTUWtAezg7jFek2DUO0RxUVC7B/oUU5Lqqw6rvPxHQgV
         w4DqK7upfl6P4lrcEytdzGXwXPbwNwuDuMt/wub9t3ZA/6mKn6zBhIa+rDk1vHYVNs/W
         LSVzJbjXQI3uB538qYTRPAubwt2RSdZcrL29sUZaTB2PBzdbmFHZ1dWLpDDVQZbC+MGA
         XilEHhZl9LByYgEutyhhtY/QXyrpu3guz+0wwqLHTjowtza7iqa4M65pVPpkPA0/2Bu0
         cdsg==
X-Forwarded-Encrypted: i=1; AJvYcCWqWMm2x5VH64g+NobD+RCGmHr7lyZyNowip28XBPas7pF1pq4k67yQqoO/rEPzUbA7VDUoPwGN2VQruiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7uZRgxmZO5g3Taf4DRFHiOdBAhpkOuCyEVaDHut7e2TIh49W6
	JnegKM5Bnjf2DHTCD7Jc+iGlPV/wpFVjQCFIWhjWvT/JwfICBxY9
X-Gm-Gg: ASbGncvtb3BHUPEca9/LpoDH/JV2looMPYrUTeaPUdb6OLchCUVRB9uewuI+DTvY0nR
	l/cFoHrK2h4d8O90KNEx1nunfnpz+yznfXhggPvStUKS0W9exIIUVgb84HEniFHJwIFk+Oc+Zhj
	7Io3iKNmm2VvJ0OTRhdG+Suy+jEXYNZVnVzvdG96G+eygsukkSqRRAWuupEjJF0pciJKgDBm7Jk
	RptOBtOpLitYieQqBxfuxo117i6OOX1mYJ1mLXWr6I+W5DVEzy+0LAgVZlZOeUA7zY9Ka7D4TXN
	L5jZ95bHjoC4qj+591/uupPQ9YmkxL0=
X-Google-Smtp-Source: AGHT+IFTMNt3WGPwQFfIPSjcsNmzwhAtn0IcAk4iI8gALkyrUbqusSigAjgQ5yukEFkCw/8HuQraeQ==
X-Received: by 2002:a17:906:f5a9:b0:aca:a1d7:a830 with SMTP id a640c23a62f3a-acad349a005mr350299466b.13.1744390874870;
        Fri, 11 Apr 2025 10:01:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb3da7sm466230366b.112.2025.04.11.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 10:01:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:50 -0700
Subject: [PATCH net-next 3/9] neighbour: Use nlmsg_payload in
 neigh_valid_get_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-nlmsg-v1-3-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
In-Reply-To: <20250411-nlmsg-v1-0-ddd4e065cb15@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074; i=leitao@debian.org;
 h=from:subject:message-id; bh=jAnjkX4YrOhRhNYOu9uh8jXBzMfz1KBX4pd4yKauKKY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn+UrUCMtIJyDxtp2QOiuNeVBrPdDHzGNIr/EHx
 2KJEdkwcVyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/lK1AAKCRA1o5Of/Hh3
 bXOLD/916eNhYEeo97LAEad4mtf/vppIawkoPOySf/v5pMlFpENgJY7+mlZNEAyajolJg+IdZFQ
 Rd86aZmHshCLJZKhlkl4MFcx1dVuBR1f68TU9LGGIUQESWPOTVZ3rVjKuI6Q+UK66P/9QDCnuAp
 ed+YktTnfmfplFLfUfHvUfGAH8jSCn+adgp6CTimnyA2XOnGdwjgutsZacLo1TxI92kfg4p/dRq
 TTYUsACl1o4xstYpX5ja5eb355rsIuDr4jxF122OORkaFZLjhSHm4Z0KdexBg4NYRgCpPwe5xa1
 uB7nfdqEPvKC2pQDZjyAL1psxrm+lEFX9eUfMYbVf36Q4ZqItXeAQmU9uEhHQyeZYtmiiWtBCE6
 xN2FH/lTJNiisYW5EmZaJc55S0gI/aAw2Hp3D84NQ+jstQPrI9Kh9MiL06Ymibl2yT72s2XSc9V
 291RPlDX5Gdpm/k2ctKyvKcfw/l+mdIVoKjiWkTJjnLO97G3WFLWV8YpvnGd3vBx24a+pODSsLx
 JqduBtLhxlRA9Rpv8mGp6zld2UYNOnX6R/K0lxf6U84TT6auOBFjmDlR9EqGZaQ9YKmdCiFxSD1
 gqopD7yb+nCOcbnWBoLIx+4zz1TM8H1U/ziQYJwKZLyGNwRUDsuB3D7VBmlVtpIOYaUb/+a6ZZM
 RGGSwL5aScOGrOQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Update neigh_valid_get_req function to utilize the new nlmsg_payload()
helper function.

This change improves code clarity and safety by ensuring that the
Netlink message payload is properly validated before accessing its data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index b6bc4836c6e45..65cf582b5dacd 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2855,12 +2855,12 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 	struct ndmsg *ndm;
 	int err, i;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ndm))) {
+	ndm = nlmsg_payload(nlh, sizeof(*ndm));
+	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for neighbor get request");
 		return -EINVAL;
 	}
 
-	ndm = nlmsg_data(nlh);
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor get request");

-- 
2.47.1


