Return-Path: <netdev+bounces-81223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E6886AB5
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 11:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A86C1C2181F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF073CF79;
	Fri, 22 Mar 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rOCc8LsD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5AC10A1A
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104626; cv=none; b=d88CLQJlHfxtdjMA4BjQSNZTr2HEVWxXD29dDql9/Ih7HusUPriPk5Lr8lQmwy0dXYDABOh3tOjP4Bp9vrLRJyntvnXVfB0Y1q4wdNnug/KGX4/mk5/TmlfPDu1WGhICLUNIw48qoNg4l7emxSPrPbLG6rTw59W9u38cEa102Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104626; c=relaxed/simple;
	bh=V0KUWw2b39Av29SSkW28FmAhp9W2EnpLXnrzuwOuShY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJmi++8/291lmJCypTZjKhwMxJUjnDAcQcSa3s6ScgjFYB/T8QWmoaXJx1k2WwaxlQ2aGlNzwWYiADlF/qt8ImthlgiWDg2ZFK4nGL+kQCa9l0CHtxdvtfBBfobdmux9jTS2QeZcxvftZTcuADCREBLyd2Lcokx6tsM73vUzgn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rOCc8LsD; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 48D7E3FB74
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711104616;
	bh=V0KUWw2b39Av29SSkW28FmAhp9W2EnpLXnrzuwOuShY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Reply-To:MIME-Version:Content-Type;
	b=rOCc8LsDAKFEBXJPpuBfedhE85qfn/nsMBum/VSy2ZZam0SEIvJpa9kqQzVYmFFzR
	 xHIhNqobPyQP7fDxEEwN7BwvfOpPS9+uAgCN33JFhLsG+B3k3B2+UgjREduLiJ8EvJ
	 3lklo0qGMhIhd/KqgIYn99IZ/cWqD5pG6iR8U1ifv4VBiycu2RzAMd9uu4wBjn/Hwu
	 8uSCPiAZ1LK025UtGWntS4cIPEW+LBgU8DEL/1SrqU4cA9U5z3pHbSr7UMFVxOeTy4
	 OfZWl5EfvvObR/nlULBP05wJzr0gkyQlGS5wC1zDz7offObMRJ5AFw5fnRhrZfcJ7j
	 /tAaldBdhCVGA==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e08039b8e7so8338035ad.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 03:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104615; x=1711709415;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0KUWw2b39Av29SSkW28FmAhp9W2EnpLXnrzuwOuShY=;
        b=APplG9zgrKUIGue9tSaixK9bIWeXjMqaPmN8WlHmQya+9kfhyk05j5tW0TjvVM7b9J
         FdMVv0HyaX39bUtD4UTz0h+6EqmZj4k1jXvppHinTh6IJsiriQGGXa0b4kbLzW9ilPxP
         7A+hAdxGmvVClN58zoi0KBJNrjdPCltJ4MvCHQI6gpK85jXXpwrEDfqlsWq8IucWAGmb
         /5S/9l3x6hz0e67tylvEz28mGIbdiIOXajS8IplQDMbVFpsAp9aoWa51iXDawxWBkyPN
         ZKt5KDh0V7kXZcdZ5rKi6dpJqLa2XDJJF3qiCQvlLT2ja4y93yStPet0RMYDXblVqj6J
         rMNg==
X-Forwarded-Encrypted: i=1; AJvYcCVwksJa01eKVuvM6537cKibiz/59bxs3gSCRqRJwVsXX2O2iArAH5ANPvA16GN1Aq728dC9qreYMmtHLHfNvT357C/Y+Rj7
X-Gm-Message-State: AOJu0YyeB2c4Cc8CA1Qc1b+ktjqJJn59fmI5qBeTmQx/tbpz/TrwkROP
	SqzgYxGIA2xUv2vwG8snaPcSqfuR77ajN0h8y4A23AWHknlvCp93ETvP70NN8MnWNFrEh3uFjf5
	3AE3H6qWpdZ9rQ9ohlZ53MfjZ4fF+E7j1Uxo1wYAzqs3Uu8ejygd5oC2nsLoMu5Oogaf9kQ==
X-Received: by 2002:a17:902:f54f:b0:1e0:7bb6:3a70 with SMTP id h15-20020a170902f54f00b001e07bb63a70mr2565919plf.20.1711104614968;
        Fri, 22 Mar 2024 03:50:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsuk8XjSSypqRamBZAHZAqI50gJRt3UTv10yYrZrgcNtveMFe2cLS/SEipSDi+jh2oDjFoeg==
X-Received: by 2002:a17:902:f54f:b0:1e0:7bb6:3a70 with SMTP id h15-20020a170902f54f00b001e07bb63a70mr2565894plf.20.1711104614667;
        Fri, 22 Mar 2024 03:50:14 -0700 (PDT)
Received: from localhost (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
        by smtp.gmail.com with UTF8SMTPSA id p23-20020a1709027ed700b001dd8cfd9933sm1613732plb.151.2024.03.22.03.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 03:50:14 -0700 (PDT)
From: Atlas Yu <atlas.yu@canonical.com>
To: hkallweit1@gmail.com
Cc: atlas.yu@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	hau@realtek.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	pabeni@redhat.com
Subject: Re: Heiner Kallweit
Date: Fri, 22 Mar 2024 18:49:56 +0800
Message-Id: <20240322104955.60990-1-atlas.yu@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <0dee563a-08ea-4e50-b285-5d0527458057@gmail.com>
References: <0dee563a-08ea-4e50-b285-5d0527458057@gmail.com>
Reply-To: Heiner Kallweit <hkallweit1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Mar 22, 2024 at 6:16 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:

> No, this only checks whether DASH is enabled.
> I don't think is redundant, because the original change explicitly mentions that
> DASH fw may impact behavior even if DASH is disabled.

I see, thanks for the clarification.

> I understand that on your test system DASH is disabled. But does your system have
> a DASH fw or not?

I am not familiar with DASH, my system's DASH type is "RTL_DASH_EP", and I have no
idea if it has a DASH firmware or not. I am glad to check it if you tell me how.
My patched r8169 driver and r8168 driver both work well on my system.

> My assumption is that the poll loop is relevant on systems with DASH fw, even if
> DASH is disabled.

I know your concern, but in my case it is wasting 300ms on driver startup. Maybe
we can find a way to avoid this together.

