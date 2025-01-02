Return-Path: <netdev+bounces-154673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB259FF5E1
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 04:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46D31881D7E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AA922EE5;
	Thu,  2 Jan 2025 03:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="OBxBxkdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2591B815
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735789992; cv=none; b=OH/ipLvzJqLWooSPKynfxLFUq4Xi7YxlAdb7AOTIybuZmkHDN7XYtvPq+jnXTSHiiMow06si8iXyCNCfBYm2xlfd7JYs78jm5k1KdWrbBFsfwCUKXdi0vhPKb7f9y5DKJN6Sxnu5flnlKserqYiALVYtkymRowznQBQCe8hVDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735789992; c=relaxed/simple;
	bh=8YxMF41QwQHaeRiSrYMmTlA8z17KjPhUjO+gksK+dlU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pbPixmOjjbzGsowpE99cdVTKOndLXbzSmhJX4fJ+Q2fCDit7wcCpXV1qj7Z/GlcvcCIu649zGAdlLLp9fd/cY8O6NtLxqAazzlkmvfA4hG5Mu5ZJ7MQN6oTXMW1bX6LwS1iDeVmI5WAxHT9aIRh7Jknn2sD+rZQuSsyFlwT982w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=OBxBxkdA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21680814d42so128012525ad.2
        for <netdev@vger.kernel.org>; Wed, 01 Jan 2025 19:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1735789991; x=1736394791; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvaCHiysk/cukfyPyKRBsGPePbIYTzKM+yFnyaXVpHA=;
        b=OBxBxkdAyVXkm54oXsIZmG3ojKSOIT4CzKLY/kIQz7sdkCQbyPs20Wv5keqPnthCYb
         yNL6DRj4g2n232GWsPfL6Y1t6c0jDM9xxaLOu3RGzrsoc3ppBTkIDcRxwiOIejjhuP7H
         fzZrL38oqwxkRC6QSkJeyC/QoAMh43rfL/tfQsQg3Bai2ijAs1eOuLWA5C4s+JprO23B
         Ep+03JZ+ZQMFsB1PCqXuhaoPchPxZab815u+ABbwp83HUDRas6R7eSgtgcR89Bl8z6qh
         jkjFQNlfG+9L60rB8WD0icWaTwZAP/VArJ0onoYhRd2pAQ0tugZ8MHqkHOjp+dvZ5HUN
         ub6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735789991; x=1736394791;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvaCHiysk/cukfyPyKRBsGPePbIYTzKM+yFnyaXVpHA=;
        b=sdHWqAqjKLzLVjdM3w2s+533TeMEz6ieDnbfIy321vjQ0UifsA9AuJRPTqJ4w4L5Rf
         X+jrqoRiv2vwXWxl1Al0l33JiWaEyKTNuS5prHkQrfZwfseh9EwVZKPxM2ZRB0nwryTY
         oqWuVHFnBxv9JcFFUtsB2th5qcr1BCaYwV/hS61HJQgXibO8FTT//1GQ1coJzRsgIb7Q
         Qq9gtxI9kZZ18U0xesNd5ZlVHJiu6MFjTo1KHSK+VtxuwnxYL/byZ24/R9z19hOBhRXm
         JtKPst1tEgASQXYDNN7bluzQJFwo6SB0A19qjhJ9Tm8eIJxmCFMy+P3yigAUI50+lDuk
         cdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIvhqEywEiLhlmO4clNrFTBiWTMq+vUG0VW8DViAAHOo/ug1z34lJJtFT+DV0tof1lYy9VQ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq5y6OsIgjcJtryS49kOPcuVGLo2KDBsaYGa2AQlS2DTtNdaKi
	RV21V9pwDkwiNw3I4v3XHfJXB7OABZ0zHqtj4vwsdDiR3Op8wDLMi98/TDXF+Jo=
X-Gm-Gg: ASbGncvYQfHatFWBJqAryY7dv+cAz3UbO34fjOurVXnvZ8i/mH0dKqEVag2bII5aG6h
	+1H1d+hY9biAlTsYvBm+F8eMR2ccUhxsxf/pGZe9OMxlNbhrKeJAFWurnP162JBLabr2nwhiCK5
	PGC+HS03jyvaxNEfDHNWsIg/+NXlYuDVO+txkU6zcMbmIILS2RSIF9tLaMmDjgCdl0erOyaG7xo
	MUCxC344jU9bIlguqVTOKyhqbDNMr/gnvXOepgP3u1uex4Z8Dl1yaE7Pi+yfibmIuBNEjP7F034
	VmlEiknlq8UnH5smHNDpNykMBUag1NyWnrjnasuO
X-Google-Smtp-Source: AGHT+IFrrh50rCp6cHG8qhSvTaRfta3Aascv2hZcykC2O0A/TWJBEw1M2DipNVGd8VFMavzOXczOXw==
X-Received: by 2002:a05:6a20:7f99:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e5e0470226mr65407285637.16.1735789990624;
        Wed, 01 Jan 2025 19:53:10 -0800 (PST)
Received: from [10.54.24.59] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbbf6sm23254920b3a.111.2025.01.01.19.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2025 19:53:10 -0800 (PST)
Message-ID: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
Date: Thu, 2 Jan 2025 11:53:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 ", Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 ", \"David S. Miller\"" <davem@davemloft.net>,
 ", Eric Dumazet" <edumazet@google.com>, ", Jakub Kicinski"
 <kuba@kernel.org>, ", Paolo Abeni" <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
From: Haifeng Xu <haifeng.xu@shopee.com>
Subject: =?UTF-8?Q?=5BQuestion=5D_ixgbe=EF=BC=9AMechanism_of_RSS?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi masters,

	We use the Intel Corporation 82599ES NIC in our production environment. And it has 63 rx queues, every rx queue interrupt is processed by a single cpu.
	The RSS configuration can be seen as follow:

	RX flow hash indirection table for eno5 with 63 RX ring(s):
	0:      0     1     2     3     4     5     6     7
	8:      8     9    10    11    12    13    14    15
	16:      0     1     2     3     4     5     6     7
	24:      8     9    10    11    12    13    14    15
	32:      0     1     2     3     4     5     6     7
	40:      8     9    10    11    12    13    14    15
	48:      0     1     2     3     4     5     6     7
	56:      8     9    10    11    12    13    14    15
	64:      0     1     2     3     4     5     6     7
	72:      8     9    10    11    12    13    14    15
	80:      0     1     2     3     4     5     6     7
	88:      8     9    10    11    12    13    14    15
	96:      0     1     2     3     4     5     6     7
	104:      8     9    10    11    12    13    14    15
	112:      0     1     2     3     4     5     6     7
	120:      8     9    10    11    12    13    14    15

	The maximum number of RSS queues is 16. So I have some questions about this. Will other cpus except 0~15 receive the rx interrupts? 

	In our production environment, cpu 16~62 also receive the rx interrupts. Was our RSS misconfigured?

