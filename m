Return-Path: <netdev+bounces-148590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25F9E2776
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42F1164CAB
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA681F4283;
	Tue,  3 Dec 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5OMEQ7e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDD1E2613
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243432; cv=none; b=F+2vpQkNV+D38EuSUeR540FZJBNWJaIHR1yc1216RfQ5srY4qsbPpUdzygM2+Y1y4ioE/Egwoj25A6wmjJy/5zQNpMQAsGoZd4hOKexoL9MAbju8OG5IcbDjXqA0tqdpp2b+Ha+fbL+vK/2mTDUmGNxcHX5n2m+1yZqR6Wn47o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243432; c=relaxed/simple;
	bh=EIGaosgF4l4A0rjBiun5K8DQn+XPkkXDbvMdDDo68gQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=S59Ky+r0u4eCE4qc08cBdaN4tlLMw0i90lvC5J9vASCRoflPOfplHPA2Nuzsd7L9jqhKSHyaswcoV+xxMpiIoH8A9GgPdWCG8iJ2z1FSVjZXrtiV8v4kIArh2OGzsEmYrBsgxso6MmpDvM3bd9ShvI2Bp0bHFCvt5KJ4B5krThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5OMEQ7e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733243429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp2UWbsujaypn3YJ/W5a3HP57t0RnBZ4OCvRhCFcrFM=;
	b=a5OMEQ7erepjln1WwsCBkjJzz7b+gb1yZuFw5Z0uBSlc0yaOIaIBkGyL7UAcWjISITtONe
	d2bPGEVBiCrxO3dTOY/ENgvFxeVxce2iL8sTPJ22UeylEjZVlUpIXAo/A7RS3a4HmFQJVi
	xMtZsApqJQjG2ua2fgFVLo20rp+o1Ag=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-brpRMCOEOH-S2z9SlUva-A-1; Tue,
 03 Dec 2024 11:30:25 -0500
X-MC-Unique: brpRMCOEOH-S2z9SlUva-A-1
X-Mimecast-MFC-AGG-ID: brpRMCOEOH-S2z9SlUva-A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B0AB1955F3F;
	Tue,  3 Dec 2024 16:30:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75A4B1956052;
	Tue,  3 Dec 2024 16:30:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Z0pMLtmaGPPSR3Ea@xiberoa>
References: <Z0pMLtmaGPPSR3Ea@xiberoa>
To: Frederik Deweerdt <deweerdt.lkml@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] splice: do not checksum AF_UNIX sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <537171.1733243422.1@warthog.procyon.org.uk>
Date: Tue, 03 Dec 2024 16:30:22 +0000
Message-ID: <537172.1733243422@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Frederik Deweerdt <deweerdt.lkml@gmail.com> wrote:

> -			if (skb->ip_summed == CHECKSUM_NONE)
> +			if (skb->ip_summed == CHECKSUM_NONE && skb->sk->sk_family != AF_UNIX)
>  				skb_splice_csum_page(skb, page, off, part);

Should AF_UNIX set some other CHECKSUM_* constant indicating that the checksum
is unnecessary?

David


