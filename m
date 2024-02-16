Return-Path: <netdev+bounces-72365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 084B8857BBB
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 12:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E51C2197B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89A77F09;
	Fri, 16 Feb 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iWu99/2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1359B54
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083115; cv=none; b=GNL/BnAEpZ+wxDwJ2owfSmgNzCkLhVsJMwz7TfrkrZYUp5AiyVHUaE22WFPFB4t8l3G6kYh4+Zo2vVhC+KH3Lg7stAsA+IeUnc+GERJnTLQbyp9R4mT2jySqENEv+vbTWzLCGCJTw9yYSaLXR2chDAd5Xybppr3beHpma0L7u5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083115; c=relaxed/simple;
	bh=x4a/tf43SYwAyXSNT3Y0mvvq8ruGltxxWUk/AN760DM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBQx3Ydkhdpm8wQS5UAy14hU0pbxrxTjbl4ml1ZqHNCihMsrXfEkOzXSrc/fKObdBnvo/4MPBqjYw7aFU6zfUmvQUApVKZL9savRWPdJ3ZvWDOpYf0l4cvc0K5JgxJk0YtOAcv/5NgSCGOTR37dtbR5OK/TiruApdRG4Ik/uZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iWu99/2L; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3394b892691so1282210f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 03:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708083111; x=1708687911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiiHKDcOiMXGmzdIXjXYceqWaWZroHQbJqSietsv9iA=;
        b=iWu99/2LEs2qhW9jKM396/z/0KV64ZRy7r+086WeLphdXfrzI4r0AiO28s+dr6veQX
         WOeRRlll9dXrjFGYgsyEZHDnpRFc61aMuEbw1AWmtFq9nj63jRkj6tR5wbrFTsa1ezD6
         nhy3tV70SZqLk1X8y4xhaGtHrWRTClR3iBIV1bkCy0YHZB+Qzdn0yQLymNo//Ng0lRP9
         hsoYt/uzBxp/WGNwckbPmJpoQ+ZLDZxE37Z7tlj0qKO5JmS92XJDHi51LCA2uQGW99Yy
         Ihft9Mh0XrM+HDeeIbV8eV1BCPPdiIo3CXWAz/pEIQN31lMvAQ6a8lN9iiO2diTn3aEh
         BwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083111; x=1708687911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiiHKDcOiMXGmzdIXjXYceqWaWZroHQbJqSietsv9iA=;
        b=V44E97ZKA5TdSL0tdnBYiARUHrFeliN7NxJNbWFMThMCg9R92pALFSwY7yagRkD7I3
         JAWMYZ/JioQ5e+AQkNGDwp19wnzuYHsoTsdLARHXdUZpftiGrVOF9bvEME6C2+rr2koI
         JW31VJXLAnqfdB5FoDrMSMIsOBbgf1Ju2I9QYrlBfgHRNqSIU/ZO6AcotcS8Sq1qKdaP
         TxguolqRY31uk7IbqpYXZvpbAgaofK5AljGQ/z5bR/vBmiseKJsvG3JFjFRFIP4TMmhq
         pN0dZ9tsFMwvJapPqhJoamvgz6LFmuR/IDyoN/i4v/O88XijBMNN4++KYISwm8DepGYr
         iOdA==
X-Gm-Message-State: AOJu0YyG5cLM0b00b9TH7eOAvVsjWA505BPv8gYAAB2PrD+V/tPUeaPk
	Va87iQnDEBwYQuElFBs/CcPnKAfMfol9xfSldw+sFhU5qvB7pcySr4LbtwXD1tvSl9ym27LKxk+
	a
X-Google-Smtp-Source: AGHT+IE0nsI3miKo0yzm8pYwVcDkJYD+XwOFilm+O+3j4JzMDwf7vLS7l7JqYA9Mpyh/54yFnp6rdQ==
X-Received: by 2002:a05:6000:104d:b0:33b:4c26:85df with SMTP id c13-20020a056000104d00b0033b4c2685dfmr3098998wrx.35.1708083110768;
        Fri, 16 Feb 2024 03:31:50 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d2-20020adfef82000000b0033b75b39aebsm1995850wro.11.2024.02.16.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:31:50 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com
Subject: [patch net-next] devlink: fix port dump cmd type
Date: Fri, 16 Feb 2024 12:31:47 +0100
Message-ID: <20240216113147.50797-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Unlike other commands, due to a c&p error, port dump fills-up cmd with
wrong value, different from port-get request cmd, port-get doit reply
and port notification.

Fix it by filling cmd with value DEVLINK_CMD_PORT_NEW.

Skimmed through devlink userspace implementations, none of them cares
about this cmd value. Only ynl, for which, this is actually a fix, as it
expects doit and dumpit ops rsp_value to be the same.

Omit the fixes tag, even thought this is fix, better to target this for
next release.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/port.c b/net/devlink/port.c
index 78592912f657..4b2d46ccfe48 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -583,7 +583,7 @@ devlink_nl_port_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 
 	xa_for_each_start(&devlink->ports, port_index, devlink_port, state->idx) {
 		err = devlink_nl_port_fill(msg, devlink_port,
-					   DEVLINK_CMD_NEW,
+					   DEVLINK_CMD_PORT_NEW,
 					   NETLINK_CB(cb->skb).portid,
 					   cb->nlh->nlmsg_seq, flags,
 					   cb->extack);
-- 
2.43.2


