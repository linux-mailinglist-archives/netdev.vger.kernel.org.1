Return-Path: <netdev+bounces-255170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHdDOl/LfGnaOgIAu9opvQ
	(envelope-from <netdev+bounces-255170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:16:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B41BBF1C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C9B9300879A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 15:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865E8346A0F;
	Fri, 30 Jan 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o3p/t+Oz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303CF3542CC
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786203; cv=none; b=IdNZUTYyuRWoVqctyALI8G00QGB/80f8fq1psFKI08vZXwtw1ZchLTg+pcXwXvAxio8VwBq1zNnhqqjd27yKI+RGUP9g+yyylwzts3X6kNMJPq8QVEHqeGw7x7ASUjig47iqot1Yy5Mk7ZcZo8YuJyqJ5g1D4BrWIthh20Al81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786203; c=relaxed/simple;
	bh=WmHtBHSTYxbfJ263YgNe7PXPFBdQFrEByiiVtkOz+uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFDPXLxgoVf4knPfdC2bHGDfHkKyi4ueNjKspyCXUbwPc/cA+otnJg8dEryMfmO0wo5YTvKY9CgBo+InSfKZJ7avk9895qiAtOvZs6j0Qy/7Uo6oY24v7tSrUn3hH+MvLYjAPvGFfq75Rqin4nujeBBH5HnBPtGhuRXMqYSebYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=o3p/t+Oz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8948273f5d0so32543526d6.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 07:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769786199; x=1770390999; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9si664lpAABtSRH5NCDTNiWW5Zo1E2FOdd2kZn8cRsw=;
        b=o3p/t+OzNolmstthDKxfQ2xaDr4SG5Cd5MhbMtCpLSmb1pSCcPW8jaVlip9X438OsU
         pvqcK+zIuEQTlyP6cyjSPpPISnUcNH8HBRF8XscGM0zgrtsq9YMvJCbOascyJ6SYle3K
         5+lplx4rOZBELiGFXi7Z029vg2gzMC0aiSCWP/xkR9Zj42Ur8ylSVCaRV6w/kOkYPsRI
         NCWMbQlXq7eyk4aNHKTwPQQYIk6ntQG++EF1z3KRTnDa5JBk2tRP7dJov/Sgzp0Jnu5a
         SVuV3RCSgr6Qe2RLxTELd34T9s4IMJbMo5I1OeLdPPTA68gyCEv8RiFwF6w3hkirjZTv
         /fhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769786199; x=1770390999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9si664lpAABtSRH5NCDTNiWW5Zo1E2FOdd2kZn8cRsw=;
        b=J64slVc0jBvKNuzHr0a2SIlqtm3K0sdKOqZbxgT1CfPhUC8kXgLJxapO9PtvY0uPYr
         icnqHo81Pnx2iRUJChf76qE/jY/K0Y4MOhnr6LvDxdn8peK6RCd4Rsq1KMlas2n1qrd2
         tSEdRypEjVdeitnOXB1l33P3Q2GFM9hJWGkcPF8B+7T+twmuvRmG5PgV5BV+kgs6WqGv
         9vsXgsXJaxSPuoYuZAzNK60xWr2TfhZcqkoTufHxyTpssLusTMWN+nVN8UZvw9wJVN7q
         qYvlRR+fsAOyKog2ZnsvcTMTB50wEjOJp2aAxIYVwtBbdG2P9I4indsjqxaRjss8EhLy
         Q7dA==
X-Forwarded-Encrypted: i=1; AJvYcCVuRfSlV+v/fr6HMzEq9s3RAZtk2xf1wWkbUNyU0hsnwHxaurfM4tVbt0H7F2wnwWKC8ySAQvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8/0FB9ZJW8cILhhsW4i8E41O74XV2W3NqxQTQBbo2wacgG54W
	jfOj9yaIgC9dKX7YQyEqcUAKkycJ1cee5HY+XBAc5EaIrA7PbSktAfiHE06GhEDEOgs=
X-Gm-Gg: AZuq6aIj7YxrKZUirjuvcLyi5Q44jVLD74KP50pQYZT8G2NNvFHLWdbIkoxoiBuyglj
	BfosiePlLyiavTX2cXnD2oNftootN/00J46/G5U2IoQ0z+Z/P+9CSv7ZPuC2VxaI0Q83+WJW1su
	aJ38GH7VRDvKsvupIWVx+rDBydu72llTef3TF1P09N/LqiF3pgVPh0ajrDQjc2EKeIHdzgaABIo
	5W9sYxwKYG+jqJ1qZ8lUeFBYM23hRt6lJrS0lrGvyHixXSMb5lFvuzBnLu/hoHJ/rnBoAyzfSRm
	8WfqebTsZ+u3JcDWxLxO6emDd7RTxrFj2nAGj2ymknn4EeiOk9k3KazWRMOaP3pIEvK7rRirQLf
	pcoXWHNsYRscUamy/MlBiFcSjehWmGyPuF61SV5UOQg/g4pnvI+vM9Qdw6VsvOqUVDxrpjirm42
	pjZiwO/Z6982cRdz3AoqWz+8XGL+fwEswKM+EXZH51CED4a7naWyTJSt2o8ycEpOcDMiA=
X-Received: by 2002:a05:6214:501d:b0:88a:4c50:3be0 with SMTP id 6a1803df08f44-894df970109mr86470926d6.6.1769786198441;
        Fri, 30 Jan 2026 07:16:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c5d4sm58414081cf.3.2026.01.30.07.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 07:16:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlqEe-0000000BAef-38VG;
	Fri, 30 Jan 2026 11:16:36 -0400
Date: Fri, 30 Jan 2026 11:16:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Leon Romanovsky <leon@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <20260130151636.GF2328995@ziepe.ca>
References: <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
 <aXSjm1DXm6yP62tD@pc636>
 <20260124145754.GA57116@j66a10360.sqa.eu95>
 <20260127133417.GU13967@unreal>
 <20260128034558.GA126415@j66a10360.sqa.eu95>
 <20260128180629.GT1641016@ziepe.ca>
 <20260129113609.GA37734@j66a10360.sqa.eu95>
 <20260129132058.GC2307128@ziepe.ca>
 <20260130085131.GA122673@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260130085131.GA122673@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-255170-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 46B41BBF1C
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:51:31PM +0800, D. Wythe wrote:
> On Thu, Jan 29, 2026 at 09:20:58AM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 29, 2026 at 07:36:09PM +0800, D. Wythe wrote:
> > 
> > > > From there you can check the resulting scatterlist and compute the
> > > > page_size to pass to ib_map_mr_sg().
> > 
> > I should clarify this is done after DMA mapping the scatterlist. dma
> > mapping can improve the page size.
> > 
> > And maybe the core code should be helping compute the MR's target page
> > size for a scatterlist.. We already have code to do this in umem, and
> > it is a pretty bit tricky considering the IOVA related rules.
> >
> 
> Hi Jason,
> 
> After a deep dive into ib_umem_find_best_pgsz(), I have to say it is
> much more subtle than it first appears. The IOVA-to-PA relative offset
> rules, in particular, make it quite easy to get wrong.
> 
> While SMC could duplicate this logic, it is certainly not ideal for
> maintenance. Are there any plans to refactor this into a generic RDMA
> core helper—for instance, one that can determine the best page size
> directly from an sg_table or scatterlist?

I have not heard of anyone touching this.

It looks like there are only two users in the kernel that pass
something other than PAGE_SIZE, so it seems nobody has cared about
this till now.

With high order folios being more common it seems like something
missing.

However, I wonder what the drivers do with the input page size, 
segmenting a scatterlist is a bit hard and we have helpers for that
already too.

It is a bigger project but probably the right thing is to remove the
page size input, wrap the scatterlist in a umem and fixup the drivers
to use the existing umem support for building mtts, splitting
scatterlists into blocks and so on.

The kernel side here has been left alone for a long time..

Jason

