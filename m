Return-Path: <netdev+bounces-182207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D5A881BF
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8333B195A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683D2D4B5F;
	Mon, 14 Apr 2025 13:24:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765934C79;
	Mon, 14 Apr 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637079; cv=none; b=Hd8sMbp9TICjM8KocD8TL9SaJkPwBH2nttWnRkvKu53WmjX1bpCtiujKX/BucErJkbyZ4xdfudF5rFcHX4ZMtaL3R5OWUwU5s0owjzcIVL3ssZBLXjPH+2S6/+bBRbF9+4RMx//VdYdEiuy6b8/w5LJlp/Qh3VDox/8usr29qnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637079; c=relaxed/simple;
	bh=Ibw2sNu8KeGqKxrgWmVE8Rau1AKfR0gUOro3uD9Z5Qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eclFmbIgIFrA3bLzPHnPk5X4LH/vX0NsfNrPp7Qy76/96fz+k5cjbqgoyZUhF/KP4vsOW2BRisQZtEj+jdo//v/jldKFhSIIUa2c06bxr5r9hK0kaH3Qu5ES4FWLWrP+4+3WxdVCRDoWqH76AN4lk+cQBC1Mb78hsUe3QbUpGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac297cbe017so968894566b.0;
        Mon, 14 Apr 2025 06:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744637076; x=1745241876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWuoOm/EAh8A+OC10WY2olZnlBorl56UzaOtac9WN7s=;
        b=MhiX6TKJMfj8oFki0C03uiB9oX0YXPkRSzfBQrpVyo4Jshf6OhraImVr6Cq8xLXqnY
         oSdFqYi78egaM/cSeB+lXCIeLkeFOVipDM0RaVoMo7NGHF5i1+IMxiEdibXz84Iiik7a
         XuBFhfDpzJKlfNnlxyWdwRqCS4cmYg8wGXqoNH3FlSZ7CkeKKPSkSFKGz4QKiA/09dEQ
         k5CCkby0X4WUZ3nXRnzSR5R50/ebCC5qYq6VlYanuMWxNMJmbXexokXRAOSkx4vhQEXW
         +nF8/28HKtmNsGqW9OwFyp5fgdEceSBZjCh2wZXmXuYWCigiCKEslt+nxXCYxrUXK2m7
         pIsw==
X-Forwarded-Encrypted: i=1; AJvYcCUfrqoJOScgfqJIAJ7ybJApGBq4UcYTkXIfdsyyFWTbNK5hOrS1Isq3acj1NPYty0TrD16vSU/p2vAkjaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3mkls9Kv4qBCNlQmasF3mZrGuxLFNbj4NTn9AQ0gNqGwOt1u
	1oOlTqKEwHg7q00+M/uN29rg5Lc8cJcIQvnvpnsgS+b4x3EgL+lR
X-Gm-Gg: ASbGnctyw22AUB3kM9GdaYg8c9nMIyz7FK6tq2g03E+09o7TtUTwSxPlHGxuyWfid6w
	Jnp8dHL/zF21IFxUEIFfMxUuCaSebAPGoLJhPAwp6ofxz4cg77cl6o6kPFjrSIzRSiOETBdIab9
	bxkMJqLB0LoD3h83uRONJxJpKmZHWabUdvVFMJXUX8WpAQwpyzmTQDozmr/HriVadTqAXpAp1iE
	9nHqlosiu6MofWxhlWz+b4Dmxt5Oo/t0nyUfq+3rtBw3sDYw2qAOIEaL/IupU1+d8fBabC2IJc1
	lHeisqtAKtBxHIsx0eUwlZBY8gG2PtJInwf53Grbkw==
X-Google-Smtp-Source: AGHT+IHaajRl7Psebw7s9XiK31rDuCP8yx+8XPtmRqMfcB5BUfO/s+1mXS7JLMHm7FnjEvegKnYOIg==
X-Received: by 2002:a17:906:dc8d:b0:ac7:2fbb:ba5 with SMTP id a640c23a62f3a-acabbeeaf57mr1475064066b.7.1744637075401;
        Mon, 14 Apr 2025 06:24:35 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb405asm913707066b.100.2025.04.14.06.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:24:34 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Apr 2025 06:24:08 -0700
Subject: [PATCH net-next v2 02/10] neighbour: Use nlmsg_payload in
 neightbl_valid_dump_info
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-nlmsg-v2-2-3d90cb42c6af@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ibw2sNu8KeGqKxrgWmVE8Rau1AKfR0gUOro3uD9Z5Qw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/QyOvDGJIIMYdrknaaOU3B1F0iNW/0GKPwmRS
 YxoX04fNi2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/0MjgAKCRA1o5Of/Hh3
 bdUJEACAoYUqm7E8UsctBqslzseNIta3ZVWDlJ24aeV2DlvV8okIW5OIYYK19joObzd2DOlPJFe
 4964OXUHpScToYtpx9njIRHaE9Mbdbze2ntmt+m7mVJu8LymRhabtUm6uwyf70XIs3gfIl6SCso
 bTMN9Xlq94RypBZDB4NmjTGOzSVQYDwnq32ITSOMmv8e0gEdOVq36mUUDvE7qTCiPCEh/jhpgFW
 gebbmg85324hHX6aTCCyF/b1sWT53QIwQmQCd3O3uWZhwR8FhNQHbufvqO6qV8U2wqHrXDopIoT
 fYHE5qBQ7aMZe0IYS/pi1dfhC+NNXBU1nRUdVynBXnO9yhrm74DcTLT0UrH9mw0SbxuoMeE81VK
 qQUqPFCi86Wz0STNdLrMpy0HPNXGOWdqyGWLV4kk+WxzYMNXFe7vSCs8EjXq7WspmNuyMZqhqzL
 8QfzkGXzJCTtNd3//7v74BeljkkfxB7KkTd784OUgGukbU3MgJgL9Q65FaKnEUo9pxmPh/8mVck
 kAtmnYtaKpX2RWoBTtatPTl2WIaI43y6BvV6SAkf4PzChGz8xyooclWJoywea2wJXtzPD9/zAoS
 lnvRnSMXhWxa0aqbr34CZmzoVzAJgAHNEIC97ZPOgWWIy1lTkvjBtpYx+zTPgY6lSja3GsbIh4Q
 kLRQu43NxGhBIDw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Update neightbl_valid_dump_info function to utilize the new
nlmsg_payload() helper function.

This change improves code clarity and safety by ensuring that the
Netlink message payload is properly validated before accessing its data.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/neighbour.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a07249b59ae1e..b6bc4836c6e45 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2430,12 +2430,12 @@ static int neightbl_valid_dump_info(const struct nlmsghdr *nlh,
 {
 	struct ndtmsg *ndtm;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*ndtm))) {
+	ndtm = nlmsg_payload(nlh, sizeof(*ndtm));
+	if (!ndtm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for neighbor table dump request");
 		return -EINVAL;
 	}
 
-	ndtm = nlmsg_data(nlh);
 	if (ndtm->ndtm_pad1  || ndtm->ndtm_pad2) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor table dump request");
 		return -EINVAL;

-- 
2.47.1


