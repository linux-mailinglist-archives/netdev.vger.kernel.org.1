Return-Path: <netdev+bounces-174552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400BFA5F2EA
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3240189507C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EED4266596;
	Thu, 13 Mar 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWj6LXWI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A12676F3
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866154; cv=none; b=axzWFMMtFsf69R3XK8xbQaMC5V8BUZa166mkW/AyhEGKu9gc4mkbhg+L+rbuEA2kcsZ9P7NNVuwqrGve7qxfaMrGRSzN+eUZX9HpyIV8N8+iTyE1gJMBQO1dIUXa3GdWhRr5rNlQ1xQAxSWN6dkIvJkAVNNm2hggfS5Rd2vrjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866154; c=relaxed/simple;
	bh=2kmGRY+DddzBBJBrhPssm2cF/u1dCoQCbxJ8tNj4958=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jIpoB6kvqK6UIoA9GQOp3YnbpzB86Xvu92r8Np1iSw0lEP4+YtX3loNao7cnmdPWKeZXe+8dAO7J1ZxW0tSLmnMqfJZmW9HDKNdnuyDKT/fBPtZ8LEUUrm17OO0zAiXw2MX1VDOKfLbsyumttJvB440DxF8WNcQ18/OzBOiKgos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWj6LXWI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso168260566b.1
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 04:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866151; x=1742470951; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvllTM5aTmowvoz4REUB0nJcZ5ArizShXuylF3X4FNo=;
        b=hWj6LXWIvvXATpW1I6xBreN8oCgdlzDDZIyLnd7DU/3PxdI86cYNL7H/kNtqjCzXTJ
         meVR//4hBuRJtPYHOPkoZUxp8GE1DHiMhBwodIQZxwf3lxJ52Cq5wAgcYc9dhjZDHx36
         omSMHVn6lDJpEBTQ+ssjSr24BugIVhIN3SHCpnlGiJn+DNTrBgmZomQ0+3E1skTKEnvU
         xHf6gaxCC00+GF06+Um0f+MrzbpEGyrKNxWofBIerh0KG6pghD3KGebl0xS6UhMPu+M9
         kJZk83rAMvue6PmzFDXR2K+lsqBNeVsyKzvnhB4LwZ8B4wANMJGd0MMmYtc8cqGUolNV
         pJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866151; x=1742470951;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvllTM5aTmowvoz4REUB0nJcZ5ArizShXuylF3X4FNo=;
        b=PokWOuoZNrpgPYnPsHRwL26//fQ81Yp2Zi2FKhR+Satt0swbr+JJtwg2uKUV7WCGj5
         wENDcmOkw/MxKK8MlV7YzRzt0WtNVegxu+iOsKoq4aOprfztE8D6mRIR8T1U06MH2n/M
         J+gmc58KCA5nPocOWf5KDghMqGbQCHQtp/KzEpcBFVpqz+MUhZqaeDNVVgI2HFq5Tzuw
         jmnNJSGs/qE1P2pMgSRI2THH2pUC1zcH84recsMHAEtkB4vMwJ3/C0/8B48yQ78OgTKV
         9gv9BgC5v+0uwPDLmscEKi3yn1oAhTo0dQ2jLkbw5Zejfd+xmn1jne9+k4/4+RD8eZX3
         d/Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV2DTBiU9Fi1c0cX8pC5IqiJ3ZLTgyIT8qR/yubcH9OzjUhfZU6txkteUgWt50whL6GL35G3fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvsUKgMRXoNOsIrw5xdpGIWVNJJ8X3mH/noWJqPvRIacKcoMP
	0+5dftxoQS6cu3MKzJ3EgOEd8puc3fQ+Emdw09lEi29zjHnl3fSErXsJY/QD88L+KdXsCAu0+Wb
	4zIyvCF7MPwQoqASxGVthAhxlycE=
X-Gm-Gg: ASbGnctqacmHUVsHArK+j2XRwWLYZ4Pa8kHTr/B9ACrmCibDE+SILjBTPMf5dQGfypn
	SR4trXgRdK0DeXD+NRbwhAu/TqbKB9tgC0/CfxFyULhyuOaP3Cny08dLW+ywFStWXoFkgCFG8zu
	v+aXPJmQPZL/Z1xjceJbrErte62Q==
X-Google-Smtp-Source: AGHT+IH5PJQagiQlgIuVx6hTVSeafKVcifZgbr7pihGNuziCmGSf2FTfVY9196O2zetpv52iSq0EiHFDg5H/EcroGfM=
X-Received: by 2002:a17:907:3594:b0:ac3:1fbd:a94b with SMTP id
 a640c23a62f3a-ac31fbda97fmr60591566b.7.1741866150517; Thu, 13 Mar 2025
 04:42:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310203609.4341-1-technoboy85@gmail.com> <20250310141216.5cdfd133@hermes.local>
 <Z9LBZsdh3PsjuB28@orbyte.nwl.cc>
In-Reply-To: <Z9LBZsdh3PsjuB28@orbyte.nwl.cc>
From: Matteo Croce <technoboy85@gmail.com>
Date: Thu, 13 Mar 2025 12:41:54 +0100
X-Gm-Features: AQ5f1JqmoyE6bFkavkJCip-8JWr3LDuRF2h4JTs8bVPI1Hks-iXxeXcl2GTubhM
Message-ID: <CAFnufp0e-GNCsjXw-KUjnTx+A4TP_gQTW4-HK2T8kYxH-PMxkg@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] color: default to dark color theme
To: Phil Sutter <phil@nwl.cc>, Stephen Hemminger <stephen@networkplumber.org>, 
	Matteo Croce <technoboy85@gmail.com>, netdev@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 13 mar 2025 alle ore 12:28 Phil Sutter <phil@nwl.cc> ha scritto:
>
> On Mon, Mar 10, 2025 at 02:12:16PM -0700, Stephen Hemminger wrote:
> > On Mon, 10 Mar 2025 21:36:09 +0100
> > Matteo Croce <technoboy85@gmail.com> wrote:
> >
> > > From: Matteo Croce <teknoraver@meta.com>
> > >
> > > The majority of Linux terminals are using a dark background.
> > > iproute2 tries to detect the color theme via the `COLORFGBG` environment
> > > variable, and defaults to light background if not set.
> > >
> >
> > This is not true. The default gnome terminal color palette is not dark.
>
> ACK. Ever since that famous movie I stick to the real(TM) programmer
> colors of green on black[1], but about half of all the blue pill takers
> probably don't.
>
> > > Change the default behaviour to dark background, and while at it change
> > > the current logic which assumes that the color code is a single digit.
> > >
> > > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> >
> > The code was added to follow the conventions of other Linux packages.
> > Probably best to do something smarter (like util-linux) or more exactly
> > follow what systemd or vim are doing.
>
> I can't recall a single system on which I didn't have to 'set bg=dark'
> in .vimrc explicitly, so this makes me curious: Could you name a
> concrete example of working auto color adjustment to given terminal
> background?
>
> Looking at vim-9.1.0794 source code, I see:
>
> |     char_u *
> | term_bg_default(void)
> | {
> | #if defined(MSWIN)
> |     // DOS console is nearly always black
> |     return (char_u *)"dark";
> | #else
> |     char_u      *p;
> |
> |     if (STRCMP(T_NAME, "linux") == 0
> |             || STRCMP(T_NAME, "screen.linux") == 0
> |             || STRNCMP(T_NAME, "cygwin", 6) == 0
> |             || STRNCMP(T_NAME, "putty", 5) == 0
> |             || ((p = mch_getenv((char_u *)"COLORFGBG")) != NULL
> |                 && (p = vim_strrchr(p, ';')) != NULL
> |                 && ((p[1] >= '0' && p[1] <= '6') || p[1] == '8')
> |                 && p[2] == NUL))
> |         return (char_u *)"dark";
> |     return (char_u *)"light";
> | #endif
> | }
>
> So apart from a little guesswork based on terminal names, this does the
> same as iproute currently (in his commit 54eab4c79a608 implementing
> set_color_palette(), Petr Vorel even admitted where he had copied the
> code from). No hidden gems to be found in vim sources, at least!
>
> Cheers, Phil
>
> [1] And have the screen rotated 90 degrees to make it more realistic,
>     but that's off topic.

I think that we could use the OSC command 11 to query the color:

# black background
$ echo -ne '\e]11;?\a'
11;rgb:0000/0000/0000

# white background
$ echo -ne '\e]11;?\a'
11;rgb:ffff/ffff/ffff

-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

