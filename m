Return-Path: <netdev+bounces-196638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D739AD59DE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBD7ACAF3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2A1ABEA5;
	Wed, 11 Jun 2025 15:11:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C441A9B4A;
	Wed, 11 Jun 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654677; cv=none; b=bRhVMaLVyzRy21U7UXLeGOjqeYLcJi+YQSNHlsZyKq0eq4+wdd06icAkd+s9b4Bu0Ed/pTxvGmJrM/L0JbzKL53HB9qTO3/TDkSiOdqPFVUyfKP6c0KwXY/fKLDWI94rfs7SXbGdMusazvWZ/rddj6DOwbKeCPRuAGLkgfHL/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654677; c=relaxed/simple;
	bh=QYZg7OC73wHuXKtmlih1DkmRrxuzAFFmclhMxt2YyjI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ReabixMqVPL0VwmWeXS2qmFIUEPfzN/Uy0UKFXv902ANs773aKjEQGdI1+Ny7h6C11QMoWxOzVLh9Uz1fbyvL+iclEm97Wa/048w7Yfswef6T2QKQG5yukfs5sXwhiYU6ty7hFcy8ZFTfYpJLSApOTwn2IBmCU2I3JYTIPj4jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad883afdf0cso1236357666b.0;
        Wed, 11 Jun 2025 08:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654674; x=1750259474;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJ2lKCXFp8kiCnCzSiICCirAMaRWwRTHTr4+7DJp1IY=;
        b=Jx04atExBrZEbXfHXlx79poKK6pt81B1K4hzlzLLG4GRmGgiPiVFTiA6bTJhlQNdTl
         zh79ZIWESNmunmhiuO5wsgf+5L01KCZlEPT8NFpHrtoRttqPo37s8d6Q58CuVI1osh0t
         /3wZWLMlIsmBIo4OY1+nx7zGBrLiN7jqANaB6i0E+PXpTCSRPDbKcm/TlitBQ7bEhjde
         Aw2RwPgOle56nSogkifuLJ4b0S0XqaPbceV5RNAo4n30wAt1gbmMKQCDhTIbSTlr4QF0
         o7WbQ5IaRcr6pD+ErF0VwVlnNl9cj43QjdhqYbZ4QgT0ffOzZm1vgbBt1eCFVYoetOib
         nCKA==
X-Forwarded-Encrypted: i=1; AJvYcCWNr7tOuRzbFpvUvrEuB9HUSe1EXCrt4QQmU7JZbw0ZJ2foS8kBJQat20dRstqXSCdeaLpxsNMj7VZSrC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8H47xmh+0NhNyMCxEzAaIjqK2F8H5LEU0KG1PfsOkMwHEirRB
	ropcCn7Hn2nQjlsXcG8S/rQrOT24GgBRJ3/ZREfPqFSgpUvZ7bctbu/C
X-Gm-Gg: ASbGncu1qIJeuk8wJaHrnkMfI07u7SXYlx1OpBBtMf+xxSzQ5Dv50YRz7lhd+aZf2e2
	C6TCQeR4bbG1hMVCDebyYCIqhJjDrbV+ayh+udafgls5zuzFnbsAAzhL0UxvPJzfJQCUFA47n63
	GrXeiIQ6E7Kdo63IlsRc/RiK4DzQH+1V4CIt2NeqtwzABnojxdz4a9wy/pWzLrIo6kH+L/na/IK
	1SOUvVMkE8FsGakLhqpDKX/+HTeRiQGcpT0+ZX+87xIdU1/x8O/dnTEnUYrUs8HmrFRwcnsoopX
	hBrKVPWOuMGZPRi2cH1rvvjTCyN3JzcsHqcODnsdZi6XmSO7EkzKZA==
X-Google-Smtp-Source: AGHT+IHI5c+ZEVZBbvejqx+icK9CTx/j8u+s0bPSpgBRWgTV5zROrBcyphLZBPLUWDnzI9zTAntN0w==
X-Received: by 2002:a17:907:743:b0:ad2:52c3:2083 with SMTP id a640c23a62f3a-ade8c7db543mr321986666b.28.1749654673472;
        Wed, 11 Jun 2025 08:11:13 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db55f3dsm908657666b.60.2025.06.11.08.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:11:13 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] netdevsim: implement RX statistics using
 NETDEV_PCPU_STAT_DSTATS
Date: Wed, 11 Jun 2025 08:06:18 -0700
Message-Id: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGubSWgC/x3MQQrCMBAF0KsMf91AEomQXEVEiv3qLBwlE0qh9
 O6C7wBvh7MrHU12dK7q+jE0SZPg/prtyaALmiDHXOI5xWAcC1fX983HPEIttZaaE+OJmATfzod
 u//AC4wjGbeB6HD+5sSBhagAAAA==
X-Change-ID: 20250610-netdevsim_stat-95995921e03e
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Breno Leitao <Leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=leitao@debian.org;
 h=from:subject:message-id; bh=QYZg7OC73wHuXKtmlih1DkmRrxuzAFFmclhMxt2YyjI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZyPU2cwM/MU5JPD9cu/f+RvpOFkoIYDyk0oH
 qovIlk82m+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmcjwAKCRA1o5Of/Hh3
 beklD/9xoJFUPRXCjiWvuOuBEucm6JdWzgTpgDs8z3LaBNIxXLBrP/4+yOExKCdva/bhC+XNkny
 +sDwb3RnMy76tMxNi853x0yqJr5uER7LYPIsqniEJmJd0RrAvEP0lhtqNBlWs0djsoCjdpxKfzJ
 U3iMRowUF4usecMUVf2NM7awPQ9vZRIJeO8lgTmqB4mTovsOzw80it6TtmUhSX2rnyAk1ToXcer
 0VCeZWNtQn9qdrYzSOsgPMv8c9cPuKr+Dl8ou3gHY5BucJfyt94uZndKN3FMc+H5tMopPEvyyaV
 9nc1PtE4TA8YBD3f5Um3Y3MLxRpK4KsnHFbHZlPF9Zjj8shvOspHig/sqZRqKlOYqx7GqgqZQBG
 WLCffCZumMJ0yMaPBiXlMaQ0SJ2YcqdAt5l8EmoP2fyy9nKjULMFm5tXrhEEkPcHQyBoNG/DzHQ
 6HrvOrF/XC35CxUlxXAvAkYVliBEHJLpJbtRd6Gtvji07zPjR9jQTANYhN3DQ9Cu/vnEo+qWig/
 cagtUNL9eaIEDLjd2WyXBJymrx1ux8Rss0Mfw0xqZVMsYwot+BjXMVswfl8JZxH/eRywDNOE1cZ
 eK+Es2u26EyORPWCBN8g4+bXjPYdnvNPEARwfQwLX+xgqdWSQr1tle/bcBjAzffddmCtPH9tqSB
 jSmTHntkwYkmYug==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netdevsim driver previously lacked RX statistics support, which
prevented its use with the GenerateTraffic() test framework, as this
framework verifies traffic flow by checking RX byte counts.

This patch migrates netdevsim from its custom statistics collection to
the NETDEV_PCPU_STAT_DSTATS framework, as suggested by Jakub. This
change not only standardizes the statistics handling but also adds the
necessary RX statistics support required by the test framework.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      netdevsim: migrate to dstats stats collection
      netdevsim: collect statistics at RX side

 drivers/net/netdevsim/netdev.c    | 37 ++++++++++---------------------------
 drivers/net/netdevsim/netdevsim.h |  5 -----
 2 files changed, 10 insertions(+), 32 deletions(-)
---
base-commit: 0097c4195b1d0ca57d15979626c769c74747b5a0
change-id: 20250610-netdevsim_stat-95995921e03e

Best regards,
-- 
Breno Leitao <leitao@debian.org>


