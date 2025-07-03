Return-Path: <netdev+bounces-203761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EA0AF70EF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C65D7AB882
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DD52E2EFE;
	Thu,  3 Jul 2025 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3N5BSfF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7829B777
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751539899; cv=none; b=NIgChIfzOaiqKtLdmWsw7oEYhIXPJLT+Y2pGT1lZey4lDnK/6tYb8ulBADL1WwMQoWqGHIvfn79oTGsjyIry41WOh4idWvS2CwefrCWM5+OlhngoIUq3XEnl0PuPsRR2YN1m3tOabd/v9BL/PnBTX1eeb2d6sUtjIwPB/yhIK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751539899; c=relaxed/simple;
	bh=OqvSnj012lk+x7sxrjtbztoI/YmrJYSA0WWNrX5Fpj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu3DZLf8IAf9zcJM7nvrLKyF6DyA1HV8sNPZoWD81lqK15CyfnYSinxDj2zRVVfkej/cZ1jba475wN9IQkRnDX8hXqnp7gdlvqj9qsEtnDMm3uMhjeHOwa7P6AtGzMCDmLFYV4rlc6XCfIhi85yh+ZpZKrEVHx+6c4moZNtzr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3N5BSfF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751539895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PTP2cROOIMAlCq/5T6gTKModShdkxtZnGGTA7OvrtwI=;
	b=H3N5BSfFWDrDRV95R4aNyBp5ThsfEFj0ZFfB5N4BWe0DoBQDyFqXGqxUA2iiMrflhrngaI
	tqOuScSSAMqeuWdoypEPKy+oITZSNvdDc65GjFNU9Ma9TKW/8r9m/ouFLgJQmKDwpSXugy
	s4MJFShFlRIz4oCl2Fkjg5jZU9aLGMw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-GXFoJLxKNhiNuaxI3arOlg-1; Thu, 03 Jul 2025 06:51:34 -0400
X-MC-Unique: GXFoJLxKNhiNuaxI3arOlg-1
X-Mimecast-MFC-AGG-ID: GXFoJLxKNhiNuaxI3arOlg_1751539893
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a54a8a0122so3962557f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 03:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751539893; x=1752144693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTP2cROOIMAlCq/5T6gTKModShdkxtZnGGTA7OvrtwI=;
        b=raofU77fNxHHEcPjlruJJWIEpUSjDjFrLgsKpCdyHjBV6reMR68XgEugjt+4lQuwN/
         hwVIxizxsAgBO90c2S/73SRF7G/mA4Z1Mr6V5BS+sV90/wpUGv5ccZJ4qVj7LXW+6Nfk
         Ehzd+lxWQ+WqaVm2cvDHwO+nkK4sDPlLeHtndzkgpsonpSo6Ex1F7Wr1wauhSMsq3gBO
         CZe+ZZzjvgez7LHRl8mhep7F4LjF1tmaBzJjk4HTVCVoA8gykj2zufmSOoVIK8uQ4htZ
         Q/lPeqr4TUQQG+noiuaI8X8dK7vG+8mp2sIwtZ3SVoX8ZyF0jz0AKZ2Cb5giKYsrHRrT
         xAHQ==
X-Gm-Message-State: AOJu0YwPXo7REOXzbgEf1cI43vCx5BKS3NFAKjuFSU1LYaxpFpofHcqc
	iJziucmICzdoc0E5mdQQeqyI6VvNf24KcAjpQZckGXQabLDQ4ygUhv7yySKrKdLJN3vp0R4eAaa
	bQu5ScdWVMnKSIKbOuZxogdTCznZqS/DkUElJaHGymCWdLazlUq7ZeQSMvw==
X-Gm-Gg: ASbGnctFygckinCWMgfjbr16UfOuzMHm6QLmF3buz5hk05x2URoam+6FTKl+ZFwn/T0
	7QK2e8S7uhyVhn2zF0EcrYK1KP3XPQtmP1DDDKZy2sFQ11CYsRf5b5moJPUKKt7ESe2vdYFsL48
	/W1VZqXR2i+vXc1jSVEmNM9ko10LqpXC9c4soRn8TcxN8g2JSn7BFGTB5Rx7jddCCVg/XkVmPqY
	EaPimhuBrG2TCBr18SRblgncocc3gpuUeV8BinPP7dF7qb6fCLEsokc1jMyzIZn9LSEmKttzQt1
	8Jfns4B01hYGd+IVYqHMmnmqBIJT
X-Received: by 2002:a05:6000:98a:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3b32fa3aaa1mr2092537f8f.48.1751539893411;
        Thu, 03 Jul 2025 03:51:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaIrtPC6+L1M9apwjRSTfcpVN1M7WJhIIwoutF3s+xjdaNvBgiwXew6JQLCZDeO5sbSJK9KA==
X-Received: by 2002:a05:6000:98a:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3b32fa3aaa1mr2092503f8f.48.1751539892823;
        Thu, 03 Jul 2025 03:51:32 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.161.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e62144sm18619571f8f.92.2025.07.03.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 03:51:32 -0700 (PDT)
Date: Thu, 3 Jul 2025 12:51:25 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	stable <stable@kernel.org>
Subject: Re: [PATCH net] vsock/vmci: Clear the vmci transport packet properly
 when initializing it
Message-ID: <ktxstfr4rxrvk4pvdreumdch55ieexfclozovszm24o6xmb7zd@nmo2w2ffu2kw>
References: <20250701122254.2397440-1-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701122254.2397440-1-gregkh@linuxfoundation.org>

On Tue, Jul 01, 2025 at 02:22:54PM +0200, Greg Kroah-Hartman wrote:
>From: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>
>In vmci_transport_packet_init memset the vmci_transport_packet before
>populating the fields to avoid any uninitialised data being left in the
>structure.
>
>Cc: Bryan Tan <bryan-bt.tan@broadcom.com>
>Cc: Vishnu Dasa <vishnu.dasa@broadcom.com>
>Cc: Broadcom internal kernel review list
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "David S. Miller" <davem@davemloft.net>
>Cc: Eric Dumazet <edumazet@google.com>
>Cc: Jakub Kicinski <kuba@kernel.org>
>Cc: Paolo Abeni <pabeni@redhat.com>
>Cc: Simon Horman <horms@kernel.org>
>Cc: virtualization@lists.linux.dev
>Cc: netdev@vger.kernel.org
>Cc: stable <stable@kernel.org>
>Signed-off-by: HarshaVardhana S A <harshavardhana.sa@broadcom.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>---
>Tweaked from original version by rewording the text and adding a blank
>line and correctly sending it to the proper people for inclusion in net.
>
> net/vmw_vsock/vmci_transport.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

Patch LGTM, we can fix the switch later.

Stefano

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index b370070194fa..7eccd6708d66 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -119,6 +119,8 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 			   u16 proto,
> 			   struct vmci_handle handle)
> {
>+	memset(pkt, 0, sizeof(*pkt));
>+
> 	/* We register the stream control handler as an any cid handle so we
> 	 * must always send from a source address of VMADDR_CID_ANY
> 	 */
>@@ -131,8 +133,6 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
> 	pkt->type = type;
> 	pkt->src_port = src->svm_port;
> 	pkt->dst_port = dst->svm_port;
>-	memset(&pkt->proto, 0, sizeof(pkt->proto));
>-	memset(&pkt->_reserved2, 0, sizeof(pkt->_reserved2));
>
> 	switch (pkt->type) {
> 	case VMCI_TRANSPORT_PACKET_TYPE_INVALID:
>-- 
>2.50.0
>


