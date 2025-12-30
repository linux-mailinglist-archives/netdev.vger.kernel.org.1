Return-Path: <netdev+bounces-246348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6BCCE9819
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD4583019185
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A592E6CD9;
	Tue, 30 Dec 2025 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvYQO0Rn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lQKm+L4X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4E1EEE6
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767092932; cv=none; b=gbgSZf/OgV1xpOFf2+K94AxrbomZTTzX37LEwSn11ikHO5iu/GAbAdfUmhE9PKju+y2JYllrnUcL34qqiY0f3s38RIl7TvGCd0uOcEMItaKjA/9FsznUADnDRr7X1rAqan4+aqoP2z8sjKayEWgkp779LiV9/IDQ1waTrmesnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767092932; c=relaxed/simple;
	bh=7WV1PZwRg8d86JRoDSV9VFcy4y30d3R/nzioVeXQIYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaDkE9Cw1K+IxF6IKyZRR/j1GN7cOWM075ODqSkKdMbAeSjeAsZ689Jka4SxBpAvIDjbt2kUCVQULTgnwdkKd2RuEZdfh3vvg5X4QQrpB+398Osb6dOMN7unxLkK0b8JjPanF4qQSqzZxmmSf06OJ7Bx3yzQQE8hJ6s3F+3NTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvYQO0Rn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lQKm+L4X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767092928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbpyEXxO7AQ8ncQp3gMzfo3NBZfU4UPQDsE56wXQgSw=;
	b=WvYQO0Rnwkse+xnNE+ITLZg+3WTMlTrJO4ES95wv4g+IDpzB2MGS/G/wDDXergpc4ZvO86
	HqvF/ZmCVqPOpdaWHf78jKemQzcrM81csFIlYb0+9cvxLRmMslJCEZlurzSeKk28uLBRmQ
	cV/pdrd7cp4ozJFHnkCUdHySUQ+SYVw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-tjsyXUazMoijh8Lds3u1EQ-1; Tue, 30 Dec 2025 06:08:47 -0500
X-MC-Unique: tjsyXUazMoijh8Lds3u1EQ-1
X-Mimecast-MFC-AGG-ID: tjsyXUazMoijh8Lds3u1EQ_1767092926
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430fcf10287so6913213f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767092926; x=1767697726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbpyEXxO7AQ8ncQp3gMzfo3NBZfU4UPQDsE56wXQgSw=;
        b=lQKm+L4XrxaXqGagxLQ0wM6F3SLsJUo4KTIHo9tw3XZjvItWfTED9pIFFcW1ddBZrh
         9Gn0o2NWANQ3RZgmR5JuF0zlulFeeJhxB5r6GubxJ+VblMkon8NI8zCRGEH1Rh7L1uph
         LBPs+ZXWo1nKNQwfsTpYWbL6iRYTG3UNg0PNUtLo7R864cn1mYLijOQkQxLZWtvoAjai
         iLmqTr9+rKbge5JeknpAEZV3OtpDXLNLwSTxToRZTI0ttsd55BrP4EKYDXea34pPKXtW
         6uJnyoNeLk1koQCNqQgJDMuTRD1AelH5ZOCdqstEQHq+VjUOr8G9tCYGHNHvj0a8dyNH
         H3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767092926; x=1767697726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbpyEXxO7AQ8ncQp3gMzfo3NBZfU4UPQDsE56wXQgSw=;
        b=BivaFd3UcNSf3gnAsAMDLQ2r0mZl0Bcdsc2lq4qtcKZ8XgbxN4QF+2ioFDsF10sXPK
         TXpwvl9qCZ5/34hzC4nmXze/J6WzmLgCyE9J+WQXHHMDa8x8lkBVmQGBLGvctnfkNBO9
         0As7nO6fC/deNXvtxDYp5w6PiTD+BtwKAMvyAUkq4fSsa7ORbVlA8PaJCrNsUTDwwxEe
         Yl6Hcky12Q0EIEkmEXxKXE8XLSCjUNrpppv2OqYPvsk2oxtkc+u7kGi+Sq11VP+TnZnz
         txEp47s76flqrw4ZkF7PKLaXDAEGfZHT/EeF8EOiQCdFc1ANybLm8ek9jzcIBpZmU6Ey
         vBGg==
X-Forwarded-Encrypted: i=1; AJvYcCWBzIKhGgw3G41lBw2JRU/QFEcX5/wU+6auMzGbAKuTsQGzr7L9fA0TjIjGtckTTQTRPsX4NJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyESeFd8F6NgCavWo9IqGzDJf09La2RCvjvvtVvi/Ti2IQoQE8W
	jVJzrslzXBVYgf44UL19F4lPk03D5RrJDOi4fmR8hJf8u5iOws0nR/jii1cQR3XtOlj4KSSZTEG
	Un9A41li4GLnrB8Ml8g0HxCGCyxFJfJHUzqrvED6HCXYa9IpeLDebHh5nXw==
X-Gm-Gg: AY/fxX7IzCr8ywLi7GLOhdz/0damaOz5c1oqVykL6VV8j3ch9g8UikGWYcN80TrWV8E
	6BSeMrMvZChs3ZtlgU1o5DFwCnxT4ltV44Tf8fxQWMEdbF7v1PssJIuZUqcdM5/xtqciONs9Wqm
	Y+GjJshfrBWBcc0CxDKV11wEGnphhS5HSvK0fx1E+y+KqQ81V2iNfyUmfQBHIeynQ8dHjYwi168
	0O+5inHO3QSb5l2mF5pUht/e1Spu622D5LSBCVTEYMIk8cmiGLvlSM5BZnHEiHIPc47HtGkQtzp
	93/Ah/zvvF/39Z+KggCaSRvS4I+FHR4UaIoy2aZrU9vnqNOTkiY76LW6235fwT+D81FvFukKaO/
	yI+8IsUsWpWoa
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30137336f8f.8.1767092926072;
        Tue, 30 Dec 2025 03:08:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvPff9z6bqnDX5VSu+V0AnQlnkoT9d++5M0UZ40DRX8SqSuj0lySJzumC+58CSjPjJ0/D32g==
X-Received: by 2002:a05:6000:2503:b0:431:a33:d872 with SMTP id ffacd0b85a97d-4324e4c1219mr30137314f8f.8.1767092925654;
        Tue, 30 Dec 2025 03:08:45 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327778e27bsm34741801f8f.12.2025.12.30.03.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 03:08:45 -0800 (PST)
Message-ID: <9bde9e8e-3ae2-4199-b416-ae3fdaf090f5@redhat.com>
Date: Tue, 30 Dec 2025 12:08:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vsock/test: add a final full barrier after run
 all tests
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251223162210.43976-1-sgarzare@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251223162210.43976-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/23/25 5:22 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> If the last test fails, the other side still completes correctly,
> which could lead to false positives.
> 
> Let's add a final barrier that ensures that the last test has finished
> correctly on both sides, but also that the two sides agree on the
> number of tests to be performed.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Net-next is currently closed; still this looks material suitable for
'net', with a proper Fixes tag.

Please repost for net if you agree.

Thanks,

Paolo


