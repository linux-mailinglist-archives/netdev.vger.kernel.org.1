Return-Path: <netdev+bounces-221230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA11B4FDA6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A551886A9E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4B63431E3;
	Tue,  9 Sep 2025 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ujv/kshz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF62340DBB
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425191; cv=none; b=uSCpsVhYxlv+CkEGUTL3UDY3sMyx9guk+5WnAgCpzjDUqMk6qqywYktCh/5I6nAa5NMplSODisFEMbMiQVkpRtCICd4QqE4YPEPrRYs7DtKqITBfLWU/bzU6FoNBVy6+m2dPQMsP1jn4I+tPUVwc+3VfOmRQxiOiWP6s6dNDTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425191; c=relaxed/simple;
	bh=vi5VRQkGnadH4GghNkC+dE6/jru5UwXPOOOgEteonfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGdZ7a6AfKtjTPCZonS7VLo5IetUiCxkbeaqX850pUfgl1Uot+Cm/uRvVwGbFABelO6wTGFiadDAwZgXQSih4Wl61/SM42l9B1NKeurooK2T439/5AIMTiHjvM5lWjG+SIRhdG7ThoY2xdCeIDz/gQLPU+/17RI9oAHZ43/+rXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ujv/kshz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757425189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GohOyoDd6x5FyrxWCq8oo7hZUyfe+EcNhFxczstEYjc=;
	b=Ujv/kshzHtA1mLGp4PDx0tN4NJsaWmOXx2i/ZHq1FaXLIH5Li1c5AYSBBKcjxYAWlq4lk7
	gyltq1OKyr/Z6i4HYxNboAS/JPqgtqEUE0PchdlOtg/Gakmfhj61NES4py4pBkhNplcFyJ
	U2+pVUCKOqIRrxUohlRzrwED5PiQZSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-bYyznTzbPn-1qP80LSWDzQ-1; Tue, 09 Sep 2025 09:39:47 -0400
X-MC-Unique: bYyznTzbPn-1qP80LSWDzQ-1
X-Mimecast-MFC-AGG-ID: bYyznTzbPn-1qP80LSWDzQ_1757425187
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso39839365e9.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 06:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757425186; x=1758029986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GohOyoDd6x5FyrxWCq8oo7hZUyfe+EcNhFxczstEYjc=;
        b=oPwIfadScIc7jpOU6P/4aK7IQfGF1xWpfFOFf4dJh8AnSTfoM6mMX5WLyf1g8xnHs1
         5HWIhA1HWGAs/spPyGf5gqOL7GbDIZ2pYZ6cwXlBkUcCSCtxltb337fi3NRPaTnUfZ4S
         h6zPX/NyG8x1vA2F9TvXZu3ZJT5Vy55e7D48d4bihsyGG/a2RLZgYX71zoHCAOZmrOcf
         TPIRE3NXLhVm/1fpdQYy5AexELqioKz4CIMN75DD1NV177ystlIkbeU1yLCAs4AFwQXq
         N1Ny1hhfrUG8q4WWyfxCCjALsg5px05wl4kirGt2qTKeNK+u2rf5lbig/zqRpHENG1VS
         ZzZA==
X-Forwarded-Encrypted: i=1; AJvYcCVu1LRl3PpDfICFKyIcnnnQk1uUT3jhlxSbJyfSwmugs/CNrwJuMECfY/6G22uMZz20Lg7oRsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHFvDg4HEM3JZ5mkdVpUsixVYPwcJyjl7Eyl8IWFhyIusN2ne7
	8sKwoZBGm5uPLvyCs2G35s2AwPL32Wz5VNwVAIFzRKzeDKGfXaB1hIHw9VMNBtzfskepy+EFPBD
	0hDqsfs3M3ZKmczIfHA1DHRJoRZNLslRMmdJvCzJzmKxyFOwtLxPUFZLs0A==
X-Gm-Gg: ASbGnctEOVXQvJjW5amHlcC5/T7zR8jH+8rvAR5QBxSD0ksJhsVcBSFN1T8N6i/P3Vr
	TJsKkaHBldPAvr37ERk9UOFUNcJph6nps5NkDBo0uXhEMcIfmEaZex73bJ+qPZhq0/Da6DIDhMa
	UErSvAtg0BSLjcfYbEWi9a1niikf9CGvaqlIveMrSVftrZSftRk7XLtLZFUisgE8CLlCn1Ypisr
	pLAxEBKTlkAqgILXabMSq90626idZBD4VFPOgkJx7493oqpmEk2DZVFKjW/1A10J/Cz4YEVqEBz
	WB/2fVlSqLHJwspg0PuOaqPcgxSLQf8IdWOdoWtysLF4h4jAoHDWzp3oMVqybiLpGJ6secU0Bt4
	0rhZlJu7xaQI=
X-Received: by 2002:a05:600c:5309:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-45de73821damr68920095e9.14.1757425186500;
        Tue, 09 Sep 2025 06:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8vcW13o8zQiQ2BPQk91775ugYApMAY0U59RrXwvT1V4eBKeiivLPWrCq9O8pjWqULjjLA3A==
X-Received: by 2002:a05:600c:5309:b0:45d:d86b:b386 with SMTP id 5b1f17b1804b1-45de73821damr68919805e9.14.1757425186131;
        Tue, 09 Sep 2025 06:39:46 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda2021dfsm179865925e9.24.2025.09.09.06.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 06:39:45 -0700 (PDT)
Message-ID: <047408ad-6fe5-4e85-8704-16edb289ca93@redhat.com>
Date: Tue, 9 Sep 2025 15:39:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 5/7] bonding: Update to bond_arp_send_all()
 to use supplied vlan tags
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-6-wilder@us.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250904221956.779098-6-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 12:18 AM, David Wilder wrote:
> @@ -6633,7 +6638,6 @@ static void __exit bonding_exit(void)
>  
>  	bond_netlink_fini();
>  	unregister_pernet_subsys(&bond_net_ops);
> -
>  	bond_destroy_debugfs();
>  
>  #ifdef CONFIG_NET_POLL_CONTROLLER

Please avoid unneeded whitespace-only changes.

/P


