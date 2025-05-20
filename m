Return-Path: <netdev+bounces-191766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C426DABD20E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A461F1BA20D5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25391264F96;
	Tue, 20 May 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="U2fB0OQ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8C265CA0
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730007; cv=none; b=JgUVImxibjKLh0m2RD6KaA6l6vDJTpH1reaLHRdT29KOKKrWdlCP8+WTzm4EHnb8WuO+TGCQJiIeBv/BhuHZZ08fgDox/j4Uhk5rFhKaTx7jCsCtj3KGKcLSOSM166g57aTntDw72XRwZ5zagFtzpbEAvOxySS5HwvimWF8yNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730007; c=relaxed/simple;
	bh=GF+s8Jl1BTh8NdVG416R8JmxJ4s20YQr+6cXyNI3IDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVRGyBDV7ELsBCEUegcxsct8KodZqFDVPgdYeCxOMBl+6q6nU7G5Z2ce4kpM39TQF/w+0Wpg1IuHuWVOvCYhvikzBKAiKoGCvE18UECVqUDLSAQu8Z2ifeudi4Thl+vwy2e4kzFKCoHAP+Qb7N7BPboF6D86mMfc92pcMekNOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=U2fB0OQ6; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 203FB4065A
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747730003;
	bh=CwADa1/5fzM71NAaC+Jbeng4RK+1Y3vai9r6LkZ/myw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=U2fB0OQ6ousF0q4JL33d6vMHxDdcrlG26deVAAfpR8vrKNf2U8zacBy0JD8or41NK
	 FJa5v7hCozVgaJ2igfPU6avVIOuhbIVExg3vkLKVQOqgMpOXcnotLPZRJ4zHyYQdgv
	 Xs2pwfYTLt071R33cgPBzTTya1Spmz6p7kWPnMCLDeSG6OahI9L2145eFOGEDqIlJ8
	 qnwJBdaYNkU6qJTXILk8kc8E5B1n4HwHTj0CWOL2HmGnbRiAGFCz11cxObquzaBV6C
	 O5mD0JEYFII9fjWYPrjn9VREVFAVNiHWfE/sGJVA+Q7ulDvYP49jms8J7jFdJsMrqF
	 YW3M0Gi5WCvSQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ad56c38dbeaso220621666b.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 01:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747730002; x=1748334802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CwADa1/5fzM71NAaC+Jbeng4RK+1Y3vai9r6LkZ/myw=;
        b=lHxGpxnuVQlwvydkGniacd8aTf73puNuPe0ii/7JIfJVxg7jWbkLO0L/HAfqW6AhvL
         HIA6KaPOkQqU+JOiC+qK8rtukw+YS7JqkR0yfI5B9m69XmFtXoo560SaAp6TPhXTg+vp
         Jit+0DxByHDNDOpUiLtrS1J9o7adKB40/PnAF/++RVsmInDDdmjlsBX62n3uJBmV+NY5
         9leet5Xy4icHA1HJyCM/idVL0VmyO9kHCKV22Vax5s8amcONgTDs93kZdKNt1aViAUz+
         5KR6b+UOAn5QYyPR974YWULRGAVhBPUJIrV6qutegpwUxM5BJCTknyPQofqcbYFcwGcv
         9Ojw==
X-Gm-Message-State: AOJu0YzHnMaYbnSDXcDVIEVBaQ92V8d5bnFG15vt4xf2swamg38Y95KI
	cuZ1VsLvQ2cOSSz2FDDs3kKNLxwyQVUH27g4rdbMFMof5ymiUFVv7AasJ6FZ8BzSHiAOcS9hq4Y
	ZZFrkLb8NN68/Kb2iKBog8A3OuElGrZf9Hgg45eIAl5MiBHhJYgn2v7VFaIDfrpdHITrNdvS4vm
	d3gwfsVkliOwgNn9Qq7ZlrZ8jHeaLVUgUyopFIQvfJomacsALb
X-Gm-Gg: ASbGncv5v5OiNq4ktdjeu2aIMMrJd/xcCjmZ5ZSkIU9jI0O5R+NbY4G4KPargC/u5nb
	bEzM2qxtiJdLa6fTWi54pWSm4S7GrBUsC+jGX9HH6PwgqEnMGry/xlOq5pIGL+6iOBZ8=
X-Received: by 2002:a17:907:706:b0:ad5:a16:93ce with SMTP id a640c23a62f3a-ad536c21b39mr1214785066b.30.1747730002548;
        Tue, 20 May 2025 01:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQIsOrzCoa9fMsKQOb5KamtkzPaDDCi/jrmWuZ6PrGIGkdsOlmhtpc/GBvgPIjQylHYiG+HYC1L59uxS62rc0=
X-Received: by 2002:a17:907:706:b0:ad5:a16:93ce with SMTP id
 a640c23a62f3a-ad536c21b39mr1214771866b.30.1747730002172; Tue, 20 May 2025
 01:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516094726.20613-1-robert.malz@canonical.com>
 <20250516094726.20613-2-robert.malz@canonical.com> <72004e1c-d327-4a69-98fe-24336aa66e8b@intel.com>
In-Reply-To: <72004e1c-d327-4a69-98fe-24336aa66e8b@intel.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Tue, 20 May 2025 10:33:10 +0200
X-Gm-Features: AX0GCFuR-LKy0Ar_XhfMUwJ-oSOq2GX0rFRIlGT6BKqkZgl6o-QxnOE2IVpPQQ4
Message-ID: <CADcc-bzq2BCL07SOjzdMXypE8Y4bLkAuurwZ0YwHuffdpar_OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] i40e: return false from i40e_reset_vf if reset is
 in progress
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	sylwesterx.dziedziuch@intel.com, mateusz.palczewski@intel.com, 
	jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 11:22=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@inte=
l.com> wrote:
>
>
>
> On 5/16/2025 2:47 AM, Robert Malz wrote:
> > The function i40e_vc_reset_vf attempts, up to 20 times, to handle a
> > VF reset request, using the return value of i40e_reset_vf as an indicat=
or
> > of whether the reset was successfully triggered. Currently, i40e_reset_=
vf
> > always returns true, which causes new reset requests to be ignored if a
> > different VF reset is already in progress.
> >
> > This patch updates the return value of i40e_reset_vf to reflect when
> > another VF reset is in progress, allowing the caller to properly use
> > the retry mechanism.
> >
> > Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on anot=
her VF")
> > Signed-off-by: Robert Malz <robert.malz@canonical.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drive=
rs/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > index 1120f8e4bb67..2f1aa18bcfb8 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > @@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf =
*vf)
> >    * @vf: pointer to the VF structure
> >    * @flr: VFLR was issued or not
> >    *
> > - * Returns true if the VF is in reset, resets successfully, or resets
> > - * are disabled and false otherwise.
> > + * Returns true if reset was performed successfully or if resets are
> > + * disabled. False if reset is already in progress.
>
> nit but if we are editing this, let's make kdoc happy. Please start with
> Return: or Returns:
>
> Thanks,
> Tony
>

Hey Tony, thanks for the review. Fixed in v3.
Regards,
Robert

