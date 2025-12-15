Return-Path: <netdev+bounces-244751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB873CBDFA4
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4D2301D5B6
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E42DC76D;
	Mon, 15 Dec 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQo6xXXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAA2D97BE
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804640; cv=none; b=Y7V4gpzQyq7pRRu5oepEUNthOcweZjBUzAVzbL6qw8UfVwnjIkTRSDY05tSgV5ruoop3OOjD24UZTV9WSg8f+DexMWdLzFuVAwUoG0i3FXELoRfGW2l7g7limCzYsY8rjxoQxxyTAdY1PWbVjEM+ikgjftKrFkf8iREhiwJwtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804640; c=relaxed/simple;
	bh=CpChH6XBVwNzsULRI5sfdZSyY2QzhI0ICFKhAooCm4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qL0btt2zBp9vaqEmrgjBt1u6CA5I/wITpe1DdzM6j43EZ0nUHqkSwdhoLh8bIAbTlzAZ5oKXyuryfCfgnPCB2bj/UavpWGvBzyLQnISKLcD3qc6xIy+zUDdl9NMIuwddlU6vkV83WeeLp162qu0kEP4jr/nzIEv7gZ4CxCCS9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQo6xXXl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-430ff148844so356733f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765804637; x=1766409437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kX23ndU6M94o44GURT4Dg9znUAX/wFKjkjxaLn6MLp8=;
        b=OQo6xXXl6WFWMEuD+N5boAIZh5FbHc7qyT3ee/hbfW7eGN54CPkyBSeqBNvgPpDlbH
         Yerlucmq8q8a5aNQX+kT0YONSKxY3BZyPiRHwSK+trl42bzlnGmAkDDnPTQEzw4Lzg36
         jbP+NXP1tyTaYYaqolJWuv+tTiQsByuEuZie7jMktujj9CE9JgQgcLMYL4a9yGxLFgmv
         pEHfpmcptU/hnE5uLNDZ7H+OsDaRGfGioSneITJvh75MDRfi2z0SPNc9791Ju7GJ5+A3
         XlxExdbtDlU8uh9+eN42jn3vCvY0LHFA2ZPKtbNshAn+AO+lLMgjp4XFdNub8EV69BjQ
         YbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765804637; x=1766409437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kX23ndU6M94o44GURT4Dg9znUAX/wFKjkjxaLn6MLp8=;
        b=kjRzMOgJ8yFl8x+v5Tn7rOMyAUpAqBuWs8hxLVKbK7UXJxDczCyNeSnDjZtsS4w9Hm
         jo2bH89RWgkwuzhvKRORwXteg+h/XHpPHWdORZyM6zISoVaLE5SB1HzNk4yWG9YjcL9V
         recHw2TGHampSp35ndt9v9TOuYfH22uNTSMg99L8nZrBnwM1HYiaALCTKsYcA88VvjeW
         +lmoZy7WP0tPpnABmX/VhVnR14OYOij91zrSWrGBEaOp4I1/wZ+QQSuY0wOWJY+a74x1
         8xX17O2jrcykNXkxnemD73GaAahpGDk6aySDHr0CIIWE3hKXGVDYt0WXlTVr96WiK7sG
         miaA==
X-Forwarded-Encrypted: i=1; AJvYcCUC8aQwkp3FvcjPqWLAKVkyQ5ie+eI4nDsMtjmdGt3IbnZ43hfbYqO2dWbSYF1nig7rd1U+XhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3UD693yAXbFCQg1sGZsweaeHn5PDeEaWb0iTwn3dBK4m8LED
	dv8F4CgSBiLHGzTZGk7/cuCUD6ahJ5DrPMNCdFlZ1DooDWiXcTP/uXnn
X-Gm-Gg: AY/fxX5uYJAANMgkU8rQJqhrhbIieBzO6m3imJzRCrFZYJlCVyiAEGBel8c9S/HhnNw
	l1PQy9eaPEkU7Emahtq/JMPP6K2UquZg2/+9sza3nHgCwGfyqcZcXoS2yENTmsQ8Qn859mCl+aQ
	0PafP5/P2cQCTt5NTqiknUJOgmZBmnYn7Ty8gpZHONmorPq+kQYKSCIYZUTk7LkPz1TO+1N1Rsa
	GS+3rZVoP6E8GU7mlNJ8u2+Qp+WU6HRWPsQ106xh7tW9P+//gtkcwn7+rUW3/bfPZ1H15v8ze3F
	NnS7gQ7KGv+ClPuYBscRpADDoGTbuf5WjQzcchFewcVqZj/r6wpUjaWmkuWF+h6yA9p3Jlz5K/6
	mpFW/Nrv74gTG+7WFmHckxkSVbBjGuqZ0v6H4CVLEEcXZl3Ozeoez1JJ66K7sUcsDb1Y+UjqM/K
	JN8suEsE8dpzbFyz9DRFsLvBfQMMrCaMAuq3I98O8DWCwoSYtsvRqDyVVCHJ9Jkr3dKSbeceTt1
	nELe+5oBoTP
X-Google-Smtp-Source: AGHT+IH7fIvnlL6YouwbGTO5//B8WsqjPffnUKjT65xkhd4Q0MMVRtlfIHMPKRIxKiLS93T3R0SCpQ==
X-Received: by 2002:a05:6000:3111:b0:430:fd0e:a502 with SMTP id ffacd0b85a97d-430fd0ea63bmr3262763f8f.22.1765804637136;
        Mon, 15 Dec 2025 05:17:17 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f4126477sm13332514f8f.10.2025.12.15.05.17.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 05:17:16 -0800 (PST)
Message-ID: <c3e98e4c-abc6-4918-9d63-cf3c6b47d943@gmail.com>
Date: Mon, 15 Dec 2025 13:17:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] sfc: correct kernel-doc complaints
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-net-drivers@amd.com
References: <20251214191603.2169432-1-rdunlap@infradead.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20251214191603.2169432-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/12/2025 19:16, Randy Dunlap wrote:
> Fix kernel-doc warnings by adding 3 missing struct member descriptions
> in struct efx_ef10_nic_data and removing preprocessor directives (which
> are not handled by kernel-doc).
> 
> Fixes these 5 warnings:
> Warning: drivers/net/ethernet/sfc/nic.h:158 bad line: #ifdef CONFIG_SFC_SRIOV
> Warning: drivers/net/ethernet/sfc/nic.h:160 bad line: #endif
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'port_id'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'vf_index'
>  not described in 'efx_ef10_nic_data'
> Warning: drivers/net/ethernet/sfc/nic.h:204 struct member 'licensed_features'
>  not described in 'efx_ef10_nic_data'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

(and sorry for using gmail despite its ongoing war on federation;
 unfortunately it's the least bad alternative available to me)

