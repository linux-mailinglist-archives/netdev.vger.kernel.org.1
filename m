Return-Path: <netdev+bounces-137936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315549AB2DF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D7D1F24D91
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706219D07E;
	Tue, 22 Oct 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyiAQwbb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D1419B5B4
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612593; cv=none; b=N5KjMJQcYe+jmwq9jc0HFqSloavTCPqwVWstMr366dUAcQ9toIg1hF6d9uKW9kXEtK71uHq6L5g2KLF5mklFJ9wPXVC9tecTrwTn/oa1K0mhr+m5nKSNCs7QY5yQ/qbazjtWMGqyiQzqwRIMSpgy8yHLpec+KIiwhRuNWR2dQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612593; c=relaxed/simple;
	bh=H40XDPdiMOoE1eQUT8w6p9BaheXGFq32yxKHOfxRzeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKDvKAUgncHOD/wEP+ve66agqos4rDRqQXc47JtFDhPTBBt7FOxvErDPzJhGegwAZy25SWByqdI51KeiwZDzh75QIqQOPORZ5oi2ehmwzVq2+1zR6bLEH53BmPiU1AaKva79V90Hj6GcJl5lgclKPqQrv0WRL5ptkEkKaNqC/MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyiAQwbb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3710295a12.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729612591; x=1730217391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tegbBlsEkO8C8TbRFgVBlJl/+mX/6QwVoXuzF2v9Y78=;
        b=gyiAQwbbUMJmeL27VBbnTUfhq0C4RtDzxT97h52ZEjDFyvnY3brULZhGediKy2aj+d
         ryaoikbTUyigfEH/UcaoDxIE5jLrpn+VtwsA4cIRlG6/p0X83OB2+KxwHV3LAnIU0Fwp
         MoD3RloTBTgvz1D0mbDPRzh+80dFXW1ARKTA4e3QeTjtiiSq3HUNBceuQ3epZJo0NJ2p
         pFrqmH8adlcd7NhNY4HlqOnXip9nWzXriWc9yjzmz8aJqA9Jf+r0kvUn7GjvPfSQcbWu
         hgHYOg5ZRkc9NkM9yxoKi+06X3GSsKfC3lFM3A4IE3NlcQNzm1sjfSDX71en0dChxDsx
         aPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612591; x=1730217391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tegbBlsEkO8C8TbRFgVBlJl/+mX/6QwVoXuzF2v9Y78=;
        b=k5hYXPmbiVMkkqalm99uc2x1sdvI8bvDsTvPl3sz5sdndRXiYpkr82lIFSYuBfMcwt
         Kd+ZlESknznq1l3mg/uuYMwktLB18I6pT8PVs+8chcD0QNoxPj1sZgKzBykxOyZwgZRF
         uCs7+k9bNdzbNeYHADlWqGMgYoJAV+8thUCvJaeuTBUF/2rzbQ855JUz/6mODJ2NIEB0
         5YlhjOoMRFkgcUHWgN9kbwhGU0lofvaWqRi+9Ms+FdlpvI1/HEuQdiuHtL+Bi7BeC2Kn
         D2hnyQozPuUjPgJNtDjps9/XHgGo8/gw0mJYwACyoST6lFZmTEGs5eYvJaYS2U+f66O3
         OSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUstSY7KslNNqIsUlwcdaneh4h+EiG0KQumszuf9NBQ1AOt1wUXNC15kbHXF6kjpMMv789OJq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypN5sATpDRWDQkjJaX8aNx6sKg9cmae7zNoIaOmZdduBIdYuck
	V2tUuLvYYXpcVCoTG0MGStYogL2MM1lAckknipCRzJ3OezNvyKc=
X-Google-Smtp-Source: AGHT+IGG+Ul2McG076mbKJjq+5mjz8HQyLX/mpaQiac8rXIeo6+TA2j7OZBAyduVHLRmVkBgjj6+Ug==
X-Received: by 2002:a17:90a:4e0f:b0:2e2:e530:508d with SMTP id 98e67ed59e1d1-2e56172bbaemr17645444a91.19.1729612590805;
        Tue, 22 Oct 2024 08:56:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad3892bdsm6395291a91.31.2024.10.22.08.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:56:30 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:56:29 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next v4 03/12] selftests: ncdevmem: Unify error
 handling
Message-ID: <ZxfLLQ7C8HV96Hzs@mini-arch>
References: <20241016203422.1071021-1-sdf@fomichev.me>
 <20241016203422.1071021-4-sdf@fomichev.me>
 <5cfc763a-2d9a-4d87-8728-19db3f8e096d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cfc763a-2d9a-4d87-8728-19db3f8e096d@redhat.com>

On 10/22, Paolo Abeni wrote:
> 
> 
> On 10/16/24 22:34, Stanislav Fomichev wrote:
> > There is a bunch of places where error() calls look out of place.
> > Use the same error(1, errno, ...) pattern everywhere.
> > 
> > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 9b3ca6398a9d..57437c34fdd2 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -340,32 +340,32 @@ int do_server(struct memory_buffer *mem)
> >  
> >  	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
> >  	if (socket < 0)
> > -		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> > +		error(1, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
> 
> The above statements should probably be:
> 
> 	if (ret < 0)
> 		error(1, errno, ...

Agreed, thanks! (and it does seem like inet_pton sets the errno)
 
> >  
> >  	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
> >  	if (socket < 0)
> 
> The above statements should probably be:
> 
> 	if (socket_fd < 0)
> 
> AFAICS 'socket' here is the syscall function pointer. I found it strange
> the compiler does not warn?!?

Huh, how did you even see that? :-D Yeah, the compiler is all happy and
quiet :-)

