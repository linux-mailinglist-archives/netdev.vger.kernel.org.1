Return-Path: <netdev+bounces-144058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E7A9C567D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0711F24FF8
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A6218D7C;
	Tue, 12 Nov 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzmIUJrF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F49218D69
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410257; cv=none; b=KkwvkNwihdIdrD63zgUsyLd5b83HaWaHVYd7nGD+nDARmI5aiMmUHkLy/pP08YmI9+asMm08Pspd1WMjWgg9pQb7fHLORmSjZiCC3FLmsKZ2hFA9zsZ54rre0ZHykvsonnaRKmp4RGrqe5W6w2Vph60QhMgj+82gJ4XNzT3kjmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410257; c=relaxed/simple;
	bh=VEjopYYM8Hj9eI3kGQIpu/ViVRSl9M0p8Ov2R/hADNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baZv2/SwMkd07ZM4FMopPgNOZCw/g7B87YLIX//Nk65Klf62b67bKk1rjwFzhgQqbCkvxKeMvIWoKugJgcrFUAlcj5eJc0eJ/+N4f/w8wmyEZ9C8kP2JOPnNrBsiCadEDWAobCF58w6rhcgp9RuRakU69IGd0EzjS+mODTVlOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzmIUJrF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so46100265e9.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731410253; x=1732015053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMMJ8iufWL7WXj+xSco2QGisyCXwnqa1bB0nKVngprs=;
        b=fzmIUJrF/EAUMMQLbrv70l5xjHqleZ4TdkJbjDqzcITYu3EoAMRFp/Sxe0FQh8NwaQ
         54iWDm4G9t+nVyTbsgEAK77aWFnNvoNFVVmHkxgiRRuBC/eArDtiaHgBBCOh7pu5a/Tw
         BCUKWl4dPuL0llOn2+VP/rQwwXJ89SvtEAeE4K8q/sP54Z2SfgDuv+5p9H4WIAAKhdG3
         YFih4xTPJD1wFRm0QzcbXSBoiESA8QTpL5vbsF9m19PFhypXExG3GUintJZRwAGZrFIl
         dbLpm8sKA9KHBvK2iqdPuK8OAryO4bXAHn5ML0e3+uA2vESHyrASOMkOeYWoBBhIPFBU
         k7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410253; x=1732015053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMMJ8iufWL7WXj+xSco2QGisyCXwnqa1bB0nKVngprs=;
        b=wXe6acMIB4QXJ0bZZwxZnZvyp9cQjPZQfi63JQFyvKClYJWOXEt4e2RX5iyPqPX0Pt
         lv4DEc+P5RUKLWk9dBHbud1lTRQwEsWlDnhUWE6deOgrVuv/Wq7UmYn7o5abRqLZ2Ekb
         17lQdFBOsPedQbSdejARnzGwA8jPonXSJ+9PeSvtLG5863d+Mxkv5Vxy0ahgkgWQ3t04
         7vtRFbeFv792PuZ1q9XB+vOUkf/5M0gp9/YLgvWu47V4AwhPN7Gu7edpqDvTn+bo6+ua
         dLElA7mWNbrFYo54gT+jgLX63a1gxxFsaowthLcfqNwKT0CzUQyRCm7GIC3ml4Rcjn41
         lDXw==
X-Gm-Message-State: AOJu0YxyAXcnp7kp2rZ14RyG0M2qowjph6SNgR8yjAG+1+6dDxp9naSR
	mgzQ3RaxmtBcY4inarodoKYeKgK7qsrLbW5ZXc6dpQfRlbkD84ZPYuqsUemk
X-Google-Smtp-Source: AGHT+IEELUWmEucz0XD2PrMwFsWo06UVes4YeVwKRZQQNQ6Kr9Gs3HzSvBCP6UY8na6XhI4NJ9lj1Q==
X-Received: by 2002:a05:600c:4f4e:b0:431:57d2:d7b4 with SMTP id 5b1f17b1804b1-432b751726emr143564335e9.26.1731410253107;
        Tue, 12 Nov 2024 03:17:33 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:a1ef:92f5:9114:b131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054b3fesm203543685e9.17.2024.11.12.03.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:17:32 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 0/2] tools/net/ynl: rework async notification handling
Date: Tue, 12 Nov 2024 11:17:25 +0000
Message-ID: <20241112111727.91575-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert patch 1bf70e6c3a53 which modified check_ntf() and instead add a
new poll_ntf() with async notification semantics. See patch 2 for a
detailed description.

v1 -> v2:
 - Use python selector module (select / epoll)
 - Remove interval parameter from poll_ntf()
 - Handle KeyboardInterrupt in cli.py instead of lib code

Donald Hunter (2):
  Revert "tools/net/ynl: improve async notification handling"
  tools/net/ynl: add async notification handling

 tools/net/ynl/cli.py     | 20 ++++++--------
 tools/net/ynl/lib/ynl.py | 59 +++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 33 deletions(-)

-- 
2.47.0


