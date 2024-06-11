Return-Path: <netdev+bounces-102527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC3B90380F
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8131C231D3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B149317623B;
	Tue, 11 Jun 2024 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MOH6AnyT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288013777F
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098938; cv=none; b=T726zOacHQq8LsB5j+Yvi+8UO2FEqA3tNiGTwPG4RB6DJEKGZLsyF6Ibq3cRaqajhC+RpWrau5GokzCnRntIxY+t0gzt4OcL3xta+5o4zIwUS3+4WWEADjG+vFpjYrc7Im26WN5dKnvmGnMoSPGRgJJDetbN3HqTZl9J+oKxhJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098938; c=relaxed/simple;
	bh=U5unDrRJ0O60368h3zCjbq1bA2ZHsRuYRLRviqIqcx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJAoCjqZGEpB3QGpvNB31jKNjCcMyUXD8rkGahAu46PAVsZTpcGxcHcDCRn43ME7bcaPTAat4IR7OQGbxEaHjyphOb1mqdxevgxCw8siBZ9oaegzdvRfqNxgmfGQuqpN8d7QnmfXlU/FSwOVlKf5Ey9YAtA6ORRHo3LGeFBgIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MOH6AnyT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718098935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5unDrRJ0O60368h3zCjbq1bA2ZHsRuYRLRviqIqcx8=;
	b=MOH6AnyTGNWaHKM8GzgI8e/VOkI0OHFBphbWYxeLUybP+fvIYdJVgfnBBs5lYwnGzcuOkL
	mEj9tNkQ/D+M0Otcsip0RByP6hkpvQUAoktftfeXyx000DeS251Ho2cP2HxrYR9jxFrKUM
	UJNslEelZxyRRk+4+j5xQIbJgMqfpbo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-1V7P-XUKODWKYH4_FKR72w-1; Tue, 11 Jun 2024 05:42:13 -0400
X-MC-Unique: 1V7P-XUKODWKYH4_FKR72w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c3213b3878so1140324a91.2
        for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:42:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098932; x=1718703732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5unDrRJ0O60368h3zCjbq1bA2ZHsRuYRLRviqIqcx8=;
        b=U8Tv7NmolTz4qtMKV1SAq+ZXYhUB6uwi1ynnrqgU/EX1369jK0XrAdfzrRuuAV2LdU
         Jxztonlq/UpedndRdw6dOOEfjoDZBmvOCdIT6jsWzSXTF8pT6epyLvA4sZ59Ny1C/m3d
         MJH3YJqz8USqzvQD8EjSMsDMe1/M56mpCgkrDyfu5bYmWmuQ5W1OF5fGobrMZVKYqFOd
         4qHxEL75zYSdqKg4R8CcqHxziTBaZKC9WMQbeFNogWOth/Z2Zdzx+z25MmOsosGLpE92
         dZyLrF4pZta02qZporhYHXkpovHuhCvo0eFcqtUIK42dcJF2vrYgrVoCI0rQNUnIxJ7X
         UYtw==
X-Forwarded-Encrypted: i=1; AJvYcCV/GYtC/pHXpCofO2a+9ljw04sQL6iNkq8sF8zHEdv2rzmNaXkXKwZivDo9GKQ7oogJF2UDQeBUlW3nfgSte9dQP9JcMCo+
X-Gm-Message-State: AOJu0YxGq6p/HRa5mY9atEBULu/FFRq5nOsA/iz2/AC+TV1mcIIK7hVr
	MtKhmC/3JJ6r2GIh5wndREGmBm4SymHQDQnM97fLGQFZBTLtvmZqlEKOU8ooCd1FAapLe33YMbv
	PQbEuBlP6Uad4V63Ne4IyeoDpkUh3Dwt2TYsrrd1nEW446pXaHXT0dvhE9+HqeVThLRuL4bd3sK
	iZf8/EMXG4f/cAEZn0ykyyoTfvkjmK
X-Received: by 2002:a17:90a:bf15:b0:2c2:ce08:d0e4 with SMTP id 98e67ed59e1d1-2c2ce08d1cbmr9733680a91.23.1718098932311;
        Tue, 11 Jun 2024 02:42:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyzDYIkyxO8ToD8S9H2/1wx4M7N2ou+ok5olmea8867gAIpOUjLlGIlzn0XE2htX5QCza7k2rCZTyNncWAKtU=
X-Received: by 2002:a17:90a:bf15:b0:2c2:ce08:d0e4 with SMTP id
 98e67ed59e1d1-2c2ce08d1cbmr9733667a91.23.1718098931890; Tue, 11 Jun 2024
 02:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607160753.1787105-1-omosnace@redhat.com> <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
 <CAFqZXNumv+NNZjR4KSD-U7pDXszn1YwZoKwfYO2GxvHpaUnQHA@mail.gmail.com> <2812aeed-ab49-492b-8c93-c553c2a02775@schaufler-ca.com>
In-Reply-To: <2812aeed-ab49-492b-8c93-c553c2a02775@schaufler-ca.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 11 Jun 2024 11:42:00 +0200
Message-ID: <CAFqZXNuYpe130gL2qurzEsxH69rdLuw27Atg963ZCWewU+q44A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 6:53=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 6/10/2024 8:14 AM, Ondrej Mosnacek wrote:
> > On Fri, Jun 7, 2024 at 8:50=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> On 6/7/2024 9:07 AM, Ondrej Mosnacek wrote:
> >>> This series aims to improve cipso_v4_skbuff_delattr() to fully
> >>> remove the CIPSO options instead of just clearing them with NOPs.
> >>> That is implemented in the second patch, while the first patch is
> >>> a bugfix for cipso_v4_delopt() that the second patch depends on.
> >>>
> >>> Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> >>> https://src.fedoraproject.org/tests/selinux/pull-request/488
> >> Smack also uses CIPSO. The Smack testsuite is:
> >> https://github.com/smack-team/smack-testsuite.git
> > I tried to run it now, but 6 out of 114 tests fail for me already on
> > the baseline kernel (I tried with the v6.9 tag from mainline). The
> > output is not very verbose, so I'm not sure what is actually failing
> > and if it's caused by something on my side... With my patches applied,
> > the number of failed tests was the same, though, so there is no
> > evidence of a regression, at least.
>
> I assume you didn't select CONFIG_SECURITY_SMACK_NETFILTER, which
> impacts some of the IPv6 test case. Thank you for running the tests.

You're right, I only enabled SECURITY_SMACK and didn't look at the
other options. Enabling SECURITY_SMACK_NETFILTER fixed most of the
failures, but the audit-avc test is still failing:

./tests/audit-avc.sh:62 FAIL
./tests/audit-avc.sh:78 PASS
./tests/audit-avc.sh PASS=3D1 FAIL=3D1

I didn't try the baseline kernel this time, but looking at the test
script the failure doesn't appear to be related to the patches.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


