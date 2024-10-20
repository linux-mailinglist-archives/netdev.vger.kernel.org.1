Return-Path: <netdev+bounces-137329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C74DA9A56E1
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 22:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC98AB22C80
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 20:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94128199951;
	Sun, 20 Oct 2024 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qamc9VFN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960E1990D9;
	Sun, 20 Oct 2024 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729457839; cv=none; b=LTPMSgKfVpK1E7p2cfsV602J+ylm0bcY36JuC0bRligEj8uMfILJ/J7yzZflk8fO9riRqlM8/HRg7D8vvp0tNAoLP6lt5bN5L/F0V6pO6v2PA+52dU8MS0npiyRZYM+QO/f0h+USu2w+jS3eO07ATHs4GczYIAgvJrwaWCLMThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729457839; c=relaxed/simple;
	bh=zRsHYisQEELxKNzF7NAHVUpkh6OnXUJdzT9EKyh/oEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoF9/i/fVNrstKSBlE6RlXjeiE/2t0hUc+94R1CLdJ1yLRG9vl7OgRMFYp5rsQvr37qIrFptUEMgJW5mxueG92HDeuZx0/+ZBiaz6Vt62ZrW+g2FgB8mt9j5747MJ7hguHXxjQHJQUu/YviH3Gz72KGwto5XeDlCRrTYt5GUA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qamc9VFN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a99eb8b607aso390833066b.2;
        Sun, 20 Oct 2024 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729457835; x=1730062635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOrSQk6OQUcaI46C63XrLELudDbvYdZw+Xbz1Ht2QVQ=;
        b=Qamc9VFN7rZ1jg/MP3XXO5oEQPBZ8angYYa7dQv8luXsnLITzpOwjMkqGQskhqyWIV
         myVs/3OQnQDNP5X0z4idrSq9jvX+agsr0UuMXYxw6qHqTSzeJNI1jnlZ7uFxieEPqeAU
         +YIuVCFdCA/hjul6tyqY3eIM4efr83sycOcLRs/RiJTCwAIrWTWrIl7eOO66qqp+9cna
         5tVmOcHQNgNAoOfEVsEet4Bsbc+0pur0dnsEHPNeog7KC1g+CpVdC/ONNSKaQjaSImNi
         8yuSSA0D7/ZfukH/EdfauNgYuc2F5lBQRSaTi+C0ZVLjiRr7xYHKzqW4nzOJ4mDZgaBE
         ln3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729457835; x=1730062635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOrSQk6OQUcaI46C63XrLELudDbvYdZw+Xbz1Ht2QVQ=;
        b=IIrXQUnIASnj/aVGZWfmCGJ5kVryeHVw5UdqhCEnzClui5gTubNrwv7JFhUtR2xAv/
         r0JDNptUaoWSaz3q7PemVfgNBNvvNmQku/hB7DBqYjLpGMfvRFKl20unDUGvtYMmXc3c
         n9couZsTIuVtsl3fGL1WK4Y7VCWtOA+TUHGL+vpKZZwfbWuG7i/1fPVy/j3o01WBW4oi
         SGSN9uRA1lL1tLavBGXgROr61nPHH7iXIcbwECcC6uX6PMy40wXRJ7QDz3oxbLx6l0FQ
         uUJgkeL0VjYW6tc71Ohj2LRmjr7ROJyz6WkYdKRwFhG+ce0p9ik4lVTXi3ZCbTRjIdgg
         491A==
X-Forwarded-Encrypted: i=1; AJvYcCW6m235uxjGubkm5EajRYvzkNiMZblTuahoMwTTs6XKrB9KMzuK5Ldx8et+g0GeY1LI+xpo/bhVZVzqkVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVGSkXG8UgEaeCoug861aoarjHfBsfYZotS57jLdOLH8qIaO4
	KgTWkqsOWb4PbVO5O0oSw4O7ePGmY1uxjouhVp+PcR+m0qrYXmOjdMoiqo6c
X-Google-Smtp-Source: AGHT+IHKAyGFZ6v1PRxM85yYZ8stnxxlf0zrC+3Zm8vaeg26Xn4l3Mew5FofYON+V5frYsHNljIE7A==
X-Received: by 2002:a17:907:7293:b0:a9a:26a1:1963 with SMTP id a640c23a62f3a-a9a6995d9admr963013866b.7.1729457835260;
        Sun, 20 Oct 2024 13:57:15 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912edc07sm125135966b.69.2024.10.20.13.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 13:57:14 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/3] net: dsa: vsc73xx: Remove FIXME
Date: Sun, 20 Oct 2024 22:54:52 +0200
Message-Id: <20241020205452.2660042-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241020205452.2660042-1-paweldembicki@gmail.com>
References: <20241020205452.2660042-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

STP frames can be captured and transmitted now. FIXME can be removed.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 596b11c4d672..0d05e3dcf05f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -2218,11 +2218,6 @@ static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, u8 state)
 			    VSC73XX_SRCMASKS_PORTS_MASK, mask);
 }
 
-/* FIXME: STP frames aren't forwarded at this moment. BPDU frames are
- * forwarded only from and to PI/SI interface. For more info see chapter
- * 2.7.1 (CPU Forwarding) in datasheet.
- * This function is required for tag_8021q operations.
- */
 static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
 				       u8 state)
 {
-- 
2.34.1


