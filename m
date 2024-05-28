Return-Path: <netdev+bounces-98401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDEA8D1441
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3381C210D4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8831A8F;
	Tue, 28 May 2024 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIwdxzfh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD61361
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877017; cv=none; b=C71+JdF7Uaps/G/xufejYbzKLthD/JAKffsW2pg/gfoth0iL4On1EFWkDuLkyZE5yNU4qO7CZy212lJd/vTdy51c9ZNajTgllXCoFOKb4DsXO4CvM5fOJE3yv4cQAn7oCxT6JbH6g04xF0P45OY9Tir108bZPZ3WjY8opvxcjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877017; c=relaxed/simple;
	bh=HVd4DPZpfWcws5L2qkTnmvzzzJPaeY4CVZPuwEcNfQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ana2fzKDeO2OxX4ddaknU/KCls8l8Qwq62uZeI/FEKuKsqRfXgG4dwXXewUvc/iYa6MVUp4B3a4eorVfYtKZ0ZthVhP7jdBdyS9lNV8rfwVhrOcKlsWah5uJAU4ccpvM19qiu6f17t4eBWPQx7dFeLCe+5EuYQKHtC4KPNy6C08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIwdxzfh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716877014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjqG7ADveeCaXZ5UW3lKAiVh1hfQx3kB3hQVRqzxSs8=;
	b=HIwdxzfh8qGQcAvx5cVpT3Ss4AWsC+4+PpI23Ej+yZFv0Sa9yrKP4/EFFpwoa60iMLETpQ
	X3IJKgpchWBpdX20P3ky2jH9baXTC1QofOSkkYRpKg99fuKEnI7iNDHyHzQKoO37H0TIM3
	jYd4lqu9CJMOwJhJAzEeYbSSnIQi5Tc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-q8Rw9bQSPZSoxsEd-B_WHg-1; Tue, 28 May 2024 02:16:52 -0400
X-MC-Unique: q8Rw9bQSPZSoxsEd-B_WHg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-354fc1122baso340151f8f.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 23:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716877011; x=1717481811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjqG7ADveeCaXZ5UW3lKAiVh1hfQx3kB3hQVRqzxSs8=;
        b=O9Uh/EOOzwo/SOgFRstpGio8sgXqWouCfOMX8vnXTz5MUehbtGdkT2I68WZ7oUYCkN
         PFIi9UQRXBB8O1eiaGjTsfJaFTcMlXlngC86DUM0+FB2kLkuVh6A2r9pNmLYx84Aad+3
         yq4EdirBYZ+8BxzlBLc7qCdWT2hQAkHXuzml4JmytqbQpYsgryz9jwJF7n1YSgi4kH9f
         KcQB6qFp8MNeLKzZcnYTB7Ei3G0ezYsCcD/ktTE9h34V2HhlS/6g5vsLNTVsr5jwAbzH
         X7LgZcHkd+rH2wmrxjMBI9ikbrwXXziW6q/7mYs1HgHSEw/kjrmhBfSFDpgM0On6POHb
         4B1w==
X-Forwarded-Encrypted: i=1; AJvYcCUA283yn/J/Yc7J/H/IKijQlzy48UfAOz9XtKTKu5R1W4nyEKrJsWIkh8gOpz3gcypfy2NIOsbtP25044fVEW4B8auHWvlU
X-Gm-Message-State: AOJu0Yxt8u/QK36LS66D5/2LC61FKgXCMRJ95uvYibu3BiAAtLZf6Jtc
	n2QcGOC7xNGOBwVG83xKt4coBOvDUpbwSMq6wbpazHlpN23c/kQkzH3wVhfzhaEueCN63ChpIJm
	IMJQrx8i434bcqMebztB1JvxxHSbLwJBXv8u73JHoLbkZ1ZcaVoS7USFqfu0fY7w4R4zIOqEs+m
	ouSrlyTnalwgb6FrHOYv4RayiN3nNf
X-Received: by 2002:a5d:62c6:0:b0:354:f4d5:6bee with SMTP id ffacd0b85a97d-3552fdb0059mr8170632f8f.39.1716877011364;
        Mon, 27 May 2024 23:16:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG88TFXQBh2G9mY2MG8R/LMQt/sWQFlrKT9A+CwvmWXKIhEyVu0bFmQtX9Sf6EjB6vG7eHvoaQD7SWATEVgSWU=
X-Received: by 2002:a5d:62c6:0:b0:354:f4d5:6bee with SMTP id
 ffacd0b85a97d-3552fdb0059mr8170611f8f.39.1716877010961; Mon, 27 May 2024
 23:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522231256.587985-1-mschmidt@redhat.com> <28f2d06d-7ddc-4b98-bc58-b560028611ed@intel.com>
In-Reply-To: <28f2d06d-7ddc-4b98-bc58-b560028611ed@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 28 May 2024 08:16:39 +0200
Message-ID: <CADEbmW11zHQC3Cq8RAx_WEHPYwEE3O5oktgnLv-ScHN=0nuWJQ@mail.gmail.com>
Subject: Re: [PATCH iwl-next] ice: use irq_update_affinity_hint()
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Nitesh Narayan Lal <nitesh@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 11:04=E2=80=AFPM Jacob Keller <jacob.e.keller@intel=
.com> wrote:
> On 5/22/2024 4:12 PM, Michal Schmidt wrote:
> > irq_set_affinity_hint() is deprecated. Use irq_update_affinity_hint()
> > instead. This removes the side-effect of actually applying the affinity=
.
> >
> > The driver does not really need to worry about spreading its IRQs acros=
s
> > CPUs. The core code already takes care of that.
> > On the contrary, when the driver applies affinities by itself, it break=
s
> > the users' expectations:
> >  1. The user configures irqbalance with IRQBALANCE_BANNED_CPULIST in
> >     order to prevent IRQs from being moved to certain CPUs that run a
> >     real-time workload.
> >  2. ice reconfigures VSIs at runtime due to a MIB change
> >     (ice_dcb_process_lldp_set_mib_change). Reopening a VSI resets the
> >     affinity in ice_vsi_req_irq_msix().
> >  3. ice has no idea about irqbalance's config, so it may move an IRQ to
> >     a banned CPU. The real-time workload suffers unacceptable latency.
> >
> > I am not sure if updating the affinity hints is at all useful, because
> > irqbalance ignores them since 2016 ([1]), but at least it's harmless.
> >
> > This ice change is similar to i40e commit d34c54d1739c ("i40e: Use
> > irq_update_affinity_hint()").
> >
> > [1] https://github.com/Irqbalance/irqbalance/commit/dcc411e7bfdd
> >
>
> This is sent tagged for next, but the commit description reads more like
> it fixes deployments running irqbalance. Would it make sense to mark
> this with Fixes and target net instead?

I chose to not add a Fixes tag here. The similar commits for i40e and
other drivers did not have them either. If I had to add Fixes, the
referenced commit could be cdedef59deb0 ("ice: Configure VSIs for
Tx/Rx"), from 2018. But that's not good, because
irq_update_affinity_hint was added in 2021 with commit 65c7cdedeb30
("genirq: Provide new interfaces for affinity hints"). I'm OK with
next.

Michal


