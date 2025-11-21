Return-Path: <netdev+bounces-240829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1F1C7AF9E
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 18:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418BA3A3A84
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D334FF5C;
	Fri, 21 Nov 2025 17:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAED34F278
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744566; cv=none; b=qeNEQttzbcQJgwIS2MAikKN0u71lbrFhQp05Mh9PG4H6oDBn1FThw+JEEDdzIxYjMZagcpXL5y0Onb4UOfsttBxwfgznEgtAblS90usOH0oe9YfJLsu2vm1DxJM4gAa4cT4sePQwbIiJVCchm1h6PEBkjfXlckk/ENtC7Ph5JMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744566; c=relaxed/simple;
	bh=tBAC1l069rZza6dG+NN40YVkYazo6FpRQbURbBbsfDU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mMDnuZ+9Pb/zuSoVXsH/2YHwT68tj5YqQKBqDaZ437LUH3HFahXPd7+lN/e8bV5DcVmyGBEdPsEj+zwxYqyTbFEzgKHMXsrJAlmZH3z2jdbpYXfGPNCmR43wmIOp0SRF5/YpKL/RJvEd/Tf4ufSGSUArANZOtSRAvQON4+jCB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c6d3676455so761340a34.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744564; x=1764349364;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=di8+YvD0bRSp/lHQE7ROIloycNEsWSYf1FI8ZmXpLgg=;
        b=Wbmkhzs9zkYpf8U3vSbD1X2REmADI/AEZETE2ElYt86x4GF7y+GYDyI0bSezfO25Bk
         RPqCdUybhubMesM4r5wXXpChEzjLqnLWoaRd0h66p5WtdhKpLFE6R7VTdnryAbXa1Q/z
         U2S5FhXcdwvAKTyTPiKo+2HvYq6uXrcyrtfbjCeMmx4tV5Khb73f6IxPoLyfNXmH9Js0
         wZ+SgxxRr1QigvDw+muAqul3as2oH7Z7ZU+OHtxXqPCkwe+IduXrmfqUQURSjP8rYRX9
         RsAJBMpYzXQtffxC1/WtsaMDRyos1reSppgPZFlKAIPx9u/IytDgO5VO8BakjBaNvoa9
         NXXA==
X-Gm-Message-State: AOJu0YzYj4SD6dKz2zGZ/sGy/wSfvLAfCLF28vEgBtaGgj2bchjvoWF/
	2xRooVtYfuNbWwmZqc0/46Lq810ch0WcqEZNtyP569h0tggtbyEB8FHQ
X-Gm-Gg: ASbGncsNk15W2vn0Pn2YMJh6/VqGQ0aKC3vUBgGHYR+JsIl/b5v8RkToohegJ6QXm/L
	WqpNM2AoncKpn6eUFeFNcJu46oA9Zz/bDTgqbOw41f3iL4CxlXh5/gkYQVZ7E/8zPC3i1izVK8O
	PV0fY1Tl+/OiyKBQcn0mwCSYAuQJx/NPGUyJ7TPJgOLdy5XziaoJidNsJf57POQt679KqvZf4Q4
	dgJpvfa9xndaKRP7WIfVdJrAse7TatCN4H4aGG1okBCB7yd11SQNRwQjX8Pa606jtN76xJKfuoy
	kW+yyf/+e6rfY4Y/tzJnXhXoUVk3WdSo5lL97g2kgFfohgS9XbTX3JMwEZ+UA+g09+ck5a0jVzZ
	TEEZ1NF/HsYc7blsHla5KL/eNfBbFrRekcIa/VhvtD09KwWB2ZjO2T3ep8tIakR8C9FIurpnC5n
	W9TQfzS2mom5QasQ==
X-Google-Smtp-Source: AGHT+IEd1pdpsJYlB2fuhN5fltW09lm+K3UXG4zPUx83WuipQLTwqD5IsTD3tnKNseWYn944zuHisg==
X-Received: by 2002:a05:6808:1b26:b0:450:3ff9:f4dd with SMTP id 5614622812f47-451159c9a75mr1014484b6e.24.1763744563522;
        Fri, 21 Nov 2025 09:02:43 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782bacf02sm1803010eaf.15.2025.11.21.09.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:02:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: marvell: modernize RX ring count ethtool
 callbacks
Date: Fri, 21 Nov 2025 09:02:34 -0800
Message-Id: <20251121-marvell-v1-0-8338f3e55a4c@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqbIGkC/x3MQQqDMBAF0KsMf23AGdRFrlK6iPrbDmhaEhFBv
 LvQd4B3orI4K6KcKNy9+jcjijaC6ZPym8FnRIG11quahjWVncsSWhs6jv1o2iU0gl/hy4//9ED
 mFjKPDc/rugHg3fwxYwAAAA==
X-Change-ID: 20251121-marvell-0264eb5b214a
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=leitao@debian.org;
 h=from:subject:message-id; bh=tBAC1l069rZza6dG+NN40YVkYazo6FpRQbURbBbsfDU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpIJsyp52PkH3rjxO+ewPUpPALhjW4xetCOAeA0
 muKdkn3K72JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSCbMgAKCRA1o5Of/Hh3
 baYHD/4gBfFprBjBjo7VguhQYH52+wHmdEzrW48rAHmM6N3bGwG8kxVO5fOcCdeUOBTKLSy4goY
 AgswWgtUsAWZbNFR6atxYBmIMiED41EtCgzVLeJbddm0utm4UBH4ZcAxSSL2F9Sqet0/zZmdiqB
 NC/OtyFTsEx4Cv1mGMANu3h4p0ePXNJJUtjopb189g8HUQ4i0OHXytziOqIwfGS2y51rcnTukyW
 9hv8lOFQlEjWLfpjnu3/3EpuCWCg55tjledcyz5FF6ekgTYYHeVhhUgJ5iUsNvHr51XbWleBmiz
 MISghen+q9T7Ax2QB05EcZUzFywjIouyUVDq/qfI4OVhvp/Fb8b9owVXYMGh1WfjcwKZJfkOgOT
 tRLyk/bDPZ+wPsdpEsaBMr9OgE3objO3PQumedAodEaEQaShx+QerjqsNZLOD17UBueUEouYcDd
 Y7/LKXT9237iZqIVBiIN4xbKmvqYkbDO5mDgIg/2ajr6e3w0EYNDqlBDlGFQfz32IGZlpVXK1lo
 +g8QErODp7LT6l9q1EO4bhvJe5uyWxs8oqWqfNgDYScG8FOLD/LRdE6w0ylr+fBX48Lz7SLfugE
 1d++JihBsO4NYqmdy9QUbgY8vZVDNTAMn7YlzRmKWiybmrNF/etcSgfpKWuQrJyU01d50LtQypF
 qCLsHG8VI3fuSpw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This series converts the Marvell mvneta and mvpp2 drivers to use the new
.get_rx_ring_count ethtool operation, following the ongoing modernization
of the ethtool API introduced in commit 84eaf4359c36 ("net: ethtool: add
get_rx_ring_count callback to optimize RX ring queries").

The conversion simplifies the code by replacing the generic .get_rxnfc
callback with the more specific .get_rx_ring_count callback for retrieving
RX ring counts. For mvneta, this completely removes .get_rxnfc since it
only handled ETHTOOL_GRXRINGS. For mvpp2, the GRXRINGS case is extracted
while keeping other rxnfc handlers intact.

PS: These changes were compile-tested only.
---
Breno Leitao (2):
      net: mvneta: convert to use .get_rx_ring_count
      net: mvpp2: extract GRXRINGS from .get_rxnfc

 drivers/net/ethernet/marvell/mvneta.c           | 14 +++-----------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 11 ++++++++---
 2 files changed, 11 insertions(+), 14 deletions(-)
---
base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
change-id: 20251121-marvell-0264eb5b214a

Best regards,
--  
Breno Leitao <leitao@debian.org>


