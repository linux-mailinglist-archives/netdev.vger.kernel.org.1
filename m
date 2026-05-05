Return-Path: <netdev+bounces-284495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKLJFrQV+mlRJAMAu9opvQ
	(envelope-from <netdev+bounces-284495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:07:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 747274D0E0E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F091A301FB34
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D4A33064D;
	Tue,  5 May 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRLB5fuK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04AA472760
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996656; cv=pass; b=U1VgcqGwzvDllJtiRmifvHhK7sGedbZDcsWH0/EO+4SZioOLFtekzGeOrxeqSRBocxneujdNUKwkJhbVr8f2L3Pm+foi0Urhaq0ot5faF8WgocP8RA91adIydIkMEz0DIAPeS9/1CjgpzAOXkTuBTzx7o8HPH8xjlT39gGAQ8vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996656; c=relaxed/simple;
	bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msGpOHdHhH1o7RE9a+Cb4Ez0z5hPD9AD0OMs6/lcf6PKCy/dnPQVmSOFOtmtasKNn6VWQgZPIJTn4ssL2tmWGUDNQ5708BKONekJ+cjkyg9Y7LnA8gLTYJo7jufQCQccR3I7DIsKjHzcexjqW/QnE99AV/dta7XVP90FZtf38ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRLB5fuK; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-130b2295ed0so2446425c88.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 08:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777996654; cv=none;
        d=google.com; s=arc-20240605;
        b=VVyBZmWuJ3Tuebn/S5iDF0WyHDBQULW0MjG4jDCCJxJQ2NpwDfqAgLQV74sJoFSrTm
         3lxQdR+irFUPmFTt8xFrIen2g3JP7+sfUWrnQRMCfMSXfZGL5FmZL66qIrBbJjBHgHCF
         wtD1PDnvfiRlFRD52sbsynPjvgyJNxvUq+XsoX8t/zGr7PpNhV18DtACTiamyXlaTt4b
         zuszq4BpRuQul2NWhOdac2GAsxn1u8g+zwb+uIKbJ+N/xKe3ozWNjuiwpOOrG+eNBACJ
         heK3xURCRmoFvmM8HTKy1gqBAHYKi61oY8Ml1jMp82PZ9GKGgWjijPlud65B9w4ZoXZ7
         kLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        fh=KUeV0kbfmQC+LH24dk5qyBO0VSscQETtYAGNrnCHZnI=;
        b=ZYhFWu3B6N24B0BGDxwoVaChbqowLIswSUjKiDfSphSqBcdJDjHKsDUJSfQmW4fEZs
         H7k4O3fFo7PvLvsqGwQ2wzLwSoavqbCb4/5vWPKpES/qGp85rUOkzHTUaq9pXfhudCsF
         774tLRHSdmkx6JUHKFs3ZsjLoXok3VK6N+7xmloKu0nG7hIK5yJgm4Odml4ApuvVeoU8
         mNp945HR8HajGyuzC2rpbh0zPA8rJ1xT5De64sP1+XUT1bojdVXycD+1uLzDMe3FPYOd
         yAkqF5dZweKpFFY9rLLoJ6MPGt01tFW29LMutgxfyWnVN8FE+TDHMt3OMvWR4aP0+tvY
         ds6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777996654; x=1778601454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        b=SRLB5fuK+rlRbRhR19pBwry7cLZbvtRVEXUjGHjYwtc7Am201qdkI/9ScVbPpVQdvn
         o2+lMM+mNjjwpz3ySgVFsMjc05G/Bf52ulrCsBdX7D1k+oOdBGuX+Blizi0Db0U0DQZl
         gTtzzuxGExcSNZrIP+LJ2Fy65AuAcfV4gP3yHMpJbf3+WcmoeJqfp/YykIkfmeW/Wmog
         axaqM/d0gMoaPtVMeQtHkwwIP31E8UzAem7dL8aR/VWks1SJMK1r5/UMEOZGfd7wFjgH
         sQRJNkzol8SOmXs5P68i43fKcXV8qkp6/l/nsK5WGFQAENusU/Bf/XPf15vZX5LuAXTU
         yTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996654; x=1778601454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LDNzA0ktaQOd9EO9z8tWH2U9AqQnquf4cSGKsb1TqKY=;
        b=NJmmMP7m4fpEQGf7nGDIrRBaOlB1OGjEXBsSe4Xal0T+Ohf2LcZF8jmkaFuAsuGJT1
         SOWpx4TN3kSjwZKhrICRiW88AWldjy00pnXqlNsnR9+QQMd+m8lYarsjp1OeuUuR5h+1
         CH42xt7k8Or2/txdB3WUyP6R1IfukrBc1gsAtFKG3MuDqmOAwLhHdYSzYnLr7wCMCzG1
         lfknKD/qByNUuubOXJyOgIGGqyxYImXBd0zAanB507bCFaQELoBCUYqUBCAguzZsaD/u
         d0EiEicrkHx58JTbScZUefxZki4HJltAA6eE4KQ3La65Zg9LjdC2FnCcvmcPYdhswk4c
         i+uw==
X-Forwarded-Encrypted: i=1; AFNElJ/wlIsCpb5uRTSqr4nghhOkTrK1/wZdqI1/5awXwuH/pMkTQ9+whyUnWfyFpqsYNuYeaoM/DO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13tHlD8jJLJw51qr0Kg6iOMXt2Qzoxoh9se9uUgp3VZAuiZ+e
	C5k06Ilyq6YsCz/rBALQjpnz1vnA4nkEj5O/zsSRjNYIcGvqE6AmRDDzy7bq8wud4FhUgbpdsqR
	z38/lg/Tos+OVcAhOhfGT2dX6b3qvvMfPAfQfMbP6
X-Gm-Gg: AeBDievUlKMGbnAF8MgwqJsEOdTed1eDEUofq2Notm4D/PueOGekhFsCT9tO9hxYGNk
	clFprziBdL8/rkOG2wzGS7YnPYavL18USCtir99NVczL0NZ3/9PtvTnAHsfWUUpc0dCx+K4wUKP
	eUTbDe2PiIlrhXsOGf5q+mpK9+aR166hCCcdi3jA0pW0YjkyP/V0OOOMxZW1A+mC5Cm08YdSNSV
	otc40oBMhuC1BN7jg5T8MMYjymZsnMvzTkKpD114eHlgKsNtI03G+k/cJNBExQB+N3tf78daI+R
	BrrGUbFX5VDV3o+RQppiL38Vu6jJmA==
X-Received: by 2002:a05:7022:b8c:b0:128:d34a:320f with SMTP id
 a92af1059eb24-130b173badamr2261604c88.12.1777996653500; Tue, 05 May 2026
 08:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <CALzav=ci8bi3=sY+F3HJTB5sOQ_pJ8Lm+kz0CDBBWVXry5P98w@mail.gmail.com>
 <20260501164314.GA1381708@nvidia.com> <afkjkBq8B-4KjhS_@google.com> <afoR1izCEe9y0MZA@nvidia.com>
In-Reply-To: <afoR1izCEe9y0MZA@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 08:57:06 -0700
X-Gm-Features: AVHnY4JrW8dKYzLI7vKq9aNciL3ihCmWQQqvYeVf-qNxqF1RpyWt82ID73cuiLw
Message-ID: <CALzav=d7a-55mg01MEfaonsU-+4QxbRE3QXpZLskteF28tdaUg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mlx5 support for VFIO self test
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 747274D0E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284495-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 8:50=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 10:54:08PM +0000, David Matlack wrote:
> > > The PF support flow requires a bunch more complicated stuff.
> >
> > Do you think it's worth supporting PFs? If anyone with a CX NIC can
> > enable SR-IOV and run selftests on a VF then we can keep the driver
> > somewhat simpler.
>
> It turns out my test system cannot enable SR-IOV due to iommu_group
> problems so I rather prefer to have this :) I had to hack a kernel up
> to do the initial testing and it was very annoying.

Ok sounds good.

