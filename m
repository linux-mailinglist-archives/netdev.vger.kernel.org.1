Return-Path: <netdev+bounces-280368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE+2HBGZ6GkwNQIAu9opvQ
	(envelope-from <netdev+bounces-280368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:46:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1351444364
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E204F300E173
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7D03C9EC2;
	Wed, 22 Apr 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDcv0/Et"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945E3C8738
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851157; cv=none; b=IGyvjfuS6P+FJo6hkGowCwSE5SxMRPf2EPYCfrZkBsxThm4yCASoFuuqM+L0P0SSL2shBkSWL7scyx0WReozLr4qVAoVvq6XGRipdhQQTt3NU6PI4WtABAhi2fPSA99pss8RoXX5LBJ1PBzUI+z5d+P8hk4WBf+a2SqwZHOxgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851157; c=relaxed/simple;
	bh=mav/STE0NF7fvNjlQRP3/FZ3RuBFYPwNZT9g9eXKEfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uv0SN4/iCoRwmRoOu4tMyK3eaCUfCtiXOGb63KCr4YeQ+FpdbyndzNECLrcmgoxKgzrSUH3XjukI5adz18XV8U8Q1ovr2iIsgCmhr+IF4ccXcculh1Rwz812Kc+S3Hyv6cOnhE9MEADlcigJwgxj9pKfGtwjV8UctiTmbJ/YfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDcv0/Et; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776851153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DWElmvCW88iMc2QmGBoFNqAZ9xIkgo2vBjnUZn+loY8=;
	b=QDcv0/EtqAOC51MYoEAfqIgEQB8tB6orSDjegqjrC4agsH4omKTleQdyRwztVne7T260/t
	jU/inoWrTrr4ehadOfmWU4B7Kp9NDKEgeuR4clEoL9AJgUKcCo52jdfdg3xEvTbNe7IT02
	6OUJDXj4X8Eq1pXJ5zJPbGmBbp06ej0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-QjF5fv6JNrK_ceQh7NBaGw-1; Wed,
 22 Apr 2026 05:45:49 -0400
X-MC-Unique: QjF5fv6JNrK_ceQh7NBaGw-1
X-Mimecast-MFC-AGG-ID: QjF5fv6JNrK_ceQh7NBaGw_1776851147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE7B19560A3;
	Wed, 22 Apr 2026 09:45:46 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 920C03000C21;
	Wed, 22 Apr 2026 09:45:41 +0000 (UTC)
Date: Wed, 22 Apr 2026 11:45:38 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, kexinsun@smail.nju.edu.cn,
	luka.gejak@linux.dev, Arvid.Brodin@xdin.com, m-karicheri2@ti.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, xuyuqiabc@gmail.com, royenheart@gmail.com
Subject: Re: [PATCH net v3 1/1] net: hsr: limit node table growth
Message-ID: <aeiYpkiWUD5MtGEB@thinkpad>
References: <3bdbe54e81bd89c1443b05500368fb45bddc3191.1776754203.git.royenheart@gmail.com>
 <aeiHa7rzmSqzMIaJ@thinkpad>
 <20260422085242.3TkVbXc2@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422085242.3TkVbXc2@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280368-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,smail.nju.edu.cn,linux.dev,xdin.com,ti.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1351444364
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:52:42AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-04-22 10:31:39 [+0200], Felix Maurer wrote:
> > On Tue, Apr 21, 2026 at 10:50:01PM +0800, Ren Wei wrote:
> > > diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> > > index d09875b33588..8a5a2a54a81f 100644
> > > --- a/net/hsr/hsr_framereg.c
> > > +++ b/net/hsr/hsr_framereg.c
> > > @@ -189,6 +195,7 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
> > >  				     enum hsr_port_type rx_port)
> > >  {
> > >  	struct hsr_node *new_node, *node = NULL;
> > > +	unsigned int node_count = 0;
> > >  	unsigned long now;
> > >  	size_t block_sz;
> > >  	int i;
> > > @@ -226,20 +233,31 @@ static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
> > >  	spin_lock_bh(&hsr->list_lock);
> > >  	list_for_each_entry_rcu(node, node_db, mac_list,
> > >  				lockdep_is_held(&hsr->list_lock)) {
> > > +		node_count++;
> >
> > I'm not sure if this on-the-fly node counting is the best solution here.
> > My concern is that it comes quite late in the process, i.e., after we
> > already allocated a bunch of memory, etc. As we are discussing a
> > scenario where a lot of entries are created, maybe we shouldn't even
> > allocate a new_node if the table is already full? For example by storing
> > the node_count in hsr_priv and checking it early in the function?
>
> The node is allocated upfront. Then it iterates here and we only end up
> counting through the full list if there is no match. This is under a
> lock so "many clients" are serialized. If we allocate the node later
> then we need to do it under the lock.
>
> I don't think the node count exceeds 100 in production. So having a
> counter which is incremented while adding to the list and decremented
> while removing items from the list would optimize the "worst case". So
> instead traversing the list with 1000 we would just give up.

The counter is what I had in mind. I agree that allocating under the
lock isn't what we want.

I'd argue counting through the whole list is the normal case.
hsr_add_node() is only called after the node table has been searched
already (without the lock). Here we go through the whole list again
under the lock to prevent TOCTOU-type situations.

I agree that, overall, it would be optimizing the worst case, but I
think it may be worth it to prevent the memory allocations and walking
the whole list. But I'd go along with the (current) on-the-fly counting
as well.

Thanks,
   Felix


