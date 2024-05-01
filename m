Return-Path: <netdev+bounces-92711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AE8B85AD
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7533E2839E0
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 06:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431F48CDD;
	Wed,  1 May 2024 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0UzUaT+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E331A60
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546116; cv=none; b=C0M/EgYAV0jJlQ7sI+Q/djpg4RJGaNhWSgvdUKQnLuiQQ2s09U0ggiYqmuazw3DwFRJEPCIK22YT1Bx5uOh5IbluEl0W9SStFaCwhvN3yR25yMBdPPiFBZaKdHSMMZ+rbxYjOGsj4tzgBxxJcbZX4WeBoII0twKZtV3FB2giRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546116; c=relaxed/simple;
	bh=YmSx92Ymgsk1uA29WwdG5jmpfLtYR2XT5kImnNzNb/k=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LaT8vztbv4QJDP09aybmXKEa62OTu36SMFTnkJJVEfKqRGElfoZprBNsOjJ6vYsDpz1KDayT4F9jHGV1F/Pvmcn5SeemhO67fsw3ORBMZJ6MqYkIZiUszyHgN/2EQj59jDxqgp6f7xwZ4bpcU9QkqT8FLkc59p2DbqHPYzCjil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0UzUaT+; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5afbcf21abdso539668eaf.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714546113; x=1715150913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwLoiI9qseNxIY8lHNGQaHIDD609lW6rFY/tCNm+L7k=;
        b=i0UzUaT+Uh7ZiPoDkoykRcC85kCdLqaurJiDx/JZ1iO5v1S5jQG6UFpZBRXguUe5vR
         K76f6oHP4ED+b+E5Z/vYOWq+QUfP8t86SjlUqleQJMIIx5ABcyP8vKV6aetK2z1jwNx0
         7CDatCh+hua49C7QDW7vrEmS3EfpQO1hslVzsrvwTqobpt+F/kMRW1RvUcy5lyMODHLd
         rUJVK5Z/bn85Ek8ODbXpxmCJiQsbfxV85eNDk4yBsY0w3XUp6A+kanvzhKzKBRQU3kbt
         99OLVcppDvtwpRWYpMRvok6I1olPlHZUjbjA6pa6xSywH/VDNbjdbJbvfGoQlhicStRp
         PY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714546113; x=1715150913;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KwLoiI9qseNxIY8lHNGQaHIDD609lW6rFY/tCNm+L7k=;
        b=eMXmJE790dO3+tPvGneEtgLT0ugHHM0jF9da+S9JWhmQCp70Z48XlmijeU6/62fubJ
         /VYu3QoeFcU7CBQM8tsxiFV3nRQY98lODJ4RMNbeC3y+TMZ3sTWUC+xNVHEGcnRxRrCA
         s9awTVm0AR+wgtj4ifo2VtIqUbpJphHFOngBBWMTUg4rV0E7kISOJLmNu7UDKoQB9od8
         ZAeLgNQ6ZG+2d6G4jd1FsN6CKxdRrXRfWU+McEKQyzfSn42cVwMweGmKaONBuagazkzY
         fel0TQ/t3q2PqlYOFPnAYdIhux216ZN/sMhk7z1RyqTc3DyPLeDMG9Y6vIoEBOOd68mT
         5Xvg==
X-Forwarded-Encrypted: i=1; AJvYcCXtC7belmy56ddPKH5GSaUSotX+di+vEIdcKvWZVCODfjjF9DK58zI+/ZwjDwrqepjrn7Zjwx+u0lteHP0gTOwWCOGQRMoL
X-Gm-Message-State: AOJu0Yy4Ul+hrQS+d8JqLdKxxuz/sEv+YtpfQK7GbOPgtt7nNwaTA25r
	y3dasVH5QC/j1v5mQhDOCIkvSj3FdzeZ9YQ0GZUGiZfNsYCRTuAs
X-Google-Smtp-Source: AGHT+IF81JIHfWk+HiXDbysWke5n1a7iTkx5WwuSty7qN7hpxsPtnDhYVjkbZJLkNhCd2VtgQMAzBA==
X-Received: by 2002:a05:6358:88b:b0:186:6e58:d81d with SMTP id m11-20020a056358088b00b001866e58d81dmr2056387rwj.3.1714546113490;
        Tue, 30 Apr 2024 23:48:33 -0700 (PDT)
Received: from localhost (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id r30-20020a638f5e000000b005f7f51967e9sm20441931pgn.27.2024.04.30.23.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:48:33 -0700 (PDT)
Date: Wed, 01 May 2024 15:48:29 +0900 (JST)
Message-Id: <20240501.154829.686841422238557872.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v3 3/6] net: tn40xx: add basic Tx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <c2b5177c-3782-44fb-b7b0-d3ca610af1b8@lunn.ch>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
	<20240429043827.44407-4-fujita.tomonori@gmail.com>
	<c2b5177c-3782-44fb-b7b0-d3ca610af1b8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 30 Apr 2024 22:40:47 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> --- a/drivers/net/ethernet/tehuti/tn40.c
>> +++ b/drivers/net/ethernet/tehuti/tn40.c
>> @@ -3,10 +3,1177 @@
>>  
>> +static inline void tn40_do_tx_db_ptr_next(struct tn40_txdb *db,
>> +					  struct tn40_tx_map **pptr)
> 
> inline functions are not liked in .c files. Leave it to the compiler
> to decide.

My bad, I should have found the warnings on this in patchwork before.


>> +{
>> +	++*pptr;
>> +	if (unlikely(*pptr == db->end))
>> +		*pptr = db->start;
>> +}
>> +
>> +static inline void tn40_tx_db_inc_rptr(struct tn40_txdb *db)
>> +{
>> +	tn40_do_tx_db_ptr_next(db, &db->rptr);
>> +}
>> +
>> +static inline void tn40_tx_db_inc_wptr(struct tn40_txdb *db)
>> +{
>> +	tn40_do_tx_db_ptr_next(db, &db->wptr);
>> +}
> 
> Functions like this are likely to be inlined even without the keyword.
> Please look through all the code and remove the inline keyword from .c
> files. They are O.K. in headers, so long as they are static inline.

Fixed.


>> +/* netdev tx queue len for Luxor. The default value is 1000.
>> + * ifconfig eth1 txqueuelen 3000 - to change it at runtime.
>> + */
>> +#define TN40_NDEV_TXQ_LEN 3000
> 
> This comment does not seem to match the #define?

Looks like so. I changed TN40_NDEV_TXQ_LEN to 1000.

