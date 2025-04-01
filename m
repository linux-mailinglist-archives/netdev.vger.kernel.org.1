Return-Path: <netdev+bounces-178551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C56A778AC
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D037A23B5
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FBF1F03F2;
	Tue,  1 Apr 2025 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7sK777Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C11EB19A
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502637; cv=none; b=PncFrPi917b9XyyWSudFPiYDFUwSE0BuqbXwANj2IDo2NqWi7tSKNOfxtvVW+ISYhN18Ay639MnStIFwOedadq7DzKpzWo1Zo299s4+MAXQ2Sq0VliFYP1tyVNLzDx+Au7v7p5Ffen1j/EvpmAMkqOfLFzu86vYSIsYORS1U9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502637; c=relaxed/simple;
	bh=J9sN/SCpQdOsJ/VsXznV8BFQbWuLunif5HeENL/lal0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbqSYEBjMpX/Kz5hbFab6pD+vRYCNH00dyg3lxWk1JWe3LoTN+EzmYTbIjtmQVga0UZ/UZJmPF9MECfO7e9Q1CmQAzn2PBJd5X3khQFEaWcXa4TCp2rftJrREvixYLWrFAffxQOgVuyCUiCThEipDNAQv9oT1pneK51yoXwh9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7sK777Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743502634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPRFAnxaBhDNBUGsyHUsSaTq1XZo6xJwhW3PBzPYlGI=;
	b=Q7sK777YWHz3wDYkSIy9RHIlOi9gI5ABQMTPuX8U0mz8QmnD8wngPbPCszNQo7jlfshDx2
	RvP+cSDvUDMAJaoQGeYZ991O1hGMd5ezNFbgBu+pb13u7zwoJKOztedwNSHocbxfIhIX9Z
	4+I56IAcGOmiFQ3fuRMccY3/2sup8T0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-LtsbjiFqOqCDTI6qiAqm9w-1; Tue, 01 Apr 2025 06:17:13 -0400
X-MC-Unique: LtsbjiFqOqCDTI6qiAqm9w-1
X-Mimecast-MFC-AGG-ID: LtsbjiFqOqCDTI6qiAqm9w_1743502632
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cfda30a3cso34139135e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502631; x=1744107431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPRFAnxaBhDNBUGsyHUsSaTq1XZo6xJwhW3PBzPYlGI=;
        b=NS2YBZ3COGcM1pyC6sN4xjIQeiMg3ln+7m6bgmGp4GdojF9JJGvO0Mi0hfR0dFuiyC
         faqANE+Hxf9w2JDRhV65NIRWUJ4DOYr1ZTJBZO/2n1Jk0tP+Jxj39rJpY+aJyoA/9MhV
         443szXXhsJQ7duuHms3RdJdkfH30PX6oLzDNFa8G/AP+HZFLylGo00dFZSUUfUJJZQX1
         JWTurdJUuJpjto+ta5BERFVxChTBWJKwCl0sYQiXGLxDDILA+F59gUGc9+r0EEBMHQSu
         Vrn3JnG5G9qdT70Yi99CWuGd0OqANWVmyeuuXx8AhMrY3OcpzqODvrpH55IHRvUA7Sh3
         C9iA==
X-Forwarded-Encrypted: i=1; AJvYcCXt/j46slw80MPyrvxYeVGkvjr6tm2PbfxKCOipejsT2bXMgdDTOdsECKcTs8rGwkZRJamQ6M0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ELIu2mWCT03I62nV99swEFukU7UKNbp4ScwW/UczsnAdaVAK
	KBWvyEvcbV/wuBsyZf28GAkQMRVWlEVQ5TinUgUyXmxsbKfOHuDhzXSsxsUrrSGBE1DzJjGxMDD
	mk2noKY9bmcUyXDsyDxhPEIQayPeTQkl/AdznTY1/Ja9nNRuB2o4N/Krsjbm+SA==
X-Gm-Gg: ASbGncv9yM+WO/v0B3ndiwUQpp2XxbVrxdWo9m6lWFevBVkTCwmVCmZDI9sdfiH6ykP
	JwTvrgOicj38i1efvbsSAA5zY6Ssc6VZcGDRJWQagHx0pV1PHEy3EGFUjEUzDbsOuFAKGuxsFI/
	3GxUfaaViofZFQ150L+hCHocY+WMUhReUmj9x+MDOGXpkPvjQ9oDBllESVmkR/R5JGShfdtPHcF
	g6UF5gUMDeQcPHCU3pWQhgD338fGEKgtmKV04iXKpLLgrO75+0Gj5yJ9nocGpJKPxMPBwksUykx
	Xr5pBLXD9IHrd+gZjboZJ0II5rCAfkt4iJEBn79gMMbhhg==
X-Received: by 2002:a05:600c:4747:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-43db62b71abmr84549145e9.19.1743502631327;
        Tue, 01 Apr 2025 03:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+h2Z3PH+SSY1KJMU4wf66Mik4RO7KuA+9WwmoDxB0EW9Tc9oa0yAr71Cu5UVVcpJzNz98eg==
X-Received: by 2002:a05:600c:4747:b0:43c:f689:dd with SMTP id 5b1f17b1804b1-43db62b71abmr84548975e9.19.1743502630967;
        Tue, 01 Apr 2025 03:17:10 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d8314b6dbsm198004085e9.36.2025.04.01.03.17.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:17:10 -0700 (PDT)
Message-ID: <2a4f2c24-62a8-4627-88c0-776c0e005163@redhat.com>
Date: Tue, 1 Apr 2025 12:17:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] netlabel: Fix NULL pointer exception caused by CALIPSO
 on IPv4 sockets
To: Debin Zhu <mowenroot@163.com>, paul@paul-moore.com
Cc: 1985755126@qq.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <CAHC9VhRvrOCqBT-2xRF5zrkeDN3EvShUggOF=Uh47TXFc5Uu1w@mail.gmail.com>
 <20250330104039.31595-1-mowenroot@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250330104039.31595-1-mowenroot@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/25 12:40 PM, Debin Zhu wrote:
> Vulnerability Description:
> 
> 	From Linux Kernel v4.0 to the latest version, 
> 	a type confusion issue exists in the `netlbl_conn_setattr` 
> 	function (`net/netlabel/netlabel_kapi.c`) within SELinux, 
> 	which can lead to a local DoS attack.
> 
> 	When calling `netlbl_conn_setattr`, 
> 	`addr->sa_family` is used to determine the function behavior. 
> 	If `sk` is an IPv4 socket, 
> 	but the `connect` function is called with an IPv6 address, 
> 	the function `calipso_sock_setattr()` is triggered. 
> 	Inside this function, the following code is executed:
> 
> 	sk_fullsock(__sk) ? inet_sk(__sk)->pinet6 : NULL;
> 
> 	Since `sk` is an IPv4 socket, `pinet6` is `NULL`, 
> 	leading to a null pointer dereference and triggering a DoS attack.
> 
> <TASK>
> calipso_sock_setattr+0x4f/0x80 net/netlabel/netlabel_calipso.c:557
> netlbl_conn_setattr+0x12a/0x390 net/netlabel/netlabel_kapi.c:1152
> selinux_netlbl_socket_connect_helper 
> selinux_netlbl_socket_connect_locked+0xf5/0x1d0 
> selinux_netlbl_socket_connect+0x22/0x40 security/selinux/netlabel.c:611
> selinux_socket_connect+0x60/0x80 security/selinux/hooks.c:4923
> security_socket_connect+0x71/0xb0 security/security.c:2260
> __sys_connect_file+0xa4/0x190 net/socket.c:2007
> __sys_connect+0x145/0x170 net/socket.c:2028
> __do_sys_connect net/socket.c:2038 [inline]
> __se_sys_connect net/socket.c:2035 [inline]
> __x64_sys_connect+0x6e/0xb0 net/socket.c:2035
> do_syscall_x64 arch/x86/entry/common.c:51 
> 
> Affected Versions:
> 
> - Linux 4.0 - Latest Linux Kernel version
> 
> Reproduction Steps:
> 
> 	Use the `netlabelctl` tool and 
> 	run the following commands to trigger the vulnerability:
> 
> 	netlabelctl map del default
> 	netlabelctl cipsov4 add pass doi:8 tags:1
> 	netlabelctl map add default address:192.168.1.0/24 protocol:cipsov4,8
> 	netlabelctl calipso add pass doi:7
> 	netlabelctl map add default address:2001:db8::1/32 protocol:calipso,7
> 
> Then, execute the following PoC code:
> 
> 	int sockfd = socket(AF_INET, SOCK_STREAM, 0);
> 
> 	struct sockaddr_in6 server_addr = {0};
> 	server_addr.sin6_family = AF_INET6;     
> 	server_addr.sin6_port = htons(8080);    
> 
> 	const char *ipv6_str = "2001:db8::1";    
> 	inet_pton(AF_INET6, ipv6_str, &server_addr.sin6_addr);
> 
> 	connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr));
> 
> Suggested Fix:
> 
> 	When using an IPv4 address on an IPv6 UDP/datagram socket, 
> 	the operation will invoke the IPv4 datagram code through 
> 	the IPv6 datagram code and execute successfully. 
> 	It is necessary to check whether the `pinet6` pointer 
> 	returned by `inet6_sk()` is NULL; otherwise, 
> 	unexpected issues may occur.

The fix makes sense to me, but the commit message could use a
significant rewrite, avoiding the formatting and 'splitting' it in
several 'sections' with 'headers'.

The 'Affected Versions:' info is irrelevant, instead please include a
suitable 'Fixes:' tag, like:

Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the
secattr.")

and Paul's ack.

Thanks,

Paolo


