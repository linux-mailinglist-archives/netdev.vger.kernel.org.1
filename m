Return-Path: <netdev+bounces-135342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF699D8F2
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80647B20970
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 21:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3581CDFAF;
	Mon, 14 Oct 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b="pvvnGbbe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C715575E
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 21:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941182; cv=none; b=R5wmeubnTM5dNKt/HYqWvklXkrBzGz1WdAuaW4jGRPNwMy1BTfXFMb+cuYnZrvc5kG6hFW+gAXICv6E9+rIEIt8oXGZM92cfJ9LAiR2nXyZC8Uj1PtD7p2CbLfH7CL373zihDE9edxsxCHoPs8jt/CBZVkNAjdefDmn9pz4dwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941182; c=relaxed/simple;
	bh=jDiP3d+X8T7hs4+XRLndWZsXLmmOOdcVV3q7LaBRibU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WEt+m4ljuAsxHLI47Pnv1/tPQMvC7P9EhZLroO4HA8RFwKb33JTVNy0bOZLgnfJzZ7qtoWxhK//E6Bf8pTNWsyE2TKKdNkbUDlGZn6Ha5VpniMY4bmIVfC6rNXTmHRFKvzzDQFIVXC6OBgaUBe33ElTOY+PB0YmKf/qYfu6wuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca; spf=none smtp.mailfrom=rashleigh.ca; dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b=pvvnGbbe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rashleigh.ca
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e6f085715so798666b3a.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 14:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rashleigh-ca.20230601.gappssmtp.com; s=20230601; t=1728941180; x=1729545980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IAeOIN8mTo5jZlWlrCZMTaf1kTCisQJOtTi5yRLS41Y=;
        b=pvvnGbbeeXehE1DYOk4k3vBd0L9JN18ZF4B3NC6/N4LbECymw1OUfHT/Gq/B6+6sXL
         Vq+nOuo73kfgLlhzmWuzbxDQ52vXua5wJ1rRsO0YkxehPG4jxDkN2qDefqsrGhQ+ucAa
         EArJ4SYElOV9PKQV1oKbxZcQaKnQkiOqm46dKsbQsz8RB5UQSa2zm/GjYggSYpbZoqa7
         bUsRqcgPl2fKp/ldH1JYBXnzMpUlt6sD/NY9Qb/k1pBap2ARuHEnMLUSCh6DueJ8IpuU
         xCbu4NoHoEfHg2pgmWiWLPxtHrgvilzsYc/YUUxktBixqJAtZzJr8u8Gjh5sK+J7iFWZ
         SCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941180; x=1729545980;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAeOIN8mTo5jZlWlrCZMTaf1kTCisQJOtTi5yRLS41Y=;
        b=r9pZvOFTvJ53fi21r61cT581IuvSCv6WnLTBwmGV2Xmh79gHd75jHP94gS1EwGBhdT
         Yq+akZgvBBoh2FZ3m1N0LORKzXzsfkt+MiL8k5hVQO82YoAPuxa5epOnaxE8aR3jNxtv
         P86LyrSIL0jqF8OJfolLO4Zn7N8bjlOOV11feJjOECPoi5kfHa9FYWEEUUZsmQ9e0NS9
         6GFTaqQzRVp0kb1jzG/GrZBGRbHyhzZrvzU2Ydvl/e2QrvSS6fUsLAbNCqTS5Gnvryzm
         uwln0dVlH5Y6DsBQfnSgNW3ffBQKYAhcXTObMVUP6EdikM5Q1vXVsVWLHfKph7z7FRAU
         rkWw==
X-Gm-Message-State: AOJu0YwYDTlxhG6qRslDoUUf0scVPMYlIdypr8KsSWelsKLfBxPJmzfO
	x0DdY6qA6P1VE0/f97d8uSRK8j5zPxhr95B3tqZtDMqQh9zNHeacr7YGeYNQR7cBg3qJmNPMxan
	4FX+1Vepn7TqAt41iGqCTQqM0f92bOjmtuSFf/PVbG/C0gMwasQQ=
X-Google-Smtp-Source: AGHT+IF0yV4lVZWbsbm3ofTW259kNVKpcTgNExNkiACvdSHDUHcGQRbo7yQkeGaThCgoZ35z0oRpmTmhb9fL320BkxA=
X-Received: by 2002:a05:6a00:4b54:b0:71d:fd28:70a3 with SMTP id
 d2e1a72fcca58-71e4c1cf249mr14628245b3a.24.1728941180542; Mon, 14 Oct 2024
 14:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter Rashleigh <peter@rashleigh.ca>
Date: Mon, 14 Oct 2024 14:25:44 -0700
Message-ID: <CAOai=UuBxxfdu8HsnZi3CmWzZR=zBc_v0A624uTwfKUDRkrwiQ@mail.gmail.com>
Subject: [PATCH net] net: dsa: mv88e6xxx: Fix error when setting port policy
 on mv88e6393x
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

mv88e6393x_port_set_policy doesn't correctly shift the ptr value when
converting the policy format between the old and new styles, so the
target register ends up with the ptr being written over the data bits.

Shift the pointer to align with the format expected by
mv88e6393x_port_policy_write().

Fixes: 6584b26020fc ("net: dsa: mv88e6xxx: implement .port_set_policy
for Amethyst")
Signed-off-by: Peter Rashleigh <peter@rashleigh.ca>
---
 drivers/net/dsa/mv88e6xxx/port.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..04053fdc6489 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1713,6 +1713,7 @@ int mv88e6393x_port_set_policy(struct
mv88e6xxx_chip *chip, int port,
     ptr = shift / 8;
     shift %= 8;
     mask >>= ptr * 8;
+    ptr <<= 8;

     err = mv88e6393x_port_policy_read(chip, port, ptr, &reg);
     if (err)
-- 
2.34.1

