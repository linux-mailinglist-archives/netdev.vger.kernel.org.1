Return-Path: <netdev+bounces-67808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDF0844FEA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 04:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1239B28A65
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9EC3B194;
	Thu,  1 Feb 2024 03:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TNKd2jPU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2715E9C
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759228; cv=none; b=FbZBu9qxI4yWHoMkHIFaQEtfm+MTQ8mjOxxDHv1lu2LJSiXrXGpAw+6Ux+pxdj26uS8ECJ42lxGawd5IsfFXlrnQB8iPAsQbTXPYWVMhynaVtPwJkR1LLgxPY+PQibSoWThK5E5oZ+6TRvexym3cv3XTTR00nVkq4KK3pgJwmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759228; c=relaxed/simple;
	bh=byg7GV0urD0GITggesjbHsAOLbcGXOy3+L3LQkc3CYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt8C7t1yg/3spFXs99MUeZ4p2pPSqgkqwyqOySC2dQ8+mYUt9xKtLsN2MbGlUhi7wWEZoTTXwOPdYOxo2KXtU7Co3eHKzYwLimzaiAdoKhbfp/nYNk/ZnwG7iGXL5KFKbwxQEXaoU09L6Y7yH3gaUER473PcxF6GOlCzazNC6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=TNKd2jPU; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a8ecbadf7so234742eaf.0
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1706759226; x=1707364026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NYfxYGrZl6xWNKpUJhZt0rWoSq/fleBIoPbmE/uMvs=;
        b=TNKd2jPUvmkmuq6SHHNp+V1WVgXGutvhUNdRvNIpHKeD8AQ+x8qa1KSqNJi0xN/ZUI
         +tLJ/+XbmZrjgloNR3zg4gPHzx1RK9VKLyvxyIWf2Srq5q5i9jhHhQ3QKLo/8UbJWl+h
         7JsQ/7PkLlTvhf3Dhd63wP6a2Dsb0YcLOVw8IEn/8ToDcUrY6QC9knAsYME+1vhDNiw5
         1g+h9VF/mx6wkISED5sqLBgbST3nXyvFcl94QrmWPp+/0YZI4/L8uRuyetGIILgmkruN
         EkcNEudQGPBupYZQDaJCqLa8QFkx/W/kNf9m88qSj2cEb4b6SgfX4VPQEHPRNjXTKsCV
         Ym+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706759226; x=1707364026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NYfxYGrZl6xWNKpUJhZt0rWoSq/fleBIoPbmE/uMvs=;
        b=Jk98jgChIt1kaMOT92QI/3om2O+V483Bg0rIAyVzUzcP5683yXc/NUWxpSf/aLAfmB
         ecG6WSQG4z+tuIWg6zMozv8XNsSK8gIXv534MkMAP4dzw5K8TcohXdDH9Gl3AwY9iITE
         thyhl6kzGdbgw+RC+tYzztO9wB2VtE8dqOol1U8DMuBE3vD+kJ19voMvVVu4oCqNyvzh
         Yg1AtWaVxkQiApZdTY3PLefnIK0tklwUjZwfb84LihCIxZBxMOKQMwSluEwoXAzbtwON
         kILsKDUSXLGPYKNwyCkFkdL1xg2wRZ63vQC5sFdPDxKx6Qqxdk7Q5O1KVp9w/gyQExCJ
         TSrQ==
X-Gm-Message-State: AOJu0Yywuw98fmjpng2G3ulrmI5mg6pWRtsHDQKpnfdkSRf9bnVkcwxE
	viGOw/GuAv06ysJMexlmD4K+t0H9Q46gVROTtMJRSYAegaBp/VAOn70ORSbXaFswRWS2dnsVzh0
	unxc=
X-Google-Smtp-Source: AGHT+IHGkX7aGpTVSzUUcZV/aNMmbSj36J9zjAYANOuGByK5hY6S2nUNTE/mUsrgloUbpFZE2hGjsw==
X-Received: by 2002:a05:6358:590b:b0:170:c91a:b466 with SMTP id g11-20020a056358590b00b00170c91ab466mr1327697rwf.23.1706759225943;
        Wed, 31 Jan 2024 19:47:05 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id hq24-20020a056a00681800b006dbdbe7f71csm11052857pfb.98.2024.01.31.19.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 19:47:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 3/3] net/sched: netem: update intro comment
Date: Wed, 31 Jan 2024 19:46:00 -0800
Message-ID: <20240201034653.450138-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201034653.450138-1-stephen@networkplumber.org>
References: <20240201034653.450138-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netem originally used a nested qdisc to handle rate limiting,
but that has been replaced (for many years) with an internal FIFO.
Update the intro comment to reflect this.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index f712d03ad854..cc3df77503b3 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -44,9 +44,8 @@
 	 duplication, and reordering can also be emulated.
 
 	 This qdisc does not do classification that can be handled in
-	 layering other disciplines.  It does not need to do bandwidth
-	 control either since that can be handled by using token
-	 bucket or other rate control.
+	 layering other disciplines. Netem includes an optional internal
+	 rate limiter (tfifo) based on next time to send.
 
      Correlated Loss Generator models
 
-- 
2.43.0


