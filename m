Return-Path: <netdev+bounces-163598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A6A2AE2E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4756E16AF14
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20D31624ED;
	Thu,  6 Feb 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="WnVg8bfa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD2523537A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738860701; cv=none; b=bhxwUNRRPUo1g5nbX5p9I+AybxSviJl3PGxlVrdkBYUfDmSP4nWYI2wXLrMp6kH5QYG106RT3u2XPteb4TUxvin7P984tlIDmiuIJqL7fbFHlk9cO0DFKMazEMU3C85ch14g0xB5yuKPYS9Xs56TXxEuifRJVWuD1vCaDMqE7ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738860701; c=relaxed/simple;
	bh=je+b3dApMtgpATeUyo8VbqtkaFFQRGWvnPPmjdIVGmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rPQwOfQIH/9ICWZ8ld6oVG5ASRfyk89R+vVVnTuKnPzuLVW+E6V8uj3TGfCKvCYLtiMMq6MTxDtB5tlXKJvw8eZcEySdV+8wROtvBeekZGzq7C28jA7Q5MBxoFlWdV6mrkUEoJKBAPQvpZFvwGKRmVlL9eGZrZwlzfccPraqpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=WnVg8bfa; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-aa676e4f36cso16842366b.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 08:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1738860698; x=1739465498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z190f3NvveskZjGzZjm+ALRaVVeYlsA7+3DWflu6r8=;
        b=WnVg8bfattIRx3Wwu1msW3WSgvldvGF3BlT1Wf5FLlKrkCL/iubnVJ8knvMg1YEQoQ
         jFMc3CAzK/2j1dfOXcGBRAHweIeCQx7AP89kXnaE9lqbvaCWzNyuJNEU1DmvpmSeak0i
         fJrvJSE3v7UQ7ZMeJ9lyIttsnLY8vgHN9o7Fq8kZ/KwGiJUj8e1riyAUf2Tx5r+kwWus
         8HTb4Ns3+leQi7Bq/vNhek4r9+hCaBhY2PgCPBqEQApqs5HXB6XRnV1XKuFiITfUqqJR
         qYKaG4fCy8HT/Y6/bWJH6VRNFqjNqjbZf1RpW8pnFBXlve3vUuWF1FbDvS4/+EVaWq2n
         SkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738860698; x=1739465498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z190f3NvveskZjGzZjm+ALRaVVeYlsA7+3DWflu6r8=;
        b=Aj9NluQJV1Ee+aa6ZHJ48o52yoAS6+svQyGK4cdQVqids0gRM4vqM8eH7IaRKqfNEQ
         Qzic79yIOvlT+n/PceOI68S05hyUn9sq8GcAhs5XpUGZ9/kiTuB8oguPU7h5g813EmcU
         LTVdaxL6uHcdZT8zKVpovwG97UNrRwZ2uTNhWg0L4IZ51TyGq/H8RSwjVvnhpFqaKAQl
         4wgqvCkWY/leo3/7gq12MsbnueV+1c4LZ+AyQjJX3yVSw8bC82SPGqZzHEf9JzUs/TB7
         Jqshl7DFKXz0ZV+zQQ5L6WKPYNCoZIaDhfid5yJnjmkm5FnWHffhSPiOxj/XqobvXpaO
         mY/g==
X-Gm-Message-State: AOJu0Yws2S7jSePTE/CCQEw2oNWUz+o1pnJR8RgUzHRix647mj/ZEsjE
	I7iPknTeYalF1aEuJtlJIzNYWmM4eNo+VgOfxDZwYJM/RlJd5bSR0sWIVCNP9tCAj9h5A06K2+w
	sKRpoa6ztQCOocjwDaldNyiju16CLIhVu
X-Gm-Gg: ASbGncvcubYT8iJlrsyEP/ivZSjKnLUG99Q67B4Qinvip3IxHQ7XY9ECEYJ3nmKsNaF
	6LGwRpI+V/Le5B3lZD2gmoEDtD8fO4Eh11qR+p+gGq9pAi4UyVZy/+PZsbU/kk2H7dkEEy0V2mx
	FuyMSLOnYM6X5d08NQZfPQ5x+jFgnhAinHSjZd28vEYGtaYMyPdJxisvGvakwtKQkJpZX45GalS
	hYfj671P/jwyAfsaTtXPmHAuTepwF3sN5U4RLw7GmXm/NVxzPwgBoD8A/6D72dqh3nf32EqWdYh
	gJvPKawz9NSQQJE+tXOssbrK2JDKVCjonvvFKjlnaZaGtC35wR0eAbJWS4WP
X-Google-Smtp-Source: AGHT+IHTbG877xoqirnDEaQjVSdMzFGzJ9/Qp6YHP7dM+eG5Viy1TVzvEWm38EATk1QGodlIINRyP/OHF1Dr
X-Received: by 2002:a17:907:3fa4:b0:ab6:b8e0:4f25 with SMTP id a640c23a62f3a-ab75e2450d5mr315637066b.4.1738860698066;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-ab772f3093fsm4975066b.29.2025.02.06.08.51.37;
        Thu, 06 Feb 2025 08:51:38 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id CA0111CD31;
	Thu,  6 Feb 2025 17:51:37 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tg56H-00CA02-Ia; Thu, 06 Feb 2025 17:51:37 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH net 0/2] net: notify users when an iface cannot change its netns
Date: Thu,  6 Feb 2025 17:50:25 +0100
Message-ID: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a way to see if an interface cannot be moved to another netns.
I target this series to 'net' because this was possible until commit
05c1280a2bcf ("netdev_features: convert NETIF_F_NETNS_LOCAL to dev->netns_local").

 include/uapi/linux/if_link.h | 1 +
 net/core/rtnetlink.c         | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

Comments are welcome.

Regards,
Nicolas

