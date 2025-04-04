Return-Path: <netdev+bounces-179365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A306AA7C1EE
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A803BA41F
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606F20E70F;
	Fri,  4 Apr 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1yZH7P4g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819A1F181F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785890; cv=none; b=f1MpmfgBbvzEvQ9De1fN/+F/oe5JhE4DwRrp4dq9rqR6l7Ow2h7xYp1CEk7RhJ77GDTRNuqz0DPo6cDWUX6Znb23Owxvhlhxw6MLD7ikebAd29jwWYH4XtUsSjK4HbrX/Y0UBCgRJhCfBiDeMupa3MfSOanVHgLF1GIqwj4XYXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785890; c=relaxed/simple;
	bh=0f4sIAwB/txu2+Y8aqKgm2n4KFXcEOR60Pr9wd9MbWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHf5otc01F+Wobb9bUqsIxQHFV6KP4O6GD87JsJ/zGrFYDd1oMVWXgJ8oMNvvoNFHn2lSdAIZ4mutvb30zO/Z1ju/4y59hutbsqhyNL42p9kNabCw0LvnoZTA8KwbPM7dAUtaLBuzOFlUyTUD5Z1zDxaYdmUY3ZOxjbjqhgfBY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1yZH7P4g; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736b350a22cso1989254b3a.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743785888; x=1744390688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4Xtf/uy6pUyPN0X11nFkGKiKsix5v+wUmZCvk1oqD8=;
        b=1yZH7P4gu8AVO1E24tQU1Ca5+HxYlQuoOD9tkn6OlS1/KGY/F2WwkJrsCUehbPB+Zf
         SYYwNVRsZOW7RmrzoK4/FMqn81/CE72Bfcc6+13GSnOMW5uK2x0P5qVGaibv3kaWf1Hw
         Wop3EAWemDo15oHwTVAG9ae4nPmNagz5UA/Vc1Wz4HfPg38idJnOuIMYLg1QWb2fibXC
         nCeIlQNiUruAs/2rvBR7x6LXqMzxLgzmZO34ln3gcPC2LVExNLXmxbaOERg680BMdV4P
         XiZ07Eilw1u2mwCt0EnIbbtIkkhRXPx9FWoVYUAfaiwDZApKEfLt+3cMQSauwiBFkd6q
         EKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785888; x=1744390688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Xtf/uy6pUyPN0X11nFkGKiKsix5v+wUmZCvk1oqD8=;
        b=ZtO3AuvLR8ZNdXPP1X9SFeHOaY/AEboVSicb928Mf4893+3KK3jaLf56ZFh1lY4nFY
         93bu6Cq3u2goxVOdubazJ6lX720p0B1V4CYeVm732QuFFTfBIWgBKAPxz+q4BMNSCSOy
         jaRYUgA8hcTXVZM0LjS5a8kuY1/xSL9Yhe8KkAhu6vlZVOHr9n85JEYDXHPjcUBfGyKj
         jd5Lid+Re8uuf4x9DNKhl2720K2Dosk0tJdd50V0jhE37I9xsWzW0F/Q/wIkV35OkVD9
         tyVu4bGxASECFi7a+ZT1KMSCFjc+r2gGC6SSw/c14iJulLuwdP1Z9X6H9QqUPmcDYipu
         gglA==
X-Forwarded-Encrypted: i=1; AJvYcCVFVYVTO/dZhWa5Lzm3Dfg8qjFw5YQZgWezjVLRZiNlonajhJB4eNYrH2JyCXRiUecCkEoJSIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMvCKpVoKrVaGHMu1nWj6NVE5hErYlK5Lk76H6oOZ9BuAXJ00
	MaYoLv3i1i+EXtB+rPInqaP46I4ilisBHU0SIvhhVCeUo2UJemJMWWoDo0TajA==
X-Gm-Gg: ASbGncvp3GgrtKEr6hVsyeAN8pw8tz8fpGgkPhc+hSDIVV946zM3d+iIlvJjHtx0W1s
	voZLSD/masJLhiVkeYy8JP11KRnfB0wsZGwxk1xHcYnXH1ApfaSWVIJWrvUnEYIIVBfWM23av5n
	nLd6DLus+KwgvHtj151aZD5fJ2lQywSADJEUH95E/Z1pF2JF4eMiY5YdF2+rXgTMiIyhNeCxux9
	Kug3vKZhuAdxQ5Q9F7iaSMJ7K/MoBQm3BPqE1iTyJXe4OJhmK6JV+YoqXcy5sYH9fgLMNxypW3/
	8l1ahTfr8KYBSG7c5w2g5pdNKKWqfLMuK7Y5EHkiGjbMa4gD0rCbLdwZvzcqLgL9G2tbqh0wxZP
	eNcd1Mjg2oksaF/M=
X-Google-Smtp-Source: AGHT+IFh74IzWtwPVl9j819LxAcNdkSl8OIHk2uahPV0zU62Uxtx640olCxrCld6HVTW6WtbIN/PNw==
X-Received: by 2002:a05:6a00:1743:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-739e48cf340mr5143184b3a.4.1743785888289;
        Fri, 04 Apr 2025 09:58:08 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9e9dcc6sm3726950b3a.99.2025.04.04.09.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:58:07 -0700 (PDT)
Message-ID: <0f0fd21a-b614-4423-a8a7-8f4ca3b1d411@mojatatu.com>
Date: Fri, 4 Apr 2025 13:58:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 08/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with QFQ parent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, Pedro Tammela <pctammela@mojatatu.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-3-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250403211636.166257-3-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2025 18:16, Cong Wang wrote:
> Add a test case for FQ_CODEL with QFQ parent to verify packet drop
> behavior when the queue becomes empty. This helps ensure proper
> notification mechanisms between qdiscs.
> 
> Note this is best-effort, it is hard to play with those parameters
> perfectly to always trigger ->qlen_notify().
> 
> Cc: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

