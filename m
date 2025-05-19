Return-Path: <netdev+bounces-191516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C19AEABBB5F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5041791D8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4212586CA;
	Mon, 19 May 2025 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNbeAVZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5E3D561;
	Mon, 19 May 2025 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651485; cv=none; b=IE4mVtuigSjR8rtMyTZUQ93Co3TxksQozvqWhuMoAcobvTMXUUZFpU13j+l9N9TZC0vS0KheHsavLiwJdVmaTiNVT3HyP0aZVyUtLAGPxoJwO6XncTbaGmuBHXkqRCfW/qd8EhsL2Z/fRKInpo9vLvQLyajD4I8PkMQVaLG6YZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651485; c=relaxed/simple;
	bh=SMkiHxsh1hjlrQJB8Ce2+iTc+Qr5e8lBqFLqhdLuT8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTLMp38DkHpN9WqKXt50qoYzOUoe/hoCvMw4C6WVk4H7hHKdGFzmAcAXV8CxLYaPCHvKBRtjcpzRlXl+RHETxl+P7+jo1rAMrrR/3VC8rj6DY9Nawu0m1VtL83XPw/hzSa2vbVnMY30PKc46j69T4ebD6QBrQV416wQyGM3PTYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNbeAVZd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad54e5389cdso285712566b.1;
        Mon, 19 May 2025 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747651482; x=1748256282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfAkTadwzg13sw1ZmkAqyKpxyROInMKiKTPvuvDC320=;
        b=YNbeAVZdkR8+PLcyciKwWXvZfgyM2ZzyJS8z7Uw4Auw9ZKkz1BvfwCvJt2Isl2vXDG
         /dlfKHvh9KjqlrCqih8/a7w+2IFY5abjs2xTDm8jn7JrQLyJFbKjPK7l+zM63LJjUR/n
         Z4MzHjWWYECRnraE6dqJsp+b2OdOjaDrPg+fKjfzRyRlDve/TXdp7Aeqo8pNNhlfRO2+
         YzDdWcDS4UEXhClbw6x40GSr58AUhEJEUTh0UAOjTrv9Y3pERlINJZSCB6c7rKYZ0/1G
         zQDNRWJB6VUpWCCJDHvxwrg5s0e1oH+5qW73YDz0IleK3VynHN8oIbG5fA0UvhkcI4+n
         ZjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651482; x=1748256282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfAkTadwzg13sw1ZmkAqyKpxyROInMKiKTPvuvDC320=;
        b=bRIvr4TyiJuSE7etK54nCKUsm+hVEHvk4/qnoyYk6/A8GhZNyZ2bBTa3An/QLphK6q
         k/pI+CvTb2nF9HhbEeLAsmyI+z/z0cccR1woK3gSiLTj1YIi+EKs3rzTYR1tUVpbeglJ
         xmBOXjaiGZczman91UlqZMLS8jwBgwGBs0DcawJxtnRK+T129NzYkYCU1pXYBYFUfyjX
         oa6bXd68EQ0DMm7o5FlDedePa+mdrRshEA1oFK33rtHWErPua8UUAAIR/TFLcXQjW2Mg
         ZLXdPGsAz9Mlia/s+z5il0s3sh7dNeXAV6ILTPRgQ7ygnXmyogAmsqkWjYTXRqH869Ea
         xLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+KE2aACIdNeld0weAUzrlY49EGgfIPKgR0+tW2pDiXvIW7MUysHwS1tehTpH8WN8khtK3VIrl6XNgAfE=@vger.kernel.org, AJvYcCWrbS8nfACnFzkeDtGrVwtTi0etMAM8yv+DZC33HtuI9iLb/sQygVtXexCuafGAh0LC5sytNZql@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6lN6Ym++We5tq7A8nLoxzqA8PWPJaKp9BMkAPG8E6C816x0N
	2lnKJ9Ys7hyTJjILjDUKYiULbfkeQ2ERwba6fYBx5R+z5smqC5BkM1EL
X-Gm-Gg: ASbGncteBmWBZXsJXSBoRjLLcw4wgEYHj75ILvQv26Oz7LzPgiVMmzU24iWriCP1np8
	wu8omiwYxj+1bRl5tIe3nN13TqU92DrUqPiw/zg8dxHIVgms/VDjR/fx3YrDeeyYmtOF9i4k6JA
	aZ44bcVPVfKOKLwjADr2FdGNv+gi7q6uttMgfNVfEdu5QGWqhuE2C0tL7ICbPdMuZl4VvMLlC0D
	mkmvipT8U2ISmQ7zeO2ptl89iozKsKWj0Ubk2yvVxEiX5KqVgahNFHXudQyes+sfNN3U6SR8YQ2
	5jRo7NU2+RILncXEtWxdjUdU+Ir94kclg+uY6l5iy0Rkutb7vztAjfOajL0pn6k=
X-Google-Smtp-Source: AGHT+IG2vDGgzfhDZPbbGMuLd//mmeiIDYKo77Hk6zFqe48UC7gE/DidVeZ2l3E57ZyZvYyAmxLGqw==
X-Received: by 2002:a17:906:c10f:b0:ad5:7a67:e507 with SMTP id a640c23a62f3a-ad57a67e667mr129755966b.47.1747651481980;
        Mon, 19 May 2025 03:44:41 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::71? ([2620:10d:c092:600::1:75de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d441fe5sm569059366b.111.2025.05.19.03.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 03:44:41 -0700 (PDT)
Message-ID: <ab1959f9-1b94-4e7f-ba33-12453cb50027@gmail.com>
Date: Mon, 19 May 2025 11:45:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: devmem: drop iterator type check
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, sagi@grimberg.me, willemb@google.com,
 almasrymina@google.com, kaiyuanz@google.com, linux-kernel@vger.kernel.org
References: <20250516225441.527020-1-stfomichev@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250516225441.527020-1-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 23:54, Stanislav Fomichev wrote:
> sendmsg() with a single iov becomes ITER_UBUF, sendmsg() with multiple
> iovs becomes ITER_IOVEC. Instead of adjusting the check to include
> ITER_UBUF, drop the check completely. The callers are guaranteed
> to happen from system call side and we don't need to pay runtime
> cost to verify it.

I asked for this because io_uring can pass bvecs. Only sendzc can
pass that with cmsg, so probably you won't be able to hit any
real issue, but io_uring needs and soon will have bvec support for
normal sends as well. One can argue we should care as it isn't
merged yet, but there is something very very wrong if an unrelated
and legal io_uring change is able to open a vulnerability in the
devmem path.

On the bright side, checking UBUF on top doesn't add extra overhead
as compilers can put it under the same test and generate sth like:

if (iter->type > ITER_IOVEC) /* fail */

-- 
Pavel Begunkov


