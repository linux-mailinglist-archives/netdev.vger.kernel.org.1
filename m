Return-Path: <netdev+bounces-178567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55250A7793B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C34C3A955E
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3261F1534;
	Tue,  1 Apr 2025 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSW7w7Ti"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D81F1515
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505294; cv=none; b=dOUFGROXVoG6QXThVEMKN4X0xnO/eDG6bymT4xgqbWPOqV3u85MZWfeWhmZOA7WSW4YhIBqx8VF4QQUBxdSBGCTbuyk+/l8AzR+CVXEtzZtZDjuAW8apTR9VhbiDewyyevqwS7Ubib8B5p6Y7dO4h90bwvkgz8FIRCh0s8CxnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505294; c=relaxed/simple;
	bh=ivqGICVxLEozQGBTawILTTXP7Nl7eMNQhKWIstBNXQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huZZiEitbXLEnKcTM1Bv7F3iV+JqYThihhJt7PYFj/Ufh+H67lyYyxD0ofZp6ALsizCKK+XXL95tcSjfRVnAtRueaosuJWRkhJuOKCmKBvR8580+yo55BMzY0xJgI66vcoPa/rhh7BWo/3b6pCTnLNTW/1iX217Ye9wUEgleeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSW7w7Ti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743505290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bjr/CuUIuzeRdMkmnmhYE65i0HIy2EZrxJ55nmXT618=;
	b=RSW7w7TixoRDbQ7ePr/B4jSlBzgTzAbHhC/5YdtNinMPSwT90hgnoEHR+k2mYS+ywzC0e6
	B/KLPLlDFsgQz1goHzFYmLJ8I74Sq2M1WiTGkjH+VFPAg1VFVul63Ik68mitNmMLNB+HfO
	1V149wZmzFGDJV52KnsnaRe8D7/dDYE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-yEpzRzF2OpOkujwAXIeFgQ-1; Tue, 01 Apr 2025 07:01:29 -0400
X-MC-Unique: yEpzRzF2OpOkujwAXIeFgQ-1
X-Mimecast-MFC-AGG-ID: yEpzRzF2OpOkujwAXIeFgQ_1743505289
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so30853385e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 04:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743505288; x=1744110088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bjr/CuUIuzeRdMkmnmhYE65i0HIy2EZrxJ55nmXT618=;
        b=KuMEmD6+gwDRS1qEjSrlXcs9A6LiQSolsyCsDghFxUmzfxYQKiElpGoTLiloLAsGk/
         alQOafL7uyF9W76IxrPm6oH/JSr2pVQIdNlb+asBTy0ASvoipRMKYPs5NBWCnVjveWzW
         yo5J3+lCmkjf0U3ntHnw6e7jQCqQhwM17LhLmRqaaZ47MBh0Y4Lgctm73V9ctHcb27y7
         a9iq7u8hDCJz9im8I9T/nLkJwIR1rSguaOxXuGtNAhW0lZG0dkVll7sBzgUzka4r/W6r
         iNLfqRIFqPb3T6+ZaT/8dOV+z1NmmMFiXT+9jrxCFrTN0uZteW79G3EJQsBw9qwvbFcm
         zoQg==
X-Forwarded-Encrypted: i=1; AJvYcCUc2RjcmIJ/HEJE9CVcw2WYmIjD0CTYE194RRb7nFTTgctbGNgkd2ZirWYRVQ4CAWK1DQgw5nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPpuOXNDTdZ1wV0OgU/9kG5zazFWs0g5XBXuXC5CV5yW1l2Kn
	TvKtwrQ7x3uDUfz5+qOp/eHr60pkWcCQm98xXG5TU9IlgNsxa4NSqaOH1/lPlTec69m4jZ0Rx4H
	YKntOuVxgzb9x/HBo0gHBrbKSGeZ20/dc3Ev+jztU07lcc5jfPTX8Gw==
X-Gm-Gg: ASbGncvHsL3r78jQikTKFTvWQJCOzbqN7sUZcgiWix4Y+On7aHf7JzThIlVcdgXV/XK
	x2OPVGYh+D0MaZe8h2jGRTMGVE81xN4vItSUAVoO4DEuTnGc+kqvxTCUL2Qkr/sn1kAAJiYn9qu
	Bd4yog8MFJXX2QS+qXEGdGHfka0NN+kC2vJlHh6D3pbFvwhekueFh2k4NiXaDPwtXo+VcunAS4O
	dqWIlxiyYroIguMF2RYI6IP60yrIrW4wxRCjXRQP/szCYYAR4HVf91ANbP40ZUUXF7tIzYyrcAp
	j58krjVSxoom8g1GuNpRBRS+4czn7s+DZ096gIm6puyQnw==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43db6228049mr92536675e9.12.1743505288648;
        Tue, 01 Apr 2025 04:01:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWR6oGgrBc9yh+EIWLu0f/Rl10wsiQ6GwZIk1/Jim/OUEtWye5DYg+AcOZjj2bj4OhsRKyqw==
X-Received: by 2002:a05:600c:310c:b0:43d:db5:7b1a with SMTP id 5b1f17b1804b1-43db6228049mr92536285e9.12.1743505288311;
        Tue, 01 Apr 2025 04:01:28 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efdffdsm194280015e9.18.2025.04.01.04.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 04:01:27 -0700 (PDT)
Message-ID: <37f86471-5abc-4f04-954e-c6fb5f2b653a@redhat.com>
Date: Tue, 1 Apr 2025 13:01:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix general protection fault in
 __smc_diag_dump
To: Wang Liang <wangliang74@huawei.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ubraun@linux.vnet.ibm.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250331081003.1503211-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/25 10:10 AM, Wang Liang wrote:
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 3e6cb35baf25..454801188514 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -371,6 +371,7 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
>  	sk->sk_protocol = protocol;
>  	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
>  	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
> +	smc->clcsock = NULL;
>  	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>  	INIT_WORK(&smc->connect_work, smc_connect_work);
>  	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);

The syzkaller report has a few reproducers, have you tested this? AFAICS
the smc socket is already zeroed on allocation by sk_alloc().

/P


