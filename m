Return-Path: <netdev+bounces-178587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7457A77B16
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B81016C10B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC331F0E3E;
	Tue,  1 Apr 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9R7s2KQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2E1EBA14;
	Tue,  1 Apr 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511002; cv=none; b=J8j+FXcDO2mLjIW0668Aao08fA/TLg9VydJpiMO9jy+GRdwHKU7FBb+Fj5ENT+q2zxR3qEhwC6Ub7rLcaRUYVrkAkba8+Ow0yyc/YLLOqWGpNElTd+K3Hch9pU8QgLymgV3fCOFYVa2e8EO/2FTALkAFGWtqehgK4OnOWtXoZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511002; c=relaxed/simple;
	bh=rFyqZ2RLaO7RKhVaj4rYRYF03+gUYQQxc4D+EVrDNFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ze3uBUOXUWwJgGGV7OfUlI9Q0Y4LnLnGfIhUYxPoIK5FNx7XUVyZx4L+/+FTe3UHjEFrwxW0AY+zRpGCuh1u1+6KIg1mROwhw7vztxWv8tgpEWbuuRJo+UBgA0Mfav8XCmIvk0rlnfAehzD7mKpJYBeygId4lRBghvrSVIb39xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9R7s2KQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227b650504fso109395835ad.0;
        Tue, 01 Apr 2025 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743511000; x=1744115800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRLq03yk6Zy7YEUudCgpVtrnIVH8S9IIQdohHtcELnE=;
        b=F9R7s2KQAzpBhEcQSLhyRl6xGdSAemhtmp0w+jC6vPizCtElvKFM2364eHh26Fh7UH
         J5b7zikdQjrs/kwuvAwMXaPBC7DOjIMiFrwWsp9KWuMRBaVHyfsH9HkjVnznw8b9kYHa
         bG0te1cOYjKA9f3aoWhGskfnYAuOCkFdT7Jq2/7wFgs7+IiSeFNB4M8EXkV9MCusm0m4
         rU7E1gUSJugb7psn7IAFVwveOIUv8zAspW88Inr9/Tp/5szTsgG5i2DvNvlcrKpyuKGf
         yuH+J5+3wnzJTr2HjLEUb8sX2TG+EwfxVYCeit2vqgd8Se4c73jVgNj7qr5S2E2fib3A
         W57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743511000; x=1744115800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRLq03yk6Zy7YEUudCgpVtrnIVH8S9IIQdohHtcELnE=;
        b=CiJ+HTDcF1Gf6wC4+hhZLT+gSbZFrdydEyoFAF1CC10QCXKbVDaLLezCCec/pGxNtr
         l1Z9zRbb787S8J/Dc5loIunHyfEqIoocLOAeGc6Y6Xp4gMsggtrFFDI08WVt61AbhxB1
         VvOdTkXISkYa+oNWLgHVzV1tQp9XzcnbZlYGgiw6+mH6cnNuwupmAukEbHnHfsl+jcom
         dz52nftMzu6OaEJGp73Q+QBUHeayTjs/ERyzHIbVP4Ma84hu+bUo2PxXGuLmKG2DlRd5
         9UkaIQ1QGqTJ+L72s7/OTYZP/ThM+8EyYra/4ExGYwTiDKZfT7fryEyEeu4LBZOIjsJL
         uMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeStN/lCxGIbp6pbuGSLdE2guCyzvTw8BLUatMgm1HdeFx7AE1+qMR05ize8QiYh3/IloSuNegYZ04@vger.kernel.org, AJvYcCXwnwfurI/1rxYwF2DiUH+Cr4VL7gjDkLCcTuzVq+Lg94ymaeJpsCYD8e6BAiWozrIHh8C0XtnWUfw79/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzes8LgCatvKSFrpjtYGkz0XeTgzeN22MxeP2C4EJxVCBUpCi3f
	pHy8KiSY7BZzBtCt5wkWLsqJyjsI5CkG1hxzwqRFGKx+/j/28Edn
X-Gm-Gg: ASbGncuW2jwg0MXJDjJKCu3JYdPrwFegGMZ/LTRTr3pEQYW7egGMUSkkTMXb7lvX2/K
	iXc4HVGKz9mG0qCtCm8zLT2YPuEmavh5NRZjfyFJfMeUe6ADHhHQpejV7QVWTgHUjpKrKoHReif
	s7Tuf+cfv5l+ZzWn3cBS1OgU6ZEY3suqiJP9vFo4JffWfJJsmu/F94s6GpI123k6Y3GyG7vDL0w
	F3D1HN72TCf43UmsHWpO7rlH3OmtM7QQr8AEcwfdvWkqoO0reJ06GMABrPlLGNjXMvbLhd7Tqlm
	Ruodut4zabCCqkXIj/K54IjlOUwmzYpZvhPjS4S7I9ejPWvm2wavxenjckRspKKIPyRLaJ/oymY
	i5Lo=
X-Google-Smtp-Source: AGHT+IEZ+AqxgvDoRSMSCzF1vC7TGaxMp9fl292+90i1l0j1zcPEixAD1cQ+sRQphPvlDNQdKR1/9A==
X-Received: by 2002:a17:90b:4d09:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-3053216e46bmr17029670a91.35.1743510999853;
        Tue, 01 Apr 2025 05:36:39 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039e1139fasm12699199a91.25.2025.04.01.05.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 05:36:39 -0700 (PDT)
From: Ying Lu <luying526@gmail.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ying Lu <luying1@xiaomi.com>
Subject: [PATCH v2 0/1] usbnet:fix NPE during rx_complete
Date: Tue,  1 Apr 2025 20:36:31 +0800
Message-ID: <cover.1743510609.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ying Lu <luying1@xiaomi.com>

The patchset fix the issue caused by the following modifications:
commit 04e906839a053f092ef53f4fb2d610983412b904
(usbnet: fix cyclical race on disconnect with work queue)

The issue:
The usb_submit_urb function lacks a usbnet_going_away validation,
whereas __usbnet_queue_skb includes this check. This inconsistency
creates a race condition where: A URB request may succeed, but
the corresponding SKB data fails to be queued.

Subsequent processes (e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
attempt to access skb->next, triggering a NULL pointer dereference (Kernel Panic).

Fix issue:
adding the usbnet_going_away check in usb_submit_urb to synchronize the validation logic.

Changes in v2
Use the formal name instead of an email alias.

Ying Lu (1):
  usbnet:fix NPE during rx_complete

 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.49.0


