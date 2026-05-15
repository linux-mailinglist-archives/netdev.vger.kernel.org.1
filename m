Return-Path: <netdev+bounces-288258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB8xEcruBmrfowIAu9opvQ
	(envelope-from <netdev+bounces-288258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4576554CEC0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A5C6307140A
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D727243E9F8;
	Fri, 15 May 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTqsSE4V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICnBetIE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B143E483
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778837624; cv=none; b=bKGcEZ8x7HNVd1o9BG4u5xy4xBDvPMstXtO/TAiVbn9+5dqdD+/8kf21MSSL9fQLFH0leJQbBRBY2eHwWmhNTm2IuYqYSK7wAPXsgvrgibkq//TUGDSy3dctCrpElp0C1lcdc4k4QshUv9u6WwSR4aKe6ik18GfaGh8/3DxxwLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778837624; c=relaxed/simple;
	bh=HzcXf6Wv0llfWEbLwfcl50s7dD+w0VdR0+2YgR8e0cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0GmxSUYqg0Lp2ttINc/+yiBjFJfc1NDqlzmCDTwfIe0OwB3MtPXtGXnTVvn+3Jm2yT3JUo6Em191q2KMPfZRoigjGJCrCZlDk1ucFhqdeBQ/zW838ERwYZYe34HQAIgt+s1g+Uie7ee48EODUIV7BQcE9Jz/AC+7VkWYGyWFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTqsSE4V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICnBetIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778837622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
	b=GTqsSE4VbNGNslqFCC5aVWd2F/WA3ZBArxesoUf4rEss6IRh8NMSm2NM1xew5L6HBga1gR
	2CVsLwGF5gYutfEZ+tY7gP0OTNVinJMB4zOUdEXWHVOhtkn7V7xQp1QcPnsjs3KsLDEKL5
	KDM6wSaZBojPbD/7CVHgu725FnBreOw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-4hLUdkxwM7WI8KggGLsztw-1; Fri, 15 May 2026 05:33:38 -0400
X-MC-Unique: 4hLUdkxwM7WI8KggGLsztw-1
X-Mimecast-MFC-AGG-ID: 4hLUdkxwM7WI8KggGLsztw_1778837617
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44bf1ac8893so7728730f8f.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778837617; x=1779442417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
        b=ICnBetIEcsdH3ztEsUar6b0l4Qf/HCIccRrik2R+qjZtiKe7sQUo/l1/HzqtprsPFp
         AEZ7CoZD7mxKrk4mHHN4xux5MOecNMn8wkZkB+IkCozFohG1QytK6zfq6/SNNr0UlZYQ
         Pa1vG2GBmhX/yIuWVdOlWljJjAMD3W1xJGoScq6yaBCPthOjDC/3ZI5nIjMM79d7PeuS
         XugF5T912i/caFWq3PfHNzoJNs6bLhAR8syRHJ1iKYESMDaKHBreg+OdcFtO8UwxMxmM
         aMrzCZt7X7xcEooWSqyKeLyGJEkozi8fsR+F5AbtLPQM0x91V6W2eyIcYihoktRUnYog
         PBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778837617; x=1779442417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ42ILoPPEodEg6ZEuswA8B5A9RnneHFtROSVsVKJFY=;
        b=gAgvo4hYqmEojZz9vIIXsWbiZQHbPTU1yO/JjFpsQtJ8S+x/Hw68R/Rh/N6hA5qztg
         v00ceNgfcBEhVPRkSE9vf+GsuuAwpqgtjBjE7qlM+v6l1j/c/E3BLgEsZiT0ZCjohXHj
         Vu3o1QypDf+l0FBIlHevLB8MSp4Y0ypPFzez4iZMWo9BLxmA1ayb7p+zWmr/CAT3B6Uj
         Gf52BR8B1+8QMCWwtgvA06TIMJzvUZCZ1B3Dpx79hEI7uytzlS1FZxKBwqlXKoV0WFTD
         lRGvYy/jAOLd/ve/twsmjpuG3tVlavJWUgqnTqxxvV9XSNcTsydFHuXTo7wvCBTcIJlE
         u1JA==
X-Forwarded-Encrypted: i=1; AFNElJ9sp+5+ZJOZwk0RZ96AK4CTQv/0OggWuZ26sb8K2QYz8PoEP7wQfzsWFIe+XgdDzI1bwqlqbXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyzXUcPJW+h3ynXypG/BmquERJ5c7OIBQpzg08hAjr0m1iL3d
	3iNqrlUpmBaakse/tRYGBFzmIMwb+FlMdG6eJwsOcC1kXir7u92hkdA+/4TYoBLHNZGa/WLsB6k
	fsmwFGqJP2ybm01O6bMLDYhGcot/U5gh65aFKIk0fcqx5DCckCZr09D966g==
X-Gm-Gg: Acq92OG3LOxHt5ehOcHPOvQTh4rnCLSAjlQXhvcUGDYLNfF7yH76Cc1HX0Djt6jfXCf
	J7MmViR8+eyc3d3AswoUnban3PhmFjmhDnJUXDLbtlduiCT3Lx95E5whL/LRCDb92iLydkAcsTQ
	mGrq1sQPD4N7xcQxxVOmdlTJ9r0RyiPuHFXqhedriqXlHB2fteJXhVboF8Z6e+twjLhPjpthHh4
	vnmPCvSrMaepC4OYwuz8nWdt/l2hmvMfuzKkhl3shbMI335q0R1NbyU1h4E1E6HuWqFgjX4g2ow
	oHkJ5ssooM0Jo7UlK2SOhtEEyw3p8sW/APopU1RUxsnqgHSTQ6bZBwn/tzZ2gNBsf2vp0nRN4tT
	xg9y8PkWJUlP/d+7abFXcE2MIvRlmw2hrKjLz5wH1nvvpS38GbTQcW1XFesE9WYrMefy7S/6omw
	==
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr3913458f8f.8.1778837616861;
        Fri, 15 May 2026 02:33:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2288:b0:45d:4532:5d98 with SMTP id ffacd0b85a97d-45e5c57d2f2mr3913404f8f.8.1778837616358;
        Fri, 15 May 2026 02:33:36 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768bcesm14392867f8f.4.2026.05.15.02.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 02:33:35 -0700 (PDT)
Date: Fri, 15 May 2026 11:33:31 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>, mst@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH v2] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agbn_R2XtH8K7aH1@sgarzare-redhat>
References: <20260513145842.809404-1-polina.vishneva@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260513145842.809404-1-polina.vishneva@virtuozzo.com>
X-Rspamd-Queue-Id: 4576554CEC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288258-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 04:50:04PM +0200, Polina Vishneva wrote:
>From: "Denis V. Lunev" <den@openvz.org>
>
>When the host initiates an AF_VSOCK connect() to a guest that has not
>yet loaded the virtio-vsock transport (i.e. still booting), the caller
>blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT.
>
>A caller that wants to know if the guest is up yet instead of waiting
>could theoretically tune SO_VM_SOCKETS_CONNECT_TIMEOUT, but it's tricky
>to find the right timeout, if not impossible: there's no way to
>distinguish "guest won't reply because it's not up yet" vs "guest is up
>and tried to reply, but was too slow".
>
>Furthermore, this delay is pointless:
>- If the guest doesn't initialize within this timeout, connect()
>  returns ETIMEDOUT.
>- If the guest **does** initialize, it'll reply with RST immediately,
>  because there won't be a listener on the port yet; connect() returns
>  ECONNRESET.
>
>That's also inconsistent with the behavior at other initialization
>stages: if a connection is attempted when the guest driver is already
>loaded, but nothing is listening yet, we return ECONNRESET immediately
>without waiting.
>
>Fix this by checking the RX virtqueue backend in
>vhost_transport_send_pkt() before queuing. If it's NULL, return
>-EHOSTUNREACH immediately.
>
>Callers that used to get ETIMEDOUT will now usually get EHOSTUNREACH.
>
>Signed-off-by: Denis V. Lunev <den@openvz.org>
>Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>---
>v2:
>- ECONNREFUSED -> EHOSTUNREACH.
>- Use vhost_transport_do_send_pkt() instead of raw .private_data access.
>- Removed READ_ONCE().
>- Wrapped the condition with unlikely().
>- Updated the comment and the commit message.
>
>v1: https://lore.kernel.org/netdev/20260511145610.413210-1-polina.vishneva@virtuozzo.com
>
> drivers/vhost/vsock.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

@Michael I think this can go with your tree, right?

(I don't see it in https://patchwork.kernel.org/project/netdevbpf/list/)

Thanks,
Stefano


