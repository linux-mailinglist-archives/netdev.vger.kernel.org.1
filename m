Return-Path: <netdev+bounces-227652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ABCBB4DD1
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 20:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6BF16DA1A
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5FC272E72;
	Thu,  2 Oct 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8j098pX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0019D092
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428978; cv=none; b=gXVAsE34BVUW+U9Bm5n+o79GSFx3z+nmAN6zQeqIVs6kMfMRsQbqp+j/1Kt7gREOOCRN2ZBsNEjK1/h+b7si9XfTCfw9VLk4sgQJhnYM6s1nqUL45tTgL6DK9MHMHLUg0fpuEWPoAptKWdD7qKQQ+Hb1VHfCdebw8Sib7Zy7Nog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428978; c=relaxed/simple;
	bh=4YmZwmO4XwMMae10wjPLr2HjLNn/L0OMbiVlm4BdR0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ics5h5IpNn3dws4DX38gVqZ1IUA4E1JTkJGwXWpBdMhyr8jIU1AdVaBYg6qhi/E/niVX1c6CZMdjJL9xZeIDdu4VlCY9jgwR+I/mgu7xoy3QeP3gWjkq4JFLRVkwy1zUbtL6IahVexxhZ9C7vo2PafOgUKFo0BJNYo+H2kig8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8j098pX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781206cce18so1220623b3a.0
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 11:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759428976; x=1760033776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VF+CvHK7URWNIP0kSMuiSIpwM2BHFOP7f+E+Y/sQfjs=;
        b=C8j098pXF7klMrTrz9yV44OV8Zi5dvgRG6UiY/uqWnDf9i0mgFtN1SJbdTRTvCzIbr
         w/F4noSdCDHPccJKe1zlgXLCtOmIt5TKHNhUk14Jx7FlGiLhUO/7lKNYDzNOAlSnMzSD
         5EH5mFan/Et7tupG1m+GgpAR1FWCR37v9fiFUB8p4F8UBXpIOjP8ieHbfpQ1zA2qi5NY
         jO35B+JySg7EL6goux/9KxAAar0BcYeZBXNW7ofTvPCfQYnEfSkWjukEsEG/x2ySEhYa
         v0EswMz+DpYYXbV/qozIQm3sLpovFFI1KvGmCxUHN6gNmXczP6hI1h7efiNahG7zWv/U
         b3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428976; x=1760033776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VF+CvHK7URWNIP0kSMuiSIpwM2BHFOP7f+E+Y/sQfjs=;
        b=WmfAnAP4FZXtvolY4a79wbA/xmevDldgLhE2XcA/1M1v6LcI+WNcgpcB8kct6UwkjN
         NjGlCUkdxzcLeh/7Nvb5P7I+HYGgD23Bt29h/76+JUsRwSAHxgyqLjB0cxMXoAsSePb9
         Lws2N4C20h7KMgn21awr8O1MYPYK0nmp1aui0FnFraUTV5fhykwYXV899jKd5HXRsWcl
         OhrM0wfGQbmGjyomXefSyFy/NdLO+LOEx4wTHjhzYaaQSHiNZlH24xAP/R2Fkaid/GS6
         w9aXBZh1ZkZNSKMjVD088rSrAuMqaR5SveIqRZywwwJyWlqaS5ple3EBFzzMTZR56KRk
         IR3w==
X-Gm-Message-State: AOJu0YwRWvkIsQ8Dh/YqsB2VIZt1egjTM99k7I5Hm+ziaCpG9zuibBw0
	hduIt2FlavnIkDBwvkiDuRAKNCxYcwcLNCi0YR1X0+zsSCf1YARBVHVI
X-Gm-Gg: ASbGncsjnfIIjBqZjQEmYIGoNDrb6DCKecjf+jsZ/LZZf5oIRYAmJwYmxRuzXf6Gwzr
	GPreMu6GQwrPqaVnE8GoCNJ6EyAce7n/F/A98TmsAfILaVA583BqIyGxTZ80GJdhco5sthBr5zr
	e5eKmBSQAxZr7W3tp8j2+BEeiR871VZ/tiMPVVZAu6ImlEYr+uLAnT+NnacnA6o5OE20Jk+DpMk
	vcoZ57mk2iCFbL+ycFqFgYpM8zQclkTB5htgmVyAbvJ42rJdfexMwM8Ihvmc2Jltd1Vj54xxZRB
	fnkt8za/LYKxnA5wSs779rXjZnBbvnOdLp1v0wMWI/DHN2zgC6aOfrcpVLZs0mwRVOd179JPq77
	6sSJBOEKkEPbIp8Q7qFnCo0BPIg8Lr9GFmJh4zLI3QeIQwPEeHdhUWIX+93wHIwpl5uSKJ2nYVY
	8XrSrFDfqhYSlD6OzeUeOMTbSt3qEX7/L31983PYzW
X-Google-Smtp-Source: AGHT+IHi9qKe0dRoWi/HCWslCFgdh7SX1EtOtW6BApAnRGoaKQicfZiuKWnmXfAzWTM0GaLuO12Hig==
X-Received: by 2002:a05:6a20:7f96:b0:243:c287:5371 with SMTP id adf61e73a8af0-32b61b4e11amr458401637.8.1759428975570;
        Thu, 02 Oct 2025 11:16:15 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:18a8:fb93:2a37:6634? ([2620:10d:c090:500::5:4ff3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099af38a2sm2494304a12.11.2025.10.02.11.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 11:16:15 -0700 (PDT)
Message-ID: <34901d4b-0fa9-4a86-b8b1-9c9dc5ed0e2e@gmail.com>
Date: Thu, 2 Oct 2025 11:16:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: Kriish Sharma <kriish.sharma2006@gmail.com>, khc@pm.waw.pl,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <20251002180541.1375151-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/2/25 11:05 AM, Kriish Sharma wrote:

> Fixes warnings observed during compilation with -Wformat-overflow:
>
> drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
> drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Introduce local variable `pname` and fallback to "unknown" if proto_name(pid)
> returns NULL.
>
> Fixes: 262858079afd ("Add linux-next specific files for 20250926")
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
>  drivers/net/wan/hdlc_ppp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
> index 7496a2e9a282..f3b3fa8d46fd 100644
> --- a/drivers/net/wan/hdlc_ppp.c
> +++ b/drivers/net/wan/hdlc_ppp.c
> @@ -339,7 +339,9 @@ static void ppp_cp_event(struct net_device *dev, u16 pid, u16 event, u8 code,
>  		ppp_tx_cp(dev, pid, CP_CODE_REJ, ++ppp->seq, len, data);
>  
>  	if (old_state != OPENED && proto->state == OPENED) {
> -		netdev_info(dev, "%s up\n", proto_name(pid));
> +		const char *pname = proto_name(pid);
> +
> +		netdev_info(dev, "%s up\n", pname ? pname : "unknown");
>  		if (pid == PID_LCP) {
>  			netif_dormant_off(dev);
>  			ppp_cp_event(dev, PID_IPCP, START, 0, 0, 0, NULL);
> @@ -350,7 +352,9 @@ static void ppp_cp_event(struct net_device *dev, u16 pid, u16 event, u8 code,
>  		}
>  	}
>  	if (old_state == OPENED && proto->state != OPENED) {
> -		netdev_info(dev, "%s down\n", proto_name(pid));
> +		const char *pname = proto_name(pid);
> +
> +		netdev_info(dev, "%s down\n", pname ? pname : "unknown");
>  		if (pid == PID_LCP) {
>  			netif_dormant_on(dev);
>  			ppp_cp_event(dev, PID_IPCP, STOP, 0, 0, 0, NULL);
Would it be better to return "unknown" in proto_name()'s default case?

