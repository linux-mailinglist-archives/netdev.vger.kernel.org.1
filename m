Return-Path: <netdev+bounces-132888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87257993A13
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BE71C23E6F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDDA18C92C;
	Mon,  7 Oct 2024 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="k2ljK1qR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CB1865ED
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728339641; cv=none; b=I3jHVl2M/gKCIPcuhOY/JnQVbtgTDPRtcurlGVfSSxSd/NY/5rGHylHMr99lBWFcdgE2s+1o5uA/B7C6rD8qQj32vW5QeC46P5dAufUT1XFzJXgIHEZEmm9UuIH9KFJcmAaEiyH9KV+RIu5UX3ewOGPk9N+guDGXWgQO7kaz8Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728339641; c=relaxed/simple;
	bh=kONiedfm7nbqc7vigAL0H85kxZfK+hPd9pfj5JlFH8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ac11Rqw17d1YqCer6XIyPmjxMue40u2oLbwySXlHmv8i+xv7Ipt9mqeJHIhQ/MwAKqAr6itXCUyreECSTorikVzUD8ezbUhrZWnmpRKhYzaMfyNhzKn67wp7usDJ4W4DNRzttPo4WxqjA8iId8H8JKwUTXzrNsUrMTrhkEm3rT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=k2ljK1qR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71dfc250001so1491174b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 15:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1728339639; x=1728944439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kONiedfm7nbqc7vigAL0H85kxZfK+hPd9pfj5JlFH8A=;
        b=k2ljK1qRzy6gtVOb3D9wKisfVo4POUVnMRfeRUNWyxYA8mtgHXhWCauJQ6V0nchK6x
         gwwGYza8FZpiNvhwBncQW9NR77QF9Y+VpvXObRedPZDa35E45NrRTOHlXhNKs0eyfveR
         DU5j3fG2Qj6kMcB9amhRiJbBnQU7Hbu+QEG/SI9+L0/CW5ct9GhgR2K4WeDZhQXm7vLC
         FmE4EmKMiOdUh5ucXcGShv9dCA57P/jyFDSNyWc0jHIzjGnFu8wB/Nm1EAKPReNK4ttx
         x8MGe7VEFR0W8zkdRrdACI7X4rV+oXHFVAz6nhaPiMD5zLm8s1QxtjBZtInay2SPyOt+
         Ilwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728339639; x=1728944439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kONiedfm7nbqc7vigAL0H85kxZfK+hPd9pfj5JlFH8A=;
        b=L93x8F+LsFdK42YFA5SHQOYVMy2ln3IC4hzSySwxnoWuyHsfErMx0DVg/Ce3Pzl9PT
         99zxY+QjYIrYkP9fr7YpCKjdm3pM5eTEmTOj28GxTKTybqsLmVshhRbaUeiafxrnrVf3
         CV5PxvQvGlM+U+EQ3frZ5eMZg5Hbd3Dp0tw7M/wpXCAzVywcjNEm6bUrij4d0knvOOLY
         V8uZAxjghAqOpJ8tb2JXMcsb8BdEpOROHIxNesnRWfE3jEVGXpYmC3OhUk+Fo2YpKpzo
         vWjqIlp+ZNgSTrWfv33JgM9THAY+Eb6HClZTy0A9NxHsURRa0nBvqv1wS6FscL1lnvwe
         rcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP9IeDFe5MoF4OfvuhOO6nS8x4tSg1MyPia4mdrN84tAtJzvwrU8buDvnb4i40KdbJmndOIeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyArt5S7iwnj6AvKuZEu5FC0fBUUyEYSf4H3Tqlac53Hi9ht4wO
	VuHEU+h5qfoJ+EuVEI9jVxbmyGHkfryuzxUvIFugUOc41knc5//VDzElIUaOsDo=
X-Google-Smtp-Source: AGHT+IHLERWGRZ5Z4ELyB8U/zT9nKxCdsc46PbEhiwN18zexSUm8WmIDV6fOoPO20En1qusM0LMc0Q==
X-Received: by 2002:a05:6a00:2d10:b0:71e:9a8:2b9a with SMTP id d2e1a72fcca58-71e09a82ddfmr5137263b3a.23.1728339639196;
        Mon, 07 Oct 2024 15:20:39 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:1:80c:c984:f4f1:951f? ([2620:10d:c090:500::4:f136])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc48asm4900573b3a.21.2024.10.07.15.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 15:20:38 -0700 (PDT)
Message-ID: <0ce58780-d7e4-4253-ae76-934586179684@davidwei.uk>
Date: Mon, 7 Oct 2024 15:20:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] io_uring zero copy rx
Content-Language: en-GB
To: io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241007221603.1703699-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-10-07 15:15, David Wei wrote:
> This patchset adds support for zero copy rx into userspace pages using
> io_uring, eliminating a kernel to user copy.

Sorry, I didn't know that versioning do not get reset when going from
RFC -> non-RFC. This patchset should read v5. I'll fix this in the next
version.

