Return-Path: <netdev+bounces-298010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tv5NJNhzKmo1pgMAu9opvQ
	(envelope-from <netdev+bounces-298010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:37:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 284DB66FED9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:37:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BW44ouax;
	dkim=pass header.d=redhat.com header.s=google header.b=OG1XsqcN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298010-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298010-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E88B300C99C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDC83612EE;
	Thu, 11 Jun 2026 08:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDB21CC58
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:37:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167062; cv=none; b=fGHDlo3Mif2J4Klws6gfRBxS+Xe42nQllsGGOU48k27bLo4jn4cdIu7OHoxiWypQaHkDVVmLdy5Loha/UShc924QanoRUKhJs+ppg2RICcadDNEbfGhmrpyDXr8iL0uNll78jT+NnDvBHlrD9Nc5L8o5J8d8GRl0NvdjkklEWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167062; c=relaxed/simple;
	bh=NvlAo8p3VOJuEX4siqyneWFfrKAEXaYb/m2XwzdYDcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITQUyOt2ZjHuS4bOXeFjA9eqHJQPxhlT2C6Hvx5LVcJQGuogOlTXK9y6IRQeSeWMdsV7p6sFDcrjKBVFoyA7N6faufOCs4MSKWdshhuqHLXM9QqWKfDGLm2XXOmqVmpz6kXBhjJDNlKvGKGtIKx6hrgjr/WAsJAMTrrMu5uEmWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BW44ouax; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG1XsqcN; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781167060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lS7ZmG5aZMc+d97NydJ9B0CqAYrDHmwAPTt7zF38280=;
	b=BW44ouaxd6vf35SapD3Y2Wti0n/Yu/QeX3n7GQIyiwLuiRenB1rMqFKKgsNzQ+O5qou+Qc
	wR3jKJD0QOUOZs1nAQMxAZ+tCE6qEkB1sTHD4hvAQLakzrTmS8Q0lSWDXN5YBnpgOc38x6
	56rya67ULHSlm/cQOuNDV2KsEHmbjHI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-Ltu44MhEOhCqLZInxKggZQ-1; Thu, 11 Jun 2026 04:37:39 -0400
X-MC-Unique: Ltu44MhEOhCqLZInxKggZQ-1
X-Mimecast-MFC-AGG-ID: Ltu44MhEOhCqLZInxKggZQ_1781167057
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso76251225e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781167057; x=1781771857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lS7ZmG5aZMc+d97NydJ9B0CqAYrDHmwAPTt7zF38280=;
        b=OG1XsqcNdkrFyq52l9wn5OT3p9f24Aoo95LxCQ4BeZUhgF00YySiZrg8FhTb/m59hR
         NMkqzo3JUG/1H2gDq5iceD3dPIg1C5vmlE64hMXjUAAwTVIuJL3qkyzYMM7hWvcW1ZNJ
         9eFJCRc3A64Oeb5q4/h6WZUltjxwB+lCkAozfyc96yPmDTI18iuOuOz81vJRq4WQ6kH9
         XMDefrutKC+2aOSw5hxwD8budP1A4vq7fFXXXJz0No6tZTPvslLB0qNkdQLQK3IX+PVx
         3k2hCv1Zwj6f/B710Fr3jZGemSeuWZVRKEsqtwakrC1VG2IrpaDgQIrXDKu0ybaRYzjG
         120Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167057; x=1781771857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS7ZmG5aZMc+d97NydJ9B0CqAYrDHmwAPTt7zF38280=;
        b=dyHlpqXEZF3woKZj38YJnRsjDb/cWmMLhrGtwk9bOgdjSFGPfjO2fweseUp/La6hhN
         vRayOAZoLXkdYXM4BgE8KIGy29vOEra7rR0qaojYQvtR3QfVYRNZvxaXsOn/A3X2B5ZR
         axfGaruVYuEssGk0MBqDdL8DGyyefaUiu/UXeEFejanGNpbpoQNZE4RVjm7JnG9dTQob
         uLmh4kdm0KyRTZYeAK6UzekP3rk0SJy2J+9/s8SYr7XsF1Utp7/RL8td9b+soxdUp3YS
         7hqjfVuyJiaEN32Fo0OSTt6TcOoY52NoarZsf3cL4rbGzUn8cQT2FczmLyJXaKwQf6gk
         sQPw==
X-Gm-Message-State: AOJu0Ywf1/ZtIE1e5SER97higWizlvi66WJUA6qg+KnjVW2AVilTtdgg
	BAA614tqR2ClR9jhbgmMLcb+hvv/IV00Al++ylDXv0lhc+LLv8OXYSqbX1b0AfilQtGaYtfjRu9
	XJkdu/y3HPKup9TfGfxcU9Ygx2QkO6lGp5FvLPsCS5IVrrTlSuB1i4QVhHA==
X-Gm-Gg: Acq92OGDn3L6/lP9+ztM+uOTo2PmyUCqMhYzv4ZAyEZGq5JHzfcVBpFvHds8dLFzOaI
	1JrrIUI3V0DznUUy2k8Y7uT0M8ZfQdT66UoOBWrgeppB20+zkB77qMVz3bSk25xmMrdDtQ6GOKk
	xyRJzemlLCcJndF5cDiJVyu6bFTd2GE+4GXbsbDFI3HkVYVFjJSkuACfWzpHaqDOb6wWHsvrjoa
	qb49qpbubw9bVs7aAqkqmUZbJPQxuDZVPIgpSGKI2gvMI8JTU+8FLblx9ObUvUdZMxMm7WKGlda
	PPagHTt3FgYLkSXikG/dph7j0sSN0kas+49F2V8Rnpjq/tlaYX3MRvoEjpHsB8G4IDn8+WgbwcJ
	Su9C5BbgVxTVOQya5bfWuA4NscYvK1cw237GslC4yOqIHmqP3cJeVTTEO7DZrfNo+bleeA2hKTo
	rmEc0A8g==
X-Received: by 2002:a05:600c:a211:b0:490:9d1b:f05c with SMTP id 5b1f17b1804b1-490e5629f6dmr13969725e9.33.1781167056676;
        Thu, 11 Jun 2026 01:37:36 -0700 (PDT)
X-Received: by 2002:a05:600c:a211:b0:490:9d1b:f05c with SMTP id 5b1f17b1804b1-490e5629f6dmr13969415e9.33.1781167056231;
        Thu, 11 Jun 2026 01:37:36 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dcbdsm66492257f8f.7.2026.06.11.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:37:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:37:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aipzlgTKa1OuKrwg@sgarzare-redhat>
References: <20260611023830.106259-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611023830.106259-1-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298010-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 284DB66FED9

On Thu, Jun 11, 2026 at 02:38:30AM +0000, Raf Dickson wrote:
>Replace the open-coded backlog check with sk_acceptq_is_full().
>The helper uses > instead of >=, which is the correct comparison
>per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
>backlog changes."), and adds READ_ONCE() for proper memory ordering.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/vmci_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for this, what about fixing also hyperv_transport ?

Stefano

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index 91516488a7..56503bee31 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -1010,7 +1010,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 	 * reset.  Otherwise we create and initialize a child socket and reply
> 	 * with a connection negotiation.
> 	 */
>-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
>+	if (sk_acceptq_is_full(sk)) {
> 		vmci_transport_reply_reset(pkt);
> 		return -ECONNREFUSED;
> 	}
>-- 
>2.54.0
>


