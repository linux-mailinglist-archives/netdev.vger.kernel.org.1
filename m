Return-Path: <netdev+bounces-304267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kZxyEXnFRmosdQsAu9opvQ
	(envelope-from <netdev+bounces-304267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:09:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DD6FCAE6
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 22:09:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qYht2Prb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304267-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304267-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87832301484B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 20:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B54F3932D9;
	Thu,  2 Jul 2026 20:09:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9730EF8F
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 20:09:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783022966; cv=none; b=VjqK6Z5THPFVI5UF3tI6OjRi+8Q5UogaBfMa6V/MpTe4+wSaep2/U33OH9dTV9YhVnpy3t8tw/z2hiRqeE7S0denTeIpEKFih2ioVOY0/+h6k5kqSFKt1Q+zlM71Ma+Cg2UiifDEBXx5GaY87tqaXoc+325ldrofPFG66s8U/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783022966; c=relaxed/simple;
	bh=13oD+YiL/3o0MEN6K6Y/bx7CKvJzT37nBrfnC/MzHFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujSofT1r2ziWV4e15T+Yb1wnfiXzeem8emzcyd+PjErDsrvyDaGkY12d6wtPYNc72r4E+S1dxZndGkxsibtmiGEetOEv+Zrp38Y8AIiofYrq/t4pshj1feAelmzTrYc8A0KP4KojgVgL8a7RBx716QVXVa323mmKRZI1xwtmBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYht2Prb; arc=none smtp.client-ip=209.85.161.51
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso923766eaf.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783022965; x=1783627765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=qYht2Prb/gnqRafc370x8QL0AVhwNbkWYD7Mb0oEnS6BBC1/7zqQk4okOm+qy8WkGQ
         RxC4dqTCKz01d3diR6dB2/5uKwM8YFAPrXjCx646oRPimx2pQb0+QSMqzy5/ttykB3zo
         tiInWqtjwp7x2BlEhBNZ9UvRPSorkfoZSFL1Ts+hgBxNBzh41kxabF+GJSxtH3TgtrIk
         7bjozptJEY/oUZlHpoUIs2DKPTQ/Ar+ULai3UQ1k3whzj32T+2lzBGKODMkUxIp2ESkk
         Qtocv5xq1OwB5kxkbsoWaRMzaYj74+ddVix6bjxov7mWczXJPVfYTRRDp4sNwrq/6I06
         eXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783022965; x=1783627765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjQFRK3eyEfNEKRH/kJEfHrxEWDAZH2cdSABwq7lLiA=;
        b=ihOC6vDRNpzgDu9PKiG9bIR5Va9Xqp/2ErCTB0A9bR1eWhy87J/f2eUu2LafEw3Nu0
         GlDdO9KQmDwQoZoIfWiddy5yoRwJbNDSCJ2n/UcgkYK+18m9U3+z4HANxByjzTccfvvi
         JIZ06BOwRGI383yvbk1YH9ISzvKtWAAxKP74noVdSKxSboZdrhK9dbHYsZWYN6/9CB4X
         1A6mbf11JeqWYxBwdOdWjFOflY7ak/wI8MzUNnAo2ogUU3tPxdF7p5NraL6juZBASkOl
         ITBfpWRALh9oUwbNubFcUucF36BzhP9X/fQrtVZMl/FG0XInf8sJlWCCgA1cySyNBE90
         OFfA==
X-Gm-Message-State: AOJu0YzMcDlkQ+r6U4upYB8wZpUIzBpxdL9puEG+F9rxxuDSELkWRh8i
	aFhvvP88uaJ8vtdlp78tLgUY79wnDJviiAdNMCtJ59ma24XYkPmot2zX
X-Gm-Gg: AfdE7ckqbzVDXFfmYT0WLRjvQL+tQ9wkOJJ8Nfs2kiJoRh7YpRWrovcYdEzCq+uTve/
	UUQ/Ff1viJcJQcwRJr6Zxu0kz/TjEzOw6DjqrxTdm+b8Z+9xSWLV2Os5xNrraNwg3G4FAmDJ4qh
	z6CxfXM0BkmoOZYUw6GHGxWCEc4juiuMij3smsA6wOPBGrOL2BGLLM5zRgaH84XAp0yZwvlpZ9V
	+/zl8Ho9JjDGHY81MDZHn18qqv3cwUUvi+HjgKDhenM9NIaHp5XqRC8iC0ftMr4bpkUZyJLD32N
	wrEnwSrn/b26FBPoyDE8imgX/3o82ODUsbQ2vhDDbRjr92v7RM0KZ2C2fafTb/vk8Gk4KgTCUBb
	AHJnoL9M4gl6YxSZxULsAI7BVia83VJnLZUQ+VnKuEmOqXKSe4C16/lvmXuZsCBkeDQRui/DLb2
	gjtvpfp2QzoUCEjVLt4qJwnkuV8CcWciy+bw==
X-Received: by 2002:a05:6820:4cc3:b0:6a2:739a:ce95 with SMTP id 006d021491bc7-6a309929b99mr4607337eaf.4.1783022964709;
        Thu, 02 Jul 2026 13:09:24 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3662142fac.12.2026.07.02.13.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 13:09:23 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:09:20 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akbFcMHenseQW7mJ@devvm29614.prn0.facebook.com>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
 <akYl38_9Y4ydXuqE@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYl38_9Y4ydXuqE@sgarzare-redhat>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304267-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:eperezma@redhat.com,m:stable@vger.kernel.org,m:brienpub@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,lists.linux.dev,linux.alibaba.com,google.com,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A27DD6FCAE6

On Thu, Jul 02, 2026 at 10:56:04AM +0200, Stefano Garzarella wrote:
> On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
> > On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:
> 
> [...]
> 
> > > +out:
> > > +	if (new_skb)
> > > +		__skb_queue_tail(&new_queue, new_skb);
> > > +
> > > +	skb_queue_splice(&new_queue, &vvs->rx_queue);
> > 
> > I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
> > when adding to rx_queue?
> 
> IIRC we added it in the rx path, mainily for loopback to pass the ownership
> from the tx socket to the rx socket, but here we are already in the rx path,
> so the skb will never leave this socket.
> 

Ah that's right, I stand corrected. There is no sender to leak in this
case.

> Maybe it's necessary for the eBPF path?

Looking through sockmap, I don't think it depends on skb->sk being
non-null either (it reassigns owner to the redirect socket anyway using
skb_set_owner_r()).

Sorry for the false alarm. LGTM.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>

