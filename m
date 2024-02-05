Return-Path: <netdev+bounces-69237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E6084A782
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0811C272F5
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 21:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD3584A4D;
	Mon,  5 Feb 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvKsOton"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993BB83CDA
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162802; cv=none; b=FqIXf6D7RzHj7dUnCL3XVB1q75MyZYMbeONadX3O8cDVhSkUEGjjIB78jtHtZYIDVJrGKN8BuJj7hPWniwbM0R1zjz53zd8TSD9Of7cycYkYs0bOqO4Gh4vNp9DrfoBuBcvo1fCYcJl2fbFpGsPDhcBDhmDyGc+r+VCbjgtYf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162802; c=relaxed/simple;
	bh=u/VKs/3EPpWVrRldc29EujFjC9yGn/bWji2MkiRM3Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ey3GrpPYuCEHbvz+0n65wVnFkSpwcUufuuw0Hwvu6CnuW/i1dsnoi5xR6QoB/xv23PQK0VWuyaCR1B1TIzFVrIUjgFgf6DnrkkJndiWaDyNkehHjsohWsYdQtu2hVCdyMj65h+d01lhzN7iEwYRwwi7EtXoauZOO1CikBOwR4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvKsOton; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707162799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VNtm/2qBOdXruRpXqj+cGjGSujDgnFJiILWoI+l5br8=;
	b=UvKsOtonnh+GKD+vA1On3TP0Q0sCCvjeJvD1fLMJSulnhinphBjWzoSd6VNTLgyegft9Tf
	vuCHZmi+bJXAOWmsVsEgrfDqDbl17LK2LIJr/PTWOdEUjV9s8IN/kFIYLXgJmpjGrFjUKm
	15gPqtrW1ygWwoTgEKmpr7ofIIWqn+c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-CxRN5HyxPny_tbrKO0hGEg-1; Mon,
 05 Feb 2024 14:53:14 -0500
X-MC-Unique: CxRN5HyxPny_tbrKO0hGEg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 940E21C04338;
	Mon,  5 Feb 2024 19:53:13 +0000 (UTC)
Received: from rhel-developer-toolbox-latest (unknown [10.2.16.180])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 639DA1C060AF;
	Mon,  5 Feb 2024 19:53:12 +0000 (UTC)
Date: Mon, 5 Feb 2024 11:53:10 -0800
From: Chris Leech <cleech@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v5 4/4] uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion
Message-ID: <ZcE8phru3Nkp2J0s@rhel-developer-toolbox-latest>
References: <20240201233400.3394996-1-cleech@redhat.com>
 <20240201233400.3394996-5-cleech@redhat.com>
 <20240204101903.GA916983@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204101903.GA916983@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Sun, Feb 04, 2024 at 10:19:03AM +0000, Simon Horman wrote:
> On Thu, Feb 01, 2024 at 03:34:00PM -0800, Chris Leech wrote:
...
> > @@ -264,7 +257,8 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
> >  					" dynamic and fixed memory regions.\n");
> >  			break;
> >  		}
> > -		uiomem->memtype = UIO_MEM_PHYS;
> > +		uiomem->memtype = UIO_MEM_DMA_COHERENT;
> > +		uiomem->dma_device = &pdev->dev,
> 
> Hi Chris,
> 
> a nit from my side.
> 
> Probably the ',' would be better written as a ';' here.
> I don't think this is a bug, but using comma like this is
> somewhat unexpected and confusing.
> 
> Flagged by clang-17 with -Wcomma

That's an embarrassing typo to slip through.
I'll fix this,and add the kdoc comments for the API additions.

Thanks,
- Chris


