Return-Path: <netdev+bounces-84718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9AF89822F
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4CB3281EE2
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639C59B7F;
	Thu,  4 Apr 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e0nv9o2m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F859B40
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215675; cv=none; b=neELXHnjhLZVgiOr0IvmW+mXWdumRlUbkVXWDBoDFGZ+qWv00x3CUzvqSBMVKNnoWtrcMmlfU8yDIITczd9m7LoB+MYx8+8S4L1qRionHJwoYD8voofwvnHAoIcIN36gB9r0nWWREB2YuaPdB99qS5mraHOh6XBKA9ZnUc4bHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215675; c=relaxed/simple;
	bh=GSH6m/6gmzpdE4ilkVc5O/E3ikW4/Ya8/okCEmiU6Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IF2J/RqXi+aSVYXJuZHOLUjmQEmxFGHYEn25f00i47SSgpspwfmmTWYHRbKoLcPKVZWTrqv+CumKhoXOVj0Rp0puWV6oVlTnOMuST8EZx8tBrK7TxRneWpRzpbnZbxRMvgRUIKqqiO0ql8RkCxAqx/ty0miKkPPvEa07xRR2xUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0nv9o2m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712215672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2tlqAQDqg/5deVRzvMbMah/jpwOnEqnfEQox5MDopI=;
	b=e0nv9o2mHepGFzN5l5DEOpFJJWYqovEYryi9tjlgEpQE0D4MKGiLpLy4GDpJMsn3H0drKV
	NN0k6OwulvipJ7TCCf4a4G39/88Qcv/YZ2gxqUxaDq4laKcDJevSHVqqXH4eo6bPHUIYkW
	7OVvssI7m0xQGVXFKw7Z+EefQco+7n4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-z_8QGsNfMYSnEJzS01LRHg-1; Thu, 04 Apr 2024 03:27:51 -0400
X-MC-Unique: z_8QGsNfMYSnEJzS01LRHg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a46ba1a19fdso44566366b.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 00:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215669; x=1712820469;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2tlqAQDqg/5deVRzvMbMah/jpwOnEqnfEQox5MDopI=;
        b=jYJ9NVHtz2VOY4rwh5Y20OxQWHc7wayT85jOCO2PhFszB0PFCo6V2VG6D7DTIgv6Xk
         fThJaEDrJRs10KpLdYghjmk05R+P8+hGln9CAQC+O/IGKcsdGBgTlkc4yc6IYocudYhz
         uqQQSVW7KgWImGvMCpKNbjYdVDCFP4XH86fEvFOrh03D7fjFkOo7ugV34+ugljY6YKQj
         A3Xhu2KAGqaCQQhk60diU/aGt+JQVNldOT13ZavYheFEeFLs5axHcGWlTZlyOYck0719
         R+9jsoTqNXyAN9MktS8cw5OXDrEbI8DOBYeZias1QvZ+qHaccrhSSzPvGyNuc3m9fF2N
         5Vxw==
X-Gm-Message-State: AOJu0Yx4e8kgnPNHf0XkuCriu2gDHgVxJbQ712G/zAA91+rBYPf/iK2t
	Vjb4CoPjWjKiTQFg9yTDs4K1ohMRco5Pv2K+XA/BMyQH49p1B1J8Ib2SYWLjcGTlPhSB0uhErG3
	3dsgbsNdsYwzqW9zX4iJReJAD8IjBpBVeXFWP+7Lre8xR+88xx/kaLw==
X-Received: by 2002:a17:906:4804:b0:a4e:2777:37c7 with SMTP id w4-20020a170906480400b00a4e277737c7mr896125ejq.49.1712215669542;
        Thu, 04 Apr 2024 00:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxbPP/ODmWMUcbgi/9We+ccJFuLsAvC+2+RNcoWVGTULDHqqt1uu9PwBj8X4lBnIyjLGdgFQ==
X-Received: by 2002:a17:906:4804:b0:a4e:2777:37c7 with SMTP id w4-20020a170906480400b00a4e277737c7mr896104ejq.49.1712215669185;
        Thu, 04 Apr 2024 00:27:49 -0700 (PDT)
Received: from [172.16.2.75] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090669c400b00a4673706b4dsm8698717ejs.78.2024.04.04.00.27.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:27:48 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: fix unwanted error log on
 timeout policy probing
Date: Thu, 04 Apr 2024 09:27:47 +0200
X-Mailer: MailMate (1.14r6028)
Message-ID: <AA6642E8-F501-42EB-8AB1-A8D4C4356888@redhat.com>
In-Reply-To: <20240403203803.2137962-1-i.maximets@ovn.org>
References: <20240403203803.2137962-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 3 Apr 2024, at 22:38, Ilya Maximets wrote:

> On startup, ovs-vswitchd probes different datapath features including
> support for timeout policies.  While probing, it tries to execute
> certain operations with OVS_PACKET_ATTR_PROBE or OVS_FLOW_ATTR_PROBE
> attributes set.  These attributes tell the openvswitch module to not
> log any errors when they occur as it is expected that some of the
> probes will fail.
>
> For some reason, setting the timeout policy ignores the PROBE attribute
> and logs a failure anyway.  This is causing the following kernel log
> on each re-start of ovs-vswitchd:
>
>   kernel: Failed to associated timeout policy `ovs_test_tp'
>
> Fix that by using the same logging macro that all other messages are
> using.  The message will still be printed at info level when needed
> and will be rate limited, but with a net rate limiter instead of
> generic printk one.
>
> The nf_ct_set_timeout() itself will still print some info messages,
> but at least this change makes logging in openvswitch module more
> consistent.
>
> Fixes: 06bd2bdf19d2 ("openvswitch: Add timeout support to ct action")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Thanks for fixing this annoying startup message! The change looks good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


