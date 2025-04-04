Return-Path: <netdev+bounces-179366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89909A7C1F0
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83857A6594
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797A120E33E;
	Fri,  4 Apr 2025 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="NGqS1xcI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE220A5E1
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785933; cv=none; b=Bn1Us6V5H7LJArqrFxAuS1+dv45K8dY3CK3NfyAbS93Cz3FkaqCN11Upb5eEtc2ym55XqWOSEZG5GoyB2+GV8tjAUokTqYWHdQ6jE91TYGFjaa72wzdkKOvZQFp1XaU/u5cXItLppEV4aSwKXct1f8Q85Rdn42Da4FCO3/ffBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785933; c=relaxed/simple;
	bh=Ryk5WIjRw1VQsX9OQIzuI6IEaYROeg3iHLSSvasUjtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc3qa9yL8GJFEKqif0Q4YU9bqo4EmU4TpFWaEs1rEb2X5/U952D3jE2MmJJeBhwKVAMFKIDCbiVgcPvkNt//jYY+nAaV2VNd/A3bvqpLg7BLi8jgx6OxhMvDZe+AQvXXZ3+/A+wfKbg2lRBFDxPn1O/abn+GMKOMSH5uyyH5pPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=NGqS1xcI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73972a54919so2188394b3a.3
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743785931; x=1744390731; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jE1bubZoXULGu9UfMX32Y9hEY3yMsnhFFEiTfpKpXGg=;
        b=NGqS1xcI4Z4jtKv5tn24RCZkgTSW2HQZduEdZqK0pqT8OwHAsDxLTjcnWOX4RnPwGr
         F7mEvM6X0fxvwmZU6OmYhsC81tNA/BEz8ZX5vx1N9egAP1gmEJBeQRHASyoxbsOc5wvj
         t5Bqjm2a1Gzksmp0OTOLo2xOoBaN9VEC8bWNpRJZaR5CaL2vaAE9uNtssuWZO2M0zw9x
         5AOEn3bFz/FWD5epLQTwCiI4kYu4gkWRZW9PPW0+efGpEQxY/nFHJlefBW9nTrYVSNqr
         KJDkb78EQUoYUZKcsmO99eUmmvpm5mAHGrvWZDGHfUx9QsI3dViTe9MXqrGB18iRU/LH
         gD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785931; x=1744390731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jE1bubZoXULGu9UfMX32Y9hEY3yMsnhFFEiTfpKpXGg=;
        b=l3J4ONpLy1YilL6obKdvHAQ/RUcd943KFjv9U5qy/4suqhP9yRG6Tn9i5E1o/YRox3
         L8ssL8JsufHp2g+ejg2mgxXiCKyM/Nj1a8b9HuKdu+He3a47pJ832KmMYwu/KN+RsEmH
         alpnt1aTYufsTsuX/rnxCbIfiySACL0OxSMZnmZh5T6QxiKI+tHpaGsRJTfddHSE8pk4
         6dFmbmmk6AH6inu4HZhkGkRIl+vhDOXRk4SQlNm6032rA9uxtlkmE6U9n5JOu1IyZDQT
         X67eVAEm6aJvsS4nq2dIdb4hctIKfBbOGTN26deuPH4enN0ivWaTWWMIL7ZJAHL2oM8U
         FrmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdOU+01iQ8QypWM6EYrWNSn/uLQrPlco8bxYH4H53qpI783HG0QaLZgVmUxt/VeldPPX9amOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsKynN0IkfYPJjX7vMBOmA+JBgcJTMR7Dw9tQRzVofOIj4JJtX
	qeQGXWF826lJcMxU1xunhInncA9YU44R/uR57OJ+BGb3gWz8Ww6uP6vSNaw+DQ==
X-Gm-Gg: ASbGncs2rCg/PF5WOMh+LTz9Wk8sdXdGqobLmO1IOHRSBCPIt035ig9imYN6xbCceng
	ndIwsz5dQAE4tFXgMcEBE31zX71/O7+de2Vv6CqAp+KX+K1Zm3RL+OhljBhi8KxJyG1FKSrDRld
	GVU+U2gvoqpVG33u21SAHXhQ0FT02jzVlD9Erbgr4Y6Qps2TUc8LomGNcuii6QUTAbjKISvdK6E
	E0of0lf4oEuIN1hrvpIutwmn3rv+mIXdtF1P3pD3TAZJbzmri0sVSDFdBsVWE9zP8ww8IPIE4RF
	US73Q+PELs83oZsa67bH8dOHkAez7MNo6SN6G6o7ivNEE+Spofyhr9D2hDB6R/G6b287B/OLQ+j
	ZuLB4hB5Jamoz+7U=
X-Google-Smtp-Source: AGHT+IHUMLPpMNo28KkZWpIR0t6dh14ZJ4QA4MkERKr/maCVgzJmWHdLkKRXP5Sg/AcSwwrabfAZMA==
X-Received: by 2002:a05:6a20:7349:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-2010817fb44mr4445122637.39.1743785931226;
        Fri, 04 Apr 2025 09:58:51 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0dedd4sm3603041b3a.166.2025.04.04.09.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:58:50 -0700 (PDT)
Message-ID: <aa2391a2-c1a9-4c48-957c-c3828ad28196@mojatatu.com>
Date: Fri, 4 Apr 2025 13:58:48 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 09/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with HFSC parent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, Pedro Tammela <pctammela@mojatatu.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-4-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250403211636.166257-4-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2025 18:16, Cong Wang wrote:
> Add a test case for FQ_CODEL with HFSC parent to verify packet drop
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

