Return-Path: <netdev+bounces-81576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A54C88A5D3
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DE1321140
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B6D1474DF;
	Mon, 25 Mar 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR9zjvtg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFC182F07
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369094; cv=none; b=MUOOrR9r84+BbeG7lqH0hRYgVXFnqayumMLLagadgAZNwGX734EJCxsJwzRM7RDRxhKjUqnjTLQ3mGlmXltUV5QeJDz4AcE/xYcBP6bWTeQMco5HYGVpqaI9Y8bIFgigUKIqvJ45a5z46roKQT+cUzdiN43kIbI8vqaigQM5LfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369094; c=relaxed/simple;
	bh=HI2SsfClkJfn/oY50aBTCzmAOuLD2EIjHXTgcCGykqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvDcC93HqFteV932qNSa5eSDRO8w4V1n1SQMqnb1GK85wGzvd6eJt24KDnX/nfqazsPiYp9C4EnXDbb84Gqymo/3pioRU+2b2+tlcklvKf4scsEZ8+suozCr+iICl3m7Tj0dQhdprvQoGO3uAu1IlFpmZGoTRRdnF0NTXPZfWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR9zjvtg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711369087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HI2SsfClkJfn/oY50aBTCzmAOuLD2EIjHXTgcCGykqw=;
	b=DR9zjvtgHMvrgR0lP/P3exQ3L5fZvZF69hIhSx/XTjNYaa7+IZQgHGQRrWDHkduAteMZVX
	T1VyZcnWbTknKJrdI3/LAZWiVfd8q1Wh0KEjxyXLJRWpxdiPl0dWrRyNQAM8kFL6Xrvm/E
	VhjxHX1azFRjxv2vZlV5RpuyUw2u9Gg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-lUYiDrXhOQ6CWQDxsplV9Q-1; Mon,
 25 Mar 2024 08:18:05 -0400
X-MC-Unique: lUYiDrXhOQ6CWQDxsplV9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E769F2932480;
	Mon, 25 Mar 2024 12:18:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.232])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55D06492BC4;
	Mon, 25 Mar 2024 12:18:02 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: dave.stevenson@raspberrypi.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	weihao.bj@ieisystem.com
Subject: Re: AX88179 interface is always NET_ADDR_RANDOM after d2689b6a86b9
Date: Mon, 25 Mar 2024 13:17:55 +0100
Message-ID: <20240325121756.456684-1-jtornosm@redhat.com>
In-Reply-To: <CAPY8ntBB+qDuw9M+2ZSFFuP78dFP9d5WPL93TdYAGxbdg=Msfw@mail.gmail.com>
References: <CAPY8ntBB+qDuw9M+2ZSFFuP78dFP9d5WPL93TdYAGxbdg=Msfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hell Dave,

I see the problem, sorry for the incovenience.
As the author of the commit, let me analyze it to fix it.

Best regards
José Ignacio


