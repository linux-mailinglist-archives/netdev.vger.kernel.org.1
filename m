Return-Path: <netdev+bounces-180498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EF0A8183C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33A11BA30E9
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6592192F5;
	Tue,  8 Apr 2025 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+AKZKle"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D3801;
	Tue,  8 Apr 2025 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744149739; cv=none; b=GIdbdlyWgyTNFEYJokYzdk32BoImcd/uF4ZvuV3G3naQf1fIxPs1NIdlsXZw+bSopQRVsHsR3wF24JDWXJyDPGSLtopmblQVOK9WsP6wgy6tpsQFlGwdh+WJxFiIvRvSQPQR9GlLQq6wkFfSzlOEtLI0QYR9NCaUQPtWVvFo4To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744149739; c=relaxed/simple;
	bh=9lX8wh61BYIq6E4SXmVUNndEK6nzrq+wZuS8HRjbnA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vt0U2QxLc+kdlBt5zLweZLW9A2cGqSWZbRjCM4VS8PWktq6LeEL7ZxFXXusBb03LbQ9JQ+wxWuYiq3QecC2xWvFx9bHi5xNSzAiXULXnRlq8ABO7DRwJoxjcn8tc/UCQ+sWrT0b5tRAMn60fxtwwjrENACGMnWjDLRVIWtbFLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+AKZKle; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4996990b3a.3;
        Tue, 08 Apr 2025 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744149736; x=1744754536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CKLxdjoJBD9fIc5Dhkkx8uZiXNwOxA2THYRoD8HoSis=;
        b=T+AKZKleq8qIASX5nmEOaInRiAxEafoZc0PvpQFasy3MLKuN41UMl41Li7tSUeOYw5
         xiEYZxyQGpt1IuUN6qrGC4bNXSWuyEunMq0xb/d+BTyzll5lGmoMtqArxQCbbq3dVEsC
         wn1hAfpvQQF21Tx1kMdjYIt7nD3Or9xBny6366SK6zMESrzpYWGkRWQyvleowRfrN2Hg
         9N3iR5zRtiYn2buTHLle31tSVA6cU9fI+1bkcZeYoyd9rNJdqf+YvBgBjNeUZcJGtjqU
         RlWQT+YSgUY0fMBIVh3p+nqVW5kkW950CcwWfmwe4SLUxn56ARkvcv58u4YJ8FrsqqvZ
         0L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744149736; x=1744754536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKLxdjoJBD9fIc5Dhkkx8uZiXNwOxA2THYRoD8HoSis=;
        b=pKD6Bd5hkke8lfSRC7D7M390Ww+k5oVHAqJI6Nx9oiWC9iTXEtBxmdwVAXl66PI8EP
         zV77YLzMwPFixQNrbzlESBtzU74UkEpMxI6JWfavhbTGoVgmFHRMuRgP0krqA+slZLW2
         8Q+ZfJQ3Xq7yrwaYCYr+KZYbVoIfLhxEZDnV0nmTLeEgM1HsRj8Ppqt9e9UZifT5p8ZV
         LjJYKwJn1BLzoQQYfLVFRCJuyrPGMfNNTioFSHZW4rXxoiMe94DJnfVBzf4zZfgL6+r3
         Y1a1/egVbaO/fOGOdJxPzGkD4NvJJlxaCuLp4osE3HVmSAvoZNCGQIi85dHaIhr4BwWi
         NGOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsDlgW0LYFYSQS7l7TEkCwjP7FMhAV+8OZ+zKJGBcwCY0dIQ/BtBJpSlhGEuO0tb0a8JzgtcbcECmLsxg=@vger.kernel.org, AJvYcCWvY0soMXCwfUfFrUtxb6+M/kVFxPoaTliDw6N7/5Pntd3EtY4R8l8HI9uAPyM2nBDa24pett/7@vger.kernel.org
X-Gm-Message-State: AOJu0YySJo7TL68ZNViV6N4OGa9+ZwFKLqrA08/n6g3sukFGVEFEmZKK
	NeblyWVHtmZrMrkoVWOZJ3bQvwjcpcjLiOhclUMFJ/ozxXFDG8U=
X-Gm-Gg: ASbGncuaXbeyJe5BhdIdI2xVgCJazF9od+Pt9QdWHWTziTRnRx10SQNTxfu5jNFboN4
	q89thVi9gHzW/BwNOQhmftwcBXfQRqEXJxuRgKfGnfAjFp+hCzvxeM1p1DQ2GQlqSJ3cGu4ANRy
	g3hyrz/4rfmtegbXQMQ9q7xEqyKZdtRjon0SKuezs6Bm4CLyfhcY9EiKuMfLRUMJlCZljVXBRgp
	6JlvoD9fAdN3Eq5UVj0cRe4NKy8Jtb0d7dbhfKZjK6Y8A6YbhrcOnNZymaP/vpzm/f8pGdbtvff
	d7KKJRB1VGYadSL7h0cSpObHlaMslv2hhz9Lx8Cjqu5WvAa6oLBzw8sYVhlaPqq3V9pjqGpGcS4
	cCWuJ4wuzzhPXXIkStaLw
X-Google-Smtp-Source: AGHT+IG/kgNyg6qxRCHE/ao52Xup57eS+G5VAFerGvjti+r9yE7Rso5856iKNaa0+/lCxBkNE8xN7Q==
X-Received: by 2002:a05:6a00:21c1:b0:730:7600:aeab with SMTP id d2e1a72fcca58-73bae4d52admr645416b3a.13.1744149736478;
        Tue, 08 Apr 2025 15:02:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:f94c:8e92:7ff5:32bf? ([2620:10d:c090:500::4:98ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e371esm11166055b3a.168.2025.04.08.15.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 15:02:16 -0700 (PDT)
Message-ID: <b1d373d7-77e5-4341-a685-07a617935db5@gmail.com>
Date: Tue, 8 Apr 2025 15:02:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
To: Paul Fertser <fercerpav@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, npeacock@meta.com,
 akozlov@meta.com
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
 <Z/VqQVGI6oP5oEzB@home.paul.comp>
 <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>
 <Z/V2pCKe8N6Uxa0O@home.paul.comp>
Content-Language: en-US
From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
In-Reply-To: <Z/V2pCKe8N6Uxa0O@home.paul.comp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/2025 12:19 PM, Paul Fertser wrote:

> In other words, you're testing your code only with simulated data so
> there's no way to guarantee it's going to work on any real life
> hardware (as we know hardware doesn't always exactly match the specs)?
> That's unsettling. Please do mention it in the commit log, it's an
> essential point. Better yet, consider going a bit off-centre after the
> regular verification and do a control run on real hardware.
> 
> After all, that's what the code is for so if it all possible it's
> better to know if it does the actual job before merging (to avoid
> noise from follow-up patches like yours which fix something that never
> worked because it was never tested).

I would like to request a week's time to integrate a real hardware 
interface, which will enable me to test and demonstrate end-to-end 
results. This will also allow me to identify and address any additional 
issues that may arise during the testing process. Thank you for the 
feedback.

