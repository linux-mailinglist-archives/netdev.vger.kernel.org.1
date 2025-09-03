Return-Path: <netdev+bounces-219527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5719B41B67
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA3A1BA5A6E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D29D2E9EB8;
	Wed,  3 Sep 2025 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HgaM7Alm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B21E5206
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894316; cv=none; b=gEQ4+/KqpCdAMqEkLzeKHbWL8pDtrGbyy8x5D7aR4aD0Z1RDFuzCrXy7fIh0ynlYHhxWn7aasWACO9P295Ll10g10uqwH7kMBYg98706gaQ4AdtrZwncMlsPMuZIhnUTaQDpYpW3CUeSOukAMZO7aX2vVcgQ1kWvl22ZAujyDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894316; c=relaxed/simple;
	bh=ZWM+I7gOKWzcFzvY+hdqKvup4xsslWjbk9vdkN+t2Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUBq3tKFLkcpJXIWWEZuccHXiHt5ZeIJBn5iRRZrEOkE317bfZy34fGB16ZiZd582NEftGUXek6C1pISG/apJeZVKRtJYnFKGox1KGCgOWjcT/cyBCK7XVb4uWa9W72zmw5bhLV2LSVWATon1zHMgx8lg394veApTMLFuC1yFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HgaM7Alm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso4031217e87.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756894313; x=1757499113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaEC72YkdU0dzg1YAuuKkN3WkhmBtHuuoh/1oBPlyDY=;
        b=HgaM7Almdmo4mR9m242m2BYDdG43c6Sn8rx9i+d4c1S4cjKxQBPP9rx2rzDrwyQwZ5
         WElEHiNbGkSlpxTuh2yuj8/8AIkp+V2jUj4hEXIMHrHO7AqaPTzE/LRRbvK9TQEXUiI1
         MYnqldIva2B6znGqZHOOHcdX5d+Mg/D2OS2RJiBvWR8O2HpeC3nim6PziF6ZTXl4yN6h
         pNdJheX6ym19bGjLb251tiVYKUFTDDUwHxXYtPru/U3o4JgHofNhHC8JLFNZTIvPgTnn
         GK+9h2NyvXq6G96Xgb6z9tC+qBxFgRfGEZ7OuGy4N/JuPOj3MM6+Ncpwzz8t5NshCC2u
         +6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894313; x=1757499113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaEC72YkdU0dzg1YAuuKkN3WkhmBtHuuoh/1oBPlyDY=;
        b=T/hA1uODNaBlVtSC/50xg4L6x28F7FmuK4GN3J7+3Yb4/bWpw+vlnJKl1K1B2wQK0K
         nfsvF3Jvs4fjBeOQd7DEsaG+DTVBc513Blelo8b19pLYcrDMbGDjHDGpBSkSZLNK5ksA
         z8Rzzu6MzTQfZlsycIH/ZS6HTGYdkAwahefMcDnB4sK8vr058os6K9vZfKzPCrAyvRHN
         HRmSErBoFyzhdSeBL8r1ZdtIiAM7lnFdMEU8zPK3ZUXPufMWbxf3Kfh7UQjoPQZBI8yj
         Wrh8BgGyLjkhdtu3v2+8sXSGQwFU4cyOyJdJeDAcQPX8qerdlYJXg9h1xeAMxVzuw2ar
         TT6w==
X-Forwarded-Encrypted: i=1; AJvYcCVOEYDZhX0q3jyv5jsxPFtKrWjF7tou1Fkn7b5h9G3jKpU6qrYfCu0SMUpPgqtawx38i1hMaUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5fb5Fb+m+/rHT3AlbrHsYg6L94LdlWd1v3Ot7BFqivYI683uR
	MWfE8X9Ic8zcUrSLSOGMVEvuD04j+xgjMXiJmqia4AsbjHFcw6A9kBp3rA+pI6qc7F0=
X-Gm-Gg: ASbGncsBgNrShzonh54ufjcGTluyZduNtpouX3tkUyQbCAqQ+NSsRfSWMNN/E1csw9x
	EbBj/5eQDHPC4ofpf+FXdFU6a1Gf6VXAJ4s/xyYpV5wMm3VjfM6kQo3wSbSoB0ugWH9l6qeDjID
	zeiQRfdP0R5yJxyzZ/u3vpuznIRxhSkOf05QxplKZOPB819w10OxEHLmPzh2dwT64fKQ33MF+46
	Oi53ObdTOcz9oBUHVqGCQS82oFMOKejDnUZ/sO6dLZbO8h6mjzPt8XdeZbzEnIoRZOHVXYzj/P/
	pV/cV2kyojoVeQua+5DOlWp9z8pPwcqVdA7BpLLukCCNMPmIoQQ7nJBXgVgzvhTaPotUXG2S338
	TIrFyeL03DA8ZCivjE0pBbx0bzlJEKRpazvYJ3YOBaZNdSyfDOoKqF6B7YJRMqM4bVHVFUVSb8n
	QOAuPe6IKYwR7E
X-Google-Smtp-Source: AGHT+IHqbWry8xvL9J/n0nJMx7Sm8XKZqsiZtmb0vZ5EuUF59SiOy4XjuOBRm6SxlSbxf5fnxVNO0Q==
X-Received: by 2002:a05:6512:3b0d:b0:55f:5685:b5e9 with SMTP id 2adb3069b0e04-55f708b3332mr4752512e87.8.1756894312876;
        Wed, 03 Sep 2025 03:11:52 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acea03csm417484e87.90.2025.09.03.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:11:52 -0700 (PDT)
Message-ID: <fb8b827e-9aee-4aea-8291-30e5e4c539dc@blackwall.org>
Date: Wed, 3 Sep 2025 13:11:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
 <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
 <aLdQhJoViBzxcWYE@sellars> <aLd2_um-oWhS23Md@sellars>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aLd2_um-oWhS23Md@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/25 02:00, Linus Lüssing wrote:
> On Tue, Sep 02, 2025 at 10:16:04PM +0200, Linus Lüssing wrote:
>> On the other hand, moving the spinlock out of / around
>> __br_multicast_stop() would lead to a sleeping-while-atomic bug
>> when calling timer_delete_sync() in there. And if I were to change
>> these to a timer_delete() I guess there is no way to do the sync
>> part after unlocking? There is no equivalent to something like the
>> flush_workqueue() / drain_workqueue() for workqueues, but for
>> simple timers instead, right?
> 
> I'm wondering if it would be sufficient to use timer_del() on
> .ndo_stop->br_dev_stop()->br_multicast_stop().
> 
> And use timer_del_sync() only on
> .ndo_uninit->br_dev_uninit()-> br_multicast_dev_del()->
> br_multicast_ctx_deinit() and
> br_vlan_put_master()->br_multicast_ctx_deinit().
> 
> 
> So basically only sync / wait for timer callbacks to finish if
> their context is about to be free'd, on bridge or VLAN destruction?

You should make sure the state is sane if the callbacks can be executed after
br_multicast_stop(). There are many timers that can affect different aspects,
it might be doable but needs careful inspection and code ordering.


