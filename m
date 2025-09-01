Return-Path: <netdev+bounces-218900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12024B3EFB0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE34648772F
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C11A1A9F91;
	Mon,  1 Sep 2025 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="npv/mn4V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CFD32F757
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758645; cv=none; b=hndsfLpL57+kv2eseFiTjifeCrhnvh8rDRWO6QtZEzuGACeYCBNfwa3zvtE4mIe/t38B+qDPIcyNGuWTURvi5+m/pkzzoLue/sw+lVRTmGovrpEsy4bDZDYv403awB5slEYGQgc0oWufF6RMsoz1mQYgx4kgmisrhQqJlHwZaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758645; c=relaxed/simple;
	bh=F6/InM3xRGl4+7YTkrpsNTusB9D0eVDADebN8uUb7HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laI/TkP43nlXAiak9kKnG0rbsbQ5Z9PNSUz7lRGypljmv6BBvccuRlBw587IxfeInbmfqGjQku+Jy2negg8rZc/xTAHaMpjBp/DLBDtXTAhsc9Rt3OgDQChgRq0S9qCs7Yt5xRK2YAHc35WMIj5ikW6BisP22ppKG1aCijPUmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=npv/mn4V; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3ZzfJipirZUzmDyKZf2yBnJ4hPSkV9Md5ill2XLbmO8=; t=1756758644; x=1757622644; 
	b=npv/mn4VR5DxIWiC/WPwSd9oihPaNMsFFs+EQCHirLqa8c2JSbkdE9VXB54jVu6Utfxlo4gsQbl
	60UPGMqGnwugI7Mstq/lhq1BhRozXaGE56LWNEAA6fD8pxBZ5e8686aabGYK1wJLSqay59WalZlEa
	o4/hh4bGvbBIYtXz0yQvJt6hTMyJPVOyrCpGxSs3vxcOPOjQRczBICs9MaMbJi7JASFzFsiVAoTS2
	nXNCzstSHvgP7s/DrtLTi40VakXTCX0RCNyXcHS849EA6yDDic5+4nfooFCy4OPSyvh0AMl501/6n
	jHdk0XncLwyujTVEPGLOKBsp6r9VlJjqGfqQ==;
Received: from mail-oi1-f175.google.com ([209.85.167.175]:57765)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1utBAo-0005Ai-SX
	for netdev@vger.kernel.org; Mon, 01 Sep 2025 13:30:43 -0700
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-437d293d2f4so243825b6e.3
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 13:30:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxa8jWBfSrms9loaBmezoJAU1ikbSRwwv4aDtqiN+XpTzhcN6Ik
	yr9FvUpmdJUivshf8cHizr4oNdHgLiryNSAIncQFn7zqRlZBUXKGY7fxJv5xCXBksjNlCuWytjZ
	YlydjuJn1FIFEuep97g72ymDwzWjvNq8=
X-Google-Smtp-Source: AGHT+IFHb/2JJ9g+Z08NjA6kk+vvm2ho/mjRg6rXRVoW4p93rr2xHQ4VyW03cykUpDjkLGy+OgES2YTAPIoMdI7Jgmk=
X-Received: by 2002:a05:6808:318e:b0:437:e743:cc9d with SMTP id
 5614622812f47-437f7ce6601mr5176652b6e.11.1756758642299; Mon, 01 Sep 2025
 13:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-12-ouster@cs.stanford.edu>
 <7c990c8a-9546-4bab-9438-9760090978c0@redhat.com>
In-Reply-To: <7c990c8a-9546-4bab-9438-9760090978c0@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 1 Sep 2025 13:30:06 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzBfv94FyCmAuekLHEDRbBf+_=YpHQHFtDoQb-qTcqZNA@mail.gmail.com>
X-Gm-Features: Ac12FXydWllTX7Q1ZIpdl3g_I8GxeRgwKCh0fIhsxNJwA4PSfJDBWcqOVdnxXbQ
Message-ID: <CAGXJAmzBfv94FyCmAuekLHEDRbBf+_=YpHQHFtDoQb-qTcqZNA@mail.gmail.com>
Subject: Re: [PATCH net-next v15 11/15] net: homa: create homa_utils.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: 764eb63bb4c91aa8ddbf2de6f9e489d2

On Tue, Aug 26, 2025 at 4:53=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> > + * homa_spin() - Delay (without sleeping) for a given time interval.
> > + * @ns:   How long to delay (in nanoseconds)
> > + */
> > +void homa_spin(int ns)
> > +{
> > +     u64 end;
> > +
> > +     end =3D homa_clock() + homa_ns_to_cycles(ns);
> > +     while (homa_clock() < end)
> > +             /* Empty loop body.*/
>
>                 cpu_relax();

Done; I have found at least one other place to use this as well.

-John-

