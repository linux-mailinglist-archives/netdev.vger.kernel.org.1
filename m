Return-Path: <netdev+bounces-264598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORZKdAeqmlLLgEAu9opvQ
	(envelope-from <netdev+bounces-264598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:24:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE79B219C60
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376F030210D5
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2F92BE031;
	Fri,  6 Mar 2026 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="MiD9fDeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E158B2BD5BF;
	Fri,  6 Mar 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772756684; cv=none; b=R+pFNLfNgQALdUHZmnnLFcNsKha9copUel2jBWFOE7UA7Sl9w5ZzjbeeG+hJS2+LshQX8WTW5NVTGYcnpjJ3hu3YWLRLwmcfYOZiopliyU51CLHCOhN0PP2FEAvucxarqVE7/AW1uFnTCUyUX4rxPJNpqIkvny2E91KmzaM9Puo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772756684; c=relaxed/simple;
	bh=RIPyD6aU0LIQ3AYqO9acD+5vBwVNWIvRydoT3iF2tWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGpTKN8Z9MHjsdvtfDjlRBoWTWmLkdJzo6mimb35DaM2tYZYNLN5yCRYR0jf/5mtuan6AaBe+a1gV8taWSMqQahI1KhLFLe8ENWHeaVY2I3a6nt3CF5WX509jpsneeL6dzQUR8LRp25/Tg/B1Aq37ObxH6DLYQfklCrfM6pEn/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=MiD9fDeb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1772756679;
	bh=RIPyD6aU0LIQ3AYqO9acD+5vBwVNWIvRydoT3iF2tWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MiD9fDeb6NCPYi/3+fd8iNmbv1sYJsVP13RLUBhbeqBsJm82gexpaaQ4Y8Wq4sPKh
	 IFcmc4NmuCfo4S/wTnc7jRbTuJyStJG8rAAEVa1nGPos63gm4nPuvVcB2lD47vSmQl
	 rhZVc9IPF7G9bMKc5tJJIWX5paTAv2bfYFL3PydNnT/LtmKQDEumaPhopeI2W/52AZ
	 1EzfpEXLd1+K8F+nOLxh8Nm3TFnCQCVxfht8C4RBzjRv4OOkqyOru7CUmDk3ImBsf8
	 /sJM8Wlxfw3fMfIJkCJic8fxGoOb5uE/0Uq8p47wC1hDw7uKKp7+X3FjekOK8ORKfv
	 N9+S8mnmJsGFA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4fRnGY5cdRz4wCp;
	Fri, 06 Mar 2026 11:24:37 +1100 (AEDT)
Message-ID: <d4307af1968ae729f4b937f88606c50d9a3d521c.camel@ozlabs.org>
Subject: Re: [PATCH] mctp: route: hold key->lock in
 mctp_flow_prepare_output()
From: Jeremy Kerr <jk@ozlabs.org>
To: Chengfeng Ye <dg573847474@gmail.com>, jk@codeconstruct.com.au, 
	matt@codeconstruct.com.au, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Mar 2026 08:24:36 +0800
In-Reply-To: <20260302174056.796540-1-dg573847474@gmail.com>
References: <20260302174056.796540-1-dg573847474@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CE79B219C60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ozlabs.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ozlabs.org:s=201707];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264598-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,codeconstruct.com.au,vger.kernel.org];
	DKIM_TRACE(0.00)[ozlabs.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@ozlabs.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ozlabs.org:dkim,ozlabs.org:mid]
X-Rspamd-Action: no action

Hi Chengfeng,

For v2 (as requested by Jakub), can you correct my email address? I'm
jk@, not jeremy@.

> mctp_flow_prepare_output() checks key->dev and may call
> mctp_dev_set_key(), but it does not hold key->lock while doing so.
>=20
> mctp_dev_set_key() and mctp_dev_release_key() are annotated with
> __must_hold(&key->lock), so key->dev access is intended to be
> serialized by key->lock. The mctp_sendmsg() transmit path reaches
> mctp_flow_prepare_output() via mctp_local_output() -> mctp_dst_output()
> without holding key->lock, so the check-and-set sequence is racy.

Good catch. I don't *think* we can hit this at present, as the key will
be unique over distinct sendmsg() calls, and the re-use of a key is all
sequential (ie., during fragmentation).

However, that may not always be the case, and we're currently violating
the __must_hold(key->lock) on mctp_dev_set_key() through this path. So
the addition of the lock here looks good.

One comment on the implementation:

> diff --git a/net/mctp/route.c b/net/mctp/route.c
> index 0381377ab760..4a1ac55ad31e 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -359,6 +359,7 @@ static void mctp_flow_prepare_output(struct sk_buff *=
skb, struct mctp_dev *dev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_sk_key *key;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_flow *flow;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long flags;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flow =3D skb_ext_find(skb=
, SKB_EXT_MCTP);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!flow)
> @@ -366,12 +367,17 @@ static void mctp_flow_prepare_output(struct sk_buff=
 *skb, struct mctp_dev *dev)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0key =3D flow->key;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0spin_lock_irqsave(&key->lock, =
flags);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (key->dev) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0WARN_ON(key->dev !=3D dev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0goto out_unlock;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

You could shift the mctp_dev_set_key() to an else block here, and avoid
the goto. Following that, it may be more readable if you invert the
logic (if (!key->dev) ...), but I will leave that as your call.

Cheers,


Jeremy

