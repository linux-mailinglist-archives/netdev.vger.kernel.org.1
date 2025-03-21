Return-Path: <netdev+bounces-176717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5799A6B9A8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8CA7AA3DD
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6032222C0;
	Fri, 21 Mar 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Iw2c3QWk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D2221D90
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555704; cv=none; b=PTPt0RZRKl/loY0Acr1qHwWkE7kO0V6bmOnMSzuw/8+WXefmwqgC3xbVsQfC3sN8/qWiGQrfAbUBtoJuGVlAq867Myrum0Dq1EJb3Ys8rOBKh4u4xrAvTPGm2CHJTIcrmZmFFllHd8nv/7xqytlgG34/sOfe4wffv/43aMmt9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555704; c=relaxed/simple;
	bh=8R6APMOXHnSGsHWxrl6UGLerFw6XUN3eqFRa7zAvg/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CIi2K1CpKDdbDVnqi/YV6rPFSSXZP/q/cFbUEOn6cseE1DiAkaiF/O2VhJxOyZU5YC0LUWpNxcpT02hZhwLSTBRu8DVGrtYH+lgqbpJuR3OabGQr46tSAxClfJCLKfPw66AtP3YLCh81C4HHBx+STJHXqAFcubjZIJcRnEr3ZK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Iw2c3QWk; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85db3475637so96400439f.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742555702; x=1743160502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kliUjv4+TXv1KW6sNWVHyeHcHrrjshrv681ijKNdLOI=;
        b=Iw2c3QWka8kkhnOcLtELQiQELaeqZuUMgS7kb4ZffDPthFqQU3UQDlpY8iqcb3lUCO
         GKiU26FrybIvWhJize1sjzcoBt/fFZ4EI5gmL1eYbygmKOOFOV3S05G6BqWzpEtclq3Q
         wwqF55+fYuET9ydA9yszlebqAhBovv4pEK6oIuWjAVkuhBFiY8+vzz+0u+3duQajcyTH
         vbXNd04PuBX2JNOWy0rOfPXwBbC9kqEnBufORUw/mt2FQa8SsEGFIN3268uERLv7P6wB
         Xa2DU71NwH/dwcyCjpPH7E35IEo13ZQNAAzp9urqcv+H8JoTQ3YUonE/S4YI1eXC9Xcg
         zbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555702; x=1743160502;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kliUjv4+TXv1KW6sNWVHyeHcHrrjshrv681ijKNdLOI=;
        b=ZvLf9Fi64nmEKA7Q2f/io6IcSwQXPi7uliUJueuC9Z+s86piQEnco1RthhfxYId8Ym
         Q/0jr7t/74xluwn8M3tzu6etxr5Igc54Ok3QMaE0HyCZvEiztSInG6fqbAFCTc+cTkmn
         Q/JjN4fU9kTP4UCCoFHQsWnqDrQ/Ei8mcWx3fn7Iu1ymkbyAJH+kctDi53lfYZ5IpqIe
         gVPAPOvz4o7ftSX/ecbCG2C9DDuGk7f/8xzvlmfOy5yVoyb22Thk7DtWSo0ETn7xlPrl
         Mzf0IIiWNk4cKN95nPVnLivPYHp+YdEiAzvFNVwa1onoAYB+CWt5yGyJmmi0T/LO1zBN
         9XxA==
X-Forwarded-Encrypted: i=1; AJvYcCUGX/q4M0kEQsimZpsXriLIci1zC2ynXY7iFtJwoeNT8RxHSYx8YDK5FUZ5fdgcLHXNWdgaLV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGt27qyBhm2L89c4+NASaeTlaWiNaioAhCykd3gRul3TdSzt9
	npRgU1q+0amJTRV0j6cz/+4UK6zw0Bmak+sUIYntTmXb1YkJG6wQv2CrRs9YeAU=
X-Gm-Gg: ASbGncvsJSqRy/3kM6ZJAZBNJSoGdv9QsbpjpscBRqYKd/qDx5HOm5eiHtXbZh+naxX
	HwKMi+BKVIZtq2GBluh3FGDHRTWS9980cNM4gcGYeCkjHJbprV19kXkCmAq2EMMBB8oNi8rWC/4
	v1mZlrIRkA7Fu4X+DUBivnOG0bcUvMu8czq5bQ0cO+z9DPsznxjoUMwfs693drFrQMoNoDhQG6S
	QjkXlctSoO6pssXBQdaMTrJAipTHr651l/mx8RbwFVlcDqIZ+AtE9kU4F2iUIQSaV5kV0P6MAjn
	6KaXUAPKCj0S5wAxICJ0z9JjtBmqvqlAUak0O56nbA==
X-Google-Smtp-Source: AGHT+IGFd8BrZDNuk5Q4tM4bK6u6ZIejPv4ztHl8dw4HSNWePmW9h5bgFFsMA3e+W8P/94Uoju3uaw==
X-Received: by 2002:a05:6602:3991:b0:85b:5869:b5f with SMTP id ca18e2360f4ac-85e2beed32fmr322406139f.5.1742555701856;
        Fri, 21 Mar 2025 04:15:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bdb5495sm33739439f.46.2025.03.21.04.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:15:01 -0700 (PDT)
Message-ID: <ca1fbeba-b749-4c34-b4be-c80056eccc3a@kernel.dk>
Date: Fri, 21 Mar 2025 05:14:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC -next 00/10] Add ZC notifications to splice and sendfile
To: Christoph Hellwig <hch@infradead.org>, Joe Damato <jdamato@fastly.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, linux-fsdevel@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-api@vger.kernel.org,
 linux-arch@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 kuba@kernel.org, shuah@kernel.org, sdf@fomichev.me, mingo@redhat.com,
 arnd@arndb.de, brauner@kernel.org, akpm@linux-foundation.org,
 tglx@linutronix.de, jolsa@kernel.org, linux-kselftest@vger.kernel.org
References: <20250319001521.53249-1-jdamato@fastly.com>
 <Z9p6oFlHxkYvUA8N@infradead.org> <Z9rjgyl7_61Ddzrq@LQ3V64L9R2>
 <2d68bc91-c22c-4b48-a06d-fa9ec06dfb25@kernel.dk>
 <Z9r5JE3AJdnsXy_u@LQ3V64L9R2>
 <19e3056c-2f7b-4f41-9c40-98955c4a9ed3@kernel.dk>
 <Z9sCsooW7OSTgyAk@LQ3V64L9R2> <Z9uuSQ7SrigAsLmt@infradead.org>
 <Z9xdPVQeLBrB-Anu@LQ3V64L9R2> <Z9z_f-kR0lBx8P_9@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <Z9z_f-kR0lBx8P_9@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/25 11:56 PM, Christoph Hellwig wrote:
>> I don't know the entire historical context, but I presume sendmsg
>> did that because there was no other mechanism at the time.
> 
> At least aio had been around for about 15 years at the point, but
> networking folks tend to be pretty insular and reinvent things.

Yep...

>> It seems like Jens suggested that plumbing this through for splice
>> was a possibility, but sounds like you disagree.
> 
> Yes, very strongly.

And that is very much not what I suggested, fwiw.

>> As mentioned above and in other messages, it seems like it is
>> possible to improve the networking parts of splice (and therefore
>> sendfile) to make them safer to use without introducing a new system
>> call.
>>
>> Are you saying that you are against doing that, even if the code is
>> network specific (but lives in fs/)?
> 
> Yes.
> 
> Please take the work and integrate it with the kiocb-based system
> we use for all other in-kernel I/O that needs completion notifications
> and which makes it trivial to integate with io_uring instead of
> spreading an imcompatible and inferior event system.

Exactly, this is how we do async IO elsewhere, not sure why networking
needs to be special here, and definitely not special in a good way.

-- 
Jens Axboe

