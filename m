Return-Path: <netdev+bounces-75503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B191786A28C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 23:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A6A1C258B2
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29A55C04;
	Tue, 27 Feb 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="gZCU3kY0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2AA1DFEB
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073226; cv=none; b=Woq3peYDjxlBjDLSRtadjbxMOri4FP78ITzPM4WGaCqlKmw2navNbWHONfYWSkb1annvBRt+mY/bWk/ad8JF4W/PNzCRBuiI/y+kWHr2TzXTdp1z4w6IPvZd/12KWZ501eTzgTWJfoRY035ZZ9+2/usOc75p3fE3boLnXHpd8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073226; c=relaxed/simple;
	bh=UOa7JuX7gXiVuYl4IAYiXUx3Y3PVbL4V1SZqE1lhRXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RO30dReA87azVPJEMQk1vs1NouNUKXXnPZUQIlI6wXgJZh9CEux1yl0g7cPbI2c8QQJJnEporFtFC5DQBdiwV0EQSNkrLJClkTpwBSMKTsi0lVUqIyCnHrvHDxY3GPkUd6QksBVjBxIhDeFeYppZpp8K+WLm2mmXlkSbh8U4lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=gZCU3kY0; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso64490021fa.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709073222; x=1709678022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXkln++pp5q7qePZRB0MDAZzW3xrtMQa441/zh5OMDg=;
        b=gZCU3kY01pWn+S7wDDw+FzP0MpcvmXT7y11lykylf33aeGX8sA0ZYnMK2j2X7RddcI
         AQc136leQpNHl/OeycVMuIR7PZwVM0iwC2ubUMq9UUguSW+uOeMBc524A250YgEs/gMI
         o7pGMx369IBbDV9tKd3FgARUt9jUEuzfG/Rgva20Lan7UBiAUqyeIz9+dQ+HICw0pO+z
         JrETRCGNBKABx6ujDGhJ7W9zOHgQH+YJj+OvrV+WirIeQaRHogtTbMCBr8V7AFVKT9ss
         /O/7z+wWLRhI/+5udlXIJQUMJpDuCgD0AINu032K5PLOlqSK6phrqvqb0QAsTcyURuTM
         ln3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073222; x=1709678022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXkln++pp5q7qePZRB0MDAZzW3xrtMQa441/zh5OMDg=;
        b=WR6sLXy+f3ctVyQMMP/KaKYlUqR041anZpYHagmMs40PK2GQxeaRANBSVgQlz/NIUd
         GlNe1/xORC0yJXiJJoYyh3GVcqU6GvVCxinxqpIJBTZCFIi0uPxH3oTW6kMDweeg7scV
         60z8MBNU3Q3156pPAZCpBvWPGTzdExfcQDY3BkH5crlMqAvyJYHj3UykiQ4WzclUYWo8
         LvEC3JhTYbEU9CgzLXreX8+Nn1IUd0gZRJR0YmWPOvxm9cUd6kzCzseM+LFsXBJ47fXr
         Ix7qEjoAKMoiCxUl3Upw7GTNRf6OdjxY7Pa4OgV+eTySiQNwk9YswHtzkeP/oyCVjt04
         mDvA==
X-Forwarded-Encrypted: i=1; AJvYcCVudmZWJmi5bHektpwOVcVFlwy07c26VD0rLbyh+HfGPRo8UI83WHj1dqb4Q51Mth/kNZ+QTcrBgoON/5kHRD1CDf5jr7fk
X-Gm-Message-State: AOJu0YzIII3HVd0zK0ACLobw1mD8cejWJC62OIDC2PeMjYDaC/ouXPiH
	QzgpErQGvl8pRgj0howEUmq5YFKnyhBZoeCENNQmG1vk/oFUjPZ+qtp2jhV1Ui8kHYTtTRLe6uC
	f7IM=
X-Google-Smtp-Source: AGHT+IE9iBgllCE4i/i3S6fhbJQU8zEp7inmJE4WCVyzWi48x1LmpTbtSa8dhMBjEvRNGYXSwPtADw==
X-Received: by 2002:a05:6512:1103:b0:512:ec79:3bd1 with SMTP id l3-20020a056512110300b00512ec793bd1mr9740348lfg.0.1709073221553;
        Tue, 27 Feb 2024 14:33:41 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id jp11-20020a170906f74b00b00a437b467c92sm1195860ejb.177.2024.02.27.14.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:33:41 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next,v2 0/6] ravb: Align Rx descriptor setup and maintenance
Date: Tue, 27 Feb 2024 23:32:59 +0100
Message-ID: <20240227223305.910452-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

When RZ/G2L support was added the Rx code path was split in two, one to
support R-Car and one to support RZ/G2L. One reason for this is that
R-Car uses the extended Rx descriptor format, while RZ/G2L uses the
normal descriptor format.

In many aspects this is not needed as the extended descriptor format is
just a normal descriptor with extra metadata (timestamsp) appended. And
the R-Car SoCs can also use normal descriptors if hardware timestamps
where not desired. This split has lead to RZ/G2L gaining support for
split descriptors in the Rx path while R-Car still lacks this.

This series is the first step in trying to merge the R-Car and RZ/G2L Rx
paths so features and bugs corrected in one will benefit the other.

The first patch in the series clarify that the driver now supports
either normal or extended descriptors, not both at the same time by
grouping them in a union. This is the foundation that later patches will
build on the align the two Rx paths.

Patch 2-5 deals with correcting small issues in the Rx frame and
descriptor sizes that either where incorrect at the time they were added
in 2017 (my bad) or concepts built on-top of this initial incorrect
design.

While finally patch 6 merges the R-Car and RZ/G2L for Rx descriptor
setup and maintenance.

When this work has landed I plan to follow up with more work aligning
the rest of the Rx code paths and hopefully bring split descriptor
support to the R-Car SoCs.

Niklas Söderlund (6):
  ravb: Group descriptor types used in Rx ring
  ravb: Make it clear the information relates to maximum frame size
  ravb: Create helper to allocate skb and align it
  ravb: Use the max frame size from hardware info for RZ/G2L
  ravb: Move maximum Rx descriptor data usage to info struct
  ravb: Unify Rx ring maintenance code paths

 drivers/net/ethernet/renesas/ravb.h      |  20 +--
 drivers/net/ethernet/renesas/ravb_main.c | 210 ++++++++---------------
 2 files changed, 83 insertions(+), 147 deletions(-)

-- 
2.43.2


