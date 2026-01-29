Return-Path: <netdev+bounces-254764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCPsLDZBe2nECwIAu9opvQ
	(envelope-from <netdev+bounces-254764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:15:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC05AF827
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 923F7300F685
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C62381700;
	Thu, 29 Jan 2026 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gFMwlE0H"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D93859F4;
	Thu, 29 Jan 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685142; cv=none; b=Eaekjv/Ri+158HePSWBCGP9+WRD3LkiX/XPlqeIS4dPjPRt7kdkcFQQx03kaQ/Yklt8jOR2AWYwYtQIg9DO58wYgPkq1fFDH6yvKxXQUuKzjrZ45ULi0Oytsew8eFBOkGM+b6V1M+OERV37Sck045lKMuOf2HVlwHELQlyxWn0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685142; c=relaxed/simple;
	bh=WkAg+DQRNVI7tJ7g9umIgS0rIdaTcjXYEshkGDsAhzU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Lp95RDkpIPPNKAj/mi8xy7DgoMKcDxGMlBRjf7AE9vbWQR8BlTlmhn+hOA76E0OM4cel5JccviU9udv1/Fn5os/zrjRyaRDCcb1xJM6lugyK4SKyK70tvz9LS2pMOQxz0nFk6uzCZfCgggDhnlJjAmSmVnAvWxY7u4eBxP6V4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gFMwlE0H; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769685131; h=Message-ID:Subject:Date:From:To;
	bh=c+Gq2aLJ72NvCATpEEA0htSSDWqZ+7d6i33HsHlh7uU=;
	b=gFMwlE0H+olpZKYztSHGUNYji69dm444Y2kLnXrU2tREzIk0Drvtm4DiFU/GgvQX1l42E1dKTfSa/oO0s5zRlUlBMZJF8nDz7CsThmfT95qIIy3vzsAt2IRpVAm9gFPWQMNQrepmkpE4t/boxBh8Kqv2Y7miEfwfEjXOIylnWK8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wy7Eiug_1769685130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 19:12:11 +0800
Message-ID: <1769684595.7934678-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Date: Thu, 29 Jan 2026 19:03:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <1769680105.7884188-1-xuanzhuo@linux.alibaba.com>
 <87343og290.fsf@pengutronix.de>
In-Reply-To: <87343og290.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254764-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,pengutronix.de:url,pengutronix.de:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEC05AF827
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 11:08:27 +0100, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
>
> Hi,
>
> On 2026-01-29 at 17:48 +08, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Since patch #1 used this struct, this one should be placed first in the series.
>
> oh, you are right, the order should be the other way around.
>
> > Also, has the virtio specification process accepted such a draft proposal?
>
> I haven't sent the draft yet, because I'm unsure if I understood the way this should be implemented with the flow filter correctly.
> If the direction is correct, I'd try and get the specification process going again.
> (That is not that easy, if you're not used to it and not that deep into the whole virtio universe ;))


There have been many historical attempts in this area- you may want to take a
look first.

Thanks.

>
>
> Best regards,
> Steffen
>
> --
> Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
> Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

