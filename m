Return-Path: <netdev+bounces-67543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20E843F7B
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7F51F23E4E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 12:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B5679DAE;
	Wed, 31 Jan 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="aNpZ7ZVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D28F78
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704557; cv=none; b=QaGWpPXehP1ostEnbdY6GaP49vzHnZbJf6HyRsGo4FNCaErhll6arL0n8EIVOjTU+sCHWUGUkmuciWEw46cPSbsCsLtyyVgQTPtdnPa3zZ4hT8nBIlcYFOIWlxuAWSJjm0Y4lPn8zj/8E8onjfHb+QRhOc53VKWM1ooywFNdVqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704557; c=relaxed/simple;
	bh=fbxRnYkzwDvN2tNGcLcX2Ze/C02CkXTVSfhqRUOPAr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mW4ANQ2/9kORbu8hLvlwg0mTc9X+15CqS9zTk1uAeEiSTEjOL1S2F9d7XwaKsIgiDp5XpThGOWQdh1yrmrWAZXI0c2ln1VBvzbiQXGyqbTmrR3T8DyUttb0q3cIoAe6Q3fCUvOyWz726PRu/m98kOSbOpHKGffbgYvBxNCBxGnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=aNpZ7ZVT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d043160cd1so41745461fa.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 04:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706704553; x=1707309353; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbpJcoV5Ju/jfx3qtXGsa0iIXKBX2PL23+obRoZe7RE=;
        b=aNpZ7ZVTjuEqp45MVkJz1as0bhZH4+ARHLmCRQqPMJeMLNtyJ4Fd0sv8EearkQhbxf
         r3UAnRsizjT+b9RdCUGAR1XJOKblIuFxaJbYZy5aVZ90KO1G0wyY532Z1oPEsDdlzHq2
         IkiNJBy0Ag/bc7Pm+3KtEUFP5zlmYK7nbYzam6xz2qX2EcJfuNe3FKeSkJlu4cZKpLaH
         ChONGHXlL3TbXiShTcPnD2V/tj0qqQkZj9ximnIuzJLpMRpXb0j870S5MECfJ+sbOWkm
         5VXzBZMDVj8Aq8uLuX7KKwCp7uwohWQ9kkZSpe6PFf5ggBElRXOs6LV7i0pdREomRk34
         tgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704553; x=1707309353;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbpJcoV5Ju/jfx3qtXGsa0iIXKBX2PL23+obRoZe7RE=;
        b=uKlzc+L+EYec0yiJapZ3NZaiQ1eIcaH4wXpQNMvF8L2iguHACFpQ5XtZj5LWrSqjeE
         JAV3a4T4ZuSUAJlAmFGaJvgWysO2hEqU8wqZLgH9UFqzE0Cwd5Ou2figeiGo0a0D14r0
         2C488TiRRHnTYZzyN4wXpUJtR/h8NmmxrpXBUIm69Xp0+hh9c66UALS/KzAycrKZqPNC
         qhFipl1LyXtVQ5oBhRAW+7uXhO3FV3bzK9D6nf8iS6oJgvsjjPeQaQlw5iBnnclHSnZQ
         VAKJNuk+liEsI9vJZCrApL7YWR+D7mPM+BJak6hH13kYTYqqPXSQpV8w6PoFvZunfSzr
         NqwQ==
X-Gm-Message-State: AOJu0Yx6qvW5pwTZYDxp9c9cNknZFCjHDPGiGmNqYeuXsycwU232d/SS
	uG0AZLVWUlF/OTPNWyAnN5tyxuWvEJCQwYmpL7QQGOvX4KkF+hXMjAeUWxXMkcQ=
X-Google-Smtp-Source: AGHT+IG8hieAfP8LqBvLVUbZvFgBCw7JxwAfevZbKKKcXzdDZs3ZmMq4UXCqyCYWpKJhPmSLAHc72w==
X-Received: by 2002:a2e:b6cd:0:b0:2d0:558e:3d7f with SMTP id m13-20020a2eb6cd000000b002d0558e3d7fmr1057790ljo.33.1706704552632;
        Wed, 31 Jan 2024 04:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVrYZFISrOum8i16q9557e4YlIFZHyrBD23OtKrxCCP5eRj0R7VlW66evOtQXYH51xdF6d+EerNaFw6Vyl0RVVNcZfFrmI91frJLpWRFaTYcWepQLn8pgGG5i7MYIlUUtQ0VFXFP0MN5Tj42Q9R7++zvN5aOwsjQemJUIaHTpBC8RgSePqCaA+khMDrCTZ8V+niSnjbvSEnrOmdm88NJKyykbb3kvZ9E7KUnNZg4xjH6SoMTJkFt+ls3oQSQQ==
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9bd5000000b002cdf4797fb7sm1913517ljj.125.2024.01.31.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:35:52 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: olteanv@gmail.com,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com
Subject: [PATCH net 0/2] net: bridge: switchdev: Skip MDB replays of pending events
Date: Wed, 31 Jan 2024 13:35:42 +0100
Message-Id: <20240131123544.462597-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Prevent the MDB replay logic from racing with the IGMP/MLD snooping
logic, which can otherwise cause the bridge to generate replays of
events that will also be delivered as regular events. The log message
of 2/2 has all the details.

We choose to preserve events in the deferred queue, eliding the
corresponding replay instead of the opposite. This is important
because purging the deferred event instead, would rob other listeners
of of that event entirely. I.e., regular events are "broadcast" to all
listeners, while replays are "unicast" only to the port joining or
leaving the bridge.

        br0
       /   \
  sw1p0     sw2p0
(hwdom 1) (hwdom 2)

In a setup like above, it is vital that sw1p0 learns about all group
memberships on sw2p0, since it may want to translate such memberships
to host equivalents, in order to let the bridge sofware forward them
to ports in other hardware domains.

Tobias Waldekranz (2):
  net: switchdev: Add helper to check if an object event is pending
  net: bridge: switchdev: Skip MDB replays of pending events

 include/net/switchdev.h   |  3 ++
 net/bridge/br_switchdev.c | 44 +++++++++++++++++-----------
 net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 17 deletions(-)

-- 
2.34.1


