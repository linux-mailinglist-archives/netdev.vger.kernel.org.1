Return-Path: <netdev+bounces-292556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIBdNM7KF2o7RAgAu9opvQ
	(envelope-from <netdev+bounces-292556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3035D5EC939
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA922308B20E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 04:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C0D313E34;
	Thu, 28 May 2026 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AIyX69k6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A45C30FF1D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 04:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779944137; cv=fail; b=MYDMHR41iVTihQM4P53nsO9o8Si9l2P3s+UkJQkK/6+uVlsy2LX/tFPyPB3zoLFKomtX2DWMKjPwFsOOStvI+yvNCZLy2ZlVkVDIQHYcxfOARIn+b56lUO4twF5WFPOz+jAu7XFn9jGEvjNm0RWQZQxvAytIbxh+v8gutK4p5Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779944137; c=relaxed/simple;
	bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO3bEtNoz6OmBqNGe9HNbYV3eatnpcYVjNMyIGKMw6XmdqmWOYYGUjaO7nBNypLz2zCldt4+qC1tFlgMtNPESXUhJ39LDuV6CXcch9iNTByImzZbx6IsBa1pMoJ5BOeVKbdS/wPsiZNb28X2bX4AuTcs5xQF5HYsTuCNF4NxgUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AIyX69k6; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RKjL614132713
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=CYYXlTA7hFjEhQyRif4MBMndMkIgqNioaptIr/n0Y0M=; b=AIyX69k6A+c9
	mM1a5KjBZFSdIajJE7N6M+mQ7sGkngpIAcWIEq6pqulW9U5nSY+gI6sFNht86O+Z
	2D6jvDhopxPYZ1YE7naoN5Kloh1FC7xqcci30zbsC9zqOK5hXC7sYrpQFtCwvBAF
	CM6JDW47bs/SUBHJiMz/+G0F/SU/VgcW4J5HaITGfovQtixxblrvL48RNOE4hkl4
	QSltZkNb8/8gzsiQJteEhsP1K0aDt00kHUNwGqFqoNzF4bdIzG4nAfjSr3a8Np3W
	FHPEHYqrWlMwWuCKKAYylzQAXpY1Mcpxe88gvgN6QcAwDuFO547/X8h14sWFBIaG
	Xo82qWEcqw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee7x6j6xa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e4026a2524so6075723a34.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779944135; cv=none;
        d=google.com; s=arc-20240605;
        b=ktKlLfvxdrmyH5+Mfxa2THwvwFm1UxKie9IAbhel0r7RxT5K00fTHlp6Xis8eDODX2
         fhF9wzQsiFcdKAf08oq7ChMdXvOwORdaUdxNlY7HhHLJ76z/ZfGG4x4S0gw9+/Y7TFL1
         lhtJxOSwlewz5PTMHC71o/7eKX3giLl/duaHy9x7SlwdqF/I/q75aMG3M1m3pbcbuGbJ
         G350kjefH6GsfWvk4kSoqxlaPBZ36H/14sTVGw6YBZvYswYCBBWxrqNItk4pNulU9oti
         lq/zlgJye0es/FqnKTcB2UrTqYsGwvH3QnSa9oiJXk+GXugkuSuX8Fc+iAOLDsYH4Tty
         ckDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        fh=rlhgyBedhiP0b8HLSs2+rgid1+fCuRmwok28p26vIzo=;
        b=ZidTSFO8PBqb2tigNNCE7JlFZtJ2kJgVocQUNXN6BZJW0Z1v8xcFAOxysBog/BJ+Wz
         qKP005n7ORk7o+r6yhVFOq81Xv8M//2V+dtOZw+7iNRGmuX/aF/rq//gbwCV8LPLkzQ3
         GKsQcJdKygNURIBA+IEPI48cSzMnqM9Sp+FeW665mLzZFsGVeEEpIR0EIuLqb2L2S7Ha
         qNpD4e+J9B0KjO08gqTtgBvyZbnaqWllcElWgwfgy21h8vLvMUedLXG7cwgnivZ0/pod
         ezywDoEr7LlR3/qo8QrutqMbgTWKjVixP1YBeiI6T8BCKc9iozEUGZlyKS7PsLvmjQjA
         F7/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779944135; x=1780548935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2lex2yvH679GF+7VuxlXdYUBKG+oUT1Bop2JInZINhU=;
        b=r+T5tUa85QO+D4dsuZZ7M5rDhgSCUmYWqeL1A0zJgotOlSWQTC8ja9G6Dynh4WC4Md
         TFnr3dRmwyMKEcoeOXpsfWQlLxIEFXWvp98Zgr4EhDXkjjXhlkbD4uwdxLPjjkZSIoBM
         gCIjmYxDKJ6NsyA3Xw1ojEBFqqKc0ZEwse+EDrxCilkVH/vqtYFqlQst4jQOobAwYzcJ
         kYCf+cJionbZBmo7acsRj1uuSa2pdVZY3DqNfmQyXQjGZtbkK5KlDbf6dpbv1jMA72Z8
         G51zpPzPpem0c2N0dVOoXkUQt36wiMPHD/4MDiZ4Olr05kERHn/G9TSMYbaXNyVbJON3
         V+Gw==
X-Forwarded-Encrypted: i=1; AFNElJ/PBAjo8ijkV2o8UxQukYHz3gjLilYFUdHoDU8RqvXv9J7CrtVoeAFL7zb/TCMr32KfS2vzF70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhE1mG+AQKwZngFqm8y9iCvhu0UorJBqJPKT7MtdryOrFLLi86
	VDvAnLu/lxvUGt27bouCaO0/0IfcXCd+MtjQFXGg9spVPtGbOnkJo6CNM8Z+4ICT8ZCl0Z91VEt
	vBiRzj+EXc/dYcbm6JhqmkJ2s5ZwG6fdzkWXOXyUs/lRQvcPJUyygSzQXtvgwT79dYRhax3gBXn
	kFW+4q0aSrhvyaW8/TyyBRnpJCkF4CatA=
X-Gm-Gg: Acq92OEX0QRE+BQrjp403yBuyHOeobi6R2+8ER7mRLRWsO9n14W6hGhSvpe2vpUfENn
	YS0LWr9Jw9w4CMJ9JULb7tuY2bdBNDy3I2ia5kPgw4v0s+SKD/JkhvgjjEMrImJALyRj/NSURsg
	t3apQC1NFqK2E/LByqbwICIwoylSVf1fSmuw7d5ejExroBQGe3scp0QhNlyI0DeiK5E5CuR9yxp
	M4pmvg8Mbmgcj8eGp67sAAMvPJjGEpAGgIwn0PEPfR/vyr11BU=
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id 46e09a7af769-7e5fee23f0bmr17184410a34.17.1779944134693;
        Wed, 27 May 2026 21:55:34 -0700 (PDT)
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e5fee23f0bmr17184388a34.17.1779944134274; Wed, 27 May 2026
 21:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
In-Reply-To: <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 27 May 2026 21:55:23 -0700
X-Gm-Features: AVHnY4KjB7ggvEym3yYxunms23zRrE8n2XXaWHSRU_rJj67WeYLMsK98_vs1TJk
Message-ID: <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA0NSBTYWx0ZWRfX9ZM0g56UoWfK
 kitum6fAn4MBnhdiTa7rcrxxIVKK3wkYQA+i1J/BWuFwkLekdEeImjng5I0jXbSRY2lfAm43KrL
 cPLRIafSPi6FGvtWv3WpdUXY+kwsCzAxTkXNELq07Z1ww6FCiaf4Di69xBOPoiRfvCTT/wpz1hT
 iiVWf5v2fyqO8696U4HtcrNSJ749JZCLaVvp7kXRlQESRTfrhq9mbUkWWTPkgSka0ziufhass/b
 TvyCtRo4j8sy0pxgIv7JEzzcnTqNutB7cE3/p7nhcxKEfoJTp0F/92DfjbyOcmJKT6BtwGWpijG
 XM1qWLYfW2QsTRj+J6xWkTcR3V3ggWqT8gu1r2G989O53My3SgM1D+76EVYXO1NhJqQ14XYICJo
 CBy/zmuWSYlX2WdPdKOsmxZlegbW0CVOKHDt3cYqrHxQ77KcQdX50nw+sPOgaPdByUYsJ76Dcjl
 y7mEoZv7FYpRGcVc9AA==
X-Authority-Analysis: v=2.4 cv=BoCtB4X5 c=1 sm=1 tr=0 ts=6a17cac7 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=zd2uoN0lAAAA:8 a=Vls0teBZlVDq3xJ5GeUA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-GUID: AdhQldIsoIhntGkE0HbCF9LR1os5M6cj
X-Proofpoint-ORIG-GUID: AdhQldIsoIhntGkE0HbCF9LR1os5M6cj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_01,2026-05-26_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292556-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,amd.com:email,meta.com:dkim]
X-Rspamd-Queue-Id: 3035D5EC939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/27/26 14:36, Jason Gunthorpe wrote:
> > On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >
> >> Yeah that's a good point, I should probably rephrase the question.
> >>
> >> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>
> >> But my question is how is that useful to a PCIe endpoint? What is the =
effect of the ST here?
> >
> > TBH I've never heard Meta explain what their device is doing with
> > it. At least it seems to be super important to their device..
>
> Yeah I think at least a brief description of what is going on here would =
be necessary for the review.
>
> Otherwise we have only the info that the exporter wants to give an opaque=
 ST for the importer to use and no technical description what that is good =
for, how to test it etc...
>
> Regards,
> Christian.
>
> >
> > Jason
>

Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover letter=
 and the
patch's changelog as well.

The short version: in this series the vfio-pci device is the completer
of the P2P
writes and mlx5 is the requester. As Jason noted, ST semantics on the compl=
eter
are implementation-defined, so only the driver that owns the completer (her=
e,
vfio-pci on behalf of its userspace owner) can hand out a meaningful ST; the
importer treats it as opaque and just places it on the TLP.

Validation occurs at two levels: PCIe analyzer captures on P2P TLPs, and the
 end-to-end P2P workload yields only expected results.

Thanks,
Zhiping

