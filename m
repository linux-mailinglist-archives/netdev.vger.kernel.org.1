Return-Path: <netdev+bounces-257198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NMXNV2khGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:08:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B369F3C81
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08BB30474EA
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E7F3EDADD;
	Thu,  5 Feb 2026 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9WEyrj/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547F3D902B
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300135; cv=none; b=UeoutIi3V09jt89caCU3HinKPvo2yQDBJAMGzsGbQr+4w3oMbhLO6LpAnXxtIFhMW2/2VIQv2kehh4M1J4KhFIXu3cPtAOsBWmcg37rLpHcC9CKVHn0zjXop+WRPzhpjGQNL51gHhrHkU5xDBhx2H/W0STrbnE9RTJ6eAeBcsO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300135; c=relaxed/simple;
	bh=hxTbOXF5unnrj4n1LK2zzj3UFtrQN608NZELXhwAT3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmopNNftu8GpfGiryXMy6QkSx5Cswe+2MNnxcd9ZqyW+CKfNjBrlHYK8jynT20lj2FeB4288M9jBvuHV/pDyp3ghnHmA6c63q0+wv8xkq6JS9S0Z9p9t9BaRHRDt7+BzH8/LHyFzNDmPCEeUZYTFWe0PZm967y2d70GHKryoK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9WEyrj/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770300133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W4cciLXcBbOn/BczcUxcWl1OtNQr97iane/H+/6AiU0=;
	b=d9WEyrj/b5Ed2UQNUDVgRdl9zipsMXddxhfa5tul6wcxPu+ix2sbQWTLs33uYVyiorfH+Z
	z1hkARRlT9Y7F8YF45DayL6O/bMVR6/+xRYWdfTJkX53+XZ9cCE7XkDTdp9eO5Sr+CrzYw
	8weFgr0ngEjk9RJpOiPPqoDSs82fh4M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-A7e6TmLDPUareYijLV9gtQ-1; Thu,
 05 Feb 2026 09:02:12 -0500
X-MC-Unique: A7e6TmLDPUareYijLV9gtQ-1
X-Mimecast-MFC-AGG-ID: A7e6TmLDPUareYijLV9gtQ_1770300130
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79AE218002C3;
	Thu,  5 Feb 2026 14:02:10 +0000 (UTC)
Received: from thinkpad (unknown [10.44.32.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FC3319373D8;
	Thu,  5 Feb 2026 14:02:06 +0000 (UTC)
Date: Thu, 5 Feb 2026 15:02:03 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org, jkarrenpalo@gmail.com,
	tglx@kernel.org, mingo@kernel.org, bigeasy@linutronix.de,
	matttbe@kernel.org, allison.henderson@oracle.com, petrm@nvidia.com,
	antonio@openvpn.net, Steffen Lindner <steffen.lindner@de.abb.com>
Subject: Re: [PATCH net-next v3 4/8] hsr: Implement more robust duplicate
 discard for PRP
Message-ID: <aYSi2_VFZ1iEMZJj@thinkpad>
References: <cover.1770041682.git.fmaurer@redhat.com>
 <d767a756f426b8906ea12e411a97cf2ba04182c5.1770041682.git.fmaurer@redhat.com>
 <ccad3f52-e46a-46b5-9113-153a31b3ddd3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccad3f52-e46a-46b5-9113-153a31b3ddd3@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257198-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,de.abb.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[abb.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B369F3C81
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 01:25:01PM +0100, Paolo Abeni wrote:
> On 2/2/26 3:19 PM, Felix Maurer wrote:
[...]
> > Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
> > Fixes: 05fd00e5e7b1 ("net: hsr: Fix PRP duplicate detection")
>
> I'm sorry for nit picking, but it looks like the current quidance is to
> avoid fixes tag for this kind of resiliece improving refactors:
>
> https://lore.kernel.org/netdev/20260121171051.039110c3@kernel.org/
>
> > @@ -526,18 +613,21 @@ int hsr_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
> >   */
> >  int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
> >  {
> > -	enum hsr_port_type other_port;
> > -	enum hsr_port_type rcv_port;
> > +	u16 sequence_nr, seq_bit, block_idx;
> > +	struct hsr_seq_block *block;
> >  	struct hsr_node *node;
> > -	u16 sequence_diff;
> > -	u16 sequence_exp;
> > -	u16 sequence_nr;
> >
> > -	/* out-going frames are always in order
> > -	 * and can be checked the same way as for HSR
> > -	 */
> > -	if (frame->port_rcv->type == HSR_PT_MASTER)
> > -		return hsr_register_frame_out(port, frame);
> > +	node = frame->node_src;
> > +	sequence_nr = frame->sequence_nr;
> > +
> > +	// out-going frames are always in order
>
> Please use /* */ for comments.

Both done in v4 [1], plus one more instance of a // comment.

Thanks,
   Felix


[1]: https://lore.kernel.org/netdev/cover.1770299429.git.fmaurer@redhat.com/


