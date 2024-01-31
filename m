Return-Path: <netdev+bounces-67708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ED1844A58
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E820F1F21300
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A941D39AFA;
	Wed, 31 Jan 2024 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8VESlxv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E539FC6
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737617; cv=none; b=sleLs/7q7GTMwlc7DqjKD+tF+yNjJbUF5uGuoSb1G1cII7Se9XD8RJK/jD7zQAnsv0w0qE/2cp+BpQB/tspHeU7fl9ccFpKa0cE7DkpB+35VGAuSGr74BBgGPIy5enbwLYNp8WjCaHD95CCq6lx8/obuPr2GoFr1rNj/MM3mLGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737617; c=relaxed/simple;
	bh=eFnmC1lbVYN4j4VfW6XU+vAA3X/Ct0usmb10imNRazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUdc62Y9zswyTKx6dtrjyzJ4j4wpw75th6+r1WRHySyfWZDwEarkaLFFwY5O0AaJZ7omRxm04J8ivxhHjhtZ/A22eAgofZhutwUQdo+a4kW7nsd3UFIZ+dmORY/aBG1IQ3/KFyYQzzc0cuVmKDzZAAmtLMkyaqTOm5MLySa0q90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8VESlxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706737615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xA0WL8OAWu59QlhnSKj+NZw09nFzDmIW6P1Gg1TTP9c=;
	b=E8VESlxvWmpYI8CWY1Qsc87rgAMKe42Gai7WDjtpktZ1NCluk8R3jNNKWlCyyljU55WcjO
	i86vpvDmCUdtrnjndZkYobsScS7lWOSSCfvnoDZPHwCpnapPfq5bp0WTJ9JotVlGpA3nv4
	kEgBYnkSsNoR/Nycot+FzI7qdz/Xg3U=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-POal1p0cMSudJkHhvF7CvQ-1; Wed, 31 Jan 2024 16:46:53 -0500
X-MC-Unique: POal1p0cMSudJkHhvF7CvQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2cf337d68baso2599801fa.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 13:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737612; x=1707342412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xA0WL8OAWu59QlhnSKj+NZw09nFzDmIW6P1Gg1TTP9c=;
        b=LW6RZUvGIb8Nd+EWjKKEj2t4pe1ueemyQYnlQ8kY1GfxNQW8ORJA/LVxnc1jYlkrJZ
         P7eWR3tVFDSfs4u19/07025j9z7oSi8eXM7vZhnvU2cKatu8B0Yp2LboWiaarZb3vqMu
         rRuGO5HK/gADzbZl1Ct+8D2ICCtiAuALUiUHG7EB1AfR+9rAzy8ldEYk7u+ByQU6MulQ
         pj9hAmbVSCVxklKjxJEWAfvwgkPuvcK5XjTAi8xjG4JU7w5YcavEfatrm4qbgTWyE4/3
         FW2WhJP1IMnZBikm7cnJ3MlCJIksDXhE6LE6SSM2e6sVvc/o1laFZD2i8PblDrSrhv9g
         3xWQ==
X-Gm-Message-State: AOJu0Yyjt7dyL8yZB5Ingd0UsK/65DblAHDr/XpLaZ28/ARJ8M2BJr9Z
	SG0ojBuHnYbw00FPmp4inD5na5pfggVrQbaCKMPWOvvRksiV0J1wYKTai7xNeX8qOoO+0UqxsFi
	nTmAyvWrxh0BHcE86VSV0YnEW/rlOsA2pnHCIeuDkC2zZabkiGg57MGN4yvIxvwLwsRrfKCwlZH
	jhUIIqMmfaNe2wg/0Iw8kW4f7EU0lj
X-Received: by 2002:a2e:9ec3:0:b0:2cf:1288:910 with SMTP id h3-20020a2e9ec3000000b002cf12880910mr1956865ljk.14.1706737611876;
        Wed, 31 Jan 2024 13:46:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE23fLdVgxCbf16DcIFLnyMiHBcJtbPkDANivp0IhWFO/5OXRw56/KeQCVp5xbX9m/eGo6azpw0AIqz+PJ+MPs=
X-Received: by 2002:a2e:9ec3:0:b0:2cf:1288:910 with SMTP id
 h3-20020a2e9ec3000000b002cf12880910mr1956854ljk.14.1706737611595; Wed, 31 Jan
 2024 13:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131191732.3247996-1-cleech@redhat.com> <20240131191732.3247996-3-cleech@redhat.com>
 <2024013125-unraveled-definite-7fc6@gregkh>
In-Reply-To: <2024013125-unraveled-definite-7fc6@gregkh>
From: Chris Leech <cleech@redhat.com>
Date: Wed, 31 Jan 2024 13:46:40 -0800
Message-ID: <CAPnfmX+ZXraFC1+2Lu+WdgdUud4ALEcFAcsRQotVjfsGFsqUvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>, 
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, 
	Mike Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	GR-QLogic-Storage-Upstream@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 31, 2024 at 11:17:32AM -0800, Chris Leech wrote:
> > Use the UIO_MEM_DMA_COHERENT type to properly handle mmap for
> > dma_alloc_coherent buffers.
> >
> > The cnic l2_ring and l2_buf mmaps have caused page refcount issues as
> > the dma_alloc_coherent no longer provide __GFP_COMP allocation as per
> > commit "dma-mapping: reject __GFP_COMP in dma_alloc_attrs".
> >
> > Fix this by having the uio device use dma_mmap_coherent.
> >
> > The bnx2 and bnx2x status block allocations are also dma_alloc_coherent=
,
> > and should use dma_mmap_coherent. They don't allocate multiple pages,
> > but this interface does not work correctly with an iommu enabled unless
> > dma_mmap_coherent is used.
> >
> > Fixes: bb73955c0b1d ("cnic: don't pass bogus GFP_ flags to dma_alloc_co=
herent")
>
> This is really the commit that broke things?  By adding this, are you
> expecting anyone to backport this change to older kernels?

That's certainly where things stopped working altogether, iommu issues
go back further.

- Chris


