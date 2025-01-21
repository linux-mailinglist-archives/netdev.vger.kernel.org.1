Return-Path: <netdev+bounces-160055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03172A17F83
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3EC7A2141
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910315442A;
	Tue, 21 Jan 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnNF2iN6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8384163CF
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469025; cv=none; b=TL4Xz4o2o4vfkcKeoFGo9o+U1pODaeCRAnLvM9YCaB1alBnJzRJXn+fO7NCFD51qehDocf+6UEVxmBewkt82tXq1GM9bNtLayh9Wi2Pxixd4eIgT+O2ur6oP4WORqtJVh9msqqmg0UV9JomXAOZ/rU4pO45x1TlovOJBd/N/hQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469025; c=relaxed/simple;
	bh=5xP8UEwi0MJSzAk4wpe04SszpkSMTyfHr+LM9M80T60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jzYICmz/LRQM9GfexzfISt4oSw8aeKiUxFkeYEKYCqDI1C+je2uSzA7fN9b7JT5F4TEgyjkVFSVXxJl5UXOueco0Vp75o03txsQTrZCGJvE5GX/783c6y5qpgdB+Edy2EwtfFcc5FQ+hfr+cFx7n1NgLg6lWnpDZhlwRs6nS65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnNF2iN6; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-305d843d925so47953251fa.2
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 06:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737469021; x=1738073821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBAYTypERn/gg1hxfG2FXIvk/fBTXqjfTdOQNsUyf24=;
        b=YnNF2iN6tlGqHLph3RXxUJNERMGJy9RSF8u1uMnFLc91uDUuDslxDFHUtXWGCz0JGh
         ou/pSbfI6YILxgrnnvuT4Ekab9gc6xbK+4wqwMlF7gOqLIOPWaNXXUgkV1SaXAXAOqhj
         KCDL4SoHfVG2QJPlpTpz9hqQK9dumFfo2FFGpnsaBLfXBMJQgDBcdCVBdnPL2y1SQUGc
         ro8VqOuBMfSseM+dWe0ouxBkvXbMK7ZmtAFdWilC5vxGxYuPLWYdvhynsLKjKEL0lhvC
         Ja/X6voOmqyLO8ApxMVflmj5rk20fwav4ZEH2odEKkiMpezOWY0IRL7WoztoCQwbzHei
         3BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737469021; x=1738073821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBAYTypERn/gg1hxfG2FXIvk/fBTXqjfTdOQNsUyf24=;
        b=D6J/gcbHYO+vtOh9uIGGiak8MiM4khopwi5dnff9Lxh3rk2cjNVxYGVO7hEeDh9Vjx
         7wrenyCP+0D8lCAHAQERGg2t1XmpIC0OnbGHRXncB9nd4Imsh18UGVjeYks+BJYgYZsF
         8Q+yKLHmzs7IvY7Jm38iy3dxYZeon1BbqImhikvENeN7OywCLP2l54/Rf9P+bTddPXWY
         7cGXtkJrKzHrubiebfuaVPa/iAiTQGtoFi94g71/qbv0dQW0FKlNqYP2Dlg3L4P5AgXY
         ACZtimFBWDICUkXzKhGd8DovP/iIEVEy3LAvNGJR2ENhWDTsIC67PM1V5hIpHwvzdT23
         xjHA==
X-Gm-Message-State: AOJu0YzwVcZqekDPKIyWQSnlMzZSvnptnXPGKofUPXx3F+5wiViVuCXP
	6AnCo6rnUZW0cJgwWQPOI4He9crIGp3q7oACwrlPrRKpb8PeFUCs
X-Gm-Gg: ASbGnctYOYDdHUK6x170ufduv71ytq8U0uVx/dkUgHRnyWXF9ddYUjk7RzOQT1BpcPu
	9JOw8t8Kwccd29BoVeP+2GJGmlShuRhmN+2htnUTcX7DEtzgiIyMfnz8GpXJQMBfOscG37mXhSD
	EvtyUAs3j398XZWfo+t3Sc1oHqtSYA9lmn/kM0EuPmoLzpRUSYYWCSBwbUXn2CW0S662Dw9jR/f
	w4XJ20c3kgoJFHKBntXco2prOcjiLuKSE/lHKEyOZjAJatvjpRGE4FtpYMMRImxWhkl9g==
X-Google-Smtp-Source: AGHT+IEJaIoypSP3Gv+MUOwSteimDSvbChXgQLrr94krYvEQ2cZ/yTX3j7P2iZ+fZLUz5wqkwyoVYg==
X-Received: by 2002:a05:6512:692:b0:540:1e5e:3876 with SMTP id 2adb3069b0e04-5439c27d2ebmr5711531e87.52.1737469021246;
        Tue, 21 Jan 2025 06:17:01 -0800 (PST)
Received: from X220-Tablet.. ([83.217.203.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5439af073dfsm1856854e87.30.2025.01.21.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 06:17:00 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [PATCH iproute] iplink: emit the error message if open_fds_add failed
Date: Tue, 21 Jan 2025 17:16:42 +0300
Message-ID: <20250121141642.28899-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

open_fds_add may fail since it adds an open fd
to the fixed array. Print the error message in
the such case.

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 ip/iplink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 59e8caf4..1396da23 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -666,7 +666,9 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			if (netns < 0)
 				invarg("Invalid \"netns\" value\n", *argv);
 
-			open_fds_add(netns);
+			if (open_fds_add(netns))
+				invarg("No descriptors left\n", *argv);
+
 			addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
 				  &netns, 4);
 			move_netns = true;
-- 
2.43.0


