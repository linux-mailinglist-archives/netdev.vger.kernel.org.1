Return-Path: <netdev+bounces-210571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AFEB13F42
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F7E3A86C1
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45A272E55;
	Mon, 28 Jul 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="QzqD0FZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E926CE1C
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718035; cv=none; b=YKtMD1kAtxWIRtQRikOuaZzfj0zhODStcz6giSKrpsq0afTpFFhxTg17fnHoBb1oAvh+StThzLHnbvo5fk0Z3iD7/gyCCaMohUC5d0GzEX9URpg5LkbpOrdKarr3cJVzyi0jmlTIJnvRRgRpBcX9G2I3Sl0VbfZq2buAnKfbq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718035; c=relaxed/simple;
	bh=Xb91t9iYll1tfZ8jj+Fe8p5aXdKrZAALX5hkvW1fTeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sgwakr0jsKTmJUPmc7zdvnpHoqkRh64Odud4wZxGSwa6aJFsyC2UI3qRZHAvBBA0EZC7bTK4dOzsCwkhENinSWZPSO5/ssu5710MvtrJsfzIe7l6nGuZchNym+FDMym5HhFMFp2SM1lhxKcThTHdSljS88QMXgXBVggKcWobrHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=QzqD0FZ5; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3df2dbe85d1so28946835ab.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1753718031; x=1754322831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vA75icUEqF0I65qQDsqS6NAJyE6+tfqsXQddj1T3hko=;
        b=QzqD0FZ5wI7lu2NkIvwIFmao1GeIhoz4wOYttjeBUAsUcda7XVBz6IY9FuMotXSTg0
         +dWZdLza1wPctsyj3wONWIxoxcOB4t/+kgcM/EyUbdAzl55urT49QT5ox4/WMcitwraM
         XIR5VqCNWiJMeN9Ur8xsgufuDFU8hLFRb2Q0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718031; x=1754322831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vA75icUEqF0I65qQDsqS6NAJyE6+tfqsXQddj1T3hko=;
        b=rZqkFmaPDRT4HSNbIOk3NCkeQxsgh9/UeMvu5Cx89IOQMfSvHzp1vMjXMUMZvJ3nbN
         HqRTn1+AvTax8hliTj7UyMD1BYOKr9wge4WR1aUUbW7UE4k+qgNSyyy1TNDR1oTusLEb
         JcwQNqH0eQ2FKzYyPA/rcWcpdBa23Vei1BRWPF88uMwhDJBzIlzWvt8k+SdIvb9vHLao
         45TElauYXAv8mboc5zT0Bp4io0VAZ+GWTqAg3dpeR6+u7dddhciMBKgnMK5g2vqzyXP2
         YIOr5bIpYa9j+LuHDvonUp6lFxqNnkAcjW88sf0tm65FfesKF5VTjM20QoL7xh+2lJzE
         AnZA==
X-Forwarded-Encrypted: i=1; AJvYcCXEzSS3s8MZcHNOeAYV1lQnuT764iVxJU98nlRbLIlOvlJy0FJvTPn/tkT8IVMexAq+sMyV+7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHJTOyCdjFNRQx0P+DG/m2t0KiCkoe5pfhZ3wXjN0zepbvqEOk
	+tneFaRIDSO7i/3EN1CsgJmTj1n6iew677CqSi2gp7949D/WFGgpzS6vXEEfHoO/Sg==
X-Gm-Gg: ASbGncsdgx+laXUNINgqY/l/J5RY+iSUWR7zXX+Fp2XryA3XUbUDTuHpllPH/l5ct1t
	dYIHE7+GdA7suMlMGwDreUMVNS/fhuE18sGt0dZ+8x8NPDb9+oQ8cbztS7SMe1AjoWNO5fAnrS9
	eIb9GBpo3l7BalnBSQJODI861mvrk4M2DuQzDkkAlPYdToxedRZNks2W5YD+5fbi0pqNU/4OvIy
	dBaHT7aS1egYuOXJvfdfurgZOceeXyIDOEnFgk59DNfTAI27xtPqh5fWOh6Y1SYZP+EDOHjkwUy
	h7dpsjfPrNzAUKOtu4I3A58+n096ZPPck+NAI28L7DHCRrCwuAR8CTB0tVWIrDf16W4pfMu1C9s
	vl4zpWtL4rHc2lAEgY2tP6AJwTgbOqY/XzZs6vIdH/UuusHqCnl0KqhR00/pZ/XSPrwBX
X-Google-Smtp-Source: AGHT+IHGlI/3Pe8bkFG3tVYCr16gw07/QecOHAd3MsLl8dDS47dIcL8tDHYDVZgzeq/TKMa3hlOSsw==
X-Received: by 2002:a05:6e02:3bc7:b0:3e2:9e61:433c with SMTP id e9e14a558f8ab-3e3c531061fmr180543925ab.15.1753718031332;
        Mon, 28 Jul 2025 08:53:51 -0700 (PDT)
Received: from [172.22.22.234] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-508c9341e79sm1953738173.61.2025.07.28.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 08:53:50 -0700 (PDT)
Message-ID: <e07f0407-84e1-4efa-868d-5853b7e9ab4e@ieee.org>
Date: Mon, 28 Jul 2025 10:53:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/25 3:35 AM, Luca Weiss wrote:
> Handle the case for v5.1 and v5.5 instead of returning "0.0".

This makes sense for IPA v5.5.

I have comments below, but I'll do this up front:

Reviewed-by: Alex Elder <elder@riscstar.com>

> Also reword the comment below since I don't see any evidence of such a
> check happening, and - since 5.5 has been missing - can happen.

You are correct.  Commit dfdd70e24e388 ("net: ipa: kill
ipa_version_supported()") removed the test that guaranteed
that the version would be good.  So your comment update
should have done then.

> Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/net/ipa/ipa_sysfs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
> index a59bd215494c9b7cbdd1f000d9f23e100c18ee1e..a53e9e6f6cdf50103e94e496fd06b55636ba02f4 100644
> --- a/drivers/net/ipa/ipa_sysfs.c
> +++ b/drivers/net/ipa/ipa_sysfs.c
> @@ -37,8 +37,12 @@ static const char *ipa_version_string(struct ipa *ipa)
>   		return "4.11";
>   	case IPA_VERSION_5_0:
>   		return "5.0";
> +	case IPA_VERSION_5_1:
> +		return "5.1";

IPA v5.1 is not actually supported yet, and this won't be
used until it is.  Only those platforms with compatible
strings defined in the ipa_match array in "ipa_main.c" will
probe successfully.

That said...  I guess it's OK to define this at the same time
things are added to enum ipa_version.  There are still too
many little things like this that need to be updated when a
new version is supported.

Thanks for the patch.

					-Alex

> +	case IPA_VERSION_5_5:
> +		return "5.5";
>   	default:
> -		return "0.0";	/* Won't happen (checked at probe time) */
> +		return "0.0";	/* Should not happen */
>   	}
>   }
>   
> 
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250728-ipa-5-1-5-5-version_string-a557dc8bd91a
> 
> Best regards,


