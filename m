Return-Path: <netdev+bounces-197760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA3AD9CE9
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1C517896A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007C2D1304;
	Sat, 14 Jun 2025 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpmQn5fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D62D1302;
	Sat, 14 Jun 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749907806; cv=none; b=QoK8CUsocVXuLwGWr4JINsuc49p/H+fNToKEOngPZi+313R2Z3UidyaSzgxzwnlEjfJ7vmNoUhkp+XQ6hsntBTycRZsLFCXNYx0uK3YTJMAZMz888AaMkLUA2sRFvFRa3aZ54IgXG2x0VU0/ALceQNsk83WrH1dWDVCEGV0OU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749907806; c=relaxed/simple;
	bh=a4+RnhGxiQVnAjxqCAjlsrCrgJ9m6DH1744AYL0N99M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLah13NC1uvYaD1bk40qkw7QvFEf+EOOLSppZFprzbglAdiQGPEUAWvnAKxVQCqD4+Bs0NWMd+hZBiqGWcxnTpwvBYxwZwS7PHhmNocYflpjZEkYfxa0L1btl8DqDzczG4eXp33DCMhb2Y5XSVctFokSUE3WNKtPKludhDq74qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpmQn5fw; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4066a0d0256so1978231b6e.3;
        Sat, 14 Jun 2025 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749907804; x=1750512604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gpxLAeD+HVolSZVyFVghlR1xvl2/NKfSFQXQsuCC2t8=;
        b=mpmQn5fwaBvXK3l8w5lHsb6HOwuam6WXJcR7feQccXrkosYcAm2HpemVF+FcnoB78F
         Rpa1Hjc2kwzQZOPLGFz4U1XsELTHE/IbAxJ9vZVYKZpZjQjf5GF1DW2hYYP3GwVr9d1P
         Q22to/iO0PxWMIEOCti/hdswiZfjRs5tNIR0b84j1NOFvlQLZyf4WIfPvh6+Pag/WOdY
         p4GLefZvJcwnSsSAA0YX1+NaCVUDIyxrDyBRoFEIqTqksfPWivtY60/fNIbiEZ4j2H1j
         sIIOrDoV3ySNbs4k7KW0IW8B4hd6hxm8K67va/HzsAqCdOODktCJF/4f/ERjo0yyEri8
         AM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749907804; x=1750512604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpxLAeD+HVolSZVyFVghlR1xvl2/NKfSFQXQsuCC2t8=;
        b=iADKjewHn7Y0BnPsnbbbpLe7MR0Euf4NmNRYtGeo6VX3EyKqRwru99qzDEqwA/ft8x
         YJZFgVHJa9Nm1MQ0jVJd/sWdhGDE/kbP4z15RvOdV2KQIho4P4kmjXyBuWi5YkzuLIjE
         gtJnRZXpRCFjBI76dCmkTOpoziqaYaH5kefAvIlzkfMpN3PZ0j4XF/pPMrtj7As7AlEi
         EV/uEAZHazejeHi2AvHr18iv7YEja82Ky9N4GEYknDM0f2H0Zniwwn5AKd1Lvnve1Zfg
         kvb/lznXPjVmVm8B8AG+pNln/QYCbfhqRHh2zLrRruPmlpE36C9diXYd+pCFhDdV009Z
         41lg==
X-Forwarded-Encrypted: i=1; AJvYcCUVJCJyHoI74IN2MuKo5JxNMLT3vHwd9VqZJfkE8rWmzGGnj0XiYbrm51WzHl1a41T8/2ZaELAI@vger.kernel.org, AJvYcCVnSfFKCO+EGO+PbRe+IqLOwhI4k3Dex2NTDoLnEaUZzyp9rvI7YvTpFBpUSTMOwh6MkAP9LXjV+banu6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvE86eqGaVOqSFcI6koBJ3QZtw2XELA8n5q15236lUKw+lkJs
	ifC4Kas4S49wPFZatdYsnanTzF/Cdb0HVII5uS7db1nJ3BV+eBb/+qVpkjzt57HcOBJIDvKAzh8
	hplZEw2FGZjSATCmSGef0RkRnltpZd9c=
X-Gm-Gg: ASbGncvUIpK8zbi1BHJMICGZEkeIrttlmqa6BoW+7f6MW7Pakb/uyUX3Da0UbGzlU5+
	x88wmKoZz0ZnROXCq7lTDzvyqy8//aH5hDd7GWqiNsr2q0yymbahVmtuWaxgaWjLXYh4aWmGh+e
	FkHr9woAo6nTSSA4ye1RQNQtf7Ji/GECm9JenJ77Ow6Pec22gW3Ngi+TaJYVHAC8wcpasClGx2I
	A==
X-Google-Smtp-Source: AGHT+IGTVlBMWe1jUtHr/9UxJLQLB7fTFlDVLqP+v2cbZPfJZOQCuTo318T7Bp2vjunGuEb33YuFW6h9rg9YFZ3d2OQ=
X-Received: by 2002:a05:6808:1b2c:b0:406:6e31:18a1 with SMTP id
 5614622812f47-40a7c1b1ea5mr2201254b6e.2.1749907803915; Sat, 14 Jun 2025
 06:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
 <m27c1foq97.fsf@gmail.com> <20250613141355.1bba92fc@foz.lan>
In-Reply-To: <20250613141355.1bba92fc@foz.lan>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 14 Jun 2025 14:29:52 +0100
X-Gm-Features: AX0GCFuxx8riQsYcwnktkvT2HBgg8dodkVLgKdtxUeyINtr1KrOWe6fVqRSEbVM
Message-ID: <CAD4GDZz-hVEWhSP9sGqZH2tGrU9T8cd3aed5hRtMNZcXk2WmNw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Don't generate netlink .rst files inside $(srctree)
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Ignacio Encinas Rubio <ignacio@iencinas.com>, 
	Marco Elver <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Eric Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, joel@joelfernandes.org, 
	linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev, 
	netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu, 
	Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Jun 2025 at 13:14, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> >
> > >   docs: netlink: don't ignore generated rst files
> >
> > Maybe leave this patch to the end and change the description to be a
> > cleanup of the remants of the old approach.
>
> Ok for me, but I usually prefer keeping one patch per logical change.
> In this case, one patch adding support at the tool; the other one
> improving docs to benefit from the new feature.

My point is that "don't ignore generated rst files" is not a step on
the way from the old method towards the new method. The new method
does not involve generating any .rst files so the patch is something
more like "remove obsolete .gitignore from unused directory".

