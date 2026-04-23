Return-Path: <netdev+bounces-280790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDiYBWk66mnYxAIAu9opvQ
	(envelope-from <netdev+bounces-280790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:27:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB99454548
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A78B302573B
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266D33261F;
	Thu, 23 Apr 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iw84djJy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNACJnJz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383631E853
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957645; cv=none; b=SPQDPdZj0Uab16JW3uxwUdNAtCXeNjSZmJMbUTj2hGygRPqoz1Glbqc73+jKnbLxAsZ3ziyo8kZLUuQpHaVnpych1EAa3Cqv6aIl0LSIZjGIgAI6QqRzY1tvpNHRd6Dy71JW5STbIl13uXn2pHjoAd9t94N5uBjE1BZ0iM0be8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957645; c=relaxed/simple;
	bh=Braew1XveMAGlyFC2s/mzZ41yr7jUS4QWkO2xuBRjyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+hnZ0+U2Ll3COmJFCHGFWAEEYPlBM2Xvm/vIUaBynI1UO9QfGd578T8iOeczNz4xrEW9wC9wV3CJNePLfPU80HDFGIfFYzEvUvn1EKa7sVu4l9/QoDLL/Wyohta9A/YChWC2HGB+mC4hKSweSEYN0PxAUt3aOauoJ0GbxWcR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iw84djJy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNACJnJz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776957643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQf/P7hvHt9A1fs4c4DenfrxwjfBH28w3+BhoS4FuwU=;
	b=Iw84djJymNIk6+G3cRW7Q4xhD4jtMzvt0YeI6KS8xVLizLZD257++7PxemfwsDwWCcDOp3
	ekWT8agTwTndycj68bNsCm9AVjXs+qZaomvtoimiZT0o8UoawQ6YopeM/xC4A/FWSGqvp9
	e2d7cyHXkBzVjwAmqSHWf8Y43rvXVv4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-_9NFwpuANG2mtC04Fov4iQ-1; Thu, 23 Apr 2026 11:20:42 -0400
X-MC-Unique: _9NFwpuANG2mtC04Fov4iQ-1
X-Mimecast-MFC-AGG-ID: _9NFwpuANG2mtC04Fov4iQ_1776957641
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50ea1a7a5d0so104257891cf.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776957641; x=1777562441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQf/P7hvHt9A1fs4c4DenfrxwjfBH28w3+BhoS4FuwU=;
        b=LNACJnJz28uaWH8nXZUMxS045YJzSwXA8m7SsOppr3w/cerL0OTOINBm+7I8Nua98c
         fNTvQl4rswH/Yj25YHZEXod1gZj85Rnm0gcgvnB/GYDoIjfJAALh8xu7EC13oL2GM21R
         usi4dX5Vu1bGH9SywLXoMJgNMk1co4pEtryAE0koj6FDaj5Fx5r4nkTQWOqN1lukP9Tl
         1X85VVo2ki46aVNfhB9WlIBDBYgglsBftK9vReQ2A/bgiFFUOE4NN9adUVtdMJR49NYJ
         Eq8NC+qAmLC6DPnqWXHeAB7FrzFqCgkTnQhLFQiYnZ9yXaU3dAuQldiet3D1gxxEiHeS
         02hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957641; x=1777562441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQf/P7hvHt9A1fs4c4DenfrxwjfBH28w3+BhoS4FuwU=;
        b=SnqkR6pWPduX7DJhjvrhQILH/voQiSJQ5cGtErtMMFaVJzKnkd+wvFh1JPAKcPb6jY
         1bVBSk8gCcNkBHRSLS7ZQlO9Pv/IBZ7XShB8UR0WxEl0lz/QDt66HnX/dwMEjMn5ug3g
         VDv6hpIfopWAgmho2XxZtiYNn9STc2iAySpaJ4amW+lCWVo45Qg8DmkOrxgMTBPfz+5T
         7p9iR9AUhL2NGH41yiezEH1w4dMKUYG7b2P1zODSldvuTovI4nDsLbUPk4b8COGuChmx
         x83NdSXBV6X0GEg509frPrhaNaqkqtPb7u0Sx/lrvwNtEHWCmqou2Zr6dYhrD/lck/KH
         PutA==
X-Forwarded-Encrypted: i=1; AFNElJ8epvwCcxY1aYCNm/3agHjkcNVK3qPimwe/U+TtuFrSO6dGBXgb9tsk7jrhewhspEwEQTDIGB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK8V/mGBztY8Xo+tfpW4no4VzWRiANJQEl2IiYZLoD/r33+HOe
	0LZFWFuitMbOm9s8gBTHhuyXPhZgPHehYUw4seKJ87Cx357vJh0oXZY9scBFlYUqVY1Vi2BHgKX
	qCwFw53fXETsnxRNIrP3wRcBc4M6soXKGMxENZtp/bflEkdGDA+97cWIIcQ==
X-Gm-Gg: AeBDietxccqtqB8zktpRhKDEnHq6aYmIRFgBK4Xsat9Qj/O8nOERe8YscU7TlJiu4Q3
	Ta4VTHTd4RNqph6rlCAs0hkqNbK16TSlGKtKIqAXoFaTUXYbUShkNrpA7IA3uj3HdT/JRcyaxsR
	BFVAXAN/QC6WEhWjKKsoYR6Zs2CyU161WNVkjAtPkZYxXk+UAEO44Rl+dDRu8laIETdodNk0/mO
	ONXUvVvvVZDZm5Vw8qCulgzSr6vxrPzqtI+FrFDyBunnsH3/Ld0Zato7m4FqpQtkFx8NPX/zmO3
	kxEGcfdWwrq0HdtM4V4yzp8IcWLHDYaknumW7GObRX10TfCuU1pSZzJxSmKwnyh+rQZBj6ZkUFy
	WHH0J0SBV/PaAtpabmYkoPYHb89Q2bCcDvYG+jft8Gw==
X-Received: by 2002:a05:622a:1390:b0:50f:b076:43dd with SMTP id d75a77b69052e-50fb0764918mr197597991cf.36.1776957640936;
        Thu, 23 Apr 2026 08:20:40 -0700 (PDT)
X-Received: by 2002:a05:622a:1390:b0:50f:b076:43dd with SMTP id d75a77b69052e-50fb0764918mr197597111cf.36.1776957640401;
        Thu, 23 Apr 2026 08:20:40 -0700 (PDT)
Received: from rh-jkangas-kernel ([2601:1c2:4400:6bf0:7677:bcee:4ef0:e09d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e5f5cc439sm105170541cf.17.2026.04.23.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:20:39 -0700 (PDT)
Date: Thu, 23 Apr 2026 08:20:34 -0700
From: Jared Kangas <jkangas@redhat.com>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com,
	boon.khai.ng@altera.com
Subject: Re: [PATCH net-next v12 2/4] arm64: dts: s32: set Ethernet channel
 irqs
Message-ID: <aeo4wlrSinKUsdrZ@rh-jkangas-kernel>
References: <20260313-dwmac_multi_irq-v12-0-b5c9d0aa13d6@oss.nxp.com>
 <20260313-dwmac_multi_irq-v12-2-b5c9d0aa13d6@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-dwmac_multi_irq-v12-2-b5c9d0aa13d6@oss.nxp.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280790-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,armlinux.org.uk,altera.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkangas@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5DB99454548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 08:13:33AM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> The GMAC Ethernet controller found on S32G2/S32G3 and S32R45
> contains up to 5 RX and 5 TX channels.
> It can operate in two interrupt modes:
> 
>   1) Sharing IRQ mode: only MAC IRQ line is used
>      for all channels.
> 
>   2) Multiple IRQ mode: every channel uses two IRQ lines,
>      one for RX and second for TX.
> 
> Specify all IRQ twins for all channels.
> 
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---

I missed that there was a net-next rebase and ended up sending a T-b to
v11 instead of here ([1], [2]), sorry about that.

To give more details on my testing around this specific patch since the
driver patch was merged: I configured RX queues 1-4 with
'snps,route-multi-broad' across several different boots and verified
that interrupts showed for all TX/RX channels in /proc/interrupts.

Tested-by: Jared Kangas <jkangas@redhat.com>

[1]: https://lore.kernel.org/all/aefX7Ajltzt5EqIR@rh-jkangas-kernel/
[2]: https://lore.kernel.org/all/aefY8WGCuNr4BQG4@rh-jkangas-kernel/


