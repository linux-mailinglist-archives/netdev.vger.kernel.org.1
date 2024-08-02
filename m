Return-Path: <netdev+bounces-115322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC37945D49
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178731C21339
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470171DF664;
	Fri,  2 Aug 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT3/jAxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8145D14D458;
	Fri,  2 Aug 2024 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598482; cv=none; b=qo37PBVhvg6FBc5spE6hzXmyeFqiXL+QI5kDIqNvYpF0bOfcAhVYBJFN7GP9yanlb8Tjh9wg+JFwNMq5r+SgfW6RbOyoKdYoJtfSL9vxzfBbhG2jC2KVy9uq0YnGZib00CSFOAFhaxWb68+6j9fkQuYL5fl+irMfOXWcUynDGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598482; c=relaxed/simple;
	bh=L4MVQUtTKPY9dp8vA/s2i1grzqz3BYHv2Nm1to54ulo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Zu1YZwcmhYw7Kte3BdnaMlqKZHFINv0w/VL5Q94QX7Rb1ZTj5CwTVUSkDRXdXMiNIWJH4VF6uX3rnjsuqA/y6Ku9RmMLvLeYM1TfOUbHMeKLQvfuOtNNmYGO3kbd1fKhyUncPutFAewJOSfpJyvkYsaHuM1JmIjnjGMeZDy4U34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT3/jAxf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15790b472so21672541fa.0;
        Fri, 02 Aug 2024 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722598478; x=1723203278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCKSxpXnDjRmdCG2DqAQpa2RCOpP1tO8Cjfgt5fm+ac=;
        b=MT3/jAxf1bOA9MiKQ9Oz9E/qox8yKOKMmOqcEppKpGruStYACXi/1IdKHidcGrgzrs
         ngKp/yuH7tV5sZrZ0Ez2T18JtGjFCHyoDrRYLfb5kKQ3QwMEXB1XXF8I1SFDGoLEKi/O
         xe34rqMFhxHW1Mufz+4303T9nuJRHkwyuYuXiKZ+JclD98Feo24yy+1NVSWWTqJE3FhG
         hXgM0TZO1EKr/3v1jLyXgWmWBETjBAKCsmHw2tqp8Y5hEkr+zbjiRBSDyE6s2CwyA9Sk
         BeJmW5H+GDvYi01jleW2UF+SQXM47Kt6CmbNflhP0QWrGoIZkQsAvYy7eGbzH2XwKXtT
         YnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722598478; x=1723203278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCKSxpXnDjRmdCG2DqAQpa2RCOpP1tO8Cjfgt5fm+ac=;
        b=fCER/3uW8JGUa8u3ZGFtKShA1xFd6ycybCUE2laXQXarCunFk4Lf3YrL9QSIbdg+l2
         EBbiEjPuxNcFwuWDlQMggedA3rlSmeNjfNnvwShE/iuKQfNQURJpPVNbOngpzw3vCS+Y
         Nuz5FCysklyIMulStiUhf/86x0kX+xszrQ0OyVXkXoJ4/9RSZxiUnlRJpog4Rzce+kHR
         LvIllTkHmiKQ8ln51ETvY1sfzvjmBL2d4f9TFPpmyG0d2IaHRUTPXjItVazh5bInSANa
         L8Jjn7mfyNhSb4rlFho0ZxvwGX6qJeVEXgj3Ux1KUzfTecB57Lp2wMkXavYfi496Z3Uz
         FJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk96YUV/jrZvQ3Q5TPwPcz2Zpjc7V+/YcPNLqnh3P+E9Z92BNWaPEdM/D4rl4yvpN8v9fxUbVFJuCi7+iq4KdboPmFAYV0+LqS0TUaKeZoAksVTMtBkJtPjNHPIFQnYgxE6GLQ
X-Gm-Message-State: AOJu0Yznumoc6sHN69Q8Ad+6kNYctmCS58S3rrJg5gsetl72qEGmNrXI
	QDMvd6CRE2m1YJusXCu8GNS8VSpwL2ajVkXiH9fiS35mQC3z4y0S
X-Google-Smtp-Source: AGHT+IGFmILD9SkkgHGNoCdAcKU3pPU1aGdE3yMX57zm2eTssfo/sPK2LeYsFnpFS56ji2GjtvQAeQ==
X-Received: by 2002:a2e:830f:0:b0:2ef:2658:98f2 with SMTP id 38308e7fff4ca-2f15ab0bf71mr22434751fa.33.1722598478047;
        Fri, 02 Aug 2024 04:34:38 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaa2esm91752495e9.25.2024.08.02.04.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:34:37 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tools: ynl: remove extraneous ; after statements
Date: Fri,  2 Aug 2024 12:34:36 +0100
Message-Id: <20240802113436.448939-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are a couple of statements with two following semicolons,
replace these with just one semicolon.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/net/ynl/lib/ynl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index fcb18a5a6d70..e16cef160bc2 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -696,14 +696,14 @@ ynl_sock_create(const struct ynl_family *yf, struct ynl_error *yse)
 	addr.nl_family = AF_NETLINK;
 	if (bind(ys->socket, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
 		__perr(yse, "unable to bind to a socket address");
-		goto err_close_sock;;
+		goto err_close_sock;
 	}
 
 	memset(&addr, 0, sizeof(addr));
 	addrlen = sizeof(addr);
 	if (getsockname(ys->socket, (struct sockaddr *)&addr, &addrlen) < 0) {
 		__perr(yse, "unable to read socket address");
-		goto err_close_sock;;
+		goto err_close_sock;
 	}
 	ys->portid = addr.nl_pid;
 	ys->seq = random();
-- 
2.39.2


