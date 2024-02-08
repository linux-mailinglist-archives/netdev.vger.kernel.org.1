Return-Path: <netdev+bounces-70382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FE984EA75
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19E6B2A65C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455804F206;
	Thu,  8 Feb 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeWMXb0o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784354F5EB
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707427532; cv=none; b=cxmk70MBuW0yguLXT2gI12zXAqGP/yR1PcDiM28Y7snH6aDQ4kmMYd8MASJT7Cm2NQ4s89nE0Glz66lk3zypOlZMv/k9+cUNIqd4Qqdtrzjg+kQMAkxv89IHQGRwCG0XHjXzilyetjFBRCrYIkwgq9VuJWTdXatF//O9GZz68Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707427532; c=relaxed/simple;
	bh=VIOLLkgHcyj7IUTAR8il6eMl03ASlAScU7bsovNoA7c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rAhjfTEN8HEr6NrLb9KnMJcWdaqwL3c62HcNewst88oujxMIpSPsXy7MGhrGr00HWXeGj0pAyATmauP/oiXK+XqmiCQNMkNJKu+GVTm4FctDiAgLCS3+5c5my3jDBcBTHaLeYmMWuDliUNltBTISeG4HyHgTnKCQcKKR/ZjlaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeWMXb0o; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3884b1a441so32375666b.2
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707427529; x=1708032329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eSyai2xAtHzho3WhrHiek+qE38r8vSHDvAJe8hAHVM=;
        b=NeWMXb0ovssBe6Ms8JYfI52m3Fn63tApA+5CQZ7+p/Cmd8Q2af+7QQbTlUQ7EgWKs6
         ZZxAhkRlOoRq1NZfiAlaWraOiCercZN0RPmx0WPBHrB9nlQfBuRvQk+f880649ynicre
         UJTmZf/lBCwxoIl+Lyu/8w+QW2EG9G7Zxvt0bbKhjVzFauYWARm9uXyPXteI67BBVpsB
         vr7s7quvL4Mz6YHJySHwNXFtnMGFNV7T4HY5Qt3XyPKZ7buKIvL5xe5BoQmB6Qfdntdr
         6Z3qAXZ/PABtG0vyjkl0a7Px0Qq3OyK4B9MVUFDRVf0q4JSXeJesN4fXLj2vLLzBsFll
         3ZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707427529; x=1708032329;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eSyai2xAtHzho3WhrHiek+qE38r8vSHDvAJe8hAHVM=;
        b=aUp6UCKExCqbFb33mreRqwf3G+BxEV3K7nBJO6vJStOeqQTo8lJh7O2Tpft3SFvCbN
         J3YZmW2glb7cOjnKKKjkH1gKQn6XnOz95U+GOtgDAuHAuUI97R/kx/TuPQQmUOnJtfzL
         Evb2w5Jdb6cTucpXM33alUf7svqvM3mFJxpYHjMesdIEdt947BB09kHliWFUVtbecduV
         X+Hk3OArnFRr+LNjnTMW+jAAjq3KCbrejtflSUEBXAQzGXPPQLnh5mdh12XyTzpBCS7I
         x5bt5OKgGr2cElbN6rhPICM1AfWt8coSzA6IwwaQN82cR9dYWrmfkAHnCYZt6h5T8ClI
         FI5A==
X-Gm-Message-State: AOJu0Yw9Bf9D5n1V65sc3FVLSCxWvC6C4eUkTfsvZ5YlV4rif7xGa6zz
	Txt7B8tp88HW+Nw2N2eGzQQtlhpYl5mwjxEkB9FgC+anGVCBs/ZQ
X-Google-Smtp-Source: AGHT+IFbvwNCyIYgEB3rS0fE+8tWI7/39Q6Qv8Dq9JMM6sEOLFBJBcRDiJnIDQP1dOeArjcATo5d6Q==
X-Received: by 2002:a17:906:4a93:b0:a3b:aefa:fc28 with SMTP id x19-20020a1709064a9300b00a3baefafc28mr353054eju.72.1707427528494;
        Thu, 08 Feb 2024 13:25:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSg5yDNtj+o5Njn9RqtOPYakZhJ+c1nLmX/EvMoKy0EdnrCbRNxFthMTaSIxP81pwHApSiEvcp9m1a2gzLyjK5Omu6n803GJgBpScON9dAr0moX4/l+oGV32nha7SERC9vL84peIANtVVWqODfhAVwVsnN9Pc6lVjihwoZuiKc6I9KjeBOHpyiuyGzJMvGUw6sVE3F+cqQhEuEa1F/o2HOCRUZFeGfqd6b4pdVz43c0f+JfZ6f1F35xTlHv10ura/zpduUlq/YEARzmBXbq5sQPOnN/IyiMnqTbnhoC148FR0=
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id vg17-20020a170907d31100b00a2b1a20e662sm84340ejc.34.2024.02.08.13.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 13:25:28 -0800 (PST)
Subject: Re: [PATCH net-next 1/7] sfc: initial debugfs implementation
To: "Nelson, Shannon" <shannon.nelson@amd.com>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <9454bbffe8de24c0afcc6b307057e927ffaec6ca.1702314695.git.ecree.xilinx@gmail.com>
 <182a168b-2898-4517-b2b9-8ef93ef72292@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ab5b48cd-9c99-f1a0-45b7-d1182b9adaa8@gmail.com>
Date: Thu, 8 Feb 2024 21:25:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <182a168b-2898-4517-b2b9-8ef93ef72292@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 15/12/2023 00:05, Nelson, Shannon wrote:
> It would be nice to have a couple of example paths listed here

Sure; added this to v2:
See included DOC: comment for directory structure; leaf nodes are
 rx_dma_len, rx_buffer_order, rx_buffer_truesize and interrupt_mode.
Is that what you had in mind?  Or more like
 "grep -H . /sys/kernel/debug/sfc" output on a running system?

>> +/* replace debugfs sym-links on net device rename */
>> +void efx_update_debugfs_netdev(struct efx_nic *efx)
>> +{
>> +       mutex_lock(&efx->debugfs_symlink_mutex);
>> +       if (efx->debug_symlink)
>> +               efx_fini_debugfs_netdev(efx->net_dev);
>> +       efx_init_debugfs_netdev(efx->net_dev);
>> +       mutex_unlock(&efx->debugfs_symlink_mutex);
>> +}
> 
> How necessary is this netdev symlink?  This seems like a bunch of extra maintenance.

AFAIK we've had it out-of-tree for a very long time and not found it
 to need any real maintenance effort.  And while it's not strictly
 necessary, it is fairly convenient.

>> +       /* Populate debugfs */
>> +#ifdef CONFIG_DEBUG_FS
>> +       rc = efx_init_debugfs_nic(efx);
>> +       if (rc)
>> +               pci_err(efx->pci_dev, "failed to init device debugfs\n");
>> +#endif
> 
> I don't think you need the ifdef here because you have the static version defined in debugfs.h

You're right; I'll fix these.

>> +#ifdef CONFIG_DEBUG_FS
>> +       mutex_lock(&efx->debugfs_symlink_mutex);
>> +       efx_fini_debugfs_netdev(efx->net_dev);
>> +       mutex_unlock(&efx->debugfs_symlink_mutex);
>> +#endif
> 
> Can you do the mutex dance inside of efx_fini_debugfs_netdev() and then not need the ifdef here?

Yes, although I needed to refactor slightly because it's also
 called by efx_update_debugfs_netdev() which is already holding
 the mutex.

>> diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
>> index 175bd9cdfdac..7a9d6b6b66e5 100644
>> --- a/drivers/net/ethernet/sfc/efx_common.c
>> +++ b/drivers/net/ethernet/sfc/efx_common.c
>> @@ -1022,6 +1022,9 @@ int efx_init_struct(struct efx_nic *efx, struct pci_dev *pci_dev)
>>          INIT_WORK(&efx->mac_work, efx_mac_work);
>>          init_waitqueue_head(&efx->flush_wq);
>>
>> +#ifdef CONFIG_DEBUG_FS
>> +       mutex_init(&efx->debugfs_symlink_mutex);
>> +#endif
> 
> Can we do this without the ifdefs in the mainline code?
> (okay, I'll stop grinding on that one for now)

Ifdefs for struct members that may not exist seems to be the
 existing pattern in efx_init_struct and efx_fini_struct, so
 I'd rather leave this here than wrap this single call in an
 efx_init_struct_debugfs function.

Thanks for the review!

