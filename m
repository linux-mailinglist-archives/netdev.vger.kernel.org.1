Return-Path: <netdev+bounces-302283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bs1vEBcdP2rKOwkAu9opvQ
	(envelope-from <netdev+bounces-302283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:45:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF56D0A2B
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 02:45:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="P3IrGto/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302283-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302283-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23CB0300DD7E
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 00:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE971DE4F1;
	Sat, 27 Jun 2026 00:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B1D15E8B;
	Sat, 27 Jun 2026 00:44:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782521087; cv=none; b=bvpETLJ+ZIhNM42fFvzRBLLUucRYtbcED0i4mLmnnYt78KLQIaYs7BNzkJLYLy26tj0Wse9Z1Jz7RPof5s+WEmupzn5DRSFr7qkdT7Q6thbut6TXp5BEpRD5WBIwMOvl3/a+rWgQGEdDK2sM6xNOlm7V0McawacgGeABm2+UiYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782521087; c=relaxed/simple;
	bh=kUr2yPQCOsok+8rxx1oCI1yb2iBBXfSozLF9w97A8c8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hTX909tjFYsIERs9vp56tMYLFNZy6zBvE+q6ShXPVZHxMBMBkvAsoBQHVmNjsO8YDFvupHO7oOZqefA2h1BIA63Keka0Aqa3CvEQZq1tOLLYRCp8sdXQzf7Ekt1KDi1aK6qBQm5nyoFMvOqI/04UFR1yQtQ18wgmQRwhUc6MQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3IrGto/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7291F00A3A;
	Sat, 27 Jun 2026 00:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782521086;
	bh=Xft+vbctEr1djAr+KskNxSck9zBs9troo/s4Ve2heuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P3IrGto/ssl/6Aj0KV7T+Mcp2qpZPH2WtCGaQ498wYOm3HGEjWg/xQhVaFoYQHbl2
	 drAJyC+/0xpmPtQV77AMKRAMxKE0xRzY6JwrobJIpo5H3oXLcfu5W0HpWVC5XYB68O
	 DaEvnkJ4umHKsLVLlrQp6vfuQTm4XrujoWigKhf7LI561Z1EXhd/3n9YV5qLTIkail
	 r92R0mgaeJKYLM6iwdVNam3lnHAJu0n9i7IoVl5XTFba54xQIM1ZRsQTdq2LLtzT27
	 gqya1lJy5fQI+sGKvGfbdum8bbLUzCmQU7XKgREtqkJK1Zjra34tcddsQyXPuAvgKP
	 fRZ0Ol0iJybRA==
Date: Fri, 26 Jun 2026 17:44:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>, lange_tang@163.com
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, jasowang@redhat.com,
 edumazet@google.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH v4] virtio_net: disable cb when NAPI is busy-polled
Message-ID: <20260626174445.700df7e3@kernel.org>
In-Reply-To: <20260626151508.1319440-1-horms@kernel.org>
References: <20260625013733.29300-1-lange_tang@163.com>
	<20260626151508.1319440-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:lange_tang@163.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:jasowang@redhat.com,m:edumazet@google.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:tanglongjun@kylinos.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302283-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,163.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5AF56D0A2B

On Fri, 26 Jun 2026 16:15:08 +0100 Simon Horman wrote:
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 26afa6341d161..c1e252400c0fc 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3011,6 +3011,8 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >  	unsigned int xdp_xmit = 0;
> >  	bool napi_complete;
> >  
> > +	virtqueue_disable_cb(rq->vq);
> > +  
> 
> [Severity: High]
> Can this unconditionally disable the RX callback and cause a permanent network
> stall when polled by netpoll?

Good catch, Longjun just add if (budget)

