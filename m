Return-Path: <netdev+bounces-295178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HQtINAJZIWqgEgEAu9opvQ
	(envelope-from <netdev+bounces-295178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:52:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBB863F370
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:52:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=V+ilH8ko;
	dkim=pass header.d=redhat.com header.s=google header.b=VpZCfonc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295178-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295178-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB80A301EB48
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606F5402433;
	Thu,  4 Jun 2026 10:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21011364055
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:39:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569587; cv=none; b=MYW9neqUbHwPjiyk0KzhnYDI8f+Z5Ybgev21fVAXwPpdz9gUtWXvLoxsrdTyyioLbDPOpuDgjeda1rXVpMOVX/v6FIUGZceLS3nlsnTuf2nRLlsqKVh3ukEQ5S0OQrDDNyShZIXoRi0QUR/aVrYIfEeDFaPaBBanMjgP2V3XVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569587; c=relaxed/simple;
	bh=2Vh56h57Z0T91eA8r4mMnsXiuc3McXuOqM+28axWqVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR0PCxXu7fBNQw4dSc5wYaKJgb4Zu9St9fWcSgC3vHZkhuWRoBMtOad3ByCpKM0TlQAEplgfM46jMEtBeJLrLL4OQevzFLqcGo3xqFyai9uR1u387KDlieouUp24lwRYPhhO2DPJR7Fe+nGQ+krYPin8ohrCNs2hKZk8Fus7mbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+ilH8ko; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VpZCfonc; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
	b=V+ilH8ko2mmfkyocfAHnaOlVAw1/mSkIh2VFO/C+EMjewjoRx1oTGOW+4aZBGwSP01JHhn
	zGgpmnHV0bj0jnNIaxkQSqqZgzOyUmOtoTthgx/RbvQY1JKin3It07j5FPtY6X7NzlKcvd
	GfRmWJ7RM0W9aLytT+11hULYCYUE+6w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-o606aRXjOIGYOtgwMUXfMA-1; Thu, 04 Jun 2026 06:39:44 -0400
X-MC-Unique: o606aRXjOIGYOtgwMUXfMA-1
X-Mimecast-MFC-AGG-ID: o606aRXjOIGYOtgwMUXfMA_1780569583
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4601daf4c65so360416f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780569583; x=1781174383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
        b=VpZCfoncwY1fB4+hinZsrq1WO3odm3ru35Jv7VlxAyuFdxyxlFld4YGU6NZPSYXFMa
         Fzap4JsczqbEzOhQYFOt4FwyU7GOfEIq01dDkkx6Ia2HDmbpgi5BGRh64vKL3AlI5B2R
         3ERL7y6Kmxar3lMR960bDa1NEdW8BJxAihz9Ov/LqChhY9dARMIRtHEFRELkrmp5weTq
         sU0NKG2t38jLokSJPwGQH/PqPZ4Xfgsd6MNcOHW2VoJRCCyqW6J9+jAXLxy0dAW/8Z8T
         tyD4AlgEYXi5zkX/dRYKgvzKI2fmRJ8iktitbZNcWxkNtnL4eHNTexK9cYJ3kIL79N+b
         ZVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569583; x=1781174383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXLe0Lyqp3ntcJ5AmrAA7vOVVp+FJ2nW9Yvine+7m/M=;
        b=sjhxthvV7UH+BSsJ0j8Vb5juXPBRlfIbh9WbZygkI+/leHOd9DlDiCQCxhnGv03CQ5
         /q2VXByVM5zMNge1OO8J8tN5XmFjMFINBclpoBb8fmEWasOQKQPqPPcoJoxKrjYg8DTc
         8D4pzEMLhYiyzre1WUwsnufb6UV7VOVAY6vgaYqdSCdjoaZC43coKmP055SfTKepxnsa
         Vw3EuaPvmhgA2JeaFILgj2PiHmbSblTr3aHHAhktfc9FAHrReE9AN4GxoTBUp/DNK9pV
         a1RMI6ClIf7iMqFmLbP74C8ZhdiQZxsvVky7cvoPJbA+0gRZ47QhsLrNwRRshyC52UoE
         T1PA==
X-Forwarded-Encrypted: i=1; AFNElJ8eKavAFYyvWQy1yd17iCSmh+ScSc+jXj2d+zYY5O/W0KDLzRniFelL41dNxTFVgOIb6ua3ss8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnrd7gv8Q4pgJQgr41kv1jHZDImD9yBfIEqs4/DljQvftNCSMt
	U/Ct5gSoqVvprhEtWnD0s9ggStkB0XKcaCt/kwddeuQjaf5yx7OyRYyS6SgsqdhfrQB8Q3kTo0G
	rSSNy9eY/vH5sEVp/ZFtsgVumoyCL1Dj/xrCgzF1t5QamTmg4YusKZLNFng==
X-Gm-Gg: Acq92OEH7Uu9WZYHGEP6eR4EkApThgmHWhsLmYOx0o90JH01U8VzrrlSR6FDv9WQqw2
	POP9jfGIF/UEcACB2ho4Prt3dsmqcqA/bY4/T0nkar3YmTXtTp6AP3QER0ecS5NZUbVm75lZGy0
	iPRejckQ2R3jgDR+i5BapeSYGwqIG+gOEPY2L7Pu5XJlM/B37guuP4z1AlWLSecchvEfWnarQM9
	trb/QnbDo+rlmT327jlFZFncMGvhjwg6IYpKBEfyGm9CZY314r2w3QBe3633tJFhU0ytXfuTQ1J
	q49FdrlRtGL1+8buOcS7u0Rnr93A/UIVL5ZNjLRt+DEV1bovFZPZnBJNc6h624AKVHVVd3FuzKs
	30JL55mFJxGvczvQF+UVtysmCNirrAtrpx7GxYKeQGI2dke+WW+8r/yPDzMdf/COpiheF8sLLiU
	v77tKMug==
X-Received: by 2002:a05:600c:608d:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490b8c0d5eemr115722275e9.23.1780569582735;
        Thu, 04 Jun 2026 03:39:42 -0700 (PDT)
X-Received: by 2002:a05:600c:608d:b0:490:b8c0:d471 with SMTP id 5b1f17b1804b1-490b8c0d5eemr115721305e9.23.1780569582103;
        Thu, 04 Jun 2026 03:39:42 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm25192327f8f.29.2026.06.04.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:39:41 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:39:35 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Message-ID: <aiFT9FBrEW_fW3KW@sgarzare-redhat>
References: <97069506-352b-4152-a57b-5a974320529d@redhat.com>
 <20260601095646.180085-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260601095646.180085-1-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FBB863F370

On Mon, Jun 01, 2026 at 09:56:46AM +0000, Raf Dickson wrote:
>On Mon, Jun 1, 2026 at 9:26 AM Paolo Abeni wrote:
>> I'm wondering if sk_acceptq_removed() should be bounded in
>> vsock_remove_pending() ? (even if that change would probably be
>> net-next material).
>
>Agreed, that would prevent this class of bug entirely. Happy to prepare
>a follow-up patch for net-next once this fix lands, if that would be
>useful.

And maybe sk_acceptq_added() calls moved in vsock_add_pending().
That said I was wondering about other transports, but it seems both 
virtio and hyperv have a simplier handshake that doesn't require the 
pending list, since the socket is moved directly in the accept list.

BTW if you are going to sent a follow up, maybe another improvement 
(unrelated so another patch) could be to use sk_acceptq_is_full() 
instead of `sk->sk_ack_backlog >= sk->sk_max_ack_backlog`. Discovered 
while comparing vmci with virtio.

Thanks,
Stefano


