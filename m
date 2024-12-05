Return-Path: <netdev+bounces-149273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7549E4FD1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEA0728397A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF71C3BFC;
	Thu,  5 Dec 2024 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVIvXKnN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1438189B94
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387717; cv=none; b=m5qigS+BR/iHYHia06OS/j3yXWS88i0+gJNrwlMAsUJlRcsPWybzdw01MLw/MjQXvkNcdjG6JsmvpRT55VhziEffmJxUaMeNT5kiDhsNCGjb15VXIMIMLZSaZvlHxxMhD3fnQJFEMsZvjq0mMEqM6J0P95wRpfuAQclinz00IUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387717; c=relaxed/simple;
	bh=TN1OnxBLa1ZpX8KGKHEDxuLMb8HtOr30GOV+vNcFKPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRH4Klph2fE6vmoX4oQFaHZ/ZasvbQyeDXmSzsh/xvfZom5RADNCOW3a+dMFjSb+/u3X8/7LeKiFWX98UUbnQAAroE6mydTZLRr2h7pl4g9i3ByREGiPJvWF71K3CpsdNM/L6S74aky6wbkbVwRP5dsqkXTC5ZWmjuX+yjMMwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVIvXKnN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733387714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYeXIaa6Q76Tkvvm9p4xso5AjMNGvePGFMfQp/2WHfc=;
	b=gVIvXKnNrfL+RXW+FrRoXI85SdXnFpkhFcOpoUWZA8pB3pIimPRgT+uol5OrbfjU87fCZP
	Ye8tj8W4yNbD64B1FOSbsBMjEkJvv7y6nCkf1u7oEUqcJFz+K+1l+XP6L0N+764sxPo0yQ
	BMOE4zb4JfZyD15Uw6jgc3QeR393jJ8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-jptAxkLkO9ujq_D-Crcyzw-1; Thu, 05 Dec 2024 03:35:13 -0500
X-MC-Unique: jptAxkLkO9ujq_D-Crcyzw-1
X-Mimecast-MFC-AGG-ID: jptAxkLkO9ujq_D-Crcyzw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a90febb8so3808635e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 00:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387712; x=1733992512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wYeXIaa6Q76Tkvvm9p4xso5AjMNGvePGFMfQp/2WHfc=;
        b=C2vY6rEzRde9487d20uF3HnicmEK9paHynqp1yukkz1joAObvKtNb3T1+Z0bNWSDBv
         XdF8uiKVNqCOX14luVLBEvkatOx8f3DigX2MQs91kz2i9/OwpYHWDy44QIbxyDgODLFF
         a/M2qXga7CmKYPf2lXIbzWs06+NjyJZg/HHwcyrYtVai2dcVHTnhn/2z/HFZsYMsfcQr
         Bo3crwus4mLekAVqig4GW/sF+tN1ZaZFf+JoWJrcClqUUVGqbLbrIxYhllVSUuz3sb9Y
         GEkEPvIN+8D44edHsD/4J7z73Z+QIHghjUjf8E1aioPGTB0g/RuR1G51WWdsXkzBubWd
         r2Zw==
X-Gm-Message-State: AOJu0YxAGhDL3hwGBbuYVv4L36m/PwBlVYSqNvBMRihebNgp18Yr/JPm
	x+xKrEVHwc6GuggVuLocMd9+wrTRI67Nz3STp+MyPNsPvEKHewhZetmGpuGwPDrfsy7cE5ptHCz
	/SA/NETV0/mk+T9rhRQkP0Hi322jLrUAM/Gyfiau/gclAOddJZCYucw==
X-Gm-Gg: ASbGnct1S2xB7arkWa5l8//5BsU0O4VpgMTgMtW5Klj4qQJkPEK2JsW/yVKAOI8efZT
	koOzsIdbg/WkXToDY0+ugOfBABW7Aky5fzduyXjeniY3segVEFAuC+8DrpWZboOUy9ZvPNXvjE5
	DtcFSICwvYt3fujS/xqQAklZkQMBvOn6Eo6nLIscK+M6IEiyPpNQZbZHHLjhzPhJ56ZOB9a4XmC
	5kDHfPixIHjpnSWYcJQZsJLWRG33EnYAwYXL3g1/D5m2E5P8ftWIPU53xeqWtY46jBGXdKQRlqg
X-Received: by 2002:a05:600c:5103:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-434d44ea894mr49057495e9.33.1733387712002;
        Thu, 05 Dec 2024 00:35:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH18akBA52UhODEDg0rjdE4ws4GXDpZBKsOeUl05v9DQ/oHyMV8KqbXGhfGeNNEpfG2TEMn9A==
X-Received: by 2002:a05:600c:5103:b0:431:55af:a230 with SMTP id 5b1f17b1804b1-434d44ea894mr49057305e9.33.1733387711634;
        Thu, 05 Dec 2024 00:35:11 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861ecf4045sm1340123f8f.8.2024.12.05.00.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 00:35:11 -0800 (PST)
Message-ID: <a88b242a-a6ca-466e-9ca2-627e9193b1e3@redhat.com>
Date: Thu, 5 Dec 2024 09:35:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: defer final 'struct net' free in netns
 dismantle
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Ilya Maximets <i.maximets@ovn.org>,
 Dan Streetman <dan.streetman@canonical.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <20241204125455.3871859-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241204125455.3871859-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/4/24 13:54, Eric Dumazet wrote:
> Ilya reported a slab-use-after-free in dst_destroy [1]
> 
> Issue is in xfrm6_net_init() and xfrm4_net_init() :
> 
> They copy xfrm[46]_dst_ops_template into net->xfrm.xfrm[46]_dst_ops.
> 
> But net structure might be freed before all the dst callbacks are
> called. So when dst_destroy() calls later :
> 
> if (dst->ops->destroy)
>     dst->ops->destroy(dst);
> 
> dst->ops points to the old net->xfrm.xfrm[46]_dst_ops, which has been freed.
> 
> See a relevant issue fixed in :
> 
> ac888d58869b ("net: do not delay dst_entries_add() in dst_release()")
> 
> A fix is to queue the 'struct net' to be freed after one
> another cleanup_net() round (and existing rcu_barrier())

I'm sorry for the late feedback.

If I read correctly the above means that the actual free could be
delayed for an unlimited amount of time, did I misread something?

I guess the reasoning is that the total amount of memory used by the
netns struct should be neglicible?

I'm wondering about potential ill side effects WRT containers
deployments under memory pressure.

Thanks,

Paolo


