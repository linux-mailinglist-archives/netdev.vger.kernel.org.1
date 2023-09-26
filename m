Return-Path: <netdev+bounces-36362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD27AF5B6
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 466321C20356
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30269499BF;
	Tue, 26 Sep 2023 21:28:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE20347AA
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 21:28:56 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A782A260
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:28:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso8718554b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695763734; x=1696368534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tM+w7SwTcJ/9TuivXGr7nl0JVKRgfVjBaqMkj1+Pw2s=;
        b=BFut5ZpGawswGr6AbMRMd8xkZcGjwSkUzW9siE+rk70jOS5UQB9e2S40V9rU13nCax
         wSxLelaun3edKvlV6a9poRCYisyk3h79yfUgxa6TEUP3NM7/6u4qe5oU7i6HGCbg0zot
         vZbgHAZwGTR5qOt9nwkiqPhok2iMtN5/SBZmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763734; x=1696368534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM+w7SwTcJ/9TuivXGr7nl0JVKRgfVjBaqMkj1+Pw2s=;
        b=YGWDigzHo2rk/5k8V7L2nw5A5b1jMfccUuRL76UApWBg/umV1SpybYSv0Cy1Lbq6tt
         qGxyfYhEYsg/mgrAzxoi/jgkpxh1i+mEA+t2ieuIbxUngoW5jUY0rSCWgycBgzDjjhMH
         btwkbm89J+6WRMpg0xnhY6qRT+LePG+hpjjFNXDGov9BBXRWQGTd8YWlc4k2RZ91OB7I
         2DhHd4gNeKQNRDJRtV6TP9sXX6Hh4t0EsCko28WVjzae6KTgGId/FHRMPrLZ1dxTQ9w1
         cjmedb1HffxZjVXPFN269TdnZYN/bcN2ioZGBz30+0zgUDrr8p0+B0XQrpcXaMH+rgqJ
         xJlg==
X-Gm-Message-State: AOJu0YzaH5bh5yBPESj3pnQBQi4TQY6rZ17YZ/ZVYAwu+oQc2js+8Jw1
	Fzu2VmF24EpL3mkDFLU95rzeHg==
X-Google-Smtp-Source: AGHT+IFg/VWvQtSOis29D/COSilSeZuwA9ac2iVmLkvtEV2cLcnBvdR30qN03c8KVE9VJv8AcgAUxQ==
X-Received: by 2002:a05:6a20:428e:b0:13a:43e8:3fb5 with SMTP id o14-20020a056a20428e00b0013a43e83fb5mr69140pzj.51.1695763734547;
        Tue, 26 Sep 2023 14:28:54 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f39:c3f2:a3b:4fcd])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b0068fece2c190sm10337251pfd.70.2023.09.26.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 14:28:53 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Hayes Wang <hayeswang@realtek.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-usb@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	Edward Hill <ecgh@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	andre.przywara@arm.com,
	anton@polit.no,
	bjorn@mork.no,
	edumazet@google.com,
	gaul@gaul.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH 0/3] r8152: Avoid writing garbage to the adapter's registers
Date: Tue, 26 Sep 2023 14:27:25 -0700
Message-ID: <20230926212824.1512665-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
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

This 3-patch series is the result of a cooperative debug effort
between Realtek and the ChromeOS team. On ChromeOS, we've noticed that
Realtek Ethernet adapters can sometimes get so wedged that even a
reboot of the host can't get them to enumerate again, assuming that
the adapter was on a powered hub and din't lose power when the host
rebooted. This is sometimes seen in the ChromeOS automated testing
lab. The only way to recover adapters in this state is to manually
power cycle them.

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


Douglas Anderson (3):
  r8152: Increase USB control msg timeout to 5000ms as per spec
  r8152: Retry register reads/writes
  r8152: Block future register access if register access fails

 drivers/net/usb/r8152.c | 124 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 9 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog


