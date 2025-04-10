Return-Path: <netdev+bounces-181074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3418BA839BB
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 08:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F254632B6
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABAF202F99;
	Thu, 10 Apr 2025 06:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPyrNNcW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8011D63C7
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 06:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267715; cv=none; b=GfkKq4ypkWMYJdBd+dkR4DEYHWoJcUpXyh5bME0Fv0XCZNz0wme7JitLQOhdfo6FQv/dxtQdxagQtvkTiVk5n0/SygGuw9dfhv5uGucNYRyK8SMZMB/xo5HJYDfR3H4Fm10xUxTHvi55T9ZkZHrB66gq0xSI0U9C36bB4mTcJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267715; c=relaxed/simple;
	bh=8T4++6YQL5JmtQQI9b2c0kc3G6Laew+mDIrGJSUBrfA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=vEqyFJiah7P47AveeWBzVXMbHFm4QlO3Sm5xaoczLFmFV2KSyLsJGb78Q1RDqUIYokOm2UdrtoWvHFIw4TAoBHVowkhbuRRnSbMMxLS4oUGvu0sryVgVzntBLNjkOKH9Jx89cMvbtnI8vcVU+TOLCKiRfEcwhvW5YTYAzmvfj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPyrNNcW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744267712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KqCcO5Qa9K7yRkLmQkxKWOtEKDtWsuadSUO7zSi/SPs=;
	b=gPyrNNcWdQQCpopQ9IvWJHu0zwufzDxd6othO/X94E14vcpmjvqIJv77eQ6hFOe/6oIy3v
	Q/UDbu45HPAadxZEI+juifgQyAuLeivLjizj1XR92nB2prjwRbSD+V9GTW3iofbAgP6fnb
	HlTPIrWucw8eXyLwdGheyGkgfgN021g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-I2zikjSkMAWHiZe8tpJ4Ng-1; Thu,
 10 Apr 2025 02:48:30 -0400
X-MC-Unique: I2zikjSkMAWHiZe8tpJ4Ng-1
X-Mimecast-MFC-AGG-ID: I2zikjSkMAWHiZe8tpJ4Ng_1744267709
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E22F5180025A;
	Thu, 10 Apr 2025 06:48:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04DF218009BC;
	Thu, 10 Apr 2025 06:48:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250409190601.2e47f43b@kernel.org>
References: <20250409190601.2e47f43b@kernel.org> <20250407161130.1349147-1-dhowells@redhat.com> <20250407161130.1349147-4-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>,
    Christian Brauner <brauner@kernel.org>,
    Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 03/13] rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2099006.1744267704.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Apr 2025 07:48:25 +0100
Message-ID: <2099007.1744267705@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Jakub Kicinski <kuba@kernel.org> wrote:

> > +	__releases(&rx->sk.sk_lock.slock)
> =

> sparse still complains (or maybe in fact it complains because it sees
> the annotation?):
> =

> net/rxrpc/oob.c:173:12: warning: context imbalance in 'rxrpc_respond_to_=
oob' - wrong count at exit
> net/rxrpc/oob.c:223:5: warning: context imbalance in 'rxrpc_sendmsg_oob'=
 - wrong count at exit
> =

> Not a deal breaker, just wanted to mention it.

Yeah.  I'm pretty sure I have the releases in all the right place.  The
problem might be that *release_sock()* lacks the annotation.

David


