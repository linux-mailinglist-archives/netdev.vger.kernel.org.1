Return-Path: <netdev+bounces-190019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD2AB4FAF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357DA1651BA
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4823A2222B7;
	Tue, 13 May 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTUTtI8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A5221FC0;
	Tue, 13 May 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128319; cv=none; b=KhfihT1wUXypJLieAOMuQrjQDEZcu9vPSVKfDH9W9U8WXmL+dLzsq2xg1fI2CboCaO3AMaUVEYWfIxU7mfE2GmAIuMRQQDSuTerlZij+XqxfZHuBOCdzKo70lcqv9evWtcYHZQ4AjXACLTBjxKo9uwbGN8uLE7/oRk3OV7zXF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128319; c=relaxed/simple;
	bh=0vnTH7IpcYbdB55+fKTyZHUcBuzLZwTH1WanZ3tgS0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cve5VpESD4+3xPGzEf8xw+giEw7neAXv3917HWGbcURXtcCxmyxa+wQ+5HfxkY1pp5tLvyhl9b7F7xel5DlwQrmurNhUmz341a1cdCW9CHgAmDNEpOy7AF63z12oG3qT72gURiOTZUOdiKU5cLgqDfM9WVpA+Q0ZuJRafj9Reto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTUTtI8i; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so51853821fa.2;
        Tue, 13 May 2025 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747128315; x=1747733115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIPpIwGNU4CPXqq/V0PRMisoOJXHPtuNqt6Y92vkNZU=;
        b=FTUTtI8iYQ6nXoIH0O061z1SNkN7LdSZkGPP4tykWkpho68mQCW09vNA/SpinhJPhF
         dnXRicvMmkAdaHp3+58e9EwX2xn1kioMMIW9iyhgq4+2t7usZn4fUqj7YiT6MmJUj88z
         fYYf0SB5/PG0RetrNGb4b0ncU623DwMZbLzlfzc9NNfbSJ6zW77Zqr+uY/yLlHGT2CGz
         U95GSmQbHUQ+VDpwkL30Pif2S8+Ib42fb9bW1mPmsx3JEupHqMd71qW9JfGxYgwSmpN4
         ADUCGz2xeELf1W+86w7Wb0oBM9VLHxiWNidIyU/kbVxO0VrolcV9ChiPIV19iKdGD4tF
         d1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747128315; x=1747733115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIPpIwGNU4CPXqq/V0PRMisoOJXHPtuNqt6Y92vkNZU=;
        b=dyhEs/9InKOdXQ7fXBopiixso60cCGr2h2kkWoxdOCQvjVO6W78nHZvQHmZMRK/4d0
         AE6utAglBrSTvsoKuw2WH6KK+HBe7Nf6D/0lSbnA5hMV6dWBaQsoxjnFVvq7jxYnCEc9
         2TklW9Zm6ZtQ/2wYvwY5vHLEkb3KWozrE1TfdHnfUcoovTtz8QnZR+U8RM3g5I59ASBo
         673MTWEw3o95JvVc/1P/o8gvrcdkQTG7OFuQ5qWEIuS6ZY7VTNm/WMVujGOJ/tz7q7Hk
         HHZZT0msAnGS3l70dE1dPgnGV+badQXAt9adYh3KQwU1Krj7+0Law6ekA9Xi6MK9GBtK
         NwVw==
X-Forwarded-Encrypted: i=1; AJvYcCVNh4kwNodB4k+NN/xedJVeNwspxyB/wajhmu5WPDcWPRC2xZ4VnCQn+nLDLgwSwqZltm9SQSO9@vger.kernel.org, AJvYcCWMopL+tevh6fTWCn0tunJuPAOKd3ofO53GYMvBCqRF0scdH1lcdZAblVDLUvkJe7dLC61+QqxYho6NRX+G@vger.kernel.org, AJvYcCWVXkxt43HY8ZWut9a9B6a0VP1nwAXwTDfM+aZngGR+UrnjsBy2UBA5zWZrj0vwW7OBB3Ya/KhpAFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFru/pf473al0GGp7hhISu7mi+q+EPh+VuaXXnc8xbTPxd1OTg
	UjvGwL966DIiCfWKDC8Z9pUOTO3UsGG6wF4mBPuOIO6Qhoi5e4+x
X-Gm-Gg: ASbGnctU7Y/hcao3HktuuJxL5RNXzK5pLa2XR+AEhDgxtd161p8weHpMQlCUEMKuF6T
	9sRk51HPGCDOKXyTNf31q3okQbW8WYmgWQ5wLXfX+GpKlZVpNgDwf72b3CEvtb7vVCCbVa1MAIl
	pMyulanpYu5MHWA5s89Y7+yEfAw32q/3zjzdX/oc+eq5CHexayMEGncL1Nro1x5KUUgx/y1N2A8
	hNdsj8JzAiKHJln8V7iict5u+koAjkSgxp1o0PjcFp15mEXB21r26CCoIk4Bqmm6eXt4p+BgTNr
	qP8RlwEkNK9pNovusAzmATdcvH5ktDaPykLkZNtT05jpZ3gOejJ4cwUxkP6nI+ZL2s6l
X-Google-Smtp-Source: AGHT+IEpVjrYLcux/PHYNZ9dnj51M8Wg5rrJhJDG4TZL5iP7mg4Qj3g39tFfIr7NKjOPPFfdl7GzvQ==
X-Received: by 2002:a05:651c:2105:b0:307:dc1f:e465 with SMTP id 38308e7fff4ca-326c45cacbamr67113591fa.22.1747128315279;
        Tue, 13 May 2025 02:25:15 -0700 (PDT)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326c321f2d7sm16118171fa.0.2025.05.13.02.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 02:25:14 -0700 (PDT)
From: Alper Ak <alperyasinak1@gmail.com>
To: kuba@kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alperyasinak1@gmail.com
Subject: [PATCH v3] documentation: networking: devlink: Fix a typo in devlink-trap.rst
Date: Tue, 13 May 2025 12:24:51 +0300
Message-ID: <20250513092451.22387-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the documentation: "errorrs" -> "errors".

Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 Documentation/networking/devlink/devlink-trap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-trap.rst b/Documentation/networking/devlink/devlink-trap.rst
index 2c14dfe69b3a..5885e21e2212 100644
--- a/Documentation/networking/devlink/devlink-trap.rst
+++ b/Documentation/networking/devlink/devlink-trap.rst
@@ -451,7 +451,7 @@ be added to the following table:
    * - ``udp_parsing``
      - ``drop``
      - Traps packets dropped due to an error in the UDP header parsing.
-       This packet trap could include checksum errorrs, an improper UDP
+       This packet trap could include checksum errors, an improper UDP
        length detected (smaller than 8 bytes) or detection of header
        truncation.
    * - ``tcp_parsing``
-- 
2.43.0


