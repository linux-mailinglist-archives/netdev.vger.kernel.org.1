Return-Path: <netdev+bounces-175800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1598A6780D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5808A189BA55
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA32220E013;
	Tue, 18 Mar 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UHCvKf9m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7063120F078
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312201; cv=none; b=lYKlXKTAu9iwpS4SOG9o47ZntSQDSIGYEq41Jw4/+NgI3JNwC1r+tjv42bE6PDvaBUE7P7dXEqCLe6N2wZbBcmC6Q8eSwb5GTueJ25/SG5KjGTkNj2G1glQN+rbs/UkIwoPA8E+rdo9QT+TD4UNfqNoauSQr0iw1tXYMrtoKldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312201; c=relaxed/simple;
	bh=+OW+RtgKsRJs1bzFMDq5bzw99FZCh7zsF6Y14sSOP+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUW5+CshBDN5VdIrPJArAydNlUtYAFC90IYGq1J6E5M+ynBUyAEqGT9pR1K0RAMf5TQkl4IaipwFeMYl+yZ471vdhZoSuP19zWPm/cNiyizdqRzbp4CdRuyS/BbgX7hwRA5sOze+yUvZMlOMgRJA96DyBpb8QVHoHL2oJnYjMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UHCvKf9m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3912c09be7dso3935317f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742312195; x=1742916995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a128zcZc5YRGP5mY1JEmfIr8nMkvTHKg1+rmTOEaIJM=;
        b=UHCvKf9m4ONRBp7gNpP6ubvj20nI0TKA3XQJ/ev2vsb5Jw4O1qAlC2avbQzVKTXSzW
         LQje3G14CuwyArRFYq3wkcz3CFc56YnSkUT5AzgG8aJ+MglP3nslknBDsh/PHup2hHgW
         bIYXiw0F9W2Leu2hNKBqeXQmSbkAJwNV4ComPZW8PeyV15ZcCGScoW82jrLAyHXUOh+D
         tdImoB3feD/KA8X5ktAkg8vAERFVKkOQp5ZRFvLThMvnZTwQLCLuz/uLaQZkcyJAwb1D
         3wZY9jpuAnHMMdknABZ3jrkxMwLGFfF5tcWC9Xu8O/8XqR155oSw4HEqPRJjBoqOED/E
         KUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312195; x=1742916995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a128zcZc5YRGP5mY1JEmfIr8nMkvTHKg1+rmTOEaIJM=;
        b=ZMBqUyoCh613Zb3tgD/bbJGLc/+g1lqbNrMje/FSqBAynPZ7dt0mlmWaXEPrPVdra4
         mu3jAzTVF0sVEbqf89mB0+gibCd1s5GNN8/B+dHcZnI0cbc6+9DMk7VAC2I5E4chNw7/
         igX3Nml1sEj6OOAiHQ4jTEuWMFvqUlg3HZfgtS8f5QTGO28iHv61QXrZdHQ3KzbvXPpC
         OmoyCqy64sXsh55b+neCVI9nP2zhct762BLwlV2uAVhW2vA2RVM0LIeFi9oQcrVpBn/5
         B20dZbkPSnDSlRlivaRs8dcexnALuxNtftP8FQhy3n3JA2UdeZIbcGPGtHCnR/aVsBUR
         NxHQ==
X-Gm-Message-State: AOJu0YxYU0oTUhChIdbW38R0SXMruOmnSKhZb+eelzvGX6tsEXcCq3FK
	GNqLCb14NFOAUp6jmuuNeWZ4Q/OoxIUYAFD44qmMvOVDEKQzf4kTO5cFwe9CgvJfdB+7EzoS+oR
	N
X-Gm-Gg: ASbGncth5y8p2gHQb7yKeYmRoJbctiGtAIuhd+68Eul9gF2KDzUJylWq368HHB+UQ5N
	l2XIhkmKP9q4VF8k7w4d9UuNswuxy5Sk83tpP5Mln3uNVlKKC3uaAwPQH18sOeRg/mM46PYp7BQ
	hQU+kwj3WuFSvS+ovBeeq68/w3ucM0CBakwPaR7RSam25cqCkGhMYSjk1jSd0USyvW2Fnm8rJR/
	52SuyXVwrO+ocgX+xYftpbZoIoBjYQdduM1pRBwRVvgxESyVNmSwyHKNndBM+Jlxr0vt41m4sZE
	WcTvoIDeBScwXrS5huV9a7GFsa4pzst/HVFQGQ==
X-Google-Smtp-Source: AGHT+IGWJxy6nSnJUDah4rsKdnxjkwL9AkkDpmXb53JRF/p5WyC8VVDPVxtF494WtRd8LMsSaOQVxQ==
X-Received: by 2002:a5d:588b:0:b0:391:4674:b136 with SMTP id ffacd0b85a97d-3971ded2b2dmr17193156f8f.29.1742312194518;
        Tue, 18 Mar 2025 08:36:34 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df344dsm19001100f8f.10.2025.03.18.08.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:34 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	parav@nvidia.com
Subject: [PATCH net-next 1/4] ynl: devlink: add missing board-serial-number
Date: Tue, 18 Mar 2025 16:36:24 +0100
Message-ID: <20250318153627.95030-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318153627.95030-1-jiri@resnulli.us>
References: <20250318153627.95030-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add a missing attribute of board serial number.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..bd9726269b4f 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1868,6 +1868,7 @@ operations:
             - info-version-fixed
             - info-version-running
             - info-version-stored
+            - info-board-serial-number
       dump:
         reply: *info-get-reply
 
-- 
2.48.1


