Return-Path: <netdev+bounces-239391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D220C67D48
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2740350A1F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86AF2BD030;
	Tue, 18 Nov 2025 07:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoRxZSHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B183286D7E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449623; cv=none; b=otYeaEQ2SrmPEs4221B7YsKmvLbfrYkgniL9nE1q2wSJS5PSB5HWrA1vP249u1Sixw3d2Jw/hRNnnWn/Z7HQ8IilCNf8OzC2wuvIRYKgiX0n7ahhj9XLlYR5IH7WCKmQUimEHY0PjJS3xYyI/HhZiyal2+UqJzXgBezbbwsBSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449623; c=relaxed/simple;
	bh=PPIw+20ARulSbJFhoj56dM848x/M0Y/93y5j407YOsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFaUcnOFA+OPhRjTWtklYvD3L2AWDx07K0NlnWvI2sanqyGP0u6jm9iF/zxTI3ztdexu7tQ4gwqnhspidXztaa8StogcNKHcUfvxT24WKXErtya8ma4nDInqHntPT2mVTDK8f0e1mAnWcfNdwmLTqXAnPuyBmmAA74jefqbZvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoRxZSHS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso4469490b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763449621; x=1764054421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jD5n8VkUquRN4P/3JGBV6k0agyP65jZ+ssHwkkWjFFQ=;
        b=HoRxZSHSCfJLNLRxw3ylASjwo6tfCpzzPyFDnYTIzlc964yTyG1LAUXIS6bVM+ONrJ
         fZZkLBc7owkmbZnw6dQcIxZX0LLozsghvHTyDyePusvJgLw1GBZ/ODUfDFW3uDCIwk+X
         kkFy1o1xDwTs7xtjLjBqH6swAgUuuOZIU+VXxW0jOSPQal0MDdIUbhm0a1dzg1Ed1Ji3
         rALNacZ+rqxXFF+/foL2ppbgVMFvRkshlicnnNJAE10tVdrquNKuuoQUuUDQ6KtXa/2N
         H/HRLr7a65+68AUOjmsBwU+2ZZbi7rONo1ETOGUqxKWWEOJXOzOSZDW/Jjb4iJcI0ULT
         Ryig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449621; x=1764054421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jD5n8VkUquRN4P/3JGBV6k0agyP65jZ+ssHwkkWjFFQ=;
        b=pYBa/7CAmlDwsGDiHgMFpn/DuoiJwxLnPsZHgrtmCX5FhMXOaVjIeshQm+5o/OKLCJ
         aei7GxnDzD8fht0RnGbeppnna1GVT5uENOXC0aRpxJi5a8P1GU51hgZAnI3Q+CUPAYha
         wB4+B7zYJkgMBGyMDFtIivXBK9fzz223n9UJXABlm6YfwExZ/2ZdpBtlEb6i3Xqj0KD5
         NjgO8khyEugVeSoHjdkoWgimFUHpJEdTzXWLhEsQge97IGmIph5tnZaKHfkGXo87s93Y
         QBKrSPcy9pkm10cgbWBR1GIsTtNw2EiOIE+uMhitQ7glfjqq9FXl4WM3xiV4ppGzRDNa
         eaGg==
X-Gm-Message-State: AOJu0Yz1otf7D0NQ4u0iCZpCkDmjGZG8x0FM0uVwZfSW6gEfrvJavnW6
	Ibgpg6pPWERLYOP1M5ARlIKMKNcO2Xy2ydbdVY9dSa98zKCtHLbPzj5M
X-Gm-Gg: ASbGncsUWznaExJiz/C25K1MN1/ul6/oGBNXDfAdyCpuKO27ptouQpw5zCBlHoW/e2d
	SIhVJ5c2ir91knab1NuIv+HUi2kttM1hYNZQj5BMLCmZB1vL9ClcK9c2aOkCc1G75uzBN85PBl3
	t0ydR1zO5KaWjkJW3BcnPrpcl/Xu9A2/KAjdT5/elauGixBg5LDvZJtJCjFgX0dPu2mHG4wEoBl
	ocT+hmCIjymKuVnLXU0GyyHMcMOXocsBirVfbWTq9fuyC/ra0Q1Gtd2WbgN2ucvjcfj661jhFN5
	vJLgbOYZoWUCJRUN03NIki6TjLWKtviB2ZDgQv0h6jVQy43IDgQ+qDSoplm/c7SoFweh9KbHyGc
	6/v0uq9hrpkNl71jyUvbWltly8B/zxpkmeO8wWztGz4pvi8pTI1Ng4bImYK5v/J/Nkxb/IIWOGl
	r1EhYLubxL+Ec5ncrHZYmz7198WUzJ+WncthYb3JGfx+GqzZnagYb6sYnYcFg387pJFGy/
X-Google-Smtp-Source: AGHT+IF7C1HGW7ILFI1kdkdZJHZJtVt42TgQfZsjaIHgdccAYg17AOIpG/uGRBNaa6KurjFl0BQrUg==
X-Received: by 2002:a17:90b:1844:b0:340:b572:3b7d with SMTP id 98e67ed59e1d1-343fa528260mr16690592a91.19.1763449621558;
        Mon, 17 Nov 2025 23:07:01 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345651183b2sm11868494a91.2.2025.11.17.23.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:07:01 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/4] net: adjust conservative values around napi
Date: Tue, 18 Nov 2025 15:06:42 +0800
Message-Id: <20251118070646.61344-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series keeps at least 96 skbs per cpu and frees 32 skbs at one
time in conclusion. More initial discussions with Eric can be seen at
the link [1].

[1]: https://lore.kernel.org/all/CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com/

---
Please note that the series is made on top of the recent series:
https://lore.kernel.org/all/20251116202717.1542829-1-edumazet@google.com/

Jason Xing (4):
  net: increase default NAPI_SKB_CACHE_SIZE to 128
  net: increase default NAPI_SKB_CACHE_BULK to 32
  net: use NAPI_SKB_CACHE_FREE to keep 32 as default to do bulk free
  net: prefetch the next skb in napi_skb_cache_get()

 net/core/skbuff.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.41.3


