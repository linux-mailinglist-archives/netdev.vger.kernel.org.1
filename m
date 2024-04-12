Return-Path: <netdev+bounces-87508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711D8A3556
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A4AB238BF
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF6B14EC75;
	Fri, 12 Apr 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfOGZUml"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3C14E2F2
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945089; cv=none; b=XqqxeZwf64++DxO/gXTcWURePRds+tXc/PleAZ7wBZZEhOm5f3b2y1+eTCxvlGPoU4vsOUP1Dl5Y+v5MnbJNtyKpaW2kW8+XBFTOWuKiUlcsbJAoJ0qdYaynco/2X8KuDjS6HruMMfgupHffY3knX3PANmChQ5i18n539uq4vJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945089; c=relaxed/simple;
	bh=y14HCBiRDXjbriFYhDvBSNVPlnyZ9Qt77utcNkMnhX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOSgfioGi3/5v6+zYU9u7eVpvvyqoqnRWwf6TXjD2Q5B+j3kTsbVoZyH/OHrbAphLHkQwG5DR8Mf1ltHViJ/NqV5NeYDOM1mHkZSTQR0kA5nd810YGRrmjw+JHposRX/asb7C7TWAJUga1M1xNmvweHu9gnKfA8AxBR9VT/i9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfOGZUml; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712945087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8W4/6Wi6zVBBYBvNPYUnjLrO9SZ46yDSu1ieJhgGgQ=;
	b=KfOGZUmlXyH8ZTtRgPrxmfYX/4d5Q/ZWu+7BtwfMJPYdD/f5UvbGOwp3Yx/0K7ga2DuZam
	jiI52illg793GIrgqXdslZrZkt15VfPhp/CzvgxIHTk/KuzEjzlRTpLb4g8jDsiOvYJut6
	MlUNXe49rUHa73z3O0bWRgIHiT0qITM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-w7B_wYk2O32KUUAv9pP8BA-1; Fri, 12 Apr 2024 14:04:45 -0400
X-MC-Unique: w7B_wYk2O32KUUAv9pP8BA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5244038f0dso8614566b.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945084; x=1713549884;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N8W4/6Wi6zVBBYBvNPYUnjLrO9SZ46yDSu1ieJhgGgQ=;
        b=cvAp0o1UrrV0lKKehayuSD9yaME8K6ACEhxTvGngKatPgfZ8zeTg8Uuc2DtY9yLj5u
         jdzHYe7kHlbB/zz3/8nyb79XiopNSoxEcrS+tFJ0s3TS9FFGqPEvfVfBQV0sYo5J0p0A
         hDGeImQtggngCAQ8xXqliZXz5QKE0s4lsThZ8dZkLN3tqG3pCq78j23aeXA1E/mggkWE
         9SFePmt1qNEtxq/4KgoN58fLDHXQ69UOTe3Ked1Y1zSUzkcuVffVGOwgVgNjNJPRn1Nt
         CpH6Quw5FMZAM5nyREshBzOqdv0vPs9RPuYjbs1PwEf7S2d5NvbcZRBy6kQDA73TWCEl
         X+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqArK45DuMEHOejXWYeafFlHu46RpfXMAUh0QsJ09nEnzM8VLA3oGVeyiiMfni1HEf3xQfVoexsvC5bBCyhRASClYfBwUt
X-Gm-Message-State: AOJu0YwzXmj7JBgOmLF1AxJNv6YC2ljvaPTZtp0uRWiQ5EqHHRJHIHlY
	R0MgPSkV6nE8IhokWbHa/wQhLk8b07N+aX3brpnbITkOwJMgYCO4sIxk6xs92WTLiJXYnkJRzlr
	KH12fm//I0goApRjOLnfdKj778MStfe73CvdnyPIXsAqsGgjOwFUXWQ==
X-Received: by 2002:a17:907:c1e:b0:a52:2f86:bb19 with SMTP id ga30-20020a1709070c1e00b00a522f86bb19mr2493122ejc.15.1712945084244;
        Fri, 12 Apr 2024 11:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7HN4yHrIL2HAcbtuvaiGM+DFQvlZMjoTsnCMfrZefcb5w7vOiCVqcObYYt+lc+WK6uGlTPQ==
X-Received: by 2002:a17:907:c1e:b0:a52:2f86:bb19 with SMTP id ga30-20020a1709070c1e00b00a522f86bb19mr2493099ejc.15.1712945083753;
        Fri, 12 Apr 2024 11:04:43 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id w6-20020a1709064a0600b00a5209dc79c1sm2090085eju.146.2024.04.12.11.04.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2024 11:04:43 -0700 (PDT)
Date: Fri, 12 Apr 2024 20:03:53 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
Message-ID: <20240412200353.3bccfc85@elisabeth>
In-Reply-To: <5d568006-eed3-48ab-a49d-3752096cc39e@ovn.org>
References: <20240411180202.399246-1-kuba@kernel.org>
	<b4e24c74-0613-48be-9056-a931f7d9a772@kernel.org>
	<20240411140154.2acd3d0a@kernel.org>
	<20240412192200.662d92ae@elisabeth>
	<5d568006-eed3-48ab-a49d-3752096cc39e@ovn.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.36; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 19:38:53 +0200
Ilya Maximets <i.maximets@ovn.org> wrote:

> On 4/12/24 19:22, Stefano Brivio wrote:
> > On Thu, 11 Apr 2024 14:01:54 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> >   
> >> On Thu, 11 Apr 2024 13:45:42 -0600 David Ahern wrote:  
> >>>> +	/* Don't let NLM_DONE coalesce into a message, even if it could.
> >>>> +	 * Some user space expects NLM_DONE in a separate recv().      
> >>>
> >>> that's unfortunate    
> >>
> >> Do you have an opinion on the sysfs/opt-in question?
> >> Feels to me like there shouldn't be that much user space doing raw
> >> netlink, without a library. Old crufty code usually does ioctls, right?  
> > 
> > I think so too -- if there were more (maintained) applications with
> > this issue, we would have noticed by now.  
> 
> It depends on how you define "maintained".  Most application devs
> do not test with unreleased kernels.

I haven't, either, but users started shouting: we have nowadays plenty
of distributions shipping unreleased kernels.

-- 
Stefano


