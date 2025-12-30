Return-Path: <netdev+bounces-246360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD02CE9DB1
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 15:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBFC9301BCF2
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8F1DDC2B;
	Tue, 30 Dec 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqNF4PKp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857117C77
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103424; cv=none; b=BkvwZrPfLSvap8vBPY5jbZchJNQokhsxC8XinUfSlDKNP2N15L8k2oXLvf/DAm/pgD7Kz65gMX4ejM++JwnpdaUMGdXP1Mxkii6wiZlgtAUo2NhTp8Xe1KML2qvNISRm11GufGCHCURYHtV0L4+oEmGHh6e7DUicmBEzPQw0q50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103424; c=relaxed/simple;
	bh=aNnlecGhKy13ROmynWAlLP7ShAf7QX0cvBkVYuQltmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZyTbIZsKf1lAZRfxqfB7agjP0uRNKMHQRPUTNZAJjqLXKKXBmo39z2CgFSlaJ5DBte3L2G1zlDGbwWHgM7D3SRWBxgoCMM2elb5lKYlOKu6ilFzNZQai6wda3XFMSkGQa1kBKsEH13/wM0XKfGOLGgmtzZjMHh+kGmCSQ0kmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqNF4PKp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-598f81d090cso10609808e87.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767103420; x=1767708220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDsxCp42eoU14j6xryKiA7K3hIVZWMWze+DuPaQ/GgI=;
        b=nqNF4PKp6lcn+SR0OjPAGmmyVTDZoIt7HQ9F2vr+F9Y/uNHZiRUTbux9UalH2u/d5I
         SzB2nTh3sWbFVbVEiW7ZhppEl89ieNlB4RdZLfxiQw0eX/2eR8X0QE96s+M7A07jYysJ
         BIa1iPOqxVxbdHWWTvBxCyLgKI6ivVWllT2FNNsOk1gAlXab1v0Km3UNj9tLNXUgsEGd
         XRZIvWLNOsj9N2nSW1mvPjI1OCrfYauzetLKwx6kmwgLM6YbmLCk+JTk6P9ilwtRj1Bt
         E1toLqCFvcDyQR5Frj3quti5NQeyVsFnsq+elMX/JQbGhAPBKASfJYudvMOnDJNRydgT
         JJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767103420; x=1767708220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDsxCp42eoU14j6xryKiA7K3hIVZWMWze+DuPaQ/GgI=;
        b=PqQn5XhKXY+ShAJyXBuIndAe58z6I5q1pzLlsivggZDuNVrEkndST3IFYlssX6Cf4/
         UFuFMAeFnFdeshASc/82hN3ZQMyzmESFu7nb8fAzJtN1fzOdpeI+24vG54NcVB4ugcOc
         Ovl3r4SFrwVIfLJtbRdPj8WV8Pg+/GRws7LnbCQrtxiZA9mGuXYIC+bU8U+0KWvn/5pu
         zVht3IKVRI4kWgDpTd2lAtxdXU76R+mH1tkLEYrb2bcyEOH7f9AVyoPe1b0EheEtu6AK
         CmpB9YLZVk5B8VXXpqmGvEFefKaGkBsyXObpQC67SpvkB1r1+BAWteUAMh3mw/ClGnO0
         voZg==
X-Gm-Message-State: AOJu0YwFWdKadR47leyJI5MQ6N1m98L6+H4Cxg8H+C5m8BnvflOv9Kdt
	EtrWoklzO+2/bexy/JIlH2efWjEyiE4fCq2HrVXBln/9tMz+7gSxh0QAy+ezxaQjWIg=
X-Gm-Gg: AY/fxX5B79amBy+KGSbcLHZnF62g3UPxqQM4jhbZsKDtWJGfvLmINTsKJHQXyJfmzOe
	/PLOkksYytz80ybKsoVhEPhYc7KG0TjZlNrPHfcR2QB1H66cPirmyQTV1fynLNUKsxl4JUyXSPD
	5TqHkyoiHi2cCbQ5b+4nlji1HLCUW2rxIRFFKEdtFzhlATfqFHssR7NPx9y8hC6cwv7wd2xIUdp
	MQy8H8urPRJq9tHEHkmxe+cL4C42+LOXVEKa4zhnQ8e5o1fMppVM4tSzQXFj9I1lGJ2eCW19AWY
	1SNO98rtTL7bagX3BDSTuc/n9a2fETELHSJ5B2IEFkp39Wflqhr7J3M9ssgT4WM2Frob/fj5l0a
	03MkcUSG7fz0Bgjsalj3migw7SLUtGn4ESv96WKzudLf7CyHuUDiA1Khz0MfBLfcWzNqgfEsgMv
	41ip2Pfc0wKHFcFfA9rwiDeF+SAVOxdyEiR1VGZjpjHuw0KcLN8rDpBEizmjuuIj+CrAJsxUD7y
	i6IJkiwyhC2v96V
X-Google-Smtp-Source: AGHT+IE+qJ4Ql12hLWimWI80sO1p2ITdZWKTvQxNonZZw8ljiPkvdhAzoarrTufYoGxyca56BBNVZw==
X-Received: by 2002:a05:6512:2388:b0:598:eef2:d30d with SMTP id 2adb3069b0e04-59a17d5a53fmr11554655e87.44.1767103420093;
        Tue, 30 Dec 2025 06:03:40 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1861f7f5sm10191272e87.72.2025.12.30.06.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 06:03:39 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: [PATCH v4 net 0/2] ipvlan: addrs_lock made per port
Date: Tue, 30 Dec 2025 17:03:22 +0300
Message-ID: <20251230140333.2088391-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch fixes a rather minor issues that sometimes
ipvlan-addrs are modified without lock (because
for IPv6 addr can be sometimes added without RTNL)

diff from v3:
Main patch is not changed
Patch 2 (selftest) changed:
  - Remove unneeded modprobe
  - Number of threads is 8, if KSFT_MACHINE_SLOW==yes.
    It is needed, since on debug-build test may take more than 15 minutes.
  - Now veth is created in own namespace
  - Added comment about why test adds/removes random ip

diff from v2:
- Added a small self-test
- added early return in ipvlan_find_addr()
- the iterations over ipvlans in ipvlan_addr_busy()
must be protected by RCU
- Added simple self-test. I haven't invented anything
more sophisticated that this.

Dmitry Skorodumov (2):
  ipvlan: Make the addrs_lock be per port
  selftests: net: simple selftest for ipvtap

 drivers/net/ipvlan/ipvlan.h                |   2 +-
 drivers/net/ipvlan/ipvlan_core.c           |  16 +-
 drivers/net/ipvlan/ipvlan_main.c           |  49 +++---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   2 +
 tools/testing/selftests/net/ipvtap_test.sh | 167 +++++++++++++++++++++
 6 files changed, 207 insertions(+), 30 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipvtap_test.sh

-- 
2.43.0


