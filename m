Return-Path: <netdev+bounces-66147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA2083D820
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 11:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E812974F5
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136A11401F;
	Fri, 26 Jan 2024 10:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI36CV8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B61BF43
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263979; cv=none; b=liInvvfQLK/vPAImQQohuMM6fwET9DYDVypEVrIbfa/5qPZVamA+tYFg5iaoKUwJsRoeDcceCFL24kwJhmLGzkxtMmjpMvfsB/yU6ZdkWyMI1ok4cR87HamO9md8Ae65tpbleSTBLE/8+5OM+Pyh9x44+u0Dyo33SpiJsUksAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263979; c=relaxed/simple;
	bh=/5yfAr/RntdBSIKdrpsJAd4vk4e6HCgLOuU8HL7aqRw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dKKa5wbfINu7qBXHMD/75OGOF1WGoS6gBnKahyKIKX6zhsk4OT1866LspcE88wT2jkc/90hMWsKlJMJvTvg49krzEjVPnb2t+MCXVOfi1x4Xa/PmE7JbtwydCTDwNy2kQ/JvJsVyxGpujEOyiEoixI/8Gd7H9g5iAnZtJr/h9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI36CV8s; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e6c0c0c6bso50879e87.0
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 02:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706263975; x=1706868775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwGLDP/ShF46MV5S8tZnfLEnUP0PzEjFne7dn85EbpA=;
        b=BI36CV8sHz4wRB1mpE8v2F7CS27n0DcNM+wNi8E3PGsbmeTSiNLJhJNe/T7iw8iLj2
         PzTfDzWDG1j2upUg33GhdmuwYOCaGRPg09+pIsHq9tvQN1VcbQ8SGIGNXfLyUZEAGjuG
         0vEtDgdOndrHJ8XDnBNuf0ZynFD+ImPeFJOppf59f5suiKUr8xcwNF59NH3hzT4Gq/EF
         sS3pX7gE89DiYn27QJVPzAlQUDFMF3YM+ZxLfrkSICrkWQKAUui9W7VLFLRU6Y4xVeBa
         RwT23kuT+gpP2ViimPp5nOyUtg1k+Pr7Cuw+2a6Aa5VHpK2RQuAoMedIm8R7wMphnuRX
         Xyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706263975; x=1706868775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwGLDP/ShF46MV5S8tZnfLEnUP0PzEjFne7dn85EbpA=;
        b=ZyNYcUGKPc0H2z1MyjIxlhbfyFUpDuT9i/Y01LL/jvHonF2WN3D1yEFKbLbbYYbK6l
         BE8dgKr7IzmUbnnizZ38iTXLKl8lNEtCKyCOHigPc1Y37ZU9o8XpxfLm3CJiFULy5Fa1
         Jf1S4wUR+j9LnHsCWIwjyw8ioMYtFk7oQYkwYqOIaVydFKfwvJafP4fx3es/JshD0+NG
         qzdwda2MkL+0KbTd2XmBuOlOOkD4Nlmy8DrejJ3+12agYhcC+X0OyBdhmQo3+T1NQeIq
         lG0r8iCnOtijSeibZ6j/x4xsfaNomxAR5EKGU4HAtOg+7FJv1l6RyrjLKBXdDdnOja6r
         c2ow==
X-Gm-Message-State: AOJu0YyeFOG0LM6b4vbxiSHh0m7hBnuzM7C0c5HzsaNytGnyIz0z0dul
	52ok4xZfm/vfN0hjgLFN0bhWBxkaOs+2wkAh/lCO+/ZQCCIl2TVpmUnL0PlIWutJCc74
X-Google-Smtp-Source: AGHT+IHBoU+AbhZ8iqIgFVR6Xc5ykjJR3UGlBkJX0CHerS6OLb90h1TsVjppUKmOHesbFe6dSN0sAg==
X-Received: by 2002:a19:641e:0:b0:50e:7fb1:6456 with SMTP id y30-20020a19641e000000b0050e7fb16456mr1424048lfb.4.1706263974848;
        Fri, 26 Jan 2024 02:12:54 -0800 (PST)
Received: from localhost.localdomain ([83.217.201.225])
        by smtp.gmail.com with ESMTPSA id cf3-20020a056512280300b005101392d314sm131465lfb.150.2024.01.26.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 02:12:54 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <denis.kirjanov@suse.com>,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] ifstat: make load_info() more verbose on error
Date: Fri, 26 Jan 2024 05:08:55 -0500
Message-Id: <20240126100855.1004-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kirjanov <denis.kirjanov@suse.com>

convert frprintf calls to perror() so the caller
can see the reason of an error

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index f6f9ba50..721f4914 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -117,16 +117,20 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
 		return 0;
 
 	len -= NLMSG_LENGTH(sizeof(*ifsm));
-	if (len < 0)
+	if (len < 0) {
+		errno = EINVAL;
 		return -1;
+	}
 
 	parse_rtattr(tb, IFLA_STATS_MAX, IFLA_STATS_RTA(ifsm), len);
 	if (tb[filter_type] == NULL)
 		return 0;
 
 	n = malloc(sizeof(*n));
-	if (!n)
-		abort();
+	if (!n) {
+		errno = ENOMEM;
+		return -1;
+	}
 
 	n->ifindex = ifsm->ifindex;
 	n->name = strdup(ll_index_to_name(ifsm->ifindex));
@@ -161,8 +165,10 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
 		return 0;
 
 	len -= NLMSG_LENGTH(sizeof(*ifi));
-	if (len < 0)
+	if (len < 0) {
+		errno = EINVAL;
 		return -1;
+	}
 
 	if (!(ifi->ifi_flags&IFF_UP))
 		return 0;
@@ -172,8 +178,10 @@ static int get_nlmsg(struct nlmsghdr *m, void *arg)
 		return 0;
 
 	n = malloc(sizeof(*n));
-	if (!n)
-		abort();
+	if (!n) {
+		errno = ENOMEM;
+		return -1;
+	}
 	n->ifindex = ifi->ifi_index;
 	n->name = strdup(RTA_DATA(tb[IFLA_IFNAME]));
 	memcpy(&n->ival, RTA_DATA(tb[IFLA_STATS]), sizeof(n->ival));
@@ -204,7 +212,7 @@ static void load_info(void)
 		}
 
 		if (rtnl_dump_filter(&rth, get_nlmsg_extended, NULL) < 0) {
-			fprintf(stderr, "Dump terminated\n");
+			perror("Dump terminated\n");
 			exit(1);
 		}
 	} else {
@@ -214,7 +222,7 @@ static void load_info(void)
 		}
 
 		if (rtnl_dump_filter(&rth, get_nlmsg, NULL) < 0) {
-			fprintf(stderr, "Dump terminated\n");
+			perror("Dump terminated\n");
 			exit(1);
 		}
 	}
-- 
2.30.2


