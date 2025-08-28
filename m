Return-Path: <netdev+bounces-217672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA21B397D7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481507A54B9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF19C26F281;
	Thu, 28 Aug 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOp7+ne1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66974EEBB
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372250; cv=none; b=i1Rm/kWsA0CT/b3ORMNqPMk1KZmamjc2jVudQFkYf632FTjvY/SresBJ0JxyUPVtwGmZivwYWqWO5aZtgLKimNacNGGA/SZKPG8MSdvUrGP1Hw7SFefC3gGfS7Ra1p9/6EygF+LzX5xsEOGR4zMYoTSMZfqShw5xpp8LauEr/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372250; c=relaxed/simple;
	bh=w6SANh9M41Cz/FJdilTI2rNWrEJavLzRaQZtNc9gy9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWlBS2HcB/WR9nDgGPIoE93sjhOr9/DctKOt5t4WLUEbSdLTbEWz7gZ18UE1BaGolzi3t+NF2rmYWVFxemz992+Xk8iaM6yDlG0iKLPZxnFEAxEgDmdUEl83XVdNwCF6CRb7OE7SciUCkZymk4pr2hxN1hv0QYcqFyc3rJGA/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOp7+ne1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756372248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nKlwPKezbuO9xwAGZFmpWVmFnAyIOSinJ2mEOrJ9HXU=;
	b=HOp7+ne1UuIug9gUp5+AqQKsKNuNSs56RQV8FdlPUKgG9JfT9Hj37dMWDe+Nwszs913UZu
	48v8XxjzHZzsh2RcKivOqIzvbE5XzGAbAUDJ/7gt1agJO+RcprV8tK+pJGCMGYVgBVAG9W
	dZ2H3SygqSeO0T6QA/SSyUjSNicF6EI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-Hr5bkH_VPZODPgTBInTCLQ-1; Thu, 28 Aug 2025 05:10:46 -0400
X-MC-Unique: Hr5bkH_VPZODPgTBInTCLQ-1
X-Mimecast-MFC-AGG-ID: Hr5bkH_VPZODPgTBInTCLQ_1756372246
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71fb88c78afso5241857b3.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756372246; x=1756977046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKlwPKezbuO9xwAGZFmpWVmFnAyIOSinJ2mEOrJ9HXU=;
        b=ZM3EJjXaQxjYehwDtwHFtrHOAha+G0MtfAmse2jyvsNXNZVrHAe4ba8j4dyJRD2p0h
         Yj49qikMSOLFuBeoYc0bCfD9C6wYmrftyHB7FKlSHrSlkb2dJnxNF1cpA5/dHCDCaXCs
         aUzSik+JwMmzsYjfkV4vL8dpXSo85baTzINDOhmbX090F75eXjj55o4DZ4eKJHbLFvX6
         tOA6WbEX7tuauoGoFcUGo0bk5NalfvIa2KDZaMBMQxgYVIo8rKwqymD3gK/Fciq+sJx5
         rjA66JMbxsYt8FNxpZ2vXyjAfLrOcHbNvnHvT/Aan42d1F6+Uc3ozgqRZi6zVo6EVWnB
         otRg==
X-Forwarded-Encrypted: i=1; AJvYcCXUCelBUVmdISGsFpqvzs/O3xqLDsswYBiqmGtma/lLWcnx57pm9U3LPkd+oMJwPebl/U43EPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVliiukXsSGPCIj8pSQh0T7uGbIVEVlLLQllBbuufKC0cm+sm
	y3CWD2RFzUopjNLziyaRmoKALIvyEyJEKwM5VseJ+V6Duc+uwa8aQ45+mtXEdTx+282tli+Fjrc
	s6IToHS1XqOw2Pb3kAJRZsay2Ho0ln6Ptq2k4dmd4zgJIqQ1P+vh0pCFZ8A==
X-Gm-Gg: ASbGncsA9D58uQzThyrzYUSZags3Wmgzs0+DIqZmip4mCU0H6waObvxNjY90olXiab6
	d59gb2R4UBNVb+NB4oGza7nT/mx2IeTMKP82n/Lr4h8Rub8HhbhlDSpncExvCyUpsfJJFZvN2OO
	utz2sNS4ZZjpqPbb/jXLlx1xxzOqyJUydHt1kZPDKflwkZzko9KMMRRHs214jzBKQM9CQqlJdUi
	hik4KZYNcZXPAW8EGh1K7Vig/z98QPULyelHW9g5ifp3C6H4Hm93zN3fRU2eZYltzLNn31x4ZAJ
	Z1L64xVO1JA0lIeBfbkcqQNws3r2Js9XkUd5NWCwBGdJvcJYfWzh9ntL4cDcM0+6NFKBhDDWabz
	GeNnpkRyhRjsRdUY=
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr254131077b3.2.1756372246201;
        Thu, 28 Aug 2025 02:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6sWncGKqn1v4/1RP9QN/2CTRKrNYh1qBsv09tOJjEFxNBC/SRSbycXZhflbiMWoycIj9R3Q==
X-Received: by 2002:a05:690c:ec8:b0:71e:7ee9:839a with SMTP id 00721157ae682-71fdc2f17e3mr254130717b3.2.1756372245672;
        Thu, 28 Aug 2025 02:10:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721583892efsm5988377b3.2.2025.08.28.02.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:10:45 -0700 (PDT)
Date: Thu, 28 Aug 2025 11:10:18 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: "open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>, 
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] vsock/test: Remove redundant semicolons
Message-ID: <rz5brbahjthbpdl7k4g47zugrofw3wj4fijl5aejwteumtsjiu@3nl2sfyvbp24>
References: <20250828083938.400872-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250828083938.400872-1-liaoyuanhong@vivo.com>

On Thu, Aug 28, 2025 at 04:39:38PM +0800, Liao Yuanhong wrote:
>Remove unnecessary semicolons.
>
>Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
>---
>Changes in v2:
>	- Remove fixes tag.
>---
> tools/testing/vsock/util.c | 1 -
> 1 file changed, 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>index 7b861a8e997a..d843643ced6b 100644
>--- a/tools/testing/vsock/util.c
>+++ b/tools/testing/vsock/util.c
>@@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
> fail:
> 	fprintf(stderr, "%s  val %llu\n", errmsg, val);
> 	exit(EXIT_FAILURE);
>-;
> }
>
> /* Set "int" socket option and check that it's indeed set */
>-- 
>2.34.1
>


