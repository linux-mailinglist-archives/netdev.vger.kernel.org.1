Return-Path: <netdev+bounces-67706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB50B844A4F
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D328EAC2
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA70539AE3;
	Wed, 31 Jan 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QziQRMJ8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511E38F91
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737507; cv=none; b=GlvT6PhMTNt9m9eDke242Zn04eM9dOK5tyWXq/mFspycjU705Q8o4raozfkmgor/TEeZ1xa9UvdrPqUv3JE9hrJH1pflTgMtqNVPBY779/gq+AoBFdj1H+x8JA11WrtYV66rThRi/2vFjSjb2/WfIo61c1w9p0P5eDDdN5niI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737507; c=relaxed/simple;
	bh=RNO5W0OP+zOfgTSimLFGWc0A4ecEarSa4TiMbXZZvIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yd99Ay2KAOZ0nV/1konYFk3Oo7isfKwL/+CmIvjicCsYDEq9WZeeur+FPEr2M9RizGLcXE8AGcS4oYOkkWb9cSs/JxC2BGp8C0eUrY7r9U4aB4dOzm7F85YLtCpaqcid1JLFZVmRTmozG7qZ+eD/9wgpn1BAazTGa8NjkV6Lwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QziQRMJ8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706737505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dbCchYRiPga9CCVNutbEbzEx6jSnpAXwCYBNUJ7928=;
	b=QziQRMJ8dVtrvl3zVIRR/kGyE6q+eXyKEN/DcM//WOMlUPDJPpjCL/j8KqTbp0S/ufReFk
	HEvETfaQW1wWi8mUXLqpHhzSb9gZ2ghtTlWIT1Z7NG4XJHLUjxHE5yiDYLvG67DlSPBAeA
	RWxcbvlgye+YWPhljF6YxTtM2wffTdM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-8X-rpn7PMdeo3-95bbQ8iQ-1; Wed, 31 Jan 2024 16:45:03 -0500
X-MC-Unique: 8X-rpn7PMdeo3-95bbQ8iQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2cf3397b68bso2484341fa.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737501; x=1707342301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dbCchYRiPga9CCVNutbEbzEx6jSnpAXwCYBNUJ7928=;
        b=ihdfRVZ1GfRlcq9Fl7Lm6LlvcwfMFPGJeIzjtT9arvVDNfs0DYy8gTddTfrYloInav
         HMTMw7vH80G1wq7tLlySzfwLWvmargcIdOerIhNFihBRwU0oklIBp6O7M6gLPNYvqSFk
         969UkXGKGuyA8wLBwG22DGqnsG+siThbgDlZhmteIRr/hwlJOoW9lQvbuzyW7rIN2kjJ
         nule7PdDm4DQTnM4GfoKfhJ6cVjxzzbs0C8M3UZKiifguqU8tnCLZZhQW06EpFiVkkxw
         7Wy4A4OCdtWP/k9OoQHVkSmJk5TbhlveKm6wbU9mq1tBQcTgZf1q7MhP7I4EZ+kRGBBz
         tNcg==
X-Gm-Message-State: AOJu0Yw4Bmh23AhpD0kH5cSxKNyLPRPCQ3SXVxkOn42Ji4xrcv5RgtAD
	n5WW9sOO9bToRxda+uaJFc3Shw+r7e1jMcbne5F30YIyPgRCAaV7mstnooEk1Gz0XhNbGOLGjkC
	FdP7z3E1CTYpeUPEqEsXSvWGOfrLN+iG0NllKIRbSCkzm+gDlMSys6nsL8GW3/dRt10NgfkTmYb
	M3TbeiSH183oqup25jfL1RrSEEqFSo
X-Received: by 2002:a2e:8553:0:b0:2cf:3324:cedd with SMTP id u19-20020a2e8553000000b002cf3324ceddmr2282117ljj.24.1706737501760;
        Wed, 31 Jan 2024 13:45:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4WSR9c2pT9GcR96S25SGMyV9IZm76XurE8FEjz5Uxf6I4GCo5Gdvvm8H5SrOpe9xqbYz5TXh0mtvDtkpATcA=
X-Received: by 2002:a2e:8553:0:b0:2cf:3324:cedd with SMTP id
 u19-20020a2e8553000000b002cf3324ceddmr2282099ljj.24.1706737501453; Wed, 31
 Jan 2024 13:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131191732.3247996-1-cleech@redhat.com> <20240131191732.3247996-2-cleech@redhat.com>
 <2024013110-greasily-juvenile-73fc@gregkh>
In-Reply-To: <2024013110-greasily-juvenile-73fc@gregkh>
From: Chris Leech <cleech@redhat.com>
Date: Wed, 31 Jan 2024 13:44:50 -0800
Message-ID: <CAPnfmX+c_TECfVgbAgphFgkCOr-=tKEvHmcxPg_vSY-qJRqaQQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>, 
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, 
	Mike Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	GR-QLogic-Storage-Upstream@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:29=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 31, 2024 at 11:17:31AM -0800, Chris Leech wrote:
> > Add a UIO memtype specifically for sharing dma_alloc_coherent
> > memory with userspace, backed by dma_mmap_coherent.
> >
> > This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although ther=
e
> > are a few other uio drivers which map dma_alloc_coherent memory and
> > could be converted to use dma_mmap_coherent as well.
>
> What other drivers could use this?  Patches doing the conversion would
> be welcome, otherwise, again, I am very loath to take this
> one-off-change for just a single driver that shouldn't be doing this in
> the first place :)

uio_pruss and uio_dmem_genirq both appear to mmap dma_alloc_coherent
memory as UIO_MEM_PHYS.  It might not be an issue on that platforms
where those are used, but I'd be happy to include untested patches to
convert them for better adherence to the DMA APIs.

(sorry for the double send on this Greg, missed the reply-all)

- Chris


