Return-Path: <netdev+bounces-148843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BE9E3433
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E188164CB6
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B852918DF80;
	Wed,  4 Dec 2024 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKZGPvTE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB118CC1C
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733297981; cv=none; b=PqwuApxMh3DRrQALRPi7SzLiL7Ewpq2kwsJYz+LbkCqoYtPp3vJC8Ske3vhXsNXd946ZBWD5/45l8JI79wVn9E90NHeA1qCWY3yFlyff3OfaPuS/Z01Ipu6DPar5EIWIRAmbuwlNd0hUWBlfqCpV4gR4LBZPNVIrUDIQ8VDhnEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733297981; c=relaxed/simple;
	bh=U2CgrFBoM0Ky42PKig4xJWCzT9ElRfnw0ImD2yO6vss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKIa451JTvAuCB59aSmI8O/jWV3c8CygKd1zubrbmU0g093haME1TBtBP/GCTp2I8Ew4NJn2Exlb8S8IoD6s96ASiIt2u3hUxvQGYzvgKQMae4vvoLprxNV+N8t8FT+tqZ8zZnPthepYWQp0Kt1iicF6PFaP6+fu8V/Hf8Z8lzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKZGPvTE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d0ccd931a3so5494941a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 23:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733297978; x=1733902778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftQI7DFJ6AuXEtuaw5MVddlDzi0DSzv5b79XS0kPai4=;
        b=TKZGPvTE2pOmdw0XRYPlHOj/dfSuIwsZ1GWwTOYGRjE1atSxfmF5Johjdeea9tlwaJ
         SoduhfBpJPWZJHfbdvSAOI/YP44xn/nax73VUTjD6aa0mzRE7pReyfY/7n8PxCnY5cYm
         w+eLTbyl1aA6g8f4Eczw/jDEuAEK3dbrwvLca8b4yC28TPjj1AN5zgJwrZQzmn8m+aH8
         EYVQ0Ycubtn+fMY5jRF8AjJFioPQijAPaENINHOD1stcFrIylt8VdavsNoFCEi8/wAQV
         wQ/WCEQSCNAbneq0/j/2ofo3Ei/x2pJ9nX3yqNyOXvYrPq+HffTzOxF5jLJbh8Ccky99
         AeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733297978; x=1733902778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftQI7DFJ6AuXEtuaw5MVddlDzi0DSzv5b79XS0kPai4=;
        b=q5ghU4uPxvX9UMaxFLl6HNSBo/WnkE1qB596WjxggE3xC+o4lDLJZSst9q8ORahSGP
         qHMHukSUBYp+5Bh34ooqYyI5di/OHQyAVFF2MufM47Kz2c4qCRyg+qGI8E2nyWjNKM88
         1ptaRlF07GYtZsR9GdkYsLOyWzYvDcgD75+nr9v5E6Dj6ibjW7QWt0S/0x2Cc867M4vv
         LsO1EVHXkmsbBfYuLS1Gv6awL+IU4rRDnYbBtUfo5LdLW57Fm849aTCvxSGWjrkfVhj1
         iT1Q0gPw6MP0ttK+6940/0KCADgSeIpa2E86/BY84loncjNdHTVKYk/rbYiVqEHk63ZO
         UCEw==
X-Forwarded-Encrypted: i=1; AJvYcCXIqnid7UTHjbBOBYjX6toFS+eLozWbWfR4bz9JhsPumOQIF2MCgMpFjY86Gq7QxJkCuOcWon8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydftaPR0dhy+TVjanYcWxnv3R1uj2VrsI6Oi7+FUh9ATKErBpy
	xWwOmoaWkU0yzfasVhFyaUjVJCU9spFAEaR5BkA0qm1U66+/glX7J+HVRdWEzTP+4px3kOAHtSp
	gu4RqTzHYViBkNoDssIPTUCPExW1J/C04af0u
X-Gm-Gg: ASbGncuLKRqFP14ZsaSQZi0HhtHWEJofQ/zcFiEPKdgkcNSRPb+q9fk3rMlAdHa5Pr7
	dQd5SKuXMTfAC4L3k7DNjuv8SBUgwfDss
X-Google-Smtp-Source: AGHT+IGa8CfJse1eNvx+rSIAPDXYGrisCCfgJMsxwi9FmfQQAPLlVXISQx4k7U1VKiRSNoyYwiNH6x7iczu+RJFeSoI=
X-Received: by 2002:a17:906:3d2a:b0:aa5:4cdf:4a29 with SMTP id
 a640c23a62f3a-aa5f7dc513bmr352469666b.31.1733297978277; Tue, 03 Dec 2024
 23:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203210929.3281461-1-edumazet@google.com> <Z0+mseLf3mn9mFxz@pop-os.localdomain>
In-Reply-To: <Z0+mseLf3mn9mFxz@pop-os.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Dec 2024 08:39:27 +0100
Message-ID: <CANn89iLofU1dnwAf-4ezn08h=o82ZPCHc3QJSMUdC+5aUhRsgA@mail.gmail.com>
Subject: Re: [PATCH net-next] net_sched: sch_fq: add three drop_reason
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:47=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> On Tue, Dec 03, 2024 at 09:09:29PM +0000, Eric Dumazet wrote:
> > Add three new drop_reason, more precise than generic QDISC_DROP:
> >
> > "tc -s qd" show aggregate counters, it might be more useful
> > to use drop_reason infrastructure for bug hunting.
> >
> > 1) SKB_DROP_REASON_FQ_DROP_BAND_LIMIT
> >    Whenever a packet is added while its band limit is hit.
> >    Corresponding value in "tc -s qd" is bandX_drops XXXX
> >
> > 2) SKB_DROP_REASON_FQ_DROP_HORIZON_LIMIT
> >    Whenever a packet has a timestamp too far in the future.
> >    Corresponding value in "tc -s qd" is horizon_drops XXXX
> >
> > 3) SKB_DROP_REASON_FQ_DROP_FLOW_LIMIT
> >    Whenever a flow has reached its limit.
> >    Corresponding value in "tc -s qd" is flows_plimit XXXX
> >
>
> Just a nit: maybe remove the second "DROP" in these long names?

Absolutely !

I modeled the names based on SKB_DROP_REASON_QDISC_DROP, but there is
no reason to repeat DROP.

I will send a V2 later today, thanks.

