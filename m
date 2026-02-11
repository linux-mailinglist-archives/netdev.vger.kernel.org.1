Return-Path: <netdev+bounces-258316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PRDC7i1jGnNsQAAu9opvQ
	(envelope-from <netdev+bounces-258316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:00:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968A12661F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7DE53009990
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A560F31197C;
	Wed, 11 Feb 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1uKnNje"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8288A2DCF61;
	Wed, 11 Feb 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829215; cv=none; b=nhpTl8JudXfkqm3ibHO3XjYytYilnAgUQfiny2/JbIDJhCbrVov6Tbg8d6uaWCEhwXLL4Vqzp/tsRTAZTIzrdbTJTzJQWbNo2cxNKpnPISYQNDoNGc3sgMd5vt6Rv77xrf7wbkWSYr3Bp4zSlbdD1yCwb++wEvKiA1Bv4LWr7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829215; c=relaxed/simple;
	bh=Sqt6TjSugqBe03dUOtB3IYh7knDC3/D9+bsAISyuKPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efvddp5AftccSjACIVRrkzZvRIoAz0BIv2ylbz+vJNAlfJIlQuJyGW0QdHEO81lVuS2tiJI/iB7Tp/5frCDEegoti5cf3adzShjak+Jfiwihj2erTEOCBuKNW3RBELwx+iu6mqv1OFow/VmUmLOkWaMul9ApRSboxRd2ViUV1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1uKnNje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76013C4CEF7;
	Wed, 11 Feb 2026 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770829215;
	bh=Sqt6TjSugqBe03dUOtB3IYh7knDC3/D9+bsAISyuKPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N1uKnNjeeGJ4s84rBqdcU0khQKd+HMaT2Y8xjK6j8yuvSNPfWEUraY0hVhj5ulVai
	 MdCWxBt31xhSnqvr1p+9MXlmYk5jonjl9/2f4X0cCR3dD8sa3NSfC8dVeppENrmBa7
	 gYteNMyhfVuSzDiSIbOPOersuly3lgaimFQxK0ZpCPkF6/P+RMOKlt6/iOtJipz/ir
	 XIP51lP6MC2TGgC8QjW6dlku5uRRY0BserRi2AZ/ALBYWOtsF+kNUMSvGIU8U062Y8
	 jG1AOY2kQ2ALn7lvABG1TxcBekfvI0kF1e8ciJ+eKoGKvcD+ctibuCnRvJJUFL7xP0
	 q1ejyGGxp/Egw==
Date: Wed, 11 Feb 2026 09:00:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] selftests: drv-net: gro: use SO_TXTIME
 to schedule packets together
Message-ID: <20260211090013.12991cd0@kernel.org>
In-Reply-To: <willemdebruijn.kernel.172899765680b@gmail.com>
References: <20260207003509.3927744-1-kuba@kernel.org>
	<20260207003509.3927744-7-kuba@kernel.org>
	<willemdebruijn.kernel.743811e01cc@gmail.com>
	<20260210175638.123782b2@kernel.org>
	<willemdebruijn.kernel.503ed4ace7bf@gmail.com>
	<20260210194814.21a0c403@kernel.org>
	<willemdebruijn.kernel.172899765680b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258316-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9968A12661F
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 23:21:07 -0500 Willem de Bruijn wrote:
> > > I wonder what's going wrong here.
> > > 
> > > fq_classify should pick the queue based on skb->sk also for packet
> > > sockets.
> > > 
> > > And flow_queue_add should add the packets to the tail of the linear
> > > list if the delivery time is identical to that of the tail.  
> > 
> > It works but requires that we either modify the qdisc config to set
> > a orphan_mask of 1, or somehow set the skb->hash on the AF_PACKET skbs.  
> 
> Oh right, fq_classify does not use skb->sk for packet sockets because
> they are in default sk_state TCP_CLOSE.
> 
> And this is by design, as clearly documented, as packet sockets should
> not be assumed to be a single flow:
> 
>         } else if (sk->sk_state == TCP_CLOSE) {
>                 unsigned long hash = skb_get_hash(skb) & q->orphan_mask;
>                 /*
>                  * Sockets in TCP_CLOSE are non connected.
>                  * Typical use case is UDP sockets, they can send packets
>                  * with sendto() to many different destinations.
>                  * We probably could use a generic bit advertising
>                  * non connected sockets, instead of sk_state == TCP_CLOSE,
>                  * if we care enough.
>                  */
>                 sk = (struct sock *)((hash << 1) | 1UL);
>         }
> 
> An orphan_mask of 1 sounds like an effective workaround.
> 
> I don't see a way to force a specific skb_get_hash result across
> flows, given hashrnd.

So WDYT about the patch? I don't wanna tweak qdiscs on real interfaces.
It's way to hard to undo. IMHO either we keep the patch as is with its
limited effect or just drop it.

