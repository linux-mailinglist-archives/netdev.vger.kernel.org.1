Return-Path: <netdev+bounces-231659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5149BFC219
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19C440516A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF526ED3F;
	Wed, 22 Oct 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g8bJ4ve4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B726ED28
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761139072; cv=none; b=ssunqyOENclJMb0+izHVjv8xM77g8n1IPueyYNl3a7wNWDBHniobprfaPCBUpuA4DBzd/VuDWZJiQaa1a4tLcwmTALrRXbnEZAXlqjzQd56Hgun2m5Tn8hqbQ8OFXIF8y48KX7vEYMwjIpB94yBVkSuhh6UbAqQagINVRJsgp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761139072; c=relaxed/simple;
	bh=bcHlOIBD3oxp4mVOg26FIl6pVq4j9LipEQCMx5XySDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUZRQKbbNlHBZYSAA7TT8rZqB7qmmDoWOEOaKUHlX8lTtadBEVD30oCZoOUJ1nNVBn2TMVEhdCGPEWhGLPKh9SG48C3Eb6v+ZYRsqZOiglBStWfKXjnzlUZG/jLwYXmC+czbFhCCAWe4QJbtR+PX0YgcwLDB4Gq2D5Yalo8tDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g8bJ4ve4; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-938bf212b72so287895839f.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761139067; x=1761743867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=io5+b/Dl+rJ0SS6Ga9nnU2IbdWExfhLs1otAYNw8S+Q=;
        b=g8bJ4ve4V9ohSIXFB0RJhey2g4lW7qipKQQudvfzB8VySoMFuoMtTvSFcIs5MzT/RV
         duRcWpLROGiT8rLspXqwzfsKYTakWrTzndGj7rrlLeZcb2KtPYnRk89oVR2sxCQHRy5Q
         l+AuvYTvD06Wov7/EWGviz1U92UTwV/JZC55x8ZaAex8HVh8br7rfiJ3vofmA6OU/ryQ
         K3uDNxUMbaU1aX61GP0lrAVO8Blv0IQl/1sY6cEzcG6M7Rvt1R2iloodpd8oHlWpWYF1
         09AI3Ahb11cwQyEk3w5c+u5T/iiATEc1k27egIyaIqYqth5pOFCrq+x0LIEGC04WJL0F
         tBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761139067; x=1761743867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=io5+b/Dl+rJ0SS6Ga9nnU2IbdWExfhLs1otAYNw8S+Q=;
        b=luaN+MAnOOOHMe3YNO/UweXed/3ox0WU3c8Zuh87wYchSDiNgY0i2S14nSLl0Pfaj6
         m1WAlDLF+1WDc2c93e8kLFDRE1CB1ZK+w+CPii6z7I3Dr0FcQPulVK3+1qECH+Rj3GuJ
         BA04TUfNiUo9B73/+QIvf8DtI7UbQ6oulgY4+HisPEBYyczRfAmxCG08Wo1hhpE+PXwG
         57Y1fuapmv7fDkcSlOhSRygIIyJyOc0KkpzxcuzCSka0jbIzoD7BvKivelI27ofjbruo
         ke8sAdWHaaifV110+sUOuJ7KT2lE7xvqZrBQ/M+/oHpahI6NM6ep2xhbzLaIROyRGNhE
         V+nA==
X-Forwarded-Encrypted: i=1; AJvYcCXF92meuPCsdmIl6ZnbKhrk0ViMq7tZvE3t0SJqqlzxKlSq+pCn9/oDnx61tLkIjHCZo9eeQG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dPUCHSocEixRhGH8XADIokpx1mwL1FpWH/0/0K4ve9lYx5tX
	TeW9hK9E3gC/lTjqL5xKWn6ht5IgXDYApntYd3Ig9BkYIjWNzSyO6GCySj7dIouHM5M=
X-Gm-Gg: ASbGncv0uG5XBhr43LOXVN9FguudmZ8mN9DdICw4SO/wKREs6eC7V+wfkre6/xOsxNu
	HWDutnW8F8LAm3FogL1AuHB+zBNERGKCOYuwZnKNyILyGvEFDhu7A6WdEtlDy+/bc1focc2nL0P
	mmgznaS4BH4a4kZY2HTLKcmf83NxZJtQl2gLfu3uNFioM8HEEeENaZKa+vFxW/4RI81UKIqH8rv
	EvWcEGPu9cMq2xJRT7F2s6C3Qwoeu1Nx2AoXk/2e2klpEthgcq77rMpZtyNDfECnYgN4OnIQqkc
	VwxTvGhBvAXj/E5dj5gPHh+EMqFiPFEEvJiqF6G1PPPorD5g6dEJ0iPlA769smHiTdlJfZgW50p
	AGgN3cECZLa16EC6CX0IqxUrCLEIIKjhY0frE1v4yLg9xbJouwrLPeYtEmUtfnchozKiar7dMIJ
	rqlzQTKsc=
X-Google-Smtp-Source: AGHT+IFxN/gtR5CCRmZKybvHgMrdakXUkYxhb+HjCqrJbjodILVkGXRUicgJOreSS8VpLkI4cMUplg==
X-Received: by 2002:a05:6e02:1d98:b0:425:7526:7f56 with SMTP id e9e14a558f8ab-430c5204a9fmr243210645ab.5.1761139067095;
        Wed, 22 Oct 2025 06:17:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a973ec13sm5035688173.38.2025.10.22.06.17.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:17:46 -0700 (PDT)
Message-ID: <832b03de-6b59-4a07-b7ea-51492c4cca7e@kernel.dk>
Date: Wed, 22 Oct 2025 07:17:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring zcrx: add MAINTAINERS entry
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>
References: <20251021202944.3877502-1-dw@davidwei.uk>
 <60d18b98-6a25-4db7-a4c6-0c86d6c4f787@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <60d18b98-6a25-4db7-a4c6-0c86d6c4f787@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 5:38 AM, Pavel Begunkov wrote:
> On 10/21/25 21:29, David Wei wrote:
>> Same as [1] but also with netdev@ as an additional mailing list.
>> io_uring zero copy receive is of particular interest to netdev
>> participants too, given its tight integration to netdev core.
> 
> David, I can guess why you sent it, but it doesn't address the bigger
> problem on the networking side. Specifically, why patches were blocked
> due to a rule that had not been voiced before and remained blocked even
> after pointing this out? And why accusations against me with the same
> circumstances, which I equate to defamation, were left as is without
> any retraction? To avoid miscommunication, those are questions to Jakub
> and specifically about the v3 of the large buffer patchset without
> starting a discussion here on later revisions.
> 
> Without that cleared, considering that compliance with the new rule
> was tried and lead to no results, this behaviour can only be accounted
> to malice, and it's hard to see what cooperation is there to be had as
> there is no indication Jakub is going to stop maliciously blocking
> my work.

The netdev side has been pretty explicit on wanting a MAINTAINERS entry
so that they see changes. I don't think it's unreasonable to have that,
and it doesn't mean that they need to ack things that are specific to
zcrx. Nobody looks at all the various random lists, giving them easier
insight is a good thing imho. I think we all agree on that.

Absent that change, it's also not unreasonable for that side to drag
their feet a bit on further changes. Could the communication have been
better on that side? Certainly yes. But it's hard to blame them too much
on that front, as any response would have predictably yielded an
accusatory reply back. And honestly, nobody wants to deal with that, if
they can avoid it. Since there's plenty of other work to do and patches
to review which is probably going to be more pleasurable, then people go
and do that.

The patch David sent is a way to at least solve one part of the issue,
and imho something like that is a requirement for anything further to be
considered. Let's perhaps roll with that and attempt to help ourselves
here, by unblocking that part.

Are you fine with the patch? If so, I will queue it up and let's please
move on from beating this dead horse.

-- 
Jens Axboe

