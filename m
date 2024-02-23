Return-Path: <netdev+bounces-74446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 252598615B7
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72F50B25D07
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43EB82883;
	Fri, 23 Feb 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG4MxnWj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE11B81ADF
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701946; cv=none; b=CP5U5jFoA3uOKAxwOWGO5myHVmyjthwzY5K96R1aEGW026DvM9Zzj6PR5kswiGOu/LSGjIDtwZlGC1jFxeDTNaDBR1gTEA6SajqNkJLD6bWa5AE0Ycv7xnWTyr3f8KkyxRzAfxd/qgA2fk3x9ssSCi/Z2FYmM/6akmBTS46/ADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701946; c=relaxed/simple;
	bh=O+VL66QC1me0jPrWxup6U1Q9NUgENnq9QBlmHle1NBk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jkyuJrkuOFirlB25Gudl1Dwz4aDiJtKkiwykZfgWQexLhFTCuJUaFIvSnsrGyqo3lkxtWQiMXKlVwKLGhDl2dfnxZtw1vXLLiugsGEbhPjpoDPekzdAednjSOovOKyjVPtITF4FbVFJFKb3NOD6EHodxPy9EqO92qmegzi39WQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG4MxnWj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4127190ad83so6506505e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701943; x=1709306743; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+VL66QC1me0jPrWxup6U1Q9NUgENnq9QBlmHle1NBk=;
        b=PG4MxnWjPn5xioGQpnaTZk/fERDhVPI+gZ2/qqE2CrdkKwe4NWJXZYah1Q7ITs2iW3
         LrCFxFUFf2DZz4kZAQ5r51mbocijUwWdf3NPHUT4Uq19ImsaSEWQjLep7B+BVEFDDp0h
         QP0dF+9MSTdlgnFuN/7hmhMsERlLtd7HBP1wCtq72IOf7YRX4BRgLR5oXIsl37iAitjf
         f0L/2xHbXn95UGPM5YQQn0QGIHws2NqL3B1tSYON1dOrLZWAzVBUmTmhbiYDvB9/9HDc
         NrifHLlePnKtUFGLn06NzjLnHRXEVtYkW01G0eKP8QixN3il2XNvT3KlTEW1u9cFqIiD
         RcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701943; x=1709306743;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+VL66QC1me0jPrWxup6U1Q9NUgENnq9QBlmHle1NBk=;
        b=YMoajyiXEqPbhl26TWCm8wVhc97ZLJv075TpFJMLx0BKQZrbPUAANCVyFwN3Xo0pn8
         9gJlWjOLsngc6jF7ddBKifmpVcbXh3pHQGazK9UuETFnmFSG3xrV6H1RC2nAdV2iE8YR
         70iKhWcc3+ljP37VxDLWNaMHjZwxxjNfsqv6F7kSvlopvppesPowjen+sdBu9HS77SIJ
         Kw+XVQqlcmWSPHkyr3Ngi9sKe3wT27uJmCUVMBzaFXnWKaqvjy8lHzkrKLtcnFXJW13x
         75PEUjhSW6bos7d/rGoH58IuXIpkVIxeMMSAEY2ZbalPax3LxnF8YPRbMMBDa1/Zk7J8
         OSwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpvXP8TS3Q0HlqO8GyHdoQMxf7ajAoIq6MEVKjI97odgjAspe3uL0oKQqk+Y+YXdxZUOX9esQGSOxPAQtuweN1ZRnDIcr
X-Gm-Message-State: AOJu0Ywhbt8BV3CaSYiQef0w2ohI5oWx/FQT8O1mVPrN/hoPe+e7awep
	9sS4vAa3483JKBGDCUezD5cdyTqsIp9obEkepL0meubhpyDjL453
X-Google-Smtp-Source: AGHT+IGe8vU94KsOBVeWirKHnVJFmvqWwfmrujVVaRikUyuyGM1dixQDHQlioG8QGlB0xvIy7aR/oQ==
X-Received: by 2002:a05:600c:4ed2:b0:412:9680:b770 with SMTP id g18-20020a05600c4ed200b004129680b770mr112942wmq.16.1708701942861;
        Fri, 23 Feb 2024 07:25:42 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id g11-20020a05600c310b00b0040fc56712e8sm2708205wmo.17.2024.02.23.07.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:42 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 05/14] netlink: fix netlink_diag_dump()
 return value
In-Reply-To: <20240222105021.1943116-6-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:12 +0000")
Date: Fri, 23 Feb 2024 12:30:54 +0000
Message-ID: <m2a5nrs6pt.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-6-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> __netlink_diag_dump() returns 1 if the dump is not complete,
> zero if no error occurred.
>
> If err variable is zero, this means the dump is complete:
> We should not return skb->len in this case, but 0.
>
> This allows NLMSG_DONE to be appended to the skb.
> User space does not have to call us again only to get NLMSG_DONE.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


