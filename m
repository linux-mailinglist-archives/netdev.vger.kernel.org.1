Return-Path: <netdev+bounces-128966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728D97CA26
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ABC284152
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D119EEC0;
	Thu, 19 Sep 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OFjqm9A2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE418893D
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726752305; cv=none; b=R8dFHLxIUhlVPJ82r+laoqpB+V2DQCu1tSoe2Sfqq0rOV3FRCwW4g5NPbCdQAvov63D7VR1NYG4bHmaOhXqD9Sy3MI2Uq/JtaBx5ffQWIAP6Z/lPmGrS1Z3Ym7QdlOdKGt2vsL6NGjXRS4VYFGSy5L/p3eT//MtIIelP3NzF7cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726752305; c=relaxed/simple;
	bh=PHPevfpJk+NzNSKAui3Hgt7JUYg7sSL+k7we0NX6b2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mle+bSu08baJ93MAc7OzuoB+j3036WxJXrIU/fkmZiK/GtJa8i0o8y94fGzRckOu3wfq2SSrrlfKXCASXDBq8keZ2RSzqEBLUK4bhkdCATu2mMJDQ2/SqG0gllw8m/xI56LObbxW4uqeXzg2cuADW2F2Le/2fOysEdRviMuBuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=OFjqm9A2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso1198899a12.3
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1726752301; x=1727357101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXKyj9QfU6TS4dahNlEkSbG4SpYUyfzDDNO0f4/oKhE=;
        b=OFjqm9A2nBwK07IwSzUnUf9CGeY32GEAPh+A4jHiNR+MA+8MKZ4BH2sdWl+r5j4SUY
         yrbZ32mQBPVT6Jy0P0EhMACT9Wowyyog5KNCekv/tPeHHFFqK4jhU03It0DKlgCbtakd
         1Rd1r/r3vZAQfuQEERhUDR+810BYhFRb/ygOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726752301; x=1727357101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXKyj9QfU6TS4dahNlEkSbG4SpYUyfzDDNO0f4/oKhE=;
        b=pBOEed6kMFxpYic5/GS2Q779emAN6181pkSLKSxGusbnppf+or/CvCXJjIK0pdChbk
         isSKBFwwlRkPDh6SPW6uA0kJeRIWJvos013kg6mc4YXoyCV/iXzPqkabMn62nItTWMAM
         QpxOyAnIx14B3QEqSJ/0cfOb5w50SVuRoj6t2DbGzN8aJZE4+Nel1sE/QeV6mwrFlF0w
         piwGLslSGzgSUFR1+GIw9O8xv3vonPE4jw1BHCfQ+vTpyp9dMBmwZzX6HDJTyGVJvrjh
         yfOu1DsYMQaTQElz9iRhtYd6EEVRQEQAS5IlznY8usLg91zJuEx9sP8n3z7mexeAdOgU
         VzJw==
X-Gm-Message-State: AOJu0YzGnEGgZ4BEa2CbAtt2QxZHetAB6PonoibBrY2OStIdhd445XJ0
	4T0s4DzXCjOo+LxLasK30S1tghBUc9nbqUgAL6F85lOcw4+64jtLupnUjigysXytndp7xaHTTrX
	hv63oHw==
X-Google-Smtp-Source: AGHT+IGw6MEqtPQG/0Y84X4e/vyi8aWsDVGP0TBOK26zSIp+11f6AsGoaS/RRyo6b1lvU8/RPLFnXQ==
X-Received: by 2002:a05:6402:2549:b0:5c2:6090:4047 with SMTP id 4fb4d7f45d1cf-5c41e093ecamr20754133a12.8.1726752301492;
        Thu, 19 Sep 2024 06:25:01 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it ([79.20.102.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89c4esm5971812a12.61.2024.09.19.06.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:25:00 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH 2/2] arpd: drop useless initializers
Date: Thu, 19 Sep 2024 15:24:54 +0200
Message-ID: <20240919132454.7394-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240919132454.7394-1-dario.binacchi@amarulasolutions.com>
References: <20240919132454.7394-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is useless to initialize the fields of a structure to their default
values. This patch keeps the initialization only for those fields that
are not set to their default values.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 misc/arpd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index b4935c23eebb..a2ae76a41f8d 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -439,8 +439,6 @@ static void get_kern_msg(void)
 	struct msghdr msg = {
 		.msg_name = &nladdr, .msg_namelen = sizeof(nladdr),
 		.msg_iov = &iov, .msg_iovlen = 1,
-		.msg_control = (void *)NULL, .msg_controllen = 0,
-		.msg_flags = 0
 	};
 
 	iov.iov_base = buf;
-- 
2.43.0


