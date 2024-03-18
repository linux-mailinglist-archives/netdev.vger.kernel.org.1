Return-Path: <netdev+bounces-80321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A7887E583
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289D01F22654
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D071D28DD6;
	Mon, 18 Mar 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbtBOpCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE0A2C1AD
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753408; cv=none; b=BH89DeVia3sdI7K3/jhjm1foghRJWLjN3Fo1P9RdlZ0hMgzxil6Y/61FcI8L3U47cIr5/35gQ6zME8FYtsXgs4YJmatBz9eNdoCUwTLAO78ThZPKjX3b2Wsa5C+3HxE3cweNuszLLb+w7fE3J0N7+lA5tUfWIxJ1bANrg3JqyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753408; c=relaxed/simple;
	bh=Y/+BZp0HUx74axqH7tIyl7LXmAakHRYTWoDpHOll4Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mCJN+/mmEtzagM56K8ym+7OOqYgiZ1XAoFlTL0lxzPrG787Xu7LIAFLYpNHzUIsgZeb8ie7GDo7/FEeggSwzYHo9GqGieXbstv4XAdeAQy2DIsPha9vR67SlukgeIklsNQaeyzk6Cr2PxRuMa7RusNGV3Crsbw9piCVN6dAjYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbtBOpCb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4ae08a01dso291811fa.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710753405; x=1711358205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QWxRWwV/uq07b1YQ7XIxT+IL0A1zHDVvbvD4jvjSWQ4=;
        b=kbtBOpCbz3P6qcX/toRhs3vAkIahbha6QhQveLvxZtj8wL3n9R3blaBHB71EteJl+8
         ROxyGRHq748jlQ9hmCwCi8YHMC0UBgmLAtC4FXVyl1qqJlB+TX0ExxKsao3xQBuBNlkp
         a+A+BfroxpUMUmFGEqu+OhpUPiEKcAUU/tE4HBzoukaTUXYkUKynywXULgcJhqcWse4A
         cN5QT6sULJ3d7Fn5/G6i2rEgfBw92HIm0SUBOCFlHCN9lq0O/PplxNP+8oBlJjeNIw4g
         HmiR+okqDv0uYBERCZAJMU5XE4kBwOWK/RSjeE+8UO6FuB+KaWuHEfr1uJ2OG77rsek5
         ex+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753405; x=1711358205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QWxRWwV/uq07b1YQ7XIxT+IL0A1zHDVvbvD4jvjSWQ4=;
        b=h3YSbCsRWWT7+QczHS6YTf/LuBRLa6xKHSqJ8/qFyE1y1FgAxxd7mZJszBuZrpO0JH
         nb/p0ImjaWNgp96jbM8AtpajvrBOkxnTMNL7EUUhGy9Ush/gSuBvbWj6Ypzy4uMOAwSW
         7jUJLn/nvFToNDAiTffUlpxvdo8bxCB4hpv/YHdBsUo8Li2p0cd5N9J3l9fJ9+qR6s6s
         zzhZQbESdXDu7cvbfz5gqsINtT4LGKIW656rQOonr6HM2VfPC+Q+HHx2KjlrLoxbpXVv
         4vZcQVVbMDsaO9nD4Hry/Drr3ZO522IGzAUitBcMvkUyKm1ZAG93NG9K+iyPgFURDva7
         7O6g==
X-Gm-Message-State: AOJu0Yzb4WB//XMMWaggHpnCMWXQ+1jB+SdJxoa77VDmVxHXh4SPyFVj
	/Mi9cMZ4ha5z9EdJR5EqqbYUurv65PZgULNVW4fBf3Wp86qhUkvt
X-Google-Smtp-Source: AGHT+IHS7atLqJzTsFxhfTz8HofXBBFmJuZscTNnwIOsSADotQfGHrO4biIyJ046Y/No/D/8ptc4rA==
X-Received: by 2002:a2e:a989:0:b0:2d4:7f17:185d with SMTP id x9-20020a2ea989000000b002d47f17185dmr7984871ljq.0.1710753405196;
        Mon, 18 Mar 2024 02:16:45 -0700 (PDT)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id a39-20020a2ebea7000000b002d4746112fesm1416010ljr.38.2024.03.18.02.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:16:44 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] ifstat: don't set errno if strdup fails
Date: Mon, 18 Mar 2024 05:16:40 -0400
Message-Id: <20240318091640.2672-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the strdup man page states that the errno value
set by the function so there is not need to set it.

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 352e5622..9b93ded3 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -197,7 +197,6 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
 	n->name = strdup(RTA_DATA(tb[IFLA_IFNAME]));
 	if (!n->name) {
 		free(n);
-		errno = ENOMEM;
 		return -1;
 	}
 
-- 
2.30.2


