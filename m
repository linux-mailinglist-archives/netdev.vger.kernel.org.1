Return-Path: <netdev+bounces-266966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNzDOJaLsmneNQAAu9opvQ
	(envelope-from <netdev+bounces-266966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:47:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CAD26FCB4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 10:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EB5730221C7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAAE287263;
	Thu, 12 Mar 2026 09:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f0WpSmed";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNRYRrht"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70B3B775C
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773308793; cv=none; b=rN27Jrwyzn6H116HI77sgFH8laYsQpqGg1MKKitr2/MJbuMsK41P51yXgjYNI1luW4DALBUj6DKC3jq+FkqapTiX6laod3dWgYOWUra/oPmsyW0va7hQq2QMyxxtbftI5KnT6XU8go6sDblrRK1Owf20XGTPg0jn2KGAYH6lz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773308793; c=relaxed/simple;
	bh=XmgO1TscYmjuACXGsGpTPCpFJQ8z+1vv7PMc1mKHSMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEDVEmRL/7GcXE4unJIUCE4X+dlYiA0NOS46Bq9i0m4o+fs8yzToD9ipd5Atmew0RI3jTesuEqE1R+6cHF4Q8ckLz4Cxnt+wrOpLH8j/c9Sdh3PyfqbWaXfDZvRbm8Rsv1vWhasbyheywi7fxIlQhoX1hqcbgH3w4ruujBn+lZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f0WpSmed; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNRYRrht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773308790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3laAzH2RegSSG4RPB9RBAb4LG65Lm6P17O2gbvY3vM=;
	b=f0WpSmed9CDPqlrhQERlgTu17lFHWNN1iKiDp7V82OddnmoswCx/kWRUGnjzbl114b0+Ln
	boOaIevniJnL9yS3KPP0i6AFfWiL5XEdEYYGgbvxm7B4n6J6jVbap0Zg8AvOpzYWMtJbIF
	MIvfvmNp3mjoUawKUfTv6J4JMi97yKM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-UFeRO-bsOb-_cIk1GDfPgA-1; Thu, 12 Mar 2026 05:46:29 -0400
X-MC-Unique: UFeRO-bsOb-_cIk1GDfPgA-1
X-Mimecast-MFC-AGG-ID: UFeRO-bsOb-_cIk1GDfPgA_1773308788
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439c4d71603so1590894f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773308788; x=1773913588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3laAzH2RegSSG4RPB9RBAb4LG65Lm6P17O2gbvY3vM=;
        b=JNRYRrht5QpWTMmLPdd7IbMa14IC3u0eLB9Jl72JI3HqJjkJEIuHLqSxDEhXXVDNNl
         wb4fRhnv7lq6MpDLWU8xaHMShn77HSmokfCekcYIKZmIC7S0YX5XLtdL41MFXvsfYqBH
         xsrWzBO9U0lUUtB9Bcj9CBgK5uxhb3ieJoz2YF0l3s2FaSAKz9WIonSZYjOePa+ks9yQ
         3MLLE/MVLndixUsdlBIIuC5vpGYa05qgsjt5vPxt5SQQi+T+ebCtDkKYjkB1r7nYqLr5
         7zEis4KX43P3LBaAomrTslWjSp7PHfHAjQgBVb1HcQoNSNb/hJEX1+xcELoDP8L3QY4J
         Xsew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773308788; x=1773913588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3laAzH2RegSSG4RPB9RBAb4LG65Lm6P17O2gbvY3vM=;
        b=CfOlkh+OL902SvNqzQntgbxEdmLhOGynQWRtWYef87FbNkYS+YFWgsQbfFCQLqypkj
         2wA8Q4YQwCVN1Orn0yAV9Jqvv9lH3EnAF+K2VHf0qcqhxNHe+mhXK8MDc3L7aFqh4MBL
         xkiewwqDm6dNatYwImmiLZ/XlSPo2BeUZJoibR+uueSqM7qYmidwGk6XYf6dVcZMXC6i
         JV9OqznYqps1U6csbAg3zHMWHLZOttWqC+d2sB5GDQYuDckn6VQQcXVtZZSFVbFLRXMo
         8PjVScGblcV2wXumrY9dm77XUg56wXbbVkv+/+DICnByJQA2TH+PpKawvEtZIoLpEP89
         SYog==
X-Gm-Message-State: AOJu0Yw73/wpfJnYVCn51ir61ksB6T+FNgr7r/njciUudTBQL0TZyhoZ
	cwaD1kiwX8jrc21GcxCwWG3FAxgQcMzeluz7Y+R/n6mfRlfEgzzYp0y36JP3d02I/0qxCRwBFeA
	VvmRyNASKDZbGez6AJDBBFiXptd5NKfzrBkiPC+ykSYXETgMkUY2ZUKguXQ==
X-Gm-Gg: ATEYQzzSHk+VunuOmu94a9bIHWhUSkF0BnXAPtoXOuaVUm25U7MfngOwOPgk1GAPdlY
	MssmA1xnUX/XUFjpYPpTsziuxqd7+xZmKn7X19uoXjdKoHy2Yo9f7AMaQyjcYJkdS7FoK/HzfgP
	E2JfFlxDQqhtJLODRnwJeRUCxA4Fpm14fRxlaQ3S6QhmFmokx3Rqsk/R70vKH6xWXysWjSJd7y2
	TW7zV9zTSSLDeDFH/LYSrYiO1Y4Qh0A5p81z2nfbJQAiz9+/6f3heKkju+BfjymKOcMGZ01MYHQ
	PFXAU9C/5HM7DA9QSj9sko8Xyt9izdQw/3TzTc3+iv5b2VGI19g/hPZeHA6Eh9V1wXbVJjBT/zw
	V6Yt+zSvhuYjO9j93rIsd3yHDKW0BaO0Kc1rg93FbRj8/jXjE1CasSjo=
X-Received: by 2002:a05:6000:2c07:b0:439:c24b:ec15 with SMTP id ffacd0b85a97d-439fdf8aa4fmr4902926f8f.5.1773308788234;
        Thu, 12 Mar 2026 02:46:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2c07:b0:439:c24b:ec15 with SMTP id ffacd0b85a97d-439fdf8aa4fmr4902885f8f.5.1773308787836;
        Thu, 12 Mar 2026 02:46:27 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a76e5sm6445035f8f.12.2026.03.12.02.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 02:46:27 -0700 (PDT)
Message-ID: <645d7dd2-9dd6-4af6-aae3-4e0b5af612dc@redhat.com>
Date: Thu, 12 Mar 2026 10:46:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: move
 netdev_compute_master_upper_features to ndo_set_features
To: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266966-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,blackwall.org,nvidia.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92CAD26FCB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 8:45 AM, Hangbin Liu wrote:
> Currently, master devices (bonding, bridge, team) manually call
> netdev_compute_master_upper_features() scattered throughout their port
> add/remove operations. This approach requires each driver to remember
> to update features at the right times and leads to code duplication.
> 
> The series moves netdev_compute_master_upper_features() to callback
> ndo_set_features so that the offload compute could automatically
> invoked during feature updates when upper/lower device relationships
> change. This centralizes the feature computation flow and removes the
> burden from individual drivers.
> 
> ---
> Hangbin Liu (3):
>       net: use ndo_set_features to set offload features for bonding/bridge/team
>       failover: use ndo_set_features for failover offload compute
>       net: no need to disable LRO specifically
> 
>  drivers/net/bonding/bond_main.c | 14 +++++----
>  drivers/net/net_failover.c      | 67 +++++------------------------------------
>  drivers/net/team/team_core.c    | 15 ++++-----
>  include/net/net_failover.h      |  7 -----
>  net/8021q/vlan.c                |  2 --
>  net/bridge/br_device.c          |  7 +++++
>  net/bridge/br_if.c              |  6 ----
>  net/core/dev.c                  |  8 +++--
>  net/hsr/hsr_slave.c             |  1 -
>  9 files changed, 37 insertions(+), 90 deletions(-)

I'm dropping this series from PW due to the self-tests failures. I guess
it could be restored later if it turns out the real problem is elsewhere.

/P


