Return-Path: <netdev+bounces-222678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F2B556BC
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1345C0153
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFB4279351;
	Fri, 12 Sep 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzMR8ri0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E435975
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703891; cv=none; b=TlCiPL+kgfYad0cssRFaL4x4tXQjZsDdsB6jcmmg0c5lu5+cj0z/LEX8aK4p5pbBm+m2cGOSEYu1TrVk8+vHMLgBtYHNXUv/X0SEjVkLmekZxZtFcLCXy2e3UDDPW+NQh+OX4j6m45IyXLgYqKNkQNNLa715yfZftHgSdX9LG5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703891; c=relaxed/simple;
	bh=0FCzrBzM2JhKTYjasOL0AsaeyNUIkT7KnauKlEfNf00=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WBqlAHE0WADKlzbm12qpnWUSwpmgoSLSFcp+Cs3xpYFlLaSsn8U4/JC2fa+1QEqGCpQwnXj3YaPfkxJeqeXIkXavFnbKBP4KPjVYnjxfjJIDMLXdFo1sLZ7Y749TWtQqayCgGvIDO3Lr4QwGUK5+YD8OeIMf8Xw3hqU1ULdczX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzMR8ri0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3dce6eed889so2039473f8f.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703888; x=1758308688; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt0rIHAGmOaE6aN/nc1KuTO7trtSCVW6AWp35b7Tb+8=;
        b=lzMR8ri0FV0u1howMB4YB+UuKzxW1TOxDXxYogO/qWePMOuPr9jgYxA6asuE+cmXfw
         6O5NkE9WaYZ0XJMok6pGMuscDRvz1GVzkJBWfVJNDfFER+i+k4Z7h5jYhZzooDbk+RdG
         NVFcCpI2MQ8SytfBwNnG8rJwekkjAkxX1U1tdvlvpII8YMZK6liXEgg6Yf6CvPCEt9uS
         AaoVUjWgd2/Lx7c4gQeqX+fqQF7LHDMibSSEgA03DnmVGIdeDRi1Kj+dVTQhXFDOTr9u
         np6ZPMsOvBXXtJmbD7Iq9Yef0vtbs5YRxNlF5/WarL1yNLseaZNh1tz9ryYFn4awwu2G
         q+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703888; x=1758308688;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt0rIHAGmOaE6aN/nc1KuTO7trtSCVW6AWp35b7Tb+8=;
        b=HZhuT/Q3iLH/U79YoyDYZfgq9d4Sv74Ts7Nrt9JokbQIksJKidDUOpvvjspIHz+yL5
         zZuMCPsnT1PqGJkG9TzGHiPgROwHcj/ufJAgyQMFpbjP95/AMjztJ87Nk9Tu1uzANlAX
         h9jKBMaagV3oewP92JMGDloD1zDWH6UkRrh+RzAwM+7Cu9a8b3NbsaRI7+lDS1ppUw56
         GCDsQt09d4c9NOk0JI6+Kol0gTH3pzt4qWvP9wHt9EoEawAdIKEo4flxcbmci/VC1VWa
         i6MVXj2APhzjIm5C91aMKyQb8gnThqWgijGvOs2RZMRvBgu3o1X0VM7nyit0yakE5Mla
         EbsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxAe9QoTfDJfAfLeu0OL1dtcAYa/E7xpJgn2uN0leENuMcTGnBanrPWPSqHV7AxFACdE4Jhdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkQmzaKLre804XHVaapXjZ6hfR9blXDS9eMg2u70tvKd8P0ub
	xR8mPff0LGE/uNB3sy9d2Kuk0ncHSmLwDtIaXfGWdOf7UuAQHUaXsn5MSuhFDpdr
X-Gm-Gg: ASbGnctqUOggXy1ImWjTj1Ou+gF8mtkcEIPXPYdubEI+dVJdeUZeogjHwzWO66Snlp9
	O8p0yuIeNnBz/RkcvKm7kknMfcj9oDQL4+0P4usQmKAmxo8HQaeTc+uNgTsUfW/FtSVqqBWJkvl
	3VKGx4T6eJK/8asMLTh8nxMbwAxKoO8SaPCM9vtlU5og9JA8NScaiSsvc5361x0W0ZTHIANZz0/
	lhggDg8/ZIIfVHYrk/Q+3gPBhdkSqo2lIl8OB9HURmFg9Nz4ilzMKIfOWJvYCad+UzWQmxSw/6h
	XcVw4/zvfd4f+DOMSysHXhEVd3HyvV9S8xhXAxN8+9s6zknmdgt3qk91lpbZv6J1EVJdeVK2Dxp
	KGD87fAyCJQvdJjCOia++w3UdYpYwdiVuUN/ng1f6fKQ23s7a0dV+CHjSYwmBjb7qyFP66VGooA
	VL5f2Zx9JUMKUgdQTMQwo2rSnFM1bXHKQ6ewq9oXkoIUYzI1R3OnTIldMxE3Y=
X-Google-Smtp-Source: AGHT+IGLv064gvEK6AsXFFocJL45NzYaleqRgIietoO8HjDyLowUg7O8TsIgjkH7vReL/L4nFlRRTw==
X-Received: by 2002:a05:6000:290a:b0:3cd:7200:e025 with SMTP id ffacd0b85a97d-3e765780a29mr4312164f8f.5.1757703887387;
        Fri, 12 Sep 2025 12:04:47 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f09:8900:81f2:fb63:ffd:3c7d? (p200300ea8f09890081f2fb630ffd3c7d.dip0.t-ipconnect.de. [2003:ea:8f09:8900:81f2:fb63:ffd:3c7d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f24be2aafsm11841175e9.2.2025.09.12.12.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 12:04:46 -0700 (PDT)
Message-ID: <b36f459f-958a-455e-9687-33da56e8b3b6@gmail.com>
Date: Fri, 12 Sep 2025 21:05:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v3 0/2] net: phy: print warning if usage of
 deprecated array-style fixed-link binding is detected
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs, but still there's a number of users. Print a warning when
usage of the deprecated binding is detected.

v2:
- use dedicated printk specifiers
v3:
- add missing newline

Heiner Kallweit (2):
  of: mdio: warn if deprecated fixed-link binding is used
  net: phylink: warn if deprecated array-style fixed-link binding is
    used

 drivers/net/mdio/of_mdio.c | 2 ++
 drivers/net/phy/phylink.c  | 3 +++
 2 files changed, 5 insertions(+)

-- 
2.51.0


