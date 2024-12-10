Return-Path: <netdev+bounces-150613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928569EAEB4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818271619BD
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18D2080D0;
	Tue, 10 Dec 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJRiEXKK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E642080CB
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827826; cv=none; b=s0TYGmvPuy1jwY2E0dL+mOti7/eVMrTVCJHFIrGA4irO7hOIqObrXhItzgpIGcuupMP85JkE/bQS2hmphyBpkwpnJBTpWHbj4CBL9VKkqUKJj+XAouth3GvP9BWDcQ0vTQdVaI9zWKnIHoDQgCK9bcZU0aajWno789wrWE9XpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827826; c=relaxed/simple;
	bh=AGxc4FOqxWvQkMXbuX2SwxovNh89cnpk+hWbNKr5vYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gc7EhK3zvLCLQnhPpgT6b1WE/mRreSIqFilW+EYvf8UKsJqUAbJZiLM1dS/oxNDBsYJtpTeZklKCbB6JipQ4ixNrtHU/heMTLBpZuxKsi98XBlEmNFXOnMTYJqgeCetRnflOkPWDFS6dMkVxYK41tJNiTtVWGH2Dt4bjzrblQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJRiEXKK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733827823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLjV4FCC5KMBFZxVgM8bECFcOiBYaxVUJ4Y2Nlk8bos=;
	b=BJRiEXKKDG/r6jDLuzdKsoS1f+hy5EYbNyGKarsSr3d51sjYdfPCWTM0FbUbqKAdZI2X78
	nYC8L8rsREWSLj3pgqdgfZP2EY7lmf0KQ90A3x2Dgpv1V1/lFxmmJBL3FmB/ev8LupcxUy
	Q2WmhUtYVEyq9+wvp8Rs3xpP54AbmRc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-7OqSDuPDNvKn4njdp6dVOQ-1; Tue, 10 Dec 2024 05:50:21 -0500
X-MC-Unique: 7OqSDuPDNvKn4njdp6dVOQ-1
X-Mimecast-MFC-AGG-ID: 7OqSDuPDNvKn4njdp6dVOQ
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8edc021f9so69145486d6.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 02:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827820; x=1734432620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLjV4FCC5KMBFZxVgM8bECFcOiBYaxVUJ4Y2Nlk8bos=;
        b=ZktXtR5da87m2HLVQ3EmcHUVQVeVL9mxW8ylGVa9utfycnClIeVpJKodFMdb1JBdPh
         iOBjo+oMdsjneAPhL5YDiUrMZ/fyMV0oJQSpsXEwARlqfuORtG2LnUx7faovetBcw8PI
         SlZ20810Al9lGYDmfXXpop1UKIydXLKMZDBYdsMgtyPpAPwePVhTSE4aQVR9Y4zgA0xU
         LLwX+uxDGAaA6phyZQ0ECFk1bK2ESUVtQf4H+k7iBYP092LeAzYgunGzHkXLQvybUwKB
         okmlXo8ax6Saw9YH/WFTaEe1ObZimC6gREBbgzsZFWuG25pTeQzKs2sfhj8zoMpnOcCZ
         ONRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6D/V3crsxzn5I3dx8ofcj0KsLj68IrM5pXtR08h/H4elXCxU5uOJy7OowMQJJ48wShYjLnFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3cAeVjez+kknu5at92ZYHx0rq8z/9s/RaAzGgGUfJMA80bhwp
	b8gIN++OXb4KdcQMrmU+sgXQNQAmfnqfpm6ULMDAVRXeMwh26vPVXcW7ubd3fNKtY3PiUgcdBRG
	Jd3BnjFwmn90khxlsI5uF2vWjDDp3Up6N1cTUEi8iMi1jpwmyJCkGsaNIbS4dNg==
X-Gm-Gg: ASbGncusuTzDn3GFbt3w5AGcP4teZ26MmE3wxWnUjj+u1/E6IBzCA9Pr0yRr14jYZst
	zI4iPGb9cwIiwvkvKNQdxBRiMFh5g7j14waQI3dldyuQbJiO1u2LrZQoW2Bya/3siNP/2tXyif5
	w+B3AWoCEH4nbMjeQFJe+GULrnBGeFAHG50chLYL58DBf9OnCkfajExa7giJWCBjDFRcGiWcAiO
	2793yHLpiSUxZ5r0stmSXjfuDdcYWvGJklpGKkMg50C26Z1L+huEL3qleFAdumSCVnsB8VXPu17
	H+Uic+PmD0p9B20yKPT6/He4dg==
X-Received: by 2002:a05:6214:d83:b0:6d8:9cbf:d191 with SMTP id 6a1803df08f44-6d91e36f9bcmr63031736d6.12.1733827820662;
        Tue, 10 Dec 2024 02:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlCP/2tZMs4skY95xHL3aewUxCBSlUCxAB8SxRpHXz5hg4MuDJgFNGP6OdWrFKl/RKvZIOjA==
X-Received: by 2002:a05:6214:d83:b0:6d8:9cbf:d191 with SMTP id 6a1803df08f44-6d91e36f9bcmr63031526d6.12.1733827820402;
        Tue, 10 Dec 2024 02:50:20 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8dabfec80sm58426896d6.98.2024.12.10.02.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:50:19 -0800 (PST)
Message-ID: <a5fc946c-01b8-41b4-939d-6e509ead563f@redhat.com>
Date: Tue, 10 Dec 2024 11:50:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Do not invoke addrconf_verify_rtnl
 unnecessarily
To: Gilad Naaman <gnaaman@drivenets.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20241205171248.3958156-1-gnaaman@drivenets.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241205171248.3958156-1-gnaaman@drivenets.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 18:12, Gilad Naaman wrote:
> @@ -3090,8 +3100,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  		 */
>  		if (!(ifp->flags & (IFA_F_OPTIMISTIC | IFA_F_NODAD)))
>  			ipv6_ifa_notify(0, ifp);
> -		/*
> -		 * Note that section 3.1 of RFC 4429 indicates
> +		/* Note that section 3.1 of RFC 4429 indicates
>  		 * that the Optimistic flag should not be set for
>  		 * manually configured addresses
>  		 */

I almost forgot: the above looks like purely cosmetic/unrelated.
Additionally, the 'net' and 'net-next' tree are now accepting the
comment format you update above, see
82b8000c28b56b014ce52a1f1581bef4af148681.

Please drop this chunk.

Thanks,

Paolo


