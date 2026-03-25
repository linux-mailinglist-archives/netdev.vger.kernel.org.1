Return-Path: <netdev+bounces-271479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLYhNkmvw2nAtAQAu9opvQ
	(envelope-from <netdev+bounces-271479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:47:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBFD3226DA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E848E3058687
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2B239FCC1;
	Wed, 25 Mar 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfKaWPpC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pUu5Q1Fv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92B23D281
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432071; cv=none; b=Ct+Rbl3/olPxoWsMa+eKQsouLTY8TOg1Bg4Ck3kFi1v6UZObOp7Go6BW3QrBW5CfzDecGmKqOSb8lcmoLP/tcZe/q/2vXV0kj73dd131X9+0/2Cip7UwWLBhkpNt7rlvqg4HH1NPaksipI7aJGAf32mwyVW36h8dao19XUgpmeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432071; c=relaxed/simple;
	bh=W9VsU7ayZ8RVpTIhzcUcmUQ6PvuDoGrgazbk6OfstuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R51gV7bh4j0nZKSIAKDLBsBI/k/Ci3smYY7C2X7rnsW0j3VBF8KBUI1k6F25V+LYe48TgXczWkbH3uNvn1KmlsHJnSEmcmzhybyjcDaLggbiVjOmXuckkUGGdoSfChl4lTU2EEp+3sqhs0Qc6IHuusxqlGIFJEHEa7XerTNaw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfKaWPpC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pUu5Q1Fv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774432069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=568F2IklrqZnJkVpdlO2OonyYtNDZb7P6ec0zUCHe3Q=;
	b=EfKaWPpCAUsePTyya+dKudwO3IGWr5Dmj2eqNCsqSMpCCnIs+0qQAjEp4luqyQcWIQrXKI
	hyu7WTl08+1GwRYBPpNbgLqhNYKrDsC1XnnVA3h0JGZICf1sE2b50IPJPnO7p+nxstO7QE
	/v3I2sieNBhc1896T/0C0u5sTfPbuSM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-jSTA9GjwNcaOcUOdU1bCcQ-1; Wed, 25 Mar 2026 05:47:48 -0400
X-MC-Unique: jSTA9GjwNcaOcUOdU1bCcQ-1
X-Mimecast-MFC-AGG-ID: jSTA9GjwNcaOcUOdU1bCcQ_1774432067
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836abfc742so35878615e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 02:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774432067; x=1775036867; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=568F2IklrqZnJkVpdlO2OonyYtNDZb7P6ec0zUCHe3Q=;
        b=pUu5Q1FvrnGky3NpnbohpKOlKhW+ceKeTES9yxnvUzMisGUIdNZUG6LvT+1MRy3kUR
         LdO2tlNfe8CVFvO0BE8WhkcxdY5wVYSlvUwBSQquV8ih+bekeA1WqPZMpfXQYXPpAFYv
         03l9Ol0YG3PDQVwK3KyWnqFpOESIcHfvSlNQRuG5CxmtlYIWn0Yyy3jrNbFMSQdzuq0o
         Q/T0ZzuyRQJ7ZT6uSfutQvVDUTHIBpRrX2CqfLQr7zvhKk6v3RlWyhUFWjgi/MbK53t7
         LSU4FAca2voUy9wJjw/cc0+vBrThlysiUpmBOCVWfgecd89P50ML+DHC1J+HWbzKMCSh
         xTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774432067; x=1775036867;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=568F2IklrqZnJkVpdlO2OonyYtNDZb7P6ec0zUCHe3Q=;
        b=SIfJSWLzbWt1gnxXr6fsGM2qTlHHJmhT82ExCNkhcQvftfl/lKm9kSckwdISBrJLEw
         f8rrPjZbUe3d0jj/9A92KT+CPhuR6JeUgGoQPYYMWlBp/GR4ym0CLMoXfAfCCcOCCed3
         qDFiJp4/okrK2yKrgQFPXSs7DWxVSTNM/KbXZkZ+bzPWdZoxtTqDbU7mTYoqcPetIa4L
         u0NU8tYwJ7RBhKkOcO2/g795Fd6g6xGCnuLMly82SixsNKS72F/+c9UaIWZiFl5LIEbF
         zU6V6FUDa7q8UHjCfoa9o729Dbko2ktpJ0pghXNDwaCBi4lPhBQX7ZpgnAaJzrVhWB5r
         zW1g==
X-Forwarded-Encrypted: i=1; AJvYcCWpbFaL4tprjhBDNLi8I9BGQgenKaY5EaE0tYknv/DdxI8v9nOtiHoP7/HCIbRmR+Em0pvAwS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnm1bARjTthQ+/1725BiiHUc6DApuJz1I7uCfFkTqwum9EWN4
	MKyzhWhzvOmjg3fdeKDbjghyQkefvxApLXSl+dYoPP91VRb+z1D+OvmOfIn+K48AgiSRt3G136D
	so0CR6TxGKhX0Y1wkkNJF5lz38FHYEMgt6BiUKLIRUaKsVg+VTEEiPk3V9Q==
X-Gm-Gg: ATEYQzztjIVEPyDR/Xgb0RjEJfCU0I7+GCfdxvog0uzdQ0oTN5X6yJ5q90yN778WeQu
	arrd4/sl9lmytIQB4c5HPOmrGT//TJXiatpR/QPnMA4l9j/YSJCGECdx+ne2kJEQDE0Shsd0z0H
	VZtyGdYCKfH7SnnSNcPxBq8Z5ja5OjKVkqzOEKxNNCsLdzZI5Rv38lSltzNx3zPg5ECYIdcSEog
	bG2C4CpFXPeM4ivb4KSFlS0mczXKTwEqSbfOFBYgjc20mNwPAMXW0z5gSlvvFGkwYUpMNzkTQqz
	H1HhNSG9rNjD5aZlFqiqCEbriSbVfBmOuQu36g5hMDJdxb1+4meihT6yjE772XggwSsx5QM/kRi
	C8ioJJxAjPEc4vQCzcA==
X-Received: by 2002:a05:600c:a15:b0:486:fa9c:185 with SMTP id 5b1f17b1804b1-4871606c89dmr38627425e9.31.1774432066866;
        Wed, 25 Mar 2026 02:47:46 -0700 (PDT)
X-Received: by 2002:a05:600c:a15:b0:486:fa9c:185 with SMTP id 5b1f17b1804b1-4871606c89dmr38626985e9.31.1774432066386;
        Wed, 25 Mar 2026 02:47:46 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116d820bsm113568205e9.10.2026.03.25.02.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 02:47:45 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Li Tian <litian@redhat.com>, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, Li Tian
 <litian@redhat.com>
Subject: Re: [PATCH net] netvsc: transfer lower device max tso size during
 VF transition
In-Reply-To: <20260325045006.18607-1-litian@redhat.com>
References: <20260325045006.18607-1-litian@redhat.com>
Date: Wed, 25 Mar 2026 10:47:44 +0100
Message-ID: <87a4vwnsu7.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271479-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vkuznets@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CBFD3226DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Li Tian <litian@redhat.com> writes:

> When netvsc is accelerated by the lower device, we can advertise the
> lower device max tso size in order to get better performance.
> While a long-term migration to user-space bonding is planned, current
> users on RHEL 10 / Azure are experiencing significant performance
> regressions in 802.3ad environments. This patch provides a localized,
> safe fix within netvsc without introducing new core networking helpers.
>
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index ee5ab5ceb2be..971607c7406f 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2428,10 +2428,14 @@ static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
>  		 * This value is only increased for netvsc NIC when datapath is
>  		 * switched over to the VF
>  		 */
> -		if (vf_is_up)
> +		if (vf_is_up) {
>  			netif_set_tso_max_size(ndev, vf_netdev->tso_max_size);
> -		else
> +			WRITE_ONCE(ndev->gso_max_size, READ_ONCE(vf_netdev->gso_max_size));
> +			WRITE_ONCE(ndev->gso_ipv4_max_size,
> +				   READ_ONCE(vf_netdev->gso_ipv4_max_size));

It seems netif_set_gso_max_size() helper does exactly that, i.e. sets both
gso_max_size and gso_ipv4_max_size.


> +		} else {
>  			netif_set_tso_max_size(ndev, netvsc_dev->netvsc_gso_max_size);
> +		}
>  	}
>  
>  	return NOTIFY_OK;

-- 
Vitaly


