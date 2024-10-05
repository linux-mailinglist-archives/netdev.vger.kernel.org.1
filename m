Return-Path: <netdev+bounces-132330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89399141D
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 05:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D7C1C21F70
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 03:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5B1CF96;
	Sat,  5 Oct 2024 03:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrEKchw+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACEB231C96;
	Sat,  5 Oct 2024 03:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099550; cv=none; b=mZ9v8stazCHAsD03rhrb99mmA16ShLxohPDF3lBRTaxbp4UWZxIww8jtrwjSufpCg/ccIO0qclOoZe6Ks3BEbXT7FBtMuJn6ZEx73hPP/4BSpC35BPVO+o3XgShGZLX/OYMwKmHhz2nmU9DX2rZPw9kyUYQ5+do8zjieoxM9fNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099550; c=relaxed/simple;
	bh=pvkCD9iWnEkAGChK6GuaJzQ8FaFiYh3PsLGQkrVj4I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L50XHY1dqw6IjavzB8sdxvBPlkFaFipD+bJ7q009+Vpt8sIlbWffD0yg8gMoc7aAes1v42yEWaNH4Z9YEfTtQxSOn/b85HIQdsfEVFZoVymkPGjB4gcYsxhHBxXGME/PfoHgENJ1UD12+slwlzWMuyqfM1PS9NLgzZzkd40cC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrEKchw+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0be1afa85so2377677a91.1;
        Fri, 04 Oct 2024 20:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099548; x=1728704348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vbzHf6gUanNTvNz9KNy650clgBnTdNK8QyMOO1v8aDo=;
        b=TrEKchw+SmizOhm+geuq6P8sp8aHETdgipuIlDd8T1PbZFQKgyshfNe6wUQAkH2Iqk
         yK/ympl84zURNEi+Q+vTDMar8wsTMrm6xj++55vsAGF0vDeyr0i2Uh0L+lmYjir18TJJ
         UQwF1ObitBOiaJMkL92NMP431L9QhNwUV9/Yob7A+9PObRy+qMxh9BG00h3D5G1J2XFt
         rc/fkmF2w8OMhyDXvJWgu+u/wOrw6rAcOHCXma1wXAZu2aa4eo4d13nR3CUhIevI265g
         kuAIJ0T8e/oYK1ZtYSgkJArfLKHy7cxW11PY5JOvCjPiDo9VZmR4oij3d2tq/geyhm3k
         MbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099548; x=1728704348;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbzHf6gUanNTvNz9KNy650clgBnTdNK8QyMOO1v8aDo=;
        b=uWgSYCIgTtlQX24SF9uUu3ln6SCXSvaJbqUxhpKeJpKSv+NyXwpheRGb8NUzFZozWB
         0sJ7Xx1MoN9f7VJP15uvyH4SZxqgeKEItem9AT1q+8SHNFWYWmYt+1zi9/KmWz8QQ4vM
         MSrIe158O9cGEbE4VWEVeYtCzFFu9FWL+AjOHNehQrwSdxcyA6/RFMAPUk45Ml7qXODg
         2zzOb35s3VEpjJspHCFrUEb7ALW6rF/yyeaJlyZ/uaB9zTBOOpWuXkH8MNdbiBFV6E5c
         ccAXYi5iKHNPoigvfsBeyidS3scbZmr2xFS4XQ7P8d1Rtfl95WyaULAF25OG8Pw55Ezf
         yACA==
X-Forwarded-Encrypted: i=1; AJvYcCWTOC4cBjNYc5H3nZUQTEdan7haI2ivTR6KPoRu/Ju1jF8fzPSq1p7gOU/o7jZX8ru31X2EmUhI@vger.kernel.org, AJvYcCWzhZGi0KEkI7oyNNISODSpVKjjNZpzTyouwPE0/Z5e967tyLAGrWKGd8L94dWetyyHOSq/MgGu10xQRQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0V16g05T/914zUblPUO7fIfsWFvM4jZfRxcV79yeAkBFjRQN4
	pSbEw7IDdzogRHi9cO0erDitLHqv1lM/fPu09LLbmGIDFUZLwmKR
X-Google-Smtp-Source: AGHT+IEz2Oy9lWRL33m9iwpaPb0IY60UZZ8sB1N/i9Pg807+1LUke36vBJ6Dr+74rklRLDU0juHwBQ==
X-Received: by 2002:a17:90a:e593:b0:2c8:6bfa:bbf1 with SMTP id 98e67ed59e1d1-2e1e626bbd4mr6574861a91.23.1728099547990;
        Fri, 04 Oct 2024 20:39:07 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20af3f74fsm778290a91.25.2024.10.04.20.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 20:39:07 -0700 (PDT)
Message-ID: <b6467db1-d5d2-4c3b-92bf-b24c5d43afbc@gmail.com>
Date: Fri, 4 Oct 2024 20:39:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] net: dsa: b53: fix max MTU for BCM5325/BCM5365
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Murali Krishna Policharla <murali.policharla@broadcom.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
 <20241004-b53_jumbo_fixes-v1-3-ce1e54aa7b3c@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241004-b53_jumbo_fixes-v1-3-ce1e54aa7b3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/2024 1:47 AM, Jonas Gorski wrote:
> BCM5325/BCM5365 do not support jumbo frames, so we should not report a
> jumbo frame mtu for them. But they do support so called "oversized"
> frames up to 1536 bytes long by default, so report an appropriate MTU.
> 
> Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


