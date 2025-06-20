Return-Path: <netdev+bounces-199811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6146AE1DF3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB52A7A6CCE
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C6A2BD5B2;
	Fri, 20 Jun 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="O8IT+yNh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1613790B
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750431422; cv=none; b=mUGW1QjlLUqOKojTWcV69gdnBd/mnR+7lF/aH+GXGxSbcEkBQNXzVxjo7hyHwYI3nXLHHcGSVPa5vbYxlxLSbkk5R+LNcra7XVWhEqq9UJb4v4e8OgjcEfzrInnoVrM5t+Lnbm5ftkJIciWnccDQmyffGC4Bc+zjuDOgGOcP7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750431422; c=relaxed/simple;
	bh=UseziiCFNy+6P/49OnpQlZKqenk+TswbIb3kp9EixEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WoaAIvi9S3vh9p6jWJQ6Bhca9CmS96Uo1QxvhLm3h5JuwpxGPTwP5VA//3ebFwRoDHvHH9jtk/7X91pvyXQBlWmJIwSsmgLg5BdN1Ruq51Lg7hNx7PkFoYXkhAtXMKVaLfTHfp8hCOMBjw+vVHlxk20Z78sfH/66dE6HllZTKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=O8IT+yNh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45364971d62so151355e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750431418; x=1751036218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hfXj34P2pf/AINloebXhcz0Fw0+WqnZX50sWt1njJSc=;
        b=O8IT+yNh3SOE6XWHhSK7wBx3TYzVa4tQcCf9r5wINQjow85c1VnvUkIwIltjSifFMW
         4D31n2DQZrSQ5xCgioiPro2IsQK5K+uYSukoaFj8bo5R+dSOdLJSSaaiUMVcXjz/enjP
         KbGX6G0+zKti3jkPH1EJk2EZpxS0NQecw69VWK0ery8WjkzWHESzSseeiX0jakerytwn
         OofJ/sPy0cp4EhWsTRiCW0YlMKoSKnc0TqlG4fwVQevjBxKnVEUVvtABq0tdeTU2qKU/
         vNyxj1TZX1y3o9fRAJVx5s2yeXywj0+/JPQqnnsJX1q7gCVtG1mPLDMw1q+Lj6/EmZzC
         rL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750431418; x=1751036218;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfXj34P2pf/AINloebXhcz0Fw0+WqnZX50sWt1njJSc=;
        b=ARkT4oVTLyfc38m7wKNJS5DHlLu9uH770FnzvCp6grKb7kzGFc9ybiCH50IcJ2kncA
         heGT/GyMUlQs7M+q84CSGa78xo0zBDJGX4XNDIRBwBK9aUv2u4xtmnu0T4yDvUBlUnMo
         XX5cKxnBqE+S9quP718jOP3BodjpEJtbkwDd/uroYiabdRsmBZlzIP2+h3rICXyty/Vw
         dtEXyiqwDkyqWcR89ucivglO1QWt7R4t4gGqAbQ5nHtBNZz0kgQWrng3zIF1R8uUQWa6
         Pjcm32bCZzS8NAviq6VZpOERLtB4Dqg2iqYd6BQ+V5H4BUoGQhLOjBCus3h0BjVAJurN
         dHTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWVbXx5+vpFPLIS/la3Vqf5vriP/y/3Y7u715Sv6mXOTYErFABFCTB9hdPQ9plkT9rjl0HGIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWEPgP3i7/VdrcvIFAvoIaCd7m2j60F7uguTmxAL7HALOBMKy
	RgM+xEcqMkRLw8AJWjiJhv4pZy7FtWipbWsHKlPVl5L7L1HdmUxniwR73YsdizqWhgM=
X-Gm-Gg: ASbGncuzOY6MXyQNxKnu+n2K65sg3WusNXamQYpOwaKc+6n+oJpZ61IMxEQAxcNsef2
	5Mf5D4dnyl0LuxPRC4LvgFBJmqABOflf2La+ku1XrRCSqdWW4h86bZGIaECC27UQ5KdNN759TJQ
	DsMux9DbPDAQu7r5ohmi6PHoY2KdxSm3UIzjcgVdLNGLdX81oARHO/Mk2/1HmDM+u+LiLUmvph4
	UtT8xASALQvvTHCx78xqmkdhdWOGVvAQFxVx0GA8hCpirUVYltAMdRsKfQ/1gT4r5gS3Zul7bKD
	nEGXD4hgZ2J6WwnI+I2lY7tpzns/BYzRiPtGfX7kLyGNF6D1desJ0U5uoDoWFDnkaAWdn5ttU8h
	Fx424iD+1A4BJoqcTQGZrem6p4r/S1O0b5YRw
X-Google-Smtp-Source: AGHT+IGRhTkUi7vAG1Nq5lQnyde1wdkbLDOGPyXB6FB4LNEfzmGXi2FxRcSC8seRuwQdvmccY9uIBQ==
X-Received: by 2002:a05:600c:c093:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-453654cdbe0mr8598985e9.3.1750431418440;
        Fri, 20 Jun 2025 07:56:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:607e:36cd:ae85:b10? ([2a01:e0a:b41:c160:607e:36cd:ae85:b10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4536470371csm27694975e9.30.2025.06.20.07.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 07:56:57 -0700 (PDT)
Message-ID: <2211ec87-b794-4d74-9d3d-0c54f166efde@6wind.com>
Date: Fri, 20 Jun 2025 16:56:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: When routed to VRF, NF _output_ hook is run unexpectedly
To: Eugene Crosser <crosser@average.org>, netdev@vger.kernel.org
Cc: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 David Ahern <dsahern@kernel.org>, Florian Westphal <fw@strlen.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>
References: <f55f7161-7ddc-46d1-844e-0f6e92b06dda@average.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <f55f7161-7ddc-46d1-844e-0f6e92b06dda@average.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/06/2025 à 15:38, Eugene Crosser a écrit :
> Hello!
Hello,

> 
> It is possible, and very useful, to implement "two-stage routing" by
> installing a route that points to a VRF device:
> 
>     ip link add vrfNNN type vrf table NNN
>     ...
>     ip route add xxxxx/yy dev vrfNNN
> 
> however this causes surprising behaviour with relation to netfilter
> hooks. Namely, packets taking such path traverse _output_ nftables
> chain, with conntracking information reset. So, for example, even
> when "notrack" has been set in the prerouting chain, conntrack entries
> will still be created. Script attached below demonstrates this behaviour.
You can have a look to this commit to better understand this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8c9c296adfae9

Regards,
Nicolas

