Return-Path: <netdev+bounces-38054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E97B8D4D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id B8EDA1C2087B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4B221A0C;
	Wed,  4 Oct 2023 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gk+pnVV7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282F2137E
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:26:50 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E69C1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 12:26:48 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ae5ce4a4ceso136899b6e.1
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696447608; x=1697052408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRE7W6rGykUfzRSDRb1QLp0CI0wlMdCzPIOy4s2ddyg=;
        b=Gk+pnVV74FcH81c7bzM7EeIXC6PLS0K6gfwSpXi9UQHYMw3O7C9T6MhBbc1V7Raosq
         aMGw1JuC302Zzj36FmeResuBpMPGLG5zlw5WHTs7hB9iKPOMgIMhK4Fj25DlYcOuH+Gd
         FOnkGUAIcIS3VEaWdyDy7iBIohv0diaYbXHKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447608; x=1697052408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRE7W6rGykUfzRSDRb1QLp0CI0wlMdCzPIOy4s2ddyg=;
        b=ImJIYFoStBoQBb4nn+pekzzp/n13mwmdSGRm6FIYOALWhi+Edhul7JZMgRLv0cjxFU
         8YF6E4WboTXmS6K3arxLu5ivb2HYe2nYSA4PUYMgf1OiVHq4mIh2GmLlykKFWjgNyF0K
         WpFQOVXa3KsRtu/zh7zLOaRFfVdUgqQb2WOF8Q+9gHiOf5WDrDIxlylGlzFpAG8/riZF
         5QPEz0xbNd5Y3BlyqYS5NG/oaZ1S/+HnoASknkuK0To/CsVjH3Ez2aCnvWRNBZQoJVvT
         ZFm2kfKyyKi1pXRibFRvdHorgRBXTK9FcGpce8oGLHFXC1REd8wGw/hhjb8mHKAv7j4p
         doSw==
X-Gm-Message-State: AOJu0YyumCoH3Y/zYMChFp88EkitwgpaJhLgB1N72vHN1yauBkJIO9/N
	753gOuBzyz2AaeP1DeyAhUDFAg==
X-Google-Smtp-Source: AGHT+IHKdRWWAwhB2Rx6+1BQ4DLatol3GN1p1tpZH1G+C0D8KW52QijHHt9AX+eyUVJh6ky/NhR6yA==
X-Received: by 2002:a05:6358:4414:b0:15a:e6ac:ee5d with SMTP id z20-20020a056358441400b0015ae6acee5dmr3139352rwc.17.1696447608189;
        Wed, 04 Oct 2023 12:26:48 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9cce:13a8:f2b8:b799])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b0057c29fec795sm3649151pga.37.2023.10.04.12.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:26:47 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-usb@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 0/5] r8152: Avoid writing garbage to the adapter's registers
Date: Wed,  4 Oct 2023 12:24:37 -0700
Message-ID: <20231004192622.1093964-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series is the result of a cooperative debug effort between
Realtek and the ChromeOS team. On ChromeOS, we've noticed that Realtek
Ethernet adapters can sometimes get so wedged that even a reboot of
the host can't get them to enumerate again, assuming that the adapter
was on a powered hub and din't lose power when the host rebooted. This
is sometimes seen in the ChromeOS automated testing lab. The only way
to recover adapters in this state is to manually power cycle them.

I managed to reproduce one instance of this wedging (unknown if this
is truly related to what the test lab sees) by doing this:
1. Start a flood ping from a host to the device.
2. Drop the device into kdb.
3. Wait 90 seconds.
4. Resume from kdb (the "g" command).
5. Wait another 45 seconds.

Upon analysis, Realtek realized this was happening:

1. The Linux driver was getting a "Tx timeout" after resuming from kdb
   and then trying to reset itself.
2. As part of the reset, the Linux driver was attempting to do a
   read-modify-write of the adapter's registers.
3. The read would fail (due to a timeout) and the driver pretended
   that the register contained all 0xFFs. See commit f53a7ad18959
   ("r8152: Set memory to all 0xFFs on failed reg reads")
4. The driver would take this value of all 0xFFs, modify it, and
   attempt to write it back to the adapter.
5. By this time the USB channel seemed to recover and thus we'd
   successfully write a value that was mostly 0xFFs to the adpater.
6. The adapter didn't like this and would wedge itself.

Another Engineer also managed to reproduce wedging of the Realtek
Ethernet adpater during a reboot test on an AMD Chromebook. In that
case he was sometimes seeing -EPIPE returned from the control
transfers.

This patch series fixes both issues.

Changes in v2:
- ("Check for unplug in rtl_phy_patch_request()") new for v2.
- ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.
- ("Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE") new for v2.

Douglas Anderson (5):
  r8152: Increase USB control msg timeout to 5000ms as per spec
  r8152: Check for unplug in rtl_phy_patch_request()
  r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
  r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
  r8152: Block future register access if register access fails

 drivers/net/usb/r8152.c | 268 +++++++++++++++++++++++++++++++---------
 1 file changed, 209 insertions(+), 59 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog


