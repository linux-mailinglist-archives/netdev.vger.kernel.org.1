Return-Path: <netdev+bounces-256337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCRUFk0Qgmm9OwMAu9opvQ
	(envelope-from <netdev+bounces-256337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:12:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E99DB1ED
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 506E43019D42
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F28E31196C;
	Tue,  3 Feb 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5dmt8Gu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AA314D14
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131531; cv=none; b=A+8SLSgJx145ie+sI0ZD/IE56OPBLOHDJPPPDW9EVQwcU4EF1GHRC0L98zGy9lqpEl056jRpVL1GdyLTF/OcfEVoVfjMF0OqJO5pZzm5LRzJW9j91OS+l8ep3ldIGnDIzVtlTUP4otlXNU4Tf/arzcBrS7EbXUrGTcwVGnvaOic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131531; c=relaxed/simple;
	bh=37Hsn483xDXHwRcx3GhejQB/vinpbjW/AzqyvbSCXEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3uusD4sGFlQJjcaHyogTevDiOd03rDRcmfhV5hcg3f2eNZxYr4q5q3WyGfsnlLj4KUD1xwefdR5itwNgMyv8AwWyTZfLsikcTl2nAJyBECdtj7OS0b03Jb97jzY4UDpFO9TYe+Tuv59O5VBOcgQIzKqqteQSdcoqVfNtdVw72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5dmt8Gu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770131528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUX/99rSKw6yjrxQfrYEMVf1LeueTxK1Nhf0gt9cJ8k=;
	b=C5dmt8GuAEofncul1kp6JE4ez6vP6A01N4hLXETODgA+suOBkt0EkEa92DnHW7c4bzohSx
	KHbdgL3N78eLs0osIk9zFGE6AromVlHIEAJiEVAKxf6BuTIuxcw2b6e0J+PJ6MJIaSyZjl
	IW0qFlL8q4shmpk9FcZi8tkuka1jBo0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-Gbqua5C0OAWXb3wdmJqbqA-1; Tue,
 03 Feb 2026 10:12:03 -0500
X-MC-Unique: Gbqua5C0OAWXb3wdmJqbqA-1
X-Mimecast-MFC-AGG-ID: Gbqua5C0OAWXb3wdmJqbqA_1770131520
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA5B9195FE05;
	Tue,  3 Feb 2026 15:11:55 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F0FB1956048;
	Tue,  3 Feb 2026 15:11:51 +0000 (UTC)
Date: Tue, 3 Feb 2026 16:11:48 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jkarrenpalo@gmail.com, tglx@linutronix.de,
	mingo@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v2 4/9] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <aYIQNPTK5ZNRnRkb@thinkpad>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <fe1dbc483482e98fbc286290a2a3e88f555894d4.1769093335.git.fmaurer@redhat.com>
 <20260128163824.GB172540@kernel.org>
 <aXpXY0YSjA-ctoBa@thinkpad>
 <20260202165702.R9PI3JSM@linutronix.de>
 <aYHMvaGiuQSHBevG@thinkpad>
 <20260203115719.cU_6tnal@linutronix.de>
 <aYHtSP-Pl1mTpkJC@thinkpad>
 <20260203134929.-HomS8WS@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260203134929.-HomS8WS@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256337-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2E99DB1ED
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:49:29PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-03 13:42:48 [+0100], Felix Maurer wrote:
> > Hm, I'm not sure I follow. Do you argue that the code already in the
> > patch is incorrect or that it would be incorrect with Simon's
> > suggestion?
>
> The suggested change should have no impact.
>
> …
>
> > I understood Simon's suggestion this way: in the error path, *also*
> > reset block->time to 0. We'd still return NULL in that case and,
> > crucially, don't advance the next_block. IMHO, that only makes the data
> > more consistent (blocks in the buffer that are not in the xarray always
> > have time=0) and prevents that we try to remove a non-existing entry
> > from the xarray on the next frame when we try again to recycle the
> > current "next" block.
>
> That is correct but should have no visible impact.

Alright, we're on the same track then. I agree that there should not be
any visible impact. But to avoid surprises down the road, I think it's
good to set time=0 for consistency.

Thanks,
   Felix


