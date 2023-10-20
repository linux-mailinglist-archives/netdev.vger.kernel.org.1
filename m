Return-Path: <netdev+bounces-43118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502887D17CB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05AAF28262F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E84341AB;
	Fri, 20 Oct 2023 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C/wcTvjn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100022B748
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:08:25 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B7610E6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b709048f32so1152922b3a.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836101; x=1698440901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQE73OQ0b8iyTRPhBZA90MrBZY63bSWJ7tj6pb5onnk=;
        b=C/wcTvjnhoKLAEVBZozgEwzY0xA/DkFBe0ny+6jN4qe9QGLfpf2hviHQQJGhx/UwZG
         SbMuv+PwCsEZ0nE9UHj418jXDtYUzQGxl5kfHTui68brDAHYidm8qVqNWMy1GMppu9ab
         F5wbVyrqwr8nfkCgN1M33E/s+MjSR5BA01gyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836101; x=1698440901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQE73OQ0b8iyTRPhBZA90MrBZY63bSWJ7tj6pb5onnk=;
        b=twMWflQC+1z/erEAJh27ftORW+H1b8MPdm6v8aSCZXE/m4C+/1YZqE5z6xMHJ3rvP1
         JkuIMt+9EMPO74MItJBT9ZMYmsBguu7B0agQz3IRDxoqzHD+Fg9jKYwEk9pRHR9sm7mD
         mnh0Xco3G3rdwiN2h2UWxA+3bouU/sleYf6LvvXbwDoMOUJ4Eh/D8vvPj6BBNBGJIvf4
         ZeWw5WP1OofBeCox3/HO5aw2ptvVP/pBXBxKyHuHz7YYkf504hD/+RBaPR9eC+tEzx0q
         dA3eX63ITWjq1iDOvcB8B6uaysq4aiXPtzYN57kkXm+fa4JRlX6y2YsDk6LurvMSNHyU
         olhw==
X-Gm-Message-State: AOJu0Yw/Ze7KRw5S+eIjMpett8V/hBE2WEWIeZZcYR/osRqfPIVRUSqf
	cScpfuaaGZybrevFz2o7oypw1jJd9zwdcwpas7nN/4yq
X-Google-Smtp-Source: AGHT+IHFBIplpt14DZg6hItiXgYR+r3PgP8bBFAvwNN0vfftWs9vbOrRHRML59tRSCJmkzB46s5Pgw==
X-Received: by 2002:a05:6a20:3c8b:b0:15d:9ee7:180a with SMTP id b11-20020a056a203c8b00b0015d9ee7180amr3042099pzj.4.1697836100885;
        Fri, 20 Oct 2023 14:08:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:20 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Edward Hill <ecgh@chromium.org>,
	Laura Nao <laura.nao@collabora.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 6/8] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
Date: Fri, 20 Oct 2023 14:06:57 -0700
Message-ID: <20231020140655.v5.6.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231020210751.3415723-1-dianders@chromium.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the adapter is unplugged while we're looping in r8153b_ups_en() /
r8153c_ups_en() we could end up looping for 10 seconds (20 ms * 500
loops). Add code similar to what's done in other places in the driver
to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.

 drivers/net/usb/r8152.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 9888bc43e903..982f9ca03e7a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3663,6 +3663,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -3703,6 +3705,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
-- 
2.42.0.758.gaed0368e0e-goog


