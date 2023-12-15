Return-Path: <netdev+bounces-57811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD78143EA
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 09:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F00A1C22078
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44351428E;
	Fri, 15 Dec 2023 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iky2EC2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B121171A6
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e0daa57b3so355009e87.3
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 00:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702630148; x=1703234948; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3w/FHaWDjgi6VbmQXAwqONy2zwZqdN+GF0eUSEvGuk0=;
        b=Iky2EC2LnSLJFfEgdMYluJrKzDC5C1nMSpFx4AqYB+9BIpz0dElDz9ffCHaBOsghx7
         MQT1wPQE5GDx7T2zy7PoJB9Ow24/Qqgxlm7KHZQd62vs50c1rTiARDd/CXhUkl/t4/lk
         Txosw5eHR1tn+8GJou7dewbIY4BLqcqyx5fLzOXouISt368jW1O8obwcQuUMS48EasdS
         qRLjC5uI4Pc1yGNmv0DOl8R8g5b0P/mnWW0w3mTSr51OdiqJLdojv9piPjybTyyKyPew
         r2+GTuFlu3ZSD3J1zfmZJXRAGBFy4L9Xycz/soR0b1a2kmSm/inp7KDQOlTAu8MNHg8U
         8IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702630148; x=1703234948;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3w/FHaWDjgi6VbmQXAwqONy2zwZqdN+GF0eUSEvGuk0=;
        b=utH8sS0HmHY4V5/aM4x7WYCMy1DNJhv9BuW2c6SOx0yxpQBUP+uCQtQaoIZ1/tUR6w
         SCbTtduRp+sjfdYNirOH+5uwAXU3ZvFaMKO43+XersqWAKjAOVbSxINjF7TT4n21I3SA
         CHMNMCX2RnTYBHBVmSav5bC563HT3Y9Yf4gSCDY4YH8oGt38ttWI/7O5tc9lK23eUt/U
         idbsGzzuc1OKPwbggltpk1UTicSFBuFC8w2DhQP77kyAPtwOncHrwobBTGWYmH0hon7i
         m/H1wN3iaG9zx6pS2kqHcUBqJJWbK/blD/7Es/3lZ3AuJqm/7pV0qUE9XbELx/Nfb9wy
         WPfA==
X-Gm-Message-State: AOJu0Yy0LywcO5GESU50JJ75xIy7JZNwJ8uL0y7gT6IN7knT+wgQsQYe
	wVRamtjQZc1nFqHjJrRV9TOs0Q==
X-Google-Smtp-Source: AGHT+IGWfnwY93PQpqwwVWWAUKZkPjSrZ3aiCaR6Y2lyslwYdiggXOqAWYCVkv7jbbT4e7fPq2AH3Q==
X-Received: by 2002:a05:6512:15a0:b0:50b:f84a:539d with SMTP id bp32-20020a05651215a000b0050bf84a539dmr4003515lfb.19.1702630148519;
        Fri, 15 Dec 2023 00:49:08 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id cf21-20020a056512281500b0050e1db15277sm166692lfb.162.2023.12.15.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:49:08 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net 0/2] Fix a regression in the Gemini ethernet
 controller.
Date: Fri, 15 Dec 2023 09:49:06 +0100
Message-Id: <20231215-new-gemini-ethernet-regression-v1-0-93033544be23@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAITfGUC/x2NQQqEMBAEvyJzdkATUPQr4kGSNs5hZ2UiuiD+f
 bN7LOjquinDBJnG6ibDKVneWqCtKwrbogkssTC5xvnWNZ4VFye8RIVxbDDFwYZkyD+Vfeh6FzG
 ENQ5UTnbDKp9/YKKypfl5vkhOeAJ1AAAA
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

These fixes were developed on top of the earlier fixes.

Finding the right solution is hard because the Gemini checksumming
engine is completely undocumented in the datasheets.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      net: ethernet: cortina: Drop software checksumming
      net: ethernet: cortina: Bypass checksumming engine of alien ethertypes

 drivers/net/ethernet/cortina/gemini.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231203-new-gemini-ethernet-regression-3c672de9cfd9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


