Return-Path: <netdev+bounces-182208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2248A881C2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D5CD3ADABD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7F72E3378;
	Mon, 14 Apr 2025 13:24:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A8D2D3A89;
	Mon, 14 Apr 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637080; cv=none; b=EvVfAgj0CaHvf5LnFlsMU7rQTsFkg5CpaFxYTIDp2D7Su8XGRQG+u+LiRDidNFpNaNMcXCU5o7nnp3JKI5iJYSIlg99nR/iV0XTKY/7T58/lzN/DhdXmdUMxyVIQc7G4dDBU4r6ZOGtjyj9/vPX2azCkMpJUYx8OSmOS32D5Jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637080; c=relaxed/simple;
	bh=TX7KDRkVxewIVmRSQKXdXwWZB0Nhk8FMev/2a3gTxws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrG0k3CFHtUUeAEL+TvKVUzx0e4pclmUIV2MqQHTOxxExyUEPqx6jATzNuEfvGuIQmy+S26lp0X7j7h1XshlrHrg2/vg8ccYFftDOKd7ITK2fRuJmn7fmRcsWx1yIAKbCc4i48NQrDdGwjPPkTN/mRAXHa9hqSgO2A863rbmC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e61375c108so5428092a12.1;
        Mon, 14 Apr 2025 06:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637077; x=1745241877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2sWzig08utwsn26aQcHYW8fjy2ABURqiBL3C70ruNQ=;
        b=aJAv/kIU8bBQWQ/pIwE6DW4JLzukh2j3B7UbgEmfKfuWivZgTfs2Mgxti+zkRmzCrv
         MJNGkwB22fDygrwRZ1o+KSFXssorlfHyqiCDCeCyIwyT4hpn0JcLMDqUQ3VYvZWCl2dz
         9ToKfPzZX5I1G4u1Q7LcUWqKWqwS48zbwX61gCImWu3pm/v88BrpEPEHEr9UB1hZ2wNM
         3VP3w3w1XL4cbIb9uIGfb49uDGwVwCvs5Mltkt7o1Lr4B1nSld/nHtGXUd0hZeTEBI0+
         P2hozUK4MP1+k+3WgyeQloryGoPxbQnQbKeaCy1VJOa+7VoTuML87x1/cuVpaBtvOT3w
         xeCg==
X-Forwarded-Encrypted: i=1; AJvYcCWbLVBFjkEhwi5lISsrUSp6VcIiDUsUUA60MiPH2PfveC38HHf3Wx/2yYbvx45grexuc723tFeoodxXWHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbVxdEOJxCQUvXhYkA16wbvzi7Aoq0QuyPYzWmVEIWoMR8Nmx
	mJMMjcEpF7pKdNHYdPMykR+UmCx+CUBJvdaLnO9iJ2WldwrjLRIR
X-Gm-Gg: ASbGncuW5cvK7JirYbRvfxLQ+YpWuQChPCMt8ifZcTGaIGKZF27ABKbTJ6Qb4R7uYRt
	mgbcCFSPixNk/uX+x2DOWe4vpXL4aP1A31XAk4Hn8LQJcioUFE0OT+1N/rGlrnf2sMmR2DN1Gd3
	PsfWMaBuGhxQLHPKn6ymka6+hGHnZC6TxY5+GkJqM9yBCakQMKSpe4EUWxbVO3uL6+f6FehNqMC
	OiNp94VlB73LdvEeGZyTwbMYegdyk2ZPt/NFCy1QW0CTmqraG82DLvh5iiqRhTFe2wfd/vXZrhu
	0UUDmEzPBcxlF2LRs+oImvyz1RGO
X-Google-Smtp-Source: AGHT+IGayCfd7esSqxLjFxexLjeAZSACSTm9GIsU6rCH58RfPDmJvwYat2pABe+Zqn7hMIrzoq7HYg==
X-Received: by 2002:a05:6402:26d1:b0:5dc:c9ce:b01b with SMTP id 4fb4d7f45d1cf-5f36f52de35mr9516346a12.8.1744637076871;
        Mon, 14 Apr 2025 06:24:36 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef56ea4sm5123138a12.25.2025.04.14.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:09 -0700
Subject: [PATCH net-next v2 03/10] neighbour: Use nlmsg_payload in
 neigh_valid_get_req
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-3-3d90cb42c6af@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=leitao@debian.org;
 h=from:subject:message-id; bh=TX7KDRkVxewIVmRSQKXdXwWZB0Nhk8FMev/2a3gTxws=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyO79OcSPPTRnbvLnOkpQwtcIpuiQhVXwnQr
 vLEjorViN+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bS7nD/44y7kDeKz9ZYSBfzIITy8RyOzbyFIsy9/gsx7FUMbx1omMKhIVbqpnkZ/pDFvq3oPMyYj
 6o1vFrmhzIPJ8Bw6ndWm4rRO647+c2eq8yhlwPspOev8jkYzqGCaUg1G7CLxTRANTNzCmwEq9CJ
 V8E0kOIHDb5jtZJSFuw45XJKKDT/wRd4jb5PufdrUOTT9inBGvpMb6NeZNNf3j8G8O9+iBffpGm
 NHrfuyAOZgzYwbj8Th56kKHN5vREpcpbCMIt0/akV9MHxfw2tD/CgrzQmqbBxRLVBv+NQ1zxKMd
 7H+VGgji2CO8R6gHLlVbqh+afcm26rWbcfq0/UhdPvPzFE9XeQSYBiRU6PETAGYP8CAlonChcRT
 Rul+5ijZ2zE7qkFRo/bJnw5hmquJKupbp/d+BwbisgZddtrzYJJD7bXKrf2TVefs7bRHIpF0kBp
 ygCowd8GyYLkKISRBa5zcf3f83fTLZuIpnGYlRw4wu9A4Sd7V0yNtJZjFfO4Hiq4nM9cMcyTL0P
 Omm88CRqdGOnfjIQJilo6rY1Zz6M6JQ2ZREp1tFxJNl8mMq1uAMvy+5Q7MCuPOYL8hxBgOQvAoa
 dn3etIeE+8ELqcKxjfo+MlNVeST89LpVehwt1EuOKQ2KITSOV4oIRyBLPK6qbT6zmrIvCBC/gAw
 W2H2CYJMs999nvA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Update neigh_valid_get_req function to utilize the new nlmsg_payload()
helper function.

This change improves code clarity and safety by ensuring that the
Netlink message payload is properly validated before accessing its data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


