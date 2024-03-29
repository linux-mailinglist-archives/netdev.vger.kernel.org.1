Return-Path: <netdev+bounces-83194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2789152F
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 09:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4A11C228CE
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 08:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B704C45974;
	Fri, 29 Mar 2024 08:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ7w7TE1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE524E1DC
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700942; cv=none; b=g2MrxUyoBTeWAHeRbnPuWsL+WDSO+6ajxbm2u0O2MdvRZ1VdXOhimVIz8SCveMe3kdSaJMl//WmhduDJJaI38FMJgmf+YApsFjIsYR8JuYe/mzVJutTQQt3YY0Lq1oFbCa8PFwrZFlVrWXTWKOY+3y4DREZME1dkP58C3OVZgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700942; c=relaxed/simple;
	bh=H4TEqdUVbh8I+Omh2NGLbbmus6qQx/nnFb3BZD9dHsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrS2cJ5vr5X5Y4SmLwsswnqfHfnibThMLQa3cw8AaujN5b5xwnYSkYbmAfRq91btWMLxYf4NRgl4qO52WR/773jR6SG2AFH94x6/ZA/7rSoRvX2m9TH4EpwIcycHEXqBR38F3GU3h9U4BdsVjQxGM9H5+l4gT5YTK6JYzXMrRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ7w7TE1; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c396fec63aso687004b6e.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711700940; x=1712305740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDj/WIGUGuQbjJfn4pkBI2FIlOuEIDvQborRQXjGDFE=;
        b=lJ7w7TE1zBjvO/TwQMOkookeU+1naG53crgJHGu+szwXDxadRY190GAVtaz3ZpJ5aq
         kOpsOmMuSfIaLcTDAyb79YvPLgxyeuujZla2RCMn1gmpIhXyvC/nNWLZ5F0QJl9+1Vz5
         fAdi+uGxqni46jXsMM8wxGAoy83wsfb7xSFUDFQQiPd+plV7y5kak14OPvfbtng72Eqd
         ZsMYouYiOt7zwMotL549r/2R1GCagFd0j82K0S0mJV/BwBPnaFx37Wjc+k0c/IE6T3C6
         rQC+EWGfqeBWexdjE55sOkq8X2YgqQirCaOUSEIzgBxaGRzNjVDM691nhpWlit7tI/sK
         V8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711700940; x=1712305740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDj/WIGUGuQbjJfn4pkBI2FIlOuEIDvQborRQXjGDFE=;
        b=VqOU3OWV+XzJuRzeQl+Kl5dTNevJZBE45ddEkIlPnfybFWE+mUn2au8bWIAKOBuDda
         vSbpndq3dvJKln/vcwF/FDpOWR398rZL6vXRPEcH3Yg1//OECGcGaVX4awjImJq0Qpy3
         FIKR/ykxG9aj/4ENNckMZ/+TJsyFLpBrgw6k+pRLXyfSTFCvR3de+Gb/AZlUU0ZUzwgH
         qBGpzWKB2Fnsn0i8lRDduriYi4QFA/X5BRcnuiyOLl+sRU5BvlReGd7OiDHSuQEqaTZX
         ejEQNWL2z6/MB1z1fuCMUwNCW2vZQn34sbWCVzW5OoOTkRhqUgmAKX7Kr0uaSkwMhTT0
         /asg==
X-Gm-Message-State: AOJu0Yw26GokxMlrhKWXMTMbtXiEtHmtPh3p34x2nvdLMynkoPE38lmr
	AhuAKhrRaRAqZ7xKXv6bmShdqfamtta8ElRm1YwxYVK4kTdkqsTEzRrYP/4JZpQeyeDa
X-Google-Smtp-Source: AGHT+IGhT9m1Uv7hItTGBa8XANLkom25bTWMu0oDcv7ApqjiR+GrUZI108ItY0f44DyWMnPCmu/swg==
X-Received: by 2002:a05:6808:320b:b0:3c3:d80c:ee5f with SMTP id cb11-20020a056808320b00b003c3d80cee5fmr2110317oib.51.1711700939913;
        Fri, 29 Mar 2024 01:28:59 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a000a8c00b006e5a915a9e7sm2656020pfl.10.2024.03.29.01.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 01:28:59 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/4] net: team: rename team to team_core for linking
Date: Fri, 29 Mar 2024 16:28:45 +0800
Message-ID: <20240329082847.1902685-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329082847.1902685-1-liuhangbin@gmail.com>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar with commit 08d323234d10 ("net: fou: rename the source for linking"),
We'll need to link two objects together to form the team module.
This means the source can't be called team, the build system expects
team.o to be the combined object.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/team.yaml    | 2 --
 drivers/net/team/Makefile                | 1 +
 drivers/net/team/{team.c => team_core.c} | 0
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename drivers/net/team/{team.c => team_core.c} (100%)

diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
index 907f54c1f2e3..c13529e011c9 100644
--- a/Documentation/netlink/specs/team.yaml
+++ b/Documentation/netlink/specs/team.yaml
@@ -202,5 +202,3 @@ operations:
           attributes:
             - team-ifindex
             - list-port
-            - item-port
-            - attr-port
diff --git a/drivers/net/team/Makefile b/drivers/net/team/Makefile
index f582d81a5091..244db32c1060 100644
--- a/drivers/net/team/Makefile
+++ b/drivers/net/team/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the network team driver
 #
 
+team-y:= team_core.o
 obj-$(CONFIG_NET_TEAM) += team.o
 obj-$(CONFIG_NET_TEAM_MODE_BROADCAST) += team_mode_broadcast.o
 obj-$(CONFIG_NET_TEAM_MODE_ROUNDROBIN) += team_mode_roundrobin.o
diff --git a/drivers/net/team/team.c b/drivers/net/team/team_core.c
similarity index 100%
rename from drivers/net/team/team.c
rename to drivers/net/team/team_core.c
-- 
2.43.0


