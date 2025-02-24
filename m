Return-Path: <netdev+bounces-169192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D0A42EC1
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED967A2855
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D461991BB;
	Mon, 24 Feb 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya8XO8ec"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62519B586
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431663; cv=none; b=TdYisStokFoQRtMJKLctfdOS9N1e2fwL0Ur63VZ611Rzb8g5dRHpltygWBmkHacYYr4tJ/Yk83sVpiEbHcyZXwfYNZIw7Yp1tOk2PPhAeebQ1dXdNidmK+8ThFsdYgy+21ov7Ncz2Iz6ne5jGcncX83uZpBS+8jAjcFOnIfShkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431663; c=relaxed/simple;
	bh=BFFfgUq7Iuzi/xZzLJfSNY8vEGPzaXwotWPI2+nnkzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vwv7tuz8Eqo2rEQxnUqSB+8qIXuj5ObmNfNdWuyJPLKJyHzjAb38mt3iJ8pL2lucLK7XTF4S5LidODoNP1JdsQ6mZH4CWRAAgWx0jPbYiW1NN10m05HoiZIS3IIeyzZMUX7i+rR2WyMYzSUhYf7sroIqRJUOUJpNxnyp6Em2Vpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya8XO8ec; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740431660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3LxYlZbO69MM2I+1jfzNgkosEahmAX1SEjMmy1nVJo4=;
	b=Ya8XO8ecxVGOvU3a4a/GbIqIpEhLvNx/q87wf/Rown5l8WV0jOMt9eGgM8BgD3cuo41BpF
	4Me/Ze3UWMntVjWtHgKca9Pet0oLQIHxT/MB0YdQseYxBCi1Kkd1sEkRdOvZmSa54a54rx
	xcHbvokBszpuXWz1wgxFQUF5UoXsQLo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-hN5xMkBKMsa-1NyiZyPkTg-1; Mon, 24 Feb 2025 16:14:18 -0500
X-MC-Unique: hN5xMkBKMsa-1NyiZyPkTg-1
X-Mimecast-MFC-AGG-ID: hN5xMkBKMsa-1NyiZyPkTg_1740431658
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abbaa560224so464941466b.3
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 13:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431658; x=1741036458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LxYlZbO69MM2I+1jfzNgkosEahmAX1SEjMmy1nVJo4=;
        b=Pff5H9j7k3x0FpG7hitewMYU5ZlDfw5UyAtXvQ1DhbXA2XlChKgZx5kJ5KyNa8GMJh
         25MkEqALVop5DAmu/BJI/bGCz0uXQX84GvDnyR8SEkSIhDq4/bWSToRWhmGohdQMEk1x
         7ISomiwMZlBvCPVWyxwNgHcSDw3ija6+N+Tx4zYZS1ppvzLjTASLcmQUOOJLI6iDFvi1
         e72AJqhBW9gNOb6ku/zrL8Uqf99e1YC/oT260C+PpS4Qa7ePqwLXaCib8kdyhEINHRKK
         ustpjemJyDIVchhBFqIUC1zWhWn0rHTGdpKG24uxFwiix75DHjvGwq7/1YaNueq+3YK/
         yp7w==
X-Forwarded-Encrypted: i=1; AJvYcCW9Crrseq/RFbcrmagHYmi8wRyxmHaGYLGcJlSyMwjRDvyGm0AjD94d07wsdya0RaFkwhrJbEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKwMYh8RbYo2k86iCB69g9yiv66qpANCGKiO8XwF/3jABIn/C5
	lamsWTLJwQzWr0Ni0yJx9IpHZfPdmC54J5Ml67tSxsz67PKMdsZbMio7vKZv5mCyfr7tq0wnelq
	xKgE4+aIn8LUmj+ANQjTtJNFSBNqgnctr0a7zymD+uy48EBHfTxKBlg==
X-Gm-Gg: ASbGnctKn0inFZuDydlNk/GdL2opj9JWz9V+7Jo32PvnP9HHTdWTosfPsCB2BLhfSvM
	fFRBXew/Db1iA5Nd0Fe2/lhKe7s8u1LEsXURfytbvatJETNdc1DeXReKch4PAylyr+UZKTCZYrN
	eUZvavGN6Z4yuytAmnUekkKeyvQtwrKkecY29gCkDE5NnbfOYBBXCQbgKx1bkyS4CUDyF3UG+db
	JU3NJkiAtqqB6uAWBCsgI/yrATBEwySlvRLans0DXdInLj/XtwM1y8wX0N5z4slZt4YRMqE7J78
	CS8BoUYvsw==
X-Received: by 2002:a17:907:7e96:b0:abc:ad5:c with SMTP id a640c23a62f3a-abc0d9956d4mr1429601566b.3.1740431657751;
        Mon, 24 Feb 2025 13:14:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+dg/b+h9Fxu9CEspNCx5tLRGK/k3UMDi1/P2vbRcKxfOCsdjbzH2czU/m3b+8Voz5NZMuZQ==
X-Received: by 2002:a17:907:7e96:b0:abc:ad5:c with SMTP id a640c23a62f3a-abc0d9956d4mr1429599466b.3.1740431657431;
        Mon, 24 Feb 2025 13:14:17 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:441:1929:22c5:4595:d9bc:489e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed204647fsm22118466b.124.2025.02.24.13.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:14:16 -0800 (PST)
Date: Mon, 24 Feb 2025 16:14:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH net 0/2] vsock: null-ptr-deref when SO_LINGER enabled
Message-ID: <20250224161404-mutt-send-email-mst@kernel.org>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>

On Tue, Feb 04, 2025 at 01:29:51AM +0100, Michal Luczaj wrote:
> syzbot pointed out that a recent patching of a use-after-free introduced a
> null-ptr-deref. This series fixes the problem and adds a test.
> 
> Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> Michal Luczaj (2):
>       vsock: Orphan socket after transport release
>       vsock/test: Add test for SO_LINGER null ptr deref
> 
>  net/vmw_vsock/af_vsock.c         |  3 ++-
>  tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
> ---
> base-commit: 0e6dc66b5c5fa186a9f96c66421af74212ebcf66
> change-id: 20250203-vsock-linger-nullderef-cbe4402ad306
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>
> 


