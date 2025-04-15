Return-Path: <netdev+bounces-182997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AAEA8A88B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AF93A3BBC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8B2512F0;
	Tue, 15 Apr 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvlUpeIk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E691AA1E0;
	Tue, 15 Apr 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746840; cv=none; b=gCip2SbrOf+qotL3HY3civvac0gzL9gqd7n17e7JvQTg33GnoBDiXyL4ePnWl1v0j85DqR9sFCd7sMUMgyR0M6KLfF4fLBeRnLd6vjoVqebqGgTFsD/mwQ1DQni49xVsWeXztMO5ixdwINUqoDKE3PkMV3Go/GsAYOBx+Zd9f8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746840; c=relaxed/simple;
	bh=MtlRpin66LdEuCzJZkyiSshjRX+kayiWy7AB1/kjInU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JidnjbMnRIrEfuxiS2G7lp6TUZJejs68RZH7oPRzOBltfh813DaCvFmY7fNVLXUkLqM+9lF8E5bdb9cqAdl3vrHhNhaOvHlDikIwojfIfz8tfu06pYeUwJM/BDS0GUXdW4jP7C86OdisaVvHr/rEWh4UFrUs1mBf9DbOAwphqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvlUpeIk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e61da95244so10298748a12.2;
        Tue, 15 Apr 2025 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744746836; x=1745351636; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43+Pow839Bzbs0w9Jaldz/DIk2TKaVOfUwaFp1PwmgU=;
        b=FvlUpeIk7BiPLfjJFJNeIe2j7kNY8wImDIkNTHipJ9CQXi7uSrR2eFEgpuMtuwhybI
         2LS3cZwlnr6QNujOii+wSmuiToIy3HDpaVx9XqkTlqVjowCrrtzgTBjrrRzQnXnAE4ax
         mFusKk9Dwz+K2DzrAGUTI/JAahDoqFsQWUmQLfwesRAf8qVk31SKrJtMpWp6IbErLxZo
         tkKmUftZF6p3x4zwEr8cLqbmieMhDV2SF4WAtINVodmSweaFCcwzgxWASVD2rk1iKW1m
         XBIMm019PJoanDYprC9ec63h2U9pAZ/anPgQq6SjqD8mvwrZiRENzeLx83vi/W+Zw5zh
         //uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744746836; x=1745351636;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43+Pow839Bzbs0w9Jaldz/DIk2TKaVOfUwaFp1PwmgU=;
        b=psOv8Vp4l53Hj3+mJUOOCYYlheDQRKV/YeF4wqTQZSb7hwMgWFNA+xYHZu8MqO9VnI
         51jONS8qoqn2SbeK/LXozfxxINJ62avvopY5k4+xi5i+SLc8E7KK8b/onhKPkwLViUak
         ZqjG65DU7CwxFHLTQFCRdYI1OM86j5meEBePXCxhraHkimnma7VCPoF8k9w+mAEQTfnN
         brSxg2Q+vVGgWpFasEW74i4/TK57HWhU0K348kAqjJeRh37Hpj3gFbU4ss/AMoKiLmSz
         EOtKsGkmihR7EDOjs0QxUFvCImxYneGMcaHzXfVWbiWVIzGhH90gzmJi/mzVIA/MPp+F
         8IoA==
X-Forwarded-Encrypted: i=1; AJvYcCVE35HhqdbqwnC2JWhFNp0qO2vFJiGYmzmKCHOVFfaXueIAb40tTJDJFg7Q0El7M9hIFw7LUu0zajY2@vger.kernel.org
X-Gm-Message-State: AOJu0YxjErTEZkpzfUFlx69BLMi82TJPUFtjZAJn8qvUnCCCx+ELm/3O
	4erTOM0rbx9QP6eoLjCtti696hTUcrTKdcxZI1LcW+YKpvXl1F/y
X-Gm-Gg: ASbGnct+JzpS/9w18hqCX8A4HnrzqDHzUSkZrFxvSU1vFhSuuHq1hMd5kD1QYs+jatl
	keb/Y3xWKoib26JRR+49qVFgoNvyfCbfGeNA5sU2l2ticzRdcyYqV3pfVpxwqZha02CHgJe8zdr
	zuPWRrMLUjn8bCLEH6bgxpstqIh4MPRhb2Qnv1gtC5Z3++tZmYCubtg3Dt2VhkzJJkhZ7gGaG33
	v/gjJ4yLJ/+2NGO9WZgpWNbpDnIN279Y0ntqBRt41BjA+KQqDrlmSSVOmmALFPvbDbfwZQq4uYr
	Ih8XrmAYTg0WCDQn2mdHRDQu8XqCWOWtbWpb3fH8WnvWP3d6cZZx7EJw6i1Zy0dyNob3BrE+j8y
	PUAAC2EXEBhbnQmjW/ByIrNK88PB32Xk3YTCOQpEcFtLV/B5MddH5gbYP9YPz6EReY0TQtx47y/
	aIogREwUCIuI+SW898XyQmAJbnQyUrYk2w
X-Google-Smtp-Source: AGHT+IE7D9bHuwV9kxdL6z6LOzKL/va0CrzLR5H8bVmnIip+zaSUvlljIgraiXIq3Fn79YC5i2wJjg==
X-Received: by 2002:a05:6402:510a:b0:5e5:b388:2a0e with SMTP id 4fb4d7f45d1cf-5f49a176c0fmr324511a12.7.1744746836186;
        Tue, 15 Apr 2025 12:53:56 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e? (dynamic-2a02-3100-9dee-8100-1d74-fdeb-d1fd-499e.310.pool.telefonica.de. [2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f50567esm7476142a12.61.2025.04.15.12.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 12:53:55 -0700 (PDT)
Message-ID: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
Date: Tue, 15 Apr 2025 21:54:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: remove checks for unused eee-broken
 flags
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These flags have never had a user, so remove support for them.

Heiner Kallweit (2):
  dt-bindings: net: ethernet-phy: remove eee-broken flags which have
    never had a user
  net: phy: remove checks for unused eee-broken flags

 .../devicetree/bindings/net/ethernet-phy.yaml | 24 -------------------
 drivers/net/phy/phy-core.c                    |  8 -------
 2 files changed, 32 deletions(-)

-- 
2.49.0


