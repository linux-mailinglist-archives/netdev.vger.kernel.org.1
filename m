Return-Path: <netdev+bounces-257853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dbedB2fGiGnevwQAu9opvQ
	(envelope-from <netdev+bounces-257853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 18:22:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D131098BB
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 18:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 499CA3005AC3
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 17:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A62C2360;
	Sun,  8 Feb 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a1ACnuNW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBQrE0rV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D07F15539A
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770571362; cv=none; b=mXRrrRxKDPwGHASvUP8yg2ZVRM4XCeJoFs5LJUh2h8o1WjXPGmTvywOrHWU3fekF8JcRu+BSc854D0Gj5t4Qn3q3n0wj87e6Pmo2UN2c4c6TVLeFN9ARMcm4a5xCJb6CuY7BR1kcrrNQI/B7eQqKpSR8eGYq8pbr55VhkQHUEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770571362; c=relaxed/simple;
	bh=JPwZSVWVaVLW3Z6YpXhW5lIznLWTsro9+6GytsHoeZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rP3Us9Olw9Oii+RfbZwPNDwQjlCk/7TRe9geo76jP4ee6oQQ+D8tAMMcRPPLWbHXO7DBI66n8Fofzt+nHMgH/yrXIK6pRhGvV7KDjcpU7jUGGePwAQShbykBL5OoAh+zdIIQpzdUrvtn6Xrw2SXBslq0YBlQ+XxeJqU3kEuNNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a1ACnuNW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBQrE0rV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770571361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6s5bPoEQnlqdP44WdUaieNNRs46yqXjX0mEOzw8uNXw=;
	b=a1ACnuNWS+E7PG+iybW75z4bBDR4wERNHjOji9muCHuscrgx+w0PFY85eetKVyfsasslog
	7cU+MsiBO2fMSyCemFS5aKrGCfJ8M5QOQ9M3UsirRrmUvkJL+7/IXbXnwwFkRyugEFnSy0
	l54SvlIrZTWDHf43qzEx0xH3+we6MtM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-2j3Mgo2sN--wuBlv_6XEjg-1; Sun, 08 Feb 2026 12:22:40 -0500
X-MC-Unique: 2j3Mgo2sN--wuBlv_6XEjg-1
X-Mimecast-MFC-AGG-ID: 2j3Mgo2sN--wuBlv_6XEjg_1770571359
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so53915255e9.2
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 09:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770571359; x=1771176159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6s5bPoEQnlqdP44WdUaieNNRs46yqXjX0mEOzw8uNXw=;
        b=cBQrE0rVvbhGfIl/cVrN5bd6QUJUXZVuGC4jmsN20UxE6wXQnjj8rmZ2T9shbwHXGr
         nlg64oCz3KRDKGn1kkNkhDa5f98L+e1d8nlKQQZVC8SutLVOIsPmq621+EqYMMdxsuWz
         D5ssBIpmvjLLEHjrX9oTQWN/xzj9Ilq5ch2f4/rHbgNbOU++qseHNKZRN6BcYAa3HcWB
         OIn9x56o5Ak1hAZW/pzFSjcMp56U49U71a//vc24vcVPGb0CJSHhjfmBd/svtFIPvIGV
         gmT/7JSPojXKSrotlj2jm+GwGMZUc0LOqcqZihFNyV42q70RxyUrp4Sqvw3hoQ9/4Rhp
         k5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770571359; x=1771176159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s5bPoEQnlqdP44WdUaieNNRs46yqXjX0mEOzw8uNXw=;
        b=fgE7YwN6zukVJzg4vefSStyUWMsWuHa1ZjV9WXckPQvwyj+ViESOe7pw4itUkB6CJt
         9UJoKEe2FLUJJsLkhCUavYA+dm5mj6iWEBuMZ2jIa0lG9LbtZRjlKiJ6NYp8dra0u9gS
         AQRuYLWLFSoRyrHjWYvuohvm3TQQ61EToWWXYQwItqqSmGxR0yx3i7dp2e5T+i/31SOA
         oSfH3JE/T0zgp6GRGAXBonFYdwqIIT9kKbJp8yOZR6htJ/OpJB1tR4kV1xJ0lR44KFMK
         duUeNvhYixoXnv8cab3hXNhRzgrUe8otdqdc62HZuYzSefgkRhxnjqVpdggZcsKzGVMw
         zd0A==
X-Gm-Message-State: AOJu0YxNmLAU2ld3FpmzIMc6nYGERosFoIE1EBg+76x7fWfowHxf3sAx
	dd6eg20o7s+FQyXyKLgjJNw5avqAiZUQAog1BLxnSmEdfeI1xIWAmyHAZym6k+DVRVRDNnIgQlI
	1iLPj3vY+1Dh5rvei8TVzMfdXqK3ilLuJ6FPGhf3Vxn3jMGRrrOFOT8dk8A==
X-Gm-Gg: AZuq6aIgLnSLZgqzlvmj2FpAaC/kt6iwRc0gKuo9BhoLIsN3DbSeCi1y/GKOf1dYvCv
	n5GxU9yoWgunQRA8/weL5ERSS1N5gTbxWLknJAMqbJbJMWyGTyY5EIpPR0/apGrov7JK3U8NjN5
	1e8qnofJAJShLVXUZ7fYGm9LuITffma7glJWApgT8XcyKsnynT0wKXZfZR6tTcc1KA20MpeCH3a
	Vq5fsGLJqFWRV4nBD+kYDb50UwdfyHR56A35IU5X0YcTSnKRGfw5Wjt+diZlt31ALNgfh98fuxx
	3t5/NeglZmDj90HK4aCSYfmI+ZIfNA4MOhtyINNr+xA+tPkDw1nnvBT9UFMkdAhj41xhjBiE36Y
	XZi0XvdruQ1gfw55XE3coIEhMarGeMU1Jfg==
X-Received: by 2002:a05:600c:c4a7:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-48320236645mr128388775e9.25.1770571358891;
        Sun, 08 Feb 2026 09:22:38 -0800 (PST)
X-Received: by 2002:a05:600c:c4a7:b0:480:f27c:6335 with SMTP id 5b1f17b1804b1-48320236645mr128388475e9.25.1770571358429;
        Sun, 08 Feb 2026 09:22:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629756bc3sm19208702f8f.39.2026.02.08.09.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 09:22:37 -0800 (PST)
Date: Sun, 8 Feb 2026 12:22:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20260208122211-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260208065456-mutt-send-email-mst@kernel.org>
 <3512ccd8-650f-4c05-b2dc-1c4588b39c87@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3512ccd8-650f-4c05-b2dc-1c4588b39c87@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257853-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74D131098BB
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 07:57:33AM -0600, Dan Jurgens wrote:
> On 2/8/26 5:55 AM, Michael S. Tsirkin wrote:
> > On Thu, Feb 05, 2026 at 04:46:55PM -0600, Daniel Jurgens wrote:
> >> v15:
> >>   - In virtnet_restore_up only call virtnet_close in err path if
> >>     netif_running. AI
> > 
> > what was this AI specifically?
> > 
> 
> It was the AI review bot, forwarded by Jakub on v16:

oh sorry i think i meant to ask about the "style fixes" one.


