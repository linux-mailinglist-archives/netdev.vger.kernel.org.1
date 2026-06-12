Return-Path: <netdev+bounces-298670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vY+fIKwJLGp7KAQAu9opvQ
	(envelope-from <netdev+bounces-298670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:29:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF3679D32
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:29:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=jV1TgZMd;
	dkim=pass header.d=redhat.com header.s=google header.b=o5ydDwsd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298670-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298670-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 690C13004059
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5D63E1683;
	Fri, 12 Jun 2026 13:26:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EE31ED8B
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:26:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270812; cv=none; b=mfbfriQcgL0RsI9QBryUemitU0LdyTfmQ9bPc91goQvd75QmQfAW5n1HV43T7+DIgIjedsdQhwI5RWfC8w57CE2fiiDCT8uaMjhWZPcOZzBbMulTDSEoE8peyEWaXEBNTuO/SgG/jsW+3vL2Mal3gyDRFgJb9BEkHfDPl9F0xgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270812; c=relaxed/simple;
	bh=rqNpdonaMf4xUXPVpMxWOBKDwUXW9fTTnr7wXzHdCvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMKZZ//4mvXInasN9sd/cm2NpRgAfhBNRr4HXm6DtPPqpb/Ao65LT7Xjg9gvFvsfv9nFbqr9dMXnGJx7BKBeDKL9FpeU2nY/YKaWKBCI4oH5UPj6GlwywaVhAKgTZRR/YkMn2fDgGMaQesDTvspfsxR/qRhY+HD1183nHSkNAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jV1TgZMd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=o5ydDwsd; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781270810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rqNpdonaMf4xUXPVpMxWOBKDwUXW9fTTnr7wXzHdCvI=;
	b=jV1TgZMdV5bp2nJOlwePb3rOrxON+I7bu2or7hm0A0CYFIIV+DmZQVITifR5KKwW6BQGTN
	xRL2fI6sR2kiLiFO2GIzeJsBm36crSuNJH/uEcdYWT5qe7IhO9k3lMSzKNnWbp7Vlz+qfk
	4ApxC+i0glyd8KnGnj4+KdYj6fghRpU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-f82osBWTMGWwRHj8IQ_S1g-1; Fri, 12 Jun 2026 09:26:49 -0400
X-MC-Unique: f82osBWTMGWwRHj8IQ_S1g-1
X-Mimecast-MFC-AGG-ID: f82osBWTMGWwRHj8IQ_S1g_1781270808
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46011aa5000so438859f8f.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781270808; x=1781875608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqNpdonaMf4xUXPVpMxWOBKDwUXW9fTTnr7wXzHdCvI=;
        b=o5ydDwsdVQOfCnd3spPy9YdzGF76CUUK6McbblAjugAwVPbDxjcfZWDJ6vojkPjNtO
         0cKUSFlH41QQX04WIQCLwMLzyw3G4GrMOxOqVZA0w1CkHZlxDTXjIP6ssZ+cyw2N5+mb
         M774XsFc/Gt1hnGvHnZS/trDoWRN1tgG5ks0jvbtV6CWyiSiTre0bvx1zCcNyoGJxU31
         k1vvcIS/PxV16rmTvhlUjxbvUGzU+wx9dNBlsw3ZticaBtFLQ2KWtjNtMSp5Em9GMBYz
         MjEc3VCiqlW6JeKZsSJFxQNQXVTHbawcu4pgJUIljl0vrdylynKoelzt5hXeddaD2djR
         xd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270808; x=1781875608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqNpdonaMf4xUXPVpMxWOBKDwUXW9fTTnr7wXzHdCvI=;
        b=fKCq/Enf6HVXh8TVjFgtmMiqj2QbEC0to9ZDP6cUs+Z226d+d8GTVYeHW0HWU+t1H3
         lz7DdUEvr8u2xQr9TQyb9SIANH9n0nlraszDcud76baMam5SzDz2nHeGSH6XkbLOWjh3
         k8irzcHw+DbOmVvRn4/AyelDRaLvR4pOlBIMIl7zRL5Cw+Yf1XeHjuI/DIriv0mxE35U
         ofwHIGQJM+wLz6p0QwmHXPx/cHq2G4IKx/QpswaPiiwmOmQHAz+za+6IAZZUPk4/eBEB
         ULMYZo9+NyN6AtMEjiqCEngmcPYbqHvDTmFJxagtMaDKhw1nGXqwzZe9S8SKj4zS8+p8
         x46g==
X-Gm-Message-State: AOJu0YwjGQTyjD+Lq4cMB6SQDQ6sTC4tfW+XVgDCFUXSvZDerZIeLfpv
	rrWvEBv5XtYPNfWXkTaUd2Ckddw9IUADOUI96PKaCkkPBLLiJgJhk4OU9w9M3fBUJgCOnwsHEuY
	MSaHQsBBI+TeSzA1rehqa0FU2Z8aF737xJ/LSNjYw2J6WDAvHE1vi1aO2Rw==
X-Gm-Gg: Acq92OF5aEs7ly48tL6bDhJS6DY0D8A0n3BVgRrg6VEBuENq+dZYCoQxTxLOuSv2MHd
	qqEfY8M3aZEaK37kN1I3IT/M2ZS0jirdSG6bC03MrcRqDAB356KW3sEMPNI75VxVYDgQXPFSvDe
	FijB6yVNKxsSWYrLeu0cas2DhhbMjMVFaK5ZEedZrJ6n/6wcBqXr3f0GXoJJnZNA89XUSCfV1ew
	D625KRXC/sPpoIhdoxtSW4p7je2Fv6zujfnIH+0MiS83HOx4Ao/utxcqt+egVLq7zOEuyyv3BEW
	Bag+Fgn8KGS2XyJzpJvpTPH4j/efCxlvWXOLjTCtlKLajCbYMdIaax3ejAhHwApuuDGCsM7p5Lu
	/eDIKfHSkNWqG2TQxPOW1e15e5HAba0UMV5OlenhZT3PYH/k+NgW0wvDYdqA=
X-Received: by 2002:a5d:64e1:0:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4606da66f9amr4155969f8f.15.1781270808151;
        Fri, 12 Jun 2026 06:26:48 -0700 (PDT)
X-Received: by 2002:a5d:64e1:0:b0:45e:e1a4:c4c3 with SMTP id ffacd0b85a97d-4606da66f9amr4155918f8f.15.1781270807597;
        Fri, 12 Jun 2026 06:26:47 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm6139232f8f.3.2026.06.12.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:26:46 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:26:44 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v2] vsock/vmci: use sk_acceptq_is_full() helper
Message-ID: <aiwI8HR0l_mHyNSA@leonardi-redhat>
References: <20260612045842.122207-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045842.122207-1-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298670-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85FF3679D32

On Fri, Jun 12, 2026 at 04:58:42AM +0000, Raf Dickson wrote:
>Replace the open-coded backlog check with sk_acceptq_is_full().
>The helper uses > instead of >=, which is the correct comparison
>per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
>backlog changes."), and adds READ_ONCE() for proper memory ordering.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


