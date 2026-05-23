Return-Path: <netdev+bounces-290994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPddIB39EGoUgQYAu9opvQ
	(envelope-from <netdev+bounces-290994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0123F5BC3F6
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37114300F9C6
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1461A6827;
	Sat, 23 May 2026 01:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fT1NcaLS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D56141C71
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779498253; cv=fail; b=DVCL3fE6v1Rwi2KRgRJJsnI5ZT+XY0VprPVNrvhdx6xnjQnCKgjJn7JtzXwkGv+78OYRoeAeTg/eTja+QZC4IIUPGyIp+X57y5gwU+FzIUbiA9TmKjKYVzpfLC2a8vIjyFPFHa+KhubeJSDKgAKhAEtRc1Y1uLLEiQjzuq7GxSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779498253; c=relaxed/simple;
	bh=/A4hX39HcRR7SH4Q02RYznjGYalKTiQUMXi+zCxotsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmz9YtFZxSELKc7WgLt8sgNMWdrwxaRfvBUvGJclEScdhYp1vC/4MvwFp8pW6jLveKhSWTmtabQr+4x/J5nvkhvbSP4rh2G7rTJUZKacj9ghL5dV8lm25HeLVzviC2VsGx5WEjpnDhePLeQJfxw/Q1Md66fwJTHS5PriGbPxS34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fT1NcaLS; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8Mfij842497
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ZSYPnXqPgD1WmWUsBlypXTMK46Ru/H45VtdzBiXsUQo=; b=fT1NcaLS0als
	V0CzITn5MusJzO7wCLcepvtcBFTpq0bJwdQSvOVtuXxphbNRdr5w4GkHaTzTSf3+
	1R03uZUVNbYR09SXtNfze33jf0vl16nQtWNHx7IejIEpQwTNM6Zdr4URIJIP4IUZ
	/MxPR0PRQGLKj5okI7T8m28gwIvEkhfg4k5DlHcYM4LKRk6uMqHrbOKc8yy5HHtZ
	5eqDNEm/6fylQhFYaVIcSOMFDFs1Klh81XfuQ3MBoRuhLL4csUmWciCvrsH6JK3j
	sIxVPa7SHf06LM2veBJyy78S1WcvHjVGrhiGukFXNTCVAfsoQEefzYCSC/aL5enj
	hOGP41Rqtg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ea3yqjp9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-479d74f0d95so12877034b6e.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 18:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779498249; cv=none;
        d=google.com; s=arc-20240605;
        b=dhgMBi+Xb7qTGLHfj8BaYjTVuicPq4KlAK9GSTmmEwJnOG5Eu4vX5A4jL899EzEpCw
         OELg6KruYZC5kTwBbewbej82OOuA1x0Cmf+UhiUkbwO726v5OjIpreEPAG12oDRJl44/
         Bs69NGfX5JvDVBRT7EnlZ+Asnhqre/TrAlX8SM8VVnoPGzGGJaKCOQBrBwtob2YkMUm9
         XB/7jcxqSKbi+pFX1lubOFvfKtNOLyAi7KNC2tu5ErRwLx3EmNDe3Ss3QyApgRWFpSGB
         vfHUsaZd6BbI0ZrZV2KWXqCT3eStn5lGbp2Wrg1pwizVQtGQKgUUQcAfOKVjfOVrKepT
         t0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        fh=QqwCMKzuNjjxD3Dw0xkKHcoFvibUvoxkjKWwpZmn4lo=;
        b=lYlIw9aon6NtPjnGrrX0WE/CiJThUYlxvciLVo/jxpkltBkf6DtVdHO0N+ctf25AAB
         Tv0blwnC1u/EcnqmeZibk+dWnPbdBQuW8o40Ak2kqh9qupczT+NdAADN4tQg/ExCbFWg
         TPaAl196OYmRaBZ0f1oc0DT9C7Nti8ibJQcehDE9dq4hs+xAgeel6tR13YvuCM7VqXre
         OKVgIYucjqfjSTRiLBrfhxF9td/hn0GcRU7FELZuuP5ItfHShGLbz/N5csISlQNRmSy+
         bjPIMU4gKGqLU2AyyyPuy1FEN2CrYlfID77DJQ2nFg3VFcgjdKJTXHh7QWApuY5//pyf
         ORJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779498249; x=1780103049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckSywFlrQVuSq3t4EfSWLfDKEF0bsmOAyDZjQDxER6Y=;
        b=sBybflvf+8mJFiwINmGt5CPoALurWdwmVPD7I+agG7uenXPAwdB0WLMHRLzQLPW6kF
         HXcE9uiHTMcOoor4KcWlAi4qVez96BlhmxVsvn9cB7VAz6qHSS5Bk2Jkye3TsgaSGgT3
         BauISCxQIl5GmkEI6K/9eekcI9fQe/JPKRSUIOKX0zQV9JMfn9VV2q3KxB+VUPDXFIkw
         MAP2Opvmjw+c8fKPF9o1JiUxlsUTM6c0OEx07GQ9VtAh8LxBC0UBbNIVO6WszSeuW5iw
         lOQYan9MRUIxxLmreBxNchHRMUlJ2md2OMeEQ43JYyym3K5bD55lLwBxsSORnC5ea6m+
         PByQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LojKgq5tHumwghgaPUZnxt/tyl4zFgRn8vbrFiownTLJuoj8geLzQR6KodFKkVFqRKvzGF94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtjgU46SxHPex4DTguCR+wKhw95Q1YjqFaNidNhbvt8k3j+I6u
	GQwZpakHQVQUJrTg/6zhdCjLPRATbZjT+0TiDlP3nvA7bL/iI3pFy9NnURQrbwjqJQEGvpr8674
	4Gw6oy6HiO/WL4q0VFUNMHAIUgC5pwiJnWBXCUdJjYvbHlF29dFWMuP53hkseO0Noa/8Z5x97Sj
	9BQQF8JUttLrLIS3zQRhEOboiAM/3UVFI=
X-Gm-Gg: Acq92OGg+q7G5wGOSyjPctzP3ZQKZNPefsCdvxhNsPYRlOvzYDdiVTfL/E0c/9oIlBD
	l7zgncGukl66mhL5wOqQGeRCk/9LfuOv5Hl4qaRKhH/XJs5mpK83Pi1KJ8hS0j/VZGFvC8AIDo4
	3ltxj2t5vVIwnqqi9B9anHoONE+9omPNKo+4gGGoOJ6/s0tKVDbwLDE8jZib3Xe0M149nhB6xzJ
	lsi
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id 5614622812f47-48549902f22mr3459520b6e.0.1779498249484;
        Fri, 22 May 2026 18:04:09 -0700 (PDT)
X-Received: by 2002:a05:6808:f0c:b0:479:de32:b310 with SMTP id
 5614622812f47-48549902f22mr3459507b6e.0.1779498248992; Fri, 22 May 2026
 18:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519201401.1558410-1-zhipingz@meta.com> <20260519201401.1558410-2-zhipingz@meta.com>
 <20260521160412.4fa75406@shazbot.org> <20260521162437.406085db@shazbot.org>
In-Reply-To: <20260521162437.406085db@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 22 May 2026 18:03:57 -0700
X-Gm-Features: AVHnY4InmgAbt-a7ZIoyl3OFAhk-P34lQOEjx6K7zj7MuEim3oYM-YaMDsRZ4E8
Message-ID: <CAH3zFs1gh6UZewMf9GJ6CtO5v0yWNokp-eZQ8G2QnyAyxD7-wQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: -6tqGeMTh9Aw4BZTBMQYqcqet6z1W-19
X-Proofpoint-ORIG-GUID: -6tqGeMTh9Aw4BZTBMQYqcqet6z1W-19
X-Authority-Analysis: v=2.4 cv=NuHhtcdJ c=1 sm=1 tr=0 ts=6a10fd0a cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=LZULGAC3ikq4sroI4wUA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=r_pkcD-q9-ctt7trBg_g:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAwNyBTYWx0ZWRfX2buoY8BjAsnB
 3SY4FfRiMllAwLgjdUzgdUF5VPg2uwykOmEgX6/lxXUq7uwXbTyoIEAGrFoUW8L0DQkyr8STw+T
 6hp0RGsVCHsAU5QD5OPjADrC0Q7bUtWlDDbdJNCgHBKgxu/DgxqV0HSqT+jL51GaColKTs0G2Qc
 Y/LEz6EZ5MctfKYVPipijI2e4cNA0tL8Y5/ATO+qRNd0kOwYsU+usFy/JrpY/w2bu3yPmLYlL8P
 JH1AFr/CcfXpoKOKc7JivrGFtL1QP8ghmkWqPulTiH77Vb3R1q+Iog8bnSDVscXXCPUGz+cT9ba
 tnUSLyr7Hig5P1lCKpUW4B8i2JNHiei4kH3XAEdgxes5ewfsOED6jkcw6dCV9qvHEazElbxgQZP
 pA/eYBNQ4LvXym8iGUQMCFARIfl8A0N8xb7E2ByzDjQoMT2zVUg4or0TOL99OeHNCDWRaCjY6Sd
 I1m/TmmRWIUNx4zt5cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290994-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shazbot.org:email,mail.gmail.com:mid,meta.com:email,meta.com:dkim]
X-Rspamd-Queue-Id: 0123F5BC3F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 3:24=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 21 May 2026 16:04:12 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>
> > On Tue, 19 May 2026 13:13:49 -0700
> > Zhiping Zhang <zhipingz@meta.com> wrote:
> >
> > > Add a dma-buf get_tph callback for exporters to return TPH
> > > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_=
TPH
> > > so userspace can attach that metadata to a VFIO-exported dma-buf.
> >
> > This should be two patches, the first extending the dma-buf framework
> > for the get_tph callback for explicit approval from dma-buf maintainers
> > (who are not even copied here).  The second the vfio-pci implementation
> > of get_tph.
> >
> > > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > > uAPI carries both with explicit validity flags so importers get the
> > > value matching their requested width. SET is write-once per dma-buf;
> > > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.
> >
> > I didn't see what motivated this write-once change, I thought we
> > understood that it was a userspace problem that the tph values need to
> > be set before providing the dma-buf fd to the importer and that races
> > relative to that are a userspace ordering problem.  Write-once seems
> > unnecessarily restrictive and there's no justification provided here.
> >
> > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++=
--
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> > >  include/linux/dma-buf.h            |  21 +++++
> > >  include/uapi/linux/vfio.h          |  35 ++++++++
> > >  5 files changed, 198 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
> > > index 3f8d093aacf8..94aa6dd95701 100644
> > > --- a/drivers/vfio/pci/vfio_pci_core.c
> > > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_dev=
ice *device, u32 flags,
> > >             return vfio_pci_core_feature_token(vdev, flags, arg, args=
z);
> > >     case VFIO_DEVICE_FEATURE_DMA_BUF:
> > >             return vfio_pci_core_feature_dma_buf(vdev, flags, arg, ar=
gsz);
> > > +   case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > > +           return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > > +                                                    argsz);
> > >     default:
> > >             return -ENOTTY;
> > >     }
> > > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vf=
io_pci_dmabuf.c
> > > index f87fd32e4a01..be1c65385670 100644
> > > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> > >     u32 nr_ranges;
> > >     struct kref kref;
> > >     struct completion comp;
> > > -   u8 revoked : 1;
> > > +   /*
> > > +    * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > > +    * consumed by the @get_tph dma-buf callback.
> > > +    *
> > > +    * @tph_flags is the publish/consume gate: writers populate
> > > +    * @steering_tag, @steering_tag_ext and @ph first, then store
> > > +    * @tph_flags with smp_store_release(); readers do
> > > +    * smp_load_acquire(&tph_flags) before accessing the value fields.
> > > +    * @tph_flags =3D=3D 0 means "TPH not set". Writers publish a non=
-zero
> > > +    * value only once per dma-buf and serialize via vdev->memory_loc=
k;
> > > +    * readers stay lockless to avoid AB-BA against the dma_resv_lock=
 held
> > > +    * by importers.
> > > +    */
> >
> > Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> > memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> > held when calling .get_tph().  There's a lot of lockless complication
> > here balanced on this claim of avoiding a hazard that doesn't appear
> > present.
> >
> > > +   u32 tph_flags;
> > > +   u16 steering_tag_ext;
> > > +   u8 steering_tag;
> > > +   u8 ph;
> > > +   bool revoked;
> >
> > If we still used memory_lock for tph, these could be:
> >
> >       u8 tph_st_valid:1; /* memory_lock */
> >       u8 tph_st_ext_valid:1; /* memory_lock */
> >       u8 tph_ph:2; /* memory_lock */
> >       u8 tph_st;
> >       u16 tph_st_ext;
> >       u8 revoked:1; /* dma_resv_lock */
> >
> > The existing change of @revoked from bitfield to bool has no rationale
> > noted for it in the commit log.
>
> On second thought, what dependency does anything here have on
> memory_lock?  I think we're jumping through hoops to avoid a lock we
> don't even need.  If we just want to serialize SET vs get_tph we could
> have a mutex on the dma-buf structure, or use RCU if we want to manage
> it locklessly and make sure get_tph always sees a fully consistent set
> of values.  Thanks,
>
> Alex

Agreed, we don't need memory_lock in this path. For v5 I'll instead add a
struct mutex lock to struct vfio_pci_dma_buf and take it in SET,
get_tph,
and around the priv->vdev =3D NULL store in cleanup.

Thanks,
Zhiping

