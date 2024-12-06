Return-Path: <netdev+bounces-149661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5569E6B03
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C422869A6
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8971E130F;
	Fri,  6 Dec 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QNTB9AJc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09441192D89
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478503; cv=none; b=AWT5bGiL6EIWoGxGdBzjDsgu/BeSiTF0Mz+e7XkqWt+EPNaV7sPD6fQ9KoxHjmzrVgLAnMvELvQEVTQ67V1vber92ozXF5GhbVVz2a4aeA34/ORCUAbxQx90sDQF89cIPcuxJLi0wPmjUP7W9Z380hMa6+Ae9OxngkXP/823DiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478503; c=relaxed/simple;
	bh=brgGX1BuWe3lqaf45JUJIczDTf7KDAUrYh5IdUvWP+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ql8zsFn6KBOVieNt3RUaBhSxqJAOAfDbxs/4h2MzYZxYO8zO5UG3YR3hBfSvQW8Maj6wzqdmtHeDrW4da02sRk9+W+HJKAhwqWLmmrx/WW0x8j1QPkbAPY6vn3E8glur3RejydAmSKymceiLpxC/fluIGRgLfQUoeDN+In9kw2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QNTB9AJc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so3466522a12.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478500; x=1734083300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Obt8KdMKwLDDpGg61ROoQFb35qCdC/z2o3ucvA6vnEo=;
        b=QNTB9AJctyrwqxNLCknPvF8Q62fURMViKXv/CrbyLkrfkooMGQLpuen+W4EKf04LcZ
         3sr42Mz6su3pNpsu0alyHvJjFm8j5TdJFQqKCOPu+ySz/ytHG6Xbyu2eAAmF12b2xJr8
         W9ZEKUMp86d4FFs8pnr1+YCR1lY+HVC7Xeh9CntiyFYbiFtbWYuUD/Sc4CX3duVgXk2E
         5Av5+B9rknqcQtKKmecuby1hXkI34PvihbmJhUSc9JbwvOtPoHuAAOWjPJ6Vnf4F2nJf
         2YAs8Xwu6bmBdkn1x7mthB+MeS0VWWMTiOY9iFeqsBVHFeBMJmoUgAcVO/HZyql0z3q5
         hS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478500; x=1734083300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Obt8KdMKwLDDpGg61ROoQFb35qCdC/z2o3ucvA6vnEo=;
        b=jRt9SfIbgpWvou/911l5evq+Ok7yWqHLs3MciG+rXaX8g3yrJdwM7LxqJdo0YBzuKV
         2oHbD185WspxXh4W96U6opsD05ptHiKI52LEfyjIGsK/qpUOQz3/LLfObWt7ve6s9baA
         o2R9Gi2mPQo85kMmY42UK+0+A2ieO0XoXA6h3xIrSSAztCdAaV+Pw/2Ddh867pQNC+75
         l4Vlc1z5siCaSJIVmQmWizDndBxic99t3eywnWeN9WhVmmCOMh3fVPZ8aHHo2uzNEyQw
         pKnBq3aV6S6nE5Q+lcIIYng/jwLgydALYC2DVlmPX7u/tHNfnxQbWxXx3KMEG2OJlLJO
         zf1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMW/bPBHgBeu/Hx0W2G85+jaClzGb+U4FPMy/RQu5reMzuKWzpRK7GM5CDiXcsp/8sSgZUTfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUFAKShgYE+ClxjcW4vG2dc2CDkTrP9vZiIE+dtVsZzHBGepi
	HxexL8Zg29aIW2QoOqIL0sFAj94rBroxN9cp2rbJnUHi+6QXSw5/AkdxziyAr/U=
X-Gm-Gg: ASbGncsIRbV6hdUNgNFaKlv6KvukGtNRNT9oqW48LHBXTKn8Ob0QC7uvGH2BZc8rA+c
	4Hu0QnhqAZK3J4VFGoPCuo4E5x0voAbHQ0eRQD2xsQM7WiRF7IOID8eiWjMryZb0OUa1P99xY+l
	PYtWon5lM+JIYp5oqBFrGofgAztVvPFcorGXVrYpQwubNnOnCtByAiVxI4a4mPbcNXcDXf4sDn7
	axKDg9b1BxMSXi0e302HaekikqavNlPdYs09IRZuvT4RuHyEPhu
X-Google-Smtp-Source: AGHT+IGvXCkxVXqr3xX3rbpqTVSG5Ho2Px9XJbc7OSX6tbgT2BbW3PJ966NWRXbd5JYUODY+S7wL6w==
X-Received: by 2002:a05:6402:2084:b0:5d0:ece3:158a with SMTP id 4fb4d7f45d1cf-5d12478421fmr6148766a12.3.1733478500373;
        Fri, 06 Dec 2024 01:48:20 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c799affsm1903727a12.54.2024.12.06.01.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:48:19 -0800 (PST)
Message-ID: <e13f753a-b62c-43d3-a1c5-7343c87612e0@blackwall.org>
Date: Fri, 6 Dec 2024 11:48:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/11] selftests: net: lib: Rename
 ip_link_master() to ip_link_set_master()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kselftest@vger.kernel.org
References: <cover.1733412063.git.petrm@nvidia.com>
 <fbf7c53a429b340b9cff5831280ea8c305a224f9.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <fbf7c53a429b340b9cff5831280ea8c305a224f9.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> Let's have a verb in that function name to make it clearer what's going on.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: Benjamin Poirier <bpoirier@nvidia.com>
> CC: Hangbin Liu <liuhangbin@gmail.com>
> CC: Vladimir Oltean <vladimir.oltean@nxp.com>
> CC: linux-kselftest@vger.kernel.org
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


