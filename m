Return-Path: <netdev+bounces-251832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCPKKG2kcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:03:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169D54DD4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71B7E50AA48
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0072480354;
	Wed, 21 Jan 2026 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUs7bkgs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvnCo1CH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167F48033E
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988893; cv=none; b=RkjdDCOtqFbkpJp//xgp41qIDbWofwdqtoUNRLiO6ZS9Oiauar/aoPzEqprulk6zA1Cp903xdmFMfZO4g0CJc8GFyOTBShPxdur/Kdu1/81ifDvv9qY8LL318yRVezX2NdKxEfq0TG+6vBA2RFjU3pUYqMgF1vGy19Kc1CMoGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988893; c=relaxed/simple;
	bh=hepF0A2LSGlCyRDBXglqMBeLZzFYJb45MCxfhvn7i1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVSQPUAbKvMXKm55HwEiQfsHF67GSwLVjUSgB8+K+TBETH7PyzyxXAej7CA20FNsTAerPobk5GBedcZegkdxbzNqXbaISQ4Lq4Lu9uQiQTQm29txy/wlaN5ZT8yB72u7ZMmvxJ+ytg8NPjzYbT7acTIjpG1L4F+rtXFrzXy8sMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUs7bkgs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvnCo1CH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768988890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hepF0A2LSGlCyRDBXglqMBeLZzFYJb45MCxfhvn7i1s=;
	b=bUs7bkgsoKWbXL2KsGs5YzGrA0gXmFfI7CnynCYh+aDO7K3dyH/cfFgbFWpvJTQSosroPS
	gCUUCSYZCBOGHQEz3OLDIw5LjpQfwtEeQNpKV4i9gYNtRQOBadRy/L8FT1EO9ti1TvjB5u
	kFn0ckGbM3/SScgfQ4Pp26DOKRjMEDI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401--_7M0tJYMeGQtrYDerBZDw-1; Wed, 21 Jan 2026 04:48:08 -0500
X-MC-Unique: -_7M0tJYMeGQtrYDerBZDw-1
X-Mimecast-MFC-AGG-ID: -_7M0tJYMeGQtrYDerBZDw_1768988887
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fd46385c0so3731785f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768988887; x=1769593687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hepF0A2LSGlCyRDBXglqMBeLZzFYJb45MCxfhvn7i1s=;
        b=RvnCo1CHPHWC79XusV5QMPyaJMq0lJYYvGj7LqN+pTJiiBffS0IkwPeo5uCEw8zSBO
         ky+3P+PQDaqWrc+V0E+n5fiXezqqMMidCF7MukFHpCwBkj1Hl7kjAdP1IquPx3HyCOS1
         llTc7c8QNVEb9dTVm4aE74zXlrxrMq+pOk2pynsLMjNa7afRoBLIKmqwRiD/915ewpfw
         9102loytTt9syabHY18/VXIJaSKwuZ/8NEFtpcVhaDV5OyCm1j/Q70bD6NJuJl8MWzQk
         cUc6BsEYMvMf5oKrha8kwphNT2zuf83xuVRHi/iX/2/jVCVuryK+PpNhdwDGRhvDCGH2
         TNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988887; x=1769593687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hepF0A2LSGlCyRDBXglqMBeLZzFYJb45MCxfhvn7i1s=;
        b=UVFlHfwTPxVdrsRF6U2WXLvsUQfKfxVoNb+gcPoFEZSTnjW/k3k0RjRBaVfMoSAhsG
         KbIQRqmkvvoNrVmqEg4Qyc0NdVEvJRauFoSBbNu9GryuY5e914pWBDgEeG5S2vfuWGDy
         Vgw85jACatIVHNEUIFUhIk0o5UpN/Uzq70t+5+0MrZU8Vw4Ugg989GXsVASD8jCy+Q3A
         CRCrQkFWRsnuipseqv/SQ0vQtvwfX9N2CpyqgCGtgfQ+mwDqI6kXVy5aaGusM6sKBB9l
         AODd2nSn9Faym5XAreFGN2pwzQvJfsWyAlc7s5POj9KxozRVAWMQcEKV/7sbovWxw1ao
         9n4g==
X-Gm-Message-State: AOJu0Yxax4NTkfa2qX8de8+rCgAsVmR7VKJ/j2g43OHn78d1jn20zsL1
	6Eft9kH2VsJj7j3NxkzmNt0yYiokYSIJ/SvqpV6DoEJQ9tK36YhuPvzY8BBeB0xtOyzTjuPt1CK
	WBCSElu7Aq6hruOIf+YmE7TlHSOMcFhWcIaB63QIDkj2yk9fH6jB9+zGMOg==
X-Gm-Gg: AZuq6aJn8Sboi0IpMBpKqrRbdcm3oOss3tPePG0bBqSqYsddssDE8lhZhYJg9729MfR
	dXfEjoJHngsUkEGSZMpiKjdBdO1VDQtWXWz8kKCkN5j95ekKiqLtit1oOHT7H62Ax62KmTeuJBc
	8iRB2duGfBzJwo9xlh/Ibm/0WyopKrMUQ2TjslNJvu05sjVRkCR3ouJ4CxhaL0Iix8kGKo8uNhv
	iFl4QMNA6k16GvUTbrNfix8i9Jic+AKcYiI4O8giRWdb0vbM4OxrbqEZJ1drj8pAF8eMP/BjDsL
	/x+dN5CcJLDTE5sXrbvqxJSqNwdAVh9tpPO8k3w4cE+HNXKZ/z9gOlvTGlTWihu6Y8Eptu8Lw68
	aqt/2tlrVrGY2dHnr6daPMLvusr4VWUMKijHaTCjA64Au1AYkJBt6YjfdU8I=
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4801e30a790mr252559205e9.8.1768988887171;
        Wed, 21 Jan 2026 01:48:07 -0800 (PST)
X-Received: by 2002:a05:600c:8b78:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4801e30a790mr252558715e9.8.1768988886678;
        Wed, 21 Jan 2026 01:48:06 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071besm351751895e9.10.2026.01.21.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:48:05 -0800 (PST)
Date: Wed, 21 Jan 2026 10:45:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Simon Horman <horms@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Asias He <asias@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RESEND net v5 0/4] vsock/virtio: fix TX credit handling
Message-ID: <aXCfnIFT6_HqC8v9@sgarzare-redhat>
References: <20260116201517.273302-1-sgarzare@redhat.com>
 <20260119101734.01cbe934@kernel.org>
 <aW9L0xiwotBnRMw2@sgarzare-redhat>
 <20260120151848.3b145279@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260120151848.3b145279@kernel.org>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251832-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2169D54DD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 03:18:48PM -0800, Jakub Kicinski wrote:
>On Tue, 20 Jan 2026 10:37:12 +0100 Stefano Garzarella wrote:
>> If you prefer I can send a v6.
>
>We'll need a v6, patchwork can't do its thing if the series doesn't
>apply and last time I applied something without patchwork checks it
>broke selftest build:
>https://lore.kernel.org/all/20260120180319.1673271-1-kuba@kernel.org/
>:(
>

Sure, not a problem at all, v6 is out now:
https://lore.kernel.org/netdev/20260121093628.9941-1-sgarzare@redhat.com/

Thanks for the help!
Stefano


