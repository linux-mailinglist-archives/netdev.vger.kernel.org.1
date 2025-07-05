Return-Path: <netdev+bounces-204287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86687AF9E94
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08088189C5F7
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DD81FA859;
	Sat,  5 Jul 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="dwUbXZMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204320B1F5
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751698917; cv=none; b=Ylvq3RHqq5vFFlIWwd3phd9zfI+t17cIVf+URkwaTlACjpAQdkEmgl6/+lr0ZPU6iML/uXNKj6fi36/EvS5mZo0fd/3lA5GDp3yqZVGuTckKT4xIQdp89qTaGE82bX3xdK0eUCsWVQ21xWaj4Hh5DbvW7WxTJE3HMuTP19/i2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751698917; c=relaxed/simple;
	bh=QjEnynwiHDhQP5PZTUAgnZKYFJ/39FKKd2Q6H8WQyQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr+lbJs7Kl/mhmbb1BmUryeUDMW/1/JzG3dgxhaFEFdBer8NV4dUGXKgBG2xPDcvMMRREyquc9E+PgI6bjqXvisPWevJbfEe8dQF+yUDAMlFBgT83ZrB72Wvx0XgImtkJNPTyiAZ+GQ9jYBeqj2jP5+7bT8BkaVMHwob7D71+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=dwUbXZMv; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae361e8ec32so328384166b.3
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 00:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1751698913; x=1752303713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+B/RDwnbgv2srEjK10waQf0Cyf424fDE1uZHA2I9lg=;
        b=dwUbXZMvTSiJnQsF/1TGcNUlU7cUjKGgsQSsbuzlJlLLHmA5Hp0pwI0tqOZxGgME8J
         Yivt/H61uGcVHYvzmj2CV5pj2EaxmMpfqTBw/hJcMVeWHoQkV5e3SNLYSCribWOEVV0q
         iAn116IezoKguk0c9CuETLNVIDv+GxPMryfVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751698913; x=1752303713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+B/RDwnbgv2srEjK10waQf0Cyf424fDE1uZHA2I9lg=;
        b=TJ7Ug6ivE1O9T94eb8Clnt7o9G29riBD7WPVGq1k4HJykO7GBhzKhcxXRZKXFujoWq
         cAQpKNuuf4uP8k//rWqZyqIbaYI/1M35JrmZQdAzIUDKhZ8lk4yhyAL66g8OCkv37vq9
         KOG17gaPx9q49igQMcMVx99cfUyrHdMft0Cak9HHoMk3EVJpd6Pkm6pIfdvfx5bXxHdu
         Hx0P8mXkXEoO0oEropVxcm0dC4oX4u2MIAgTOjcPmuv2po6WxQ/1lMEViu37LGY0Q2zc
         Ewx9KG+9Hu+Lt/k1ljiHYa2Xh66S16y/iUUEhKQ/HoJi6OXs4pWtDeW6L+GNPuTKZq5x
         YnFw==
X-Forwarded-Encrypted: i=1; AJvYcCW5kSQ+fU9BX1vU/8aSMK2mPQ192ui/MTDVZq13bSdx8Par9MmviTNPOD+qPvsxMfpYQYxJWr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2MfKfC6zWay16evwMn9EEBOz+dQdE2cCOPXy0k1gMMBB2PbC
	5ARtIHF/Q1GuDwgI6k0yMHJ2h9pRV75w2+rdtx8bxHR5kufS2kUWuEv9K26eBtOY3I2JDu6TbT5
	Ybvsr+dQ6Ozr/tIN7eD6BWdBCIeNZJm0OJaAE3NYJ
X-Gm-Gg: ASbGncuBNLdy9/VWwebyBdihA29LnGLzZ/OZHIAZRLiitOITMRaIDscrzD2ALr98CJM
	p7qUVpKxk/2yxb/kN3kVffDPCZjBOZyMt6BpaBS4sW8zObF9FRlTCxymzQh3XmmeHcrXIOpBnXa
	Xq5qxJ5+uUN1E1DxNPwf1/DpSoNAkduLkKueToE6CZVaN9
X-Google-Smtp-Source: AGHT+IFZNGe5yhhDERjrdCMDkrJYVHRb+epjwumv6RBELYxXQX1wAeeejnpm1EGNA6u6CvCTxThS06tD3fpmLZpVlIM=
X-Received: by 2002:a17:907:d23:b0:ad8:9257:573a with SMTP id
 a640c23a62f3a-ae4107862a5mr122681966b.5.1751698913266; Sat, 05 Jul 2025
 00:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
 <aGgHka8Nm8S3fKQK@localhost.localdomain>
In-Reply-To: <aGgHka8Nm8S3fKQK@localhost.localdomain>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Sat, 5 Jul 2025 09:01:27 +0200
X-Gm-Features: Ac12FXz0iPXl1W6a_JIMngDrS-AC2eXoaB-V4pPDY0n9tMd_rdWNz2tfHyTkcSo
Message-ID: <CAK8fFZ6KzyfswFE=qj6pz-18QZ16swdwyFfTf=4e_0+sPLyUcg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] Increased memory usage on NUMA nodes with ICE
 driver after upgrade to 6.13.y (regression in commit 492a044508ad)
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, jdamato@fastly.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Mon, Apr 14, 2025 at 06:29:01PM +0200, Jaroslav Pulchart wrote:
> > Hello,
> >
> > While investigating increased memory usage after upgrading our
> > host/hypervisor servers from Linux kernel 6.12.y to 6.13.y, I observed
> > a regression in available memory per NUMA node. Our servers allocate
> > 60GB of each NUMA node=E2=80=99s 64GB of RAM to HugePages for VMs, leav=
ing 4GB
> > for the host OS.
> >
> > After the upgrade, we noticed approximately 500MB less free RAM on
> > NUMA nodes 0 and 2 compared to 6.12.y, even with no VMs running (just
> > the host OS after reboot). These nodes host Intel 810-XXV NICs. Here's
> > a snapshot of the NUMA stats on vanilla 6.13.y:
> >
> >      NUMA nodes:  0     1     2     3     4     5     6     7     8
> >  9    10    11    12    13    14    15
> >      HPFreeGiB:   60    60    60    60    60    60    60    60    60
> >  60   60    60    60    60    60    60
> >      MemTotal:    64989 65470 65470 65470 65470 65470 65470 65453
> > 65470 65470 65470 65470 65470 65470 65470 65462
> >      MemFree:     2793  3559  3150  3438  3616  3722  3520  3547  3547
> >  3536  3506  3452  3440  3489  3607  3729
> >
> > We traced the issue to commit 492a044508ad13a490a24c66f311339bf891cb5f
> > "ice: Add support for persistent NAPI config".
> >
> > We limit the number of channels on the NICs to match local NUMA cores
> > or less if unused interface (from ridiculous 96 default), for example:
> >    ethtool -L em1 combined 6       # active port; from 96
> >    ethtool -L p3p2 combined 2      # unused port; from 96
> >
> > This typically aligns memory use with local CPUs and keeps NUMA-local
> > memory usage within expected limits. However, starting with kernel
> > 6.13.y and this commit, the high memory usage by the ICE driver
> > persists regardless of reduced channel configuration.
> >
> > Reverting the commit restores expected memory availability on nodes 0
> > and 2. Below are stats from 6.13.y with the commit reverted:
> >     NUMA nodes:  0     1     2     3     4     5     6     7     8
> > 9    10    11    12    13    14    15
> >     HPFreeGiB:   60    60    60    60    60    60    60    60    60
> > 60   60    60    60    60    60    60
> >     MemTotal:    64989 65470 65470 65470 65470 65470 65470 65453 65470
> > 65470 65470 65470 65470 65470 65470 65462
> >     MemFree:     3208  3765  3668  3507  3811  3727  3812  3546  3676  =
3596 ...
> >
> > This brings nodes 0 and 2 back to ~3.5GB free RAM, similar to kernel
> > 6.12.y, and avoids swap pressure and memory exhaustion when running
> > services and VMs.
> >
> > I also do not see any practical benefit in persisting the channel
> > memory allocation. After a fresh server reboot, channels are not
> > explicitly configured, and the system will not automatically resize
> > them back to a higher count unless manually set again. Therefore,
> > retaining the previous memory footprint appears unnecessary and
> > potentially harmful in memory-constrained environments
> >
> > Best regards,
> > Jaroslav Pulchart
> >
>
>
> Hello Jaroslav,
>
> I have just sent a series for converting the Rx path of the ice driver
> to use the Page Pool.
> We suspect it may help for the memory consumption issue since it removes
> the problematic code and delegates some memory management to the generic
> code.
>
> Could you please give it a try and check if it helps for your issue.
> The link to the series: https://lore.kernel.org/intel-wired-lan/202507041=
61859.871152-1-michal.kubiak@intel.com/

I can try it, however I cannot apply the patch as-is @ 6.15.y:
$ git am ~/ice-convert-Rx-path-to-Page-Pool.patch
Applying: ice: remove legacy Rx and construct SKB
Applying: ice: drop page splitting and recycling
error: patch failed: drivers/net/ethernet/intel/ice/ice_txrx.h:480
error: drivers/net/ethernet/intel/ice/ice_txrx.h: patch does not apply
Patch failed at 0002 ice: drop page splitting and recycling
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"

>
> Thanks,
> Michal
>

