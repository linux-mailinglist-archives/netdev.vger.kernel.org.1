Return-Path: <netdev+bounces-209223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2BFB0EB94
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963743A9F24
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 07:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D778246BC7;
	Wed, 23 Jul 2025 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A8RjlQs1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1862E3702
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255026; cv=none; b=YKorfEYk2Q7jpuf3aRE8qFA8kns2Oe7jzTiaJsFl3zhQbA6hyxGZmdgH83dlavvegB0aTnwk/gRSu0FOZQuqFUQ8MlAS5K2F4TBrSRV9KxiWuFPGI8sv4w2g2RYWkxcaNtQQgA6XjkXtJbVyzJBlv0rdbDZPTdA8Uf2cFZhgFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255026; c=relaxed/simple;
	bh=dCIQ9pi8CHnrcgbOWkn13oZfNaihHxqtu7TbF/rVHjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdnJBAdgHcJUP1ru49mex7Mbt0EJZuks9axpFmXtx5TutB90Y5cQK3uSDJ7FfDW0Gd6QHdAHq6OxL3PPE9W5FLEBxcJnpyoZ9EJOcp7gip21ZplDCaEK6heP6hJIuuT/lAbiunqUGdDIaWDLIRni9H7L3ryqjtkLtsM6QmictK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A8RjlQs1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af0dc229478so412966266b.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753255023; x=1753859823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjgCzalKQA7mynglTO8uzWQ6FH//8k7oECe/6Ke+2Ts=;
        b=A8RjlQs10BiDP+CFxXxv2igTh0+iiN9WhhqxjM2RUzzpgw6v83/O6/gl7pRfKl5Lij
         Du76sBn5z55ZHdqUFBgXbq5qPAHVRggZSIOVUmjOU2kFTsqkfgIwPigAVSUBlhU+ex1p
         ewNYciw+UWhylK+amcWGpJjhs2275cVcSLHFzmvvvePTLMmvGc9BBFu29t3JilHevCW5
         e1JvxhpFshz4Kvqa2LQWgDMn1c6U0pRH26QTTs6kQ6oMHdYMm+E/VUF9GfefEsHLQHdW
         rhIoT2/8CN+CaoNdqZ/DlToY2Lv5vuOo/05VIuQA28CT693xkFJHJKl35eL2yVNFfW/e
         ZwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753255023; x=1753859823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjgCzalKQA7mynglTO8uzWQ6FH//8k7oECe/6Ke+2Ts=;
        b=bEzk9Vw7fDEFORLWEUq9pzKCLryFbhQBmXa8sIAmI1LBFBbw8ClhuP38IDZ0ytFE9v
         BO0OPSC6VluIh3FirrRdGaq7KRncHblI4dVjVhaNO4UgFs/WKOsLxyrEG1GuDoBFedFL
         wDQ/i1oGWiJ8mceb1b22TPkx17Xz8kw34I3tXIf5XydKnrDsY/8hc1esaYo9cpKlAAFI
         +RqHK9bOisU+Ctp8JbRdD1BRhohUjWlbOtc7IVd/+AhCO92CMbj1hMfABk0DFQogeUEq
         O62SJWzvV+VXM+8Pr2pVxqI73bf635eDb6VA/5pQWtD9x+UC6KlTK/l0/WccF3yevaCT
         dAQA==
X-Forwarded-Encrypted: i=1; AJvYcCUtIHcHt6ZJdeLpQSW9C2Oup48fdjFW4AaC39ULGc1dFIGm8Ax01t/gSwIzxGLRy0PNpEKWfQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjl9R/pAVC8B7I7K3CDnj0GJuEuYJvNXQoyNalr1JlAl3LntoQ
	RdIwpPgp1k2r/o5xPwcfFNzUlVkDfupzRJA3B+Gn3hz0DWnuQVD0lLh7drePteQ1I+H5vcPf+81
	GTfs2
X-Gm-Gg: ASbGncv/lXFhlm0zIC4hVD401wNkP+ACqAXKfupBpW6egQvB6ENltAvLTyjDLYo4Lia
	qQs7QqlCUyl18aKBak7w636umH3Q5nOHZfbeJZ7WE343fXItnSOs3NRRCmdq8t6y73pEAofzk08
	kDJfRwu9g6evLmToE1tAdJgaq8RZXX1pmRYP2juGBDCUp304Qo5yc6/1RBLu27PZTAdzC3HOf7G
	uSdWCnsKC4YknJcnegfWT8FqP1TnDe1ZXCK0o10medNvzTn1FOBnAi5zwKBdmtvdGLPEhAQUdfm
	io63aU1ZgRLxmhHPWKlmgj65PQ+v6vgsYb1xXfPJ5lgnSCRpp4uNBBCueBlgu0cci7Jp7QooaL2
	ZZLi09FJywRUnfiTno+ZDyROhG8e7ConPxwIxf0TNS+9Wdf+CR/fr5T51r6sWkGg=
X-Google-Smtp-Source: AGHT+IGuuEyTsRXkgkT9r8mWAZV/qIwG0TNGe8o4GgTqWMhqKXUoMdqq4qg3WnLlEX3qPfrQmAlN7Q==
X-Received: by 2002:a17:907:788:b0:ade:450a:695a with SMTP id a640c23a62f3a-af2f9381584mr172150866b.61.1753255023164;
        Wed, 23 Jul 2025 00:17:03 -0700 (PDT)
Received: from ?IPV6:2001:a61:1375:cb01:9949:2e73:6e1:36f7? ([2001:a61:1375:cb01:9949:2e73:6e1:36f7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f59a7esm7916619a12.31.2025.07.23.00.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:17:02 -0700 (PDT)
Message-ID: <6373678e-d827-4cf7-a98f-e66bda238315@suse.com>
Date: Wed, 23 Jul 2025 09:17:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of
 MII
To: yicongsrfy@163.com, andrew@lunn.ch
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oneukum@suse.com, yicong@kylinos.cn
References: <1c65c240-514d-461f-b81e-6a799f6ea56f@lunn.ch>
 <20250723012926.1421513-1-yicongsrfy@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250723012926.1421513-1-yicongsrfy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.07.25 03:29, yicongsrfy@163.com wrote:

> No, the standard does not mention anything about duplex at all.
> 
> However, Chapter 2 of the standard describes the scope of devices
> covered by CDC, including wired and wireless network adapters,
> among others.
> 
> We know that wireless communication is inherently half-duplex;

Well, no. 802.11 is half-duplex. Cell phones are capable of full
duplex. CDC is not just network cards.

> for wired network adapters, the duplex status depends on the
> capabilities of both communication ends.

On ethernet. Again CDC is not limited to ethernet.
  
>  From these two tests, we can conclude that both full-duplex
> and half-duplex modes are supported — the problem is simply
> that the duplex status cannot be retrieved in the absence of
> MII support.

Sort of. You are asking a generic driver to apply a concept
from ethernet. It cannot. Ethernet even if it is half-duplex
is very much symmetrical in speed. Cable modems do not, just
to give an example.

I think we need to centralize the reaction to stuff that is not ethernet.

	Regards
		Oliver



