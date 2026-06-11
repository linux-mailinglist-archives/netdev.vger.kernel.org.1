Return-Path: <netdev+bounces-298055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+u7A7CHKmpSrwMAu9opvQ
	(envelope-from <netdev+bounces-298055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:02:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C59670A7C
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:02:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WtONt87l;
	dkim=pass header.d=redhat.com header.s=google header.b=HC4TaPoT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298055-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298055-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A45443055438
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CCC3C1082;
	Thu, 11 Jun 2026 09:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25263BED75
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:59:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171965; cv=none; b=Xk/KFxSV0/xgsG4Nz3kiXlvj5Sc7ni9Y5G+T0xhthXFhvLPRFWdn4di9vNUZP3WWkxT3nH6zCS4pXYzCr8W6j2ZOCid/E71x1yGwDtxqgA3lN/VQn7eZvAKkxsPCUs5E451zpWfylfffalAi0qCng9XmiZIpiVI/g9GB+D8p/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171965; c=relaxed/simple;
	bh=ymhkASxbIVWv9j+mePOgKOi1FOiNAz+RhJolG3knZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWO20pCOFqMAQWM1tjCY5U8BLpWUQ/tscgYFgdd+2HwaW6b3YkLLOkq5C/ESMHHy7B2rE6mMljZ4as1gsWxaJDGsrJX0zRv0y2jBBqvLRVkxn0vfQul0nUSDfLd224NZL1qUsrg37wbbC7Y3J3nXgmjrGgBcMYu7h5mdhmJeEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WtONt87l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HC4TaPoT; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781171963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hdogEkd4s3EnCeQjcrov4HvOxfOonGkNZrPgkWOPMM=;
	b=WtONt87lY7wqZ8lGopwp10moE+c9PBRQ4j1f/ceRGNbK7u6bvOUC61YPNbhGir9Ch/xqOY
	JSR/MCzdPmWcdH0ODMKuR43TK4E5llMAi7z9FDiYgxlJXaTvnPU810nbEhaEVvP9h3JMau
	PPKoW9PK7b2dGwp8/8LsHkGG2I9OqrE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-ipugxCf4PQiVFy12PHJDLw-1; Thu, 11 Jun 2026 05:59:21 -0400
X-MC-Unique: ipugxCf4PQiVFy12PHJDLw-1
X-Mimecast-MFC-AGG-ID: ipugxCf4PQiVFy12PHJDLw_1781171960
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef616db45so6605322f8f.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781171960; x=1781776760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hdogEkd4s3EnCeQjcrov4HvOxfOonGkNZrPgkWOPMM=;
        b=HC4TaPoTZIylBnuLCQdGNQRKZlanGOkKR8ED2jWqygxrNycIXcyneByM7f8Ln3G+MP
         lwab1ht9sZMulNdIrlP3zKkMJ+nLAbU/L68lkd61ELKW2f7AHAu2KDfX087vMz0XhhXW
         ePa2tKNOsPJGh+SuayMPNsgyOdR/MbkFnygwLAFBfzdwWfquzuEsTXOEwUHObMbk3f23
         2HTJfKKw699wm1au8jskXLo3K4xtlSKch4Kh54Zw4cWIhR1FheKIJczaPdawjDIox7kC
         RJW5YIR3zfc1TbuaZoaTeq5LaoMoYUmdPR8ZsNB4ljXIzv86UxWEUQ2lJFJ1BP4h0E8c
         z0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171960; x=1781776760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hdogEkd4s3EnCeQjcrov4HvOxfOonGkNZrPgkWOPMM=;
        b=QxXuLknSiuaRYAP6nt+z5N7fAND3W7BSfpqf0zPUq3+i+CfE7MFU0YIopl5MJtsNRr
         tqa/qmCmjYZTy45ROGIbQyDtDC9GkDCbj23hdcoSAQ15UxpZweGY51yMyPf/A/soTed3
         6kSKKTkprYqJ+PU4zbKw+hAF/29KeFaCoYRmP9dbwX+USj4nzIdm0h5hiHH/3rcoO9K7
         lUzKFzP7e2jeFO1NkqaZinHc4aHh6jbmhaQITAmMsmkmYxdHqBFyVpmz2fbfS+ERd3Bq
         1l2TEB5zSKrCO7T7xSltkqUuWBrmZoqfd+aOEJvk6KGUnF5RFSu0J/nHgoDB6VUYmN3e
         BrPA==
X-Gm-Message-State: AOJu0YwqhNLmPgBIQARtL6D1SjOASNOno20na0YBP4vkwFvinLBM0BWa
	Dxd/yhn3qyhiamVzPg/CgQ/SBJ8m1o5/MWXYcN6TkrvyqdXR/GKtQ+5tXJiLkuRpKZon5u+ktT6
	LPChhpAdtuJXKb8lwc8MSkNkTJU90jZvOM1+eqr7p36qS9VEPJgo6Pnuv/g==
X-Gm-Gg: Acq92OH8OCakLT7jpkMXxMeXt9hMG/riN143wtlYY6xbMKu2dOh9/HDplPoJ9Wh7JP6
	H1X7R3NToRF7/+2RaFtjK515HS4O3r+8n1ZP1clyWE4A26yUAV/6mnTXoXBWlQAz3JZ2dq7jCR8
	NlESjDRBtdCtUSiTG+tDakW51YVD/fxXIDJJYIejzVA0p/TUjMikchyDfesNZzJrYd0EA0EvOX3
	VFaw0bd0Lq4uuFJUxOyY9kHzKnvkM+9LdPMqITx/kr39aP9hXPfD1BHGmY3JugNIcmokFVgOHGM
	7kwA+sYNPEHHOja05L6BWBSYbbIAfPD6PYsKecqZBP3XrodZqG/tI+F7YKXjK7jHgWYBpp6UsSN
	3R9e3R99Q6zXUNEqeQpVRnKdUtmAYnc+FNwZ15/pTEWnK3zgF9a4FocitQ27eCrzRmDDmou6Uxq
	IsSd/EYA==
X-Received: by 2002:a05:600c:c082:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490e560b59fmr23257825e9.22.1781171960349;
        Thu, 11 Jun 2026 02:59:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c082:b0:490:4e3e:b483 with SMTP id 5b1f17b1804b1-490e560b59fmr23257385e9.22.1781171959774;
        Thu, 11 Jun 2026 02:59:19 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e52a553csm39112405e9.2.2026.06.11.02.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:59:19 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:59:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 1/2] vsock: fold sk_acceptq_added() into
 vsock_enqueue_accept()
Message-ID: <aiqGyLp4w1zKU9JD@sgarzare-redhat>
References: <aiqCQCdPHw7Ja3tM@sgarzare-redhat>
 <20260611095509.19125-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611095509.19125-1-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298055-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,broadcom.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rafdog35@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:bobbyeshleman@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42C59670A7C

On Thu, Jun 11, 2026 at 09:55:09AM +0000, Raf Dickson wrote:
>On Thu, Jun 11, 2026 at 09:42:12AM +0200, Stefano Garzarella wrote:
>> Okay, but VMCI still need to call vsock_add_pending() and
>> sk_acceptq_added() in vmci_transport_recv_listen(), no?
>
>Yes correct, vsock_add_pending() and sk_acceptq_added() stay in
>recv_listen(). vsock_pending_to_accept() only replaces the
>vsock_remove_pending() + vsock_enqueue_accept() calls in
>recv_connecting_server() once the handshake completes.
>
>So the v3 series will be 4 patches:
>  1/4: introduce vsock_pending_to_accept()
>  2/4: fold sk_acceptq_added() into vsock_add_pending()
>  3/4: fold sk_acceptq_added() into vsock_enqueue_accept() (virtio/hyperv)
>  4/4: fold sk_acceptq_removed() into vsock_remove_pending()

Okay, LGTM!

Stefano


