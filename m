Return-Path: <netdev+bounces-160866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B6A1BE5A
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 23:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C6A169B14
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BEB1CFEB2;
	Fri, 24 Jan 2025 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUftYcVj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D7224CC
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737757099; cv=none; b=QTsH4UE/JV9+jiqIGDA7ljy27aj4eXVraMdYUIBz5x4Vr8xr/OU+ZVFjxm8ZDg827aMWCND9OCHQg+iM5zbaNekmMI9XupS98Qmt5Mb0jaoIKMnYMc2kcNAZdYeKU1LiQBxcub7HxNZxkOFB2G9JXZVEAIjna+WojWJ+ze/+DIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737757099; c=relaxed/simple;
	bh=xdKI04wq4+0byfaeIDs7tw03nc50FyekufaP1kXdG+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rA0jafzD8LLin+fwHN5m77xIB0XD8XmssGdzpH8BZsTVnd1nm1IJuSTMHqiFwRE4UXKJwB0iKW5FGuimewMj41aKzsSebO2bxRUvl10zyPA5Zy5f8NqrTxfXjH5avocDJiL25EF7Xkzh3N1RxOOuYJmaWfwZXKIzPEpmsQflBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUftYcVj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737757095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xdKI04wq4+0byfaeIDs7tw03nc50FyekufaP1kXdG+E=;
	b=DUftYcVjFm54B9ZkpLlFG5k14Oh7C4B3JIU7kOyvtB64qyiM3nglTgt6OJd5zttccZRx8i
	nHGd4tt5S+COxHc3PIfUehnT4osjj4ArSAT97W9T63DY3EZ1XAGwbXeHB2BXfZ18PtgUGC
	kSyB9pUXtyx9gVgwR6sfO5PCSVMHCDs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-QijWSJokPy-iPzSHsi7Dag-1; Fri, 24 Jan 2025 17:18:12 -0500
X-MC-Unique: QijWSJokPy-iPzSHsi7Dag-1
X-Mimecast-MFC-AGG-ID: QijWSJokPy-iPzSHsi7Dag
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa6732a1af5so308925766b.3
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 14:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737757091; x=1738361891;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdKI04wq4+0byfaeIDs7tw03nc50FyekufaP1kXdG+E=;
        b=lASUjVErhOa5abLMXmo9V0r8c9anxnm9VvqjDrc8j7i5ahTZnw8tv26p+OAR6GW+19
         JdckdBOOiTT3J+wJQFalTM8buctElNKJvYb/VaBNpd7ix/dr998+uFo3wDrnvKCnC+xf
         9IMZ1FPy9MIiHm2mtGQiiR/16o31t3JwDfal4uoRQEaAByn4xAoQ+8A8INxLPYD2pNSW
         m7+YWe8qGA01q505DN9V9wSZR2kAcTmVpvcnyPQlXhLN21rDHHSfGiXMsrpuvZN4hAtb
         IxFjOHdMzZ+U2p+q3GhYXJmeTBmog/XAkuLofr3uHIetWDxSTBLorfREa+jCXVnNhdXa
         CR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWocc/MgWe5rdUBGjQkYdFHKZfDGhK5wQjS4C8alftNy8OXZJJp41OC8XQqzFsthkGY5qF1urk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrXdlsUvAEQ+odDjlDUchcCbjknaNuA72DdEvssTXE16P0try
	gaqQGlqXD5RGk/czAVViYzx6MGQu+LHS4PaB8GqgAREc8J3HJY6NNFCe+jZOzE9zgBu7QYdQjDM
	rXhPMk4niZUZg3qYOf2YqLJknL2hlUN9f2wx68zi8SpeRtnPxFiBdNQ==
X-Gm-Gg: ASbGnctenYXEsxM8LsODLkjerXzsqJVTT4kICSo6QYBqD3ar6GA4W+2oVzHsyVZQuUI
	JFgKB/obwQuO3+nQV0DdK/t9nXtt19Ouz+U1z0glSm3iKrJfP3bZZtnWgnyVEaogRwhOkz/w3OW
	p49WBOEromsr/za5rWMjd46o/51zOE3HEQgn3JA+dnDIzfwaPjsCALLsjiWAX2mi0SbvANzsC9y
	ia5XrgBVxifGaBY96nXRyOXUx0EtrnWt+6TYnLln3sr70tsSMpkUpHaGYIhYYt+QgZBBCuJ1fIE
	xQ==
X-Received: by 2002:a17:907:7f12:b0:ab2:b6e2:fcc8 with SMTP id a640c23a62f3a-ab38b1e1e08mr2919699066b.10.1737757091311;
        Fri, 24 Jan 2025 14:18:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyJMTAHFRSD+RMPQs+IDIemdovmgEK9+a+hDiBLsFb6ybvN5Ztf/esB+3ZNSg5b9nGdB4zgQ==
X-Received: by 2002:a17:907:7f12:b0:ab2:b6e2:fcc8 with SMTP id a640c23a62f3a-ab38b1e1e08mr2919693966b.10.1737757090357;
        Fri, 24 Jan 2025 14:18:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760ab0bcsm189769966b.95.2025.01.24.14.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 14:18:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D082C180AB10; Fri, 24 Jan 2025 23:18:08 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, asml.silence@gmail.com,
 kaiyuanz@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
 jdamato@fastly.com
Subject: Re: [PATCH net] net: page_pool: don't try to stash the napi id
In-Reply-To: <CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
References: <20250123231620.1086401-1-kuba@kernel.org>
 <CAHS8izNdpe7rDm7K4zn4QU-6VqwMwf-LeOJrvXOXhpaikY+tLg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 24 Jan 2025 23:18:08 +0100
Message-ID: <87r04rq2jj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> On Thu, Jan 23, 2025 at 3:16=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
>>
>> Page ppol tried to cache the NAPI ID in page pool info to avoid
>
> Page pool
>
>> having a dependency on the life cycle of the NAPI instance.
>> Since commit under Fixes the NAPI ID is not populated until
>> napi_enable() and there's a good chance that page pool is
>> created before NAPI gets enabled.
>>
>> Protect the NAPI pointer with the existing page pool mutex,
>> the reading path already holds it. napi_id itself we need
>
> The reading paths in page_pool.c don't hold the lock, no? Only the
> reading paths in page_pool_user.c seem to do.
>
> I could not immediately wrap my head around why pool->p.napi can be
> accessed in page_pool_napi_local with no lock, but needs to be
> protected in the code in page_pool_user.c. It seems
> READ_ONCE/WRITE_ONCE protection is good enough to make sure
> page_pool_napi_local doesn't race with
> page_pool_disable_direct_recycling in a way that can crash (the
> reading code either sees a valid pointer or NULL). Why is that not
> good enough to also synchronize the accesses between
> page_pool_disable_direct_recycling and page_pool_nl_fill? I.e., drop
> the locking?

It actually seems that this is *not* currently the case. See the
discussion here:

https://lore.kernel.org/all/8734h8qgmz.fsf@toke.dk/

IMO (as indicated in the message linked above), we should require users
to destroy the page pool before freeing the NAPI memory, rather than add
additional synchronisation.

-Toke


