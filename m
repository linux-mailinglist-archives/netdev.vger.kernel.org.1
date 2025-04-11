Return-Path: <netdev+bounces-181614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E005A85B48
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3FD17A1E7
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801A221260;
	Fri, 11 Apr 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBPn+ti2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28878278E7D;
	Fri, 11 Apr 2025 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369907; cv=none; b=uJN2TKWX/TgaINsuToueL5NlRPvlm82F1fxych7dZD+KajkRD5vxlfgVsm5xE0OACdg4rgePzd64vOpVhZevGsCDXiFMxhQZYZcxJ4IZti4k/lL3UJ9F8Uk+E5Q0AQsKADu8rgVx8KEvhbNldSCPU8xlG255lvadvNOIU0ND2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369907; c=relaxed/simple;
	bh=r47D4va+hMH0nDuBINvAukqzGK5b0T3bIPft0LLGe1w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VbbYLfl3Lzi4CPHXqYHhT83RydEUCnH75w+D8ZZvvTiMB3vadb04xKzYM23yZVVY4LPpkeWMtyvI4Et0CBi0x8XX2kAHilJokt8NYUWP9SBC/cK3sqipGVFkIbKc5h/rVhfAB7lA7xmzXPiqp2pd9E0UALiGR9ICSa8v4jFWHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBPn+ti2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso12910485e9.1;
        Fri, 11 Apr 2025 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744369904; x=1744974704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hpXQKfyaLGLKe3xI0l3a3j00vTUAb2QPam0PVoMhfq4=;
        b=dBPn+ti2Zp5nkv/QQ3lAtYxMEMf/Nh0mIC0SVRNgV38h7+7eM4fcev79bNM3YSoSbH
         BUFjkLaHw0fPSBYDvKoYCsGukL3xzJlp14spfCfBzbKHtf4Ql1qOG4RkYVKNZYqwlxp1
         12IP4MmSggKn284GM5+oK6jrRD37hFtp33gunPA0SOaNGnt27KMlYFVqfQcrigOlMaV8
         1nmsZ4dvQUiQ77kbZuX5XX74i4XZ+cXXkNiUhEfi8nzbF6bduftxltRTM6FzHMoa+hc8
         HPJO2XploqyMTnXK5qu9U0R8M79iaReifntoKsRxdh51730hXR31RP86qntbq+RI+FHr
         e/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744369904; x=1744974704;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpXQKfyaLGLKe3xI0l3a3j00vTUAb2QPam0PVoMhfq4=;
        b=VM8oVh3ZvXH/1Oiz4PZVz0YvOBRDWTMFX4FWXvBNNvk9R69efDIxyoCX9dm0b/caSa
         Gok2ImrFxoHDuDYBUSzFZnB9A4ZMYNmjT3zNbH7cZnf9hwJizLYTxp/+o2UoaLRBWSrX
         7JM0mZYRdye1p5OnAkUM7jsx9j7wnXtLmHPBH6+WfKQHtx3hUiT0swwbKehDjTWYkaqr
         x4acjQpFrziu16o1/IfesNs832TrxrfHE9dz6qPY4FmSHBF/du3/E//orTw6olDufava
         79iRSipMfTlfzzGjBQp2cC1sYYrSs57srZ2Ca/pG/0xGBdOYMdAHYPzB0hPgKYmAK08T
         2RLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3x3tb4m0E/kUJEzaP4Ukr35dLrgyXPvxrzExqwn3Z2AnXg4kSL2XKfUqacPqtVBwMrXhMb9A7DN0=@vger.kernel.org, AJvYcCW8ilWNWvvR07D5Sx6UW/5EBfM+LDUaY4bDipdRXp0/JYUWf8cEiDiSaY06zsXJhr1PuraEXh7x@vger.kernel.org
X-Gm-Message-State: AOJu0YyZED/EF9zqHyFoVumZiywF79Z/XesoiTD3Mxepm6Cs9FvX9+B5
	xS42Ppz+NpSabmk+1cYMdHkRNSeQKfDScdTFE5zmIt5XFDpmf6mi
X-Gm-Gg: ASbGnctRhnNDvYi5GvgmyQCwgp+PlcuVh+Qx0iVsT0JtkX+mgVI5K/UrYzBtJ7Q7TMN
	Wkt/KcBIgyRwdkFpmXm0cbDvWOKZtTapd2PtIKwV1awU+UQo9NLHPtJklf7j70CA/00j4w6uznc
	l9j3PvLAf9z2wLIaKu3CYU4WYz3qdU5Hl0S/hvuW9j4DFR/GvGf8JKEYwqF5keGHDnAvUwkRejC
	/X1GVrL+WgTNE7g/9uKe9UTOlTA3KOqlvf+AKpDrma/6P8np3rfA0o4stGkj8LGeWQMXbOQBzul
	hCyzvkDh9CLK0/MhRFQdGoahmbDoJJ9fp+31+WwlLqZjWdwDK5ra9BgGw7EtujKwj6OP998xJSF
	A8zkke2pkNkHf3VoJ7TSD8s5ouXPVn+m/BC4aPGM=
X-Google-Smtp-Source: AGHT+IHGfWqGKYK2XCsLaggmdsTg8N3NYT4RvucqIT58PsOgAUm1Rp915BQIxxI3WxJe3J7VXocRuw==
X-Received: by 2002:a05:600c:5107:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-43f3a926606mr18010065e9.6.1744369904282;
        Fri, 11 Apr 2025 04:11:44 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338db88sm81134385e9.6.2025.04.11.04.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 04:11:43 -0700 (PDT)
Subject: Re: [PATCH net-next 01/15] devlink: add value check to
 devlink_info_version_put()
To: "Nelson, Shannon" <shannon.nelson@amd.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "Dumazet, Eric"
 <edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 "R, Bharath" <bharath.r@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
 <20250407215122.609521-2-anthony.l.nguyen@intel.com>
 <d9638476-1778-4e34-96ac-448d12877702@amd.com>
 <DS0PR11MB7785C2BC22AE770A31D7427AF0B52@DS0PR11MB7785.namprd11.prod.outlook.com>
 <7e5aecb4-cb28-4f55-9970-406ec35a5ae7@amd.com>
 <DS0PR11MB7785945F6C0A9907A4E51AD6F0B42@DS0PR11MB7785.namprd11.prod.outlook.com>
 <20250409073942.26be7914@kernel.org>
 <5f896919-6397-4806-ab1a-946c4d20a1b3@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <20a047ba-6b99-22d9-93e0-de7b4ed60b34@gmail.com>
Date: Fri, 11 Apr 2025 12:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5f896919-6397-4806-ab1a-946c4d20a1b3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/04/2025 18:25, Nelson, Shannon wrote:
> On 4/9/2025 7:39 AM, Jakub Kicinski wrote:
>>
>> On Wed, 9 Apr 2025 14:14:23 +0000 Jagielski, Jedrzej wrote:
>>> No insisting on that but should empty entry be really presented to the user?
>>> Especially unintentionally? Actually it's exposing some driver's shortcomings.
>>> That means the output was not properly validated so imho there's no point in
>>> printing it.
>>
>> +1, FWIW, I don't see the point of outputting keys without values.
> 
> Because I like to see hints that something might be wrong, rather than hiding them.

+1 to this.  Failures should be noisy.  Time you care most about these
 data is when something *is* wrong and you're trying to debug it.
AFAICT the argument on the other side is "it makes the driver look bad",
 which has (expletive)-all to do with engineering.
Value often comes from firmware, anyway, in which case driver's (& core's)
 job is to be a dumb pipe, not go around 'validating' things.

