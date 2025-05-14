Return-Path: <netdev+bounces-190321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B760AB6343
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D0BD1B4489E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 06:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADD1FE47C;
	Wed, 14 May 2025 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyBu/xNF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CF1E633C;
	Wed, 14 May 2025 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204630; cv=none; b=cTaPsEKQgH9hiuFQw2n6DcQPWIBd03H1NNFTxND0pAdUT7CDVKoPEEsfw7eNYEuw4XU9enEhkc9Perc0mhKU76DhBMWt7go0OURn4lMEuMLem3uNGxwolPXVm2DUQo5Qzam12T9tUNdqE4TRC06+93mVF2RHF8MkIenWloxJ/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204630; c=relaxed/simple;
	bh=Iju1T/QM7gWs0Y9yyMUqY0aUdISlpw7vyengxeSHhFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL2uKRwuDVEr9e/zyj2lb6BlS2mNJZa+yY9q2cVJYVirJ+opQlCqVIF5q10pDt0nM6IPCHwgj0czX+a2oSLdpj6ikE6R1Oy02ZBfkSsikkxgoPJx4rm0VE8peUD2Kwiap9LsUsjh8/coBmQqCIoJPkrXxFthz/K41HVtZLwRM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyBu/xNF; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5fcab0243b5so8257968a12.1;
        Tue, 13 May 2025 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747204627; x=1747809427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iju1T/QM7gWs0Y9yyMUqY0aUdISlpw7vyengxeSHhFU=;
        b=YyBu/xNFzhF1wEoli8QfFhX4S+VCnQsodYBTML/92UVtzl5S3GcTPxoJmEBJWjM1ya
         AvN3ZNaob/F3BDHwsLBFHKR7mOTU/MsVexfDKfTL/J2duo6AOUiY3ap/X5iTXpxpIHFY
         xonLLb1uCCyyXU+ljD8MkUfOOXcWgwRSWZgjPUrepHpZob3K+ObV99ID3rscoR2wJdgB
         xhpS2pA/GmiBdm2B+i2n7AI5lXBzsCJb7fFJGbB7Ef+tDVNzVPj0yp/UtjskLRN66MNI
         jATBirzIuqoKfbaG0HgJtqgaPjMZh7SJqOZRvsVzFA05U8ofrpsyUploki7GoyLCtfF0
         4knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747204627; x=1747809427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iju1T/QM7gWs0Y9yyMUqY0aUdISlpw7vyengxeSHhFU=;
        b=Lp1AgEx57iYkRG8HF/6r63ErJ5eBzLDbxqi7WtDMgniWXZtHYlcd126llELWxWyiW3
         39EzTjNUivLgUt3SGEsrepETMy1V+xSrpECnwjJxIeV3tqJ9bQ7zt5faYlLzUyjOUnc0
         I/6njx5IbbaSYtceVh9CAcv62WGqIdvg3md1I5yLXjzPlhe5gc8L8jUcrce4bzngNa+g
         KOoteoQTt3tFu4GkQpm2LlSzIp0mijz9vIs0GyknUnBu0HkHLPql4zqjWaCie8tXrli0
         2khx4V2rzIGGQxvqaIi8TJJrdrcWMdR4MQFpDe8XXc55ShaM7eDQXwz7t5tguNKIxBWE
         uYIg==
X-Forwarded-Encrypted: i=1; AJvYcCV+A/ZVr8816b+fw5TVCK9Lj3zvPJxUKOJPJXEI94iwRXftlKaL9ULgZqVVbKY/iLjR0XPGbiTn44tXvY0=@vger.kernel.org, AJvYcCW1UIWze4iIiYAzzx4yRb29TA5qBYwv3feSj69t3tPeICW7LhrB8eaiifOCWrQQtZuBBt0Ku1xm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ve74zouAAIeyGQPDsdrTo6vDs0AZduUjMH6sxpTTanHsaiUP
	NPk9T627vCYaXtAO1xIk+jc71lHnJHXnitcDISM4LQUSRpGt2xZhaC2vuPrPSuXCpZOWstz6t1H
	3SQB2hyu1qAUeW6Fu1cVJpxIOsr4=
X-Gm-Gg: ASbGncsRzDW/I1elSotdsdanTV/K/EEF1NT5lOmEtfs5KiRbiXT/K9cO/HFjRcN5B3J
	dW+0mg3qOZEu+/QaEOB5S4yL60h8tchmAVpWde0MtUf/XT/2myk/lm9OLOnxBIszGCaR1mGUN61
	lj//jIx1QY9b2EpyPaxn49upCzSd7EEAZiCAXyU1LEgQ==
X-Google-Smtp-Source: AGHT+IHEBTfsRpq8031zH2FGSeDn6dIVqcXXmsK9zp570JIIxdHq/x30Tj3ssXbLJJ5YU8+G+gNa6PIR7LBvX/tAi7Y=
X-Received: by 2002:a05:6402:2792:b0:5fd:2e33:fa49 with SMTP id
 4fb4d7f45d1cf-5ff986a8ab2mr1475548a12.6.1747204626860; Tue, 13 May 2025
 23:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508071901.135057-1-maimon.sagi@gmail.com>
 <20250509150157.6cdf620c@kernel.org> <CAMuE1bH-OB_gPY+fR+gVJSZG_+iPKSBQ5Bm02wevThH1VgSo3Q@mail.gmail.com>
 <CAMuE1bESfcs92z-VowaQjgWG25UK6-fTzgDqFagOyK1yifH5Lg@mail.gmail.com>
 <CAMuE1bHL1-t_YD0B5v1LuY_b558U5qbseSYJXvnm734+Vb-v_w@mail.gmail.com> <20250512170702.1f6d0c07@kernel.org>
In-Reply-To: <20250512170702.1f6d0c07@kernel.org>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 14 May 2025 09:36:40 +0300
X-Gm-Features: AX0GCFsFJezkIm7jfmcDDr072HIgwJMqDQzTHMrKvVJAU8NNdPC_C8rNZGEuis4
Message-ID: <CAMuE1bGWAoF-=6NNuNqFRymhYeg=Ah6dPmTx7vyZUD9yM8jwPA@mail.gmail.com>
Subject: Re: [PATCH v2] ptp: ocp: Limit SMA/signal/freq counts in show/store functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev, 
	richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 11 May 2025 17:39:08 +0300 Sagi Maimon wrote:
> > > > > What do you mean by out-of-bounds access here. Is there any acces=
s with
> > > > > index > 4 possible? Or just with index > 1 for Adva?
> >
> > The sysfs interface restricts indices to a maximum of 4; however,
> > since an array of 4 signals/frequencies is always created and fully
> > accessible via sysfs=E2=80=94regardless of the actual number initialize=
d=E2=80=94this
> > bug impacts any board that initializes fewer than 4
> > signals/frequencies.
>
> Right, but the bug is that user may write to registers which don't
> exist? Or something will crash? We need to give backporters more info
> about the impact of this bug. Can this crash the kernel?
>
it can not crash the kernel, it avoks kernel Oops (page_fault_oops),
the kernel the kernel recovering by terminating the process.
It will be added to the commit note.
> As for sysfs exposing 4 entries, I think it's controlled by what groups
> of attributes are added. So I think were possible we should create
> attribute groups with only 2 entries for Adva. Eg. copy
> fb_timecard_groups[] with just the correct entries, and in
> ptp_ocp_fb_board_init() add an if which selects the right array.
you are right (look at Vadim's reply too)
Adva has adva_timecard_groups with the correct entries, so the fix is
relevant only for signal_summary_show
and _frequency_summary_show

