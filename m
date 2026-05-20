Return-Path: <netdev+bounces-289936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKzeCROrDWox1QUAu9opvQ
	(envelope-from <netdev+bounces-289936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:37:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C41058DD1F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 160BB309C264
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E933DDDCB;
	Wed, 20 May 2026 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0HBZXtz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725A13A86C
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280279; cv=none; b=FaJLow1zWp3sVabQrVA4gCnztduxfllBkeFYTFgC3UFxJQYbJwRSX0NyXF3krMbSbSlIaogbP4nAsUoZw5iUJHl11vXy4daMw2sXUfZcihwQi41TEDF5/dG1eoDvW1i6nOm938rhynT5LppeWMp4IiAUKaAjg9GAUqe5HK5GkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280279; c=relaxed/simple;
	bh=7gAk2JTKbsfJYuia6suT6lU9Gcv0TRau2aV5ozbZXCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnMunmWRDqNtAQCqHBDtAvcAcFqOy+6MRN1/gpc2NLd5DV5KGVuF9UHltiJTrIMxm+VsmE3OkFhtX0A9eE76dwGEVJPtcu1u9mnc8iOHVF6+2RjwRAAkT2wGj9sGZudkEjkhPKvdHK0k/kaNipo55BPo2t04vN/196Im3/UET2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b0HBZXtz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779280277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CB/Z4bzbsyrd+gSXXFc5hMEcaetYVQ+7kd0CfM+SH9M=;
	b=b0HBZXtzb8hjap4X+k/bAjl+jgzpiIu9yDYDgYHRQVFFEJSXpnuG6PvxoUP/Cwl3ZlkhVj
	l0IUVGRpYcD8v7zp2iMG0Ah0NAU5Vm1/ZxQhqFju4WawgaM+ufs0BPu0FCvDqEdnEpBupg
	wWh0Bu5ImK08rSJPmftQdIKoQFaiSTc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-OFz8t6rZN3-_6eMhLI993A-1; Wed,
 20 May 2026 08:31:13 -0400
X-MC-Unique: OFz8t6rZN3-_6eMhLI993A-1
X-Mimecast-MFC-AGG-ID: OFz8t6rZN3-_6eMhLI993A_1779280271
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3E3A1956096;
	Wed, 20 May 2026 12:31:09 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 271F01800465;
	Wed, 20 May 2026 12:31:03 +0000 (UTC)
Date: Wed, 20 May 2026 14:31:00 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Meghana Malladi <m-malladi@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	David Carlier <devnexen@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kevin Hao <haokexin@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 2/2] net: ti: icssg: Add HSR and LRE PA
 statistics
Message-ID: <ag2phK4k7PuyBo5B@thinkpad>
References: <20260514075605.850674-1-danishanwar@ti.com>
 <20260514075605.850674-3-danishanwar@ti.com>
 <20260518184506.694c584e@kernel.org>
 <E30AAC96-01D2-4A23-B562-126087DEB7FA@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E30AAC96-01D2-4A23-B562-126087DEB7FA@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289936-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,ti.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,intel.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mibbrowser.online:url]
X-Rspamd-Queue-Id: 9C41058DD1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

On Tue, May 19, 2026 at 07:55:55AM +0200, Luka Gejak wrote:
> On May 19, 2026 3:45:06 AM GMT+02:00, Jakub Kicinski <kuba@kernel.org> wrote:
> >On Thu, 14 May 2026 13:26:05 +0530 MD Danish Anwar wrote:
> >> Add new firmware PA statistics counters for HSR and LRE to the ethtool
> >> statistics exposed by the ICSSG driver.
> >>
> >> New statistics added:
> >>  - FW_HSR_FWD_CHECK_FAIL_DROP: Packets dropped on the HSR forwarding path
> >>  - FW_HSR_HE_CHECK_FAIL_DROP: Packets dropped on the HSR host egress path
> >>  - FW_HSR_SKIP_HOST_DUP_DISCARD_FRAMES: Frames with duplicate discard
> >>    skipped
> >>  - FW_LRE_CNT_UNIQUE/DUPLICATE/MULTIPLE_RX: LRE duplicate detection
> >>    counters
> >>  - FW_LRE_CNT_RX/TX: LRE per-port frame counters
> >>  - FW_LRE_CNT_OWN_RX: Own HSR tagged frames received
> >>  - FW_LRE_CNT_ERRWRONGLAN: Frames with wrong LAN identifier (PRP)
> >>
> >> Document the new HSR/LRE statistics in icssg_prueth.rst.
> >
> >To an untrained eye these stats look like stuff that could
> >be standardized across drivers.
> >
> >Luka, Felix, others on CC, do you think we should expose these
> >from HSR over netlink as "standard" offload stats different drivers
> >can plug into or not worth it?
>
> Hi Jakub,
> I think there is a case for standardizing part of this, but I would
> not standardize the whole set as-is.
>
> The LRE counters look generic enough to me, especially:
>  - unique rx
>  - duplicate rx
>  - multiple rx
>  - rx / tx
>  - own rx
>  - wrong LAN, PRP only

I'm very much in favor of having standardized stats for hsr hardware
offloads that the drivers can supply. The list above looks about right,
I'd add "frames with errors" and "(proxy) node table entry count" as
well and that "own rx" is HSR only.

In general, I don't think we need to standardize this ourselves but can
adapt to the counters that the SNMP MIB for IEC 62439-3 [1] already has.
It's part of the standard and IMHO we should gather these counters from
offloads (and later supply the same set from our sw implementation, but
the current netlink interface for hsr is quite messy). For reference,
the list in the MIB is (no need to fully adopt this naming):
- lreCntTx{A,B,C}: Sent frames per-port (for A,B only tagged frames)
- lreCntRx{A,B,C}: Received frames per-port (for A,B only tagged frames)
- lreCntErrWrongLan{A,B}: Received frames per-port with wrong LAN ID
  (only for PRP)
- lreCntErrWrongLanC: Received frames on interlink port of HSR-PRP
  RedBox with wrong LAN ID
- lreCntErrors{A,B,C}: Received frames with errors per-port
- lreCnt{,Proxy}Nodes: Nodes in the (proxy) node table
- lreCntUnique{A,B,C}: Frames only received once, per-port
- lreCntDuplicate{A,B,C}: Frames received with exactly one duplicate,
  per-port
- lreCntMulti{A,B,C}: Frames received with more than one duplicate,
  per-port
- lreCntOwnRx{A,B}: Frames received per-port (A,B) that originated from
  this node, only for HSR rings

Note that we can not currently completely distinguish
Unique/Duplicate/Multi in the kernel implementation and their meaning is
not entirely clear to me from the MIB.

The explanations in the MIB in [1] are otherwise quite explicit for each
of the counters but we may want to adapt the meaning of "port C" to the
counters. For example, there is lreCntRx{A,B,C} for received HSR/PRP
tagged frames (by the LRE). Port A and B are clear, but for port C the
meaning is "number of frames received from the application interface of
a DANP or DANH or the number of number of frames received on the
interlink of a RedBox". IMHO, we should consider separating "application
interface" (what the kernel calls master) and the interlink port because
these two are not mutually exclusive in the kernel (nor in the NICs that
support hardware offload).

Thanks,
   Felix


[1]: you can find it for example here: https://mibbrowser.online/mibdb_search.php?mib=IEC-62439-3-MIB


