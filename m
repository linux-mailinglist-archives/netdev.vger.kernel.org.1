Return-Path: <netdev+bounces-233136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BCC0CE49
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 11:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B204216BD
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A07E29D28B;
	Mon, 27 Oct 2025 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3lBY4vU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7C1E1DFC
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559454; cv=none; b=Nn6uWIV8wn5OnpcOKX3KhfYt63H0OsJzEQerzx0jHIklrf3YfffS9qNwlon823C8voJYiKUU/qXAL1YmwE9tIGfyg0/DiQiGwUjrXaOvpzHkRPZLMFsA7XqgOrgowbrI9ysos4qh1X6gxWM3q11DGSvgcZBn1suj0AYNoFfDAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559454; c=relaxed/simple;
	bh=9h3JF2Jsr0bLr+MYsKAm+lyyaTDNMUS6YLXcZVa+WHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmg5nhs0apor3b+pUT05ci1/afMow/dZrS05oWHQF6+tKcj+g4T8ucbQ5CurzAKCTm0H23skRaLxaVAPRmlmisCUPE+ZPL1sXI3BuA7PtQvppGXENxul960nIdCvN0xNLdDK3yDZEbqdPPpHFSsjb2nqlTCET8pCmva9pdeAUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3lBY4vU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so2124991f8f.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761559451; x=1762164251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKJ1wg6u1UDCN2tuMgCmCoT9rKQEtjNwHunwEx8cPko=;
        b=Y3lBY4vUt6Sdw6Ksc/GOP6j1dSuo168GcHkkUngf1EZVCWALNE7+agjIAZAjlQgv4G
         pvzlxhX2BTc+37WTzefuDuSq207T633FQfsqQCBAfEgwZ17rTohzC3QP8TdnQ6F3Fh1k
         VvdXg2rLbcotOsingqZimVnQRb7ubW4cpNVx4+O3nMPGmrDG+o3r020BLFe2JrK67eQV
         i5iAMmCIDO46kjQ4JLz6IjEDIvTM+STSNbIC/ELzwEg8Daa2VM7SYsaDCGh+FO7cfk0Y
         2sZj9AbRYVOKkvXpYrss5l74lWrEPBEOpoINtzu5wj3VlzlXRmuz2j67TJMG2nS+zYQl
         m7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761559451; x=1762164251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKJ1wg6u1UDCN2tuMgCmCoT9rKQEtjNwHunwEx8cPko=;
        b=a615ocxOsy+7xQnTEHxaZpV21Mgbu9lm9cv74qcO7IqVNKbdgOGO8Uz7hDM7d6vpK/
         cnrnjVuvJckK0ydJmzXz2hRiCPc+Vr7Rk26rc5VAEWqnzrJ89avoF3pQONgck4nOvqoV
         1+c2u+oFjcUciC1bh0X21PmN0sOx8dT5uujf8FIyFub4YFcUBba3WKoASmbV/Yh4fFMO
         X5evH6XhWoXsdtM7ePQMAqs1SB1bcsoFnNSGRHxfnJNs6m2P6GZb+N6UlZGsc3NaASH8
         zb/eZaSb1ye2/OnmtlGfvsrgKWWz+XGQKzYWKJthmtDJQfETQmo6BX0vTzRyV6V5HQZI
         EMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvMHqBrU8myxUQLJCRskjluNtLnz0IjO6KhFrwq7T8DwXJogKEN7u3Ovjqexx9Iqei2x/5R+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgIM70GpcSzArcp1kZVharmNDsXhvOnuXDe8duXdXoVmqH4qV
	ps0tDCQ9IJ7FIsOcgAyr06NG4yAxSB0/LEvxoKx8nPu0IzT19sVZVvtJjTqrNg==
X-Gm-Gg: ASbGncvbqPlsBf+doy7HJVFj01BnpRt9jp92FagXkesrZE26OpvkcM7PrWhwhzXUGeh
	WF/EVo+CTP47AznrufWOeygjJ7c91cfiFfKsVPr7aKuHiNN1Ia+1XCj8i+k/NX+YJSgK85JqSSS
	KKoevXY3KaQkho9qPPRswdbRMeldQlWXQD0WohfuHAZm+WMfSArGlPRlska84agahiPU+7m4bhj
	GzjDG475XpTIvMOaqlLXxGXNfEJ0sq6y81xW1HDa5XuLP1rKMxNMolSIGV/N0DMFA8p/9s+n3YP
	mxC2Me/8dnqY8prtTCkOmP2ysBXsSNZDtk0pdfSN/yzoZ2yF7yvIHKVSuVZfK/4MO+w0EbAcZQO
	Lfq7ZUloZjqnI7Oco2WksmeGVzwQ54rFizhRUUJVDcP/NUSID0qLGDNL9uZXakGfwTSjuba6P2b
	lDj4nkz78mJw5CFOXb1j96ZewJFzqpooEq
X-Google-Smtp-Source: AGHT+IF4fsgQiwGl63VPBGIPyCwDHMyRRafneFK7MUW9p1IOLSi9/nVRRkViP/Dxx76BiIBnVUk/Gg==
X-Received: by 2002:a05:6000:4b10:b0:427:6a3:e72f with SMTP id ffacd0b85a97d-42706a3e74bmr21755793f8f.34.1761559450855;
        Mon, 27 Oct 2025 03:04:10 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:8b1a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm14277603f8f.45.2025.10.27.03.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 03:04:10 -0700 (PDT)
Message-ID: <c3a45eaa-0936-41a7-92cd-3332fd621f6a@gmail.com>
Date: Mon, 27 Oct 2025 10:04:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] io_uring/rsrc: rename and export
 io_lock_two_rings()
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251026173434.3669748-1-dw@davidwei.uk>
 <20251026173434.3669748-2-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251026173434.3669748-2-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 17:34, David Wei wrote:
> Rename lock_two_rings() to io_lock_two_rings() and export. This will be
> used when sharing a src ifq owned by one ring with another ring. During
> this process both rings need to be locked in a deterministic order,
> similar to the current user io_clone_buffers().

unlock();
double_lock();

It's quite a bad pattern just like any temporary unlocks in the
registration path, it gives a lot of space for exploitation.

Ideally, it'd be

lock(ctx1);
zcrx = grab_zcrx(ctx1, id); // with some refcounting inside
unlock(ctx1);

lock(ctx2);
install(ctx2, zcrx);
unlock(ctx2);

And as discussed, we need to think about turning it into a temp
file, bc of sync, and it's also hard to send an io_uring fd.
Though, that'd need moving bits around to avoid refcounting
cycles.

-- 
Pavel Begunkov


