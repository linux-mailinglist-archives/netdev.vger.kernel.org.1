Return-Path: <netdev+bounces-147091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F479D7870
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D1F282768
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAE15E5A6;
	Sun, 24 Nov 2024 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="hX5bDHYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF0E5103F
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732485676; cv=none; b=u66svk+9CKeNR/C36HeORhl+WYdtibJaW/Y/0gTkgecIhEzhRwvoPXcrbCExWaf9ueuQfW0hBxrM+DSfi+8jRrKwR+aB5PD0aEhXjE4gNmmzxnRey6ZDRsFwMCltv4MMK8zXWaUIgQrc3vGhB7S9KeLB4TQsfH1LcD6ww27d+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732485676; c=relaxed/simple;
	bh=B6ZExtlrWDpdVkh4NrErlj5TWXl10njXAk3D3IVXvjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFu8mUtoMYSqmD7EpvvlzQW0zBdyq5LnlA6cBLnRiM0xHNKla9QzUhTHFM4pCXjbC2vBW+rEUMXH67f0GDnajTJu9kRdJahyAUix5EkAocJFirf5cnOvKnPJV7X3bS6V1r7aNjmFVUmUhImLq44Gfp0d6jbv+RldZd7fIrBCihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=hX5bDHYg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382376fcc4fso2178408f8f.2
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 14:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732485673; x=1733090473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO0cvhOCCYEcMHo4t/kUcC7+MddOiWfvg8yPqnsazn4=;
        b=hX5bDHYg6+UsRUluRjpXQcWAhAehhv496WFfAjp3OK+Sl9S/xEdfrXuusNwYYzKx/O
         Aks3lm+k7/hd4suDwLvlTot5iiw0eoFVBdc1CGVwx8K1k//INL2ELAXfFcr9gwtzuJi1
         vrxR4pBcp8CbRsJGTN4HS3m9nrmuX6JFUKIjRTLz9ocViQdFeIUZgD7J+kgZ5lMoLAg6
         qM7O3UfmwgN+aJfb5xvZX48o+Lqz2mnWbiVk0SJd8HSMDm3qamafOkgmk9lUsZOHNxu6
         jC3kcLmwL0qK1JfpYlFws5y58VZ5AgsjjJ+aT/lkpiWUE/JX5SiFFiyXDkVlNBMGB9yH
         4DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732485673; x=1733090473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WO0cvhOCCYEcMHo4t/kUcC7+MddOiWfvg8yPqnsazn4=;
        b=vy4PqDbCqRxPkKwUkjzeXYHcK5yS3RM60R3zBsQiwn1LHclNRC8GZyjB3uzniRww0V
         Zm//Wh3CFNZdaZAhrSKGRqBO4M/SvEAYDH4Tz10S5t0OQa+qcOJSxsGIrQPShFWSZrm7
         ITifPu0CX2MRGW7c7j+O84C0ierfIzeNdGmyq6xX6CPrnnV5gqcJlLWgw5i7iDqvxFyI
         FShYm4LiXzWS95rfie4mXohY9EA9JgvYTHd2lvjR5uV5O87jJkGLKQEVVVScjhgqIqOJ
         5V2y4PAlkxwUSsUOXQzLM59OxQxZf+8tGkAXhp09jhH5AKaKPZCwA2yuHUza7+36JKCz
         4n2Q==
X-Gm-Message-State: AOJu0Yyx7V/c6Npi4KU8+iDrf3BAaRZy8qQAqmmJFwZnlsORtfqZ1jrN
	BW4s8iSFST6kkovR8FawKhZDWMBk+RNdb3ZFH2xFHJorTteSwQtETftJN+8Ajig=
X-Gm-Gg: ASbGncsxSM9r6hJvvaYbcsgaQilEBBpNZrgedxqaFwufdYGfLqFHUTRGMNWwClROZpp
	Cwh0krNGFxgu6A9PdmNWM3MULo50ACgldV3uZrhjls7tZTckO17AUhdbolsH/WXLJ5HvP8U3zGb
	BGo37vNYA5dlpDQP3uNP4/S/dR2fHLDV8FZFTqvoip6R62UGFgDWxOOqbDMdtVISV8A2HTFQnD7
	KgwspuzZck3DHVaGWaAcVN/hiQjYZMnuRsx0GPlHNqIZVbhGPR2
X-Google-Smtp-Source: AGHT+IEUmJWNVT/yCHIU4DpWfoBtu4D/gDbWjN7B8ekkI1xXmQ3BxXPpdtKlYrC7+KrVS7KrV9+AEw==
X-Received: by 2002:a5d:64a1:0:b0:382:5aae:87c7 with SMTP id ffacd0b85a97d-38260b89369mr8791101f8f.31.1732485673204;
        Sun, 24 Nov 2024 14:01:13 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde0db3csm105665385e9.10.2024.11.24.14.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:01:12 -0800 (PST)
Message-ID: <87d8a49c-41e3-4b18-9ada-cb64fa66fe9b@blackwall.org>
Date: Mon, 25 Nov 2024 00:01:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next (resend) 1/4] net: bridge: respect sticky flag on
 external learn
To: Elliot Ayrey <Elliot.Ayrey@alliedtelesis.co.nz>,
 "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "roopa@nvidia.com"
 <roopa@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bridge@lists.linux.dev" <bridge@lists.linux.dev>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108035546.2055996-2-elliot.ayrey@alliedtelesis.co.nz>
 <f2ac33e7b8ec0fefa48fe7cd3b1004abab67dcb1.camel@alliedtelesis.co.nz>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <f2ac33e7b8ec0fefa48fe7cd3b1004abab67dcb1.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2024 23:01, Elliot Ayrey wrote:
> On Sat, 2024-11-09 at 15:32 +0200, Nikolay Aleksandrov wrote:
>> So you have a sticky fdb entry added, but it is still allowed to roam
>> in HW?
> 
> No the hardware has informed us a host has _tried_ to roam.
> 
> As I think about this more, using the sticky bit alone probably isn't
> the best idea and it might be better if this mechanism were related to
> a port being locked? After all the port being locked in hardware is
> what generates this event.

That does sound better, but we should have the same functionality
in software as well. Perhaps optional to avoid potential flood of
current users with unexpected notifications, see my response to
the other mail for more info.

Cheers,
 Nik


