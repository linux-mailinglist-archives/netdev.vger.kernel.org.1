Return-Path: <netdev+bounces-255970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHcfCGbigGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:44:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7729FCFB98
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6577F302BDC3
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E2F3816E9;
	Mon,  2 Feb 2026 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9l/AZ01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69060387349
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054039; cv=none; b=eavWVYAzZNWDoUx+9xc2U0qWza9O+DnYORbcLWv5C//DSxedKlzTgtqM96GR0eRvmjbyVt/6G7AYMXXaxvx/nWISWgaLt7cIc/7nqJF/oJfcf85c2HJAPxpk9mKeW0Etdo8SxGOBz+JRoxoDgCikq17+/NUB3T+BwUGdOdMU2YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054039; c=relaxed/simple;
	bh=VRCx+c4hexJbmDKx+kICIYWJ1xdiJDc4rP2eOiSEuIU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RetnnxWiijBWrseZxt8GhVznr/FBLci/pRUMXVM26R/+FqZDMFGR6osgd2UFLw/gZZ3jkPGDZA9Rc8H4yxHFMhRrX2nVFRMxLujO0IIIJw2qGoB76h7PIwmwZEzec25j2/fo+XC7dYssVT+N0t8EeA5rfoeTvKTY9ZwvLPeHofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9l/AZ01; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649b22e5894so2689643d50.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770054037; x=1770658837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr0owY/HcJsxUU3YNVxCg49UjG1nqp/rA/XqNsApWS4=;
        b=G9l/AZ01uvaKzqM0spB9OptqzXa+8ThWKUTl5XOLCsTKZYifw/CugJmz18t52q9IGT
         B4KlSCY6qw9cx19sI4qLYLzUnRpbcCf5FgVA1ZTYbVWXNiwSNog/kRZiCyvxeEadtzbf
         YOTB5svihQLMBD+ufSXOjEIzp8rrmWFO/sAFCOstqIw6a3/vyMzw2jJtMf+oDqoIe/zU
         gPn7QaigeC6bjXJhRo6CmNjg7undpOmZG/+JicmFTXn77FRYtT9AvcKT3Ybpl4DYPK9W
         vd75XpSrsZudDOE9SFTITzzwIEXyfw7juZr9XW6nNiaGVuiyqnNPYB3g4V684mJpTQtx
         X6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054037; x=1770658837;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lr0owY/HcJsxUU3YNVxCg49UjG1nqp/rA/XqNsApWS4=;
        b=bsEb16YXe8nVbFUlUXY3vctrvkVBXgzQqTjrD1JPvo/s4RrGLhZe1arvAmzoy6TY5h
         Pt4J3Hg/GlHNV3eJDbbxOhzXgmUZZBAVeO9DG86DmY5pibv6LiavXx5rS4vkFK+/k9FB
         dLcLxzGMIQsrC8e7+sI3VE/wUAIk0pz5KQkIGdyh8lAG5iVufMWmTWmOvDuneunvl41b
         DsDotWnI8kshcfiXtqm7ymoRuUTfT15it9Cy/GsiZ3YondkQWOSDDwJGZ9aTVmwiAexX
         1oa3pr1XEZdcTNmOjQVKarwEBZIpCDyptsjphXxyfZB9MZZ/bRbiyeqSwpzyTs33neST
         Sxqg==
X-Forwarded-Encrypted: i=1; AJvYcCWueyhksRtLFrLrSwB7kX3m10PgLe0ActJtDD0zJkJEH7MNr890kLo0rh7mYCn/UvZnblBGFsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIBrdeW5nLpPkRN4QAh6/JC3lS9dwUugXxeeyLdAERGHicwmT
	Im3TQdLgmibSUZCJ+XMDvB/FhFEct4py13EDrrbfsh/WurLw8skWBblz
X-Gm-Gg: AZuq6aJhjMHOS417ytOtd2HWlhF9qeYaYzjvQCXZvCGIlawFlWto7htVN/nk7ltNFOx
	PhRtq2JZpajGbqciefqT/OFdpDgxJnpAxrDwkqJxrFgrRq5qBv1jgRqirkM4UFS8ri4L15bvQ39
	KmF0/RCs1MqfSRq6cx65RaJ/WjlkNJHPMuYCABoejGSJo6Xf4Q4Fy6MBqm2CNDObg7T3sQFdEGo
	cqssuBtWk0647o1jgqCWNXUsZRJJRsZVI3Xfq1ckikOUI5IEYVpjqmL4/6Tkp6nUB7oV+0RlJPR
	z2c3OtlxHdIAwnnvLLw0DRfAopnFKwaOyN+i7B2Bo2Oz8VwfcBINMkE3Zqekbm0zIyTgjPEP5bV
	0M2Vp1ttJglF21sVoDe5PYws2E+S0IFOx1eyCuYColdoEOVmaWRkCD0QTjzT1qZBHZdWKrh+fEJ
	wyfQzyMJ05u624oj1cswUr32XhrBdXelSvcNJ9nCjF1bZWttSw7Jzj1NYeLuw=
X-Received: by 2002:a05:690e:c49:b0:649:66c5:74ec with SMTP id 956f58d0204a3-649a849ef90mr9532381d50.56.1770054037437;
        Mon, 02 Feb 2026 09:40:37 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64996063a24sm9718869d50.5.2026.02.02.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 09:40:36 -0800 (PST)
Date: Mon, 02 Feb 2026 12:40:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.16b0979449c84@gmail.com>
In-Reply-To: <20260202025322-mutt-send-email-mst@kernel.org>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <willemdebruijn.kernel.37516e24f10fa@gmail.com>
 <20260202025322-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255970-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7729FCFB98
X-Rspamd-Action: no action

Michael S. Tsirkin wrote:
> On Sun, Feb 01, 2026 at 04:05:54PM -0500, Willem de Bruijn wrote:
> > Steffen Trumtrar wrote:
> > > Add optional hardware rx timestamp offload for virtio-net.
> > > 
> > > Introduce virtio feature VIRTIO_NET_F_TSTAMP. If negotiated, the
> > > virtio-net header is expanded with room for a timestamp.
> > > 
> > > To get and set the hwtstamp the functions ndo_hwtstamp_set/get need
> > > to be implemented. This allows filtering the packets and only time stamp
> > > the packets where the filter matches. This way, the timestamping can
> > > be en/disabled at runtime.
> > > 
> > > Tested:
> > >   guest: ./timestamping eth0 \
> > >           SOF_TIMESTAMPING_RAW_HARDWARE \
> > >           SOF_TIMESTAMPING_RX_HARDWARE
> > >   host: nc -4 -u 192.168.1.1 319
> > > 
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

> > > @@ -475,6 +478,8 @@ struct virtnet_info {
> > >  
> > >  	struct control_buf *ctrl;
> > >  
> > > +	struct kernel_hwtstamp_config tstamp_config;
> > > +
> > >  	/* Ethtool settings */
> > >  	u8 duplex;
> > >  	u32 speed;
> > > @@ -511,6 +516,7 @@ struct virtio_net_common_hdr {
> > >  		struct virtio_net_hdr_mrg_rxbuf	mrg_hdr;
> > >  		struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > >  		struct virtio_net_hdr_v1_hash_tunnel tnl_hdr;
> > > +		struct virtio_net_hdr_v1_hash_tunnel_ts ts_hdr;
> > 
> > Jason, Michael: creating a new struct for every field is not very
> > elegant. Is it time to find a more forward looking approach to
> > expanding with new fields? Like a TLV, or how netlink structs like
> > tcp_info are extended with support for legacy users that only use
> > a truncated struct?
> 
> I certainly wouldn't mind, though I suspect tlv is too complex as
> hardware implementations can't efficiently follow linked lists.  I'll
> try to ping some hardware designers for what works well for offloads.

Great thanks.

Agreed that TLV was probably the wrong suggestion.

We can definitely have a required order of fields. My initial thought
is as said like many user/kernel structures: where both sides agree on
the basic order of the struct, and pass along the length, so that they
agree only to process the min of both their supported lengths. New
fields are added at the tail of the struct. See for instance getsockopt
TCP_INFO.

