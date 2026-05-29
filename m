Return-Path: <netdev+bounces-293002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAoKAM40GWqdswgAu9opvQ
	(envelope-from <netdev+bounces-293002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:40:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A895FE0E6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 08:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCC2A30C9351
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D493A963A;
	Fri, 29 May 2026 06:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="tE2F1C3+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D43A9018
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036493; cv=fail; b=hej4myzE2pYXTADW8TjTv1+ewV9ibfi0Lo/ONDj2OsX9k81UB72HNPwhMGkv4ZsgC7hC7Ficg8HiPLGD0lrGbwjn92rAIRptqHIbA0N3G9Qv5Zcv9Hwc6xKFyIo4zUKeLdeupb+Xb2VLRKaF0whHaN7xvCeSOUeESMzqrWNiQcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036493; c=relaxed/simple;
	bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuBic7kaIy62AS8xr/2mLCmK/uGgUWk8MQ6T2rQsicOIPxSGL4eUKkEUKWjJrdDKEAbzBROmniwgnHmpTfpWO6SJQn0rgaDXeIIHGMBFiMy5tkC2CR7WaVHVDqR8xm3Dz+YIH/E0TzU11cBC1rfBU413wc5pJhvuaunGum/hs6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=tE2F1C3+; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T0dAH12186999
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZiT8x+cfHgSyrwMnA66rNUoxHkXDnwIwkwrIcOdA0Bc=; b=tE2F1C3+IWIc
	hD6uPAo9NgDmLx3SiAIqN6xdU/vi1BTlNSH50fpgV8+w2z56TbYNWRvwyATimLcQ
	6gBB7u+bSsBhHZxDEcSgqK3/4LhMs0I3XhEpCctNiBQjacxzZ64Ht3GAKINKXsRe
	2a4b6ZZDgp7DFIXB6NZzeM/x8uiRnSviRZdPNOFY+C+No5faqHXGRxg3ix2FcSdL
	ETSBtsgPPA9Za6p83WxjzQ6xcL+i2YajrLWFKyrDiNGr07q5cwUoyo4ikTdnEkY3
	yiwI4qfRPsWTAFXgnVqxw2XBZSbFpE5+g2k/neK+34pAldo7nom/u4tzd6ac5WIM
	FzG4O2F7ag==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ee80925k8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e4de59797fso22424088a34.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780036490; cv=none;
        d=google.com; s=arc-20240605;
        b=cdmyfK9/hV0xTHNSpsTFKUPAPV1jnGCw7d3NUrBtxcbxXITo5qN1zKUPpEMPmG0txl
         DweIiLQEINZdIA1iB3Jz4M9JPkxfqTGbeG8Ys+Q9YkckUiKpSCARo0j9LxQBbVwkwARG
         36JAuUJ6E7C8TpJrE0PF6qw6rzv4nIEgaKTf5CRKnfTOt/R/NWGEUeMyIXq+n2uD+5uw
         3ZuimCpObAZazCzOgJGEtWISils2eQbzb6pLEeJ1UmvrlHpi2JnahJgAPILmJpXGOc4Y
         1tvKwIndN3ruKBo76wnLfCAn0PmS8bys2f2TUicSJhALksW7JT6TvEi9bscdcLTvHJEl
         rJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        fh=SMsNCfwWxyozmkjVVNd47iUNnjOjD4go5/THxkzfvPw=;
        b=iDJ2Fq3aT6cGbzJ3ISMWqdJ3Inj9MUEeLp5tz8Y7LC2JvfzfCIwIp3qpRnQmGhI1Fl
         1Cs/1lc8yMljjNCLVdgQzcfkwJ3dHHXrAzIOHc96ttB6B15tfur+wivtpQ/SM/yEtN6T
         p7/N8eVZHI9KX08bImd7591bSbM7Ew1z4oVPopk4oQcgRv3ssjH2QEFTFkPM6cxwM6bJ
         lcm78lwx7CtWFk1WniRpfdymc57J+1eFi8jcRTafLej8PYdea7zHwX8FOnT3RCppc8Kw
         UtkaNTZckNCLPlL+x5jJvVKRly7m8SmOXZCDvQ+5i2l2eAsG7f0FpqbgAqYFtxqgULEr
         CYbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780036490; x=1780641290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sjBZwiGe18mw6X67+Um2SWVYDlncy8HfxAJKV10muTE=;
        b=WMAMr6XbopQ8GCVeP4S1Pzc06cCh1zJ3FM/JTWgLSzxUUaoIJQYs8iAON+PZeCtAMU
         jLiXPZv/jcs8ydv38JNiCyfOaqjJuqn4OgaSyH02gUBVTQq5QLTiz3pQaJrxhRXnPpgP
         FkZEtYT9CVr4LTobrwmrXQnancCE/MEss8cPfTjSb09GoAlh1UM03HIFR8rlWxdT0qqi
         W1zzrgnYqpP6lSS+xMRM63MvRGpvQ9ty96696jn3YIlRq6dcszMmkW7YcXeF2MjRsOU5
         wU+kQ9hWK3upgkTCP3C9u+vKZ+bIS5H46jnDA8DTIqirrId5b90pzN+RQLCoTCGDKwLG
         +XwA==
X-Forwarded-Encrypted: i=1; AFNElJ/UQilx4g1QmbCH0NleKvO3B89y3DwusQXqMexniU8h/X26Ae9sdfYGGjZtlkHo4z8EKteET1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvEnTauYaK5CryRyyDnPqMHGcW+GcGHmaNlXQzPXIZyziRKVPS
	sK3mAf8Cied9EVE7Lfqt+nY8l5A3q9X57C+pTzLczfcZ9Q1DQcFyU5HuwMRGxsfQc9oAf9x56w3
	JwwMabp4sGM2v5S7fJrwrToUPRt0gf9lLOIOHQnQQxU5a3/QV67sFVt+gdOmFNQ3I9Mprvb9VRl
	8Rbq/4VVZOpqL9HY5bFas3MwjmoKqQLpA=
X-Gm-Gg: Acq92OGsqTEPDsNI00HjP3h+U56G4QUr0hGaR5GGtJNbG+AR88ctw2Io8TJW0X4Lokp
	TPIwTGL7N6rkeEYST0jzHZ7bSm/wzPs9dC2E8B84rA0famdqqi38RnDD32MSBVn0+Zb718c2utL
	Z4D/hUS7HjMZ+7yyyKrxsbsfGqtnQty7YsN8m9ys3jFMs00ERWrgI7dEUJmZbFAcIk/tFcXVmT/
	FJzeylAm3800FjJv7jBXgZewty3qyfvj6vHJ2uDM1WwA9IRec0=
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id 46e09a7af769-7e694dc2b7cmr1101943a34.17.1780036490379;
        Thu, 28 May 2026 23:34:50 -0700 (PDT)
X-Received: by 2002:a05:6830:8285:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7e694dc2b7cmr1101924a34.17.1780036489896; Thu, 28 May 2026
 23:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526144401.1485788-1-zhipingz@meta.com> <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
 <20260527121438.GJ2487554@ziepe.ca> <ff247643-73e7-44e2-b3d5-8ac0a8efb871@amd.com>
 <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com> <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
In-Reply-To: <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 28 May 2026 23:34:39 -0700
X-Gm-Features: AVHnY4LezOs9bV0UClJoUOHcNCdwbl4qfviQEKqNUnQx0j2Atcq5JV3HHpZqmfs
Message-ID: <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: T_o0JxA_Hup2eWwxGhkcM_gpwaj3BLIO
X-Authority-Analysis: v=2.4 cv=UYZhjqSN c=1 sm=1 tr=0 ts=6a19338b cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=zd2uoN0lAAAA:8 a=f7uq7ceqOUF8L-MFIRoA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA2MSBTYWx0ZWRfX9fnb6hbrbGRH
 XVS5hrGpE38IxeGhZaeUP0NYof3wzHKjaMe9lHnrjCWjBlT+0GjZy9m8q112mI7WH+AUC6ZaA3r
 LFdrOi1+xKji9Iz1mNXCqNvKBeRDkqZ8HyOF3ZVyyTYh2uDXtcLB0uaWXqPP6JPq7wz3Vfsm6js
 LGnrfxRoVpm1XsQSLaVTgxFFkf1CDRLmlvwrfiB4iHm0MbEBBaErudEBHWCutDSweqsAtQinGza
 VZFBj4eINV16P0C3maZyi8xX22Cq6vJYbfFxaGMqFHbs5fKqb2erFPzw/SSakvxFD7GlSkGDMF/
 L2x8wl9RXLGobfcrtL1649bPvFqIiYOEWkoKXpu7RayJXNPSoHwgKyxVGrPpnVymHcSMBjA7TFm
 pW/K/OUAgkC9NkjbFE3WZItHCq5x9lMxpCcTgnyj5rJuywaNDZD7sqo97GqQw57vu6hemmxUWLn
 ziokhe/lglGq0tQowPg==
X-Proofpoint-GUID: T_o0JxA_Hup2eWwxGhkcM_gpwaj3BLIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293002-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,mail.gmail.com:mid,meta.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 50A895FE0E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:46=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 5/28/26 06:55, Zhiping Zhang wrote:
> > On Wed, May 27, 2026 at 5:53=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >>>
> >> On 5/27/26 14:36, Jason Gunthorpe wrote:
> >>> On Wed, May 27, 2026 at 02:23:46PM +0200, Christian K=C3=B6nig wrote:
> >>>
> >>>> Yeah that's a good point, I should probably rephrase the question.
> >>>>
> >>>> I'm aware of how TPH works by adding the extra ST to the TLP.
> >>>>
> >>>> But my question is how is that useful to a PCIe endpoint? What is th=
e effect of the ST here?
> >>>
> >>> TBH I've never heard Meta explain what their device is doing with
> >>> it. At least it seems to be super important to their device..
> >>
> >> Yeah I think at least a brief description of what is going on here wou=
ld be necessary for the review.
> >>
> >> Otherwise we have only the info that the exporter wants to give an opa=
que ST for the importer to use and no technical description what that is go=
od for, how to test it etc...
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Jason
> >>
> >
> > Fair point =E2=80=94 I'll add a couple of paragraphs to the v6 cover le=
tter and the
> > patch's changelog as well.
> >
> > The short version: in this series the vfio-pci device is the completer
> > of the P2P
> > writes and mlx5 is the requester. As Jason noted, ST semantics on the c=
ompleter
> > are implementation-defined, so only the driver that owns the completer =
(here,
> > vfio-pci on behalf of its userspace owner) can hand out a meaningful ST=
; the
> > importer treats it as opaque and just places it on the TLP.
>
> Yeah but that is not really sufficient to justify a driver 2 driver inter=
face.
>
> Which PF driver is backing the vfio-pci and what effect does sending TLPs=
 with ST to it compared to TLPs without an ST?
>
> Regards,
> Christian.
>


There's no in-tree vendor PF driver =E2=80=94 the device is a Meta MTIA
accelerator managed entirely from userspace via VFIO passthrough.
That's why the ST has to flow through a uAPI: userspace owns the
device and its ST table, so it's the only entity that can publish a
meaningful value for a given dma-buf.

On the effect: the endpoint's PCIe ingress block uses the 8-bit ST as
an in-band instruction for the incoming P2P TLP =E2=80=94 selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework =E2=80=94 only the producer (userspace owner of the VFIO device) =
and
the consumer (endpoint block) need to interpret the value.

will include these words into v6's cover letter.

Thanks,
Zhiping

