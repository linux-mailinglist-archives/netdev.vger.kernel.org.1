Return-Path: <netdev+bounces-176329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D06A69BBF
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD390482A22
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693EC213235;
	Wed, 19 Mar 2025 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYpRI0OR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F01EC013
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421879; cv=none; b=IIH30cAYBgX2MkJDYF8awD9DflqEU9ysHjC8jkdGWjr5x/sUFaPWfyScrmYpTONHy/7Akf6jSroe3MxoUrAKOLDdhKkcQiqFdfNmJUXANJ2tWu10cJiohy1XsTliZVTlmvGPP0W12+CoxHooicfXxZfIl/6kTBygiQQpuB08ViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421879; c=relaxed/simple;
	bh=BLI84LE2vHdgh4TDzUZqik+2P3fVs8DxRMBd4Uxi8mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKIRlU9SUZV+mxVV1uU1gyedn/b5SeEtMrlf9Icix8eMx4P+OiIzafm+RTpAs2vS4Aj3BYEQl/aL984YdAVx6Ieu5yo2wguc61qhp+hfv+jfA7Q65jUsswQK8QhX43GUx0o2peTP95nyk0cpyHIFUXjBSNpbZre2kMcuR3l16s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYpRI0OR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742421876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G8RNOKlUpS6zmZnVth77HKmJFNJPAi4U5ku9osiS53o=;
	b=FYpRI0OR8Gp51pNGE3HwYA/oiK0l7A/PI/rG/sbNHLZ0dnZ6M+9I9UxZYeEz/iStEEJEq7
	oxe33YNJ4++7S3lPDCWppymLNa2G905j8LYabB/sNId79IHOLfUR94JKH1sQzwocP0W4sd
	XvtuCiGzogUBr0uCHhcVOLpAN5NR+sM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-WC5CrS_mMsKZMwGI_fTHhA-1; Wed, 19 Mar 2025 18:04:35 -0400
X-MC-Unique: WC5CrS_mMsKZMwGI_fTHhA-1
X-Mimecast-MFC-AGG-ID: WC5CrS_mMsKZMwGI_fTHhA_1742421874
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so466705e9.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421874; x=1743026674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8RNOKlUpS6zmZnVth77HKmJFNJPAi4U5ku9osiS53o=;
        b=pfNNjSkm4TcHowfAWxEbry7+DyXlmfg4JCNK41w8lUuAG1Np5rDCYq+tyW+TX6Nets
         QMaqkMKDhhqEdhiRqm2ZbtG/jnB60DNuHcXHfJdaorJqcHU+tkiJ/V7zsmjLBqFnL2t5
         B4MHKvV2Y1UO924lbNnHnX75adWW1ZLoksbPBH00hDDJpkvnVdrTbf/Tgh3rr9h9Rx0E
         xfQeqGJHAp434K5hdDeWvx1XSZqOtN3gZn6ECoo6sPsaN82V5Bum7+q63CfnyWg8SlpF
         ztW/MxjBbTGcPfqaAI8H14COo4jZeRSujmqD1JdTO5ePf2Qn6wQp+WI793s6xz6lGfHZ
         MzuA==
X-Gm-Message-State: AOJu0Yw/NxeMMIB79R8t6ATf0xYpXbMx79FRIpc75P/sQv4KWgM0QVko
	xXXxcIWYQMEiZbiI3taw9+NR5j3+ua4qvUF0EsvXjsklS3P3Z7q3SmstdFTN36lNjKxgD9pNvJQ
	Qc8cHJLM9tO3lE80P8PIogdE7hGYyjkr34q+sl8tOALWXa+fF/ZYEsQ==
X-Gm-Gg: ASbGncvuCvJWDQFSZAlRLOK/Tuv/3ZAmqpK6XHvxTK8u/cAJVfa/2n+iVnAYwPUMwdK
	DSOh1kAzbJoxZQzDDjfpWtJz1XfaAUos6O1FegieiJCX0SaEbyFLAezQz16RIc6mQ1TmCXzBOYU
	lazOcyx6JOWowj9zXlbWo1hXzI1ZcPwfrHzUanXvYOm36PA54oSxHFzDwySt6BnBDCDUtDeWu/B
	t+DY0kppowjHbmdhP5g8iYj/C2cL5oGhV4nSzrJrtK1Fk7K4EqISM0fqBaiKsTVpTDh+yALaYTY
	9Q0zVWw9l1hr9OYk539cevuYprzBlNdRT1+LyrM1MSABeQ==
X-Received: by 2002:a05:600c:5009:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43d4378b215mr51077925e9.11.1742421873866;
        Wed, 19 Mar 2025 15:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2VGyu+4pUjYskdDZ5bDY6nzCB7FaIudoR8G3AfOUjEhu3S7bpsHFSZxEx721KexDWjFU4Pg==
X-Received: by 2002:a05:600c:5009:b0:43b:b756:f0a9 with SMTP id 5b1f17b1804b1-43d4378b215mr51077535e9.11.1742421873348;
        Wed, 19 Mar 2025 15:04:33 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47c8csm30022645e9.12.2025.03.19.15.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 15:04:32 -0700 (PDT)
Message-ID: <539b6ba2-744e-4e96-bc88-80e5e5d030e0@redhat.com>
Date: Wed, 19 Mar 2025 23:04:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] gre: Revert IPv6 link-local address fix.
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Antonio Quartulli <antonio@mandelbit.com>,
 Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
References: <cover.1742418408.git.gnault@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1742418408.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 10:26 PM, Guillaume Nault wrote:
> Following Paolo's suggestion, let's revert the IPv6 link-local address
> generation fix for GRE devices. The patch introduced regressions in the
> upstream CI, which are still under investigation.
> 
> Start by reverting the kselftest that depend on that fix (patch 1), then
> revert the kernel code itself (patch 2).
> 
> Guillaume Nault (2):
>   Revert "selftests: Add IPv6 link-local address generation tests for
>     GRE devices."
>   Revert "gre: Fix IPv6 link-local address generation."
> 
>  net/ipv6/addrconf.c                           |  15 +-
>  tools/testing/selftests/net/Makefile          |   1 -
>  .../testing/selftests/net/gre_ipv6_lladdr.sh  | 177 ------------------
>  3 files changed, 6 insertions(+), 187 deletions(-)
>  delete mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

I'm going to apply this series well below the 24 grace period, to fit
tomorrow's PR.

Any feedback more than welcome, but it need to be fast ;)

Thanks,

Paolo




