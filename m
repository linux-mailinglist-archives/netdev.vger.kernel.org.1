Return-Path: <netdev+bounces-136030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CF399FFF7
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 06:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB669B22B2D
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8F51714BD;
	Wed, 16 Oct 2024 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b="sVIfX/83"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F23165F17
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051718; cv=none; b=R5GDdksZfnpgUy9phgjL2oEFu8CvZl5xMzyFWy7mlusplSp7E441/slQ2BDjuB9hI/Y6a5NxgsqMRWN418uJhkmhnSmGu1EhRCK6XNh9oL4FrG5/wspqBy+ggiJRfC+Wcp+LJSG6AEjwkwnZg8cFVmQKYiMl04V5fBbPe5n+/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051718; c=relaxed/simple;
	bh=rDDNeYqvkvtb4rkbGd7OqvgdRYatNgVzVnyYdt4qgJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZmVC2gJhfHWICnAzSF0+zhe+KBrEhvXLNlb57k6EsfSpAZO3r9yTe9sR+mJ6+F1w0ij9bpUAUqxm9J5ov4xeFTcuV8AAIAl4susDxeiWlxmkoFG3M/N9CkPzrefbwW+FSJcaVSZLEcSwNtYMeWhglHMN0zCeqg62HKXF7tziox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca; spf=none smtp.mailfrom=rashleigh.ca; dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b=sVIfX/83; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rashleigh.ca
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so1616681a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 21:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rashleigh-ca.20230601.gappssmtp.com; s=20230601; t=1729051716; x=1729656516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8QG8NBf3zRAuAEWxk5GFyScinHdujSAhRXpVbDCMkr8=;
        b=sVIfX/83+z+y6dqRzAHa2kvQoLqpl0IJeBF27vmlmoZPgTZBUxAFTlKYfAId8x7kEe
         YfYx16h4rPlOQdWW7fsQCI1TMqr/TvSorcyGi2HHKCU4Xip+1UiRJs5UOZR15XuOtly4
         KIkRraJuoB88tKe2wvbpdc15DMY4Vy5a48Ajwlt1T3cYrnNDr59tcqTDK/Zi9//1Yopi
         g2U2o22khWydXcwnecyD8VkE4bIC0qkFoo9/2KWPNmdsCJ8nBj2/EINwCBveNUXXML+H
         kRKEY7k+HTY6wbQVvarDKrOSNbp2tbFayZe0Eo5DtCAq1TdwlK7SUBA85m+hMkPr397i
         jTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729051716; x=1729656516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QG8NBf3zRAuAEWxk5GFyScinHdujSAhRXpVbDCMkr8=;
        b=WU/WK6ofQrgYqtMyFB+q0hpFRZwEALigW6x/kmeYjWgUMEwgNoEsETlX5NTfbD8AFj
         ZkZ0fYN8g7oQ+dCtJfKjgykcKd/f3GqNmaSt8kS2rAQqSx/ESCjqikFnahqimylkecUF
         IMLUCaR+rvAprdf8s4COFVKsZxU9NeW2/dy1jwYYgmiJ8o4cFQ8j0KOOyU3WEeM0yOCA
         5qqyjYMY/Krarf4uBr4P1DEuc58Fs9CWj/DtgKoI0av0o1ADPe6w2n9KBW9vDfjd4TmQ
         71EJgifkDwCiF76oR2AiJxOZ1wzFRWQOhzrC87/CT6pjaiUbBdKG3Wr0OcaG/LmKyvPK
         aQHQ==
X-Gm-Message-State: AOJu0Yx5JMKo8T74XqHDOeQyDc8hRCP/ptgxynSaklnCaDxMk71UtFd1
	PLvHFEtjJ9bITPCrxslTR/TNPsLW3h45lVpDHdDanoLy7aCD/iLJ29mv9Hx9ikQ=
X-Google-Smtp-Source: AGHT+IER3rPBJw46WxdbW2JJEhZHOvgkjPLMsnarFrLaOG0cCovNa6CpxhCbIYEQJW2AQKDPNlavuQ==
X-Received: by 2002:a05:6a21:3305:b0:1cf:6c64:ee72 with SMTP id adf61e73a8af0-1d8c9699c8dmr21309096637.34.1729051715955;
        Tue, 15 Oct 2024 21:08:35 -0700 (PDT)
Received: from peter-MacBookAir.. ([2001:569:be2b:2100:b7e5:b2b1:7cd2:2a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c7058afsm2296679a12.74.2024.10.15.21.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 21:08:35 -0700 (PDT)
From: Peter Rashleigh <peter@rashleigh.ca>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	Peter Rashleigh <peter@rashleigh.ca>
Subject: [PATCH RESEND net] net: dsa: mv88e6xxx: Fix error when setting port policy on mv88e6393x
Date: Tue, 15 Oct 2024 21:08:22 -0700
Message-Id: <20241016040822.3917-1-peter@rashleigh.ca>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mv88e6393x_port_set_policy doesn't correctly shift the ptr value when
converting the policy format between the old and new styles, so the 
target register ends up with the ptr being written over the data bits.

Shift the pointer to align with the format expected by 
mv88e6393x_port_policy_write().

Fixes: 6584b26020fc ("net: dsa: mv88e6xxx: implement .port_set_policy for Amethyst")
Signed-off-by: Peter Rashleigh <peter@rashleigh.ca>
---
 drivers/net/dsa/mv88e6xxx/port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..04053fdc6489 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1713,6 +1713,7 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 	ptr = shift / 8;
 	shift %= 8;
 	mask >>= ptr * 8;
+	ptr <<= 8;
 
 	err = mv88e6393x_port_policy_read(chip, port, ptr, &reg);
 	if (err)
-- 
2.34.1


