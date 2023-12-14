Return-Path: <netdev+bounces-57345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3AB812EA3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026362823CC
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C313FE5B;
	Thu, 14 Dec 2023 11:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pWsLpYCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D09F5
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:35:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-551c03ae050so3046794a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702553718; x=1703158518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V0lN7lqB7W5a9CFQ9TubSyTsdw9omFHDKq2iCjTufGc=;
        b=pWsLpYCyyLUogAYE9UFSjvwV+Uync7yVasgqNYTg+epzmVJAj5rJr/GJIsZrUGSEsc
         Yi2Ry1ukyA4T4F5PmNxvWs55uxB0pA8ODGuLVIYxqEeyOjYK9fGDo8Ei6iaA2pot8jL+
         V/eXe6DyAX7X5OoBue56/yJKyGjpI+6jCzfiOi4AOtASe8D97dgmcPsvD9cRaXMqjwVp
         q5JyMLBclLkdx0Jj7w7QChNe2JJjQCzNHFVM+qFXpHIPQVxdKLA3usx17/H9itrEOjwS
         elyu6aSbBh0hf51SIda08FjnOxuIlmTWWxaGR5O8a0XaSVs5yOIfO5ml7RvqKI3Eix+m
         IZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702553718; x=1703158518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0lN7lqB7W5a9CFQ9TubSyTsdw9omFHDKq2iCjTufGc=;
        b=LiSoEQ5K5H51rJBw/W+7IqW75fUncKWD1e++GszHYoAXTcM+SihboMYr4j7ndrUMzv
         +7kZfUJX6klUTzAF4LWW6xyTqLZw9NtVmnPsxBxISbjGbNTCpCwUy60xbwiNJurs+Ay2
         4X+ZJJHAfrTdFAKVcErJ5A7Nttk3b5WnEDivUrxjFrVd92pyAKM3qi07i6tb+tN7z8vv
         69LOPxC6C5vMyFJSvF2XSGelfbvBs2zqioFs8PPxqOpLI7XauX1gqj/HOUBZTrvJyKjh
         4v3tEQQ9Wn6YBgw63PI3jO0BgZP216fnle3j+lCPLo7gehHdcaWDQPopgQsquX6YnJOE
         C0Qg==
X-Gm-Message-State: AOJu0YwpSfQZqZb8CrY/akNAHGzHGEjvBe0PoA7LUAlylVzZKZCEist6
	R8/2DRLK1FSRLAhrBgziKUtqKQ==
X-Google-Smtp-Source: AGHT+IF+xr8PlZ+FtDZFBnHVTRiKyiPP0SraqXz1/bLYb1tElTf1pbuIGEvxDv0nCqa6p5sONRjwtw==
X-Received: by 2002:a17:907:3da9:b0:a18:4e1d:a360 with SMTP id he41-20020a1709073da900b00a184e1da360mr5224871ejc.42.1702553718174;
        Thu, 14 Dec 2023 03:35:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id vx12-20020a170907a78c00b00a1ddb5a2f7esm9290656ejc.60.2023.12.14.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:35:17 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	claudiu.beznea.uj@bp.renesas.com,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com,
	niklas.soderlund+renesas@ragnatech.se,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	mitsuhiro.kimura.kc@renesas.com,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ravb: fixes for the ravb driver
Date: Thu, 14 Dec 2023 13:31:35 +0200
Message-Id: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds two fixes for the ravb driver. Fixes adapt the code to comply
with the hardware manual requirements.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  net: ravb: Wait for operation mode to be applied
  net: ravb: Check that GTI loading request is done

 drivers/net/ethernet/renesas/ravb_main.c | 55 ++++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

-- 
2.39.2


