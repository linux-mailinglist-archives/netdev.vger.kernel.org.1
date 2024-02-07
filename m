Return-Path: <netdev+bounces-69803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6F84CA79
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658CB1F2C1FF
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABAF5A787;
	Wed,  7 Feb 2024 12:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bu2JbaTN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91225B68B
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 12:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307676; cv=none; b=D4UzXXNhPmzk9j7EQ7uA6g5HMKYZSMRxNsFMrneBCYdyFe8EoLlOUFFO6pGqPDPMdP50TOifO4XXScTi1uxfH5U3qipSJTidBmS6A/wpCcuN28M1FaoBXY/k4XfknDpS7XuQFdGcO1PD/UEkt9lpnlMdv98rB2D4jm0MV3NL2UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307676; c=relaxed/simple;
	bh=SxlMICegmXdUBxQVVBm2FzksqEV77QNPyRMJh6d+Tbs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HzJO4hlcwpcXVwdFUV9BvSFxzdjOGI3NwMG1x8U+tYcWsMdxuIjW/DsISbex7BtEWIj9QntrL1SIcuzJsAR9/YZCSl/MOpOWqKb7g7BovsGdNUfPvLrMk1Zsw+F0d7gVQNeWX00MtA6aiHsyOeszqpYWMAzlIht2yAhHReGAwsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bu2JbaTN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33929364bdaso366993f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 04:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707307671; x=1707912471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cFc6eloGSwMPUDaRE6k+RTqrzneAql26eIJ4/C1a2lU=;
        b=bu2JbaTNXUCq6Nzbt+NZiWf69R8cNzBNPzVYnS6W+lDdtgNpc57eIrxD6t1K7fnSS+
         K93EGpajV6is81m0Q0jCATl5rc4fwgpRqoQbOa6Ivxec+ElK6FZuLOw7sAy0Jc8jFffD
         Iev1+o76mH+LGshekaDhVskMNAInvTeq0nlgsjsaaR5h6uB9iRr4DLBn9zIBzvOm7UOG
         QHQDTWr+dXWQzFSFrOwXxi5SzQ2jAkaMHm1nOmL0E3lvi2sEZ5unnG+K464832cDsAMD
         u5lrfZRluYydCngdt8xxHPOniS8881CB6VWyMC653lT9bIv1uSxlF778P2TxysjB/D8j
         f1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307671; x=1707912471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFc6eloGSwMPUDaRE6k+RTqrzneAql26eIJ4/C1a2lU=;
        b=GLqWb5UNrqiVbaA9ug/lWaYm0fMuWg+ysWGBUnNrGT6cFb1TanTPgioy1d91Puxx+t
         Ry6Yz261qQitnZwEydcN7j/o3swkCVkGmLBt55ZNhpraJXMcUVF2A9Z1TJwpjmVlq7Zk
         fCRLs41d2z5VCTvXVxFgcWq5Y7JkLkZCSouX0MAwHzdMw6meVw5HbiuQGbP0oYyqluMw
         2xfQHXZsQKFItiBjSk8wlouRiLY+u8YtOeW9zY6jkn8SvZz4StAng8mHkF0dvz7/OSwd
         TsjJGbqZSK/Bq41OSF11herSbnJhmUhyg/LDGUeOSOH6EXh8X0HeTYHk2RzVmRsZQfHr
         doTA==
X-Gm-Message-State: AOJu0YxxM6hyOgZxT7W3J4WPpvjcxuz5B+XJWkJQ2IqC1t5SAXo2VAyc
	WHAJ74TUWyc/Us/5JuAgpH7UfBXe3bUjP91NGkIRPSu02GkniiRxLq1JtYsZZok=
X-Google-Smtp-Source: AGHT+IHYuDU8bFZ0W1OL+/OOZDpOCn53HYr4vDa7Ay4yaE5N25fQ3SXc1BUZqSPmjMCtmirdIIrHug==
X-Received: by 2002:a5d:4e4e:0:b0:337:8f98:8ab4 with SMTP id r14-20020a5d4e4e000000b003378f988ab4mr2777700wrt.37.1707307670693;
        Wed, 07 Feb 2024 04:07:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyoRwjcmsp0ARCl+kbxRwBCdodgYGIqvw/qeHxh0qsZdp9vtizAAKbHqV3jD4crNufEV63I8bBgb2UQvzYXkc4M/lCVDLqAWBcV5J7l5AyLjj0rKNlv5eUmHQ4GpCpCf95cjNa0SQoQe0bhJbRxxSWVPiwLmWx0tp0u9YqMGzlPhLpz/rbYwbls1Rwe4XOZ+2lTLTQzKrl9YNCbwVK93vzXTQrYcfp4DwRggzGERY9/tzmij9sfZvMUTZOYlXHYrRJIOnTMEyzMMX1FqTaWXL65Kj4XHvpXaNS+RPeajWel1mEXbqnBItWIHTUSjBsp26dcxVt3Wuj3y4=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0033b4db744e5sm1363957wrt.12.2024.02.07.04.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:07:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next 0/5] net: ravb: Add runtime PM support (part 2)
Date: Wed,  7 Feb 2024 14:07:28 +0200
Message-Id: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
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

There are 4 more preparation patches (patches 1-4) and patch 5
adds runtime PM support.

Patches in this series were part of [2].

Changes since [2]:
- patch 1/5 is new
- use pm_runtime_get_noresume() and pm_runtime_active() in patches
  3/5, 4/5
- fixed higlighted typos in patch 4/5

[1] https://lore.kernel.org/all/20240202084136.3426492-1-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (5):
  net: ravb: Get rid of temporary variable irq
  net: ravb: Keep the reverse order of operations in ravb_close()
  net: ravb: Return cached statistics if the interface is down
  net: ravb: Do not apply RX checksum settings to hardware if the
    interface is down
  net: ravb: Add runtime PM support

 drivers/net/ethernet/renesas/ravb_main.c | 118 ++++++++++++++++++-----
 1 file changed, 94 insertions(+), 24 deletions(-)

-- 
2.39.2


