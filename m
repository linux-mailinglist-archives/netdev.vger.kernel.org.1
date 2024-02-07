Return-Path: <netdev+bounces-69659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA6F84C1A2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7CB2B24BD7
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43B7320E;
	Wed,  7 Feb 2024 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkUpQ6fc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6D18F55
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267956; cv=none; b=YMyMkzJHWYAwdM9TQTULWAanXgTCkxX57Ie8Q17dT40poI/+A9iaRdcmfdmGbKMZ0fYfhJ6FlltojlCQR9yx7W01+8QXUuuDLkM+8HpEiD7D+FHSEeBqhIkcnlzKLxCN+koycCS7wFC8OmpCAg8XsOLDMQW3viqumN6UrxjBh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267956; c=relaxed/simple;
	bh=Ox2KBB3WTggOb9eB6E4z12sPWw6VzL9YeDa6+47kPnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhv3jDwWEhB4o9TjHgdod+F4w+ucUSNtB+nS2ruV2fS6OpStcdRmQYiV9zsTyQFNhE3EzWsnLqFvlnjtCN+iY+Xl1QhTsM3rIC8wkrbijBJwEpYcmimEHpxJvw2NQwobNCM9Wm1zl8eyR9pnjHv/WfzkjEbITSKTp0DTz5I2g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkUpQ6fc; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso5019039f.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 17:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707267954; x=1707872754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKY6VPXocjXHf9lpwTRdDpnP+2n9VhAQdM/0cZN0QJo=;
        b=WkUpQ6fcMBKgADjHXnW0jw0yJMlg3MJ6Zokq3imiSp6uAypGG/GauTzXo2q2dt8+Ic
         1qAQ8Bb3D5JfHjPemQZPIPercdP2r3Nfs5auPhpM/8+Woeq+eR3fEeHXrr5YtZ378RvZ
         2/PyVtnjW3Z8jOPMRUsSrnDJVO8B+KL59ASOE6OmKlnHtFhUKRMs+hnAxviBhO0SuuH3
         +c9MrR3ME9j/muFedp95t+ctdFeQsA/ubYHn6ls3hdrlyYbg49P1Z6P0sabWs2k5Bo7j
         rch7tdscLbkR8/h8N/zQ5av58jIY37ZhBoQjPxVjOWosJGYavSR9xWb47J4Akzp1eip7
         m69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707267954; x=1707872754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKY6VPXocjXHf9lpwTRdDpnP+2n9VhAQdM/0cZN0QJo=;
        b=he3P4z2q97A+lz2ASMyuBzmCabLU9eKt+hJySoBPkfLlvOkMRATJLskv9MXfs4bqLz
         mB9x9xCfV6b+RwFcur5wDqU7BTvX6cYw+NklQC1/WQcJwwCuiKVKJHrHP6cH8XXGG7lN
         tiM8590IpzEiepoTCCOpWHsbf1Q5irsmUHQ/WAtgW0RLjRKicVc4FeJc/589triQ0J8+
         JPkaaB3Hqkjb6aUohjaELAVGYsnDsPvEJ7Nsb72c7MMNL2M08K3bY1ATTBOeFa8n6XmC
         m3/UZDR2ZcsFMRR21zdyQNoMW7Z0tPFMdociOga/5luFuESiIVyJopZxaJ/iCO2K5tPk
         1+xQ==
X-Gm-Message-State: AOJu0YwxTDOJqGpGD6BMoz+JOdao5+NLV2jrLWssGywWDk1Xs/2O7n81
	H8u1WiRHv2zWHI9Ladiy/sjUvAQ/wRZyLfmkbk+SjlHybGtVaOzN
X-Google-Smtp-Source: AGHT+IHkHhy3ECha1ZetL9KskMK4m2soj3rkIvRU5DGU/QphwjF3u+liVg2PKoddalDfX3508DGBbg==
X-Received: by 2002:a5e:8b48:0:b0:7bf:5264:86b0 with SMTP id z8-20020a5e8b48000000b007bf526486b0mr5273995iom.11.1707267954131;
        Tue, 06 Feb 2024 17:05:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlWIQw9AvfWhWyZd9uZbXbN/yBOvWILHBJW2yVzzXRrYSyTz9Jkl6bmI6M5gZkKl/j5q9iF9023zimOeq/TUni68lUH9rTMd19UiN53zlHbJGToK7bDtmB82rMmmo=
Received: from ?IPV6:2601:282:1e82:2350:61cb:4663:414f:b991? ([2601:282:1e82:2350:61cb:4663:414f:b991])
        by smtp.googlemail.com with ESMTPSA id d15-20020a056602184f00b007c3eab82610sm19470ioi.21.2024.02.06.17.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 17:05:53 -0800 (PST)
Message-ID: <fa61cd41-a0ec-4b01-aa2e-577a1b15cef3@gmail.com>
Date: Tue, 6 Feb 2024 18:05:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2] ifstat: convert sprintf to snprintf
Content-Language: en-US
To: Denis Kirjanov <kirjanov@gmail.com>, stephen@networkplumber.org
Cc: netdev@vger.kernel.org, Denis Kirjanov <dkirjanov@suse.de>
References: <20240202093527.38376-1-dkirjanov@suse.de>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240202093527.38376-1-dkirjanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 2:35 AM, Denis Kirjanov wrote:
> @@ -893,7 +893,7 @@ int main(int argc, char *argv[])
>  
>  	sun.sun_family = AF_UNIX;
>  	sun.sun_path[0] = 0;
> -	sprintf(sun.sun_path+1, "ifstat%d", getuid());
> +	snprintf(sun.sun_path + 1, sizeof(sun.sun_path), "ifstat%d", getuid());

sizeof(sun.sun_path) - 1 since the start is +1?

and that is an odd path. Stephen do you know the origin of
"\0ifstat<uid>" for the path?

