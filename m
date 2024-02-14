Return-Path: <netdev+bounces-71675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A94854AE1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F2A285DDA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7855C3E;
	Wed, 14 Feb 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AsssQ2ej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686854F82
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919129; cv=none; b=JYpxdyOP/GpOEOf/CpvrOzXLeYH6xdpAPUtgSIME0Q7awmqkzvJwmVNlwuHL7o3LwiVQMhZvUuFIszLvH0fONN+XPkUpFLmihKXC5XtCTmatUm2ZJqwEE/iWoWBfSo+pT7QAmfEomV2nI9OuChCaCrU0/Qodpo5v9QX29/ugth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919129; c=relaxed/simple;
	bh=QTo2vaKjibWxTlfxwFldo69+DAlArXcmbGu8z0hzYRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sc6s4fuKTdHgR21zq5hBktdqi0UuWaN0wcZ7g87WZf5I2LH63ixIXc58WxGCVMduA3T9sLqAihuwJNRI0wgmmSr9bZKzU5bY3k3k06VYoG4O4LeR/y5XDECte6aQMRf1dT81e+Fc0/hToo+siDIbvXppjFVWEPXy5sA5Y4Til8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AsssQ2ej; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33adec41b55so1247278f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 05:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919124; x=1708523924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2Q2Z0kn1NfJ1eM/+pIgOtt+zWhQbGntnuOFYjaTGg4=;
        b=AsssQ2ej7zhSw+J/gtV6ynao+YDWXqOlEZHxHeSJsV6t3g5vbegZZGthpJ+v/Oz1NC
         XQtDjMkOToolIUWNfvfhZ/XfkUcCh1On24v5hLbc5c9F+sUqFPbbq6kVYnSJBGSku5E7
         Wh5ddpQaSYh+G2gtipZWdQY1Fx+Mg5hPnCXkROvcqQ4F8lRc+XxgxUkcdkGwmbHQZ2kr
         BZUEtZ+4pP3H+S7ymU/0XyXyeeiD0eGUHoT9hc91q6zDyRb2x9gScA5jcTGMepDXL2V3
         C1EKJumpdYxAS+BJUAFYwI8BdZsTsmxjkwJXx7iTkcj4LPUaK6Ru3caAuai/h+7dtIEn
         rS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919124; x=1708523924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2Q2Z0kn1NfJ1eM/+pIgOtt+zWhQbGntnuOFYjaTGg4=;
        b=SarvIfjyH4rNA3YabEmgF710O3oUNN5e5h/Vkgfx9u+qDSdtyq/6xmm3TVe0xQICZr
         576tmbkBA6en4JDip/WBQ0pxJbEKmvlzVH79FHX2F0xR+vmgtJfqpbjlIpQRZjzMrAbm
         L/ezxKvJJZLYBMxwN2DyBsmQAA7ey4Q2y/tJxqZzMZi9fA5PUQH1wn1YLZ6nJyd3Wk5F
         PZkquUJ/QOk3DdJB7m+tScegC3u6XSqhdA+68zX2mlcx5B4XMS/rdK6nomRDVHjJVL3H
         L7L3T5PRaZNLToQYqZw1x7itjCbmA/Tb7Qi1R0YAo7KYr0+ofLzej0c24RrvlRl4rlIe
         w6aQ==
X-Gm-Message-State: AOJu0YyMQh2SfBhf3yxO8c+TKifa6silQc1XYNXLkNDoC4D1PcnoKEFi
	G7MvDgJ4AFPsWIduSHmJPlZHVPgD0sVx4hOsZ2HajFLMKEtjJw/Iuq0fkq4gvqs=
X-Google-Smtp-Source: AGHT+IHgn+C84i6k8WfBVbpgkCeTeSmK7AvBOIs04oUzRLgjnN4Fjc230os6xl6EDhs0YTi39B191w==
X-Received: by 2002:a5d:6a8a:0:b0:33b:5590:c0d8 with SMTP id s10-20020a5d6a8a000000b0033b5590c0d8mr2032758wru.8.1707919123924;
        Wed, 14 Feb 2024 05:58:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0KIs0Wvg3WpjPl1XhfNrCXJ3W1SDOeAr5Cgfi0e4/ooyOaf6/goMabQ+NX/EXdTcgZuv2E7d9jxAN/aYO5mG/8plYFjQQWp18idSRI/rR2DnpuQhbyP3V3OJMqvMTSRAaMdirXYE2GLPQCNAibc6o2KUt75RsooJZXPFH+BN5WGnQrnJXPxmweTRPz9oKzsN8ln1ql4CeqYlmBCVd0BjH0vhs91vHDZKKcr41QmrJPThvAQ7dPLt1vpt919a5Enx6jQSE9gwzfC73ZLAhDnphiideF9Muz/GFke4sqBqW4oxWX40I/wPmkeET86Fi+giydpG5pxvpjktH4A5zOiSSEcVqbBjLxsb24PueU2YKkVYU2vU9
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v4 0/6] net: ravb: Add runtime PM support (part 2)
Date: Wed, 14 Feb 2024 15:57:54 +0200
Message-Id: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
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

Series adds runtime PM support for the ravb driver. This is a continuation
of [1].

There are 5 more preparation patches (patches 1-5) and patch 6
adds runtime PM support.

Patches in this series were part of [2].

Changes in v4:
- remove unnecessary code from patch 4/6
- improve the code in patch 5/6

Changes in v3:
- fixed typos
- added patch "net: ravb: Move the update of ndev->features to
  ravb_set_features()"
- changes title of patch "net: ravb: Do not apply RX checksum
  settings to hardware if the interface is down" from v2 into
  "net: ravb: Do not apply features to hardware if the interface
  is down", changed patch description and updated the patch
- collected tags

Changes in v2:
- address review comments
- in patch 4/5 take into account the latest changes introduced
  in ravb_set_features_gbeth()

Changes since [2]:
- patch 1/5 is new
- use pm_runtime_get_noresume() and pm_runtime_active() in patches
  3/5, 4/5
- fixed higlighted typos in patch 4/5

[1] https://lore.kernel.org/all/20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (6):
  net: ravb: Get rid of the temporary variable irq
  net: ravb: Keep the reverse order of operations in ravb_close()
  net: ravb: Return cached statistics if the interface is down
  net: ravb: Move the update of ndev->features to ravb_set_features()
  net: ravb: Do not apply features to hardware if the interface is down
  net: ravb: Add runtime PM support

 drivers/net/ethernet/renesas/ravb_main.c | 132 ++++++++++++++++++-----
 1 file changed, 103 insertions(+), 29 deletions(-)

-- 
2.39.2


