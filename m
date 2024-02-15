Return-Path: <netdev+bounces-72043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E315A85645D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218141C22480
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FF130AEC;
	Thu, 15 Feb 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAzxL4oK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9D12FB3A
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003751; cv=none; b=WDtny1GAsDZRr7KJjoo0X9sn1LK0+0pM+kWEcBFpLKP/wn8JOGXwxlB7WxVK8MooGLUkvoJX23v9WF1cZYhscvDJIdy7ITnqwlW8Iy9o+EdWsOJ3kPiJdLQYNr68AbL8eeiu5/hVBehS1g4A1tTkvnHa2InZJEDvzxQQE1q0uRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003751; c=relaxed/simple;
	bh=5eeVkjyvudX/pKW1hZPYEgCAdxgDwkfCTULdfvhHo34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikA0wOag12s/zcQMoEHupTJYnBi0ATVF2hMUs76eT4lI516c58XzXBIGDJ8ruGA+5Du6xFhHU+xKd92lt5cBM4lt4nCTMh8ByBQ1jiFHlVHxzaWLWl5CYcW2QQO+U2P8kQSDeDIsepLEIRI1AcohTw8Vv3vMbj66QKrUOXYk1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hAzxL4oK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708003748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eeVkjyvudX/pKW1hZPYEgCAdxgDwkfCTULdfvhHo34=;
	b=hAzxL4oKGUadZyghNALNPr3EksB5b6cQku4DbT9sv5RpaDVWWLB92sc4NrKSImtzmt4Fbc
	9/lpDThgdFMD05ueZaPQ2mxQWH1O3U1RJi1Do/qWb+hiJbiXhmHpDhygN5kQu/QtLBeV+y
	QUn6OD61rz4mss55F5E0Fq0laQbHUm8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-rrjr78ZzNTSwMRN7gkGnnQ-1; Thu, 15 Feb 2024 08:29:07 -0500
X-MC-Unique: rrjr78ZzNTSwMRN7gkGnnQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3c3f477eb7so42061566b.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 05:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003745; x=1708608545;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eeVkjyvudX/pKW1hZPYEgCAdxgDwkfCTULdfvhHo34=;
        b=OnsF62ggoOJz1jPYHN1ErWtKe+GutbUPTRLKgaW/2zT3r+6hPeKT/LOdT4k9fmowbr
         ooCntupn3OKfp/Y1i2LhylTlIMdbxJea4sNKsEi/XHmm7q8jW1Xt3hLJ2pNBP13HR2tO
         /afsm7sOJW7xnHajUhCCZ4Nqy44+NyTshWjc7rA97oc8dUVr3TgrM16YJKH9l12miAcd
         2q3bUNrCBZGXgNWSKmfcwAoQJS6oYLchMwt4/SqETUYHkLYvnFnu3vehaGt6RLxHadP3
         bwlj4URKcNXIBsuGvx1MZjcinhhEW7MlUYiLaG4oLt66qohy+wLPBa81C8TfCoVqMA7m
         bfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSruyVPce7DxL+sli/K4fM6zMOd8L6smCcvjGtTJP6iH9S4P59sgyLLH4gf1SgSZQGejV57wRj8zPQX9Zhn3lQ1R+YwcSE
X-Gm-Message-State: AOJu0YxrcmeWsSRzoipKLoucC/cmQ5oR8OThJtMbnHJVPH41lD4snvGJ
	GR/GkszhqpKdiCe45uSkNbvlQdhcyPSHKbVjM2hprYjO37+exKxCXbjA+xa2S7+NT9pAKS73gMf
	07wFU75ADTnQNOxVIrI6AlIbTq1n/QlUpYvdYDDTUJ3+mIJ+wdgCHDTgD6JkIig==
X-Received: by 2002:a17:906:24d7:b0:a3d:3781:6edc with SMTP id f23-20020a17090624d700b00a3d37816edcmr1280801ejb.55.1708003745152;
        Thu, 15 Feb 2024 05:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHenfB7DY75o/58zvNxuONlHdNOgFk3aJKOzSO8iJ3lT0l6WsgAs9wbABWWtdZ7pihKzcwGfA==
X-Received: by 2002:a17:906:24d7:b0:a3d:3781:6edc with SMTP id f23-20020a17090624d700b00a3d37816edcmr1280785ejb.55.1708003744827;
        Thu, 15 Feb 2024 05:29:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a3d784f1daesm539293ejc.132.2024.02.15.05.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:29:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EC50910F59BF; Thu, 15 Feb 2024 14:29:03 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] page_pool: disable direct recycling based on
 pool->cpuid on destroy
In-Reply-To: <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
References: <20240215113905.96817-1-aleksander.lobakin@intel.com>
 <87v86qc4qd.fsf@toke.dk> <8aa809c0-585f-4750-98d4-e19165c6ff73@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Feb 2024 14:29:03 +0100
Message-ID: <87plwxdffk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Date: Thu, 15 Feb 2024 13:05:30 +0100
>
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> Now that direct recycling is performed basing on pool->cpuid when set,
>>> memory leaks are possible:
>>>
>>> 1. A pool is destroyed.
>>> 2. Alloc cache is emptied (it's done only once).
>>> 3. pool->cpuid is still set.
>>> 4. napi_pp_put_page() does direct recycling basing on pool->cpuid.
>>> 5. Now alloc cache is not empty, but it won't ever be freed.
>>=20
>> Did you actually manage to trigger this? pool->cpuid is only set for the
>> system page pool instance which is never destroyed; so this seems a very
>> theoretical concern?
>
> To both Lorenzo and Toke:
>
> Yes, system page pools are never destroyed, but we might latter use
> cpuid in non-persistent PPs. Then there will be memory leaks.
> I was able to trigger this by creating bpf/test_run page_pools with the
> cpuid set to test direct recycling of live frames.
>
>>=20
>> I guess we could still do this in case we find other uses for setting
>> the cpuid; I don't think the addition of the READ_ONCE() will have any
>> measurable overhead on the common arches?
>
> READ_ONCE() is cheap, but I thought it's worth mentioning in the
> commitmsg anyway :)

Right. I'm OK with changing this as a form of future-proofing if we end
up finding other uses for setting the cpuid field, so:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


