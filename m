Return-Path: <netdev+bounces-134662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441899AB7D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5536C1C22310
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E401CFEDC;
	Fri, 11 Oct 2024 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1Mu2dVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FEB1CFEC5
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672556; cv=none; b=MYV0XoDjte1nvt5JfbRCoO0/VnMPeLwoCRTufEj81oyoSArckUPWPBAUr/WiUR8/NfZ/7Xcyl6I/vmQxu5PeXw6zKK2MJCryIfe/Z5siGNB1qkcIfIZW0V8/P7O4mZuS/DcbFkNMSwrRsESBVbK6afM+VmLHq0RNaQ/dV8yZlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672556; c=relaxed/simple;
	bh=mGGtmXOkiL+NaXSLGTVrliW9Y4OXTHK6Zp3M2UoVbDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge7tlqm8MwzkSNvaHWCdVzfS3tQLhSQO5qVeA9x9Z+kj1pENHpHaQ2EP0GfMt/8o/QaxGGKPmWML8KWPlydbiLVhi4QdwUG1JKgeSaeqb3a9F5cnDb/i3pKquIKJcSi2PNaKSuo8FNpbtSy3bMS3GFfKBLarGYNe0VSiFGmjveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P1Mu2dVS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso3038467a12.0
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728672553; x=1729277353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGGtmXOkiL+NaXSLGTVrliW9Y4OXTHK6Zp3M2UoVbDY=;
        b=P1Mu2dVSzaPZswsJ0+IxBNCK3oVF3cUVQx2CKUzD56o2Av/5cafAZn8WY4CUC1/5mS
         pNxHP/WrMhdfYTyao2pWG92avWxiWi85ZtXd986wgIxGCa0ht3IF6/2oA8c7vY54Xp5g
         XDUgvJGZ49YNCGyr8pc5NQHRw+1v6QCZbkUz0+VjPD1Vn3zjtGgZUbAuPnfuLX03NljW
         oyqj+6SfwO6rpbPdCxQU+2oc1Dg/WEuIszRGhYFI+pRyLi0zQwjVEP1iBj1zymvtWnWA
         5ZCbzhjO9tglWaU9bw3QKdBF1iVw8A06QWBw1R/iUFWpMr+vVW9MoGiZxGRu03nsAas3
         4McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672553; x=1729277353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGGtmXOkiL+NaXSLGTVrliW9Y4OXTHK6Zp3M2UoVbDY=;
        b=spjenghEg9t+2sPEMb7cH4hfdi+PebugjpM4OH+S0KIZXGBG/N2I+gETImm7ysXW8x
         SEMcefMuQAxROHZBs8D6BHqQOCN9up7WMXlWacifHN3Ofb+1SEui0Q3OsAzF2/RuMCt/
         WngQ2ZUzTxxx6I2JU3MUoF/mglyZkL/2+nMgKWKzT3BMJsno4Q0pKjcSlL97UEUWflpT
         wrRdyJNg9fvd3zQdejSKKN95M9NkZg3JOXNPp8nyDP8wsLAvM9j884BmLBdusXNu0Lcr
         eFWdwVCk7CKrhMVhbYf9koKIipE5Wvr7A34ofx6A6uQNBUN0Fv+wffO7h0qvwQ9xubje
         Elvg==
X-Gm-Message-State: AOJu0Ywv4e4blD2QS4K8QzEUhaWxrQG4KRJPGnlywdWo72BWs9XnOaAN
	DRCwkUdWsDt723xaAYq07Q518FSU9F5Q5Lh1ECfDqHGGG4RtFUILaLg0vwE3R4XXOF4Tcxvrjo0
	LiXwlREwk1D7sv2phiXyERuEFrK8LRucptCyQx7SdrDxr6sc61fym
X-Google-Smtp-Source: AGHT+IFdOExi8Gh2dAs70FPXckILto1QCGfCelh7xShxCeFOgdGoVjbiGquJFr6yyliTvxCD6Id/DS/KMK4tTK7Of6Y=
X-Received: by 2002:a05:6402:42d4:b0:5c5:c4b9:e68f with SMTP id
 4fb4d7f45d1cf-5c948c8832bmr3152234a12.5.1728672553112; Fri, 11 Oct 2024
 11:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011184527.16393-1-jdamato@fastly.com> <20241011184527.16393-6-jdamato@fastly.com>
In-Reply-To: <20241011184527.16393-6-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 20:49:01 +0200
Message-ID: <CANn89iJvzWA7W-Sa1j0nGz2LCPbu1tdLs9uwL2xCT=EZ3rUtrg@mail.gmail.com>
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:46=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Add a persistent NAPI config area for NAPI configuration to the core.
> Drivers opt-in to setting the persistent config for a NAPI by passing an
> index when calling netif_napi_add_config.
>
> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted).
>
> Drivers which call netif_napi_add_config will have persistent per-NAPI
> settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.
>
> Per-NAPI settings are saved in napi_disable and restored in napi_enable.
>
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

