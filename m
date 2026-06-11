Return-Path: <netdev+bounces-298035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EmjEH1eDKmoNrgMAu9opvQ
	(envelope-from <netdev+bounces-298035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160667086A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:43:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NsFKionA;
	dkim=pass header.d=redhat.com header.s=google header.b=fiTn2Uj6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298035-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298035-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91E26300ACA3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 09:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48D3BE15F;
	Thu, 11 Jun 2026 09:43:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3F28C2BF
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:43:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171028; cv=none; b=npAceq+QSPoP24zampoynXv4MAy8EJHRWMqgQVNcZhdWqV+EmObOMXVX/Wrb2cqKnJEPICPnIjyZa4Ax/xc8N6q3jn7Jg2XdVul1DVUVryw2Wkveozc/e6YI5dJXjOw6yIO0CF8agwYeJl3XcPiiN9rSiSiWY8tdZma/aSB5VDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171028; c=relaxed/simple;
	bh=zwJe9NjwLeRXB4kvfswnxtmZRmzK+isV+tjs2OXPeAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=craYbAcl2giWRPQTJPD/UbXkykeqzxcCpmkTAzM3sY9k0lmrC/A+GoAujuYKYdsFE1dGlY8/accTw2rTOUPdGRUhpl6PmKIs0mRIlfMit/wmOLOsGdQXcnu0Cbof0iT6Y7bK36A1FRgE5wYZO+VNYevLGCcmS/cdwUR3CjMQzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsFKionA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiTn2Uj6; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781171026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HwzXzJxi4t01YG2LmZXdRwxBBtGHBaEKZaxu6bnugsA=;
	b=NsFKionA9Naua45MnjE1ZYaU6GWXM+gE0QA43aiMwbvkpjWuoUIDEqIOABrQ6cnkKbLiNl
	aElacbU/Q4odSs5WStoS+nm5N1bq/7SqjfAy+j+ZBCs2GWMs9Lt6CT+idXwsfMN+1dmSa0
	UbW3/HQs/rW5TXk49VX1DAo52uioRSw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-CFAiPEFQMummoeVbV9ub3A-1; Thu, 11 Jun 2026 05:43:45 -0400
X-MC-Unique: CFAiPEFQMummoeVbV9ub3A-1
X-Mimecast-MFC-AGG-ID: CFAiPEFQMummoeVbV9ub3A_1781171024
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso61880355e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781171024; x=1781775824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HwzXzJxi4t01YG2LmZXdRwxBBtGHBaEKZaxu6bnugsA=;
        b=fiTn2Uj610Z2NBzu23ng6b9uIjR/s3a/AT28XwGhBNiD1vGyPgmCMP0ReOus3nUYKp
         ENKQ632uUdDtdhGVDEtAr4lq910G4aefJRpzHN0V9hzhXPvxb0ui8cTQE6nQF/Cs8YVY
         yLnYz0af/r8BCfaHY5asLvU8UzweZdlDgt8H2iPjSI5OsHBWXfQnTt6GxgsQ4y8VZzyQ
         qC6nFCPR0xcDkT7fYTHOUZtbnRmAP/OEL5jKZ7+j/MqlF15GbRjl7fBgnYbR6XXlFnm7
         cM4kTyVi9cx4no0N/04JtzLFuJiLVN/y8RVoVi0+AbKccb1oH0oJxl3GA0iX47CWYp/d
         iAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171024; x=1781775824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwzXzJxi4t01YG2LmZXdRwxBBtGHBaEKZaxu6bnugsA=;
        b=iAvIV18CU6tCmDCjpDQ0CG51gT8L7gd39fpYjXPeABOVBTX0wWNgra/XABDqWR1/0b
         yd1+RqREkFWZNDDJvF0onSQ5qBC5w+QeRHNSECLVu1McaV9x8Ov+lgOSFq5OSgEESAJO
         bl6cmmesTs3pXHAm1771qW+30eB1RSE/qAPzf+doCi58OSBMXlzK49HRfm+jdRUa/84H
         1Ps8/hA0VmeivOsUpUsgRxSbl54GusADoOtjM22GOtoJqjvNFX710zRYLWw+Yhy4zhn5
         kwJtIFbaFvA9U2a0MTxpdUG/zty+yj/W3Twar2mZxkCslMVPhbyJMe8RnIV0f3188UOX
         kTAA==
X-Gm-Message-State: AOJu0YwxiZSKuSiidiBXKOPzs1cL1Fth7tjHD77ynT1aZk4I8jpd1ux0
	zOLCRbW6w1f+235JkiAPIO77BQjRCd5cJexPFK4KS6rsHICxq1DFoy8Eu0jPuduH0emXGgeF+eD
	4vA6jXVY8PbOml+pgd/1uC2iUqw0QAcm5pf4/ZycZh4Rm5lj7PrZLVOLrzA==
X-Gm-Gg: Acq92OFaH/lyyorDJ9xdTFAsEPZa5riUGZlyn6E+9n7xxMa4lRtdRk6VPKllprTN3HD
	KRx5Zweky3QH1c/4q4/hALWqV6UbWoOu2DFdW9wgqT6hOz+FPgWdUyGaRkO+vF40oRYXrBA0oSc
	GN7lIWRcgp36HE6OsOcSaAa3KPBNzJsq1EAUTW8mzY3gqL2fXw91SP4s5A+vTpe15zipnANdUEP
	nkOrPVNLs29lBH1IPb1J3bDYNNC7g40/pR7WRx0ehdIAUk+4HRSVI0e3I5CH5f8MhgOKzWYIx5f
	lx8XNtElZ5FrhF8G05YI+V6ZVrHx2/mxcBFIozNf+KQChhM6TxCSzWQ4jEG+clBTM0Hy2iZarpH
	9Eqryx8/iWYhBSrAWNh1dlMfHDqsQqXidFLsGss1p1LJnSsZ6HmlHOba92mAyadAbgzeLoIv1RG
	ihIB2CTg==
X-Received: by 2002:a05:600c:4e52:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490e5604df5mr24266545e9.17.1781171023920;
        Thu, 11 Jun 2026 02:43:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4e52:b0:490:958f:2a5c with SMTP id 5b1f17b1804b1-490e5604df5mr24266035e9.17.1781171023418;
        Thu, 11 Jun 2026 02:43:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2ca21f4sm51473605e9.7.2026.06.11.02.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:43:42 -0700 (PDT)
Date: Thu, 11 Jun 2026 11:43:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Raf Dickson <rafdog35@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	pabeni@redhat.com, stefanha@redhat.com, bryan-bt.tan@broadcom.com, 
	vishnu.dasa@broadcom.com, bcm-kernel-feedback-list@broadcom.com, bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into
 vsock_remove_pending()
Message-ID: <aiqC6U87G0FSabtY@sgarzare-redhat>
References: <aipyNh_qseEUxj6Y@sgarzare-redhat>
 <20260611085603.626387-1-rafdog35@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611085603.626387-1-rafdog35@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298035-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2160667086A

On Thu, Jun 11, 2026 at 08:56:03AM +0000, Raf Dickson wrote:
>On Thu, Jun 11, 2026 at 10:35:23AM +0200, Stefano Garzarella wrote:
>> Maybe we can keep these patches separated (which I like) if we
>> introduce the vsock_pending_to_accept() I suggested with an initial
>> patch of the series.
>
>Agreed. Will restructure as a v3 series:
>  1/3: introduce vsock_pending_to_accept() for vmci
>  2/3: fold sk_acceptq_added() into vsock_add_pending()
>  3/3: fold sk_acceptq_removed() into vsock_remove_pending()

IMO would be nice to have also a patch to fold sk_acceptq_added() in 
vsock_add_pending().

The rest LGTM.

Stefano


