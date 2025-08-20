Return-Path: <netdev+bounces-215379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5BB2E4BD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FF11C280B3
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE3272E43;
	Wed, 20 Aug 2025 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b="WCbjBL6M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183926F2BC
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713516; cv=none; b=JHDbHne/Dk3tUQM374JN/RsuOTXpaD38fzbOFjGvL2kUvd+UBOwYphH5r395Xa8P2kzGpRApZX5tmvsbGWqBdaaIYOJ6DXV54VghsQhur5AIR442DdsZdbyS6ue5nZYUuJH4pF1YQ3zZ+LHzWBBmsxot8TauEe8YsHC+VwY4oJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713516; c=relaxed/simple;
	bh=5y0tb11bAfwjQcAcD5wHTycE+79QfXfSKAZzvsQNrkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqKxQLRV84BoWpH3C4JtNBAtIp3wJT40FvsrZqk1tfRAtyGXk3P+3sDsiXSSOz9yHoSM4Ql84/96YKhKA6XYWtmLQu84v/43Spu9AbXGP2N/CVzBsEB7vqrDzyWTEfRfGMfG/EOaGRWzo2iNnbCn4lgqu8Z0tCkPBjXQZuT0k4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech; spf=pass smtp.mailfrom=aurora.tech; dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b=WCbjBL6M; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aurora.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aurora.tech
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e8704b7a3dso10434985a.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google; t=1755713513; x=1756318313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y0tb11bAfwjQcAcD5wHTycE+79QfXfSKAZzvsQNrkY=;
        b=WCbjBL6MQJhlSf7KTnVFY6iWmtr5xVZMU1EOTf7qySbgiQjRkP9MskRkVeN3r9PddZ
         wSp1QxM2IpAG409e0rN66xAsvjVqwZ2J4hsurjeV6tPMolJu3DH3NtBoeJ04smzbjw6j
         ov9HllX7seKiSAk//9r7qXLDdmLWxGFWX9TS7G5dIeKIlPXk08JdLFOoDMzL+gNVWiEK
         C1NAG7XpxgpxeVWdlcswE+CVB0NPvQXaxrbB1Qv02mBW4rgWUknclnxSLuq7sgkC7jIj
         oz3OJWOGxeSvZFhoDYkKfHdVqX+2+owqreJ2H65SWJwxLNlRq03gJhkvbNgZ1Iy6hTMk
         cpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713513; x=1756318313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y0tb11bAfwjQcAcD5wHTycE+79QfXfSKAZzvsQNrkY=;
        b=D+pH4v4kQ/iMvQqMVVtGLLsRcq76yY6DYD2J1CPZ9Rl/4nNcXSZ0Zki7J8/FL9Ig1G
         nymeu+IHD1ydKtFIHPuZFrr/gqPMHLmBDlm/C0iTa9/2n2OAIt/PH+6C1lhbLeQq/aS3
         I0ljb3F5ll2zGYKmi+V5I2PdozbsncRMwyZ3a8fPqjNV28CPQjqSTbM7Zs7xim7ZdoeZ
         9/bDgjfC7Zo3gM5aSwSQYFoYUo/JtUD/Nlq6LoqNyzORtLSfb7RDPosYWW017Ub1O9oi
         x2CyfU6/ZLERAP42PtW4rLn6+x4edSeRDlALhlDe+IyuYyEjv2e+ulB+0LCZsEywZxnZ
         ypAA==
X-Gm-Message-State: AOJu0YxYFQwxfk1GwNsDahDDlKOiYpOrm3ZfoYbmqctf8axSB+yKkrfB
	BXsM/h2FLLpDD4no3Ofp22rD5nzMl1oKHIK1SDuxYcole8fdWHNN9KVh9dQB0+IuyUhwAyPrVDF
	bcZIZQ1S6rvtbPm7RtwXoTlho11fiZ5xWUFXK2MhGq6Sdxd5FN0g235j3wR2fFibrtMla3dXmBu
	IZnoZrB/19pySN0tkcn96RKPPkj/0g8DhFKN4kxdJ91qZhkw==
X-Gm-Gg: ASbGncv08pv4pc5BtY0J6KVyHKSnum2ejy1DBybaU72uo9E9/CujEHfsqmblTZUP1tT
	0Y2lu42SuBEhlPAfHw4pGSa35Qpq041kzHGqf5YCj6XwihTgG9PYn5xXFaFRFT8omY2jn4AR77a
	TeBEbJ+Kv3pncYr9yy03GzOOnqVMJ/kuh2xNYn3Zq+pYVydKOfA2or+QaK3bnyl46ry4yUkKFrA
	KfQizQX+ixrlqJoPX/L+Ib2ZRM4uAK0J7csuYj1TNxJBWmYPJh84VgSYrR8cmxsj6gOs1ct17CH
	Vtq++208pYx8KMwuxsbF5peXmo8F582QNk6iwrbnoMWmhz2E5LMFbHBur7xqM6IXXZK+NM+xr6S
	6uBZGwsocCpcvIcY+ah0tkDRcY3oKkIiq9K5kFXUaij3DpaTTQYV9eJ41+dY=
X-Google-Smtp-Source: AGHT+IHrpXF0JwDQHsPT2241OVo1HXqPYH1izhIJ9UXU3feFLHmgGxGeI6u0QFY0R52WFLMnDsnQ4A==
X-Received: by 2002:a05:620a:370d:b0:7e8:4337:8ffe with SMTP id af79cd13be357-7e9fcb0bc33mr461231685a.47.1755713512404;
        Wed, 20 Aug 2025 11:11:52 -0700 (PDT)
Received: from ievenbach-5SCQ9Y3.taila24ae5.ts.net ([2607:fb91:8201:920:c1f5:e65a:cf92:2a6f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c56e9sm967134985a.67.2025.08.20.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:11:51 -0700 (PDT)
From: "Ilya A. Evenbach" <ievenbach@aurora.tech>
To: netdev@vger.kernel.org
Cc: dima.fedrau@gmail.com
Subject: 
Date: Wed, 20 Aug 2025 11:11:42 -0700
Message-Id: <20250820181143.2288755-1-ievenbach@aurora.tech>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <57412198-d385-43ef-85ed-4f4edd7b318a@lunn.ch>
References: <57412198-d385-43ef-85ed-4f4edd7b318a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please could you Cc: Dimitri Fedrau <dima.fedrau@gmail.com>. He has
> done most of the work on this driver.
Done

>> +#include <linux/mdio.h>

> I'm curious. What is needed from this?
Oops. This is, indeed, unneeded. Fixed.

