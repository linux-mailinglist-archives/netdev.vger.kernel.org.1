Return-Path: <netdev+bounces-138190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C5D9AC8B0
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4919CB20B58
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFB219CD1B;
	Wed, 23 Oct 2024 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH3ywEBV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084631386D7
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729682195; cv=none; b=qy3d57dFLyqI0G0F3K88yMmHWjiRFWCBgW2/QCyX02XXFScn9WBN85CjdqY6oa0nEyYIjIIPidNA+73cOEbD+6ZIdZ3ES3ijhw4WFqNMcETJRUZOjH12pGZ6u3hA5C/2EqjsduAg8pfkb9OXJiuOHGcteFPBIWrQTAOLa6pxXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729682195; c=relaxed/simple;
	bh=GLKqgZ9V1d8X0dCN96VlM1JVlYVSiksnfVr99r6medw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TLeOiVeC7RriiTDMxQIzntTaxpYH9QAFUdTxSxnZF/MI84y8KePVGH0xfxeXPaPYLl1IeNRyaiyfM0VPoAzU8ZA47HUpVWjdsyQfPMa0y1ltWzvfD9sYmm1SeO6omAAyR3icAZwsu5PYkTkudb5rY77T1mIjUuGKjf5HlR9/RHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iH3ywEBV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729682192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yXmDz0l8PctFJHxTV0/3t2xUcJ3IV5Oz4t06mcPzTp0=;
	b=iH3ywEBVvIIuZMUwKmOZQW1ecXDwHB45qS6Qdj+JSLvzppd9O4XMRNyyOZXdIGOojoN0Hf
	wvr3nunTxoEY+FQ55fLPROc79Hi5Z3cTTpeTlUQPv/9kFyx4L9NOq3CUPeAbLk5pB0RbDC
	zi1mJAwtkLqBZnEIu2F14LjPMFlXMb4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Kz4i9XO8O--T0V3TUc0b5w-1; Wed, 23 Oct 2024 07:16:31 -0400
X-MC-Unique: Kz4i9XO8O--T0V3TUc0b5w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d45de8bbfso4765266f8f.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 04:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729682190; x=1730286990;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXmDz0l8PctFJHxTV0/3t2xUcJ3IV5Oz4t06mcPzTp0=;
        b=i90l68Hvg4+iAm+2eJ1jw5W2GVZjiZi9JXnKT6a/t7mOrApzQuJgI3R8fchmLOfBXK
         PUJaidej75jtgCKyir3SVRK/fjzuAVBu/TrRUKbXsqnllpZlci0lS7N0q0iG7GQFacGu
         q75ucG+6k7IiuO+AEHIs1P66xE7yOp4Qy8Ne1vV9woLITok0KHsCWeuufv9Jbl0xKbdk
         Ra6CHLXq1/GvyJwD/MDvJ+SAEHldgvYVEi0BbyRPJBN6ois/eh6YsGk9n+u28WsSF0p8
         RbMsxfqy8RdjS5AiODcB2zklWB6tftWeFvHvVYJCh0KLCtTa8PKaoUxQzfhOMnkbQC4l
         j6Iw==
X-Gm-Message-State: AOJu0YxSzTUyHxKiHNeiyrCvwkRf1AMhroVw8Uec8zVaLat3y0V6oo8X
	8lFurYyi6e+QtAtgNewVWXJQPlQ2pOkO+sp3Tb2D1LjFtoJmWyk1wzHGnD8sziAGuEGTBCIx0SE
	+Cpk/ARCAS+EDY1SpoKtuODhv34zm8kHNWiPzaOEVQKgN9bBrm0bz2g==
X-Received: by 2002:a05:6000:1e4f:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-37efcf18afbmr1825132f8f.28.1729682190464;
        Wed, 23 Oct 2024 04:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlm0moYsamYKrKoMI+J+w1mIwl7w+6kcRBTNWBTI5DSrhNu19H64pCWXSNkmENovB5hCd3vA==
X-Received: by 2002:a05:6000:1e4f:b0:37c:cfdc:19ba with SMTP id ffacd0b85a97d-37efcf18afbmr1825113f8f.28.1729682190030;
        Wed, 23 Oct 2024 04:16:30 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b7dsm8668588f8f.24.2024.10.23.04.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 04:16:29 -0700 (PDT)
Message-ID: <889fad3d-33a6-4e51-83f2-7df9634c7055@redhat.com>
Date: Wed, 23 Oct 2024 13:16:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for
 getaddr_dumpit().
From: Paolo Abeni <pabeni@redhat.com>
To: =?UTF-8?Q?R=C3=A9mi_Denis-Courmont?= <remi@remlab.net>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: netdev@vger.kernel.org
References: <2341285.ElGaqSPkdT@basile.remlab.net>
 <20241018171629.92709-1-kuniyu@amazon.com>
 <12565887.O9o76ZdvQC@basile.remlab.net>
 <cba18775-af46-4ae5-ad29-28687401781b@redhat.com>
Content-Language: en-US
In-Reply-To: <cba18775-af46-4ae5-ad29-28687401781b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/23/24 13:04, Paolo Abeni wrote:
> On 10/19/24 09:48, Rémi Denis-Courmont wrote:
>>> I think bit-field read/write need not be atomic here because even
>>> if a data-race happens, for_each_set_bit() iterates each bit, which
>>> is the real data, regardless of whether data-race happened or not.
>>
>> Err, it looks to me that a corrupt bit would lead to the index getting corrupt 
>> and addresses getting skipped or repeated. AFAICT, the RTNL lock is still 
>> needed here.
> 
> To wrap-up Kuniyuki's reply: addresses can't be repeated in dump. They
> can be 'skipped' meaning the dump can race with writer reading an 'old'
> address bitmask, still not containing the 'new' address. Exactly as
> could happen with racing dump/writer both protected by the lock.
> 
> The bottom line is that this code looks safe to me.

I'm sorry, I forgot to ask the obvious question: @Rémi, are you ok with
this explanation and patch as-is?

Thanks!

Paolo


