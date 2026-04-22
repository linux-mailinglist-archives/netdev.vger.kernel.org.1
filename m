Return-Path: <netdev+bounces-280418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id C0hSHvfF6GnxQAIAu9opvQ
	(envelope-from <netdev+bounces-280418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6AA44654B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1855A3057632
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863673E95A3;
	Wed, 22 Apr 2026 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="MICorXxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DF3D1CD4
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862367; cv=pass; b=j6ArVrf5FHPOO+zIj/4KwWdeqG/XORjRWIeAFpgI9TV4cR5nc+6+V25G415CByplyuMJBTZWhUJBUySImEcNMqWlGw2NNH9IuY6n2Lic8UBSedEXz/7gfu7VZ5xcnNGEvkhy1PRMp1tpefq980som+PJHctgpTOLAc6K/3dwgDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862367; c=relaxed/simple;
	bh=m00J7dXJ/WIyvEhrJ8JX/+GFA6/blhnBsbcOzFRIKG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V83LUsE4laC6nr7ebcOgoH4qpq+xfrtCJj/gnWDE+CeQXEd9lUpmOz1F9jgONTin/e5PtRWkLYlNlKheRswPs2CcVtUwp8fAY2YTETcYCgGJlntzhFibH0+kJYskDxUEY7u1zRXliIM8PRL6aFKH1OzsY5At/WhbY3XD89tAJ1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=MICorXxW; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56a9c5cb48bso1906318e0c.0
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 05:52:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776862365; cv=none;
        d=google.com; s=arc-20240605;
        b=h2Rnm1BVMtC/Ho7+xHk93DtULJHfmzmzKeD2dvoMQFuRkMy7d2P9u0lrs8MK4xQa6t
         j/0k3xvvSFx+mCNtjo7WDJqnI8DX51AQsAfmkt9YRgoGSaKVvdFQyHucTo236wJMQKrd
         xB+YUzFRRRE1u28NdnqDqKM2zlbUAT3+sBFQIipifeDwTWojCgEidDa5eWHC8FtC3Fjs
         mkjyBM54ctoDTHR938RvFSUbvd3CB5e84VURbthIQHDXHVWBawI/0bvnjnEujdxYpfxL
         Xfiipf6NXB7IZTOBbBqDekoKHLFxlBUCQDJE5iyDm69+DfGOVGrHHy7lgakeZ91z5fQb
         PXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m00J7dXJ/WIyvEhrJ8JX/+GFA6/blhnBsbcOzFRIKG8=;
        fh=ARV2T8RUJkb6DPg6PGf2FwXQDkN7tNBRDW07vgyBVac=;
        b=eJcU1svAytYe+aDwj6RebSYdS1PmJcOSzFJw1pF1Uj5OjZFFT23id4xlPndcWrkC0z
         pqCBZBvgTI5JNIqrSqGbCtELPb9dVslz7+PIupGbrKs8naf1i9jRLHbFUtnw7TxK/6cI
         meZ0fKdnH+t7w/NB9bL3dY1nJPIR1lXCKPErk7VpiDGEuGBH05SQdUn+//fJWM+pEBWW
         XwYCqOPAqwtKQnveu0IDT/rSni5UGZ9AxMj27WY+LoY5GjMy/FkHn7gPxC8rPJvNubEc
         iM9JAV5h26avh7cDqocl/XZz+SX4NJIGdGFgQO6vNmx2T1uULTbJiVVh6Z/hHPX6JbH9
         UQvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1776862365; x=1777467165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m00J7dXJ/WIyvEhrJ8JX/+GFA6/blhnBsbcOzFRIKG8=;
        b=MICorXxWmMY1fQ6bRD0c4X/2iX8lX6S89/tjxDhQgQnQTQRPMatCeR1b3B9GOq4Da3
         g/0UnOAu575T2NNsVVKNirikrvyPaPf1WrcF6BVnIVpHlQH7pfHJUBRMrvV1Hps+YG+h
         I/OAERQPmDPsHxZxNobjNNZRsrJeqz89sbemE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776862365; x=1777467165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m00J7dXJ/WIyvEhrJ8JX/+GFA6/blhnBsbcOzFRIKG8=;
        b=YkQhlFyI8Yvjwh4y7RyBisozJkt4lwslHspgsQJfmVoTx97E8ydupaGj57nadPHpLo
         o491IL7CLqa1BvwjPwoGKd0NjmrRMOq9XmY187TM26DZ4D6/PvXpxwcMRcMZRqI1jl50
         0EUmZJknrRphCEHvDxmgoSGeaDvftJwExfSZpURMrxU/oeqZ9m7wgc6bT27yCUdBoHBl
         ikrdPbSDOzoDl08hTEEgY9/eYK2EU9VM6KfF5GKEX1ToKO5HmYfEu79sbY0M1zry5fKd
         15yuLaSuddCHN4dhYz2TM6vAYZcvqy5rG+KR1MkRdPUNfznQzwgRd7/w2Q5rNiHFccAG
         I16Q==
X-Forwarded-Encrypted: i=1; AFNElJ9CEi51g+uy3zrU7+YEY+BXjS8lxhWxyRjcj7t5kvKHYsYDRf2CkBc800048XF7qCm+50GcrJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ERqQU2H2zExaVxFNA94vzPhchoB2uIGRjEphIZA3qsAcy+XB
	DhOP7OGRIYAoDQROGmZXOoOfgkmDY/OwU28sjx5NTN8Q167MEpkgNpVoyy12zeUSAyWd9uKn6Jy
	inweArVoZKZHTXgv+1C87jD4bMXmDH7orkV+G6VWhuw==
X-Gm-Gg: AeBDiesQA0PD42ICQO5AK+OLSgp3LuMxcBKVjdD+WYxyOx0NGn0DFzDfeve+ZRrg/DE
	gMZsQI1NwX+Fm7J7GqUtXUznHJ372y6gXav8uw1MdpLp0G/3y0PJqab3YUBWWc/W6z6amTjFo1r
	QAOt0VDalFlvL6Be24WTBRmWJVnNjNM/Uym8RwcVDFvCPi/9BQlML/FwUVGuAg1ZjUxek99Fs0B
	ClLWdXL4FCtn4HBOrHSy94B6LlIKUBSC9rKIrP9nc9PwjYhc2JPlqsjieP3GmPpGBMqQAWwBssC
	Fj8pRVGCXtCaiw3AAEg=
X-Received: by 2002:a05:6122:8d3:b0:56e:eafe:3bdb with SMTP id
 71dfb90a1353d-56fa59844b5mr10223635e0c.10.1776862365120; Wed, 22 Apr 2026
 05:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422003206.1017863-1-anderson@allelesecurity.com> <2475724.1776861474@warthog.procyon.org.uk>
In-Reply-To: <2475724.1776861474@warthog.procyon.org.uk>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Wed, 22 Apr 2026 09:52:34 -0300
X-Gm-Features: AQROBzCkDyEis_AMAf1anRy1QoMzs15DhFTMqlK1dWq00uaZfHvcuxQPK16Yfp4
Message-ID: <CAPhRvky1Dfy-y1UyLnonYnw+Y6qof_Y_OG2vUh-4539-H1hzuQ@mail.gmail.com>
Subject: Re: [PATCH] rxrpc: fix missing validation of ticket length in
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Steve Dickson <steved@redhat.com>, linux-afs@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[allelesecurity.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[allelesecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280418-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[allelesecurity.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anderson@allelesecurity.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,allelesecurity.com:dkim,allelesecurity.com:url]
X-Rspamd-Queue-Id: 1B6AA44654B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 9:38=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> > Subject: [PATCH] rxrpc: fix missing validation of ticket length in
>
> ...in rxrpc_preparse(), I presume?
>

In fact it was "non-XDR key preparsing", but "in rxrpc_preparse()" also wor=
ks.

> David
>

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

