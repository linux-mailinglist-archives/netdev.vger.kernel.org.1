Return-Path: <netdev+bounces-273235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCc8NsaOymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:55:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C90A335D3CF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCC283029B68
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DF93271FD;
	Mon, 30 Mar 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSwD+96+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVSu8fm2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D29327BFA
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882007; cv=none; b=Pz5r3ZHHFLz016R/hMYIye1gYyE80Sj736i+kgPsqxfh+drN09+M6RCgU7+epYqzXNzZBcUEtottbu70tgmtZ85EFrrIjwk0xAK6ZhxMOKaTqPnvJTTXa8wdP0itU3vmxz6/8KEZHxlxjBXxMLlxOo3UrRWn3LARLWsCxNzI4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882007; c=relaxed/simple;
	bh=+5gTHg4vDOFdaFyL3X0paJ6piTE6QKBmaZjfG+KdWvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUpCYv7/Pz7HasLlaKYt+9gGXBm+pREm2a6QDMnApbGymXnzh//cJRN7HOhVsnlF3/MwvIQEKO79LDWR32lnX7zp5tE6Bdco7hkgWsxh2joAFFo59fV5hRbvUJbAg79odM6oQic/MpYnlT82e+x0xTNM6R2Ltvqfh/NYzsIYdMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSwD+96+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVSu8fm2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774882005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vE5lW6KIYn9Crg+NxmWP1FduSgxGLW1hAif3uAMklrc=;
	b=NSwD+96+jSISV/VIiK8wrOc2BvAm+dCTeIpJx0RV7H28+kVc7OyzGgwN4LEZGw8q7rremf
	4UKxm5C5GK8p5MCtuqCMduV8ZsggzmeFrS6y6jX1EuBExnzU5AFc5tp0BMQisxeuzoI4Mz
	UBOvddlnuZzvfmUllexF1iaw0Hsf1MA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-N5bIfgkhN3OTd8N4FzDNpg-1; Mon, 30 Mar 2026 10:46:43 -0400
X-MC-Unique: N5bIfgkhN3OTd8N4FzDNpg-1
X-Mimecast-MFC-AGG-ID: N5bIfgkhN3OTd8N4FzDNpg_1774882003
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b9b8e3af6so2480105f8f.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774882002; x=1775486802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vE5lW6KIYn9Crg+NxmWP1FduSgxGLW1hAif3uAMklrc=;
        b=NVSu8fm2ZDVffeaHuQw16pwRMrizArQAhmpviggZbdoqxiuuywIFXWq2Pe5iE/luxG
         vIP8lHceOyK+R3CYdd+gECvy2kplD8t1fdBsZOyDrR7RHWtsisRV+cMTFSGVDLUtUZSK
         sy2TePNXDXfD7CUJnTwDoRcRVSR3pqah9n+IqWvwMtDPCUwAkiE/CYrjsiNWouu9OLb+
         qpdymWZYOQTIAYQjSjt5sp259SMzxudwy0zqaZ+8lyPHsTaf4kGl0/i3OlmDrHl1oyXN
         SPAG7EwlTBPJ5Ciue88qAuDBN1WTFv8dC+HjaaoyTAieeoBbadwvUVxRptpiqTFaMdD7
         jwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882002; x=1775486802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE5lW6KIYn9Crg+NxmWP1FduSgxGLW1hAif3uAMklrc=;
        b=rVJUVAHxv9rc9jhKaBDMZ5wUA16fMnK1/wmwRKvHGnLmYbYy3bRb0bf0oMOK24lRBB
         sYI1/8kIdpMm+JRwSJClJ3EEuu/xXUwxfBya1z4O5tkZiEM28UoCDNDLXItb4f7L/apk
         Af2F8MELy8uFCB3meSaOBI2WuM8QDDYIBFFf0qdvFZJnwM6H9s7CYAqhc5lHlztHgomR
         nzjm0tzpquBYiseNJgTfRq012oRbdJ7+Tu0BwrMH2Y04Q945W1HY47gaAlheZLnmlxYl
         bu2em/e+mJL+v3Al0uK+hnYIYhLHoIe8aOkRElCffxp2NbFZQ9UccSwP7/O6dciZRXkQ
         E/gw==
X-Forwarded-Encrypted: i=1; AJvYcCWIrKdtoOQ1lZr5NpU36lg1JMw1b+vuryJLwkOdwkZ+ENMeeX6I1tRIB27kXLmIOOCfwt7EqrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTt04KcYokqEGtF0gvBoHddi/X4uMtKsIDND+FQPUTaGP03HeK
	/vCLYIVIQasp95htnjTm/iNtyw17lXy8wZe9lL8HDtXfrj+dTuiYmp9bAqL7hyv3BrBfCF2Sbpf
	Kza71ooVBoJLO65YP2Kl/xbhDnTI31YoUYfcIfu9dDrnZRvYYLsgja6CN6TxTqYRn2Q==
X-Gm-Gg: ATEYQzy3/RI0PjaeE79s06gYXVrfAo27496h7k8yYyEGbdOW9svgYjoTFnFnlCMXrLb
	CguPAc5nYx5Bk+LOc1Niti429DAHz2Kdni5yg5kGcEOZLE8THnRFmMAYhoF96yEtNYtz3+gjFBl
	YTONtKSVXEEndRXoOlC7E6HjUbJngPTlbVtO3UMiSFkMU/yQRGwHhmUwEf5Zmb0h86tvO4kcoy6
	plZOAnMxrKMW8UnbaeeSy5p9DQ3XONPoq6b950+J/aXAybnyell/21Cox423IxapvXPbDgn+tJq
	ktNKg4VZsbMhZWCI4UWSTispbtxDwsaqohXDu8DPlKoOMxij2YulvieVIwGyvFmFcLjaluo8AxO
	1aQffB4uCyyXCih7l9w7EemNqvnFz77SRSvebn79t8OWUO/xUrBHl0tH9VvotwawkER38NxqEdG
	Bv
X-Received: by 2002:a05:6000:2505:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b9ea34773mr21701246f8f.14.1774882002058;
        Mon, 30 Mar 2026 07:46:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2505:b0:439:be78:e1e9 with SMTP id ffacd0b85a97d-43b9ea34773mr21701174f8f.14.1774882001517;
        Mon, 30 Mar 2026 07:46:41 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e9e24sm18330997f8f.10.2026.03.30.07.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:46:40 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:46:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	Valentin Lefebvre <valentin.lefebvre@suse.com>, Yu Watanabe <watanabe.yu@gmail.com>, 
	Andrei Borzenkov <arvidjaar@gmail.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Luca Boccassi <bluca@debian.org>
Subject: Re: [RFC] loading vmw_vsock_virtio_transport by systemd breaks
 vsock_loopback autoloading
Message-ID: <acqLo6-IQVBzY3UW@sgarzare-redhat>
References: <20260320110224.GA140154@pevik>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260320110224.GA140154@pevik>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,suse.com,gmail.com,debian.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273235-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C90A335D3CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:02:24PM +0100, Petr Vorel wrote:
>Hi all,
>
>there is a systemd bug [1] which causes vsock_loopback not to be autoloaded due
>previous loading vmw_vsock_virtio_transport in an early phase of boot.
>vmw_vsock_virtio_transport requires vmw_vsock_virtio_transport_common and vsock,
>vsock_loopback requires vsock.
>
>Reproducer: [2].
>Proposed fix in systemd: [3]
>
>While I think the bug should be fixed in systemd with proposed fix [3] we'd like
>to know opinion of the kernel vsock developers in case there is a way to improve
>vsock modules autoloading.

The original idea of vsock_loopback was to be used just for 
testing/debugging, so maybe even the autoloading when no other transport 
was loaded wasn't a great idea, but at the time we thought it might be 
useful for testing.

In general, therefore, if you want to use the loopback, it's always best 
to load vsock_loopback.

What use case is being affected by the fact that vsock_loopback isn't 
loaded automatically?

Thanks,
Stefano


