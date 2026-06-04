Return-Path: <netdev+bounces-295179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 37pUKENZIWrPEgEAu9opvQ
	(envelope-from <netdev+bounces-295179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:53:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8763F379
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:53:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DLtRb8+Z;
	dkim=pass header.d=redhat.com header.s=google header.b="Crzq/dCV";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295179-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295179-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D30753073A1A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A12402B9C;
	Thu,  4 Jun 2026 10:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C3402453
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:40:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569611; cv=none; b=Qh+/RGSkmfwOCdw5vhhJBnuxlTF8EaLuSTXbHht3PiffMDa7noOpw/DEjmF4LE1EuGoMv0aLAIxL73NSNbUN3GVxlzWSA6QRZ8SWVcaovHaIafNEOECIySU/nrj/zYk0QoP9RW+VXSaFVu8tU4vHjC+H8ZN9u7zFSxODP5j/Pdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569611; c=relaxed/simple;
	bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwJreqOaKUcHRQas46d9XBcri4KfBn0eL58cFbT4YU3CHUP1CxNE6Yo5ALawifW1aFfrS4cIyvBz9B/DS8URwpiZvzhpcXXHhYQjJ2c+zv20d2/1XS1h7diPGvQV9Sx4pt2tCXsRlP6K7uvvqxoPh0oQp0bbpSSOdcZsUnQ3JxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLtRb8+Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Crzq/dCV; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
	b=DLtRb8+Z1Da9Jruixea5zHoP4/v9f4h/qTwEDxg5OkH7ct3MklXvzIepTfOOC4AtGnejM2
	G26UBO+WbIuLhJzkV0OCwQ0K5yloDSLBADIinLYTVLuKbvw7ow8tdDb7rrLx7fwd5L1gkm
	z33JZ1IiuQnGZRI+rvrOeRpU43puD2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-oMXQNluYOcWjVkRSHNek-A-1; Thu, 04 Jun 2026 06:40:05 -0400
X-MC-Unique: oMXQNluYOcWjVkRSHNek-A-1
X-Mimecast-MFC-AGG-ID: oMXQNluYOcWjVkRSHNek-A_1780569604
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a060eb84so4069155e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780569604; x=1781174404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
        b=Crzq/dCV3JoDc7wD4S95Jx/MY5nmnVkxSmMkIgApvM/KZWrx1mFpVG5OxRcvyVyj0b
         tl95cBOgTsdwhK4Tl9f281gCrN/Fj3UwRCmSa4e34DHCieiqmtRyGRnOKgjo8ETlmnyC
         WbkOtOAMGFaau0m6Pys13tOME0GgHAhjk84zWyHtvd8JLGnVEF4b1O0ythPl+GF3rXEi
         Kql6IJDPBVsZ+uie4GEDIGrA3Xgeo1e0gzcCkBsNrwJjsbCOzUTqeAc7YMQ3JSCGSAbw
         kkrEc3PMNWYDwOg0ahMNVFDYBZRafw5BQXodDkZdPewfRZtjNRKAPOKJq+W2pfk5iL9Q
         uJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569604; x=1781174404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgX+c99SJB1lXKqlQ8aRE/jWzmvN8g9EUrDawofw5ms=;
        b=CzEds8LfAECJeXKYOufc8YLNaLpm/OD6wwHfrzUj3EBsHj+lV0+WCi+jjmzT1FFY1Q
         Rcsv0YR2LaqgKTzCnJ/KW/mbzkke/VSh4bA37NqDrpwBMnqwGGddB8lpi9Nl2IV1fNFI
         yLVG4yOuJQbgNH/nyTFsD6HbG71QO2cep4bbfl/rk/Aw82u2HYwV6u6WddAaEKggGKP0
         N3C3Iz44A+jvZ5Z+Sj5HDfv/srjeYG2wLmlU5nrm4qctIEe9iHRhB7Rf6vLSwmMi3mGo
         w2B5sV52zh+dGM1ny+zwhPLRqzXfPy0hgbcmwGo801oOXrfglVa0J0Su0nz+kq5zvqqs
         BlCQ==
X-Gm-Message-State: AOJu0Yxymp41d7Tj7mpCQSQHL5Csjld+RfHwTpFrRVi/80HY0jBWdGDB
	i1gVSXNhSjBa1iBvoHRUX2nh5LrZMVSjWnYq7SSB2TXQvjVfViHIZ3gnCwUnV6YCrkNk8kNoSBk
	owdjwdVkkg4JX7KB2x/oFbg3pRhzzLLZAAbBr3AuLC+YJMZ38pzAG++jf5A==
X-Gm-Gg: Acq92OGT8SpS0eKTCwTT9MoLn8I18lRPvMfV2W8EcqLGQoFwb7yuzfDFlms0YnkaZCl
	WsvB/NpZ0rvAx1I2i+1BP7gTy51d0eU+vAh9vHTSlJF2tyQtdeZ4gn7jcsnHwgMDy9RWg4xsv7w
	KUkMArR8GIBucNV/7BDAsVhTYfzBgpLWcKbyPXSSKZ337W2mWLsLONVc0VqEJD/QBqzlqin2Qpl
	T+wEVTIh1oIcPEhMPgv+TY6BObcvUWInleDrpSH+7pD8BpvdWmCoe9F44TYaJj374PxSefwsvX4
	SAXsuAW3w+vxQq22P9BB/2DOPdCFx9UZC+Bc3axepfC2pPBMrDEY547+VlZetOf6LnQ0O6qC0O7
	ERqFdz2rI9qqV62vGrALcXK+SkOJsQsOFTv1a+ZR1c5xwiGw72nbgcYLmw92tPab8udlLN6P0bm
	NYtfbnaA==
X-Received: by 2002:a05:600c:1993:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490bb19b19amr71419115e9.27.1780569604428;
        Thu, 04 Jun 2026 03:40:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1993:b0:490:bb19:b110 with SMTP id 5b1f17b1804b1-490bb19b19amr71418665e9.27.1780569604008;
        Thu, 04 Jun 2026 03:40:04 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm73719575e9.1.2026.06.04.03.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:40:03 -0700 (PDT)
Date: Thu, 4 Jun 2026 12:40:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/vmci: fix sk_ack_backlog leak on failed handshake
Message-ID: <aiFV8w-cvY2jUsqb@sgarzare-redhat>
References: <20260526104356.469928-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260526104356.469928-1-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295179-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18B8763F379

On Tue, May 26, 2026 at 10:43:56AM +0000, Raf Dickson wrote:
>When vmci_transport_recv_connecting_server() returns an error,
>vmci_transport_recv_listen() calls vsock_remove_pending() but never
>calls sk_acceptq_removed(). This leaves sk_ack_backlog incremented
>permanently.
>
>Repeated handshake failures (malformed packets, queue pair alloc
>failure, event subscribe failure) cause sk_ack_backlog to climb
>toward sk_max_ack_backlog. Once it reaches the limit the listener
>permanently refuses all new connections with -ECONNREFUSED, a
>silent denial of service requiring a process restart to recover.
>
>The two existing sk_acceptq_removed() calls in af_vsock.c do not
>cover this path: line 764 checks vsock_is_pending() which returns
>false after vsock_remove_pending(), and line 1889 is only reached
>on successful accept().
>
>Fix by balancing sk_acceptq_added() with sk_acceptq_removed() on
>the error path.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Cc: stable@vger.kernel.org
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>
>---
> net/vmw_vsock/vmci_transport.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


