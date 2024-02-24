Return-Path: <netdev+bounces-74676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FC86236D
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 09:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1343D1C20EE0
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 08:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29E4DDDF;
	Sat, 24 Feb 2024 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxfqPcgo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31BC14B800
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708763147; cv=none; b=rUHa3CeMX7bwKn614v1PzjMkGE0JFgiteBL57Tofzkm/aZrbA3fgZiLBAdbcZ3dbMx4KuIdP+NoHmM80NQhYrX9RffTzksIxDmsv9Xe7qxdkZaXCg9b79kEPYX3x32Dh0HPLdjUWIsLPOAgHazNDMoXFDqKN900dZdtFwnWY4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708763147; c=relaxed/simple;
	bh=Z5IwZFN6wzvJEjJG/SfrJEnp2JT3AgkmKbLowH8+v4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWEekuxMKmFnOkZgD/70vKXe9Qcmye4KbFuxkOc9q+I8iaLNus+nUaz5j9hNb0QsU8Xuzax9q7QukAh8swrjGuMXmz/sssqcDl5Q/AWYlvnV47cFHJoNC3UectOeKGvOqgfOrnly835mN4hiN2WwBGVm/+AFHSZBHh4eJvDTo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxfqPcgo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so3639a12.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708763144; x=1709367944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5IwZFN6wzvJEjJG/SfrJEnp2JT3AgkmKbLowH8+v4M=;
        b=SxfqPcgohu2rs6Rhu8AwiFbPf+T95wrb8VP+HOg+/gtmswVhJr7t3StNhOJSrVo7az
         bQZCp1QPLgYrQUMeQxscbkaE2RufYyNGQpMJT2qZM6EMhe3MSNkzLsByzrZnlGnx3SKH
         SAo/v3gLwlGuIjRVG3RFk44RhEDxf5E9Z32WX8wnv9q6zNjeY8rUBwU3GcIJccB5fzfZ
         qnIo9Bk36v5OMuihuIDNGOzzF5YD05+PH4gTLSTCO1ZK7jS8FvtmHWAcknyoipqj4OSc
         xN06S1qiAJIDu/538GcFvTHjms+gwjgqTlR2L/K7EoPyKN6cH714iYxj1A3k4iF3+eHD
         Ot6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708763144; x=1709367944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5IwZFN6wzvJEjJG/SfrJEnp2JT3AgkmKbLowH8+v4M=;
        b=ACcLZjxhm8ncWKSRgA6Pvaz6an1MXhD6CwkOqnRuF8+GMZ6wlbl9prZJ+flOhsCjC1
         oElp01t2TT/r8khxe5T4MVUbh/grr7kYmtYIzfQr/YlaKb4KCSsNcN6aDHvOIgSMaL4h
         yrUtpjJC2ilk0Qp8M/jniO41dUx4sgZ67pBIDn/ZfxPrPXrn246IaSV+42KWYxyDtjR+
         fepaDPmjKqSsNBBeAq77LcVsaaW/+0LLb2RbiwAs33a1qqmNtKeglWvUHly59DS5smHF
         IQaxnOC7eibsoNYQp6OLklstWjJitHEodLk+WQZbhheBXoTG2voOCXK4J+go1z66MPUT
         YQTg==
X-Forwarded-Encrypted: i=1; AJvYcCUhogKAKyhfYudGqDCAaqaUGIvu66LxwN/rC5KPMgHaMhMWxlL8WhK3IcchQsZ1ni2YReRc3/dDQYn2abnFwiYqKAgdLlev
X-Gm-Message-State: AOJu0YzV+dn7kFOOFOzyVvwYJwvZMuUGEaiXfeNsXfMs4ehFctc1s6M/
	ixcgPL9u0KkdmFFk21BgclZV97xU/XeGLK4wq/j4hkSEtzZil4t4qatjeMBf4RfIsAvvti0WErq
	t9i62s1hyxmuCjq2znPs+qHOa9Y8mZMXdOzzL
X-Google-Smtp-Source: AGHT+IEw3UIy6F3kfkk6Vc1jDdePDYPmmVrdb87ueGc+FU1c2LfDni9B631IwRghSONpK6MQAeBWQJndJRV0wgsdtcU=
X-Received: by 2002:a50:f696:0:b0:563:ff57:b7e8 with SMTP id
 d22-20020a50f696000000b00563ff57b7e8mr135440edn.1.1708763143953; Sat, 24 Feb
 2024 00:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223235908.693010-1-kuba@kernel.org>
In-Reply-To: <20240223235908.693010-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 09:25:32 +0100
Message-ID: <CANn89iK01o0eRyo+b=CMq6ykzymRjp=y6vVq=TRRDMysPeUynQ@mail.gmail.com>
Subject: Re: [PATCH net] veth: try harder when allocating queue memory
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	Miao Wang <shankerwangmiao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 12:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> struct veth_rq is pretty large, 832B total without debug
> options enabled. Since commit under Fixes we try to pre-allocate
> enough queues for every possible CPU. Miao Wang reports that
> this may lead to order-5 allocations which will fail in production.
>
> Let the allocation fallback to vmalloc() and try harder.
> These are the same flags we pass to netdev queue allocation.
>
> Reported-and-tested-by: Miao Wang <shankerwangmiao@gmail.com>
> Fixes: 9d3684c24a52 ("veth: create by default nr_possible_cpus queues")
> Link: https://lore.kernel.org/all/5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gm=
ail.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

This reminds me a change that we should do in
netlink_alloc_large_skb(), using kvmalloc() instead of vmalloc().

