Return-Path: <netdev+bounces-247924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF380D00991
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AF8930019FA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48821257E;
	Thu,  8 Jan 2026 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARRI0+mw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBF1DF736
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767837937; cv=none; b=i/WxdzPTTTHJqdnvgL/cg9cuxvnjQC/SPnUFQGS56A2eUsB4gvsRGqKvaD099V4GqXpXEK2EcA9sopDYvW4EFFINTqh0sTgf2rkVgtDLp8Qhdg/sjwrL84JoZKBZQ4rzAW0mYLfdvi1DrVX6DzxphIm1P9um6z8fuRRan12n9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767837937; c=relaxed/simple;
	bh=VtYE1J2xq0aigWHl8P/+j8X8nWiGklmYogLvj2VYJA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsuaA/sVtiycHd5CZKCFvnnBgKb7jrAVYsAGFVj1CVehODgldWvCoTUvzFvfyV+XrLlIPBWvlsIQVDMza80O8G8MoOeAA/171QaofnEnHajsmpjG2ZNPPOGmwFG5AuVA0ku7LDH4H5SMz1N3+bDPTicwraPbKZdGACMR4baYzIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARRI0+mw; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so1626632f8f.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767837934; x=1768442734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+fn/v4fdrAGDvAjCHVPfuNMKjmCh7SSKlTQtq4WIMw=;
        b=ARRI0+mwdGoxqZHxhoJNtTfhcBgUU/SoAG59sq5W/a/GaVYDNQlPKXJ4folYhhyeeJ
         pOmHR8ETiaosxtgRqhaSooFnMTGLFWCpfV5nqafSwhRUlkHs85elQPusfa7z7IuMzek5
         wlFf/pMz5Vrew+DaRQZediB9SvpH2vLIX763ajYq6FiPLDqPkfEBYlrTO/rHx6SHHOPv
         /mPZBvx1XM3sbTekwa72qKzu5oL4inapx5XdGMFjjtc+mQ+vzdMsAq1ZQmNzxSMDIKpz
         COVdXA31YB4ANPvWGQppgQbLlCpeJyyjRS6/w945fdRmafiJo9mn9pWrr/TQ8GJfrgv6
         4mEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767837934; x=1768442734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R+fn/v4fdrAGDvAjCHVPfuNMKjmCh7SSKlTQtq4WIMw=;
        b=AIznMQbFrRJqvCCH1QZSb5ytaKDhiVPpj1mrgWFrWp4LfCQZm/B60G6O1aNLpMi7VG
         tUjfano9hp81ATsbU6ZRP7IlwZZtpUaOww/1eEFZ4zXJgHKUzoO5fvrdRyhCUkDaEe5H
         yylylS2pxPTioJoVEsYKSzdqka5SSFWOhsk02ZWXXwR/uqRc7gyIFBpTO2ftjvc8rwvS
         exosmf7kVhsE2UZRlNb4CrK3Wxi0+YulXHDdIkBQ8HpG52Zn3S0/nNzei0AbbcJOU5dg
         YMwFTtF0yvQYN7JUX7Vxo2AenWMXoHBA7nCnNFe4BTgoPfv8IJjvl4bxJbzMCgZXs3ga
         WDsg==
X-Forwarded-Encrypted: i=1; AJvYcCVziwlt1k7pyUctc3q2VJEk3MXMp5GDija/UMl4g6ind1KROMvu45yQzDOsoocHywZndWKewfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCm+EX7CMT2ovvBXFKc6sBZSeY0hd9zYnTYoVeWfsKxMvxptXm
	qJoCNKYLPZrqWMPfRhLX2vm12QDu7lxYmgVJBdMBv5t/LnPLtVEIjyE8
X-Gm-Gg: AY/fxX6dHQWaq3lwt/3hXtfcTKLjRCrJtgyGU412J5U4DonhV3MLh56Fq8/Wln/oHo0
	k8Ro6NCmJo6OVJsW5ua+tU4Onqx/eC682tvf8kpi0eoufBO6/ogfMwlxahB6VJeXWC2rt+WOjSs
	ZzIfa3/v+60TxNxsdAGpZ4CVf4Arq9qI1m2ei4vPMjDHF6vOjGhzV40t2fM01cr7rlem/lHWvAC
	ynNrA0w+qcEIQhc/xbrmfcz6/7vUp8gZOzqEqdx0gI6tJDrmBhQ3j5ABliXF5kvbEItg1yH30A9
	hNKE+4+obZaeBlcfJNVyIAJMfdxsWYMvpN+tg1V36Eo6jT/zKaj+pLsMTgoZy4Co7QusztdtgAy
	0IkLnFUMKfu8TEKFbbGfobviTdO5ZKKU1TZw6tFSGsm+LSDtTRL2skxyqhH0Uby/o7T/XQniJgv
	FXGSAlHA0iwg==
X-Google-Smtp-Source: AGHT+IGhxc14Gqk3b1nYtLfLfslH1TeP8YceFFCbzHeZeJHiKhj1cMe1/d5Wre0TXCEj0LJuKLVzOA==
X-Received: by 2002:a05:6000:2908:b0:431:a38:c2f7 with SMTP id ffacd0b85a97d-432c37a7d86mr5239803f8f.59.1767837933817;
        Wed, 07 Jan 2026 18:05:33 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm13411048f8f.39.2026.01.07.18.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:05:33 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [RFC PATCH 0/1] prevent premature device unregister via
Date: Thu,  8 Jan 2026 04:05:17 +0200
Message-ID: <20260108020518.27086-1-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
References: <63fddbfb.60e7.19b975c40ea.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially I was unable to hit or reproduce the issue with hwsim since it
unregister the WWAN device ops as a last step effectively holding the
WWAN device when all the regular WWAN ports are already removed. Thanks
to the detiled report of Daniele and the fix proposed by Loic, it became
obvious what a releasing sequence leads to the crash.

With WWAN device ops unregistration done first in hwsim, I was able to
easily reproduce the WWAN device premature unregister, and develop
another fix avoiding a dummy port allocation and relying on a reference
counting. See details in the RFC patch.

Loic, what do you think about this way of the users tracking?

Slark, if you would like to go with the proposed patch, just remove the
patch #7 from the series and insert the proposed patch between between
#1 and #2. Of if you prefer, I can reassemble the whole series and send
it as RFC v5.

CC: Slark Xiao <slark_xiao@163.com>
CC: Daniele Palmas <dnlplm@gmail.com>

-- 
2.52.0

