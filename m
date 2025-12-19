Return-Path: <netdev+bounces-245499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 889EBCCF261
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66AF830688E9
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED094239594;
	Fri, 19 Dec 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0rOmAAm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcLKwCIA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD41391
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136656; cv=none; b=d8i4cJFqQue9mwmVKAdoPINzmmpn9nh0PIsKrqmoNYJSfVUa0CdZKQJ8IhDN1xQQX7RRErb8YV35T6pyaftKaBzk449rymE35is07xp2Aj5Dk8kt8EMxcZUOCkiXBmj+XlUYDHSZ7w+eYsPHFQwjc70xlJUNEZcj4bGXf06n+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136656; c=relaxed/simple;
	bh=LOsmu5nw+TahYlZDOACpyZ4jhQG71BppJRA0YdPFl+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FMduolbF3c91cZ2inbYqggHgNWaDKllrkur4LBAzQWptg2TxGBtBLSxO3Wm+zXmmXtV7fTp9OzqRZCbo/zrHLQ7X9Jy+4pDZUSBo/ECtplZPx6QeSTTYIdpu6TsLaY1yJpQ6cnHCaDlIy1eFCQ6n6+mfSjuLfs48pq5JGoxAMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0rOmAAm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcLKwCIA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766136654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RhJ17mGs0UMlPJdLNR9V93gzR5chywtHvsBiM+UNIQw=;
	b=K0rOmAAmoAUL0V0PeEGhVNNorFtRyHTZ4U9wFN6VfonjGSIRDPlv6dvA3qUXmbyrspgl/D
	r9phkr+ciAF9qiPwEVNL1r7acsSBBP42B8aJmQV/tZ5gPHZjT3HiPWgKQBMTDFqArD/V1Q
	CKZCWm4R1lQF150EDsazxWG7HCWTSxM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-trp2vRYXP2yGCoSKCdyYHQ-1; Fri, 19 Dec 2025 04:30:52 -0500
X-MC-Unique: trp2vRYXP2yGCoSKCdyYHQ-1
X-Mimecast-MFC-AGG-ID: trp2vRYXP2yGCoSKCdyYHQ_1766136652
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so10369785e9.3
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766136651; x=1766741451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RhJ17mGs0UMlPJdLNR9V93gzR5chywtHvsBiM+UNIQw=;
        b=LcLKwCIAdV+5ja5wTtMi/QLl0wHXhAFpUjaOxU+9t2jTuKXmxv3EKvpTayc4/Sxbyc
         NV65KUF2cbdoKTNSjAFvj+CBL7Jik1g8J1zVubBm/cgJsI8R/lZW7q5JGyprdj3kG2K1
         IXID7+3H5ORmlzCjfrA1jkyaVXkSo9FQ09w17BmxlTx1meJHUmO8aax0N0p1iaInLvId
         b5N32N5F/wSVTJ3bjHo1lNEo5p8+Hf+AhuLSvF/R5SoekdMRD5L2thGFToWGRRrjCual
         fpxY1ZjShRq+qArDEmXrPlfS+y838bB3p3YLTTwO+7pGAuhKzE/nDshHVxU+15FKfqa8
         lzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766136651; x=1766741451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhJ17mGs0UMlPJdLNR9V93gzR5chywtHvsBiM+UNIQw=;
        b=GF+QHn7atkn5e2UTlFrG7IFHGFMQo8vS2uC3UYJYuYCnyxnzsQ07OX5+MrNOUXQOZ0
         xzeIFJR9iaFnNzxAR/bl/iMohWYLKP31aSHJNuANnzlWOTf0fsVwXwbWq5uwfwMKIW01
         8k0JgEwcgpLLxGn9tz481oESmJtAGSdO4E0xjv2DAA8KTcW2O5qtVOF5Ap4hW+tPtsfb
         FsYgfk1600lBVFjeMQ4Sxa0D2patXIzXnJvGwKTOj5lSPm/UsCokU9kp/3lSdVK9xdDM
         WMA3VXlXMpscmWM0khABBGWOEO5wfPJ2bgEpTrA6cOPbZVpHYLRbrOH42sCaxVruXa/n
         DVTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVijRwoMwwmyybIY/ccZv+ASND4zmlLJ94WuHR4ZmWa6z3FOWwo7D3e5UrPZ5bKUyoxbuznJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOU56EPj1PrZF5KIMhn8V2UU3FvUONXmHuXBTfz1M1eio5SOv
	fHavqyxD6aCGtfN+H1wLHasQpdob5DCnOFvlu1aeI8TUuGuYQLnBKPSdRQJKIhLMuQTIuRmBfoD
	PABoEde+cN+CfgS6WlyI3Z6qj1haAfWb0+n47HGUuf8XcYHUp5fbc8TIURg==
X-Gm-Gg: AY/fxX4elOFg6kZMnytU9u6hG6WOI2ieQ4veiawrlh/C5rkDvdOS+wLrAFLqQ06F1Tj
	N76JA/FAp/LIuA8OqbqaRzIeUl4jujiB9Hvqmh1/xrdY3/OlN3AhrqjVVI2u87Kz9zMGrbix8qZ
	Mbkl0S3YVRVdVI+q/J2ywU9Y9Z3fRpVCxdQKh0kSEwqq6Le7o5s2E3mHDtA//iFtl8Jrll3D8cK
	VJh6GV800k8m4ffI4Ej9e13/eGziEG6XEfcWCduvFc6GKSZzVtl7bTfS3xYhQbmfZAg5DWY1qi/
	4xEwc+XQhKSaehqA76TlLlCBWwHbtfEVzGmKlPvFMdQZHfCiAN101sZBuHH/xUr0ohfDLn6WDoi
	NDjYpoI5bI5K8
X-Received: by 2002:a05:600c:4fd4:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-47d1955b744mr18297425e9.6.1766136651496;
        Fri, 19 Dec 2025 01:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxfESphrT6ZAoSAcAy7SabUQtuWs9ZKQBFPxGmBKkh76kf8bW3dFyAXWDkDWrPXTMsmhQn4g==
X-Received: by 2002:a05:600c:4fd4:b0:477:7bca:8b34 with SMTP id 5b1f17b1804b1-47d1955b744mr18297165e9.6.1766136651099;
        Fri, 19 Dec 2025 01:30:51 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3bbe1c8sm31265465e9.11.2025.12.19.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:30:50 -0800 (PST)
Message-ID: <12b2e464-04d9-4f43-80d8-8a9f7fa8ef83@redhat.com>
Date: Fri, 19 Dec 2025 10:30:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: clarify tcp_congestion_ops functions
 comments
To: Daniel Sedlak <daniel.sedlak@cdn77.com>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20251218105819.63906-1-daniel.sedlak@cdn77.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218105819.63906-1-daniel.sedlak@cdn77.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 11:58 AM, Daniel Sedlak wrote:
> The optional/required hints in the tcp_congestion_ops are information
> for the user of this interface to signalize its importance when
> implementing these functions.
> 
> However, cong_avoid comment incorrectly tells that it is required.
> For example the BBR does not implement this function, thus mark it as
> an optional.
> 
> In addition, min_tso_segs has not had any comment optional/required
> hints. So mark it as optional since it is used only in BBR.
> 
> Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.


