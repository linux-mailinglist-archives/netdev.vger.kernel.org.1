Return-Path: <netdev+bounces-207888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E06BDB08E70
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124741889458
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078FB2E6D10;
	Thu, 17 Jul 2025 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TozdKuzr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767852E6D0E
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759620; cv=none; b=a9hlX3SCufAib95EJKThDGZXoLryewVfhWBeVmUo0DryDJ2cj29epkzIluF3+G8rkc4gkKM9UFQQa7WsmP2fFAdJH4lVARdT2lJEfReND3MoWnn5CERyrwMdt9A31RAK/qJNVb2t9ZpAPp9HBDTj5qx7Fh5fjIWLPoOt8SnM44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759620; c=relaxed/simple;
	bh=LuQfGUg7QimTZtMM6kIrGixSsVqH0rbo3bsIbi5btEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1wyerNCWcb1dxzD3FH1d3rYfDXH7HmyRGRUzQjuaibsVdcni2AqG3M73u3T2jYg8opKCW6oC/Rxx0329SooiTTR/TGTk8aLtij8uQJfKcaQYZfVyUk6MRmGhgqd6jJSQEFJjZj5HgZ10aDXD9CIKG9ARWCHBj4p4mOX7xt6Btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TozdKuzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752759616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGPfxbk6jNUxyPOfM4/Z2ZLLJNVNzX1A59T5q3qLXtU=;
	b=TozdKuzr9KGTIK5OOZmt1ZDS/tbVEIsgXsZLnjwOYlElWRreNT8FoXPFyCyFB8wBq4hAmV
	JCVFOgnXFYdryi8WcdiQKaUsz4cRxBA0ZIThpz2SHswcjqTZZaCpvRSM02FrJOifGIyndU
	jIxQRga87AN4F7pWvzwxfMCnU+CI/Ls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-VJXRhBhfNEe9nX6BNKNVOg-1; Thu, 17 Jul 2025 09:40:13 -0400
X-MC-Unique: VJXRhBhfNEe9nX6BNKNVOg-1
X-Mimecast-MFC-AGG-ID: VJXRhBhfNEe9nX6BNKNVOg_1752759612
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a58939191eso452461f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 06:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752759612; x=1753364412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGPfxbk6jNUxyPOfM4/Z2ZLLJNVNzX1A59T5q3qLXtU=;
        b=aehKYRIqfn16/c+FWKQM1dZ7Gjffv9lsnaLmAPuv2+seoQjtYeiWmaHeK0yVub2h/N
         w+V4oOFduZM5tHx0DHGKuVDz8QtUi9qpPYR8T1f+mtrARVgKXIBUC7E3zh93uO+N8yHv
         +JugmUmA47FdT0R64nkz+rvwouQ/YQXCWj9y495GNDXs5uMgAjiw1WXgMF2QFxf8UIVb
         DSqvWH56LiaylQZULYGUcQiSSwSCByLJeCL6HSXbK4u8HAN1pQaqiXpvo3Zp8iK1vrqI
         BBJolQx+ZWTB6briwkM/OadqOOmxJKqCYnv5P9qnQr+RjnhdbuVwzBiYLZW0vMh5D3hk
         7KZA==
X-Forwarded-Encrypted: i=1; AJvYcCV35qhhAr89BGMZqmOb4YhoVbjblzOtQg4sfpE3Ozw4aKnGl4Heb16zoSn/XvJYT3mdrTUqKLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkiR5Jdb+vuafTRMCKGthdTX46SCKtb3Kh2DIFLiE0X4AhCsx
	TWlMo+DUgCOlE4hHMl+fVK7O3mizuZ8d+U/3/j8rHazzkwa6zAAf3mKSlz9EOTzSK3md3DiRGPW
	IjZLTs+BYoqecL1MwwMqSNmW6biKzW4nO3d1u6vh0WqpEcba91Ne+Z01+AQ==
X-Gm-Gg: ASbGncs2QntbMh/53CZTNF6rY5YVxPvVn2e7/IGGt3GCjOjq55+YEjOvJYEyUy5n8Gx
	CXwsR3dkm1T6GrvJU8FNg7T8aRTWORBV4/iWm+y+vKMz2TDQgeXlzIM/HqG23h+mKI5/ct+VprY
	+lArUTYdltDcD7NOScWYQeiSFij/cXqKQlngOsuBy2S+o9Io+XsccsKM+3obGUyMQ2EeoNtz0y8
	5onwxk2oCRSId0bpXWUtT7sXuVjLAx4zd5svLrCOGDSdbSVEXCGK1wdVle8iDghAwSe40B4VaEm
	0fVoAJKKf+J66QuVuiOsdpVutcWtK930aZseqWVjSpo3yd0y1IAQgXU8NwHEfDeMeMUHzkRuK2R
	x8FZBMqGT3e0=
X-Received: by 2002:a05:6000:2002:b0:3a3:ec58:ebf2 with SMTP id ffacd0b85a97d-3b60e4c4915mr3929308f8f.7.1752759612434;
        Thu, 17 Jul 2025 06:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAIardHgYCQYeh4W/Z6kkN3By8E1k+FByZrilW0zMomhGnQ/6ioH/KXKgCzHgSbmluM/sr9w==
X-Received: by 2002:a05:6000:2002:b0:3a3:ec58:ebf2 with SMTP id ffacd0b85a97d-3b60e4c4915mr3929281f8f.7.1752759611988;
        Thu, 17 Jul 2025 06:40:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5f16a6016sm18837512f8f.69.2025.07.17.06.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 06:40:11 -0700 (PDT)
Message-ID: <68a3115b-8ae6-47bc-aaf5-b38e4f83c5f9@redhat.com>
Date: Thu, 17 Jul 2025 15:40:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/1] ppp: Replace per-CPU recursion counter
 with lock-owner field
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-ppp@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Williams <clrkwllms@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guillaume Nault <gnault@redhat.com>
References: <20250715150806.700536-1-bigeasy@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250715150806.700536-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 5:08 PM, Sebastian Andrzej Siewior wrote:
> This is another approach to avoid relying on local_bh_disable() for
> locking of per-CPU in ppp.
> 
> I redid it with the per-CPU lock and local_lock_nested_bh() as discussed
> in v1. The xmit_recursion counter has been removed since it served the
> same purpose as the owner field. Both were updated and checked.
> 
> The xmit_recursion looks like a counter in ppp_channel_push() but at
> this point, the counter should always be 0 so it always serves as a
> boolean. Therefore I removed it.
> 
> I do admit that this looks easier to review.

Thanks for reworking the change. I do agree with the above ;)

FTR no need to add a cover letter to a single patch series.

(but, since the matter at hand is IMHO non trivial, in this specific
case I'll preserve the cover letter)

/P


