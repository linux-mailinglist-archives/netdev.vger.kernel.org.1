Return-Path: <netdev+bounces-245230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC3CC94A7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A3FA301EF89
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 18:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD1D192B7D;
	Wed, 17 Dec 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRXtJYnK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58204CA6B
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765996067; cv=none; b=XYwQ0TgOSo6MJLttqC3A37fv2mlP4fjUh7/qDRFtYOAwRyTm2i7SaW57IAPeRFYa4+ZTqpdvEVjhkJUxROgzmeDAyrfYg3LDFurshAK3OWl6Z+8F5Yej1K8+SLes3BaCEWN9Fp5pNRP3IBLqml2KTzEPIDN/70gQJBE417KvgDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765996067; c=relaxed/simple;
	bh=qPtKRVfPDeDZcRP9JyAzm43jdZNoLMnJhd2EY9ptxFk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hRqMcJfLbK59J9IAyxwHHLPEutqOOOGptR83qu3MB4D1xIJDOM3cH524dDysTikb0mah8tKM3+//ne2DKfgaKrdXtsFGS5jZVo/9oRy0HEjFgUAXiZJw7/7VDKgGYbNvK9zPuhskbFyXtc3Gzk1wMF9o+0yzoSnQqK8AnPQOD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRXtJYnK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a09757004cso54693135ad.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 10:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765996065; x=1766600865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UpDNsYyJAdY8tME6rICBJv4nxpYRyPf1m3ZA8MX77XM=;
        b=BRXtJYnKasTox0bC/sFF6KBpIUO+BHlzJArhXomFpBJlU8MoYohBw+QATrrlw3B0tp
         lHcEoAhl466OfrvhIZr3km+p5pB+MbJ1W7pWK50jXZWU8ogLpArovlFPEGI0p/DAHZl7
         LpL0qu5aNB/GTHxYT6bSBg4x2kYSCWS09Dsa5w8zPs+c/IYEiGJZQEQ4QF3/nRiW8nem
         RnfCwnfi38yJTqEDBkUUgSGgNBY8ibyLmm+NDvHAgoqWAehIFHEqntJ5ZOTpR3F5awvL
         9Cql64WuMPaaFJCHMKsqzuADB/9pTz6c6CNS5EmVL7dDnup3iwZpU228fLfL82t4vCU3
         Xu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765996065; x=1766600865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpDNsYyJAdY8tME6rICBJv4nxpYRyPf1m3ZA8MX77XM=;
        b=i2HB6mD0h5eTVzNeMUez4T3l9rQpxJGaLG/mevSnZDj8lSsL964J1ehldtuNmPxKeA
         eI/qJV3kAVnzmhwdi48qqjR2I6DIIW6Onxo1HW1PgvX4HlyNrg9li1Yrscr2DIg7kDnn
         x2NlWawfjkzg2ayrGWdWSg4kcj4yIH2XruwEYbGOPyuSeG4DwiqMSPNPH7JFLGxEsZLM
         LO04ZWRRJbt1yAUdiOqLD3K6XR+zZJ2QNMDTD939HTj10tsih6e3ZBEhfXNdfAOSJ1z4
         NHBnffkYlNiRaloIqwmj/5sd0jGk6Ap0TBnBS8lBY1r/1VfNH3+/Aev7rKKZOAq8081M
         4/RA==
X-Forwarded-Encrypted: i=1; AJvYcCXxS64UM4tjn/X0UD0x36sL4xsariu4T1mbqC+UzbqmSN/9mXZs8fdAGuyM+dqXuyM04GNPwJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqkBjNqnSK1Z6FfJrWTna3ty8UPmv2T3cLVmD+qc/OhjC+6jJn
	skAvHpZkOdz04jFuFdJQDd1qzjbfrDHrhKt0htZzvhTtynYF1RZMmHQs
X-Gm-Gg: AY/fxX4Un4vbXuIZBpC0A15CunJKh3wookAZVIjptDRDqVXH/rf/MEOdzMYm8pFs0lF
	PQx57ma/8OXqpe9KtlHQTpjx+GkO0R57FeBO+MMmm7be/qIAwd7mLMQEIRmE30v6SB5kY7ScyaV
	jRp613rexkZVxnt4uq2Ipu9/0nNE92yI8Q2pJSv7MMvvWtINL+847LttxANyWLhC3Ldotdmt7YB
	AYcP7j55TcewMmdedzE27c9mY13uIrk9kHU2A7zUnucDElGoAGI6PLreSoN+xLVjmjOmHP1gHcY
	+Ol4fDqU5TNJyrK4/4QhDz0zvZxXNfxIkeLznDhbIPRZch0NXSG+MG5jl8a59EQDqiFvw9eaVYP
	eF58xrxVSfcXDl3dTlNi6gUtlmndQEu6vhd1uvueLm6s020TTonUSVPZFh+NR4/uFpLKRge7aUL
	unPdCvL2d0+YDs3iYcFaFl+8KWUN0Zkd5QEPYDzDLNsOD0dg4/JkZmeCbb
X-Google-Smtp-Source: AGHT+IG83zXgOyUDDiPeAEogQYxTiQGUHd5eYn2DFqqm2563GOsl7LKJxylc7dwIKvXWpTwcZrSnLQ==
X-Received: by 2002:a17:903:3c2b:b0:290:cd9c:1229 with SMTP id d9443c01a7336-29f23b514b1mr202499205ad.19.1765996065487;
        Wed, 17 Dec 2025 10:27:45 -0800 (PST)
Received: from ?IPV6:2405:201:2c:5868:983a:f063:84b1:a248? ([2405:201:2c:5868:983a:f063:84b1:a248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d089cf0bsm282365ad.40.2025.12.17.10.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Dec 2025 10:27:45 -0800 (PST)
Message-ID: <166583a8-272f-4e93-890e-3dabfa0b2390@gmail.com>
Date: Wed, 17 Dec 2025 23:57:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net/sched: Fix divide error in tabledist
From: Manas Ghandat <ghandatmanas@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: xiyou.wangcong@gmail.com, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com>
 <20251212171856.37cfb4dd@stephen-xps.local>
 <81d4181d-484a-458d-b0dd-e5d0a79f85d9@gmail.com>
Content-Language: en-US
In-Reply-To: <81d4181d-484a-458d-b0dd-e5d0a79f85d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Just a friendly reminder

On 12/12/25 20:47, Manas Ghandat wrote:
>
> On 12/12/25 13:48, Stephen Hemminger wrote:
>> The whole netem_in_tree check is problematic as well.
> Can you mention the issues. Maybe I can include that in my patch as well.
>> Your mail system is corrupting the patch.
> I will resend the patch.
>> Is this the same as earlier patch
> I have just moved the check before the values in qdisc are changed. 
> This would prevent the values being affected in case we bail out 
> taking the error path.

