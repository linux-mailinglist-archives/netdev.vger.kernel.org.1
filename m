Return-Path: <netdev+bounces-40456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E624F7C76CC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309F4283200
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C83B7AC;
	Thu, 12 Oct 2023 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lo4hCg8M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD33B28F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:30:24 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C287DA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:30:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-564b6276941so991646a12.3
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 12:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697139022; x=1697743822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIBdQHfHPM91+b5JonQNYSwOG95FePEogJzP0FDSRh4=;
        b=Lo4hCg8MjbZ3rjVctuJwOHfdaEbxxPjqg2YWMAVzsSb3nN11ID0NyQsfSnrivseRfd
         qlus7Z5tDflBYlebtyxxR1gWj9UesmXyTFDKydhLvmZO+OoC5H5tQ8MqFTrSJ/wSizjl
         BnxHR+d9dsvcIDl/L6uwd59u7d/uhHtknxc8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139022; x=1697743822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIBdQHfHPM91+b5JonQNYSwOG95FePEogJzP0FDSRh4=;
        b=uQNOxYv4x22Ch/wz1wQqaAYK+6qp1hlZM33s17YP220Ii6rORRi7cgAjWnmqslipRa
         I04ltdNdIrhpfIKwQRuKQ2CpfhfCxOQ8WdT3x9bsyGp1g3njXQbT33Lpk4W+4Hg+fgQC
         jPmevdJL3YfkDswQvooDzVd7ec1NvgtFhF3xDpwenjE9zBv398+GhmrBhHeuTSeZm4lW
         yvxqW29IVFkBEhmm9XnKjyoQ7VGHyAuZO+wdCuLqGWn8KFNVrmzI1BF0r47BFa0fHBGF
         HCYtKdGJfnTkZdqFSOi66333JR2hPwOToavSva9AlaR7Y+gFmhJLy39n4kKdkOmYU3Cz
         DrFg==
X-Gm-Message-State: AOJu0YxcUF/Izy+psikF8jUu28cJK5OMEk8vueHgbFcnB/5Yux3Lu2ad
	pWyofeO3tDfqRbtJS7jFbbS8mA==
X-Google-Smtp-Source: AGHT+IGVCqHhyWjPHboIFX68T+H6J7OFRjv+HwCMKpgqYEXTLWlEh1BjUo3hAYNJygg/UPMwH3OV1A==
X-Received: by 2002:a05:6a20:9385:b0:161:3120:e840 with SMTP id x5-20020a056a20938500b001613120e840mr31028866pzh.2.1697139021715;
        Thu, 12 Oct 2023 12:30:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7c85:4a99:f03e:6f30])
        by smtp.gmail.com with ESMTPSA id b3-20020a639303000000b0057c25885fcfsm2075720pge.10.2023.10.12.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:30:21 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Simon Horman <horms@kernel.org>,
	Edward Hill <ecgh@chromium.org>,
	Laura Nao <laura.nao@collabora.com>,
	linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 3/5] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
Date: Thu, 12 Oct 2023 12:25:02 -0700
Message-ID: <20231012122458.v3.3.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012192552.3900360-1-dianders@chromium.org>
References: <20231012192552.3900360-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index fff2f9e67b5f..888d3884821e 100644
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
2.42.0.655.g421f12c284-goog


