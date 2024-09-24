Return-Path: <netdev+bounces-129476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C829984147
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C28BB23E39
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4621531D2;
	Tue, 24 Sep 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT4koGpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D8450EE;
	Tue, 24 Sep 2024 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168349; cv=none; b=o6ylv1nE4LAVlGG47l4nd6zB91iJ/FYKO0ghL4mKoyCztFONCc+/II3YcLFtlLsp8OXMbrPych/JZKQTW2i7QQ8m6qkuW7LE6R+fuxuMEN9B9nr7n9FWtc4v7ZeOvTgj0k/qAhB3OxrFVkSghJ7YbJS3B8wlRGPTmdzhf1b3pmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168349; c=relaxed/simple;
	bh=TIjiInp5pELDnkYGaFVJkVfflzwKq2DE0f+96DHTLk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QwVfVDwxzrTFr06R5jfr0RsQXV0d89A8wwD8jsG1/jOM5CxComMhDHmWEifAn8UpO4flMNH1mKKpxDI3hhc53vRZ158PhZylnifzB+RsIL0sM1lqDHXhdlWJg4H1ifAWpH+PV5pRnh8MQEspaVxk1bNj5lgBurGhH6NbGtCQ1II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT4koGpi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d446adf6eso815790266b.2;
        Tue, 24 Sep 2024 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727168346; x=1727773146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ucn6KFv4m2jyiQhnJ4UGLJJk1WxDrftqKLzug+YU3Y=;
        b=MT4koGpiujncNusH1zfK2fqMutV+4JUWj/bh+HwnW29Z7mgxKLEylcTjPeuOOqrWNW
         i+Xf7yL/F6gx1mJaRdnyc5LJNTYx4G11Ld2mQWGytZBGAPVLD8ipViP6Ut2nGfjjSajK
         K+P7d0yOhAykzMVW+Ffon1i63U5DoZxbw1YGQxAB17ACOtDfMDrnXXilj0o9CxtsJ0dF
         FvXQjOzs2FOZuchpKKXqsrSH3SqOIpmjN0F/xmalSIyGNGV3JdxsPEyzSdNdAjOu9aiz
         EwciC3lbS6jXqnzDliZ560pxrVVAimY9iCxWgJ5KnEFbIoRcZAwk5udZLNX8wmmCPWsp
         mrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168346; x=1727773146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ucn6KFv4m2jyiQhnJ4UGLJJk1WxDrftqKLzug+YU3Y=;
        b=W/ZhtUWsMYekIk68A58ZFVtOl25GgmL6XTwXfZFPWD+6neLjXx6dQD4Av3c/iVC2L3
         qVTDmPwkf7a2bYC2vTe23abla0QzPm7QLA1q51GONKnYq0nt0MfPbxVqm7nA4LNhtavw
         /9aeHGfBcLASMUFnEcOqmeCZBSNsc62DzJqVVIGHpVdd7v7E/SrZoIo2emP+o3TcfSY2
         Gto16mrCyEDepq8EhWOVKQhB1s2UDmh4YVHOwUfNOHiPgHeY3RKaURSf3m9s8mW22PFv
         4F9RqpbN3fRiVrHYQqoOEu9dgGtS+fbGnjFDaNiC8mep5IXH5xzqQOiya8cbSfzPomSz
         rfqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9HEChNyXuJym1XiJflLfjaUfPOuWZ2098mfrWKG+dlfve8QfcjU4yH6FzyNAY5FEPq/Mnam9m@vger.kernel.org, AJvYcCUKzlStRcinD5jFeHKMdATdyM/RKD143Eruv8PVS+IM5cc57MNuCORAAF1I3vONlp31ogF7+Rbhhyd3xoQs2ws=@vger.kernel.org, AJvYcCUeIf1uG5u6l8/QW2zrjzNunxOZDYM5+r66EivgmEke3xYj0GBFn2DoMKdiVEpApWta9TzYzN2QUYS4vfHW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EIk5338chVZXTRF1v8+RdijJAFErL81taeIsm9akoyOHgsNN
	aME9sPBID+d1p88E0njTFfBmwWigvEN9rkk+jf66b8mAnWl9cpt0
X-Google-Smtp-Source: AGHT+IG2GD4Ps2kGs66gbdB6nkTpqcOj+E1HD0+Yw+QRK3+ABgbkmvSyzJdE26kyah5Z5PQTO4bqrQ==
X-Received: by 2002:a17:907:7e9c:b0:a86:8b7b:7880 with SMTP id a640c23a62f3a-a90d512a4damr1616183366b.63.1727168346235;
        Tue, 24 Sep 2024 01:59:06 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a93930cacf4sm59798166b.142.2024.09.24.01.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:59:05 -0700 (PDT)
Message-ID: <34e0701a-0e61-470e-859c-29a06ec262f9@gmail.com>
Date: Tue, 24 Sep 2024 09:59:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tcp: Fix spelling mistake "emtpy" -> "empty"
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240924080545.1324962-1-colin.i.king@gmail.com>
 <CAL+tcoBmccFW1VVPQhG4=aLx8XwqAv=oR+VELBr3Zuwc=6BGfQ@mail.gmail.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <CAL+tcoBmccFW1VVPQhG4=aLx8XwqAv=oR+VELBr3Zuwc=6BGfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2024 09:55, Jason Xing wrote:
> On Tue, Sep 24, 2024 at 4:06 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>>
>> There is a spelling mistake in a WARN_ONCE message. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Is it supposed to be landed in net git? See the link below:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=c8770db2d544

I found the issue in linux-next this morning.

> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> Thanks.


