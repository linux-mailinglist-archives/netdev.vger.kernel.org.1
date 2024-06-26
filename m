Return-Path: <netdev+bounces-106950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E46991841F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4602874D9
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D8A186292;
	Wed, 26 Jun 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5mhGF6F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E4186E56
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412084; cv=none; b=J+WBpS2mkXOO1eWkyWKxb/KOc8Hy8JpMOlROYD0i2tNOESzecailyUt8LDBWJ0DG4eXi3hQAorz8LZDXFXjK/epYNEE4WA6MObdXBllnrHq/656kP/nhDGsA21iApaquf5JntqC37mEJ0OyhO3Rra0q6Y1uF83GmHiYC5cB6kwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412084; c=relaxed/simple;
	bh=Jszx5xLnInAAS2PzV21hdC61cHrHQ9SmiiBcgrX3ltc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T67wT2r+oKmri/WPzO23NMOLE/CDp0SgyY5s3b9MduBlXZXDHcdzH8+T8fCMtbLPo3UL0W4RBJE/qDok8bRPoCsYdNbthcHmvnYQkJ/gZ/FhHl0CBDEUgyFfy1y5xDwdeTtrU5amP0aT7s/2rYRhSQ5x08pU1e0GAM+NS0pEXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5mhGF6F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jszx5xLnInAAS2PzV21hdC61cHrHQ9SmiiBcgrX3ltc=;
	b=Y5mhGF6FKg3AKrSwbrEfFdpTp2pD0+lUxXj/qH1N37SoOxgdLRHwDC2wl1QfDEdlpfhaJI
	Q9Ap6saXKnYjWfU096ZKoZ7FTcelAl4wjZBffLfHQS6zGV1SHmncC9F57hq7WZEQNHWz6f
	VINJa84SOsuO4cS7FXZXDuz2vTaAPcY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-2gNkBGVbOJudlS_t9yPKeg-1; Wed, 26 Jun 2024 10:27:59 -0400
X-MC-Unique: 2gNkBGVbOJudlS_t9yPKeg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a7244d1b086so268336766b.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412079; x=1720016879;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jszx5xLnInAAS2PzV21hdC61cHrHQ9SmiiBcgrX3ltc=;
        b=gGZv0EmYafM/M7Qm1tt6npdr9XZpVOWZZu9OW1mwxAy4bfp6uWKyc+N08mekRE+o66
         pf16C4FYqD4kRIrRdowQJMf4h50aCfl5KDgJY+C1HWeqOCjzjXHAaNFW6vT9DIKEv960
         pZckaKGgNKWT3eG3yUACMtQmg5ROlwLDnU1swpJFpgivTWuVahiJsRY/ySp8Y9QqkYKr
         9I6iZW+ZVHa2UbAtIk95fJ828L0bIa6yUzoiynDc59nKnfFxk102gMZloQEWIMz+7Iw4
         xPg0kKF/YHwb01g+9sZr/YgFezAOBpSZqzxZXj4uZZssfd8eucyYTl4TBH3qcSWiFKA8
         M+Ww==
X-Gm-Message-State: AOJu0YzrbpVugQM4iXV0chzFuGtG97QhkY+1sgokuFMnWD9wLGr94BMh
	F2tuT4eUoHE66U+aWuBTj1hZXr+g7LFTDkuA5VmQVvEuMc/XvXmPLSKAAkxHZMxYUvFv1tnjw3E
	XHGBhw6tyNY9sfo4JjLe+08QaFmmE+CRVG//2lHcaYcRt54yQPDZ+EQ==
X-Received: by 2002:a17:906:e28c:b0:a72:42f6:ff0f with SMTP id a640c23a62f3a-a7245c70af8mr566334266b.77.1719412078852;
        Wed, 26 Jun 2024 07:27:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbOBcMfRBhvshk7EYwyI0+qzKm0u+wGTMOkcIJZFCXy3eaPn3qGR/opDnZRQ8Cvzp3SipKeQ==
X-Received: by 2002:a17:906:e28c:b0:a72:42f6:ff0f with SMTP id a640c23a62f3a-a7245c70af8mr566333566b.77.1719412078594;
        Wed, 26 Jun 2024 07:27:58 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.27.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:27:57 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 01/10] net: psample: add user cookie
Date: Wed, 26 Jun 2024 16:27:57 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <31B53809-DCB7-4081-915E-52311DE5DF4E@redhat.com>
In-Reply-To: <20240625205204.3199050-2-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-2-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> Add a user cookie to the sample metadata so that sample emitters can
> provide more contextual information to samples.
>
> If present, send the user cookie in a new attribute:
> PSAMPLE_ATTR_USER_COOKIE.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Acked-by: Eelco Chaudron <echaudro@redhat.com>


