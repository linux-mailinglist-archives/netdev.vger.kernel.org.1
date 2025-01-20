Return-Path: <netdev+bounces-159723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4AAA16A6F
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFDD7A47D5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22F1AF0C2;
	Mon, 20 Jan 2025 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhbHo5mp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916A1AF0B7
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367571; cv=none; b=L6oW3TgJoPbrDfbnUq+zyZQI8bwdRqjl4OV0CWFDTnLshqpguYgUbS1Zd9gcorysacxhN2O+x8Fun+YnnkLABwJtICIynf2R4t0yq5klp0dRc1UZD/NyojW+NOpVdVlaYbx2dHjvdLCRgmTMglC6OrLYF59Sgbi8ytMapVg+rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367571; c=relaxed/simple;
	bh=3vv7HEhplcmKj6XAVb0ipP6+A91BXSteE4FN6eUwCMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3lKwSlx1A/Dpd8m7H0w/HZYOehavo2OTsKX9LccvRGUG5Rh3PAeXSCaT1oXR7cu+S62c2fCNB6SDNpSWxoYi9NGGDdFA0wNoqfFfsF/ddOqFtv4V6FIXkw2sGBJYd1YMXTXWsHwkFDUj18Im3JGgbhIDmR0PBa3IdLBEM3acXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VhbHo5mp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737367568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sYGK8tFGSRuDX9oHSgzktza2gPMT0KCvutcl26VlYzo=;
	b=VhbHo5mpQGPwTelzAPad2C3jo0h4xAaLxmYzvCBPhhZf/0e5zaYK2aW5i0CqxUmbyvBepc
	Z/1kFZc1zagJsXKd8AoHE+fk99/Dj0jBwfkMkbvBy8Kxwl0VDAwKSxGLZ9WybRqRrnGTvx
	REvHBXlIzqMyO0/WcrkhdXYx+vfO48o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-FbC35h9lMQu42_HbMKrOOg-1; Mon, 20 Jan 2025 05:06:07 -0500
X-MC-Unique: FbC35h9lMQu42_HbMKrOOg-1
X-Mimecast-MFC-AGG-ID: FbC35h9lMQu42_HbMKrOOg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43628594d34so22924865e9.2
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 02:06:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737367566; x=1737972366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYGK8tFGSRuDX9oHSgzktza2gPMT0KCvutcl26VlYzo=;
        b=YMIWepe2BfwzX7BKRajvmnvzWaXJ3jdik4XF2WmuRJRsim9pqcHtSC+R2ZWfIFPgIg
         qHKOAJMybD84U6BeSz5xZ4L1ih5gqlZu7WD8K9SI46jdVrT4TCvlzkKe14swtyD1fVoz
         yAYAxtvxBHksKD7aj9pepCXOAk1BwIe1pE6iSshS5WjTmmzVQmfH6+/h9ZG9lbKFdXcG
         DzlWGCufFx51YrD4OV3qWaOGA9FUxabJqMAFcxamPAMuc2ukdZ1yn3Bbl+RDkZ+y7uX2
         6mQ1lA3TAGMmgRbyRZ9po5WO1eHY9BamhApBuzShS4+P/Ct9AcISL7gEiLOhcanqeFlI
         q6Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW8r5iptUuWMyBrSf/gVHanOvQA3fXS02zAd7fugmUDEBSw/KMBVIMpN61wAgx9wlpbcJGfEPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Xsdg32bA4ASau0IqMGj2juMmf0b34ijfN3DhuiS7ssZP92Ce
	1VFttfImq9GV/6JNEkuVcmhUE+cANqJdIv8wUNPCzmCgcyMRAT8qEShEsW3bu1n3Ymz+07r+8QO
	tWdHmrCo7iIyjASQNqNuchpeI/uK34hWVN3Yb6meVBr8ye/7ShJEryg==
X-Gm-Gg: ASbGnctsi4AIVpLHPdKuavNjUMk3MPmtAoAjFIsgYY8dbPpXZGRUBnZix4e7ZruWihQ
	CHd2YeN+6l95jxomcWKB2vD8NhQchm6jQLkSR9Sh3+UpCNtAn+jKQiWE2FhgZxh0RyYjoWynqt3
	HCi8cPfSYyMAxk7Z7iz2YHqq1obos5xUbYP3wYVanR2SEVEVLoUZvua28UZyigDrlAviiGVUllu
	HFl5AXOUlLWBzopnKF0polYR3/0ofPKKhxggnxILpr6wIcIQvn8TF1j1vDkXaP6cto3NYNALuri
	0EPRkEzvBuCMBzvU3lnFtxdxOjqRrtM/8Zm1CcIYPXZSeg==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr100793385e9.19.1737367565878;
        Mon, 20 Jan 2025 02:06:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+FCfAgAmdlOox/s1hXG11FElqFx41alXSFngTtDgQUyG8kO5JQZTuCrHENAI0A2Xmuy92XQ==
X-Received: by 2002:a05:600c:450d:b0:436:840b:261c with SMTP id 5b1f17b1804b1-438914340afmr100792835e9.19.1737367565188;
        Mon, 20 Jan 2025 02:06:05 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468869sm131526135e9.35.2025.01.20.02.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:06:04 -0800 (PST)
Date: Mon, 20 Jan 2025 11:06:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 2/5] vsock: Allow retrying on connect() failure
Message-ID: <cgl6ydknchpqgif2nvofqyus42va5m7ucct4oi6mp7bniuexj4@n7vedkravfl3>
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
 <20250117-vsock-transport-vs-autobind-v1-2-c802c803762d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250117-vsock-transport-vs-autobind-v1-2-c802c803762d@rbox.co>

On Fri, Jan 17, 2025 at 10:59:42PM +0100, Michal Luczaj wrote:
>sk_err is set when a (connectible) connect() fails. Effectively, this makes
>an otherwise still healthy SS_UNCONNECTED socket impossible to use for any
>subsequent connection attempts.
>
>Clear sk_err upon trying to establish a connection.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index cfe18bc8fdbe7ced073c6b3644d635fdbfa02610..075695173648d3a4ecbd04e908130efdbb393b41 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1523,6 +1523,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 		if (err < 0)
> 			goto out;
>
>+		/* sk_err might have been set as a result of an earlier
>+		 * (failed) connect attempt.
>+		 */
>+		sk->sk_err = 0;
>+

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 		/* Mark sock as connecting and set the error code to in
> 		 * progress in case this is a non-blocking connect.
> 		 */
>
>-- 
>2.47.1
>


