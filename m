Return-Path: <netdev+bounces-127114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D19742D6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA021C25228
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439551A4F3F;
	Tue, 10 Sep 2024 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uhaUVyTe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0C1A2C36
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994605; cv=none; b=OaOTEVFoinCt1sTHVnyk8BgKw4msuNOf2d2qiCRrZR/1vVukS+K6J1lMwAxT2zc8x8oawsJ805Owq4mESqfuImYqnERkXjhfI0Ai7txebJ8JY7xbz+WeWG+9tsm6j08gui7OxgsUsYRFU9bnhGlD3K/o1sAQCPIzrmmsQKaj6/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994605; c=relaxed/simple;
	bh=kWTZjwRO7V/Rkeawjjcy1doJ7O+3gIKYTMNLYL0Pjks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9Yp73+52TftaPf6CfVa9Mzq5clp9DuwSVBA91GeohQj0pTnnfKpCOPtFbhbC/aQ4uLtwu1kjj2CC157ExyxKYLG9fVsDVAUvRb7LKrjqwz2I+YLW7zuUCiQlr+c7PxFQA+ycWWI9rP7vR1g9y9xrj6JpqRQcPH5jUOL9AU5W4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uhaUVyTe; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so19080425ab.1
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725994603; x=1726599403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqchVH+yQwSNaoTKxBCltVzEmAkSgmfNc2h2nOiBr8Q=;
        b=uhaUVyTe0/dkMbadxMQczF2mFTxRM/Ho0LmIoUXYYSr8O5K6jPLSjsIA6f/2y4KexT
         +h3OpytlXCDPBkBNruBDoTKCW5DG3VQP2DU3w3w63npbgM25A9WL04iWmViSkGE9ICr6
         Liz3ByaeDp1jDRijnwGeRJuMgLZLCutlS/xqbGGVUSrIZWJYKtTop/RFHshwRlUuZ/tJ
         nx5G43N7JMUIkcVoWOpfiKzThJ0V8cIw8gjtBOPJ7eS4wAmr8/eKvKh2voQCnCPTPmeO
         uGtPVcvaji6vTKk19w+Ki0vLoHqpaGreh/biPOjfMcSxSmkyqnMnNK4GvLSOgIy4T2O9
         53aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994603; x=1726599403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqchVH+yQwSNaoTKxBCltVzEmAkSgmfNc2h2nOiBr8Q=;
        b=G1uaLAKaGVC7NUK3agpaRFnEK3iM3fVPi/gKGDBW2tn3Tfzfvu9D3MEVqj+ltuxmd8
         L0laJDjKpKiFJhrAa5u/+c84WFbuEHXjH0NcHrYV7wyI+hmN1c1dWR4zSMeBcWLxVGYb
         Lho5YBa6Hnig2G8NytNXs2NtiXE5ykKu40qfYmZOIyEGZlO13POVByOGWkLqJdE9MfyO
         X6rmgPxvSkXnbSzSaTOgyauLPwQrBpx0czUIgw6S41W9sTN8f2poPIxKzESCIyr+DXIO
         dKkLSkg49/4nsUiZ9nKZYWhqLHyGPqXnk7CAkHOLvz6Qwjg774w1Txoey84BcVOIPwE1
         hmhg==
X-Forwarded-Encrypted: i=1; AJvYcCXvQjNksZl5mi1VDP4ITV9+hO0yEyn2fz9VEMJJ3N4yhw9uia8v28iKAadUGUAZ6v1LsqiTkM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN0iB+QZOfQp9wIpGYsghr+nDzYEKO6+q3/TNcLEgjig9Qpui6
	5ddGvUF5iNIusNJzs+CSyIenqrCIZuT5fd14gsKaJxcMTSclHkiMP/KtTkT9Hzo4Bsbu8BiwR4O
	+
X-Google-Smtp-Source: AGHT+IHMp7hRi8XX2MGmuaa2yCo+AysJEHJ99Yel5Aud3FfWwtuBx5wNzIx6hwxMxbWGsYQU7oTUTQ==
X-Received: by 2002:a05:6e02:1a82:b0:39f:5282:3b9f with SMTP id e9e14a558f8ab-3a0576ae56fmr109157455ab.18.1725994602633;
        Tue, 10 Sep 2024 11:56:42 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fc90a3sm21630085ab.7.2024.09.10.11.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:56:42 -0700 (PDT)
Message-ID: <c777a300-964a-48dd-9c4d-71aa09c317a4@kernel.dk>
Date: Tue, 10 Sep 2024 12:56:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, Netdev <netdev@vger.kernel.org>,
 linux-ide@vger.kernel.org, cassel@kernel.org, handan.babu@oracle.com,
 djwong@kernel.org, Linux-XFS <linux-xfs@vger.kernel.org>,
 hdegoede@redhat.com, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team <kernel-team@cloudflare.com>
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org>
 <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
 <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
 <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wj6o-GwyT=7nEfmHKz0FcipfSQwV9ii1Oc1rarMTUZDjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 12:46 PM, Linus Torvalds wrote:
> On Tue, 10 Sept 2024 at 11:38, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Curious, does your init scripts attempt to load a modular scheduler
>> for your root drive?
> 
> Ahh, that sounds more likely than my idea.

And if confirmed, now makes me think I should migrate that to the
6.11 fixes rather than 6.12 where it's currently staged...

-- 
Jens Axboe


