Return-Path: <netdev+bounces-94923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798B8C103D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0F1F23E5E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490DF15253E;
	Thu,  9 May 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBWWP9iN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B7F381C8
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715260717; cv=none; b=GzEvyFtWEPtDNPGGv2eqoMZ7B1YxwwCM5cPj/ZTEGfz5amjUluJt9GB42MmggXobaH/7ZHMVUpWDhZArKQXkmciXgeYpYvEGOeL92E8wGLxKD8cfRymDXDBiUgBuzCV+IDbun1BVrpqpohghbqr4oHTf3ZDkjPww5Bp5aE8R70A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715260717; c=relaxed/simple;
	bh=EQ0BcQGZwFrmsvSF8EhGx5oyhRvHpu0vS8HQj62opsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHr7DIvJmSpOSJoJVIqkKlNp1c9SUhjuaysSrTYfLfdvrv+HyF8pPzEUkN52oJ+NyqvU8wzMiajnm6B2tie5iPluN4dMDhDTldxuZX0u8S0iHEgmeica9jV9hJSppnOVJjqee+qPbETxTfH6DHIlk34J57Gw72B4mKlQUHhSIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBWWP9iN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecd9a81966so14218845ad.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715260715; x=1715865515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KtfIyfSFiA1iNWHSjF07hVa2in13vIiPTh12iYmMaA=;
        b=MBWWP9iNiyZRU89PokZkVmUe4NtIvergpGVKpIDbX/c67XEhdnmFkdGWJ4saplJ3uY
         GfVwrgEe4eFUNTNf9dgRRqYLhU18uE8MeYRBbwGDrrZOsQKr+VT44RDQ1wK8P4NJZOJd
         nAHjmtgGAvbZxQNXAGWncB8jdyAYzCNpcKipP0DcTiCd1Lfo+zDGdpmD9hyZLMAIWJXW
         8J26EU7Q1ghc68s87e56LapzKo979SEfGU9GCTJ8JaYpQkYsIUkD53QoeDGJCScL6kgZ
         FzZc8B+3vS4LfRB82eYZtLRmDUsbBEfzWturGH2asQJ8TcZZ2ofQaQ7EzwwfunQrUiae
         pAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715260715; x=1715865515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KtfIyfSFiA1iNWHSjF07hVa2in13vIiPTh12iYmMaA=;
        b=H+iOXJhXcQRZOVcD/e/F3zeB7WJnnx3L4xNWfT6uPS7xpz/YGe18DXIgy66sdGqMD4
         lxY7eSUd9V5aNeEY+25m6ZS6uH6MR7cympx7qj6k889vwCdMsxIAz/+P7sl/CAeV2dMV
         eiXYEiHMbpIBr5FVnN1aeFaEw25fy321fWi5taHcJ20ceZ89kO9M13DlQUVYAoosqKKN
         QE/r76ZeF6zqtlayAWzxPQ5J+/EHzJDlSG1LX1+3HnYIikUEz2yclVA2Yud8zwm3+Q0U
         enOJ1iS+EDSIh0+ilwspH9O4ppu8CGUzBP3GrumKVH/8tOSckv6vYWtHS32phzZx37tv
         x+gQ==
X-Gm-Message-State: AOJu0YxzBG8Xc6LSc6Eav2X8e4ZoikDdbJifP4rPpce0XNV0Cg++hZQj
	9V/1XdJXAZm+m7gRBME6WhDXi75RKig2EzwsaiivNn85Z0kvyKs4RZ2sDe/CRjY=
X-Google-Smtp-Source: AGHT+IGQnttX7ZwoFjPH+uami+Dte3VHX+qHv0lCRitZ94Q/JIMW3guu5HSXjeV5a/gqkwHxRqY1dg==
X-Received: by 2002:a17:902:e542:b0:1ea:482f:f41e with SMTP id d9443c01a7336-1eefa13a014mr41332725ad.15.1715260714842;
        Thu, 09 May 2024 06:18:34 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bada3d8sm13989055ad.99.2024.05.09.06.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:18:34 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/3] ipv6: sr: fix incorrect unregister order
Date: Thu,  9 May 2024 21:18:11 +0800
Message-ID: <20240509131812.1662197-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509131812.1662197-1-liuhangbin@gmail.com>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and
null-ptr-deref") changed the register order in seg6_init(). But the
unregister order in seg6_exit() is not updated.

Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/seg6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 5423f1f2aa62..c4ef96c8fdac 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -567,6 +567,6 @@ void seg6_exit(void)
 	seg6_local_exit();
 	seg6_iptunnel_exit();
 #endif
-	unregister_pernet_subsys(&ip6_segments_ops);
 	genl_unregister_family(&seg6_genl_family);
+	unregister_pernet_subsys(&ip6_segments_ops);
 }
-- 
2.43.0


