Return-Path: <netdev+bounces-298675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vgl+E0MNLGrAKQQAu9opvQ
	(envelope-from <netdev+bounces-298675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D27679F15
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:44:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BKnsuNGM;
	dkim=pass header.d=redhat.com header.s=google header.b=Tc0h0yDP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298675-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298675-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D38CB3256949
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51E3E5A22;
	Fri, 12 Jun 2026 13:39:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49C3E557E
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271575; cv=none; b=PgFUeM0JThddy9jxKMY+x1l6PhqfNnTPLwSFpgTO5GqVbnkoUNvxGVbhibIPpMM7t1QJ3WobTgUwhmuA9kE39VtXaALCmbFPvR5pfI7IcCdfOaED4lHqq2b/qZIiH6AwQjONBZYUG62YAjyXH2+Z7Vzue+84TPjQcymdKNYQq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271575; c=relaxed/simple;
	bh=lYvSM21mI5IdNvW11t4ECXqYviymzd4QCxw07mn2wEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZopC5r9ujASMt5ETSGCraoG8qWIF7OH9U5RYXwauMUl5cZT6Ie9LFSK+dCUwJHNX8F+Lz521Q1fADhfUlZIqEjNnfIlZ0YH+BJHUe+DUUtAfDx2Ud4Kjdpx+z9M86T1L//Gw3M4YJZTWcMivRD8ofgKS35km4ZtlIH24pEvJHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKnsuNGM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tc0h0yDP; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781271572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lYvSM21mI5IdNvW11t4ECXqYviymzd4QCxw07mn2wEw=;
	b=BKnsuNGMAIYFEABng1Q2FVEbTt6G+vGrC8Q9KZ+zVRLca1wlc4bvxFB2+FW88qfQFTBkk2
	kzuxUMzYwc2yz43MelHaxYvQ4xUzdgm+TCB23nAmYc1xxdWKZNRiIg7KCPHNM26B+U+JAQ
	Bu9imkemJe3Yse/m40XGxIP6x5M6co0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-bymZuCLsNZ-FtrOGhY7rxA-1; Fri, 12 Jun 2026 09:39:29 -0400
X-MC-Unique: bymZuCLsNZ-FtrOGhY7rxA-1
X-Mimecast-MFC-AGG-ID: bymZuCLsNZ-FtrOGhY7rxA_1781271568
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490b79e6b94so8567275e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781271568; x=1781876368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYvSM21mI5IdNvW11t4ECXqYviymzd4QCxw07mn2wEw=;
        b=Tc0h0yDPaZtEnGvEvgWH+SDY/N6DlJwKN5o7BYNnX6Xf5YFDTBZ44jS3SvQkhP4/w9
         bt168zNt4yiu/YXRsXBha2Ru7a7FDtZsXLacYj/Ty7l2ARyR1EkeYRTEJRxmngVYsIA9
         OsXCBoWlpfYsSUeo6UPj+6EWPdFb3uQeOBnzVVbuSKJCtMg98/3Xj/te35casJtDwGA3
         Y9Gqvfxcgd8f5rSYl2pcBYrsWqi9O5pbdBnUlnHtfErgUvsUYzizD91wUlfrJNimuNld
         MQ9vLrAHETRprg0HeTxeGBI9CuJyzT7w0Q7Kp0y+ZRkTr3lLVJvrrjSBlNjxpY8p86XU
         1GhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271568; x=1781876368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYvSM21mI5IdNvW11t4ECXqYviymzd4QCxw07mn2wEw=;
        b=AgVoZRSG61l6m4jeS1mULEYPYr4VHDwEdiZoXKby4jrfLKHv/Y6M+4+zdr48X1dCq6
         asQBNSUJlyfVhkvVruaUMTFxX4CftHtyIIoY9gxvaQtF2w3Wm5ioV9RHbZzM7EehXnef
         BM6JO2eL9CYus8pyDCGNvROoDgTmyTiSjoVAWDq0WEPzByWPj/AE3tcxiV46GgVnpv7D
         US1TySXAsFiaIOGRLjUd5QJKZIpafhfGc/Xk5vhIIIbRDeJzPsRBz/AM52NpqGPLQPe9
         QYwbQvr+5ENaPXzrKLt38QHI+qUcye4yt5rMpDQDYdIpmSO34pdOU4L8YwLElaY1l7eT
         jrrw==
X-Gm-Message-State: AOJu0YyxaqDsIwv1uzwBmmBt1ne1fh0jVpX5SvtwT939ZiCwHIFI5N7N
	i8apSEVn6vbilSeNi1ViRZUnxOwB7uVxhOZKOg8YZabp3uNESCXyfeF9nH+0t8E5QqdEHEJvomA
	tZGzLX7pPHkMOjTKf04JiOoKBKFMkVHbpww+rQNCxyti4BkN7+pNXyPPSUw==
X-Gm-Gg: Acq92OHqY+uB7ekK478+uo2Fa8van8db+jtnxt14V3/6Zvy3npC96q0fCa1wd/JEmFf
	cUGc1e3n/KMEfpvgPAoVfc3e692HD13bgWD5UGpeFlSIufQ5GOSoyy77Yd+SGdEm8XSQ7p6y3Ob
	L96oqUkCxiSmmJVCqQZpUCkxVYbx7no12O0TKLJq2sm2KdwDGVtyyww9cj8lWHeQ5OBycWqFS6y
	keyUVbMY107nnZDlTev1PwkAU59y/l4WHn3F2lf9KcF+PXdkmnbBhqJn8VIVLkRdnMP8sSxD+Zs
	4kk5vQy7klDXBq2/VZZUfs5lyJoUCo7sHu2rAR4VR0VE9oPV9i3w7mM8D/4wl+uA340xi/1lWfM
	GTIGtTzC4blLgXJxOUYfwLrBG5/POFHWmtVANCiMSlntA7qQ6TmsXkmLP+Fo=
X-Received: by 2002:a05:600c:3b15:b0:490:ec79:3077 with SMTP id 5b1f17b1804b1-490ec79315dmr40208075e9.16.1781271568223;
        Fri, 12 Jun 2026 06:39:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3b15:b0:490:ec79:3077 with SMTP id 5b1f17b1804b1-490ec79315dmr40207405e9.16.1781271567680;
        Fri, 12 Jun 2026 06:39:27 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2c7ead0sm165992055e9.3.2026.06.12.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:39:27 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:39:25 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 2/4] vsock: fold sk_acceptq_added() into
 vsock_add_pending()
Message-ID: <aiwMAASKtqsiU_1d@leonardi-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-3-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-3-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298675-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5D27679F15

On Fri, Jun 12, 2026 at 04:52:14AM +0000, Raf Dickson wrote:
>Move sk_acceptq_added() into vsock_add_pending() so callers cannot
>forget it. vmci is the only transport using the pending list and
>is updated accordingly.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


