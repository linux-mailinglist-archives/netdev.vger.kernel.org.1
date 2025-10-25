Return-Path: <netdev+bounces-232899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BEC09D52
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3683A6335
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030502EBB80;
	Sat, 25 Oct 2025 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjDQveDL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F181E1C22
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411976; cv=none; b=M3fgblLUQtnakr7tJkt3qhssgshLR0tt6I/9Q6lnDdOPT/uyrmfXim7LI9KE5+tWGr40rsOfBoqfuK+Qdijlbf1Z8TQ3sciN0I7mgqqQTHXrPSyZ9eaFD9kn90LIDgAZtNj2G1fLkZ8mrp+Q2f2ppiqF65cCb3U9nIkRJF9ZbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411976; c=relaxed/simple;
	bh=HCu833bmir4M6r9j2JFmyaeqxzTubipvFpWHffKiLvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMT1CAI/lCsH3LnvBxN8nyK7AmIMOrVBSZ3+4+lkWB/XUmroS0FpFY6yO+tOtGwst+qnAzDMnbfCxjmPVa8QjjVK6b8FEbxhmL4QNdgFDtbHyvPDnhYxyA+hF2YTrl5mqAOHuWTaYQ/WC8Y4gXRgxNIvkbUv/KKTtDNZrIrW6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjDQveDL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so3822648a91.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761411975; x=1762016775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/XY21ztoERrjQmgy/d/a4G/lIjgj5+cHWJnKPaCDzk=;
        b=AjDQveDLIfJJgTDJQeDLkDYfit724a/O2GjiipI+YJZLGD1YDbQa1deN/MmzpZWmxI
         vWwY5WCNGokp3eOFd4CQ+qaSz9VME+pEMtmfhQxe7wJVweKwZCWd7zJqHoDNrL3ab0D5
         /Wqq5p3roJoGWt6lE1veB7GCb1RxOgFQvkuKEVtZiy+69hlX1mkjVS4kUkIO/Cp5lqKZ
         /KocPSbuJWUZPwk2KdvwGChVireimnpgU+d7HjOMmaLMcmMeklSXhGanatz6rHqG4CD7
         s5Ov+YuEYYgDf2NqdejFl4QETWO3aCr69LZsqtiFrdRQ1oNn9Bdud+v667QsFoPGfm+o
         IHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411975; x=1762016775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/XY21ztoERrjQmgy/d/a4G/lIjgj5+cHWJnKPaCDzk=;
        b=Lgl2zCo+NINE08qG6CbclLPwow6f7/BRcGVuTU03HZPBFeQi2uz5UxtI1usHURV75/
         yAfeZOSgob6Z6GtQ/pJgYvH1oeaj0GFK1byx8bjbmKInym2hWHBfaG7WpDlWoq1PXPIj
         PA3dUVQy+c62FYaB0PCrIct5m/TzQbSGO+r7A1Okwh6ees+UT9u++Tpn8sSb/J5LqsCU
         2FZx1W3mzWgW2zud4t+ufCF8AA+usSJ+eGX9L+icQ+gw1C7LNlZ6lQxmZ/lyTGoIKOw3
         uZjIgusH7llz3etOBkUoIx1zjdf0jdb0w1mDHPUll8sA0aBPcOgJWhwrVSMh7/s24kZE
         XI6g==
X-Gm-Message-State: AOJu0Yyu0yUwJYl5kqzDTPk76P6xn9nxdaXViNu7LDrZwbucL7juywOD
	EkbPtmR/7cbp9QUDTmB8o9ugcuNwp+FajNIm0QKpHHgGSITqZt0lW2Fe3BA3j0z1
X-Gm-Gg: ASbGncuXGuYdqv5T5mBwS4igyYNdoH/sBlGrWbLJ76Emxtsmvv5NDfHFf/CTbzpHUoM
	2NPqcHOzaCuPRTgFXSiYHS3WjXcfNw7eQPL1MRFLP77di5of8NYvTAivGMP8jNntLFU0IfgGpXy
	Sz78GEvqeln/JQQALOyGZcatLqdZ5N8NnZMnKVBOJZIte3WUuTufPX8SGAruSb1Mb4VLcA3qELk
	5Bfe6atYD7BYqMJsVoWz4pBdCtHwlf3WN+7rgQcpHZu8S1drW3mF3FAUI7Nli+YchykGCs00+ep
	+CMHBwzDVsOYHzvt5ElBWokjuvYMlGwAfRzhWB+6Q+tf9A9GvEG+JgaWnk4KCTRRzgFv+SI9fF3
	X9KdFVGR3roFjEjZNDqJtSRiuUMil75cZUchFFApn7a0AdQPgiR4teZMJ1sA6fvOcG4rfNoU3eH
	UwydZACPfs+IZxUnu6mA==
X-Google-Smtp-Source: AGHT+IECuaD1uzfsOK3S4QZldR25k4OtDGG1HNwYEOUqeZL32um7yY1qQfcQYZXrA4WJ/IS4Ljj/nQ==
X-Received: by 2002:a17:90b:3911:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-33bcf91b8demr46331970a91.33.1761411974532;
        Sat, 25 Oct 2025 10:06:14 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70d1sm2857842a91.11.2025.10.25.10.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:06:14 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: dsa: yt921x: Add STP/MST/HSR/LAG support
Date: Sun, 26 Oct 2025 01:05:23 +0800
Message-ID: <20251025170606.1937327-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for these features was deferred from the initial submission of the
driver.

v1: https://lore.kernel.org/r/20251024033237.1336249-1-mmyangfl@gmail.com
  - use *_ULL bitfield macros for VLAN_CTRL

David Yang (4):
  net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
  net: dsa: yt921x: Add STP/MST support
  net: dsa: yt921x: Add HSR offloading support
  net: dsa: yt921x: Add LAG offloading support

 drivers/net/dsa/yt921x.c | 324 +++++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/yt921x.h |  55 +++++--
 net/dsa/tag_yt921x.c     |   4 +
 3 files changed, 370 insertions(+), 13 deletions(-)

-- 
2.51.0


