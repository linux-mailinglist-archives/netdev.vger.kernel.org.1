Return-Path: <netdev+bounces-112787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A293B334
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DDBC283C1E
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E196158DA3;
	Wed, 24 Jul 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9bUmeKK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1D157491
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832916; cv=none; b=t9bguw3GljujR87xQQsUzAgn+aQ+ndmdYANSS2QlvfrEQwHfyTRmpynb8dVKfpsOroQGmBkfOb+d/v6raJdCO+npV/qDp6s9Oy4YiNe+bpsnFU5iKzlC0D/q38mk/Qut5LYw6tAaHT0UALhgG0OVhX7swwQiFv7SBPipUcgVxvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832916; c=relaxed/simple;
	bh=nLjXiP4HZkptRsbuUSRu8KiMjkZkkee/nRjBU+GFhwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvxGrU4PHDLmWnIXDrAJK15G/oExlSHttd/kmHwcTpfcWUO6YqSCZuIqsZIbD9Ezru6Ve7nv+id/DzSu88qpRHkQkieDrb/NHdmiUcxWZloRDuygq96WMXUXXY27e56E5cAFL1GB40x1N6T8FG6gbtW8sODMMdYPYUu/nBz//GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9bUmeKK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721832914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqaslouRWriEmr41dYglirZKWf9nqPnvwlDNJN3ShwY=;
	b=D9bUmeKKo2krfBhZcBm277rKxswp+i//oQH4WkLGC+FgMPCA527lX1V9A6YXVAsWnd1ZpD
	FDphxET3WxOvbpHGelafHBYpUJkPsJi1K5bvIKCWjFF0EuAnZ4VPRFKCGi8EN+LGJqlfN4
	eJ1XnuRA3dmtaMM0sXF2Lg8Fp0b+UME=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-6b0L-_YIOmOwiMs0IdXUrQ-1; Wed,
 24 Jul 2024 10:55:08 -0400
X-MC-Unique: 6b0L-_YIOmOwiMs0IdXUrQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 629DE19541BE;
	Wed, 24 Jul 2024 14:55:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.143])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0940A195605A;
	Wed, 24 Jul 2024 14:54:59 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: gregkh@linuxfoundation.org
Cc: UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	woojung.huh@microchip.com,
	lucas.demarchi@intel.com,
	mcgrof@kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: add weak dependency with micrel phy module
Date: Wed, 24 Jul 2024 16:54:54 +0200
Message-ID: <20240724145458.440023-1-jtornosm@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hello Greg,

> Agree, this isn't ok, if you have a real dependancy, then show it as a
> real one please with the tools that we have to show that.
IMHO, I think it can be very useful.
Apart from the comments trying to answer Andrew, let me try to explain
better:

I am trying to solve dependencies that are not declared in anyway, but
without modifying the normal kernel behavior, for special cases in which
some modules are automatically loaded when something external is needed
or detected. For this cases, user tools like dracut don't have anyway to
detect this and if we a use a normal soft dependency, the modules will be
always loaded in advance.

Yes, it is a real dependency, but for this case, some phy modules are
possible and I think it doesn't make sense to load all the phy that could
be possible in advance, because there is an internal mechanism to only load
the necessary one (the associated phy is read using mdio bus and then
the associated phy module is loaded during runtime  by means of the
function phy_request_driver_module).

I think it is better to load only the necessary modules and have only in
initramfs the necessary modules.

Here you can find the complete/original justification for this:
https://github.com/kmod-project/kmod/commit/05828b4a6e9327a63ef94df544a042b5e9ce4fe7

Please, take into account that this is the first usage of this feature,
lan78xx can be completed (others possible phy modules can be added) and it
can be considered by other modules in the same situation.

Let me add in the thread to the other people that have been involved.

Thanks

Best regards
José Ignacio


