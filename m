Return-Path: <netdev+bounces-222395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF486B540BC
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969853A86B0
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847C1D90AD;
	Fri, 12 Sep 2025 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHZIIFDH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A537F3597B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757646284; cv=none; b=NTqwd7QoFtbOw0Cqxk2zce5jhKwgbU3DLGX/pEUycu5DKFTYaKTKA8GdlG4kfVKiRmq62e89GKfllkejONZZO16IfpZyua7V0gj6Jz6sg5e5499cRwIguPLVpui3/xM/nEeGOZ1ggUnx0dAw6cvvZz3l9wQ9bYSkeOnUe3mfJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757646284; c=relaxed/simple;
	bh=nmuRw4Lnt0FC63tNFSruI/MFuiURdvkUmoJvN25GCQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ouN9cXi/a4puz27P2a3ZEFm4Qlht666J4I9f7MUlA7O7QwI+EzJ+0xQ936Ksf+oKdBkJWQntoUIrlRiiZF6uhOfg5qLWu4/oUiYdUg8fNW5M2dMa6PQQpz0wDNnax7bF7yxdUDL76rxobXSVEUIMteGNr8SCihHrqX6yoxG7q60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHZIIFDH; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-251ace3e7caso18620345ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757646282; x=1758251082; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O6NJfkyxkT3pO+7wqsuPcsmhLtRqJkDys/1ZVlsqcCg=;
        b=BHZIIFDHCyYLs0VpsKvZTT99EeyPu0aqTOuuhcQNlvKYJ053NN3XDsiB6x+TIz0oLG
         4rAhWGQNjqlZIQm5MCofs/dGOD9Zd+GixrcOfhJjn8d+w4/6R6BSf8EImtw1weinnkuv
         py9nedOO/kVcaq8FfQPStzQQBfO+77qVkZZPhjvpWyCZp9lB8FmAXa1YR1a2NR0eUnxJ
         DVbyyVI9STVbZsC0XWQc2JnL0q6qTSQIlD19pHR5LO9Q0+E1GHEFLBDEJm+w1WuZMSfe
         yDN3KNVyO+4SEf+WVEVTTCNxpD8ld+hW1ELLKHH+O+XWnFKAG7n04Z+crGjg12/d766D
         HEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757646282; x=1758251082;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O6NJfkyxkT3pO+7wqsuPcsmhLtRqJkDys/1ZVlsqcCg=;
        b=huLS/mZRHjBRyvI+sBnETR2mHTrny9Q/n773gYt5gTHBVoiMdBx+f4y2OGBUm6LGm7
         CMO8wFtckG2vKf4Hd4Ulkm/VXTBDe3VxQLws8hBIIVtXYUHkEdFPYGlpvTMgLRHztIqU
         ou9bJsjHJLRHOk2BdiO0BmTWFwjoIP7yOWTJ3pP2HxQJnMZrKGdVrvBWcOzqi8kJGqTT
         fb4z0dO/G/diGvs3bDSnvxJ4ZbixxWp9eBEx+mtWEU5YpX5crbq2aAhaQoOtlV4zA8EM
         RZsWpWoLLOJXSiYJIkiOJAkTX2KgzNTAk9YEn+hi9+20apl0Ekyy638pjh3RDh8/jzi4
         5yRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbGtdf4xrprA/KYTkyIHOCIpM/m5BPljkgpU5kiXNrGvEdzi+HAKp7Zxw5GCsOD8P5uDgxJxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Yeyjz2rxQhzByRT1ZHivSfCvkYjymtq+a2uSVN10dWwa81i0
	gnkU1CCCOvfcXx+9yOJ8j1CwxHuhlhitJ99DJNy+nWjGGb8SXcyraOYL
X-Gm-Gg: ASbGnctoKxzjsLdz7R1OeWEGnHLECwuv+NYk/c/Uh+rk4wMerT8lMEYclH4KkI6JSvM
	OAHoL24TNSKyTF4yIzIX6zul/gttkJB3qpqaeZuMH94Q2JQcSFwyP+5TRiasel4HtkvawyK8RdG
	lK2f4G1PnEmlDzoB6QqLsw1TiFpO5EMW0vuoxWV8Bmb8hJS4Nc2eeGHIqcgS4jCgeijLAEzpGSU
	wTgrOrdAD2KbaeD17fN3dZUFaMeoTRi+X0cu9TFSivbc/sND1GX7D34cBJLEWxLEC3pxd+urHX8
	YwEa0YLU6dKNwp26X4RyudeTA0EdtxTW/6ShwKkpfueTGIZ/d0NQYhPgeDPY7ceUzoAZiV949vP
	uadypeH9SzHXvu+iRGP9reE76wFcv+m9JFYANyw==
X-Google-Smtp-Source: AGHT+IG/alMKyBXWGuBUs2ZOxE6Mv8W0iR9DLxBoziRoo4LwYai+4BufuaYzJVS4tQItNB3i5PJLpQ==
X-Received: by 2002:a17:902:f546:b0:248:c96e:f46 with SMTP id d9443c01a7336-25d27d1d5f5mr13747245ad.60.1757646281732;
        Thu, 11 Sep 2025 20:04:41 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37866d35sm33839735ad.64.2025.09.11.20.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 20:04:41 -0700 (PDT)
Date: Fri, 12 Sep 2025 03:04:36 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Lukasz Majewski <lukma@denx.de>, Geliang Tang <geliang@kernel.org>
Subject: [HSR] hsr_ping test failed
Message-ID: <aMONxDXkzBZZRfE5@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, Sebastian, Yunshui,

I tried to run hsr_ping recently on x86_64 arch (build via vng --build
--config tools/testing/selftests/net/hsr/config, latest net branch,
iproute2-6.15.0) and the test always failed due to error
"Expect to send and receive 10 packets and no duplicates."

I checked the normal ping test and found it also has duplicates.
e.g.

PING 100.64.0.3 (100.64.0.3) 56(84) bytes of data.

--- 100.64.0.3 ping statistics ---
2 packets transmitted, 2 received, +3 duplicates, 0% packet loss, time 1012ms

I'm not sure if I missed some configurations or anything else. How do we make
sure there is not duplicates?

Another issue during my testing is that the test checks

        while [ ${WAIT} -gt 0 ]
        do
                grep 00:00:00:00:00:00 /sys/kernel/debug/hsr/hsr*/node_table
                if [ $? -ne 0 ]
                then
                        break
                fi
                sleep 1
                let "WAIT = WAIT - 1"
        done

While in my testing the debug log shows 00:00:00:00:00:00 for mac B address
during the whole 5 seconds.

/sys/kernel/debug/hsr/hsr1/node_table:00:11:22:00:02:01 00:00:00:00:00:00  10026a200,  100265ef5,              0,     1
/sys/kernel/debug/hsr/hsr1/node_table:00:11:22:00:02:02 00:00:00:00:00:00  100265ef5,  100269800,              0,     1
/sys/kernel/debug/hsr/hsr1/node_table:00:11:22:00:03:01 00:00:00:00:00:00  100266140,  10026a200,              0,     1
/sys/kernel/debug/hsr/hsr1/node_table:00:11:22:00:03:02 00:00:00:00:00:00  100269000,  100266140,              0,     1
/sys/kernel/debug/hsr/hsr2/node_table:00:11:22:00:01:01 00:00:00:00:00:00  100269000,  100265ef5,              0,     1
/sys/kernel/debug/hsr/hsr2/node_table:00:11:22:00:01:02 00:00:00:00:00:00  100265ef5,  100269000,              0,     1
/sys/kernel/debug/hsr/hsr2/node_table:00:11:22:00:03:02 00:00:00:00:00:00  100266140,  10026a200,              0,     1
/sys/kernel/debug/hsr/hsr2/node_table:00:11:22:00:03:01 00:00:00:00:00:00  10026a200,  100266140,              0,     1
/sys/kernel/debug/hsr/hsr3/node_table:00:11:22:00:01:02 00:00:00:00:00:00  100269000,  100265ef5,              0,     1
/sys/kernel/debug/hsr/hsr3/node_table:00:11:22:00:01:01 00:00:00:00:00:00  100265ef5,  100269000,              0,     1
/sys/kernel/debug/hsr/hsr3/node_table:00:11:22:00:02:02 00:00:00:00:00:00  100265ef5,  10026a200,              0,     1
/sys/kernel/debug/hsr/hsr3/node_table:00:11:22:00:02:01 00:00:00:00:00:00  10026a200,  100265f98,              0,     1

Thanks
Hangbin

