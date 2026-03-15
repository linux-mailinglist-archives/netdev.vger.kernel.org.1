Return-Path: <netdev+bounces-267894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jALnLoIPtmm38wAAu9opvQ
	(envelope-from <netdev+bounces-267894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 02:46:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB5528FC6D
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 02:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA5853065852
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 01:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3649155A5D;
	Sun, 15 Mar 2026 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWN+OVFV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DA273F9
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773539199; cv=none; b=TC7cDyUVoayKxZ4/AQNB/8bWEgyUPkxsEQ3jbYLsWUX+FZk7OyGO2VME97lajskh70hfT+8Ab2CdcGU+2f6+7wxb8buvmKBQW/fYH6EeUVKKhZHgmoUbM82KA0O5Z93WhX5YPlrDXLXVgHPKwXYIuOuO4ReXq9ZBgbp3R0EXlm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773539199; c=relaxed/simple;
	bh=op/ZBUTmK6CT7lDupuvky7OTyDs6tu2pY54psT29e6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sckoowMCtTdpPCQ19VrXjHxkD1lvdD/bk9GHXHqo3GIm+R1s+4SvEBxCYJnNNaZCcZbXMEQU61t7j7gLLThUaD5RDG4D2MMb0R98LqflWSBwlz03AFFTQT4a1tDGjet24HYISGY2kaju4nqWOD0xmy5jx69NJ3RPbwgbY1PRlkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWN+OVFV; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-127380532eeso3394559c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773539197; x=1774143997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytk5F5wNRm+XfQM9jyuevZrOr+JUuTTgh8fmUsf/qxE=;
        b=mWN+OVFVkl8oNrRc+/8E7Wo7TCGjEA3itRGK3FSJnIFjGztsTnbkatJOXMv02r2ssD
         dvc/ccUqrYEAJU7QZEWFbmdsrvfilmWFX+J/XbjQj3ZCOJg67F6HLf0O6sqcEadOTJ1f
         cGgFdLvQ4Ag1y0A1BV4TnrplmUYR5bozzA/ETaCWg5nho4FaBsnibhcZPM/mr5YC1J+d
         BqPA62X/h8vkRj2pwBXvOduW7UgRA3MnZbVPbrog0LGAcgEsiFpqQJKKQnGVXFsgwjLE
         r2YUVdjWLeSrNwde2aoo0JgPVdexHlmMVIoB5s6ToaHook0HVBt7KrdIGR2S+8A1YTXt
         5p+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773539197; x=1774143997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytk5F5wNRm+XfQM9jyuevZrOr+JUuTTgh8fmUsf/qxE=;
        b=H9bRPvWtwlGgq7VH3HeaWi2oKtfW9jvNBCq7nxc6x0amxo3MDnZEaJ98b062/9A/0k
         xW+s4SxzAniUs2K+MQwR+3emUM+Ri8i6Li9ae+05DWEIQcCFYwgMCwUlJQujIYte5hJB
         kMNkpBAltc8FdUojSAlubcv3yXnA+SuITPqHd0jjkL2m05oVyDwv6P6ESWSgZkIEt3Yn
         knzMQEUVna6D0XK30IajGDJrnMhBO6zm/+ihRH1ucaq8xFF1lpqkBy+oS5qenzb4LiNm
         ABZ99aAaWt+fB3NDOSqrS1sad4dl6U/fI9c9i43nYihmEitLFB7AUC6/bmcy2+oYyNyb
         87Xg==
X-Gm-Message-State: AOJu0YwPfsI/mLVCXyo+VF9uclHNrjqhwW9gx15muFlJ253ybxjuVhTn
	tzEk7rvsd2i+TO/gRGOnHaerahepyxifpRUW2LXLsTYsbS+GG/GnGUnz
X-Gm-Gg: ATEYQzyDOYs4r72PV0PBMwfliXYgpNoo5kuJr50vYcaUYY924W/EIALwLLp1Z9wrQce
	Hxb0dNSbuQw0Bjii3XnlzAAty5yc4zrosLUrDaWlYWGo3zbBGW5jF2LCv6+6VlsTwMfLCapguOw
	iDZQYggPXUfj/Em67p/CLxaqqLxftDM2wWH8Ic31laR4dM3ua8e66k+3XOuCLj/QwZ5oj8pf1B0
	g0CgzA0eI5/ebMgobmS+WvesGHkLj+86Wa/DU6XeGQjdREjn3DTZXO2lu1wvoChkF568xH+1Gvj
	b4onpUW3C/DsBsgLu7wdN7ivQMkr4m/izMsb/sBHREVO3/TeCdN2TOUNeSW/A8fczNae20kvujI
	p5YKDSQGl7x/S1rT+s3B9lptx2j1zR6+zryblCUtkDji+PbgdTvrVa1EMTXJ8+QN6IXtHXWFwCf
	hz+LRA59Tnf+0ycBa7/rKnBjYWIcJfCxEDuaY4UJa9gemhbZKLeQUkPEpQzC5Gd6VGHZC7us/KZ
	w==
X-Received: by 2002:a05:7022:60d:b0:128:d714:3ca6 with SMTP id a92af1059eb24-128f3d4a5dbmr4061902c88.12.1773539197320;
        Sat, 14 Mar 2026 18:46:37 -0700 (PDT)
Received: from ser8.lan (47-147-17-191.lsan.ca.frontiernet.net. [47.147.17.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm9689302c88.3.2026.03.14.18.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 18:46:36 -0700 (PDT)
From: Huan Zhao <ms.huan.zhao@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: r8169: RTL8125B restores default LEDSEL values on Link Up, preventing persistent LED configuration
Date: Sat, 14 Mar 2026 18:46:36 -0700
Message-ID: <20260315014636.30074-1-ms.huan.zhao@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267894-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mshuanzhao@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2EB5528FC6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hardware: Beelink SER8 mini PC
NIC: Realtek RTL8125B (XID 0x641, RTL_GIGA_MAC_VER_63, rev 05)
Kernel: 6.19.6-arch1-1
Driver: r8169 (in-tree)
CONFIG_R8169_LEDS=y
CONFIG_LEDS_TRIGGER_NETDEV=m

Problem:
The RTL8125B chip restores its LEDSEL registers to hardware default values
on every Link Up event. The r8169 driver does not reapply the LED
configuration after Link Up, making it impossible to persistently configure
LEDs (e.g. disable them) through the standard kernel LED subsystem.

Details:

The Link Up path in the driver is:

  r8169_phylink_handler()       [r8169_main.c:4757]
    -> rtl_link_chg_patch()     [r8169_main.c:1597]
    -> rtl_enable_tx_lpi()
    -> pm_request_resume()

rtl_link_chg_patch() has no handling for RTL_GIGA_MAC_VER_63 and does not
touch the LEDSEL registers. Similarly, rtl_hw_start_8125b() and
rtl_hw_start_8125_common(), which are called on hardware initialization,
do not write to any LEDSEL register (LEDSEL0=0x18, LEDSEL1=0x86,
LEDSEL2=0x84, LEDSEL3=0x96).

The only driver code that writes LEDSEL registers is rtl8125_set_led_mode()
in r8169_leds.c, called exclusively from the LED classdev hw_control
callbacks. Therefore, any LED configuration applied via sysfs is silently
overwritten by the hardware chip's own firmware on every Link Up event,
before the driver has a chance to reapply it.

This was verified by observing that:
1. Writing 0x0000 to all LEDSEL registers (via BAR0 MMIO) before Link Up
   successfully turns off all LEDs.
2. After Link Up completes, the LEDSEL registers revert to their hardware
   defaults, turning the LEDs back on.
3. Writing 0x0000 to LEDSEL registers immediately after Link Up (via
   NetworkManager dispatcher triggered on dhcp4-change) successfully keeps
   the LEDs off persistently.

Original LEDSEL register values (hardware defaults) on this machine:
  LEDSEL0 (0x18) = 0x0002  (LINK_100)
  LEDSEL1 (0x86) = 0x0028  (LINK_2500 + LINK_1000)
  LEDSEL2 (0x84) = 0x022b  (ACT + LINK_2500 + LINK_1000 + LINK_100 + LINK_10)
  LEDSEL3 (0x96) = 0x0020  (LINK_2500)

Secondary issue: CONFIG_LEDS_TRIGGER_NETDEV=m causes silent failure

On Arch Linux, CONFIG_LEDS_TRIGGER_NETDEV=m (module, not built-in).
The r8169 driver uses /* ignore errors */ when calling
led_classdev_register() in rtl8125_setup_led_ldev(). If ledtrig_netdev
is not loaded when r8169 initializes, the registration fails silently.
The result is that /sys/class/leds/enp2s0-* entries appear to exist but
are dummy stubs with no hardware control capability. Writing to their
trigger or brightness attributes has no effect on the physical LEDs.

This was verified by manually loading ledtrig_netdev before r8169, which
resulted in functional LED classdev entries. The fix was to add
ledtrig_netdev to /etc/modules-load.d/ to ensure it loads before r8169.

However, even with ledtrig_netdev loaded correctly and offloaded=1
confirmed, the LED configuration is still lost on every Link Up due to
the hardware reset described above.

Suggested fix:

In r8169_phylink_handler(), after Link Up is confirmed, reapply the
current LED configuration by notifying the LED classdevs. For example:

  if (netif_carrier_ok(ndev)) {
      rtl_link_chg_patch(tp);
      rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
      /* Reapply LED configuration after hardware resets LEDSEL on Link Up */
      if (tp->leds)
          led_classdev_notify_clients(tp->leds);  /* or equivalent */
      pm_request_resume(d);
  }

The exact mechanism for reapplying the LED configuration (whether through
the LED classdev framework or by directly re-calling rtl8125_set_led_mode()
with saved values) is left to your discretion.

Thanks,
Huan Zhao

