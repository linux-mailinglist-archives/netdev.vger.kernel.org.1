Return-Path: <netdev+bounces-111909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D6393415E
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 19:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A990C1C21232
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F0C181B9A;
	Wed, 17 Jul 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3g9MyML"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC61E4A6
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236900; cv=none; b=KD4EQwv8dDMRSFrK8PYQ9Lcv903T+k20AXG6obGsZpGSueB6wGoL9onpekpCO/nK9fd6RL4OGonn8bxEzi1IjO4HAQopTxhZC4D1vSZGX+LhG97WyznpnU/AO4VAvbiFdTtcKlc4xxWe8ROVCdu2r/tUbrBCWqcP7r4IMHEi/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236900; c=relaxed/simple;
	bh=8Pb2z5ybh+q+/+t+W8q24RGbCjJ9IPbqOhDGpQfX0dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6abAChiOFI+MtRSlZSpwdmCajGz/JLJEh6OxtpFIOhEZTmzqelJrRx4oM2wcbiHa3eZL7gvJ6eJ8jjfaMkDjL9m7HtITLmCxbJops4ZTJ6h+c0De6w9beCoKUTnh4rq8KVuvBDQ4V9GVSsVybPUNPm9JqzvEJOR3urFkXBvprA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3g9MyML; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721236898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YX1GRcU9sKy/uXFsIBsY6ZH3nyOB2unYC6GpQ2d0URw=;
	b=d3g9MyMLcc0a60vchDBCVVrSLTnJ2tyL+K6NEJ7zQrG/odWqPlY8hk5SiYhQICrNai0mql
	XGsKnoJ+XFBhBnZPhYvwJFfEasjpAy2nw5tCs5SKgSbka6C7INKgk81k8AmqFEnUtWzFw+
	dneG9znOX1L5ahU5rzJNJLNby1hyVE0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-VS3qAQyfOgucT6umwKzpSg-1; Wed, 17 Jul 2024 13:21:35 -0400
X-MC-Unique: VS3qAQyfOgucT6umwKzpSg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3678ff75122so4683043f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 10:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236894; x=1721841694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YX1GRcU9sKy/uXFsIBsY6ZH3nyOB2unYC6GpQ2d0URw=;
        b=AASRsowtzd0fgXXrH0Mi/yIruCi7aETlkgAODNq30bKVaMLIK3dgsuoYDlGUobZ/90
         GSi+v/rNOTmJbxlneVqFxci0ek/uFbbLobobv0B/SoNyMQs3rX6o7j0hosmLxjwbtgqm
         oEUhBHEzJsPMp+H2sy1s2pSZmXfGOAZDEZAlobLv8Kaextmf3m1wu2iEIMiH8wUV2nqT
         0LieaZ6eBIIAtJSzfXFots/4ZCu9snaB/BDv05FFt9W7PSgPo0/p1TgCBv4ICzBbLdU+
         VCtq2q4sG9PbmeskpsOZMaciY+eDwmcXiyAgkR0w5qbUNsrFOECvinrlqTGPy7L0Kpft
         NpZw==
X-Forwarded-Encrypted: i=1; AJvYcCWfMgzYNuJVGxWX22AG5xnm4kNwrlrIpdkbotNh6ksaK0Z0Yu4vfIxJxW6rjX8XeiF7l8ts/GxisNwVPOGruaWKvZ5qGiav
X-Gm-Message-State: AOJu0Ywr4W1qrMncroG/JlKhBTyMkVFuAKA36hEE11xplJyalXVfm6cA
	9jbCWlPsXC6LH20cnaYNzErMt15rUbVXcRqrEQtbfxHWVlRgc5ZJg2Uu31QxVmeI1+hqDVnimSx
	T2emhgCSPn3XhLg6PizsfadZV3tWZhTiDFucWDtrlnuftbXjw5R6BdA==
X-Received: by 2002:a5d:4286:0:b0:367:4dce:1ff7 with SMTP id ffacd0b85a97d-3683160059bmr1877251f8f.6.1721236894370;
        Wed, 17 Jul 2024 10:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5E3r5zlokJ2Ycf6jSWV7gx0NfBkAUw6wHxsNqleFmRN6IhQHbH2ohVveywytV2g8FctyoiQ==
X-Received: by 2002:a5d:4286:0:b0:367:4dce:1ff7 with SMTP id ffacd0b85a97d-3683160059bmr1877211f8f.6.1721236893407;
        Wed, 17 Jul 2024 10:21:33 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368467a34dcsm441474f8f.109.2024.07.17.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:21:32 -0700 (PDT)
Date: Wed, 17 Jul 2024 19:21:30 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinfz@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] f_flower: Remove always zero checks
Message-ID: <Zpf9mlUXHZfgV+74@debian>
References: <20240707172741.30618-1-maks.mishinFZ@gmail.com>
 <20240710161139.578d20dc@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710161139.578d20dc@hermes.local>

On Wed, Jul 10, 2024 at 04:11:39PM -0700, Stephen Hemminger wrote:
> On Sun,  7 Jul 2024 20:27:41 +0300
> Maks Mishin <maks.mishinfz@gmail.com> wrote:
> 
> > Expression 'ttl & ~(255 >> 0)' is always zero, because right operand
> > has 8 trailing zero bits, which is greater or equal than the size
> > of the left operand == 8 bits.
> > 
> > Found by RASU JSC.
> > 
> > Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> > ---
> >  tc/f_flower.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tc/f_flower.c b/tc/f_flower.c
> > index 08c1001a..244f0f7e 100644
> > --- a/tc/f_flower.c
> > +++ b/tc/f_flower.c
> > @@ -1523,7 +1523,7 @@ static int flower_parse_mpls_lse(int *argc_p, char ***argv_p,
> >  
> >  			NEXT_ARG();
> >  			ret = get_u8(&ttl, *argv, 10);
> > -			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
> > +			if (ret < 0) {
> >  				fprintf(stderr, "Illegal \"ttl\"\n");
> >  				return -1;
> >  			}
> > @@ -1936,7 +1936,7 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
> >  			}
> >  			mpls_format_old = true;
> >  			ret = get_u8(&ttl, *argv, 10);
> > -			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
> > +			if (ret < 0) {
> >  				fprintf(stderr, "Illegal \"mpls_ttl\"\n");
> >  				return -1;
> >  			}
> 
> That is correct mathematically, but perhaps the original author had different idea.
> Could we have review from someone familiar with MPLS support please.

The MPLS TTL field is an 8 bits value. Therefore any successful return
of get_u8() should be valid and this test is indeed not needed.

I guess the original intent was to keep consistency with how the other
MPLS parameters are validated. But TTL is indeed a special case as it's
the only parameter with a "common" length.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


