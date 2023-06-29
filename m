Return-Path: <netdev+bounces-14491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF17741EEE
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 05:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5071C20972
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6B1FD7;
	Thu, 29 Jun 2023 03:54:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816774C90
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:54:09 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516A530C7
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:54:08 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so188861a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688010847; x=1690602847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2AHgNaBFK8JfNASOhLGds08CbGR9PY3Il9QtABWRh4=;
        b=et3Vu15oD0I0/VTYf3k59eeXyPxFA0clBBCUdHY1eXEFWGvj23bz+/zkFatUsDfBch
         IR+g/aHslPcC8iJreUR+tFMscRb6bLCjoLCrLTg+pc5CL/NHCvLT1Bez57oah4Kzbj9N
         G9klaQXXF9rXjC7VFINlryTVLbGlwBCQ2vrcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010847; x=1690602847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2AHgNaBFK8JfNASOhLGds08CbGR9PY3Il9QtABWRh4=;
        b=PEAiqCmnnrfyl1Fgl59vlmoTdM/wTKt9gqXcQqzl7flKSIDwqNnZecrG7gVfWgSg9Y
         s1A/QmRY+0jSdC4vCv5Pi2yBY8PIKlDHoeZI2ja3QUe9OsSvuEruXm8+aMzI31P02M3/
         1WEiqQ2ETaLT7R8BrNqnalbZuGwRudAvu4N6DbNesFPraNEUFFtLn5VmBcBNjN8QbwZn
         0MaIsEAyNnRn6tKY/RtUk9mpMAerWVNUgUIiVIz4YXKTMih+rzSny7MvSJ6UY/dZH+w7
         dfD5Vp2a5cUoL+fX0QUiLAKw/mv49hefWAsQvIknuJBUDZB9fJ0grT2kc9XNUCOzwJpX
         2ZaQ==
X-Gm-Message-State: AC+VfDxYQ42ejL6fxe5hQExJ2txtwJDXHOrH57VWKFcCm6tC0atzRdTh
	5a5PWDyfZw9OFe6nJiJBeEiohQ==
X-Google-Smtp-Source: ACHHUZ6ERoeG3uQAKmubsGmF14KTacE2DDCjpJbY0mZaPsbsZ/WEjLnqr+/Rj0L6NaJstrbDu/M8GA==
X-Received: by 2002:a05:6a20:7d96:b0:12b:fe14:907e with SMTP id v22-20020a056a207d9600b0012bfe14907emr5996043pzj.20.1688010847675;
        Wed, 28 Jun 2023 20:54:07 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (242.67.247.35.bc.googleusercontent.com. [35.247.67.242])
        by smtp.gmail.com with ESMTPSA id r19-20020a634413000000b005579f12a238sm7019842pga.86.2023.06.28.20.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 20:54:07 -0700 (PDT)
From: Abhishek Kumar <kuabhs@chromium.org>
To: johannes.berg@intel.com,
	kvalo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kuabhs@chromium.org,
	netdev@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath10k: mac: enable WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON on ath10k
Date: Thu, 29 Jun 2023 03:52:55 +0000
Message-ID: <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230629035254.1.I059fe585f9f9e896c2d51028ef804d197c8c009e@changeid>
References: <20230629035254.1.I059fe585f9f9e896c2d51028ef804d197c8c009e@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enabling this flag, ensures that reg_call_notifier is called
on beacon hints from handle_reg_beacon in cfg80211. This call
propagates the channel property changes to ath10k driver, thus
changing the channel property from passive scan to active scan
based on beacon hints.
Once the channels are rightly changed from passive to active,the
connection to hidden SSID does not fail.

Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

 drivers/net/wireless/ath/ath10k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 7675858f069b..12df3228b120 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -10033,6 +10033,7 @@ int ath10k_mac_register(struct ath10k *ar)
 
 	ar->hw->wiphy->features |= NL80211_FEATURE_STATIC_SMPS;
 	ar->hw->wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+	ar->hw->wiphy->flags |= WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON;
 
 	if (ar->ht_cap_info & WMI_HT_CAP_DYNAMIC_SMPS)
 		ar->hw->wiphy->features |= NL80211_FEATURE_DYNAMIC_SMPS;
-- 
2.41.0.162.gfafddb0af9-goog


