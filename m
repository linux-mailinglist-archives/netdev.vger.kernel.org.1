Return-Path: <netdev+bounces-106103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B54914DD1
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6E8B23C5F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6BB13D50C;
	Mon, 24 Jun 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="g78lGZ/+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B84DA04
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234061; cv=none; b=q8yWYLjEASpm8zATxBEyJFyLNDez5AojGMVauN0PmOe/lmkuOQkWliVdbeaKhP/Bxi5Uo75KMnTbjsYBw/sdsmaephlbncZVYqG1P8K19Ch7v91+bppBBXOpJCxAvZyIfgBkB8o1AM6GhN4DrkZOWnScVNXGZlEYurLeyAt8eK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234061; c=relaxed/simple;
	bh=Tc3WgwSjDjOkH1XfJrFafIvVw0PTvyV224+BjtBnOO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kmILSp3iRGhTf1HqVb4B74A/W14fTSnvxw9QliwydjLg6uiNUTUIykjiPazGQw5951W2CF3C4bmXNuKtIH2VeLBywUV0qj1FLsOruN41mweoX2UVZtiXAP8EFHzdfMAdACtV9K+D+pIefM7nVCaaeV/DsSfp+DgQYHOCy1r3+/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=g78lGZ/+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cd80e55efso4811389e87.0
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1719234057; x=1719838857; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ew2TVcR234H4PzQ4PAcHMSScl4lrA7wOmPyWAW5aH8Q=;
        b=g78lGZ/+alhqdEpcEZ/k7A4x7uakMZ8Zd/U7a4+JZu3NuLXY00J2JJc/GCM9XewKaG
         4H3UQxtDvFotZs7nJ1EIXC3EP3OiW4/llVve53iPUrIERpXVGuSosO+BUhfshZatZjaL
         nvJSuv3iNLttSvm9ROQjJAOOMtQkeyZ6a9z8qhXDOvpk2lddpNwVpjoxRtyQa2AszH9y
         ouA5JoBNKfgITQTItzZ6CNoWVT0fHnG+e5myj6vh7A9VQXv+mB98OTGX7B9ktpGmHQjv
         1iu0cZtbhugp/o0xGT5OQv0Yu4U4hhvtijpbHZeTkiLyM/Lh5hLDAo0hJfmhtCfFatoG
         v64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234057; x=1719838857;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew2TVcR234H4PzQ4PAcHMSScl4lrA7wOmPyWAW5aH8Q=;
        b=P4Z22nyGBf7dTamfPSjCwCc3ZtHk/RSQCtDGmMkyp6HWxIThUiRNElAd1GHfcMPBYu
         tljGygax+pQxmA6a54bKjEZgT/9ChTLvbIMKDb3DAaglSb0S+qQqRZJHYtmb2dZTLIrz
         jt/+MZk+nWuL5pn1AP0YFxQHebX2SvxTMAAMwZp5ggtWZp5976bWjEJg2VLuEjKXrvEO
         bm6pTbULj4ZCY//C3BT+m7rQBYQagB/baS+qRJQLCERevXb4ZXVg1m5Fa8p85mLsXlHd
         NPwLUZgInwOP99QGVtkD6WPvVWr3WiL3cD/S+V/mqyyfX9twQt47ldicne8eSdCQShyN
         7BPw==
X-Forwarded-Encrypted: i=1; AJvYcCUyetKa5cgPFDX2VBq3/FuIyU2rS9jK0iPAoQCwTp5C1G06q7IqGV8y4799ikG0QCOR24wphVsZxFZG0sF117RzcKfr+rAN
X-Gm-Message-State: AOJu0YxJtwZiAcTKYxI2sqjlKCRXkXLTZFYHdymHVB6tedoKT3CPzqEs
	xg2Nxo4yvdDhKVtpDPVocN+0nB8Ae0JZsXS0An8z26ShLAyPmekZC2JUPjXVJ5ItgNr+JsNJ49q
	k
X-Google-Smtp-Source: AGHT+IFscqAjpeJS/7cWBTS85zqIfgvOYm5hxFRnO69AhvRRP1rr637Zw5ZcWjlx0vaOhzymXflLtg==
X-Received: by 2002:ac2:592e:0:b0:52c:d5ac:d42 with SMTP id 2adb3069b0e04-52ce182bcadmr3092867e87.9.1719234057290;
        Mon, 24 Jun 2024 06:00:57 -0700 (PDT)
Received: from wkz-x13.addiva.ad (h-176-10-146-181.NA.cust.bahnhof.se. [176.10.146.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd6432bd9sm981827e87.227.2024.06.24.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:00:56 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: liuhangbin@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH v2 iproute2 0/3] Multiple Spanning Tree (MST) Support
Date: Mon, 24 Jun 2024 15:00:32 +0200
Message-Id: <20240624130035.3689606-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series adds support for:

- Enabling MST on a bridge:

      ip link set dev <BR> type bridge mst_enable 1

- (Re)associating VLANs with an MSTI:

      bridge vlan global set dev <BR> vid <X> msti <Y>

- Setting the port state in a given MSTI:

      bridge mst set dev <PORT> msti <Y> state <Z>

- Listing the current port MST states:

      bridge mst show

NOTE: Multiple spanning tree support was added to Linux a couple of
years ago[1], but the corresponding iproute2 patches were never
posted. Mea culpa. Yesterday this was brought to my attention[2],
which is why you are seeing them today.

[1]: https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/
[2]: https://lore.kernel.org/netdev/Zmsc54cVKF1wpzj7@Laptop-X1/

v1 -> v2:
- Require exact match for "mst_enabled" bridge option (Liu)

Tobias Waldekranz (3):
  ip: bridge: add support for mst_enabled
  bridge: vlan: Add support for setting a VLANs MSTI
  bridge: mst: Add get/set support for MST states

 bridge/Makefile       |   2 +-
 bridge/br_common.h    |   1 +
 bridge/bridge.c       |   3 +-
 bridge/mst.c          | 262 ++++++++++++++++++++++++++++++++++++++++++
 bridge/vlan.c         |  13 +++
 ip/iplink_bridge.c    |  19 +++
 man/man8/bridge.8     |  66 ++++++++++-
 man/man8/ip-link.8.in |  14 +++
 8 files changed, 377 insertions(+), 3 deletions(-)
 create mode 100644 bridge/mst.c

-- 
2.34.1


