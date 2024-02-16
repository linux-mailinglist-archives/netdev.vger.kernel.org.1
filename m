Return-Path: <netdev+bounces-72417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D8E857FBF
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD433B22ECA
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3B12EBEE;
	Fri, 16 Feb 2024 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etWEotEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC5812EBD1
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094989; cv=none; b=WBnfTdIqjqEyBZLr23aHJi7uEqN2VZMTnChrrHNRD2W56ISAuD0s4PPeyyeDYz8y+Z84LijEahV4YtD624trtRr+4Z9XhX+/qjSMBV1Ih1M/IKUrBBHh7LUyMaFcmysHaGnOMX0SWeqkXY5TGxu7+RnZcUhHyeuGMrci1iK/bds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094989; c=relaxed/simple;
	bh=7h6t9PGTWdjxq+avVfOhfHS2NF7OnA/etJRkxhfcr4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tYp94Mc93EWI/GC26FGfFI2CYoiTcGJtZnmQ2D8wxQyMvDQOWCj/UtG21u5JZOjr4EALET4k2SOajEVkQBJ/cbG7mfjqAF4ZKn37JXDM4UW2tWURckYLl1/6c45NvaYIHhkjpeIEV/21AJt46raYaLcdJ7i2PU3uByYKGTBUfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etWEotEz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33aeb088324so1103338f8f.2
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 06:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708094986; x=1708699786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lXwDBwyW2yCdyPBOFmRBQ9u/0dgGN6e9gwGiJLRBTvk=;
        b=etWEotEz5Kp47NTLcgro4BlCZLsgaq2uE0H8E+tiOh8F/EbuQ/T86UJKkB/3slJmZ6
         izb+OlmHAL2NTt9pEjk4XNKItGm6RNoO/JAlv6c8DRInkxZrGxOhWR5ctMioYAVFFQsO
         pRxXmYFg6TSWb1mZTiSXAKoFYBwZ2PqYSUGK6t15MET+K0O0o4nqtGSQnbbDVZAAMfiX
         2jkq8MH+e5BhrAUO+FFAKRt8iJAghiMP6wJUUlEd0x/iqNMh3Zu0tOxp2Gx6YponCVBt
         F+KKMjSJcvsUZcnh+a89j06zDC67Xq4s/dSxc/FRY9FDzYJ0OaPMAgAeR/vtkmwpIiVH
         He+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708094986; x=1708699786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXwDBwyW2yCdyPBOFmRBQ9u/0dgGN6e9gwGiJLRBTvk=;
        b=oiqQ3mioE+wSrGZIrtfINYL3Y8cJxc4dOdByTVJSp8YnBOgwwg8njVI4V/4sfp+qkg
         atkx+rN4bU/u/uavc719p3mhzjjQ+sKjES4n0x7RL/5NjFs9nCLLM9mIwsavAWFjieMX
         XtacwzKjxutn795Rg042IQy/974iTg5Jvh0LwCNEqKjz2CUPFa6Kknqmd65fSB1WRQgM
         DGngwP+eoC7vxHVfYrUSm0T4TnMZ3AFu+hudvz0/IrRxJiiyXo90L2bSZ+f6C4IOph+i
         nVTLKzx5VKoUZSBppO3/m4PxRcZQbTK/q8MYKdw7ZK2oHZOSKEx+tD62XprFniw4lv+B
         C7/g==
X-Gm-Message-State: AOJu0Yxh+DEy8DFVoAZpNHxHqfFBl0WdMCzgN19C1LhgZV0cEmLgnyj7
	a4g+6tTXkTq0HPu60nZQ6ya8i+JDDXcB/u2x/0IT0ZucCoBOWMr/fXVZ0c5m9G8=
X-Google-Smtp-Source: AGHT+IEqJJGFWMknVyZf18tb4V6HxkorlafNBosNKdtp8S0w9l9Zjv+FgH4do6mrRsfQFFVCBhpwag==
X-Received: by 2002:a5d:6643:0:b0:33d:26dd:8c4f with SMTP id f3-20020a5d6643000000b0033d26dd8c4fmr135888wrw.23.1708094985701;
        Fri, 16 Feb 2024 06:49:45 -0800 (PST)
Received: from lenovo-lap.localdomain (109-186-147-198.bb.netvision.net.il. [109.186.147.198])
        by smtp.googlemail.com with ESMTPSA id bs18-20020a056000071200b0033d27491b80sm56027wrb.33.2024.02.16.06.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 06:49:45 -0800 (PST)
From: Yedaya Katsman <yedaya.ka@gmail.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH] ip: Update command usage in man page
Date: Fri, 16 Feb 2024 16:49:39 +0200
Message-Id: <20240216144939.2585-1-yedaya.ka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The usage in the man page was out of date with the usage help, fix it.
Also sort the commands alphabetically, the same as the command usage.

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 man/man8/ip.8 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/man/man8/ip.8 b/man/man8/ip.8
index 72227d44fd30..cc8a61e18ddb 100644
--- a/man/man8/ip.8
+++ b/man/man8/ip.8
@@ -19,10 +19,12 @@ ip \- show / manipulate routing, network devices, interfaces and tunnels
 
 .ti -8
 .IR OBJECT " := { "
-.BR link " | " address " | " addrlabel " | " route " | " rule " | " neigh " | "\
- ntable " | " tunnel " | " tuntap " | " maddress " | "  mroute " | " mrule " | "\
- monitor " | " xfrm " | " netns " | "  l2tp " | "  tcp_metrics " | " token " | "\
- macsec " | " vrf " | " mptcp " | " ioam " | " stats " }"
+.BR address " | " addrlabel " | " fou " | " help " | " ila " | " ioam " | "\
+ l2tp " | " link " | " macsec " | " maddress " | " monitor " | " mptcp " | "\
+ mroute " | " mrule " | " neighbor " | " neighbour " | " netconf " | "\
+ netns " | " nexthop " | " ntable " | " ntbl " | " route " | " rule " | "\
+ sr " | " tap " | " tcpmetrics " | " token " | " tunnel " | " tuntap " | "\
+ vrf " | " xfrm " }"
 .sp
 
 .ti -8
-- 
2.34.1


