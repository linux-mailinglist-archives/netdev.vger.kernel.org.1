Return-Path: <netdev+bounces-239786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDAC6C6D1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 887CD4E9ED8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AD9286430;
	Wed, 19 Nov 2025 02:46:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72942285073;
	Wed, 19 Nov 2025 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520360; cv=none; b=nDNeAG8QNOXcjBAYlfbuiVWvMyr3BGDz06vbiq4XNjOHZZNeRAn0TtAifgWF/Z4pCGjAHqU4Glh04+HVseSCsPaX4SJOJ6vgKyxkoQvnZ9GcGE5rpMmvYOWI7gwrY4NmUzeKawPvnrsx71kV2vs/2aGz/VgekgeiBE8cOn+zTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520360; c=relaxed/simple;
	bh=nFHiwsTwpyx1OEdrt77TXKnhQslbORm27Dwr3muiIcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqptH0nELvvMeZXoumw0ISN7xzVUppQ/0ADYzPDpS5t6wT3THt/q8JicMc9e4PtBRNYhrzT1477dJiZ9Nv3+FrLO+QNMeuD/eh81MArnNKbAaitCpgKnbBTDA/WQdovH24MuWpQxZaWVcWlE22kP9cAQciEyAZ1JE89rCsE2Cao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-07-691d2f5fe744
Date: Wed, 19 Nov 2025 11:45:46 +0900
From: Byungchul Park <byungchul@sk.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
	hawk@kernel.org, andrew+netdev@lunn.ch, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	ziy@nvidia.com, willy@infradead.org, toke@redhat.com,
	asml.silence@gmail.com, alexanderduyck@fb.com, kernel-team@meta.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	mohsin.bashr@gmail.com, almasrymina@google.com, jdamato@fastly.com
Subject: Re: [RFC net-next] eth: fbnic: use ring->page_pool instead of
 page->pp in fbnic_clean_twq1()
Message-ID: <20251119024546.GA18344@system.software.com>
References: <20251119011146.27493-1-byungchul@sk.com>
 <20251118173216.6b584dcb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118173216.6b584dcb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsXC9ZZnoW68vmymwZX9ahb7mpYxW6z+UWGx
	/MEOVos5q7YxWsw538Ji8XX9L2aLp8cesVvcX/aMxWJP+3ZmixWT/rJb7Lu4hs3iwrY+Vovt
	DQ/YLS7vmsNmcW/Nf1aLk7NWslh8PHGC0eLYAjGLb6ffMFpcOvyIxWJ2Yx+jxe8fQGWzj95j
	dxD32LLyJpPH5Vt72DwmNr9j99g56y67x4JNpR6bV2h5bFrVyeax6dMkoPCOz0we5y5WePQ2
	v2Pz+Pj0FovH+31X2TzOLDjC7vF5k1wAfxSXTUpqTmZZapG+XQJXRtPJbraCw0IVvX/aWRsY
	X/F1MXJySAiYSDzsuc0KY2+5e5QZxGYRUJVYsnsRI4jNJqAucePGT7C4iICKRMvmmSxdjFwc
	zAItLBL/D80AKxIWSJdom9UEVsQrYCEx9fl/dhBbSCBGoqnnGiNEXFDi5MwnLCA2s4CWxI1/
	L5m6GDmAbGmJ5f84QMKcAoYSJ+6+YgKxRQWUJQ5sO84EcdsjdomNK7UgbEmJgytusExgFJiF
	ZOosJFNnIUxdwMi8ilEoM68sNzEzx0QvozIvs0IvOT93EyMwqpfV/onewfjpQvAhRgEORiUe
	3g5+2Uwh1sSy4srcQ4wSHMxKIryqjjKZQrwpiZVVqUX58UWlOanFhxilOViUxHmNvpWnCAmk
	J5akZqemFqQWwWSZODilGhgz9W2PTDLjfmE9T/KmX4ec/dtXFuV6nH4PDriJzrlj+jHj9uO8
	C6dX9wcY2z/5Zdv6efF5sU7xOUIOXEWpH+adTTpx5vCSG68XzW6cKX/r8r5fn8KZHp2wC3my
	0sRFwyLWdMf9QDOOha2cl4wXTH7ckZz33frBvpzgsvaPYbO+3jA7/Ueok/+0EktxRqKhFnNR
	cSIAAgFzG+YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsXC5WfdrBuvL5tp8LtJzGJf0zJmi9U/KiyW
	P9jBajFn1TZGiznnW1gsvq7/xWzx9Ngjdov7y56xWOxp385ssWLSX3aLfRfXsFkcnnuS1eLC
	tj5Wi+0ND9gtLu+aw2Zxb81/VouTs1ayWHw8cYLR4tgCMYtvp98wWlw6/IjFYnZjH6PF7x9A
	ZbOP3mN3kPDYsvImk8flW3vYPCY2v2P32DnrLrvHgk2lHptXaHlsWtXJ5rHp0ySg8I7PTB7n
	LlZ49Da/Y/P4+PQWi8f7fVfZPBa/+MDkcWbBEXaPz5vkAgSiuGxSUnMyy1KL9O0SuDKaTnaz
	FRwWquj9087awPiKr4uRk0NCwERiy92jzCA2i4CqxJLdixhBbDYBdYkbN36CxUUEVCRaNs9k
	6WLk4mAWaGGR+H9oBliRsEC6RNusJrAiXgELianP/7OD2EICMRJNPdcYIeKCEidnPmEBsZkF
	tCRu/HvJ1MXIAWRLSyz/xwES5hQwlDhx9xUTiC0qoCxxYNtxpgmMvLOQdM9C0j0LoXsBI/Mq
	RpHMvLLcxMwcU73i7IzKvMwKveT83E2MwChdVvtn4g7GL5fdDzEKcDAq8fD+mCCTKcSaWFZc
	mXuIUYKDWUmEV9URKMSbklhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbL
	xMEp1cAYmSP1va+JU8cscMvH+aes4+Kvx/5gWG+tfdRXa+aPT7rbJfQb7lf/Tfhu53PBYsXe
	nOnqm/NTLm1cwRNl3f+vM6N25qVZhdMe3H6y9M2ZPxPKjG52tXq+OxM/dzrThZWm63etfds9
	Q5+RgzXKOX3K/vK09tq7ivNfftF0TGC0vqKXY5pZJflBiaU4I9FQi7moOBEAgoPsPM4CAAA=
X-CFilter-Loop: Reflected

On Tue, Nov 18, 2025 at 05:32:16PM -0800, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 10:11:46 +0900 Byungchul Park wrote:
> > With the planned removal of @pp from struct page, we should access the
> > page pool pointer through other means.  Use @page_pool in struct
> > fbnic_ring instead.
> >
> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> > I should admit I'm not used to the following code.  So I'd like to ask
> > how to alter page->pp to avoid accessing @pp through struct page
> > directly.  Does the following change work?  Or can you suggest other
> > ways to achieve it?
> 
> @ring in this context is the Tx ring, but it's the Rx ring that has the
> page_pool pointer. Each Rx+Tx queue pair has 6 rings in total. You need
> the sub0/sub1 ring of the Rx queue from which the page came here.

Thank you for the explanation.  I'd better make it in the following way
rather than modifying the unfamiliar code.  Looks fine?

	Byungchul
---
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index c2d7b67fec28..382573f35408 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -653,7 +653,7 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 				 FBNIC_TWD_TYPE_AL;
 		total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
 
-		page_pool_put_page(page->pp, page, -1, pp_allow_direct);
+		page_pool_put_page(pp_page_to_nmdesc(page)->pp, page, -1, pp_allow_direct);
 next_desc:
 		head++;
 		head &= ring->size_mask;

> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > index b1e8ce89870f..95f158ba6fa2 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> > @@ -653,7 +653,7 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
> >                                FBNIC_TWD_TYPE_AL;
> >               total_bytes += FIELD_GET(FBNIC_TWD_LEN_MASK, twd);
> >
> > -             page_pool_put_page(page->pp, page, -1, pp_allow_direct);
> > +             page_pool_put_page(ring->page_pool, page, -1, pp_allow_direct);
> >  next_desc:
> >               head++;
> >               head &= ring->size_mask;
> 

