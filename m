Return-Path: <netdev+bounces-232904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01545C09DCD
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C145C4E9468
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3C13002A4;
	Sat, 25 Oct 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDWr9NWj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E32EAB64
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412404; cv=none; b=QnyeWYKVAlEZ+zMAtq9FEj49v1nPSOHey/+NWxGRm/jpJMA+w3FTWKm/1cmjyXPBYnnmwpg9aMaFy2/xb8k6meE0DhWOW7pzryW4a1LVBtvbGPRyJmivToZBZp82w/nvwlZFcaqNr8GYtLqzu6Vuu7UR3zdQpbLkP0nt4IjN6yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412404; c=relaxed/simple;
	bh=7lmGC1q+c+FgaQKsnCMXwCqQEYlM/ahItBJoPnseraI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVlY4+4VMUN5kONd3Ds9MVBOcGOk8MHrEN3MNWmrAhxXtQdVaONPmXZy98NhxVtbn58cEnEOESYxM5zB8iSXfuuMWDkUl8WgkVuVd+VPB58z6VmylTzHhMeJpO94fO35Qg9rDpGgH0P34NV3aF1Gh+V30gBk7vS89QmapEB/LJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDWr9NWj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso2660674b3a.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761412402; x=1762017202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z48sCAKG3WKzuxot8CdFTX8oor6ocdCy16+r1lGqXvU=;
        b=SDWr9NWj1Au46BqeZ3hZ+xcBs3b7LiQ266gksE638zhLp5KE+D6O/E1f4q99Wsda+v
         VQvvnDcX1cnehQb2SdDQtKpEgwKIa9acdj82BLJGKVEzafmK452eSo7ZlsLD7iSnWpoE
         rgUteKuQrvrRsCdbz8BxzBkpMVf71kRjKhR7uiIpratmmNWgcl0u9hgRYbKB8vyqEGHM
         UgztY5N6ckIwm4uha33JOjhJWEMdZLGorOyfNTffnLIw2VeczggZBvGi63RipgHWOQpy
         j+HnSMMdxglUz7lMECrkJrOgz5PJxI5aTZ6QoLCO8RweMAFyb2mfQcTYoIlJjOpP7z8g
         okCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761412402; x=1762017202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z48sCAKG3WKzuxot8CdFTX8oor6ocdCy16+r1lGqXvU=;
        b=sbHdEtxcpExQQN8GB71i5HV9H9JT4sckxaVe1LBm7+BUfOo1td2hulDN0suiQmkd/e
         x74FWe1EPEQojran9gMFhIWeZTXVf9RS3XtstMPFTBrWc61NEiHdnHBI44NYUfLcz7J9
         UnhEPS70uyOr/1ABsMcPj7kMQ5BPsobsilvhFLWCDPdzz7uDdOVXq0zYBmYNMQoS2Iub
         f1rsBeBqqvdy1S/vlNyjoyi8tZ3xjVftDsbm13v+KNIsxhPVMmYxBJiVZMEevF70PO6v
         JiMU9UHtLCQujurgiVgTxtUpcMHz57THgUe1YpEM51FjRA0lByfeo4+z1YfDoGiVl9dS
         XuoA==
X-Gm-Message-State: AOJu0YyOcxbPNstB848t3xMNrGZIrL20Y++nHJaRRxvCgXs4L02qB6v+
	8aEZpO77l13fCvGF55pdRx4I5O1BynM2J/Hxcf7TA1blG8FaUD5aee4a9xzrJ2IQ
X-Gm-Gg: ASbGnct6NajrXlh/m/qG/cVbIPeVpOYu/DWxG6fyDRrpTWAl0/+6wnJPVrFqNBchQMt
	V29uUaHt+46C7Fh/fxYwooWhM2gVfwvdltoRRK/nxG7LpEGsrtB9j/Qgyr9Zr/Xb9jmt4kdRlNz
	RV8psx1r1mlzvGu17cT1e++6rf0VLMemTlTM+8JOCVps8v9fNbhS++MWUjw6yoSFF7ERUFMLHEt
	dCoKYtwUbcP2Cj2MgewWMq8GlESmTCXRfy597T97C1x2G+TavW8BWPRtBKbMhNSoC+KZTD5qbcy
	s0H9MJLKuFLubwnInA5qQCVVDB48zmjhfq7wrg2ediuoYT3U4V2h9s7yqf3RoieWb/qJumHreyb
	kijF3KgktSHZppTDSNlAjuJnnFra+w4TmaueJSyPQcIeTFr6blaiQN7aUk9am6y9lhjj4f0C4r6
	SQGmVDt2s=
X-Google-Smtp-Source: AGHT+IHuS/nhNRyMpW/6+6GKiMn0JmU6Izue3QmhMGAWwUn/W6gLcb1ePdGRXmR3Cz1EGUJD2ljA6w==
X-Received: by 2002:a05:6a00:2ea8:b0:7a2:86c0:d630 with SMTP id d2e1a72fcca58-7a286c0e196mr6720193b3a.0.1761412401862;
        Sat, 25 Oct 2025 10:13:21 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bcesm2850481b3a.8.2025.10.25.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:13:21 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Sun, 26 Oct 2025 01:13:09 +0800
Message-ID: <20251025171314.1939608-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning reported by static checker.

v1: https://lore.kernel.org/r/20251024084918.1353031-1-mmyangfl@gmail.com
  - take suggestion from David Laight
  - protect MIB stats with a lock

David Yang (2):
  net: dsa: yt921x: Fix MIB overflow wraparound routine
  net: dsa: yt921x: Protect MIB stats with a lock

 drivers/net/dsa/yt921x.c | 76 +++++++++++++++++++++++++---------------
 drivers/net/dsa/yt921x.h |  4 +++
 2 files changed, 52 insertions(+), 28 deletions(-)

-- 
2.51.0


