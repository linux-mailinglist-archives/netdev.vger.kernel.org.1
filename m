Return-Path: <netdev+bounces-117161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274E794CF2F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10181F222C3
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC88F1922E3;
	Fri,  9 Aug 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz83Rr33"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D71916CD05
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201534; cv=none; b=kg8oz7cZIJPVNv0gIwEKDO5jPMzVYoPV08FlZi6/6SOiE/u4PohTmSZ4J1bgy9Hw6tb69oZb3aTjDvreU4csHX609GFOQNJZZxi5U3PhF+vmj+haB+ZQKh7Ate8Y95bYEC/a4hhIfR0QHaPWs2atGlFbY6SmDvQeGopz4k/XKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201534; c=relaxed/simple;
	bh=+fGjLyr8+mM3EQ1Qg4zs7+HDFWx/1Tx8NMju1CR3Gl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBEKUd51s8dNQtWBqnUdSW/69i0vjUv0iYzo27gJ7tv1ED1MhGEKaN6KBiTuLvKWrIafLY9jApLTz1skt32APnqTycG36PuqwcK2HPIJ8AtWZYzj4itYvEofBTJJbvBk2YkC7UJA3a2Bg3+p+9MIeGtH8eATOhC/XpVnx1jqnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz83Rr33; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723201531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+fGjLyr8+mM3EQ1Qg4zs7+HDFWx/1Tx8NMju1CR3Gl0=;
	b=Dz83Rr33kyOrQjk578Qg1soflGgMHeXRzmPP+JmYhAUfaTCZ5CuJfsoqq4HoCY2JoPnXJZ
	8drFwbWKAyeZeKEDbATM2zsEp3UkzfJX8sn4k3DdjKm7lf8RDoGT0CS/Rx88Z+dM0i6axQ
	ARXREPVzIyXFwRRoYBNKEufGX8G8Auw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-v7TboLfKMBCkG85x3hY8lQ-1; Fri,
 09 Aug 2024 07:05:29 -0400
X-MC-Unique: v7TboLfKMBCkG85x3hY8lQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B383219560A2;
	Fri,  9 Aug 2024 11:05:27 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 619B719560A7;
	Fri,  9 Aug 2024 11:05:23 +0000 (UTC)
Date: Fri, 9 Aug 2024 13:05:19 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved
 size
Message-ID: <20240809110519.GA30788@asgard.redhat.com>
References: <20240809094321.GA8122@asgard.redhat.com>
 <c78f98ff-df44-475f-bb1c-5c33f816ee11@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78f98ff-df44-475f-bb1c-5c33f816ee11@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Aug 09, 2024 at 12:42:19PM +0200, Matthieu Baerts wrote:
> Do you mind sending a v2 with these small fixes, so your patch can be
> directly applied in the net tree, please?

Sure, will do.


