Return-Path: <netdev+bounces-246797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452CCF1359
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ACE930198DD
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1334D225416;
	Sun,  4 Jan 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFs6Qzgh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA1D30FC27
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552105; cv=none; b=rfbmaUS9r02nRy/0xprfuNOLsKOuTJNJ4vWckGdCRma52rRR7eFQArgJVZUD3trxWbDqZ2hGZ+zEiZtJrlpTjF8Fw54aQOSW+jQZwQ9+srb6CY5vNhhOQ3FwmnhyoKgwf0g6bQLEzyNFmrOVhBro6487PtPhWRob1ttRK/c4128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552105; c=relaxed/simple;
	bh=xTW7lVbfJsgnlziO9m7HRTBaTgvYhjTEK5XGbQnoB3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JvLJnIyFDiTfOywMLqSrzDq6Z5SqpxgHa0SNiJk8dYhqgCRsmjdL0pmWW4Q2dOvJWiv0zglfT0ulSulvoVB4pQasNO24Kk6t0dMWb52Fyfa8CMgDP7iH8zDLj79mtujcChGGoPVg6JFu8lKkJz6RKQyp6Onmc/tqhgZz/m4HqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFs6Qzgh; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-121b251438eso1787111c88.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 10:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552101; x=1768156901; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=EFs6Qzghey7xQ6Fcur0QLwvI940WJB8GnGr2SNvRWe39WZsSBZRiAl9SmSMEQkR+GQ
         70BZndiK56RDqkzGfMIUraEGzKAr4MdJjXOzpct3kVrPq9aj1LwXU/inH9NqI4o28FGC
         4dPjNRt4sP9HCT8eCJgcOTQ7wJdalG7Sq4UWPzJMX4K7KBSQb0Ed4lxRRDgliGHHdONn
         Ydv5NqPb58INBhoP98o2ja+AGm8HN9rcz+Og2TgklpV45Nb/G+BI9q8nOS37EV96apX+
         iKUfeHAQJs0XcO9ZsPxnqK4BlRsLGDMzqtO0VTPanIm+OyzHrTs54Fm9MANeXxkcB1j4
         mcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552101; x=1768156901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uKBmUb8EWfQ3VixqXwZwtOjhnNqHJe7y4QanLPyxD5w=;
        b=KR0glCxWTO4+2HP70TCrKmmU+0bUx8k+XEKlJBM+pTgVgFvnHQAW/7vvAsrNE00KUl
         6cG1u+ZthLLA3omaHOwPfkT6Pew4SxxYqMJ9upaYnukVk//1OEltB/j8Erxn4nXWGQaJ
         6+oDc4N3u+jJRmoVUKb8K91Fg+F8jWuBLSPyHxWsoi5As70Y7dak7U8ImBC8FRmswGhK
         nWKD5EFIbcwe4+sAo8NLI31WrBJlckavS7vRRZ3n/Wfe+9hqptq7FczbQ8kSjxpY7AZl
         VFwJwILF5wnZJ+pWa7j2JTRbXGE9khHHlwBedhfZH3+KEBnIbNgehOgyZlWR8R6rxdEm
         D95w==
X-Gm-Message-State: AOJu0Yy4xuUMplbek1YYZ0CDZP+9y1J0oySE9I4p5GYzsBkrl+El/QJZ
	QUx5SJOLa0VS9oLWtVYbOpC6uKnPBAFXbROzVTZl1EQwt4mMXuw8thQ5
X-Gm-Gg: AY/fxX7fw9LDDDLA3GA3y0TM0Bv0W5XRYCG3kzGXrz2kAvyOW5opUwtno//PE+0Z5Oh
	hWox+avfkdgRMXrVekLfhcLxZyAx0GzXXG6fknFedAtn+KtbRne61liOeOoW47i4hIhZywHUiGk
	LvGgcxeJjJAcFnHbUUEaEAzG9KGXjOk/MXRHK7lnUM6krVbKNXQfC4pzaFdWhryOmIq7lf+03bg
	wrYJqOlk8fv/UF8/RQPn7WbjRXkDT7ZwNWrJsIjYKHUY3Bpa1oQS+XI/9LxgwxqLMDDT3H2uV5a
	72EA0sk6vtAoOtTh628jKYc5y9Y/4VrVT230OmLaogm2TZL8ynO8zogXi7M1hY5y3NpllJ/OKSb
	OjSlQ1jPx7egoKOiSv0XWS3NruiJtvMsiMDrZAudvMC+01FDbvFOKAXEitY+adZy/Su8PatyZ8O
	IZEDuKWfnohvMM7QPb
X-Google-Smtp-Source: AGHT+IEkrerLkA/4ixjyUlfOE1XXFSRLs3hEvRo2xtxXa3LLm+JllqO1Z2sjIR8HVARMLkkwliMMxg==
X-Received: by 2002:a05:7022:4589:b0:11e:3e9:3e91 with SMTP id a92af1059eb24-121d80da9a4mr5164433c88.26.1767552101038;
        Sun, 04 Jan 2026 10:41:41 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:41:40 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:11 +0000
Subject: [PATCH net-next v9 1/6] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-1-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=747;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=BLduFEel2At1ZpRoHzUB/43M6t0wpDLHJLh+eokOBeA=;
 b=16wxTenr+y86Rt/Ag3RI3x399WrHWTY/kIyhlsFlYOMk5zACPlbx+jeBwuMORyjOODyzqYAE4
 84+KGlB10dsDrvpVh1t3elftkyBxiXuobe8zN7mpmcowQZ0MWrnvM+N
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9cb4dfc242f5..e2ec09f238a0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -119,6 +119,11 @@ enum sysdata_feature {
 	MAX_SYSDATA_ITEMS = 4,
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.52.0


