Return-Path: <netdev+bounces-236259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC57FC3A6E1
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25CF9350C77
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0EE2C08BC;
	Thu,  6 Nov 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hMgrM2SV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWAkx2MJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5118CC13
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426907; cv=none; b=VzYQicEjwzZDt6fTgj0rbVN4Q4NjeZDvYdtKyQNfA5MtI4lR57ZYb6OgJAeFc2TXjDuEUiwcun7tOYJEdgHEBUKPzaT23/8NAKsC342eGbsLz6aqcliptFpye7GaqgivgZtYDBfF+VcaZukjz6hCnrXBxksSTM0NTJ0mNvo0ZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426907; c=relaxed/simple;
	bh=Dei5euvfk6aFAQ/MRNBfMjoeeHQCZRrQl8W9D/WrzU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lStgUMUHELMjjs8vkhsmxC48uVnK4WuLi/gfves0exCwUnEEnH1F8HTSt6LisdhffEUjnmg8U8ucbK2f5Uj5gt9jQ6SPB2eWRvXjF+dDXmzKjq8rrx1pQRpO2sIoZeMDJo4/TiQIrTKfulNrBurnTOZbMmGgpfYur3gmIvG2Hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hMgrM2SV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWAkx2MJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07X1DhUV2EUqxrRz0+TYJuq8bAIzOYbawmg2oVbO75k=;
	b=hMgrM2SVTyYYtjr4kDwtLfhUjjgg9QL72p8oYzGyjLkK262It4LYS5141P6N+MM9pLxXpN
	W3kW21BY8T7vWAWx0IRAdyzINI6wNF68mS+YgPW4ZTLmcVclosXken/t1rhR1YmQRwd1ih
	BjEfXZsSZ4OUvwIsGT7VtoevEjP3HMU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-7Kd7iHQdO-qMDJuvHUCLEw-1; Thu, 06 Nov 2025 06:01:44 -0500
X-MC-Unique: 7Kd7iHQdO-qMDJuvHUCLEw-1
X-Mimecast-MFC-AGG-ID: 7Kd7iHQdO-qMDJuvHUCLEw_1762426903
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso3727405e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 03:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762426903; x=1763031703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07X1DhUV2EUqxrRz0+TYJuq8bAIzOYbawmg2oVbO75k=;
        b=aWAkx2MJD0eCUyqTGZpxYU9hbFMcHcZ/vdNxbM+shEexTREhXuDjf9M4BnJFNYNrbg
         9nmxrPbO7lu7oLPyhXVM91baJP5UTHGOw5Kjr6j1qYQMi3IruoTexZO/bcbeGPB2U+rx
         K3jexjeasZcYiMozF07n+GQ0yaWMDHxWxrrl6BYYcE2CzbvazGpiAgeuMoDnyWlDGxSN
         5CRKkZpkCWYQd7FKxxJH+YqzqNuvmLoBIMasKxOZi1ZdHN/ZObfaVZ3FMHR2jNW/XG0X
         OdZ0bKEMxa7RNQSNu5v3LYrRhexsJ4Amjg0fmdZDAKEHK4bw9ErvztjUX1zizh4UGhSe
         XhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426903; x=1763031703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07X1DhUV2EUqxrRz0+TYJuq8bAIzOYbawmg2oVbO75k=;
        b=Y+QDO70D5ckE6wgcgdzs+FJAhrJHyRqt7Df+PS4ys1JkWWnc7lpHR+b5M1RFUcsT9H
         KoryJOWTwnhIUvQvhp2x/cbudrwm6oipngN73S2EBOkCmYaZPsxFrs4Mg78Gtknmea9F
         oGn+uMYETBn6zZV/EmMTaWwbvVlsKlfNf9anTf2eWTmuzigODSCGulwxq6CoIhm1LWJS
         0Z4OjYN8m26Ec4WMnkzxSPvY4oXgIVnJDMTM/wlDEHO89gLNjOYs804JEW/6LAq4skV1
         RhzjqOZTKjAVGROB/OkJAMQWKeWoVWMJd8C5AIA06dXN+hNIAtbIspBoNWwYUni9VoYH
         8vhg==
X-Forwarded-Encrypted: i=1; AJvYcCUUPbAhEStk/XYu3TFvwtwWfVHbVMHu2GyHNqp4fjl7jAogpuY+JwnB1TbpUG71MFP1R4zYQMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJugyFesGkf/0PbAeKRt7QIQXCXvD0oCYNxOaij9+eXqArXr7
	jMzTy9DV7YPH4Cc3Fs8zJR506eM+2j6hFzTojVBOnCB8KsGbGSqeI4GW5RL4/YNGHZQLjwfvllg
	6da53tiEcWjamXx0Q5q4s6brNEm1pFUAHqyjDcet12ru3+3W/jYKPItL6TA==
X-Gm-Gg: ASbGnct+S0KFewCxB8Wpn+wZ/9gf40jLVPnHtifYeBsHh1jrvC41kw37d4esjrsmqCN
	1G0UHlPDM12Ku2ev4n8zjI4PNjz2l01LqHkO3S3U4gRTqUxTYSpHq8obFhR5Gtbb/nXonAmTjbh
	JK1ao/SR8t/ikTrP/QP6/2JjqStptxChHp1URKxqv46y4+vTLdRbwmu/ceGE0aqcJzTN39cpNQ0
	Sv134n7tM4+FTCD2EO8AsDEBJIfCjaE3c7m1QwdZeRec4nyD59NcxKScoxM2scpL1XeNfyuMDqp
	4EuU1j5hf6Z9jlB/Yqx59MRbh0jzsC+JNKGHam90ssCmLRpWWhBd1/PWr+IxTogKs57g2n3gTWN
	mgQ==
X-Received: by 2002:a05:600c:46ce:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4775ce14b52mr58027535e9.29.1762426903194;
        Thu, 06 Nov 2025 03:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG430xjOAqRIvEcdMviVraV1j6ItaKaJ77q7yFj/XLjJ3thQ0llyl6gKxWQm4UuWaaKlMnvwg==
X-Received: by 2002:a05:600c:46ce:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-4775ce14b52mr58027105e9.29.1762426902622;
        Thu, 06 Nov 2025 03:01:42 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eead98d2sm2648165f8f.38.2025.11.06.03.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 03:01:42 -0800 (PST)
Message-ID: <8ad4ca21-5b81-415b-b16c-6cc4b668921c@redhat.com>
Date: Thu, 6 Nov 2025 12:01:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 02/14] gro: flushing when CWR is set
 negatively affects AccECN
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> As AccECN may keep CWR bit asserted due to different
> interpretation of the bit, flushing with GRO because of
> CWR may effectively disable GRO until AccECN counter
> field changes such that CWR-bit becomes 0.
> 
> There is no harm done from not immediately forwarding the
> CWR'ed segment with RFC3168 ECN.
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Please provide a test/update the existing one to cover this case or move
to a later series. Possibly both :)

/P


