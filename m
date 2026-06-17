Return-Path: <netdev+bounces-300117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pZ10Jyp2MmpU0QUAu9opvQ
	(envelope-from <netdev+bounces-300117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:25:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 210AF698735
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:25:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=m8I2x0be;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300117-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300117-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3273431E417B
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521E43F165C;
	Wed, 17 Jun 2026 10:19:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785F3F39D1
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:19:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691591; cv=pass; b=kF7kX6se7CviMmY/3Y2IJAmeEagZE+FXSj/RaYL7TW1r57/WIgkolFbx2ZnhYgnM+YiXdqAZwrd/++WnGnFj6mmIH4eQNZxfAg9ZebYV3bWqcevEvmngSqMFBQ1BtQsdZxAMTiMflDjpdXehCppnL1vwsYVlaQ5o+Z4UXObiN/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691591; c=relaxed/simple;
	bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwplvEB6Mf0khTNJC1UP8zmzs64nHjRfic0ZvZPThql16s/BbTMaQcQHg19eWeA2A3nz7/Zq2TPB4jl99Rf7134o0rtlrrWhO3t2Qp8PjgybtCEAhwIkEakYyA0juHgTPytlV48zJJ4wABu6RwAzD0evvN3rBkVX/iB7qHZFt2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8I2x0be; arc=pass smtp.client-ip=209.85.167.53
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ad4c0c94fbso130399e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781691584; cv=none;
        d=google.com; s=arc-20240605;
        b=gao605ikTLtzbEXXhl6inNPYnR/dzH2sseTjRMQIxZKGeAGNQNXwPE+/poG9xWYd0Y
         URRJUOQs81L9uw8k9tfXA4SOmdyP9UueREGSwnVYfoOFRCKWSjJ1HoaAuvJeU0nlwExp
         XExUcUmmZbf/ClRcUyKEEMZkAgpuhv+VJog3LWNjv51ZYw1iNyTD5ryC10g1D/m0wHWp
         0u9ZOg8kwX7YOS8PQMzNOmWDYlpGyQOL6qCEQ26aBETwtHXb4K0diw0lCr3Xdq7YVEk/
         tPCI83/QSzxOxCeP4sK4X8jWDCu5ezutguG9ZDp+7Xryqz+m0xy5qnRop3rta2on9b8M
         6lyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        fh=/YGzQRnVAlYrpD5/Buw0RZ+pkmmPzRUpYkhDYAIguf8=;
        b=A+MhxRYRtE1+Htz9gFmvtWH2PArZD9EzrpMagl1bx93ksGhqKwr13JDfCL21vGpoK5
         xr6EE/5nHkykhpgUi3ZM5623V5CL/D/MOP3HRlCi3YjvpA5/X3BhUR+QAlHY7eS5gqKs
         PDfsCI+rL2kh3raLEjMWE9CoI1eU3C9D3zhgUhsCUuW472spiUbie0De3i6uiYXExffs
         9ZFtHi1nmdu+iBpYFn47lhf/6AmQAqy/IEbKoSE4NUvSc1GIkph3lgR7bCGcKGkaBmab
         Zx+TAO4Gq5Zk/6V+tk9DncKy+wGVRKRzWpxIWtiAEy2OrPLoNAd5uyXOID80lyDOsUvh
         hazA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781691584; x=1782296384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        b=m8I2x0beRrfR12co+e+px7vvMJ9czl1/uz3hO2DUXg4V63FWr/bkrD2yJPMvo2KjBI
         jBcBJc1DWL9AOcQ7sPZEYtRPMFgcA1xVL6jyqp3rbr7dFSvMr7DzfjPg63c1NQNBLPt/
         mE6dxI3I5fxSfxdmibcV7pefz4Pk28xTKRZQSxG2U1bpFZUTUrZwjJcUkBRAk/O8UFVg
         JpqWATDcRpqRPdhXq1X3TTKzLlfFjf0h1tGqKZY7wU8dg62iJRUfY3N6vqKKS8xyaD/H
         nRKFGtY6Il2ZJPIky23EMUAoS8KOBDzHwH3ndQSI5Egsw5WYarRSNrDGim9jX4JAx8cp
         ZdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691584; x=1782296384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7k6CH9rIvY0L2Y+6cbDTkLW/YZqZpxLNzTHCwn1xCXQ=;
        b=YK8SQfRBRHRbbAUF8lJDyF6vvYZ5mtMdIFq0KD0GTLOX/asIoD/FDPc5N6haXfNttM
         cv7VbWHAIO4GdkdI7vQYjLesen2rr4T5fV9vtRr9cVpMz+3DYERSpHMqpJra7Dr3j9W/
         YtdT3uSWYvC8FFcKIcmetsyRsJkyKQCMdProu5cW5Jl2wJMXqI9nUnQNtOej5/ZnxtXU
         w3X5tLIo+N3A4n5ZHo2N7CsAppnyI7gg+JwJ9afGg1gafG6OebOY1ZOBN8+9mMzICzOj
         R8dzPq7adhuwoGC82VLQCsGxi+ChYv41iFiEe09sznTfLN7Gg4zRja7awAd1KoFVlT4x
         REgA==
X-Forwarded-Encrypted: i=1; AFNElJ9F31zjUSqI0WR1iNE9vHXc4eSRfo9GcPa2oyWyZznXBpRFvmIHe2nwWXpzfxm52PKTaGh4yMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygVr1nWzzCaOXTpGwmCA6v1pWxzJ6Fhyt+aKZEZHsj25BEqNNf
	iRCdgi2IdX12PrTwnN1y3aeVtZMwd8rNz1uEgoWr8XJrtniWz/TpY2cPE90a51Z4CtveBImkR8v
	jJH2RHWLmRVwv6VTg4W6mdiIk4NHxpM8=
X-Gm-Gg: AfdE7cnYH9/hLpNx6HIagtH8XE2+SV6VfkglgrujjHIeykR6bDcgW2jvxn1rjO+tg31
	RXdltcQkAdU+qOpRkuWlxe2wor81frBPoYdD9jvbH28XVy0v0EAK8Xe0HrOhARkmzPWawmRFO65
	4JAOc9faOrkVsg/w0DXnXCRWd+WXPIDttOvNWNj/gdzffUQuewX1/tC3oGs2sNaIlAWIkVdySV8
	td6Hfd4anvkj0VnvaBJgDkmzHYDkfleNzN6qHun1pYrx0McFnQOeHVjsLIC8L9RECGEi4fPJks3
	8SazFGYYGFUpQFvupt0MRKrglq+cQktR4SimKSo/Bd38XZUgNZzPE/Y9xtNhpj3me9go4FfuWzb
	isalPHGek1kg=
X-Received: by 2002:a05:6512:1c8:b0:5a8:86a6:c476 with SMTP id
 2adb3069b0e04-5ad470467a4mr663270e87.37.1781691584047; Wed, 17 Jun 2026
 03:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn> <20260613112113.55d9313f@kernel.org>
 <TYn10tJ2SIGF1pAhF26DRQ@linux.dev> <ajJrckiXEUztBQDz@boxer>
In-Reply-To: <ajJrckiXEUztBQDz@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 17 Jun 2026 18:19:06 +0800
X-Gm-Features: AVVi8Ccr6U6gFua-s95uJJAy8Eyxi9pGTjbRb0f81lrrSkjCY3B3t1Mt-CCv8VE
Message-ID: <CAL+tcoCcrJdynuBqrntDGK_OMSkKkQB9XeoUAC5ig-1_mVjaeQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, menglong8.dong@gmail.com, 
	Jakub Kicinski <kuba@kernel.org>, jasowang@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bjorn@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:menglong.dong@linux.dev,m:menglong8.dong@gmail.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,intel.com,fomichev.me,iogearbox.net,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 210AF698735

On Wed, Jun 17, 2026 at 5:40=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> > On 2026/6/14 02:21, Jakub Kicinski wrote:
> > > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> > > > For now, we use sk_busy_loop() for both rx and tx path. The sk_busy=
_loop()
> > > > will call napi_busy_loop() for the specified napi_id. However, some
> > > > nic drivers have tx napi, such as virtio-net. In this case, sk_busy=
_loop()
> > > > doesn't work, as it can only schedule the NAPI for the rx queue.
> > > >
> > > > Therefore, introduce sk_tx_busy_loop() for the nic drivers that sup=
port tx
> > > > napi, which will schedule the tx napi if available.
> > >
> > > First, I thought the only difference with Tx NAPI is that it can't be
> > > busy polled. So if you want to poll an instance don't register it as
> > > a Tx one instead of adding all this "tx polling" stuff in the core?
> >
> > I see. Register the tx NAPI with netif_napi_add_config() allow us
> > busy poll it. But we still have two NAPI instance: rx NAPI and tx NAPI.
> > sk_busy_loop() can only busy poll on one of them.
> >
> > Before AF_XDP, we don't have the need to send packet via tx NAPI, which
> > means that we don't need to busy poll it.
> >
> > I analyst some nic drivers on the implement of AF_XDP. Some of them
> > will check xsk tx ring of current queue and send the data in it in the
> > rx NAPI, such as mlx5. Some of them will allocate a extra "rxtx" NAPI
> > for the AF_XDP zero-copy queue, which will poll both the data receiving
> > and sending.
> >
> > In the case about, they will do the data sending and receiving for the
> > AF_XDP in a single NAPI instance.
> >
> > However, some driver receiving the data in rx NAPI and send data in
> > tx NAPI for AF_XDP. In this case, we can't use sk_busy_loop() for both
> > rx path and tx path, as we need to wake different NAPI instance.
> >
> > >
> > > Second, can this problem happen for any other NIC or is it purely
> > > an artifact of virtio's delayed Tx completion handling?
> >
> > According to my analysis, only virtio-net and ICSSG driver have
> > split NAPI for AF_XDP. I don't have a ICSSG nic, but the codex tell
> > me that it does have the same problem.
> >
> > I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
> > Maybe we can modify the driver instead by using the same NAPI
> > for both data sending and receiving, just like others do. The
> > advantage of introduce sk_tx_busy_loop() is that we can split the
> > data sending and receiving, which maybe more efficient.
>
> Would be good if you back your changes by any performance numbers. I
> believe that drivers do tx processing via rx napi as before AF_XDP it was
> only about cleaning up writebacks, AF_XDP added more weight via actual tx
> descriptors submission.
>
> Maybe you can vibe-code virtio-net to work only with rx napi and see what
> are the results.
>
> Side note/question - Do you have a tx-only use case for AF_XDP ? I am
> planning (for a long time actually) to implement asymmetric AF_XDP
> sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
> queues even when you do rx or tx only.

As far as I know, since I use TCP as the userspace protocol, I don't
have any idea on how we can apply this. It seems you've got the
requirement in the real world? Interesting.

Thanks,
Jason

>
> >
> > >
> > > Third, this series does not apply.
> >
> > Ah, I'll rebase this series if a V2 is acceptable.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > >
> >
> >
> >
> >

