Return-Path: <netdev+bounces-77055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0886FFDF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBFBB24329
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9433C39AE4;
	Mon,  4 Mar 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="A2HjNnOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D139852
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550576; cv=none; b=jyoyW1/y8E/cHq894hwsPkJepP0wP3O+JipbVH16m20MaM/jiymZjSJBN2C+pydaYmRo8ZzfX4H4THEkvgSsYAna4UPPikw0tXorKGeQ+aDnH/lhfUu2dWl+vU9H0b7AfDHGHhXO+9Khv0Vtl7ZFuz33J2/KRxpznIov7jvZnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550576; c=relaxed/simple;
	bh=lXzdrdhwZ5b2tIn/5LyFAdEolZJTtG1XdtTq3siwjA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LSRqt8uoBOK3hRzlgckEuLe79fHhBZ4JjHeHWmgGzDS7ppqEjhfzF4Z3nt7FENNyNjj46KGptP9VOE3ehmb+N0AQYYCwWwSNqOw2RP2bRt0gNpDFNUNydHJw4UYwkP6xoQOrqwaaV/740uH4cNk/wqjIJx3ys+TTcb6jJhKnr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=A2HjNnOJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so5706123a12.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709550571; x=1710155371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fnvdle85bFN9s4tk+YWOcM02aqwKrMEFnGRHcj6TJUk=;
        b=A2HjNnOJ8UOj9UDhL2AUaveCmPH52vAqUSO7PMa5W3bcgv8UJkAuwVusX2FhUoWpEm
         Fefzoe+QpLxP6l40vb3KSoNlOuH9g7QqgHCHeieD/viIVkM0Yr3oMYFoT+2grnRLRWT9
         z1hLe0AjRGL337DanMFr/d6WS7uxqG2M9g2toBna20T6RQL/iIXB55NwR403K5lOeyU8
         rXJbfrAybyfI3tHH9HsK89/woAxCrPu5oM4wXlFISOxBYxD9ZlBBdmfMjp7YYPRnZZM0
         4hdS7PsvRrUA7hlokptJuUvmuBrnCEs1Zjqb69R2XQ4wsaVmU2K0r6MLlNoOO/mPaDOt
         gugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550571; x=1710155371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fnvdle85bFN9s4tk+YWOcM02aqwKrMEFnGRHcj6TJUk=;
        b=e0hSJ0l941fZ/P5Bi5Cm+4zRRCtlOb5PR2HP5s1lurQ5kxC2UuWP4Y6tX5tzHcT8LH
         +3rzItKt3JNsUT34sGWFwfJ1zP4t1QeqzVOxzdVxcEa7QncfPQn/75aeDNohMbJxUfav
         +3eUshn0c5q6TNNP2tHKOMCv812tef1drF+xFx9OOxnr8C4Ll+zpDNnB+nhcrxvYYi36
         EGyzTgVyI/WInrU8zyK5C1G7XHmqxGgqtX+4OphoA83utxGZ5eLmUDwO9a49HCmWwrUA
         aBtOglbfpKM7J2BPilPICnpy9brZ+TUMSeVxcz6SIRp9703VBi/AiGCegcBcdaswijuo
         kfNg==
X-Forwarded-Encrypted: i=1; AJvYcCU6PT2gsZZK88g5W4BvSOsc740P5Xg/FUuj6UnPHIhpwCBlTqd3kB7vqdrey/qwwgYPQp0j95VJVshq9J5ANhqwo03bGxrd
X-Gm-Message-State: AOJu0Yy/2POXZLS2/fCeoSJXUWAYsenMfv1Rdjw8kU6arS00yDX9tIXz
	A9mokcfQ/RLxsr371cz6+tZnhmSyOtq9+Cz61sMcQpr8LDy4sCzYAm4VsuPJD8o=
X-Google-Smtp-Source: AGHT+IFAo9TwFaILny0b2KqmEaX7ntbt2e1pdgT9fQcuYhViFWqYw+MMhi4Wq6uqlHrlQXBtif4wOw==
X-Received: by 2002:a17:906:b78c:b0:a44:44e0:868f with SMTP id dt12-20020a170906b78c00b00a4444e0868fmr5899780ejb.11.1709550571560;
        Mon, 04 Mar 2024 03:09:31 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id v23-20020a170906565700b00a455ff77e7bsm688420ejr.88.2024.03.04.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:09:31 -0800 (PST)
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
Subject: [net-next,v3 0/6] ravb: Align Rx descriptor setup and maintenance
Date: Mon,  4 Mar 2024 12:08:52 +0100
Message-ID: <20240304110858.117100-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
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
were not desired. This split has led to RZ/G2L gaining support for
split descriptors in the Rx path while R-Car still lacks this.

This series is the first step in trying to merge the R-Car and RZ/G2L Rx
paths so features and bugs corrected in one will benefit the other.

The first patch in the series clarifies that the driver now supports
either normal or extended descriptors, not both at the same time by
grouping them in a union. This is the foundation that later patches will
build on the aligning the two Rx paths.

Patches 2-5 deals with correcting small issues in the Rx frame and
descriptor sizes that either were incorrect at the time they were added
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
2.44.0


