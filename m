Return-Path: <netdev+bounces-223419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9ACB59141
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B5D3B217A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB39285404;
	Tue, 16 Sep 2025 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWSVhcmW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FAE2741C6
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012519; cv=none; b=Ql6Mwd2hLIfSBtBRwnQ9984fgq9qgdshDMjesL7ZXYKJjwH5lSsJTKQ6elue3Zy/vf17jBR9svwToQ8lINXKpmNgWkQk7Iy9xVjJJn1rbeomNZW/Hh7JCyp/ETLTN9b+cXQyiGiCbtp1iLjQcnXQBKr2fGGYfcrn7y8i0F3mJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012519; c=relaxed/simple;
	bh=OTx1CX18N3834rVvwPY9O7+tKZ/kymmSB63p4JEscVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxXGvAEAv8ipopGhWXAgLrYEl/xVrd+/ZzvMriJxR5F3zQoUOyImCAgDKjY0ePN3Gp/PGd5ieg79seEXT7BE24LnX+eoTtUcVEWQG0rsBbUaqinMI1bXU6N4raiDKbJzxU6v1Vag9GKVXWxfohSDI6CLyUq0xZnPGgcBVw8BuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWSVhcmW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758012516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmN1zVAHoxMBQ4g/7XFyoJDJue0wyL96gZwCleosapQ=;
	b=fWSVhcmWJLGlXlLSSPuKY01paG+CEGOLTrTGsx/o8xhrTHqd+yhEwrVOZzxXTYcFFaMETh
	1mEtiRrgLSLnv0EYHbskOpDEFpxJ5/rTMJQkDn67SexMc2I0GaRqF2aBRdlJbMi654UT9c
	hEfDx+5WpvCbl12FGA2aobcqLLzSd/g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-8dzIuArsPrmtf3vs83mj0w-1; Tue, 16 Sep 2025 04:48:35 -0400
X-MC-Unique: 8dzIuArsPrmtf3vs83mj0w-1
X-Mimecast-MFC-AGG-ID: 8dzIuArsPrmtf3vs83mj0w_1758012514
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so15999265e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758012514; x=1758617314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmN1zVAHoxMBQ4g/7XFyoJDJue0wyL96gZwCleosapQ=;
        b=NF9EAYkdPUenI5+1Ckxv79l61jma7gjf3QCtG0t5tmNkuZXaISjL9uWnZYns3fF3Vj
         WqySdqWaS4Q1YwWBTfzZxlhsIc6KZmJNbU9KYCiJzNMrkuyQGwvXKOiwnfmnajvkmmcK
         ePEmr/5O9HsO8BWhMSsG2OYs1O/MF8MV2MGsFLJ1fKlTTgsdowQHZw9TsQcob2zTh96U
         ReeRVBNxJ/R+ebzVcIveUr+cprVNt11QM4S29D2U7uAyaQDhwCH6lsMwC/ZrLIS9rFf+
         INWawAMEaAUygx8zpWsi4Dc/3ta17xPdLreeQWkvmRfpmae2Mnlz9s9s0j3ONEpROEUD
         Rhmg==
X-Gm-Message-State: AOJu0YxlI11baQ5+Hvz8jFBjgosQTliNUE4fqkuaO727g3FJdyeRNWqW
	f5BlKdq43fos29DVxRFckzxmCBMUPltgG5A42gCw5CH2Ei/6JYh1XJ0qYfNWNtwerDA1fIIKgCO
	HuJo2FWnXflwkkICjZ4ylWbM2tMbbpzyLOm/osGE18x9NXjLJFxbVf0KgfA==
X-Gm-Gg: ASbGncuvJX+H8kMYTnBjuYOujxQ/dQjSVF0RohysmL2w8HbM0dODEvnwSAJDMFTQowq
	5ELMwlXbOJO0x9xu+XhA1/uhShyfQ9krtFNCdGQEQXlUIoPUT3jKQbeJl1u3cwRnWSPonJ5B9nL
	DPAuQgQl90Rg6bqAatxzQI+uqQQyYh+1WfCW2LftBr+T6Oq0TvoX9kCcWYckIhmVb2qky9DXVfx
	9aJ0NImqEJjIpx+wBxTHgmh4BKM2jsSkCtDWDUeLz8zTo9OwZl9968quMiV1H2Y5b15vH0yv3Mw
	gT3MpB1MstWE/0oCwYdZJJwDYk4wtCRcP2NpjIbHqS8943XFje/X/7xzyi9kStEPnHfaRgRCYVC
	2uywv0c69U5RC
X-Received: by 2002:a05:600c:8a0c:20b0:45d:d944:e763 with SMTP id 5b1f17b1804b1-45f2120600amr120929475e9.33.1758012514026;
        Tue, 16 Sep 2025 01:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMOKpkiTHjhH8V1CoxbkwPtQS09nDDz3Z1SOX4Anr7W9Jju1W3xt7/QkqndQiKwCF6Tcwikw==
X-Received: by 2002:a05:600c:8a0c:20b0:45d:d944:e763 with SMTP id 5b1f17b1804b1-45f2120600amr120929185e9.33.1758012513639;
        Tue, 16 Sep 2025 01:48:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0157619fsm215833385e9.7.2025.09.16.01.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 01:48:33 -0700 (PDT)
Message-ID: <a52f9dfc-cfb8-40ec-b5e5-102b99803b1f@redhat.com>
Date: Tue, 16 Sep 2025 10:48:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v06 00/14] net: hinic3: Add a driver for Huawei
 3rd gen NIC - sw and hw initialization
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1757653621.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1757653621.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 8:28 AM, Fan Gong wrote:
> This is [3/3] part of hinic3 Ethernet driver initial submission.
> With this patch hinic3 becomes a functional Ethernet driver.
> 
> The driver parts contained in this patch:
> Memory allocation and initialization of the driver structures.
> Management interfaces initialization.
> HW capabilities probing, initialization and setup using management
> interfaces.
> Net device open/stop implementation and data queues initialization.
> Register VID:DID in PCI id_table.
> Fix netif_queue_set_napi usage.

Side note: You lost/did not add a few Reviewed-by tags from Simon. For
future memory it's usually safe/better to retain such tags in presence
of minor editing.

Thanks,

Paolo


