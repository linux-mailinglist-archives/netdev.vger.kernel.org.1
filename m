Return-Path: <netdev+bounces-220283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D0B452F0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42F01734AE
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7B27932D;
	Fri,  5 Sep 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXarme0z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B4421CFF7
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 09:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063746; cv=none; b=cxACb5diKS5eD0Ux1wSrQ7nMRDKIoObwD38EaN4VLkWApELNDjq548VUbW+TQadjNMi6LlsXEGbLp6lCnLNVOGtJz2EyiN0kWPmw/W5r6sV57NF/dquULsZd+o1Sz/QUiYzE3XCDoc5J57efpHn7zG4oKizalWPZ8BaYP7BO8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063746; c=relaxed/simple;
	bh=WbmBMowJV++GnBWq2KoXvo/MQORjRjNcFtyYxDppK50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRa8lSKfjwdltF4xW9cbn5+iA1Mvr70FTtdpZh/okNlBDPrZLl0yZsgdgelKap+inVC/Dinar/nTWEkgqLjzmB/r5hTNpSBiH5ST4OKhmdtpHHl0FelyT4Jkdy2OOP5FYC1bPuIwpq9cijnZXKbWtJk9XtaaktWxhPDvawCQE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXarme0z; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso1788095b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 02:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757063744; x=1757668544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLKMjKENOiGWQ+3jJu0UGz9aXP11g7Q9tCM76mtuTtM=;
        b=gXarme0zOL+PUReFonmZ7DthD9IZUVLDfOzGbcXuTpSuUp+aL+CODbOvrvlakqj49+
         LV0E09VegCjUzJdGsft0fLzChweng0a9+9B9uLAsQ3tNy8177EfnpkgMoEB8IBztaLEw
         Wmi5dkHLt8c8K77GEo7vETu/EAKw86XPH2hhxfQfQLW6ECb/Jtn1XmmXruDinf5gVchu
         ixN61tBrPV2lP5LKoVEE8Y4TSpgXD0VOuG7KVG5VdSpmK4TRVZMQmNPj4vaHJrPrRokR
         5zbNp32a9Xe2xwzAapjAF4OX4rKYCxbUi3FjrZDI/geq7FfsSgBJZulKlT27x7NsBjnm
         rpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063744; x=1757668544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLKMjKENOiGWQ+3jJu0UGz9aXP11g7Q9tCM76mtuTtM=;
        b=pHuj2CvIuvFcWoYkof90H03NH+UdRTxzguQGgqGpFEWfWbkMXlljxFVtuE35DGm2/R
         0iEpnlzIubt3J/sI793BomFcmU1KM8BRMxOAs9pUSuhPvZfEkwcKN21W7au+hf8c7YY0
         Eo1973CVdb/quN89QF9EXZ0gS58yqyYjcKxru0MUHvMnsiTvpX/BxqneFv6tLzCRSjRq
         SPpIgWr/l4B59ter5ytfQGZ4iSU5nTbGUom5QZraK6y6ccg+5HrvfwEXOSjuo+HNUtuq
         d1F6MPu4urD3fHu8UrlbcdqgP6pveKSFc0U8qWPwY2dKKploqn/MhPQUORG2rw9HXqzr
         I1Cw==
X-Gm-Message-State: AOJu0YyUg1odcynNDKbhLhRipII2U2YHkWMscR+rCoQQcOsDWDcLobRR
	p4tIKc6fM/enuRXemIXRfrlhkGeCUo0z/ODaX4X4aFZxdR9S0cQyiZd8yiVa0Buj2IQ=
X-Gm-Gg: ASbGncvv8+xhRlWG8mcrKayatzKfWTsSoqrvAdLOdoqOdd3GUSM3DE5/on6MOTNDZKt
	1IzIXsjkASM6WbuZfDwChPNv9A2eEnXVhiDgKlq/YJmX30XTVnLJDSC5p/qR4p5jBzmxu2GClP6
	aPe+io7lEVCtTBfyt/uxca6KeSHfy4FKMapORXgjUI4kYOnoIsKvJZXO+H7YBly62HrVx8Ym9u9
	tdnsnFKXp8ksyShaxIZOVKLjSZTDm3+8HJ4YngGHt00O/dd+e9UPdqubfT4E4746OvBkG8g0/hC
	VjHIBGsMAWfeRXn7Rv9/yJa2ozb2aDSMmOlb3NYH6Hrg474BtCTsbt7YxDqE/5BGr+2U7SLkukT
	CF7fSLgCiZCGeWQbc0gbBP8BMfd8yRDjuxJmEPzIY0Q==
X-Google-Smtp-Source: AGHT+IFjiXCEfh0qAtC6AV6ZQ02E4AK24LzpNH3NzHJJvKZA5nTvPWstYxn2S/y0VMjIOSuwUma0Rw==
X-Received: by 2002:a05:6a00:114b:b0:76e:8e95:1382 with SMTP id d2e1a72fcca58-7723e1f466cmr22832212b3a.5.1757063743685;
        Fri, 05 Sep 2025 02:15:43 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a71c60bsm21078281b3a.103.2025.09.05.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:15:43 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 0/3] hsr: fix lock warnings
Date: Fri,  5 Sep 2025 09:15:30 +0000
Message-ID: <20250905091533.377443-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_for_each_port is called in many places without holding the RCU read
lock, this may trigger warnings on debug kernels like:

  [   40.457015] [  T201] WARNING: suspicious RCU usage
  [   40.457020] [  T201] 6.17.0-rc2-virtme #1 Not tainted
  [   40.457025] [  T201] -----------------------------
  [   40.457029] [  T201] net/hsr/hsr_main.c:137 RCU-list traversed in non-reader section!!
  [   40.457036] [  T201]
                          other info that might help us debug this:

  [   40.457040] [  T201]
                          rcu_scheduler_active = 2, debug_locks = 1
  [   40.457045] [  T201] 2 locks held by ip/201:
  [   40.457050] [  T201]  #0: ffffffff93040a40 (&ops->srcu){.+.+}-{0:0}, at: rtnl_link_ops_get+0xf2/0x280
  [   40.457080] [  T201]  #1: ffffffff92e7f968 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x5e1/0xb20
  [   40.457102] [  T201]
                          stack backtrace:
  [   40.457108] [  T201] CPU: 2 UID: 0 PID: 201 Comm: ip Not tainted 6.17.0-rc2-virtme #1 PREEMPT(full)
  [   40.457114] [  T201] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  [   40.457117] [  T201] Call Trace:
  [   40.457120] [  T201]  <TASK>
  [   40.457126] [  T201]  dump_stack_lvl+0x6f/0xb0
  [   40.457136] [  T201]  lockdep_rcu_suspicious.cold+0x4f/0xb1
  [   40.457148] [  T201]  hsr_port_get_hsr+0xfe/0x140
  [   40.457158] [  T201]  hsr_add_port+0x192/0x940
  [   40.457167] [  T201]  ? __pfx_hsr_add_port+0x10/0x10
  [   40.457176] [  T201]  ? lockdep_init_map_type+0x5c/0x270
  [   40.457189] [  T201]  hsr_dev_finalize+0x4bc/0xbf0
  [   40.457204] [  T201]  hsr_newlink+0x3c3/0x8f0
  [   40.457212] [  T201]  ? __pfx_hsr_newlink+0x10/0x10
  [   40.457222] [  T201]  ? rtnl_create_link+0x173/0xe40
  [   40.457233] [  T201]  rtnl_newlink_create+0x2cf/0x750
  [   40.457243] [  T201]  ? __pfx_rtnl_newlink_create+0x10/0x10
  [   40.457247] [  T201]  ? __dev_get_by_name+0x12/0x50
  [   40.457252] [  T201]  ? rtnl_dev_get+0xac/0x140
  [   40.457259] [  T201]  ? __pfx_rtnl_dev_get+0x10/0x10
  [   40.457285] [  T201]  __rtnl_newlink+0x22c/0xa50
  [   40.457305] [  T201]  rtnl_newlink+0x637/0xb20

Adding rcu_read_lock() for all hsr_for_each_port() looks confusing.

Introduce a new helper, hsr_for_each_port_rtnl(), that assumes the
RTNL lock is held. This allows callers in suitable contexts to iterate
ports safely without explicit RCU locking.

Other code paths that rely on RCU protection continue to use
hsr_for_each_port() with rcu_read_lock().

v3:
hold dev lock for hsr_get_port_ndev caller (Paolo Abeni)
deal with hsr_port_get_hsr() separtely (Paolo Abeni)
split the patch for easier review (Paolo Abeni)

v2:
check rtnl lock for net_device_ops (Kuniyuki Iwashima)
hold rcu read lock in timer function (Kuniyuki Iwashima)

Hangbin Liu (3):
  hsr: use rtnl lock when iterating over ports
  hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr
  hsr: hold rcu and dev lock for hsr_get_port_ndev

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 20 +++++++++-----
 net/hsr/hsr_device.c                         | 28 +++++++++++++-------
 net/hsr/hsr_main.c                           |  4 +--
 net/hsr/hsr_main.h                           |  3 +++
 4 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.50.1


