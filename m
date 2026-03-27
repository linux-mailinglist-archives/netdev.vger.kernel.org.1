Return-Path: <netdev+bounces-272354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGxxCJX5xWmOEwUAu9opvQ
	(envelope-from <netdev+bounces-272354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46433ECD9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 04:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 001013011589
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 03:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F208357A4A;
	Fri, 27 Mar 2026 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDFVwvBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E32D1913;
	Fri, 27 Mar 2026 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582160; cv=none; b=Mjvw794sbZ0RvTHdyzwqioM2LMJsIj0O7OT128No5+TEdfgzJQTyHxBbp3mqWC8VapMFKNoVgTu4roKBa1JaemJBzJh+D0LZ6IwHxkngsf0huL/OlKmjTAnBu+r4xYPagotHrWH7/w4GR3tPvrQcQGs+p095EVGJjwaDsb0bWPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582160; c=relaxed/simple;
	bh=2Vm2O22HGQulWv9xpPzIAgsaqExsvAxivcOhewsMBPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj51qTfqPQ8MS3CEj+PSsignUmitiImlqOOTutw8pLDMtLWhJlxhXDu2YWbAxrPbkwaVvN2ovYsaz56tNOa6AeGQZK1iRMnnc/leQ/PYAMvzn0A0J6bKcrFp+sgZ7HBH6DoyHqT7G2itLdDUhfgcSe4UdhcnEjcCOrYab2V01Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDFVwvBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AA8C116C6;
	Fri, 27 Mar 2026 03:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774582159;
	bh=2Vm2O22HGQulWv9xpPzIAgsaqExsvAxivcOhewsMBPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JDFVwvBK9i0H4m4qyPasfCzsQHPqFgL6cG1XV+1eQvJcYih65OPycCtQe13RC5A2r
	 hOlY6KFwrpZ+2lAwUXANj4dFTRyFCpE1HIlUEIlbWttHNHH55Y6acW5DJL6zJWe5ZU
	 pER7Xnh7ByNO5uNDzc+SjJ+am9AiJAftoyGiWJ3z2D3+SUYCcsBd5aUZEwEC9e5fVn
	 k/kvfHSkqUecEbFmvWACamJt090kYeEe3ecfAMtWw6flixur4G0uj78VLtOb2pZuwH
	 lW21su8dwaYww3E7ef/rA0RZ15cYhjChHnYEa2ED7T9DPrKeFmzIK34xAhlZyrWFZF
	 U/MbcPq1OMb2Q==
Date: Thu, 26 Mar 2026 20:29:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, Di Zhu <zhud@hygon.cn>, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, willemb@google.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, lijing@hygon.cn,
 yingzhiwei@hygon.cn
Subject: Re: [PATCH net-next v4] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Message-ID: <20260326202918.07925cf0@kernel.org>
In-Reply-To: <CACGkMEshcxj-R1Ek1dRykBTQ6NLS11jt-9NAu8PbcmtzobRY0g@mail.gmail.com>
References: <20260323041730.986351-1-zhud@hygon.cn>
	<20260326200346.438702a6@kernel.org>
	<CACGkMEshcxj-R1Ek1dRykBTQ6NLS11jt-9NAu8PbcmtzobRY0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D46433ECD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 11:22:43 +0800 Jason Wang wrote:
> On Fri, Mar 27, 2026 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Mon, 23 Mar 2026 12:17:30 +0800 Di Zhu wrote: =20
> > > Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> > > allows control over offload support, but the offloads that can be
> > > controlled may have nothing to do with GRO (e.g., if neither GUEST_TS=
O4
> > > nor GUEST_TSO6 is supported).
> > >
> > > In such a setup, reporting NETIF_F_GRO_HW as available for the device
> > > is too optimistic and misleading to the user.
> > >
> > > Improve the situation by masking off NETIF_F_GRO_HW unless the device
> > > possesses actual GRO-related offload capabilities. Out of an abundance
> > > of caution, this does not change the current behaviour for hardware w=
ith
> > > just v6 or just v4 GRO: current interfaces do not allow distinguishing
> > > between v6/v4 GRO, so we can't expose them to userspace precisely. =20
> >
> > Michael, Jason, does this patch look good now?
> >
> > https://lore.kernel.org/all/20260323041730.986351-1-zhud@hygon.cn/
> > =20
>=20
> Yes, I've acked.

Obrigado!

