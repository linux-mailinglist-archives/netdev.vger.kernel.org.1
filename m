Return-Path: <netdev+bounces-168147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4EA3DB36
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E92189C93C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211A11A8F6D;
	Thu, 20 Feb 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="XGf3mbNR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCB1F8676
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057740; cv=none; b=S9FLZQ8d33S8ZqlQPW5zA9/A0bt0lGhf3LpJmKxZEoK26NY9Ma9Zv5ghZtLiXznXizaRr26SvOj7epzYDI+dK/t1tpSuLZDfMJSHTyzuxTcPtY9Mk2KjlQmpfLD+bq6uDs5qLom5uihkuBWE497q1wv4q58tOOP2KR6gRoKW/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057740; c=relaxed/simple;
	bh=jUFk5Fo5YnjRTpO3Q5VqPQ2kp6h35PIen8abrhiAPmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dExcOC/eSh9/5Te0br1Ck9XLqvWgtQnYgwml2NW9b8QK8hmWaskfx3w0T8V+hGhOWTHCuW5VCQzokk4tbz32Sb6qnCYxV49S44z0XXkNiJqVtso5ZlvUUSK1VovpMCcQ8CAMc+Cxdj37G3lnzeAjFFUD8/fZVmtEigvcsAAF0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=XGf3mbNR; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-439a1e8ba90so885055e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740057736; x=1740662536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pa08VUhb3/5f+UR3gEsvQAWWge0v4kAte/HungXxozk=;
        b=XGf3mbNR1osNti2kpW8F0bYRHF8LBVlsI4kib27aVNUuyAg1vVwwXbFGXX0685tmrV
         tdUz6wEgDql2xw6K5tBGHNiF+efUcs/ycw3AqNr0YMFtMJ+XzfuV8AeQo294W3x2zDLm
         7caT2L7tyjwTpWWID0NxLLStz/R1LycdJhHnu1GeyGll6ZZxR6bkFwytuwj0LmDYS5q7
         Zpr2Cc/Pf7heymVN96cAch5VNO+yAnOuKHNBJDpLGr+Ll6S4er8BYzaUk8kdqhnqYOl/
         nqjzpYaMPTFG+7yVnZ8ZITmRxxP/Qdc76oyfdf4W+yQYXkwNEYiwGs1czHZOqI0EDA67
         1yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057736; x=1740662536;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pa08VUhb3/5f+UR3gEsvQAWWge0v4kAte/HungXxozk=;
        b=A17/J5N8uRDYib9qpsnLBkxaMKhFu1gnc8Q7rRFrppVzyDv967yjwNJy0kshbSsXJl
         PPzNWMA7bVWBLOKej+SV8xVVQz1uJtF9Qq/jFEWMpGANPVqgOn5rSFw02rv4bFzlTZl6
         pwGiLsvLfCpzWbHnzVefqTwuAGB9CDgqOnjM8dN6QEga0oPc1PoqHAGKPve/alLqP9+U
         RBCHp20ihxrhZRaON3eOOEoxulpzwu7SLDUI5vaASPXX5weGzGLpeP1wtaj/QVz9L4oH
         6D2rDBv0QCSuBZNxrifVghL+xOzIkOVBNy7vEVEKmGr2ZerjcFOiB7/sgUMxgODuskPZ
         XYLA==
X-Forwarded-Encrypted: i=1; AJvYcCWk4XPt6Me1sTE8QySE+XVUtO3BefX8dLrcQ3GIpyT+cp5Manx7BnUeAk5JBp5gCrHnct9Nh+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQq0YZQmbgiGpMy981dbAdg7lhSaOAw/tLvGpXf6n7+mrk8mX
	4SvuYFz/kp5SMjFssAQ3l/gDNO5Ho4p8qcmejjPOrsCXHAoGFch7/LAmYolSvq4=
X-Gm-Gg: ASbGncs7+zDBEvQYbzPC4/aS1wgDxUHpG83bPTGzRZwBrd4YLk9boSWmlJhE4TJvt0p
	jY5TvHILauVh4kZC/p/Y+kfXW8eWp+bPMYs5AR6MtHcrWb8dRODT4EWS6ofyg/2NQ3ovvRUhZlV
	06AsWgDqxI2rUSWdUEeKQFJs6WzGSgJcv0rwTJA5yF4im0CnaeHbX1TH76F2tm+6LNONgKNPJd8
	eDYslnmydAWkwZsDQUczqNoIDfP5fMLTIG7X/2+hW+HXBriUofjCpmg4rwtO2CUEYDQL6QvxOCF
	wSBZao8F0m3KfmorM3HLWiitpHjJVKXn/lozIQxRFHtNMvuspxINUTCj8mI5btXDHjyv
X-Google-Smtp-Source: AGHT+IHuuanujE2un3nNAOZiu72aYpwDSyCWgAMT0fDU58LKSs4DeFb2X+UIrtuH+S6PYRt4BhVE8Q==
X-Received: by 2002:a05:600c:1549:b0:439:9a40:aa1a with SMTP id 5b1f17b1804b1-4399a40adc9mr26279725e9.6.1740057736472;
        Thu, 20 Feb 2025 05:22:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:eba1:dfab:1772:232d? ([2a01:e0a:b41:c160:eba1:dfab:1772:232d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a8007easm103815435e9.21.2025.02.20.05.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:22:15 -0800 (PST)
Message-ID: <101c5d62-d1e9-4ac4-a254-5aeafeac6033@6wind.com>
Date: Thu, 20 Feb 2025 14:22:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 2/2] net: plumb extack in
 __dev_change_net_namespace()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com>
 <20250220130334.3583331-3-nicolas.dichtel@6wind.com>
 <CANn89iKdYXKqePQ5g5eU9UGuTi4fZaxwWy2BK7D+F2wkQHAXhg@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CANn89iKdYXKqePQ5g5eU9UGuTi4fZaxwWy2BK7D+F2wkQHAXhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/02/2025 à 14:17, Eric Dumazet a écrit :
> On Thu, Feb 20, 2025 at 2:03 PM Nicolas Dichtel
> <nicolas.dichtel@6wind.com> wrote:
>>
>> It could be hard to understand why the netlink command fails. For example,
>> if dev->netns_local is set, the error is "Invalid argument".
>>
> 
> After your patch, a new message is : "  "The interface has the 'netns
> local' property""
> 
> Honestly, I am not sure we export to user space the concept of 'netns local'
> 
> "This interface netns is not allowed to be changed" or something like that ?
Frankly, I was hesitating. I used 'netns local' to ease the link with the new
netlink attribute, and with what was displayed by ethtool for a long time.
I don't have a strong opinion about this.

