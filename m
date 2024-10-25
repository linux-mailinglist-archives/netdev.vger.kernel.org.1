Return-Path: <netdev+bounces-139129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B89B0592
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3C21C22DBE
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491FF1FB8A1;
	Fri, 25 Oct 2024 14:20:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC82022E9;
	Fri, 25 Oct 2024 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866046; cv=none; b=eFRvGO2imeVMkFFMceiZeMfCSDVDeJwmBKmbAI2mEhXR4XzBIfxezFQfxtmp5PFNVbILMpdnwS6HfcdqNF91HAKye5wAnXvB5w/NX0kR1bTdZQYpyS4h984x1SFThN3IqBJfRbikpr7+ibqzVEYfkwTx3LBYG0WizVvrIVPbFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866046; c=relaxed/simple;
	bh=AL33S6aqp2+Me+OST8v16scKbzzI5Wc5/E5yIdnk6Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3O7rZqLbfNQLuN54or+oy7vkqUlD89kPuGIHQlY3GARjSgEu8TaekGFIlwEbrBSFCmXzX4uy+ccHDNpjlwheAAvfZiLngSOdjkYQYbG/W7IzXbnNvJX2FybKygfEkEoXJGz1gIM1Do9m02CPYECzC4adx0wDI+aH/gcDH6tWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a2cdc6f0cso288864766b.2;
        Fri, 25 Oct 2024 07:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866042; x=1730470842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57KDVzYSwEIQctNDCcs9zd4Yx9d1EFMi2Kt7CfrtltM=;
        b=pcppgehPvJCyEXuH0HG/4/b9Ip4ANhnOVvKqCir52M6cTM+zAsQrGnRQ4QEwRqvrKM
         B7ZZn7db3xu4UMCexZSvosuD/T0b79D6JcgJByn3gERKvSyVxqw1lGRtSgbQypSOKcrq
         h8DCTiLpEPUnNxhUHIhaGnIFTseQoBDBJZddMVUxdKXHKZa+69QIXi680TWlfRK/6wEN
         EggEXyThAX33X5EJUF4sI+il0e1ZpNrN9AC+lPdNAbUBmPv7hE5VqCfocEu4/ApnlOAI
         kDecvF/lfOxqTXoEGmECwquT6GylC8XSGmRW77H9gsV8v7e9fuKkWn+aTAAF/gPodoWE
         L+cg==
X-Forwarded-Encrypted: i=1; AJvYcCWi+rKjSRVhLcbYAONl3pmOF1lXPnkss76/c4Bzs1LIG8cy46HZz5uMijZqcX5nYWVCE5fp8qbc@vger.kernel.org, AJvYcCXCfXp9rZueOpIecF7HRtA2Q+gvx/Apdz8tQQIIim4nXlhZ8W2f31Y1eHUbvIC9wnPT+0IQCVsR7WCfTWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5DNZmob2A+LnDQvluPMv6PAhJlmO7NCVeE15D7Bvux/tzAlb
	eqrC1gtGgjU9nLxD1Dy/fPqkkfujJgxUCKDmuj2P7huJm5827vir
X-Google-Smtp-Source: AGHT+IFUl1d1otlSP2l0kzq0Mxj1GCgb7HSwX85GZgsdLHF2rLlTRyhtRxvX8C8tnkQGmm2HP4J4/g==
X-Received: by 2002:a17:907:9484:b0:a9a:597:8cca with SMTP id a640c23a62f3a-a9abf92f3camr977454666b.45.1729866040871;
        Fri, 25 Oct 2024 07:20:40 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b307b53fcsm76881166b.148.2024.10.25.07.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:20:40 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	vlad.wing@gmail.com,
	max@kutsevol.com,
	kernel-team@meta.com,
	jiri@resnulli.us,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	aehkn@xenhub.one,
	Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population until setup success
Date: Fri, 25 Oct 2024 07:20:18 -0700
Message-ID: <20241025142025.3558051-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025142025.3558051-1-leitao@debian.org>
References: <20241025142025.3558051-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation has a flaw where it populates the skb_pool
with 32 SKBs before calling __netpoll_setup(). If the setup fails, the
skb_pool buffer will persist indefinitely and never be cleaned up.

This change moves the skb_pool population to after the successful
completion of __netpoll_setup(), ensuring that the buffers are not
unnecessarily retained. Additionally, this modification alleviates rtnl
lock pressure by allowing the buffer filling to occur outside of the
lock.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index aa49b92e9194..e83fd8bdce36 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -772,13 +772,13 @@ int netpoll_setup(struct netpoll *np)
 		}
 	}
 
-	/* fill up the skb queue */
-	refill_skbs();
-
 	err = __netpoll_setup(np, ndev);
 	if (err)
 		goto put;
 	rtnl_unlock();
+
+	/* fill up the skb queue */
+	refill_skbs();
 	return 0;
 
 put:
-- 
2.43.5


