Return-Path: <netdev+bounces-191523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D6ABBC71
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3102E7ADAEE
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A5274FCD;
	Mon, 19 May 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5wz5fgd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E826AA93;
	Mon, 19 May 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654404; cv=none; b=FLjcAQ28I5sUqR7yiBY/Gy9NYyiWpez8mG7xadmISRx1afXKF9eGQ/Zx4clVZ3wqdqQiLezFA3KgEHBRexIqZHYwBx5SM3z1r5dzLJmwog/WcLIV/H2q72q/ap55ciap+NgrxJbo035VaW8efvm+r//pWDSwqa5JkQy41fk9nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654404; c=relaxed/simple;
	bh=6REXSoz4BH67JZ+gvZ24WlHfe48pXz+s+E8vvSq/8r4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MzKHsopRmOKy0U2pH05BpgqT4HGsKlBpp4lDr6Mu8qqyzkxfPY16kDKrlNYDC31AhAkoMG0xrAshfb4X+iy7iAov8ajDfPacLgKSFu6n12ynp2PVEGH2I4X0rDHNCu6u2196Tzh1r7pdhe+Lusw13Gt3LcKUS16BW2IzUsJjX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5wz5fgd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad5533c468cso257933366b.0;
        Mon, 19 May 2025 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747654401; x=1748259201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+ClcYN2Pl/W43wRMw7G8giXl1lRDl6zZONILMTOq3E=;
        b=k5wz5fgdwfEsMXUghXkRXiqWvvOOdSgoBj7XNhNTPXNgn7MHJ00JYnwrSQn0pzJQl0
         YNuEBGrbJK2ayS+N/ThePDmDAldTPFPB1DwXHVnjdQhptEtKJKcCuraz1OkZlwfhh3vv
         p/dVgSh7l1xlfNc9ttmdpsbHAKt/MSbHCmnZicd5b07C3biZkl8zfOXxCNBlgkXCAyAG
         FviZT1DDfPDjQcmnUwNKCBELyZTvYQNRoK41ZCiLzrM0JnZCsckX6BlzLLp0XEmvzCba
         pinadmv9+Sli+SL+hYCTeL8KVIgbOzRJsAoZBaPrKOZrEcK5jIhYhICJOEn6MLqX53CZ
         oliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654401; x=1748259201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+ClcYN2Pl/W43wRMw7G8giXl1lRDl6zZONILMTOq3E=;
        b=EswyTJdodWY5GRniKsqf9tijCW7N8KKoOIseq8MmjpFXW8bOCHwF1I7USQKzQ9Ha6f
         RWT4kmrJyNZ0vS5GkIbdOQQjlrNeUcv+k86U++Wqu2NQOZD/DI/TOmyvdnA6wFByzetB
         qftA0b+Hof03XrFdRAPWbhS8JecJz54AK+8E+RncinHhi23tFKkFRznJbgRTd3HjVomV
         Uby3aoUkAakikCk0SvC45BlY7AgLKrC1q6MMX5gWLcRGe5PfECeLjyfs0W0Tn1E1bjBT
         1Knd59ox5WPO9O7gsZw1NZJh+apr1v9uMD4R3X8hu2tDm4RP2gmaGaOP3Hsq+TOv6pCW
         v22g==
X-Forwarded-Encrypted: i=1; AJvYcCVfkrhRwGr0bo1mktU+6gQLtJxOOLvmM9VTKyBhWo0b+uW6t9yIeqtznJjM3/pqw7fcdAhgUPFf@vger.kernel.org, AJvYcCXEzFOWR0lIyQj3sN03wC5tlF12VNSQwtKJqi4Iy3i4SqsGybMH9v4EpcnkeVhA1MfXA+u/cchrgVdHe/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKt7O/i3GDLJ5HzEVApnxW0QAtzmGI5LHFttwlyg+AEdCTtMj
	QAc/aqj6akuX3SJZeWlh7+8jfRqQ75528H4T3EfuiZursuyu1I+at7X3
X-Gm-Gg: ASbGnctW53gbKe1x9fpjnfHrLyrhfrxosGTS/UiPgG1uEj3fJDsBCMKalp2PImoMt2Z
	82GQqctvJHpTzpPoeouoWqo2m9NUPRL3CkxqMHnbVJSurFzjvJEs5gWWKqYeyp+jdEkH7bq/F2E
	LL1e5/fbwLdyly1kA80hE6N5ENdgwB8qoO446DA6sW/FhqGEV9nmalukoE6IdGrpH/kigxlI8n0
	NAopzmkMNJ3ECFUTRgClx1t53nOJiEmjOBM4LvDfG9Bq4qM3ldaADnH51kVC8mA8NtWpp7pDBGa
	T1n0yo+ZurMLwNvJ4vgPo7p+JntqAyaTGxIIkpEAepwfsRqND5J3Dwi5HgNZ7bZRX55mjGDf
X-Google-Smtp-Source: AGHT+IEUjVHVTfAe27Qf1IVkemKIXYgimmrEqMCPROQoPMv5Mt2eSZtVtFQHUP2hROAQrCWuGn2jfA==
X-Received: by 2002:a17:907:7205:b0:ad2:2dc9:e3d3 with SMTP id a640c23a62f3a-ad536ffc80dmr1406512066b.57.1747654400506;
        Mon, 19 May 2025 04:33:20 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06bc66sm574279266b.46.2025.05.19.04.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 04:33:20 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v3 0/3] net: bcmgenet: 64bit stats and expose more stats in ethtool
Date: Mon, 19 May 2025 12:32:54 +0100
Message-Id: <20250519113257.1031-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, this patchset updates the bcmgenet driver with new 64bit statistics via
ndo_get_stats64 and rtnl_link_stats64, now reports hardware discarded
packets in the rx_missed_errors stat and exposes more stats in ethtool.

v1:
- https://lore.kernel.org/all/20250513144107.1989-1-zakkemble@gmail.com

v2:
- Hopefully better readability
- Fold singular stat updates
- https://lore.kernel.org/all/20250515145142.1415-1-zakkemble@gmail.com

v3:
- Fix up coding style
- Move addition of new counters out of 64bit conversion patch

Zak Kemble (3):
  net: bcmgenet: switch to use 64bit statistics
  net: bcmgenet: count hw discarded packets in missed stat
  net: bcmgenet: expose more stats in ethtool

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 277 ++++++++++++------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  32 +-
 2 files changed, 221 insertions(+), 88 deletions(-)

-- 
2.39.5


