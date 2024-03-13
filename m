Return-Path: <netdev+bounces-79654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A1087A6EF
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 12:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D651F23BC4
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BD3D3BE;
	Wed, 13 Mar 2024 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9fAjAd3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6133F9C3
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 11:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328453; cv=none; b=M6/wisWI93IH61X4S9YhOCDY354q12ZLGNVZX7GfE6QNogIG7yjR5t1v+8NpHkaz2n7Dr5mBc1WxFV1p6XwqKF3mT1li2FKlzQB71QsqnYG6auF9PH89u38C2W2YYrc/Sn0LOxrhB+O6YIXxQKQpOklY6ZyTs3L1fOMzWr8CZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328453; c=relaxed/simple;
	bh=O2khxfHdkj4ZQ1U0sRtZjb5+p0cWYFEGv5IoGvbXspg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=aU2OOxM393BMncDSLgQC+qwgIxeH8G3h1c8AMFqSkjd0JiXY8yTOEdUDM1dhBRznY5BNP6NOmQRWMaPp9MLJ9TpXt2wMHEU+l75JOJiZ1SWV4WTNP8/hKIJGxFKzH7+HcvtfGE8UPpZprscUx3pzWp9HOl4/bCpuj1S7AJ+r41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X9fAjAd3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710328450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O2khxfHdkj4ZQ1U0sRtZjb5+p0cWYFEGv5IoGvbXspg=;
	b=X9fAjAd3O/c0U//aHeiIDxP8SRVjnluySpI+ABMTZOf+Ia7xTii/kT9TcWB4tJ/pqzALss
	gTos0QyZEjElddC9pIM75VhlAD3MXHnFJBUrX5TqVODG1O5Pe9kp+/umKtoGlz6ljsI6QL
	aqaWdtyQGdzvwYhZaQ9MPv4By69OAAY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-HKb6oDvhMDSFbuQsiL4lFw-1; Wed,
 13 Mar 2024 07:14:04 -0400
X-MC-Unique: HKb6oDvhMDSFbuQsiL4lFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 110723C0DF79;
	Wed, 13 Mar 2024 11:14:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D875C3C23;
	Wed, 13 Mar 2024 11:14:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-2-dhowells@redhat.com>
References: <20240312233723.2984928-2-dhowells@redhat.com> <20240312233723.2984928-1-dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Yunsheng Lin <linyunsheng@huawei.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org,
    Alexander Duyck <alexander.duyck@gmail.com>,
    "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 1/2] rxrpc: Fix use of changed alignment param to page_frag_alloc_align()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3086025.1710328441.1@warthog.procyon.org.uk>
Date: Wed, 13 Mar 2024 11:14:01 +0000
Message-ID: <3086026.1710328441@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Reported-and-tested-by: syzbot+150fa730f40bce72aa05@syzkaller.appspotmail.com


