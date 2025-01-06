Return-Path: <netdev+bounces-155472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0052CA026B7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826DC3A272E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA431DCB24;
	Mon,  6 Jan 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjBSTwFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53191DB34C
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170600; cv=none; b=llaX76dEzkFF4CmZkrioyYtOfHoJJ3BA7n5agfe1TIebqq/I7TWU1aTVTbnhrS0ol5oyMXMScPaaTmO1UZ5jXvQn4D0ckf27NZXcNUxm9yqvVLqD+gfwlTMvWuaIV2KR3heRS3TyZWgEYUyd0lKbJbWYg0oJUdZyHM4Rs8E4HHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170600; c=relaxed/simple;
	bh=advdqmRZ6khhWIjgFq2Y+inf+HLyEu+c2flfTBYBeB8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=sSBhPXyjy+SKL1tzAlkLJnPlu3CRMgiYsmGB+WvWoz55bmczp52WSfp8OXyYcTAybBB+jOG3a5Z8KUKfHMVSVPzhlVgrytlAhN1+5FcIIi+MMLxnlVVvu2ZShMCHbfALfB9p9nrDribaBBhrcZYwVjqyD90ZvLx+IancfQ45mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjBSTwFF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so9161142a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736170597; x=1736775397; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=advdqmRZ6khhWIjgFq2Y+inf+HLyEu+c2flfTBYBeB8=;
        b=CjBSTwFFxPj36Q+0UMyEYe9KhtQ+OGtFenoLjZfRFykhnMTaavwK3yp4HMahPzSpvL
         kJUZZiFqQTCfKQN6uB9eaDE6Sjb7iyxXU9GiSdB822aNJt3/WeWfDNpFCoFQy8NQvgL+
         xnsYEWcJfyNkhqLmbYUmMrwKFO9wr7o8ai0kOXsD0CIJzM4XdjXCt7V8GGAMH71l37ER
         yRkQoXWBDqKCKU7bODDBcKyMovMMTPsXarpIvYwIDB4hWdRIdKEX5C773ECTQAUysoDx
         EmD29r1JrBzx4J25NaraXvaJZZ7iPVuEzgnyP6hy5IKw7mgWVg05EU7LOwXBJ6aCZFwq
         Ztpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170597; x=1736775397;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=advdqmRZ6khhWIjgFq2Y+inf+HLyEu+c2flfTBYBeB8=;
        b=rgdjoDxFOE7onMhaUCFuAZJTj/cDEsQuymJrBUy7IYJPpugBN4DZxdoM1mJkdVp4cI
         0snbbbHiXSZc19auj7kQT2lf0pBAkMMEXUAT7r0ppcL4IjdTX+uW2qMIIl0rsX7QopTa
         /UjHlUAc20LR0UZFZea8WG3hy3X9VcT15b3ucByFD2VBgaNJY6W19h/Jh+gcJ+4GP7JN
         4rbRRLtioghglLBEa11QY2xfl3zWOTfehiNRRw6jW+SD17snI4SWTwSG92VydOsVJCcU
         CyrbjPBo+l2ASyWXGFfYu2aS77Ypa9ByhQQGX/zlLyzEcsonoqqtAEHECwKgEYwuVjbG
         cmCw==
X-Gm-Message-State: AOJu0Ywo7f5ObB1Gwgzh8e+CXwVqSwgk02sNuzR502E0BC4FYttD38y0
	tL4IshSwU0g4bJGTHpYTkDr1xdJLBeslvo5ow3YlwlajhyNBN3XtUl2CyA==
X-Gm-Gg: ASbGncsGlp/OYlmBvqSrD3bRS5CpLXt/wZ7uxn4vqAGxg/sC5G+iCzk0lMT20Q3zDco
	6XJp28SpDXmTZR4CJj++Xjod5pBWBIu5OSqM7wLpF/qUovItshVEMBZo0bwz9YKhuHoFZd4SVQU
	i/mG40kt5nWvxkqOfYlBO/h5u0FRfOsUFD6HZoIuXBg1umKOjTuUIN2gXeSdGj/e2iMdYVtNXhv
	/7tWMHaus7qY27wsAq6Sd8zyZPWNeOnRnvUASVb4M87TxIOdirA3nFjLjInj66xWeJkJlbi3nUm
	rYO930dVJEhEJgcO3jJ5zqAoUiLRfmfieinm0QeAAc6KaaMD55QcP4v1xo30+v1eAuq2OGO8Jdr
	Y71brmUc2YyAUXDG7Lbg32gpdlp9H+m+PrZEnnjuR
X-Google-Smtp-Source: AGHT+IHrypMbm0NOI379DDFSuAZ19UcVxbnJ0jXPcqHa104r1JdkGueLpMa0ld04CiIA4zrEj3ToYQ==
X-Received: by 2002:a05:6402:4405:b0:5d8:16ea:cfb4 with SMTP id 4fb4d7f45d1cf-5d81dd7d02cmr55486160a12.8.1736170596953;
        Mon, 06 Jan 2025 05:36:36 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a5a8sm22981874a12.13.2025.01.06.05.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:36:35 -0800 (PST)
Message-ID: <965a1d69-d1fb-4433-b312-086ffd2a4c12@gmail.com>
Date: Mon, 6 Jan 2025 14:36:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, imx@lists.linux.dev
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: EEE unsupported on enetc
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In enetc_phylink_connect() we have the following:

/* disable EEE autoneg, until ENETC driver supports it */
memset(&edata, 0, sizeof(struct ethtool_keee));
phylink_ethtool_set_eee(priv->phylink, &edata);

Is it a hw constraint (if yes, on all IP versions?) that EEE isn't supported,
or is just some driver code for lpi timer handling missing?
Any plans to fix EEE in this driver?


