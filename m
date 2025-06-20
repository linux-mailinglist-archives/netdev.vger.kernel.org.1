Return-Path: <netdev+bounces-199660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080AAE1383
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 07:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6FC1768D2
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 05:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE3121D595;
	Fri, 20 Jun 2025 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="TX11KRAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B821C18E
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750399170; cv=none; b=O7XfkW0uh6P7+eHufHYA4vs4B37pjRtSlZQrpwl8Z/Ye1Jv+CEh1hqABmo/b0zBwvWzLLDhhuo/I4pIP0uYbn02jg6I1gE2Mm6kwWPrY6C948GVqGPCXcoTyPfZ0kYUuRigYUuTC0GV7d2zkKX7khmnY6kAxoRBYHpeoJc8TEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750399170; c=relaxed/simple;
	bh=/XyQGOkIDeY6Vu3egfNNxX+kxqaWI2jOQ4QBkbnle/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Utff03usjif0oBhF7cg1w2b+IirZXjb1OeTjwv5Kw+7WJbE+JmnSAtPwR/kouegBoULdCoyBjsQbu1LN4QjC+h2ufvC/7dW7sRA2gSYHMLphZOGpVkQewYhgN4ac3/4+UVIT7SFxqIwTQ6fwWDFMC3XkxhmqJHH9OLfZPlnWysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=TX11KRAM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso1721438a12.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1750399168; x=1751003968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tb0Oes5vWA1YL51NeB25Xo196XgSTcQZVOjoHvg+cQ4=;
        b=TX11KRAMh1ZOjqYLQWN5KYUz7jpK0ZykTeZdRruCCAO35gUxxPicstbbWEZGe2+3ar
         owZOGXpM1oOHwSRaDFhs8Q5tN5CdYsqeslcHUGtqDFXydJYUSv8BZBHaaNiODV4cgwv7
         X2U90+yPdPOge5Yajo4KWPwpzeIJnFENLd6KyC7TdHbxKUdFBWGyl3YjLB6dhIMs+Z1r
         3fgDhRfKGUKkeKoUPcgUeqt08j1nZycoa1ujIC1+CybCv0tmb/gxW+Opa4f6TRyvQMux
         ga7wQXOBjqYY7925Riv+zjJTXbUu+coQhz//AuObELUQhtPmm/89KkY5aO61D4kO1hYu
         numA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750399168; x=1751003968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tb0Oes5vWA1YL51NeB25Xo196XgSTcQZVOjoHvg+cQ4=;
        b=Xgsj/41i2DW3rN4cF8RT86USWcbjwVY8AYOQ+Ta58YYXRhD9zMlEi3YU0f/A9mG2jo
         x1op77AwXWMWfnutB+xTDH9Fiw5iz+aRswenLwLpxUEcKTlKWpRDx8++ce0rDnBeNt/h
         sS4vimmlaNxbmLmCQvybmfnYq8hX2fOTlnDxAwuLnFwcAmVBvrZbkkWZsmzQYKYLRR1O
         f7xGRxFtMruIBMg9Nlc5HgpCDwVwGfBi9Ywbcgi+PCtjLeMXXpDwZxK/TUEsVprtNtmA
         eaM4ZXcevHpyY1APgFdFURlMdRdlW3BXGqwlwMSmZrO5Y1uElXplIay6kDPzFNmo2orh
         RhGw==
X-Forwarded-Encrypted: i=1; AJvYcCVDTNMW9tCaffQ+MDbfAeiCfhUAnPKfUbnqJEDK4hfU0FkfE+0KXcXtD43qapOY5jk0rm1GkkA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwn7TT2KDCxnweFxXT6NuOK1U1hgAB64vluB7hlwjswA4Cmrhy
	EJ1XBFKvYXLSSBEByeegQrmh3hDTCKcbxbX7YOxSRthNt7qNcQuMlA9JEfDmJ8/jEiw=
X-Gm-Gg: ASbGnctv7mt2LpxA4rrpVOgIxk2+fayL4kR4J+pCQsrTMMqttJc6KwBzNXiNlj5ADen
	bw62lTC7xE3DnXUI+T56B5YqrAGCYyiVa10zV74umh7kjsFsHxxcoNYI8/1JkGoq8jY1p+X2H04
	mNUixCNl82SLAbE6E5wZ9qvgonyLig+NYyBKSPZmmB3zO9UMHS5s2zhqMGtlxCq/Qe3Elep4Aag
	4eC43Cjfs0FXwkIDIz2LXveIN6tg8nSvNascP/OBo4JJBCDbgeROXaM9tHTia928+N9C8C9AC94
	hxeQrnfjdzRsV/UV2tM1gQaEH+PgZUG/g6uDo715Ux64j8P0BCDaA1im2jmGwbyMWRBBb+erAkc
	=
X-Google-Smtp-Source: AGHT+IE7e4Bb7rJJNNMR4+4eRFxKU+Xn4nNlZf/xt3mR3LHeEsVw6xgAfYFwkb+subLmAJR8msAAyw==
X-Received: by 2002:a17:90b:3cd0:b0:311:fde5:c4b6 with SMTP id 98e67ed59e1d1-3159d6260admr2559985a91.6.1750399168283;
        Thu, 19 Jun 2025 22:59:28 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e0558aesm824923a91.30.2025.06.19.22.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 22:59:27 -0700 (PDT)
Message-ID: <41a290a5-19ef-40e7-ad21-f3f552f58845@daynix.com>
Date: Fri, 20 Jun 2025 14:59:24 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 3/8] vhost-net: allow configuring extended
 features
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <c510db61e36ce3b26e3a1fb7716c17f6888da095.1750176076.git.pabeni@redhat.com>
 <e9ca64b4-3196-4b7b-822c-4bb0b40f8689@daynix.com>
 <52a8b6c1-1e3c-469e-8598-74f5b1cd417e@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <52a8b6c1-1e3c-469e-8598-74f5b1cd417e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/06/20 5:13, Paolo Abeni wrote:
> On 6/19/25 5:00 PM, Akihiko Odaki wrote:
>> On 2025/06/18 1:12, Paolo Abeni wrote:
>>> +
>>> +		/* Any feature specified by user-space above VIRTIO_FEATURES_MAX is
>>> +		 * not supported by definition.
>>> +		 */
>>> +		for (; i < count; ++i) {
>>> +			if (copy_from_user(&features, argp, sizeof(u64)))
>>
>> get_user() is a simpler alternative.
> 
> That would require an explicit cast of 'argp' to a suitable pointer
> type, which is IMHO uglier. I prefer sticking with copy_from_user().
> 
> Side note: there is a bug in this loop, as it lacks the needed increment
> of the src pointer at every iteration.

A pointer casted to u64 __user * will make the pointer usage a bit simpler.

For example, initialize featurep as follows:
featurep = (u64 __user *)argp + 1; /* skipping count */

...and you can get the i-th element with:
get_user(features, featurep + i)

You don't need sizeof(u64) this way.

Regards,
Akihiko Odaki

