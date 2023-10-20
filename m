Return-Path: <netdev+bounces-43112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E6E7D17B6
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36250B21630
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F51249FC;
	Fri, 20 Oct 2023 21:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQ1X/yFi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E954D225D1
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:08:12 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8F6D68
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so1174096b3a.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836090; x=1698440890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPqVWlZkVjBOaaqWeVuWNgddk8+3v1f2gECGqKGWY0k=;
        b=fQ1X/yFiSZsTMl+tK2K4JXHLE278vK+VBPFZkFJv5HbRwtvuGNb9htWqcq96N1rXjs
         MW1xV7QYHcHeDD7yYsiw8U5sH/E9ecktVpq20ThKO9J9u8vqpcAf3iEOzxQg98RXmyG7
         YR5rUQ9wSmNzE2IlWx3sb6UkOP5DMbZcC/qdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836090; x=1698440890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPqVWlZkVjBOaaqWeVuWNgddk8+3v1f2gECGqKGWY0k=;
        b=YAaermrD9X7KFavlGh2wABCcBclArwdiQjpSI4sv9pOKeg16U+7KwhXCcWcRkG4Ti9
         67ZOebux8uhvseeBidWW2K8tmyAd8/AQncj7oR+dYPZM3Wn0a/Ekz8I0ByPeB/QfEfA7
         koVXYfeLudNrkiwUJ9RUV7+PEouPDKVQKedY/CLhbpTn1GnBn0GWS853a1dHi3kR0Itd
         O4DMsNQeb0w2PXemUveDmswED2JIGoMSHNZ3MhN8aUSTG4Cq2c57tAl9qSpyyNMlp9M6
         w0Yh8cu7FAejkKBS3b7+ku48ppzy2K8G9VF3b56jOnQGJUj/YFWEVuL+yjdZiQrbDY05
         C9Mw==
X-Gm-Message-State: AOJu0YyTN+ekT0WLjXtCTQ9OdQqLpMQNyctb6iDiTzDmYkyKA+s62ixB
	z6W146U8uFwTXtOK7NoEuY/YUg==
X-Google-Smtp-Source: AGHT+IFXECkGwNdWLIcRAP1qPIXHtPwWVv95aFN21R8mGM5bDI8Pq7iFgDZrq1UwLKCd+9HQlq6BZg==
X-Received: by 2002:a05:6a21:4843:b0:15d:3a10:18c6 with SMTP id au3-20020a056a21484300b0015d3a1018c6mr2625583pzc.45.1697836089997;
        Fri, 20 Oct 2023 14:08:09 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:09 -0700 (PDT)
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
	Prashant Malani <pmalani@chromium.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 0/8] r8152: Avoid writing garbage to the adapter's registers
Date: Fri, 20 Oct 2023 14:06:51 -0700
Message-ID: <20231020210751.3415723-1-dianders@chromium.org>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Changes in v5:
- ("Run the unload routine if we have errors during probe") new for v5.
- ("Cancel hw_phy_work if we have an error in probe") new for v5.
- ("Release firmware if we have an error in probe") new for v5.
- Removed extra mutex_unlock() left over in v4.
- Fixed minor typos.
- Don't do queue an unbind/bind reset if probe fails; just retry probe.

Changes in v4:
- Took out some unnecessary locks/unlocks of the control mutex.
- Added comment about reading version causing probe fail if 3 fails.
- Added text to commit msg about the potential unbind/bind loop.

Changes in v3:
- Fixed v2 changelog ending up in the commit message.
- farmework -> framework in comments.

Changes in v2:
- ("Check for unplug in rtl_phy_patch_request()") new for v2.
- ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.
- ("Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE") new for v2.
- Reset patch no longer based on retry patch, since that was dropped.
- Reset patch should be robust even if failures happen in probe.
- Switched booleans to bits in the "flags" variable.
- Check for -ENODEV instead of "udev->state == USB_STATE_NOTATTACHED"

Douglas Anderson (8):
  r8152: Increase USB control msg timeout to 5000ms as per spec
  r8152: Run the unload routine if we have errors during probe
  r8152: Cancel hw_phy_work if we have an error in probe
  r8152: Release firmware if we have an error in probe
  r8152: Check for unplug in rtl_phy_patch_request()
  r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
  r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
  r8152: Block future register access if register access fails

 drivers/net/usb/r8152.c | 303 ++++++++++++++++++++++++++++++----------
 1 file changed, 230 insertions(+), 73 deletions(-)

-- 
2.42.0.758.gaed0368e0e-goog


