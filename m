Return-Path: <netdev+bounces-86047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB3289D596
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC79C285374
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E63E7F495;
	Tue,  9 Apr 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqKD3sS2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042880024
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654939; cv=none; b=I6a6sQ8WrY/qz07dmThv2uAvm2T3/mn9HAPM/AZWGjkWi6JPD9xkdS7br+ibHJk1DYfj8gT1oDVgJ3Uzgla/hxBELSey5Ary0VV6OClcL6xjK5CnmZKQWpbuM38W6ZfSzyiokM5gcQJavkQzAjYFIcb85kWPFFH7cNPJWQk5dwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654939; c=relaxed/simple;
	bh=Zg3Z27ZRnUWauluXhILXsQKwKSMray0vEOe7OhSrRM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6rDO7pVtmCEZEhzanDIXIMLTX8oNpjco6Ga0ydWvkAPE+IQx7p8FPkmX/Qe8X/atmqEg2tqDNJpYIfP9PkqbG/6owMnp1AM7yR5e7GWcQilNOw6YEKmEt7iVqT4Fjo/WmSucWgJXDWhToS9VibnUZuIYkGJbJ/EYKigAaW+8u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqKD3sS2; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea1189de94so1603109a34.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712654936; x=1713259736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEETWeZEnir0mHNgtGB6XSEuTRTwk6na8LoXtdLsqPI=;
        b=AqKD3sS2iu8rz7oRpe8HmLdBxyAK4l2E9Gv+vyya9p5VEZuD4fZGozqPt0MrznpFwZ
         XvT4rEt0vsyKv0XbidkEKuNSfh66XZgNaazKnbZa4lTgMtvTR2zDDajhPmE20ecIQnBk
         B5zZpBm289MiHs8mvokIwtHyG/P3HmTU6xTaMeiBFaXSfS/BkC5CA2FXn+lOm3IP3+DX
         KfHtGEP3LjmLA+SOnRxkibLs9U1A+ybbf/m61+gUjyxQPYOE0VgYkl+6JXXpt5T8oU63
         TDURLiPYe4RxhfkoTztDMvtX3iN+RvJtDzNBFCQe6Ce6WRjXDTGqIyFp938fMd99byl2
         dHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654936; x=1713259736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEETWeZEnir0mHNgtGB6XSEuTRTwk6na8LoXtdLsqPI=;
        b=FwaAafnasinwGKuNV/DRpanEJE3JUWu0g43MU8MXbx1jw/r54S5yqBD36X/Slqd7Zk
         uahbnvoCmhW68lnasfrsOiyu6lIvnX1RobLV5A+LHVZdnUyVzK1oh83mhU/EKpMOPBWo
         dG663vPk2JShq5oHSOeJ9BebTfPyBWXlUE60Wi4IS90KRg7ktlrApLwqiGy59REwsi85
         s7avDD4dDhdPdFYBxU3UsUnMhD5P7shom/N32JqslYf7UWwyAD2cbV6K6mZ/CCxGS+zd
         9VDaW47Zi+PZF92Kp//SJWDpDSr4a7f001dsJooajlfnPmq0XTACZyby4DrFn+5nW0aU
         +ziQ==
X-Gm-Message-State: AOJu0YyqRM0odj7BtxlUgwQidY+pmUJPX4nhiHX0w/l23f14I/kNcmru
	dCc0rSti/m2tGbIbM//SM9gGdRLDrn1pGgUm8G0BLNkWgITgKRM3VoVx35UBrT1e8iia
X-Google-Smtp-Source: AGHT+IGdmvsIdzyXMep78Oz1eomqHRFtYxN+/zPAX6KxakDwmGO0hDDWgvKTbQa3gR7tnfMhhgYXuA==
X-Received: by 2002:a05:6808:3088:b0:3c5:f0b8:d5a7 with SMTP id bl8-20020a056808308800b003c5f0b8d5a7mr6668956oib.54.1712654936249;
        Tue, 09 Apr 2024 02:28:56 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g10-20020aa79dca000000b006ea80883ce3sm7806702pfq.133.2024.04.09.02.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:28:55 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com
Subject: [PATCH net-next] net: team: fix incorrect maxattr
Date: Tue,  9 Apr 2024 17:28:12 +0800
Message-ID: <20240409092812.3999785-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maxattr should be the latest attr value, i.e. array size - 1,
not total array size.

Reported-by: syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com
Fixes: 948dbafc15da ("net: team: use policy generated by YAML spec")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/team/team_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4e3c8d404957..8c7dbaf7c22e 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2808,7 +2808,7 @@ static const struct genl_multicast_group team_nl_mcgrps[] = {
 static struct genl_family team_nl_family __ro_after_init = {
 	.name		= TEAM_GENL_NAME,
 	.version	= TEAM_GENL_VERSION,
-	.maxattr	= ARRAY_SIZE(team_nl_policy),
+	.maxattr	= ARRAY_SIZE(team_nl_policy) - 1,
 	.policy = team_nl_policy,
 	.netnsok	= true,
 	.module		= THIS_MODULE,
-- 
2.43.0


