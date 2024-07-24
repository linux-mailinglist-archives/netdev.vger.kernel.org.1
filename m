Return-Path: <netdev+bounces-112785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9DD93B30F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A541281B65
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83016F0F3;
	Wed, 24 Jul 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdG+FK3U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153C15ECCE
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832412; cv=none; b=QjW6J6b3hDpEg6DsOIUaxK4ZtM/kXMl7w8U1Gk/IPaf+pKLsHE3+fGFHWwDeEQ7CdBKbAF5Yq60HdS054vmbSadOIW2Vb9mswOfy/PaNz3OQS2UUSfRPnn6SBrYXu5zymKbRLIzXafgwgPmUh97OrJB+MyyOr+dNGl4qfZKFDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832412; c=relaxed/simple;
	bh=6FewaBjJjpbdVWRUM2owAR3Q2PzvlDTS3+AhZu2c0dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjeChOks6jkeLj6j4SKWVpWwf0zoKXZi+qJqNoVQL1Zmcj8VN8kmL6eUIlMPg6MycjElWy9n+cHQwIagIuB89TznXX0ORRdmuNfoxff/Oklc+fS+q+oy94zS89IbyYdXiyW2PANS3SCYEhM3DAdmNOVIaFvTOA9Sd+/e/+AYVr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BdG+FK3U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FewaBjJjpbdVWRUM2owAR3Q2PzvlDTS3+AhZu2c0dM=;
	b=BdG+FK3US22o/vWcmk6oCAAAiaGVe0V/0/EURe6wKu6fsdXA6HETOBKxsqut61x8lkIVL8
	sQJzcpFeU0N4Ldy/CfG1NrQxKXxVg7NMzrSct8krfg7JrWOWdmh+OQecj94ZnTe78ASIk3
	Jh2G6EyLUs5HI3DLkPtNnQ1+GoPiizU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-c5kfv1sCO2GN3gAPhuo-7Q-1; Wed,
 24 Jul 2024 10:46:47 -0400
X-MC-Unique: c5kfv1sCO2GN3gAPhuo-7Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51EB71955BEE;
	Wed, 24 Jul 2024 14:46:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A8231955F39;
	Wed, 24 Jul 2024 14:46:27 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: andrew@lunn.ch,
	gregkh@linuxfoundation.org
Cc: UNGLinuxDriver@microchip.com,
	davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	woojung.huh@microchip.com
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy module
Date: Wed, 24 Jul 2024 16:46:20 +0200
Message-ID: <20240724144626.439632-1-jtornosm@redhat.com>
In-Reply-To: <2024072430-scorn-pushover-7d8a@gregkh>
References: <2024072430-scorn-pushover-7d8a@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hello Andrew,

> Is MODULE_WEAKDEP new?
Yes, and it has been merged into torvalds/linux.git from today:
https://git.kernel.org/torvalds/c/f488790059fe7be6b2b059ddee10835b2500b603
Here the commit reference in torvalds/linux.git if you update your repo:
https://github.com/torvalds/linux/commit/61842868de13aa7fd7391c626e889f4d6f1450bf

I will include more references in case you want to get more information:
kmod reference:
https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7
kmod test-suite has also been completed:
https://github.com/kmod-project/kmod/commit/d06712b51404061eef92cb275b8303814fca86ec
dracut patch has also been approved:
https://github.com/dracut-ng/dracut-ng/commit/8517a6be5e20f4a6d87e55fce35ee3e29e2a1150

> It seems like a "Wack a Mole" solution, which is not going to
> scale. Does dracut not have a set of configuration files indicating
> what modules should be included, using wildcards? If you want to have
> NFS root, you need all the network drivers, and so you need all the
> PHY drivers?
The intention is to have a general solution not only related to the
possible phy modules. That is, it is a solution for any module dependencies
that are solved within the kernel but need to be known by user tools to
build initramfs. We could use wildcards for some examples but it is not
always easy to reference them.
In addition, initramfs needs to be as small as possible so we should avoid
wildcards and in this case, include the only possible phy modules (indeed
not all phy's are compatible with a device). In this way, with the default
behavior, initramfs would include only the drivers for the current machine
and the only related phy modules.

Thanks

Best regards
José Ignacio


