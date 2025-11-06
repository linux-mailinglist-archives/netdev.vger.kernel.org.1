Return-Path: <netdev+bounces-236443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02305C3C575
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 17:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 306B55004FC
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423A34B433;
	Thu,  6 Nov 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jttP62vr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D264C298CA6
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445438; cv=none; b=tTpYn+4IjbIwV6FhVuaTpiNy9M/9GeI45uYGULbnmm4c5CCMtHxZgLK6luouvHD7AZAgKrvT9QuaAEobIH62jxWpq9CDAzMUssjhDMYxv2Oy630JWPtRFjQZR3msZs7PCmz9BxX/6aHcmedcU04jRryH/FbXDNMPg/sP6igJE4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445438; c=relaxed/simple;
	bh=QZSW/BJ/RJydAx+Ol7lrobWrMwqz1A1hUfVzW6JIwh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMmNNA9qnIKdXwS4kaLZztyrxfTvk65dnNC+PEDc28TDE6b6A7seB1SfF/OIRYKY4I+Hb510QzIOplr/BKjnnJOA3OxyvBV/d0zsxA+raUb+SyRreYM70Y99gITi7clyIslcRjah0xt1ZZnsJ+gSoFvAfPsjzUkOgK3S5jtnvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jttP62vr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47721743fd0so5799095e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 08:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762445435; x=1763050235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpSDFcQNgt2zxWM7xhHt9aq3d7KBybR0vmck3/ABSyY=;
        b=jttP62vrzjVqv2PyHxXR9clfxua9zlH4WlRgPb6DSRhQxir0RK4S7bQNio0axhFB4v
         BPad0ywPNXIlS6L4JLBrxjBlhfRd97gyIYyMWLm2zQvHkPZNgTYhmZWyLNe6DMTL51Mn
         PD196a8Dw4A9wMSyAhYAJeKBXY+fLz5Mia3tcivdgyJVv6u1763LZ2srnGUN5KtxUBlA
         Oc6ZaXofTE+x5uWzkoHS9tanooxfHOZRbSIGYJH8kYZKN5jNG/tyOWpYwzSkBt/2xin2
         d+FWCyrlKFny/QDVY+0gmdEpmSXun5tuh+wPaA89ITpEqEwNN40Fqoi97Mbsm9SljzC9
         We7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445435; x=1763050235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpSDFcQNgt2zxWM7xhHt9aq3d7KBybR0vmck3/ABSyY=;
        b=mCi/LGPJtbr/Vd5qsIIa3ATTax7wmaT0wTReRDZYeGNd6QH4mgFrCBUvvKnx2Cyosp
         tRGqd+kx2Tru4WhOLcJwnu2Xn5RhlkPVbAPiPqhe2rDJ2hUyilO6EqvtgIWjCxTglDpb
         ZiVnhbFDmO/F/Bo7R3uykCjV2eSMW+Sa/vDCdhUa77NX9zF5vyTrpKXUNYDGNkDspdq2
         CZpZIy7KanvvCBtJNFTqPA5IsJPPcvaUnhOYoG72boG5wmGae0sOHq7fdAn1oRsRaxby
         6lkx1nLIDevAltP6M8+ESfTFDAyUOy5/qFchSiiWseVekhhQ+gpP/866AXKADFF5xjYR
         CswA==
X-Forwarded-Encrypted: i=1; AJvYcCXG7TYjy1ENwCuhtn5j8DmDC2Zlp4BsdgBTRWacFg3k9NiWOm5NZw84waSejfDcCd1rdF11JiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlB5HTOHP71vVFRCqPYPv836EG9Hw/cho2GPKe0zFnbjXn5XZu
	Mf+7PtPAHJQ3qlIezX8/N63dLbWx7BVXdTYPOeBPyNiG1+rzPDDdHQ2d
X-Gm-Gg: ASbGnct0nfu7cvdJZSmRCcpLvUOsXf9upX6INOon85oYcDdWdzISCK943ur7oMEWGLG
	mceKR1052XUZdRUWCb+CsroWz3iPHStxV9wsl1zbqQXOEeIys6fnYSoe/gL9pInhoWgmU5ebFt6
	t6sUPx0GvwvaFpkcUXc8KvSGOwPmMwzOql9ADaKZyuqcv+yoq3fFBlPOGiBFSyOOYV85+p1Y5TI
	U+9k+MuUfq6QTb4DXqpJ1l7FsOlS9f1jlklSBe+euXn+1+xarasr220XItUkdESCqz3dFIk2J2n
	yNqnwA7afM9AGUfskbw/sZnR84oov3bG6eJMc+i//7p6C2YxAWqwturMbYVTX4AopkADKi023na
	vRdBcGHvowiKyUgzfVCF0DbtoOOp/L9sYuWi4V/dcqFg5W3/sLJGYhlqj7oNlyaaxLiqh1QHQBg
	1/wYJU5tvTLqabvyZAnOz+2/t96eM9ki1C3BmSB2vEYKnj4pgUl3o=
X-Google-Smtp-Source: AGHT+IFgbjeBxecVoVp+6vBDH7heaujGg1di/ulHuvm9TQYuO13H0aP+SVDN1qD40wa9yHHuu4qK9w==
X-Received: by 2002:a05:600c:1d07:b0:471:803:6a26 with SMTP id 5b1f17b1804b1-4775ce265d1mr61987175e9.37.1762445434949;
        Thu, 06 Nov 2025 08:10:34 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce329afsm110752595e9.16.2025.11.06.08.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:10:34 -0800 (PST)
Message-ID: <358f1bb5-d0c2-491e-ad56-4c2f512debfa@gmail.com>
Date: Thu, 6 Nov 2025 16:10:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] reverse ifq refcount
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20251104224458.1683606-1-dw@davidwei.uk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20251104224458.1683606-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 22:44, David Wei wrote:
> Reverse the refcount relationship between ifq and rings i.e. ring ctxs
> and page pool memory providers hold refs on an ifq instead of the other
> way around. This makes ifqs an independently refcounted object separate
> to rings.
> 
> This is split out from a larger patchset [1] that adds ifq sharing. It
> will be needed for both ifq export and import/sharing later. Split it
> out as to make dependency management easier.
> 
> [1]: https://lore.kernel.org/io-uring/20251103234110.127790-1-dw@davidwei.uk/

FWIW, if 1-3 are merged I can take the rest to the mix with
dependencies for David's work, but it should also be fine if
all 7 go into io_uring-6.19 there shouldn't be any conflicts.

-- 
Pavel Begunkov


