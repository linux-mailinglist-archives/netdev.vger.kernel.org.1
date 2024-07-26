Return-Path: <netdev+bounces-113194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AB893D2DD
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F621F22B66
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09B17A599;
	Fri, 26 Jul 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eji+hQcM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8924AA3D
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996149; cv=none; b=M0L54oC2iC7GE7d5mRuxuy69GDkRcPVvX5Xxk+RFxkzUqabTVvzrBbj/4XwABD1Fy3UTKIiu1JxVkXZwUbnmVV+E7xhhHqV3C7ZVtiNRwWXovpUAFx0jH+esAMPg2pbBVyx2ADqmktM/HVc3s58TkJI8NjekY7mJaEt0ro83S9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996149; c=relaxed/simple;
	bh=zpYoC0bKWO/E8vU/OfmKM5HXzkjJBLVwbnPHaL9Kgtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WT1h1TEu5nzF4YYkzpVwMfsgsnIm5BnK7YqYkOxKRwWE131sxsATMfyjSQBJG24OyBGdIeNUcIYlxz1o3EdG9ja8vXs6A9G4c4Ub8knku2U1YtdD2bBeV3u/dcR65kvVAz8l+CK6P3UFjopJ39eBHYkfSwgw44pFGPEWmKdSJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eji+hQcM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721996147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ia6UsEbsS9+W6Fb8WCpi2quyjabb0b4//2sWiMCJBA=;
	b=eji+hQcMd5nuQuzWvWgAGCGoZe43myCri6UckK4RBZqZ0O1zzF/owBHDMKJPYQXfLnhXsd
	ToWJco0zi6FPG9n0VRevOe4NIyjD3sDcMY3C3dva+rumg5Y5OTp4xMq0YP63oeMiyY97/r
	JeUmBZPt6iJzj0HdXwVgdJo9i8693Cw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-rheZr8p8M5O7cxbTjh0r_w-1; Fri,
 26 Jul 2024 08:15:42 -0400
X-MC-Unique: rheZr8p8M5O7cxbTjh0r_w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E10A1955D4E;
	Fri, 26 Jul 2024 12:15:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.105])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C75801955D42;
	Fri, 26 Jul 2024 12:15:32 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: andrew@lunn.ch
Cc: UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	lucas.demarchi@intel.com,
	masahiroy@kernel.org,
	mcgrof@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy module
Date: Fri, 26 Jul 2024 14:15:26 +0200
Message-ID: <20240726121530.193547-1-jtornosm@redhat.com>
In-Reply-To: <bcc81ea0-78e1-476e-928c-b873a064b479@lunn.ch>
References: <bcc81ea0-78e1-476e-928c-b873a064b479@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello Andrew,

> What this does appear to do is differentiate between 'pre' which will
> load the kernel module before it is requested. Since there is no 'pre'
> for this, it seems pointless whacking this mole.
Precisely, we need to fix the lan78xx case with micrel phy (and other
possible phy modules) too, due to the commented issue generating initramfs
in order to include the phy module. 

> What to me make more sense it to look at all the existing 'pre'
> drivers and determine if they can be converted to use this macro.
Of course, now that we have the possibility we can do this with other cases
that have been already detected (and fixed with a softdep pre) and others
still not detected (if anyone apart from lan78xx).

Thanks

Best regards
José Ignacio


