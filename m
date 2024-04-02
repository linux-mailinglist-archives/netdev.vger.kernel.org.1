Return-Path: <netdev+bounces-84042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5AF8955D7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAE21C221EF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D887358AB0;
	Tue,  2 Apr 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OtvqWuGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF380BEE
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066092; cv=none; b=CI3nITgSrsgGlq0mC854bYjWE8pxVhAfKzS7jPr01NnP6nhTXQ4KFEnOTqmCaaUzVtmxgGUm0DcZErQMPPnGTb9HN2FiBYbYF3h6SQ5SrSZb0Llt3sClBDvvSeoRF+eCEhB61n/X74GaKk0GpklJvGELQ9HOqpo+Fu3ObPjpJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066092; c=relaxed/simple;
	bh=OhezKoMk0ZpyNgIu9VoaSTemJc67M5kb5EmMZp2QqP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm3aYB8FwWFcdcZoz3xI7xp/A+QvBCXhRUE/hXja7w5wv1KGvDjp6cFOcD6/TzadvGnwbHaJRFdi4Wu3z5Zvz07x6TsYYb6BUsMIBf0/gwzPhwnvB3c9s1x5qm+cDvlFDXsI/T+PaGFuRzESsHrnDJJaorzjHzQ1bII2D8/0Z08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OtvqWuGV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56beb6e68aeso33915a12.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712066089; x=1712670889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhezKoMk0ZpyNgIu9VoaSTemJc67M5kb5EmMZp2QqP8=;
        b=OtvqWuGVMjQxa0QqW+DpWBq1xbzmZ91At7CsbHDLVXACCkGA34tqX3bsHr1BnBFPIz
         LEooi/ejuFqpky9yFdDOVqxP1WTAJ4aD8pKEiaTIJfzHjdm9cD1MwtgbCKwkD3WVi6+5
         NUTpaYCieBT5VcPQUTBYUtbM9nJvxDjY8EECa2NFzvJIjxv6ACiOYvfpLq00limcvmZ6
         oAuQ3EtsmAwDjpCqLEATDVjlTOKtoizLPzWgh6gfn9hDuS0ZIVMYXOpeBtYrPSJEqaWO
         124l/09RGVdnJnb26Iyl0yhPXiLmOuY++rU9KvITHEKhpauSQ/z59acV5lI2yA8Vyg2n
         VuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712066089; x=1712670889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhezKoMk0ZpyNgIu9VoaSTemJc67M5kb5EmMZp2QqP8=;
        b=rQXcx/v1bOpVod73/heRvPIj2cZaPDdsEL56pTIPIvs7RufaiILvdxox70x2Fn5S/i
         x/ZP5VIWiXR/k7C6WR+27ErEcTTOZltFEAMMiv1ZmmT2eP6QOJhh903EJxBn+hjQSsUz
         7njkFkYysi1AJX4CTafuybP9EoBXlIVANU3OR8WEk7CtoWm/jK/iCsqhrd6pTfuTqnVo
         +9q9BfQIdcTzonwpCXeApDjEBmJJklzK5/acDli/gAIxrqAAhEPnPsFtTmpP1S61sM1T
         6ZgWGsP02BsYfokRCwnIHgk6JLoI4FsmRBBC6oG28VOfFcNo9r94oQ/KNwwPTtijXxmR
         Gy5w==
X-Forwarded-Encrypted: i=1; AJvYcCU+xdqfHenxt4OAPD0s8J7xbjqY3k4GVBEC2fVbPl4a4zl9RDpGGw9TrkzGWSZEsemuHzMyN8IJUxVPF4W0En9HIxY5gRug
X-Gm-Message-State: AOJu0YyDb5nBu9WwcIgyT7VmbnZxPWVts9vCxBAsxpveu9FSz0g7hasv
	o3Htq6SEzRmsOHIyOsYKVT+a3taeoYJNX+DsbvORIMnKbEhyrvNtkMWE1qDqcq+5F4N+FP+nVyM
	vsFd80rUCXpeYeyrJkhOcDWaPVh1ZjLCjc1wN
X-Google-Smtp-Source: AGHT+IFkFummJ8EVqYQbMMRY/DoS7KDISq3fii/tRJEgKUeKeL7aK3elsQSlRTCe7QYCweZPOWt3PdPoUpKnCcbikVs=
X-Received: by 2002:a05:6402:5256:b0:56d:e27:369c with SMTP id
 t22-20020a056402525600b0056d0e27369cmr668695edd.3.1712066089193; Tue, 02 Apr
 2024 06:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306111157.29327-1-petr@tesarici.cz> <20240311182516.1e2eebd8@meshulam.tesarici.cz>
 <CANn89iKQpSaF5KG5=dT_o=WBeZtCiLcN768eUdYvUew-dLbKaA@mail.gmail.com>
 <20240311192118.31cfc1fb@meshulam.tesarici.cz> <764f2b10-9791-4861-9bef-7160fdb8f3ae@leemhuis.info>
 <72e39571-7122-4f6a-9252-83e663e4b703@leemhuis.info> <CANn89iKfMTGyyMB-x74J5bgzhM1RxSvuNhvXyWWv4DO8MZakSQ@mail.gmail.com>
In-Reply-To: <CANn89iKfMTGyyMB-x74J5bgzhM1RxSvuNhvXyWWv4DO8MZakSQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 2 Apr 2024 15:54:38 +0200
Message-ID: <CANn89iKPh0uR2mq4ThokwaF5iJA-N=9sXawi2H=-vLDn5Xfmug@mail.gmail.com>
Subject: Re: [PATCH 1/1] u64_stats: fix u64_stats_init() for lockdep when used
 repeatedly in one file
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	"David S. Miller" <davem@davemloft.net>, open list <linux-kernel@vger.kernel.org>, stable@kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 3:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Apr 2, 2024 at 3:40=E2=80=AFPM Linux regression tracking (Thorste=
n
> Leemhuis) <regressions@leemhuis.info> wrote:
> >
> > Hi. Top-posting for once, to make this easily accessible to everyone.
> >
> > Hmmm, looks like Petr's patch for a (minor) 6.8 regression didn't make
> > any progress in the past two weeks.
> >
> > Does nobody care? Did nobody merge it because no tree feels really
> > appropriate? Or am I missing something obvious and making a fool out of
> > myself by asking these questions? :D
>
> It happens, please resend the patch.

By 'resend' the patch, I meant : sending it to netdev@ mailing list so
that netdev patchwork can see it.

