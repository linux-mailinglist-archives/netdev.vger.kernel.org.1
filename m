Return-Path: <netdev+bounces-206522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EAEB03550
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D979218967BD
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080AA1F4297;
	Mon, 14 Jul 2025 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gaTGcuF8"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C1BE65
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 04:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468451; cv=none; b=Rh3wZw7bM0vXLFk94brN4PodAIY5PO0FIISalX96EeGjYUpWUfOXhbbrRqHztqjwUjsiZCeOhsfqg0yHSkdFUPVsnCWRSgS773My62x0iexjNOmVFixZlhV2GchqRGVTN7DzaYIWE7p3Bi1bLue7yaf0nuXhCQAflCTcMrFsaCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468451; c=relaxed/simple;
	bh=2TLOEy7APGic4rNRF4nETeBzg0G7HZkHR4OomFncHw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhNYQetwjB6LBMwxVsozwBzRkHQxJifRdCuzF7UnKaRTdUkZnyBGJ+OmTG8SIlq+a2/Cqj4CB5oTE9UgCc2R6k7oKxiEARPe5rz/PiFU4EPlNn7sbu/OYLvRb++09e46dK3AIoCv5Ikc5GBW7MsLl4H4O9WHRlzP+2lFmgKIRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gaTGcuF8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jt3uuIFexqd6XmP6qepoHJTyP14Vh0xfu0v5fLb1/J0=; b=gaTGcuF8Tn/JorOaAjK0A9ZPk/
	Zn051Ya+lJOrbJsSjU6jL6eKzhxVC2gdIKHZeNVXCGI95s6wi0T0xaQUIXv2YPkqzRa6pq2F+s3ro
	IZW4NSF309PXrI62JEIJ3+7obcg9LLCQmF6rtnRL+v7oqvl5rfrqunsRE+fLOgNxO+sC0H48bkZY2
	7muO6Zl5ARxp+QFVkEKi/4BFqLj+EHoQ2L2kWkooB7mgyqysos7UGrcb4/tST2yJZS+noRcsvl7xN
	X5v+d30l60j+ZOW4EMH/vDQRGvJvcc8L4XQWKGp+RhVLmA4hu7VU74bkwK8wxEATE/bEPDzn7isUN
	w4cRCsjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubB66-00000004kHb-1Ydl;
	Mon, 14 Jul 2025 04:47:26 +0000
Date: Mon, 14 Jul 2025 05:47:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC][PATCH] don't open-code kernel_accept() in
 rds_tcp_accept_one()
Message-ID: <20250714044726.GD1880847@ZenIV>
References: <20250713180134.GC1880847@ZenIV>
 <2eb0df2c5dd8b16b5103f0e2859690519c4f2dad.camel@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb0df2c5dd8b16b5103f0e2859690519c4f2dad.camel@oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 14, 2025 at 04:36:32AM +0000, Allison Henderson wrote:

> >  	if (!sock) /* module unload or netns delete in progress */
> >  		return -ENETUNREACH;
> >  
> > -	ret = sock_create_lite(sock->sk->sk_family,
> > -			       sock->sk->sk_type, sock->sk->sk_protocol,
> > -			       &new_sock);
> > +	ret = kernel_accept(sock, &new_sock, O_NONBLOCK);
> >  	if (ret)
> > -		goto out;
> > -
> > -	ret = sock->ops->accept(sock, new_sock, &arg);
> > -	if (ret < 0)
> > -		goto out;
> > -
> > -	/* sock_create_lite() does not get a hold on the owner module so we
> > -	 * need to do it here.  Note that sock_release() uses sock->ops to
> > -	 * determine if it needs to decrement the reference count.  So set
> > -	 * sock->ops after calling accept() in case that fails.  And there's
> > -	 * no need to do try_module_get() as the listener should have a hold
> > -	 * already.
> > -	 */
> > -	new_sock->ops = sock->ops;
> > -	__module_get(new_sock->ops->owner);
> > +		return ret;
> I think we need the "goto out" here, or we will miss the mutex unlock.  Otherwise kernel_accept looks like a pretty
> synonymous wrapper.

What mutex_unlock()?
	if (rs_tcp)
		mutex_unlock(&rs_tcp->t_conn_path_lock);
won't be triggered, since rs_tcp remains NULL until
	rs_tcp = rds_tcp_accept_one_path(conn);
well after any of the affected code...

No, return is perfectly fine here - failing kernel_accept() has no side
effects and we have
	if (!sock) /* module unload or netns delete in progress */
		return -ENETUNREACH;
just prior to it.  So if we needed to unlock anything on kernel_accept()
failure, the same would apply for the failure exit just before it...



