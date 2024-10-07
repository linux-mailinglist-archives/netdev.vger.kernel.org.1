Return-Path: <netdev+bounces-132818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6EF993501
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407A4B216CD
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138781DD55D;
	Mon,  7 Oct 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AELZbK/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EF1DD55F
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322127; cv=none; b=MglpShJh3KFkBNi2m8Hxl+0BWUJMRqu7YyC8EvInb8LWLheBVxLQHLANGpIWWqwjZGKQ6t1SiXgP/mYbW4hHQQP6H+dq4pj/othL/Z8c1jxEMJ/L7CX/06y394SWEU/Cz9SFgMx66Xjxz6aZCvTaDembf05xdu0AZVrmsPcQAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322127; c=relaxed/simple;
	bh=3CJvxuJ6KqxdJiUfgEGSn5hJJ5U9bsLjc3awc4rHEQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ck83kz/eEzygA25XeYG9/o8aokdr9Bo0lGicJBJ5olodFHuuesApHRUw6919AARCmZ0JsHkb5KoIGTVRHy9zMEfqU5MJam8XO0fsOYOa3wcwnfT1tII+LPkDipQdKk3IV6Xs5gBywh7TwNf6y34r+IpcvZ/QdK0OMiqslpXUFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AELZbK/4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b5fb2e89dso35882405ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728322125; x=1728926925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/MVLiebyBqKMOWwjWUN1n0h3eMZlRkRs9MYlwTgHAG4=;
        b=AELZbK/4OykyUSFWryuMSIIDjy6pL9YHY9oWF8YJWIlEzAE7d+w/SyLcO959XH3TNS
         pQ9cmsTlEQRJ8O/BATfXmE34yq5ZH8Gi8hS/TojyVas6BtAKLCz99k+qVHqksUAj+IKZ
         6fjXgFh2LesCEVqLqyTqwvfU5IBe4Qde74sKlYu4GlJ0IK4RiQos3JI8wcKERa0Kflt/
         1m58KJYUXCnqO35lB8j3TVmQ8zjTIJONWR5D9xgcTLJ9AbN27sCfe11AVQet69LtTYzQ
         EgH4r7MAYNN9kQiGhjgki7ghkCxI04lnVkLkKM5Bv9bMbGp9IgLR0k5KzaSHRukRvCos
         MdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728322125; x=1728926925;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/MVLiebyBqKMOWwjWUN1n0h3eMZlRkRs9MYlwTgHAG4=;
        b=uiDoKs9o30OWXlc+aAStnuSFAQPixBbyR+Gx+UMeX2eNp0vQaslSAC5oGd3BPF13yt
         Q8zVgjxiGS4UFti/WhuNKifg47EU2VJ7ptNoauJhFs+i+CqrSxxm7khWmzg6EYOTLJ/T
         dYPALhJgt6soiFoeDOkA7WFjNY1xUKewzFkb5dJJ+pfaivcmHyY0LSfz0TWgJepEsdCd
         E2Wvkmyb3Q/Yb8LvHtnldCHZKaQwD3vjOoyATVxtzEt7Puh1FggTSQNXaSuUuqPWQePE
         jto3kgTiigHWFqyGoZvnFb684p8q0CJhpJ0aSGiigNLuFVV1SBzk8n5KqDNUWJifSbwq
         tczg==
X-Forwarded-Encrypted: i=1; AJvYcCXlQos4RC+wYsT01tRJv9XjE0vNbeDdrXJFW31LApBWN1/Ger5mhyA4Imy65sAAjRZBxsfEVps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+sDLnMzYRvG1V1yXqr19YPqDsgbb17ca0smYehJ+oRUAc7d3
	v47MgCRtNExvIeu1hJJQ0dQ/knoKwFLGWLr2NIAvA+FzJPT1DzXOqO4/AQ==
X-Google-Smtp-Source: AGHT+IFl6aswS+BLrAFwmuBr2dE4rUQ+o+CuIIUiE56uQwCtH9lgg7PURlUEh7Lidrh1xWpgNIMc4g==
X-Received: by 2002:a17:90a:77c4:b0:2e1:ce67:5d29 with SMTP id 98e67ed59e1d1-2e1e62a197dmr15321552a91.21.1728322124748;
        Mon, 07 Oct 2024 10:28:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca284sm7433538a91.11.2024.10.07.10.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:28:44 -0700 (PDT)
Message-ID: <c572529e-78c4-42d5-a799-1027fd5fca29@gmail.com>
Date: Mon, 7 Oct 2024 10:28:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux network PHY initial configuration for ports not 'up'
To: Tim Harvey <tharvey@gateworks.com>, netdev <netdev@vger.kernel.org>
References: <CAJ+vNU12DeT3QWp8aU+tSL-PF00yJu5M36Bmx_tw_3oXsyb76g@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAJ+vNU12DeT3QWp8aU+tSL-PF00yJu5M36Bmx_tw_3oXsyb76g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 09:48, Tim Harvey wrote:
> Greetings,
> 
> What is the policy for configuration of network PHY's for ports that
> are not brought 'up'?
> 
> I work with boards with several PHY's that have invalid link
> configuration which does not get fixed until the port is brought up.
> One could argue that this is fine because the port isn't up but in the
> case of LED misconfiguration people wonder why the LED's are not
> configured properly until the port is brought up (or they wonder why
> LEDs are ilumnated at all for a port that isn't up). Another example
> would be a PHY with EEE errata where EEE should be disabled but this
> doesn't happen utnil the port is brought up yet while the port is
> 'down' a link with EEE is still established at the PHY level with a
> link partner. One could also point out that power is being used to
> link PHY's that should not even be linked.
> 
> In other words, should a MAC driver somehow trigger a PHY to get
> initialized (as in fixups and allowing a physical link) even if the
> MAC port is not up? If so, how is this done currently?

There are drivers that have historically brought up Ethernet PHYs in the 
MAC's probe routine. This is fine in premise, and you get a bit of speed 
up because by the time the network interface is opened by user-space you 
have usually finished auto-negotiation. This does mean that usually the 
PHY is already in the UP state.

The caveat with that approach is that it does not conserve power, and it 
assumes that the network device will end-up being used shortly 
thereafter, which is not a given.

For LEDs, I would argue that if you care about having some sensible 
feedback, the place where this belongs is the boot loader, because you 
can address any kernel short comings there: lack of a kernel driver for 
said PHY/MAC, network never being brought up, etc.

For errata like EEE, it seems fine to address that at link up time.
-- 
Florian

