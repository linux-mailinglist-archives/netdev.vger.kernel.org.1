Return-Path: <netdev+bounces-143606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D239D9C3429
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 19:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7CD4B209C8
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215998615A;
	Sun, 10 Nov 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="AKOTukR/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1537D1E495
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731262455; cv=none; b=c7u7e4NosWqBmSuWWgD0AVt6FlMVJP8rghkSrKDkFCrNzA6XQjxzjZ7dNd8uPaJGeLX91Qe/Opk8MqOgRB3hd4uxZ9UTbb2qI1poFO/I3f0eaPPXpG/OoyOorzLOTZdQJ/kuzE6Ga5ILTcQFmAWl5EUQODEPnyoEXZ8DJyi5Gs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731262455; c=relaxed/simple;
	bh=sKnOMNt/BMKiknJkxM5fZccqGKVWNsCxg4YdCKR2K/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M26wFAxUJaZl0GvpVxeUg8xq0CkbfEzRnaY0U4lARW18/kNXEQVJowb1CvXaewPmJ0Esps33EOjjHza5ePUEoy6UOm6z5+phOEJZbE2W1cbk679gjtzGywUlcOJm8a54q8sssJ+flwkJ1XXvCXp36dCD/S65YgnDUwoPJgYru1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=AKOTukR/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-210e5369b7dso38924075ad.3
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 10:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731262452; x=1731867252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpENEPB6lVdal6P5++3dyts7KO+skOmG5gxIaWngtKI=;
        b=AKOTukR/4BXGsRDAwyFT56cPeuyCTlgplNvmsx3Thmib6KLk87abrNn72tj20aYZlN
         6ivNgDOl0WyzEc8BKsMQI5eOaGW5AIwJOUt7k2V+cqZanU/faq11yna4DvG+/LhXre2V
         Xx5W6SPvK7rRxgAwFhHhEQUnvtbsGOLyoN20/9PgiiPtl5uiMDLbhaeNIrP2g+elW20O
         llm13yxgNiUWSqfP1zCZ9y/1mICWonRCfkfZA3WRK8sMH0QjQZthOVNtXpIAgMjqCiBL
         Od7ueF33VJLmWPfSx2pzkbV8izzJ/c5R9p65es+sm1+AsH5Z1Mx5wVdiGuJ5xJzG7VDK
         emYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731262452; x=1731867252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpENEPB6lVdal6P5++3dyts7KO+skOmG5gxIaWngtKI=;
        b=KhUFvpb/TmUqiuV0hVCCsERJIGDOFrXPgi8t5FxN3GVIzw7eNUkurMToMV40ayJEv+
         Ndrl6Y4EU9BcRaE+GxZQ0mU9zy+3BpP0B+RJGr/U7xxY+r5Zb6bPZtZlBapHcCdsLbIx
         KNnymxNUC5Z+C+IE+1mz7keWUTj+0w3LTRrdVYyFZ/e0H33pkbVqR336v6sA0/9nVOSF
         hGih6EHRQDDjFGnHHBDjoWxkqKYqLZUTKv5DACjy1xEfN80agmBAIc8BHZSyvFWojP5A
         E0aZF25OKeD+L5frrI2BSGG9ZgtGv8xT5DVLuhCwCfmnBvzqg8SnoicWXa5BQH8pr9mW
         Y0YA==
X-Forwarded-Encrypted: i=1; AJvYcCWorZVyrEBOSQJvKMYeLw8kNFnRowkB5ZP94QNUFuZrf86IqJYUPLULqdyF4Lz0L/lQvD0EAe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf6dwZf0uEJdGxsPPQpLvUBJ/FPtvPRfYnUvjbGwpmwQZvw8zc
	+7PS2RWel5qoAeMSP4+MfsQNEpKlLP1+sPp/Z23XQFlqKjdXfiIi/3eMOEpLLA==
X-Google-Smtp-Source: AGHT+IHRaJnCGtmK1acKEgBJvygPSy9CXaAKbpN1bqRc18Z+0ClVmXpH1lfXLZKE/O5aebxIFvx51Q==
X-Received: by 2002:a17:902:ecc3:b0:20f:5443:9ec1 with SMTP id d9443c01a7336-21183d261bcmr122466225ad.33.1731262452309;
        Sun, 10 Nov 2024 10:14:12 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c0:14fa:2291:3c53:d9e7:ccaa? ([2804:7f1:e2c0:14fa:2291:3c53:d9e7:ccaa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf0f5sm62176345ad.79.2024.11.10.10.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 10:14:11 -0800 (PST)
Message-ID: <b5df8fb4-e093-4798-8644-fd0604d0d7fe@mojatatu.com>
Date: Sun, 10 Nov 2024 15:14:08 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v7] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 horms@kernel.org, alexandre.ferrieux@orange.com, netdev@vger.kernel.org
References: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/2024 14:28, Alexandre Ferrieux wrote:
> To generate hnode handles (in gen_new_htid()), u32 uses IDR and
> encodes the returned small integer into a structured 32-bit
> word. Unfortunately, at disposal time, the needed decoding
> is not done. As a result, idr_remove() fails, and the IDR
> fills up. Since its size is 2048, the following script ends up
> with "Filter already exists":
> 
>    tc filter add dev myve $FILTER1
>    tc filter add dev myve $FILTER2
>    for i in {1..2048}
>    do
>      echo $i
>      tc filter del dev myve $FILTER2
>      tc filter add dev myve $FILTER2
>    done
> 
> This patch adds the missing decoding logic for handles that
> deserve it.
> 
> Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter handles")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

Tested-by: Victor Nogueira <victor@mojatatu.com>

