Return-Path: <netdev+bounces-165189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725AA30E0A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026411665F7
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A812524C693;
	Tue, 11 Feb 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8M7eBdy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313824FC16
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283458; cv=none; b=QI6tgDGhobUxb4IkpnkWdtxRs1GtW0rXLvZ4qBayYyvE1hzUpbD3SEnLk03p+iFxbqNamIiwinZeo9gAoHhZRTss9MWhYj1Yeb1ypNaQUGBti3Q7VgqrWiteSqfJHQPJ4Nwanz91ipBzEr/6QF0bhpa7dLsKYry7md/3qkXTHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283458; c=relaxed/simple;
	bh=fHGmL3imBwVTsko40k8hSfSoegWXvwQZ0WU74iXTHPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yq9hVz2OKINRvVe6zTHIxnERJQH0I+ykasrnLChgdhU36cdiqzhyWxqS4mTld0ggj8dCoMFOcIDg8T3OdsDON/S3BJCRmOlPF6MAMGdYEj+JLtqkw1zTtE9YvtosMne/2KCtsNFHRY/taAoX2Yz5LEEkzvISrj8WPTVMMcH2XFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8M7eBdy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739283455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dZxzK6zQLSRGW305iGRO4RnSN/mCl6UDA/xY7zEHlA=;
	b=Z8M7eBdycdr7HLvV/H5Dj4Pw8D1iBZjOGNLpSqJKmL+twmIv5mcwEGsVmzCkKeJvL10/Gr
	PnfW/xpiQnRz/zU7JyZr5YivqkYIgkjjum950GKa9srZW4TTUyzn39MtPnD8530GDa+2v0
	d5lMBmihqjXkb0bEOrbdQgMLrTnmK30=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-aEbvi6eYP7ChqrYpvZ6K_Q-1; Tue, 11 Feb 2025 09:17:34 -0500
X-MC-Unique: aEbvi6eYP7ChqrYpvZ6K_Q-1
X-Mimecast-MFC-AGG-ID: aEbvi6eYP7ChqrYpvZ6K_Q
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43933bdcce0so22148135e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 06:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739283453; x=1739888253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dZxzK6zQLSRGW305iGRO4RnSN/mCl6UDA/xY7zEHlA=;
        b=UAj5rWJir4tVgke/vWw5MHCVpgwRHc6xgHwHqrC1+On3JmMje+YSJlvkkmBx4vL6wv
         sL90kEiFHMR9pUu2/eydODhd3KyCxZMbJ1wudBhhb6vumR1kS413/aqSh0lUgrfiYwz8
         DrzPBwKwjSKsYRvml4v6Ef+MdDXM2oBNOQZW2pj2PFELhJk+5NAlKn27EkmLkKJszJfK
         ciuQajid2AdeeJvO0xdFrTaYlljmFmQ4BtIVq14MsU/NyYPaEe2M1bKGZejrRayNNDZh
         kTPtVSsN56iiFuUEvYhuD/904w0OYaxLzwGvKAeo9fEgP4LlAbD3vlsTvo3nIbCjnEah
         AyYg==
X-Forwarded-Encrypted: i=1; AJvYcCWL53xSEPoeK+NU/ZMARZ/fEJKSE9n/CKBSQv0qMW9MTq6jywr7UinKkRARV4fvvgytHiso3Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVkn/jhbigHhBtEBLX7XrVhd+V8nJ+e6whiS8N6VTWuxW4Bf1
	HM+4BsjwYa91Umk8/N5BnFYcbA7HQ2Sj84Fadd9AOhCrWgvrEK2nuCNAtWT1rY45I8gGH3s414q
	7n0sJvQ6k74JKSr8j11PcTiNIpQ39PqyDTcQ/aJr3CCQlwTasRF7gfQ==
X-Gm-Gg: ASbGncuSBkOTih3ghvMwSBonAmglfcwXsMBaBQUuI+9zx/Ip8lvtbcTbi2VwtikblZo
	yWzOEynArBYe+9tB+MeUQYe5OsTlM/xIRTtvykrmT8yt0auP5uI99h6ZYY/3Z1KB9keaP82cLvt
	aaKo2B1+5Q+ipfvf+xKcUkdmzxzqJ24nz951gMkIXbuBWviaaTO8N22H2PwIRJxXwZAXdWcdWfq
	CEiHDziSvL3F959/I1FGGK9o0W7TCOhNEjESC4XEl6O/zdpz4X6QseX++7Df1TABVdaIUuKGiOA
	hl44tWS2tYezTDTc8y7YniXXdVXEFGqLk50=
X-Received: by 2002:a05:600c:1c94:b0:439:5590:6d2f with SMTP id 5b1f17b1804b1-43955906f3cmr19754135e9.12.1739283453510;
        Tue, 11 Feb 2025 06:17:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu6DhLw3phykq5CKlEilxji2nk3kDuVQY+D0h8PqErfcfqr8yNj4raF/yweEUNcSpgAaAc9Q==
X-Received: by 2002:a05:600c:1c94:b0:439:5590:6d2f with SMTP id 5b1f17b1804b1-43955906f3cmr19752935e9.12.1739283452174;
        Tue, 11 Feb 2025 06:17:32 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43936bcc04fsm102681885e9.20.2025.02.11.06.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 06:17:31 -0800 (PST)
Message-ID: <a800d740-0c28-4982-913b-a74e2e427f25@redhat.com>
Date: Tue, 11 Feb 2025 15:17:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] vxlan: Join / leave MC group after remote
 changes
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>
References: <cover.1738949252.git.petrm@nvidia.com>
 <6986ccd18ece80d1c1adb028972a2bca603b9c11.1738949252.git.petrm@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6986ccd18ece80d1c1adb028972a2bca603b9c11.1738949252.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 6:34 PM, Petr Machata wrote:
> @@ -3899,6 +3904,11 @@ static void vxlan_config_apply(struct net_device *dev,
>  			dev->mtu = conf->mtu;
>  
>  		vxlan->net = src_net;
> +
> +	} else if (vxlan->dev->flags & IFF_UP) {
> +		if (vxlan_addr_multicast(&vxlan->default_dst.remote_ip) &&
> +		    rem_changed)
> +			vxlan_multicast_leave(vxlan);

AFAICS vxlan_vni_update_group() is not completely ignore
vxlan_multicast_{leave,join} errors. Instead is bailing out as soon as
any error happens. For consistency's sake I think it would be better do
the same here.

Also I have the feeling that ending-up in an inconsistent status with no
group joined would be less troublesome than the opposite.

/P


