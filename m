Return-Path: <netdev+bounces-155758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4EA03A10
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 09:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7177F188727E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D2B1E25F1;
	Tue,  7 Jan 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3Pg1PiV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32F11E32C6
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 08:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736239484; cv=none; b=tA9825Th6Ievz8dEJYkengbp/Qhfns4Vx1lHPvpYNk9jCqFmWBYZEAP4g/2jqNVw7K7Q2XyB5+DtIO0/TxcMuC8c7guhNoH7Cri9dgCjCOJOHYH9WltcUiVpNY5SgAq/fSwNE7zWTaYHtNCDDgeGcHQaDpZNAzdNBKbW+0VqtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736239484; c=relaxed/simple;
	bh=9z4E307FEw5yEmX/R4lxvUrMV7D0T547+CC68yqF1tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEXwbUviveff3fThwUaIdSvI+1Vc7OS6bxN3NC62k8pkyl9vysoB7MH5Yq5CkZtviO/51L0J4phVcJRmnzpkx2mwc0/NbVHX9jFyT35DLHnOZ2m1u9sUX3/nR7IdgpJu18DDCp5iwxgxO+XmsycsbOhSwW8QlJYV3AwweId0pGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L3Pg1PiV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736239477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHBnQGum4M7ipVuexTEpYGlSJHQu9KV4nhMGzektAi0=;
	b=L3Pg1PiVcqiH5MTJ89RF68T7cWr92llLGBzQs+PGgU505+nwjrUhEXCWOGq2Pv5WGEOArp
	1IEcmeAyVXVsEtSi1/DCUUunmXvTe1eZ3QphWi0j1MiV4Ed3UjsfXmGzFZ6mov1NOrjrRk
	16kDfRHv6JYGxg7GsnTsiOi9TQJ8/Bw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-_Unu2T00OUOuG3hiGjBYaQ-1; Tue, 07 Jan 2025 03:44:35 -0500
X-MC-Unique: _Unu2T00OUOuG3hiGjBYaQ-1
X-Mimecast-MFC-AGG-ID: _Unu2T00OUOuG3hiGjBYaQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f3b93f5cso2944488785a.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 00:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736239475; x=1736844275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHBnQGum4M7ipVuexTEpYGlSJHQu9KV4nhMGzektAi0=;
        b=S3myIhqekexFuc8tCjEUHfgwUkvhHZtg/BeVG9EFjcxxhKRFCEDvIfLukeCEOxJ5aN
         mw2EQDJpbSnVOhY20pF03Ozwm/J5/cdy5eeXg70GrQO56IB7jYrNNFIRsXi6+fPVMaKr
         uuf8a5U2l94vHsK4BtN+5P7ksRWQ2R3CKlTezMNV1T3XR1j8IJH6P8ZZLT/oVNJaYbmX
         mqoosdZEshujsVTQDRuu/FCcr4gXZ5y0TxruSQIjzbW6VaAn+6TqYm8Gtb1+v20DXna1
         LBPVHobwnlFcAoXUujlZ9jWfwGhiEFZPPqs0zN5Or09f5yRrBADXWgdjN+rdGTF0Sg/i
         hIsA==
X-Forwarded-Encrypted: i=1; AJvYcCWtY0zHYjwQ8MqR8mHZkos1wPZKkmL71X1fKmn95FQ5wfGifjJD42BR6idmXpZX7bSj0g2JrDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfhKxEpGmHV/91FsXAIIoWyY1vBlHUnSFRTllgJVD/7au73WP
	h14PXY907rsdB3Me4rVqSn+eLvEMtKt4l3Z+U/WjyT10jz0aD/guu6rRUWiwzOf4S3UvfqDqMq7
	g2+uJIPY453DVzNedU4ma5XqvVA1quzvO6lhLYlBcV9l/P0tAAUFVXK0mE42G0ljI
X-Gm-Gg: ASbGncuA8Khwir0Y/vBPN8labFxiKoptpk8PgII0ln3s9vv7NKLmv0HXT/3QxqV2ICI
	dDOhQyyttxJRXpxrWqsAJZtQhZpzk5r/WBeX6ObuNakbsNgVsrxEKHW8SJHhc/y9tIMVsxnSvuw
	D5Uxb/6QiZmpMtpjLV4s8ijtfJCAu8x3u1ZpospnRCYJZwh64MKE97Ddnfn9ru2jhx7RKoWvxSd
	48/j9M1vAp46+5r3o9dbmGHXOKTaIpZbuxjPjTquyKNSju92gpMMksnw1b/jGyeZv9PhYrVZ/Zd
	HoG3iQ==
X-Received: by 2002:a05:620a:2a03:b0:7b6:eba3:2dfb with SMTP id af79cd13be357-7bb9027dc9cmr357934585a.16.1736239475068;
        Tue, 07 Jan 2025 00:44:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQCMcAkJhmI/CqAK5HFPejGMDCVtbEjbyNYs7SJgbt11nVHwRNfhnAYo5Ac+BtyoR7P+tihQ==
X-Received: by 2002:a05:620a:2a03:b0:7b6:eba3:2dfb with SMTP id af79cd13be357-7bb9027dc9cmr357932985a.16.1736239474732;
        Tue, 07 Jan 2025 00:44:34 -0800 (PST)
Received: from [192.168.88.253] (146-241-73-5.dyn.eolo.it. [146.241.73.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2e6587sm1573880685a.48.2025.01.07.00.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 00:44:34 -0800 (PST)
Message-ID: <1f4a721f-fa23-4f1d-97a9-1b27bdcd1e21@redhat.com>
Date: Tue, 7 Jan 2025 09:44:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: use the correct ndev to find pnetid by
 pnetid table
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, PASIC@de.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241227040455.91854-1-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/27/24 5:04 AM, Guangguan Wang wrote:
> The command 'smc_pnet -a -I <ethx> <pnetid>' will add <pnetid>
> to the pnetid table and will attach the <pnetid> to net device
> whose name is <ethx>. But When do SMCR by <ethx>, in function
> smc_pnet_find_roce_by_pnetid, it will use <ethx>'s base ndev's
> pnetid to match rdma device, not <ethx>'s pnetid. The asymmetric
> use of the pnetid seems weird. Sometimes it is difficult to know
> the hierarchy of net device what may make it difficult to configure
> the pnetid and to use the pnetid. Looking into the history of
> commit, it was the commit 890a2cb4a966 ("net/smc: rework pnet table")
> that changes the ndev from the <ethx> to the <ethx>'s base ndev
> when finding pnetid by pnetid table. It seems a mistake.
> 
> This patch changes the ndev back to the <ethx> when finding pnetid
> by pnetid table.
> 
> Fixes: 890a2cb4a966 ("net/smc: rework pnet table")
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

If I read correctly, this will break existing applications using the
lookup schema introduced by the blamed commit - which is not very recent.

Perhaps for a net patch would be better to support both lookup schemas i.e.

	(smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid) ||
	 smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid))

?

Thanks,

Paolo


