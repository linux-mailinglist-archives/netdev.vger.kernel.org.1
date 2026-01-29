Return-Path: <netdev+bounces-254682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PDoAL8xe2kVCQIAu9opvQ
	(envelope-from <netdev+bounces-254682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:09:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 736ECAE679
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF6B53030EEA
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8B3806CA;
	Thu, 29 Jan 2026 10:08:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6C937D101
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681323; cv=none; b=neebpQG7bpTNhVWRIBVJJl06csZQjPJid4GadlSlH77i2T4VXn0CTzJn0ceIG0vCFHrMuJnWtikUSqdUe00i0EJJ/N32EKC0+PVHEzzFxw3C2Tz3z+8ocPL/jMNIzWLoKzDKru+IpKsWCPdO6JIHt7PoiiknRmtbyT/8xW0ALms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681323; c=relaxed/simple;
	bh=8FQ3eXMoKRfKukRRuRLHfLBjErZPj3GI8f4M3mmw9oI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rja+N0UZ0pVnE7a4OMZZMNySnso+G3H+U+/09hmve1Ge0OzIYj1EzYrURQeS5n4YO5IjgLNd3SU43uffTNBe4cfhHD7qG/KANsGeD/AkGiXStskP4BjynbrLnXg/IFI0TkATt3Bg0Gax5HI+3Z5+cWUrizzXk4o/c6v1AvyrE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vlOww-0003ME-4l; Thu, 29 Jan 2026 11:08:30 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  "Michael S. Tsirkin" <mst@redhat.com>,
  Jason Wang <jasowang@redhat.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Richard
 Cochran <richardcochran@gmail.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
In-Reply-To: <1769680105.7884188-1-xuanzhuo@linux.alibaba.com> (Xuan Zhuo's
	message of "Thu, 29 Jan 2026 17:48:25 +0800")
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
	<20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
	<1769680105.7884188-1-xuanzhuo@linux.alibaba.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Thu, 29 Jan 2026 11:08:27 +0100
Message-ID: <87343og290.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254682-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.trumtrar@pengutronix.de,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.828];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 736ECAE679
X-Rspamd-Action: no action


Hi,

On 2026-01-29 at 17:48 +08, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> 
> Since patch #1 used this struct, this one should be placed first in the series.

oh, you are right, the order should be the other way around.

> Also, has the virtio specification process accepted such a draft proposal?

I haven't sent the draft yet, because I'm unsure if I understood the way this should be implemented with the flow filter correctly.
If the direction is correct, I'd try and get the specification process going again.
(That is not that easy, if you're not used to it and not that deep into the whole virtio universe ;))


Best regards,
Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

