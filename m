Return-Path: <netdev+bounces-298674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zm1/OjYMLGpXKQQAu9opvQ
	(envelope-from <netdev+bounces-298674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:40:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A13679E96
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:40:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KOfZli7D;
	dkim=pass header.d=redhat.com header.s=google header.b=Y1J5eZLh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298674-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298674-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D61732CF7F9
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F43D305E3B;
	Fri, 12 Jun 2026 13:31:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D333227EB9
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271063; cv=none; b=bPsmUtP2e/pNMd0+mDdg+RyEHkBC2xYAij667jk0P0VIHhLHjEOhR7zOves2L77UhhXe9fgkIfDfo3pkY5QxEvlrm9iR7WIvr/Z0JuZijClVLnw0+1lkvELJox+dc1BXyVBxoyK/C1qSBijwvChC/dVJaeGUJ2H1nDfHLcKhVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271063; c=relaxed/simple;
	bh=o6C89312xo3o8VBjH1GVjeqa52tCtDyhVrUewQ/dMSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8Oprl58DwIPh5yuGdafLx7n7HlBY31Zyf0FhH2lCvrIA6+Cbx34dgbf0u2CkcHvGpZsFm/G3uHron4GSt7ydwKxXbY9Ai1fwLtF5tGgsfuTMEz/ZB0dZTtbheIIJ130TN1kcGqtxcNJN9M2rQpItrejBJ/YCFKEcWGhHg1yS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOfZli7D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y1J5eZLh; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781271061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6C89312xo3o8VBjH1GVjeqa52tCtDyhVrUewQ/dMSU=;
	b=KOfZli7DNFOBj3HMRxgWQRYPoCVU2IQVMj9uAdT4RwZBgwABMyovkT1TBm0tytexGcYFWf
	4vnOm5uh2qIv9ERai8ha03n5zM9a4nFX9/eCvxLG4xgrkuWqq9G+VUx8pfQEC3I3ns1cnt
	GjudmrCnzXNfozsoH34R/etI4Mgw1II=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-1CO4GD7gMlmii8F13xNgWQ-1; Fri, 12 Jun 2026 09:30:58 -0400
X-MC-Unique: 1CO4GD7gMlmii8F13xNgWQ-1
X-Mimecast-MFC-AGG-ID: 1CO4GD7gMlmii8F13xNgWQ_1781271058
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b0682d2fso9622925e9.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781271058; x=1781875858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6C89312xo3o8VBjH1GVjeqa52tCtDyhVrUewQ/dMSU=;
        b=Y1J5eZLhkcW0R6f01t8p9CMFDSh45m9MYloTl0nPsOmGAGVdnacabypr/Ybqy0p8JP
         IT7VNRr5o/K3JP14xjUVHkyDYI/4+A8t6Iu64YwzeRfJBjoKY/fLd/uAYbvhUGzE6s3p
         XxU3fNk64Y7Y6XNVy1bbODHcvBRxyyOmcS3bAqN+F235otk6wiGZZjb20bJT72rTGll6
         xqPdW7ld1TvpTHCnjd+RNYqN0umDtldsf+6WPZYZLk7aP4TfF8IN3b8ZJqaoDrDGaf3L
         tiYIiVin99H1SVN2fWvZHEr/h34q9SWpnGHlgTRyh8BsfIHMcwvIn8tISaSB87/rCS5a
         7BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271058; x=1781875858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6C89312xo3o8VBjH1GVjeqa52tCtDyhVrUewQ/dMSU=;
        b=qc6sIcZYdJnQLn31oKhVIHQZb+cthnCRNVYfBxOw4YoXJkNC23KcotUq3pXZ1/Ufx6
         lznh9N9gi7ZF02MpHlJ5OOtYi8rRiV3UrB8BjflOIweKN9m61zPCnem02LmeRyVWrdfH
         ZhLgpJZPolX09oMFJxXgk29dRTL40P9/TsHoIum07K/nBgGH4LSUmuK2zp2QQE41k1qE
         7+jC2X7Uruyw3Okxs8vU6LbbGe+FDop8jQic5s2SnORkbiKv+U7Y5wz962M8GRnWWwzP
         a4LsSLhf4c3hF17nSxLTlZPbuTJ/May6bEQys5YU2yRLSEnzWqq+3A52ntSA5eAaOpcG
         im3A==
X-Gm-Message-State: AOJu0YxIhjQ1KB7GgYwKDpVwHeSydwn2foYBBdfgQdIdukurPJ+x+Vjh
	ul923sbLGdQHL2sttBZpP4Ky/rxGpwZs8NSPLWWhEUDsZ7Dg/q2G+c9DKkJFqcBltBpGy2GjGy/
	cBIN/3+IKdO0ykpz2zm2ANMEri4IloPj8GxoCHEyo99+hC9B8l+bOIVe3dw==
X-Gm-Gg: Acq92OHhOc6j6k07eua7Evh9YlAmXft4Zjp5w3KN4sML4juUUvusp+WAmBSrQ2vtGWC
	DArvWeb6PPphlY8b5XQ7cmLOFd32UR35mUo0zuCZ+kfOzJ2rlqETtt781YS1iKWPHPABLZ6CCjf
	32kBxOyGf2lrZYTv0BM+mqZUMlMpolIgO80+69qxhrINX4BG6u7iZt4nMjMurt8pqZ1NwdkJKZ0
	/h9EyUl5F99aMYVNt4jkVyh7VqIyox27I2dcHkSLRDm68Y7QGtCQeLigm64n5f5PjWBCgqZfJiW
	IFnBOs5jv6Ey2Z0uBKRBA1kW0YdERI1kSmfIBPH1DLmvhgsXEqidONbcwTM+Sa5lz4fHSt6rDd+
	Oo6DaNBNujkHQabIkIPGI4nRc+5Szkn6nPg9P60ShcVOoJaW4AUxod5fV3xk=
X-Received: by 2002:a05:600d:6413:10b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490ec4b5a6dmr29663725e9.3.1781271057720;
        Fri, 12 Jun 2026 06:30:57 -0700 (PDT)
X-Received: by 2002:a05:600d:6413:10b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490ec4b5a6dmr29662925e9.3.1781271057178;
        Fri, 12 Jun 2026 06:30:57 -0700 (PDT)
Received: from leonardi-redhat ([176.206.21.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea7c0960sm60228985e9.3.2026.06.12.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:30:56 -0700 (PDT)
Date: Fri, 12 Jun 2026 15:30:54 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, 
	bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	bobbyeshleman@gmail.com, horms@kernel.org, edumazet@google.com, kuba@kernel.org
Subject: Re: [PATCH net-next v3 1/4] vsock: introduce
 vsock_pending_to_accept() helper
Message-ID: <aiwJ96DvyETyJ_IB@leonardi-redhat>
References: <20260612045216.105796-1-rafdog35@gmail.com>
 <20260612045216.105796-2-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260612045216.105796-2-rafdog35@gmail.com>
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298674-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com,kernel.org,google.com];
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51A13679E96

On Fri, Jun 12, 2026 at 04:52:13AM +0000, Raf Dickson wrote:
>Add vsock_pending_to_accept() to move a socket directly from the
>pending list to the accept queue in a single operation, avoiding
>the sock_put/sock_hold dance and the sk_acceptq_removed()/
>sk_acceptq_added() pair that would otherwise be needed when
>calling vsock_remove_pending() followed by vsock_enqueue_accept().
>
>Use it in vmci_transport_recv_connecting_server() where a completed
>handshake transitions the socket from pending to accept queue.
>
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Raf Dickson <rafdog35@gmail.com>

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


