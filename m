Return-Path: <netdev+bounces-222687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5CB55712
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00996A01C10
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FF33EB1B;
	Fri, 12 Sep 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/7j4AMY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910B338F3B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706249; cv=none; b=mHd3qkUqeN6JGK6eMjvl2z210WmP9tmVPCcMIorn7K4QhGdKavTjugP55dN7lf8mDYcOzF0FJmYgFCmMvrMhe6eEzKRLha4RXPc8OEiKJtcCECXM+ncACVqxE/in13tEEYpyk7AJbcnmcpEl681ggCvyGd72VN3sFPOI+8VOvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706249; c=relaxed/simple;
	bh=HTZCF9HHG7KGOIM3FLP7xYTC1Qk53AwpjkHArOdAA3Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=iSwZGlHvxXeIUb1w69MOQGOY6P/PI+3Ly1BYIzjYJ3RxyogW06VIrkBWToIaFrsSHWDyRVvqsgY4TuAx0ML4N7pQFfGaQGvSru3PSGOjL4llej8OOaF5kt6ghKvIhroxkQn4FGRaX7i5U9GQPamp8VzLMJTPsDTH0+I2BzWLBuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/7j4AMY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757706246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AaqkOSjrTGuOFyhvGeW1jhkYe7CZaWO5SQO66fJCWMU=;
	b=G/7j4AMYA5Brm8jqAwsw54c7ghlogB83ZxikPbwxaCypFZaf+fLRT1Xfpyxn/Ry85vPGcr
	66ku1aDNF5017TTDBjjHHfNerH6TELIONM3EvdAFNTvr4Oia0pyAPlw/rGpRwEXWHyfcWG
	QuPy2lDKdo/uFzis4iHnx6kMZ4F4MM4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-D7tUWhg2PymFxzuIgBflHA-1; Fri,
 12 Sep 2025 15:44:04 -0400
X-MC-Unique: D7tUWhg2PymFxzuIgBflHA-1
X-Mimecast-MFC-AGG-ID: D7tUWhg2PymFxzuIgBflHA_1757706242
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 582DB1800284;
	Fri, 12 Sep 2025 19:44:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42BAE1800452;
	Fri, 12 Sep 2025 19:43:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250912184801.GD224143@horms.kernel.org>
References: <20250912184801.GD224143@horms.kernel.org> <2039268.1757631977@warthog.procyon.org.uk>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, Dan Carpenter <dan.carpenter@linaro.org>,
    netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David
 S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] rxrpc: Fix untrusted unsigned subtract
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2331699.1757706238.1@warthog.procyon.org.uk>
Date: Fri, 12 Sep 2025 20:43:58 +0100
Message-ID: <2331700.1757706238@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Simon Horman <horms@kernel.org> wrote:

> > Fix the following Smatch Smatch static checker warning:
> 
> nit: Smatch Smatch -> Smatch

Yeah.  Can that be fixed up at time of application?

David


