Return-Path: <netdev+bounces-73671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E8F85D839
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 13:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754C61F22A69
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E153816;
	Wed, 21 Feb 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="s9Cds9o8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7843C493
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519702; cv=none; b=EgNDydyH/xBogqvNzW8KdYmgci7/LN9cUVd6R+G3W5iLhfrzyOsKnjR3Bz/HCdKY2tNPpbXzgcVfNyQtINZWj64ojWVdPhnRpZ9Z1dl2Ib0cIr6oV6zf6DWLXHbJgtdq53Td1wG5Z2/vWcpLvnB/bYpUzAfa0yxG/GuwXP3xha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519702; c=relaxed/simple;
	bh=vNqQgQCVAtuevWv2dhhWfhGqCJDXmF5wdBtsfrN7PR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM505PawGQuEDpPKVp8mwyzOaqHP+ghjVbGrp6UB/VJzDWXd0CzEp9CZPeyqNGP81uEG7ZcVGHvwCmKf0numExfxqmAHolrqSH4WSi/knIFpMTk6nM0/SyTTm7QNHW7uFZDaAg/qXTpUYeQ2rchTBuF8NJdN3GMOTbo8fg3vRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=s9Cds9o8; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d220e39907so72566571fa.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 04:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708519697; x=1709124497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMvnAiGXjuS1f+1fwMF0v58IRkwVDz6WDHMCFpJrdyo=;
        b=s9Cds9o8cNZHLclMOSKfQSBU0lCPbUdF62HB/RlJ45TYYiazwQ/aI0I3Bcm95lLI2+
         s6QvITFLeW5p/D6HfR82tJPrMVVoAMHbSuMatJFyWtm3G5pXhqJG8AmuDnxuoSixxRe1
         0jRARGBQzq8EK6f0NxL5HkkZIwd8+uV02kDTzRdzjzi+wLUWSyqaYeUFt+nKe51FvsAj
         YZHe2qB8Cwz1GlNtyRfqUIkt4od6/rCcXfmI8XIEx9shSBFvoOD0B1m/DRbyIwW716LX
         NQoGQ/rngbbayc8A2KRsHEzFLe/rQqn5y2prpObQ7RhgxfbWr05OJNKI5XkdQDiU4tok
         ridw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708519697; x=1709124497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMvnAiGXjuS1f+1fwMF0v58IRkwVDz6WDHMCFpJrdyo=;
        b=JldpQG9rBYsZzPdaY/9UJE7vQ8gtYu/v5sXHDZ2XqIKNPy9b985SEMj3gBjEq3nW5f
         vNY+NWBTkEAIa17Q/ffwH7pAfBuGyb7qMEsTnZXbh0O3OyWX4sHGFi/kWBs6hYsKjKd6
         Aoo/09KRlFJzHGlGO40S0kTkJXXAyCXmKnd5Dh7bNOkoUiR5YeWKuGzNaMIvqU7aH9en
         NIjnYsA2/QKyuErj5dWhIGl+rlXnRlVKqcQu2Zf9gOkp8pNMVpVOo5yICWKEkBvhWy+J
         bmfD8ZcMsEkq+oaSoYDicvkEasaRT8CZ8pahUsvFH6xwLEpW/R05eDGhLqD/vmeYfBeB
         Zl0g==
X-Gm-Message-State: AOJu0Yw2KGot4hfcMdC/M6K4utSLJ2id3chBcOk3VwXwI6zKhsQBFb3X
	aICPULkaOD87O12VxFztDgVqyfdLErc8YxV3B4pqT1jsKhcbcNC0j6Yb+JLTTJI=
X-Google-Smtp-Source: AGHT+IE4oVKAdzu+cKuH3MZUYtIwCSHwJgv1rWTLHYGpr5p577JAaqTBcAv2Qzha0C8uoT2u5BPPdw==
X-Received: by 2002:a2e:9dd0:0:b0:2d2:393d:91b7 with SMTP id x16-20020a2e9dd0000000b002d2393d91b7mr7254913ljj.52.1708519697287;
        Wed, 21 Feb 2024 04:48:17 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00410ac2d6b40sm2461401wms.8.2024.02.21.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 04:48:16 -0800 (PST)
Date: Wed, 21 Feb 2024 13:48:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 06/13] tools: ynl: introduce attribute-replace
 for sub-message
Message-ID: <ZdXxDZIAM5iLlO55@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-7-jiri@resnulli.us>
 <20240219145204.48298295@kernel.org>
 <ZdRVS6mHLBQVwSMN@nanopsycho>
 <20240220181004.639af931@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220181004.639af931@kernel.org>

Wed, Feb 21, 2024 at 03:10:04AM CET, kuba@kernel.org wrote:
>On Tue, 20 Feb 2024 08:31:23 +0100 Jiri Pirko wrote:
>> >The "type agnostic" / generic style of devlink params and fmsg
>> >are contrary to YNL's direction and goals. YNL abstracts parsing  
>> 
>> True, but that's what we have. Similar to what we have in TC where
>> sub-messages are present, that is also against ynl's direction and
>> goals.
>
>But TC and ip-link are raw netlink, meaning genetlink-legacy remains
>fairly straightforward. BTW since we currently have full parity in C
>code gen adding this series will break build for tools/net/ynl.
>
>Plus ip-link is a really high value target. I had been pondering how 
>to solve it myself. There's probably a hundred different implementations
>out there of container management systems which spawn veths using odd
>hacks because "netlink is scary". Once I find the time to finish
>rtnetlink codegen we can replace all  the unholy libbpf netlink hacks
>with ynl, too.
>
>So at this stage I'd really like to focus YNL on language coverage
>(adding more codegens), packaging and usability polish, not extending
>the spec definitions to cover not-so-often used corner cases.
>Especially those which will barely benefit because they are in
>themselves built to be an abstraction.

That leaves devlink.yaml incomplete, which I'm not happy about. It is a
legacy, it should be covered by genetlink-legacy I believe.

To undestand you correctly, should I wait until codegen for raw netlink
is done and then to rebase-repost this? Or do you say this will never be
acceptable?

