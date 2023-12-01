Return-Path: <netdev+bounces-53028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD21801229
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364E3281838
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990C4EB46;
	Fri,  1 Dec 2023 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VfiC+jfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B3DD
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:01:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3332e351670so1159863f8f.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701453717; x=1702058517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9UBHcbxzufUnUwywErPHJ7sMKwzSgboT8ep1LICL1s=;
        b=VfiC+jfRSZyz9urAWD6tfFtuW8fVL1sc+TAiHtQBaneQTAIDeLO5cKJ8nvvIftV2Wp
         Btr0TlKGFutKDHCrtc3hcWVPGTPuv3KgLRPxh7ealPvkdE3somsrDjuGhpZErAVLCwP2
         06u6K+HcVaZA7pOFsXCaqOEHCNw2XAJjgqdhnTdlRbDVlc1hONmqOz5YN9rn+HfMABit
         xx78WVwcnDv5IKoVfAKuta9ve+kjTzt3/D3piLyKARBtBReu0pMdOifNAIBX2M9jUYg8
         UoV28pdkEu/9ODjWblTwswm+mGOTmkhLDPx0JRU6ELvIMNO6H4nSLk8EgquQY1m4lvnb
         GfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453717; x=1702058517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9UBHcbxzufUnUwywErPHJ7sMKwzSgboT8ep1LICL1s=;
        b=FuIpR36TZSUBabU4Zos4RHTcRy/UK3xXuunkrtucojvNgCMJLOM7rb5Rq372CRxNVT
         Vjog+MoKmNcvnACyc7YrLtTiJHb3LEjYa0n2+oav/Gxa5b6XZt8lBqp+gBzRiYEudJUH
         VnT1J3WZTcyzOdizlGOLaKMHv+oYkolRr0I85rrb7qaUthjQAgUPS4TKtpjxDF3nrvWS
         jXyThTHTPJCVk2NkXilqqygGlWgRLDXSyBa+aHL+bZoly6YaMVFeY0sYWtaadzBsNT3n
         7X/Ou172LszDs+gkNJ5CzJH7fK5YJvkgmDV00Tsqrw8YGLGw3eiaBD8v3EKDKLlVislF
         Fsbg==
X-Gm-Message-State: AOJu0Yy/stzIJj1V72dwef1WhNNHo5izaZb1EvDQ9LDCzw1nEqgTWKku
	DeQMAqVxLWtco42MhedXgtB/ggkdGrn06S3hGDc=
X-Google-Smtp-Source: AGHT+IH6F9pT69ihraaspOPy4zUIC8Bon9s2womKlerMT9NKidY30a6KT8q6fNVwu4tNgo48l2Qn3w==
X-Received: by 2002:a05:6000:114d:b0:333:3117:c46d with SMTP id d13-20020a056000114d00b003333117c46dmr491161wrx.254.1701453717311;
        Fri, 01 Dec 2023 10:01:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v12-20020adfedcc000000b003333471d94esm1151815wro.90.2023.12.01.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:01:56 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	corbet@lwn.net
Subject: [patch net-next v3] docs: netlink: add NLMSG_DONE message format for doit actions
Date: Fri,  1 Dec 2023 19:01:54 +0100
Message-ID: <20231201180154.864007-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In case NLMSG_DONE message is sent as a reply to doit action, multiple
kernel implementation do not send anything else than struct nlmsghdr.
Add this note to the Netlink intro documentation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- s/avoided/absent/
v1->v2:
- Changed the note completely
---
 Documentation/userspace-api/netlink/intro.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/userspace-api/netlink/intro.rst b/Documentation/userspace-api/netlink/intro.rst
index 7b1d401210ef..aacffade8f84 100644
--- a/Documentation/userspace-api/netlink/intro.rst
+++ b/Documentation/userspace-api/netlink/intro.rst
@@ -234,6 +234,10 @@ ACK attributes may be present::
   | ** optionally extended ACK                 |
   ----------------------------------------------
 
+Note that some implementations may issue custom ``NLMSG_DONE`` messages
+in reply to ``do`` action requests. In that case the payload is
+implementation-specific and may also be absent.
+
 .. _res_fam:
 
 Resolving the Family ID
-- 
2.41.0


