Return-Path: <netdev+bounces-82606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9FD88EAFB
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14461C31D44
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E6B12FB12;
	Wed, 27 Mar 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6yYArjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA24F890;
	Wed, 27 Mar 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556405; cv=none; b=X+QNNFK+jy2vNM8rv2qqWor34TLahfAc1c89C8Vl/KDEJpQUnJK54uzZACqbXrQxmBoHHT6XMVeZfKub8kvy0XDhl6L2cWDtBwdmWYgix5kDoiaVA+xsZU3XrJG51yNRW0vYEMZtlKOwNaq7TEb5hudfxcdXRwwYIH1wU6JkToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556405; c=relaxed/simple;
	bh=j88n54s9zbJvWLno8JfXJMl7NtO8hsipemJhXEQ6Oe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF+9SjGCPCyJa3QcWGinbE9DctHv+e+k8A5VbH+S/RdVdisCvilfz25KWX6I5Eyho1Sa+ZYNSfS78kcZliWYWqGbbUCFImdhTgGAeo4TUii0CjBHXPsEdzIUT4bLIU6CfnXLYJ3Q55d3dKbyMg/oUT26vvtA2jyZP+l5+VM4FBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6yYArjz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-341c9926f98so2659316f8f.1;
        Wed, 27 Mar 2024 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711556402; x=1712161202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA4SmAHnWf7E/XAz1zEJ5N0QxB09yCyD6l/c5eJ2my4=;
        b=d6yYArjzlsaFro0tR8lK5yIuGzuQck5g9g93jTBA72McGGVZMrTHyPrr/rfsvCgOp2
         oOFmb7iW4K58GoUyPNFiZiNNNoUKprYFAXTZiTm1SjT/M/CBMn+ESiy5jOrO9fN6MJRZ
         BUYnOM0YzS9J8nfFrZg/+WEU9hbHFu4reFKy7VWVFx4trfKG2+csQMwDAVfFpQYGpheV
         3f0/dAUMfZAIyQGHSDCQjtYGRiKB0cp6QmVfa/eoHNmuDHDJraa9XmAmzBoWC9B5MzSM
         bn884YYkKazijE6vVow6/ZQkk74TrGMVx2TLGXtGFsi3lkMVUMX/NR8QU00V41fqCTU4
         j7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556402; x=1712161202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GA4SmAHnWf7E/XAz1zEJ5N0QxB09yCyD6l/c5eJ2my4=;
        b=q9sUvF2/z9Wf/dffkO6Gku3r1XSbw8J0mXuKWDC1zmQMDL2/Jm8VOBavR8RwZbISub
         3GXxAdAimQW9YkbDsEPbJJ6zpBDfKRO4hNuF86sLw88lfQEoI4pImOONSUqCTuRKsFMY
         FxQ5oC8nReDYMMZIioUCG9QKPrVP93Ia0gL4lyG530DMYYkQZJBsWTX44s7k9bM90ukf
         UjPzTfdgbhNu4m2CutkdPIrFQ5QihhuQ2TgDIdJjq19iunLzxa3tpXTXQ6pXi61LAFeJ
         Zv9JhWaYdgl/GUlLwf2UkYJOQ1WwTa0CukBlDARxNdVd5evwkJkQjR0pLrfawWrhXptT
         X+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlALUS19X/8NvWXAx+HQnencAuIT3Oe5HF3DZFMYRs4T/SMhsPr5k1yuW7ivtwdsxp1XlHdbjRfta6twfHnN2hUkrsLIYtGMbYOIjiigRDpydbAgS8KD0y3ROw
X-Gm-Message-State: AOJu0YyECuJYQJwRasa30ssL2jqzeVDxX7klEEBY2rFwQN/spoDs1ZSL
	bHwZnZQV+jSMuQOHIrIjiKSlhRZx0K8hWrkTOeFyRs5OSbs6LiIkzcWOFvTeMpjUKEKdkmvzEBI
	KyzmFFgQHUfhTyg1a/Dqgp5X+mHKbX25w
X-Google-Smtp-Source: AGHT+IGOLUyybcaypmwHtjo1hmb6tDschtNePdsR8FdIz9SZnndIxYwA3hfIOexbD2jDzYa+ftvaKAwLNVT68AqgLmY=
X-Received: by 2002:a5d:6150:0:b0:33e:67c3:43cd with SMTP id
 y16-20020a5d6150000000b0033e67c343cdmr304498wrt.27.1711556402510; Wed, 27 Mar
 2024 09:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321134911.120091-1-tushar.vyavahare@intel.com> <CAJ8uoz1+ubemU4FPviGjTgtbW9f37=AxnDVXvkw85d4eQkfzhg@mail.gmail.com>
In-Reply-To: <CAJ8uoz1+ubemU4FPviGjTgtbW9f37=AxnDVXvkw85d4eQkfzhg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 09:19:50 -0700
Message-ID: <CAADnVQK6mRib56QC4K2RhCRH_1yHEH-37J_h25mZ3hwPRHbRcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] Selftests/xsk: Test with maximum and
 minimum HW ring size configurations
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Tushar Vyavahare <tushar.vyavahare@intel.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:24=E2=80=AFAM Magnus Karlsson
<magnus.karlsson@gmail.com> wrote:
>
> On Thu, 21 Mar 2024 at 15:05, Tushar Vyavahare
> <tushar.vyavahare@intel.com> wrote:
> >
> > Please find enclosed a patch set that introduces enhancements and new t=
est
> > cases to the selftests/xsk framework. These test the robustness and
> > reliability of AF_XDP across both minimal and maximal ring size
> > configurations.
> >
> > While running these tests, a bug [1] was identified when the batch size=
 is
> > roughly the same as the NIC ring size. This has now been addressed by
> > Maciej's fix.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/comm=
it/?id=3D913eda2b08cc49d31f382579e2be34c2709eb789
> >
> > Patch Summary:
> >
> > 1. This commit syncs the ethtool.h header file between the kernel sourc=
e
> >    tree and the tools directory to maintain consistency.
> >
> > 2: Modifies the BATCH_SIZE from a constant to a variable, batch_size, t=
o
> >    support dynamic modification at runtime for testing different hardwa=
re
> >    ring sizes.
> >
> > 3: Implements a function, get_hw_ring_size, to retrieve the current
> >    maximum interface size and store this information in the
> >    ethtool_ringparam structure.
> >
> > 4: Implements a new function, set_hw_ring_size, which allows for the
> >    dynamic configuration of the ring size within an interface.
> >
> > 5: Introduce a new function, set_ring_size(), to manage asynchronous AF=
_XDP
> >    socket closure. Make sure to retry the set_hw_ring_size function
> >    multiple times, up to SOCK_RECONF_CTR, if it fails due to an active
> >    AF_XDP socket. Immediately return an error for non-EBUSY errors.
> >
> > 6: Adds a new test case that puts the AF_XDP driver under stress by
> >    configuring minimal hardware and software ring sizes, verifying its
> >    functionality under constrained conditions.
> >
> > 7: Add a new test case that evaluates the maximum ring sizes for AF_XDP=
,
> >    ensuring its reliability under maximum ring utilization.
> >
> > Testing Strategy:
> >
> > Check the system in extreme scenarios, such as maximum and minimum
> > configurations. This helps identify and fix any bugs that may occur.
>
> Thanks Tushar for this patch set. A year and a half ago, we had some
> bugs in this area in the ice driver, so these new tests are very
> welcome.
>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

Agree, but CI doesn't like the set.

Tushar, pls keep the Ack when you respin.

