Return-Path: <netdev+bounces-288861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uyXmChyxCmpx5wQAu9opvQ
	(envelope-from <netdev+bounces-288861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:26:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 908E6566AA3
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D54E3042C47
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262ED3E121E;
	Mon, 18 May 2026 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLg/Md4u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130B3E0087
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085323; cv=none; b=XFlyChfNtyt/wFA06syQVloTENGX5Dm0HgSjRnDgvjd0ebloG14bnz6WQ2IbUxqHH/CP6Ud6B1p+OHLL1GURNsF1eox6Y3Ln2Xlwu0fP4zOmx+NL/do3V8Z5cbiMZEJfYM7+kNtrF60FUO1f0co6Z2gJtQh4Ap3QG87i/V8GEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085323; c=relaxed/simple;
	bh=GAxmCVfEfuTYdYwUoDV98+wVYrNUCo+F+B14gf3GO9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKw2o9VBLZnc0AqOyUHIQB5Di+S/6yfkGUWzaB3LmRp9YbyVCd4YiG94MhDVhKwt6ixxDbpDfs1PH8b+IfBAvfeOuHxz57SyYEeyDmQYUfOkmehIQH8VLGHYCC0IU9+15zJ2r7LJr9jY+DNAV2gVs7EzOfFQdejwo5iG4KX7TfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLg/Md4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779085311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dg7sEKaYbYXo9PZMr6ZpjguChM6yU45YbBjm7jsgrk=;
	b=iLg/Md4uPHJUb6gsaGoIT+GRCNdMGJxqTl8wq5Lq98l8jndy1keI+Siyybx+EPo70naf69
	VQvBOrhOBl2Jd99VyMHt6CVRif1krQMHBOBHH5RDfUba94vVX9f7FwXiZCN3MycLG/absc
	/1h5ykezkCqeg9RXLCfYGw1tiW6X16k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-3cKWxSV_Ny6n3wpZqxTRmw-1; Mon,
 18 May 2026 02:21:47 -0400
X-MC-Unique: 3cKWxSV_Ny6n3wpZqxTRmw-1
X-Mimecast-MFC-AGG-ID: 3cKWxSV_Ny6n3wpZqxTRmw_1779085305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C33418002C8;
	Mon, 18 May 2026 06:21:45 +0000 (UTC)
Received: from griffin (unknown [10.44.32.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14E8D18004A3;
	Mon, 18 May 2026 06:21:40 +0000 (UTC)
Date: Mon, 18 May 2026 08:21:38 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, Adrian Moreno
 <amorenoz@redhat.com>, Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, Matteo Perin
 <matteo.perin@canonical.com>
Subject: Re: [PATCH net 1/5] net: rtnetlink: fix link nsid reported when the
 link is local
Message-ID: <20260518082138.37522db0@griffin>
In-Reply-To: <20260515201937.2813983-2-i.maximets@ovn.org>
References: <20260515201937.2813983-1-i.maximets@ovn.org>
	<20260515201937.2813983-2-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 908E6566AA3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288861-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,6wind.com,canonical.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbenc@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Ilya,

IIRC this was added because Open vSwitch needed it. I'd expect most
users that need to deal with cross-namespace detection to just switch
to the given netns prior to issuing RTM_GETLINK; at least, that's what
I'm doing in the tools I wrote.

On Fri, 15 May 2026 22:19:20 +0200, Ilya Maximets wrote:
> But this doesn't work for link nsid in cross-namespace RTM_GETLINK
> requests.  For some reason the code checks if the original device
> and the link are in the same namespace and not if the querier's
> namespace is the same as the link's.  So the logic becomes:
> 
> - if NSID is not reported, then the link is in the same namespace
>   as the queried device.
> - if NSID is reported, then the link is not in the same namespace
>   with the queried device.

I'm not sure I would call this a bug; the original idea was to use
IFLA_IF_NETNSID to switch to the point of view of that netns but
without actually switching to that netns. Hence, the netnsid is
relative to the caller's netns but otherwise, you get the same reply as
you would if you switched to that netns. If you think about it that
way, the current reply is consistent.

I agree the side effects of the self-referential netnsid are
unfortunate. But that's an orthogonal problem merely uncovered by
IFLA_IF_NETNSID, since, as you correctly note, such netnsid can be
created also by other means. This is (AFAICS correctly) fixed by patch
3/5.

So, I would argue both the old and the proposed behavior are valid.
I agree that from the point of view you're presenting the proposed
behavior is easier to use. Double so since you're arguing from the Open
vSwitch POV.

> 4. A seemingly read-only RTM_GETLINK request for a different namespace
>    allocates a self-referential nsid for the current namespace, which
>    is a little unexpected.

I, however, don't agree with this argument. RTM_GETLINK has always
allocated netnsids, even long before the patch adding IFLA_IF_NETNSID.
There's nothing special here. You might call the netnsid allocation
unexpected but it's been part of this since the very beginning.

> A research across open-source projects doesn't show any projects that
> rely on the things that are being changed.  I couldn't find any
> project that uses the reported LINK_NSID with cross-namespace requests.
> And no projects that use cross-namespace requests seem to even parse
> the reported LINK_NSID.

I trust your research. My main concern would be Open vSwitch breaking
with the change; I haven't checked but obviously I trust you there even
more.

> Of course, that doesn't mean there are no such applications, but the
> current behavior feels like a logical bug that IMO should be fixed,
> otherwise it's hard to use all-nsid sockets properly.

I don't think it's a bug. It's just a different way to look at the
interface. I don't have a problem with saying it's more ergonomic and
better. I don't have a problem with changing the behavior given your
research. But please resend this patch without calling this a bug and
without the Fixes: header. Otherwise, it gets a CVE and I don't think
that's appropriate here. This is not a stable material, this is a
feature adding a behavior change. You'll get my Acked-by then.

The real fix for the all-nsid problem is patch 3/5.

Thanks!

 Jiri


