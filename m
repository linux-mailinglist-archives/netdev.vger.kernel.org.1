Return-Path: <netdev+bounces-298398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NdpuNtQ/K2p75AMAu9opvQ
	(envelope-from <netdev+bounces-298398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBE675C27
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:08:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="S/OjtqUr";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298398-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298398-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08A6C31ADE1D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 23:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550A6388371;
	Thu, 11 Jun 2026 23:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A8380FFA
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:08:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219282; cv=fail; b=cBkCANUEgIno+9HAhyygR7m6BWbahGhHJ6gfKGqK6Ix9e934i3AAyPhaCquPZ/UmIHTTTmG9lKHWtAyWNRH9kilQCw3VoKrmGG5eMHA7gfOu3raq3Qzlse7Ol/ij5PZPja/Pbn3oJstcOovZmGlhEGgxyHIteJGwzjGZWRK93oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219282; c=relaxed/simple;
	bh=Xy3ScJnXdGO1uSMgz2W54lBdlaGYi8w2p6RzwRoDR08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWS9+Jm9SYg/ue1TT8qsz7Gb7d+YzvE0R6MGeQo3mzgY7klzG+Bsk78US5pmd7oKzM1IU/2gdShfqN7zVyjAG2bPCFbH0Fk631t+jt368xUW6kCXdhkm/9mB0deW9nx6YaHa7LtA1O3WvcimhzUBpkN0cEPdgZtO+vL93fpLimQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=S/OjtqUr; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BETiKt1447278
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=eSd4DfDWKCJhrlk+WFf1HJuCXJjV3yJV405FpCwAOa8=; b=S/OjtqUrfaHy
	U2tzFcZ8mycupW/bmzC0ry9dC6/TLZhsjYUOLx9kRDPB0KY54IyAWb3v/8NCzgIb
	Lo7j7/o2b10gCRzYHkStHM3+46rjVxu480Rw69rpMHhOshrelnhYeaEHIAZWHY2c
	45cn3iSQuWvr09tWHy11Rg98ilzmEcTlYqqh9Q7sHC11wTUiTKCHHmUjQuUuiz+2
	BUzCK5pTcOnMAmuXtXpOjrSB6KpO6VLwRJcO/kgZ1gLYJTGY+KSd+TwJCKLMpmK8
	S3GzefST7H4aOVX962Ewe73xPQFn9Ny/oy+d2hIXiJkNWwIp7UrGbCvYz36QF7sN
	eBQXf3TFYQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eqe78her5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e6dcca848bso702924a34.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781219279; cv=none;
        d=google.com; s=arc-20240605;
        b=DGIiy58Kjasa5tCsQ2zUJtC2LTAo5v/0RM+hzwIz1aKvc+EqcZmVUbkOaZfogXAbJp
         MawOUSsMi1njpKPlONsSA9V7RrhpSZGXXmCpVr4lY/BGln9Ukc6pKPXEVSXXRwcYrC1O
         5c2i5mWl0X7S+dYF0BmszNkELyowkoiiM7PlbL9sIoLmXlEFfVvnmXOtC9JW0yLhKDga
         an2QgS5sJ0bFMYrZ95msgAXgp7aBF7UHF7GbyUfzGiSg7NTNm0ynb8tbuK6u5aU0930b
         Z7UQ+MeanDVVhzZSu3c3LgO6atLq7E1OuvGh+UpGzd/Brj2LEy5DxWoNYK6CCDunCrhu
         2VSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
        fh=EetbHamIKmNRUEWxnxrsknQ6zmc+QjsvssT9V7Pqwkk=;
        b=QI0uwdWoRaO6erhLAWICvXypBSoRQi1SxRsnHjsOuJKEPtOZ7bea3FZtb3vLxAcPi2
         YtOxY876A1gr8U1FWOLvBx3ESpWRmTaUAV8+xGYc/ZLVbz3uUoupDx/8+t5uEIPsFO7k
         0fF+WAYp+HDibmfzhKAFvWDEhQ01irQc4BqFanE/LR8CNdlu0UI/DNXGZcAsrfSRw5qv
         6QkF6rWl7c1leaEw2TtXPBbUfe4JTGU7b8wwXEqNYcnj5ngXk5wuE/G6nemYz8xEcLVJ
         P2A4t+vvtVyPs+qisLwtbairknZ6G5H2KLD1+j+X9Qpl2kd09oIdyepBPK/C7hbFgrLN
         7jAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781219279; x=1781824079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKBgDS5EhOCeCGVgkUxAvmWq6B4D8KMNSa2GuVyeKb0=;
        b=jVDLdoEU/1V3lLdh3pGhIKBxGtkDrdf7DattHuAt99tRu8zu+KfYzaNqAd28NdPoZU
         UpP0VI/CAorbCEl/BbSEoRYBZQ8K8LMrGfhJP6RpnJezGMM+FCCTWDdHrjLMYMr+iao7
         GsR/glosjuI5xjUT4Sby9gckAJfr0g0tUPHhXlFUqcHqp3sfJUurbGtmPgPVWyBe3pGp
         ryj4eA5k3x5eh+j7lHWTZOKqIRkiuyoZ1VnbG868VZdXt7EgesOHC50331MuP5YzZMMP
         /v8tWIq3OoCb3/zNz/0t/S42m5DY7NRuf5WsH0qg85csgLvJl8cADxPT4xfvViRf5gT3
         jFzg==
X-Forwarded-Encrypted: i=1; AFNElJ81vtGQcLR0vNtG7zfHMDUNqpMSzje3b1ntICMV/weUA1nOzQYt3xAl8FMp9mPrQoybASB9dFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1gAPybqGlVTmrzHa9I4VSz7W6+iEIKxQjVT8zA9jUThiFTJS
	pZwEuejl/+XE1qe4VzUSNfyxyN5rFjmEQgBGILr3tkfW6GMEjpUtAFhKyVqaiTKsuDvR6sa/Z8i
	t/m2PD89VBLGsIyP7qMklbyC1ufxETk9AEteROvGPOaMuovU7JIfBakt9/pIYCsNIM04ozTUfjE
	Ooy7TL+BNfpwp1HbdpePRy9oyQMayljx0=
X-Gm-Gg: Acq92OG78peUtoS6jUZdwEtmL8iM0Vmx5AhdEC9x+eYfIx9CWIh609IFdL1yeBpurRM
	+6IxpB0U+4PWahwnESR0uvTfWZObSAr46W/+HeD0rTFkKiBW8nQxQJbgUol0zoYiJiokXpZQLW1
	8bfgw2NoiDUOo8InRRqS2aM1DJ4mUPiJYdRNc7F63gQX/C+dubO9hNZnDJhxdITwPhCkrM4lD2U
	uB9p+PFV8mJak/L/fOfWw==
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id 46e09a7af769-7e7848a9e26mr96710a34.24.1781219279121;
        Thu, 11 Jun 2026 16:07:59 -0700 (PDT)
X-Received: by 2002:a05:6830:6810:b0:7db:b7ae:ef0b with SMTP id
 46e09a7af769-7e7848a9e26mr96676a34.24.1781219278679; Thu, 11 Jun 2026
 16:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610193158.2614209-1-zhipingz@meta.com> <20260610193158.2614209-4-zhipingz@meta.com>
 <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
In-Reply-To: <98b65e1f-1b5f-47fc-a4fb-0cdfab6725ed@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Thu, 11 Jun 2026 16:07:47 -0700
X-Gm-Features: AVVi8CfN6ELCKVsJhBpTTQfWRh3GrCVI0SUXGM4wH5Fa1maXhiidrAdOyWsdUPU
Message-ID: <CAH3zFs1=CKtS524vU6f2inbX05JcyMi-5FouDxSCZAjNG0OUmQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] dma-buf: add optional get_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: oiKP5fgDiyYULHZ60kLBm7Pixi3h3WNZ
X-Proofpoint-GUID: oiKP5fgDiyYULHZ60kLBm7Pixi3h3WNZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX5i3LSvvLYFwB
 iHcQvJoCM4p+7h6p/OBOHTrydW+rxotSrrbl8AKFGVjixltFvnNj6Bc/bkh6Vk8GkL6JgULD5wz
 8ll7MmW9UQvi7dzD6+V8QeuAQ8XfDKRRChDg7gzX1qHEZbxaHsn6kuKdqSny1fbLhOLo4wXZbok
 BZ3SvLtXLlEaxX/Tjf519uvM88+lJJi08cltgjlmZ8/NehaVTZkw9Zl5v3+i5qUIoj7SpORC85W
 6ia/Fv/pO5BxsqVOJRLBiW2MMq23ktMp9dR+j6xHsbIr9mRtCw97wLERxyiTATMef6VGUkSbBJ3
 HtPGUdGciIvVCpRjqh2ojKBGnR8LIG/DVnySRIJW5tlSvOxJnkk7rKEqODWbqnavBYVYybHF93p
 P5fw0IZvNj6SCq+xfanJXbA8W0ZOCSCpA479vzZOGR1L+dQgaV5ZvftYj/eZK16Of/UrDV7Z7+V
 MSKQbBk4PNeSvN7MdTw==
X-Authority-Analysis: v=2.4 cv=L98theT8 c=1 sm=1 tr=0 ts=6a2b3fcf cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=zd2uoN0lAAAA:8 a=VabnemYjAAAA:8 a=Zb6pUuT0p51Zl8jFNtYA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDIzMSBTYWx0ZWRfX6lSgAsNUCF8h
 Xfhz9iS/wOqBQ3o+8mfquMZC9HnQEEgtBCw+rwhO3urdJVjhmZjn5oceUO/l6yOD5aMQPo10RCH
 CPgV8DDusYjRdk9bTQ/U3z3C9+RTib8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_05,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-298398-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:dkim,meta.com:email,meta.com:from_mime,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5CFBE675C27

On Thu, Jun 11, 2026 at 3:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> >
> On 6/10/26 21:31, Zhiping Zhang wrote:
> > Add an optional dma_buf_ops.get_tph callback and a dma_buf_get_tph()
> > wrapper for importers.
> >
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces, so
> > the importer requests the namespace it can emit and the exporter
> > returns the matching ST/PH tuple or -EOPNOTSUPP.
> >
> > dma_buf_get_tph() is the importer entry point. It returns -EOPNOTSUPP
> > when the exporter lacks the callback and requires dmabuf->resv to be
> > held while the callback runs.
> >
> > The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
> > mlx5 as the first importer.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 21 +++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..aff79ea12e43 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_tph - Retrieve TPH metadata from an exporter
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
> > + */
> > +int dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> > +                 u16 *steering_tag, u8 *ph)
>
> That name needs improvement, maybe something like dma_buf_get_pci_tph().
>
> It also needs some brief explanation what TPH is, maybe a reference to th=
e PCIe spec name etc...
>
> And document in the list of functions that this one should be called with=
 the lock held.
>
> > +{
> > +     dma_resv_assert_held(dmabuf->resv);
> > +
> > +     if (!dmabuf->ops->get_tph)
> > +             return -EOPNOTSUPP;
> > +
> > +     return dmabuf->ops->get_tph(dmabuf, extended, steering_tag, ph);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(dma_buf_get_tph, "DMA_BUF");
> > +
> >  /**
> >   * dma_buf_map_attachment - Returns the scatterlist table of the attac=
hment;
> >   * mapped into _device_ address space. Is a wrapper for map_dma_buf() =
of the
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..6a54e0f251a2 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,25 @@ struct dma_buf_ops {
> >        */
> >       void (*unpin)(struct dma_buf_attachment *attach);
> >
> > +     /**
> > +      * @get_tph:
> > +      * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +      * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > +      * @steering_tag: Returns the raw TPH steering tag for the reques=
ted
> > +      *                namespace
> > +      * @ph: Returns the TPH processing hint (2-bit value)
> > +      *
> > +      * Return TPH metadata for the namespace selected by @extended. R=
eturn
> > +      * 0 on success, or -EOPNOTSUPP if no metadata is available.
> > +      *
> > +      * This callback is optional. Importers must not call it directly;
> > +      * the dma_buf_get_tph() wrapper is the only entry point and hand=
les
> > +      * the NULL-callback case. The callback is invoked with
> > +      * &dma_buf.resv held.
>
> That most of that should be obvious, we only need that it's optional and =
that the lock should be held. Everything else can be dropped.
>
> And most of the description/documentation should be on the wrapper functi=
on, exporters who implement the callback should know what they are doing.
>
> Regards,
> Christian.
>

sure will do

Thanks,
Zhiping

