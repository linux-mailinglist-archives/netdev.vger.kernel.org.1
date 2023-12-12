Return-Path: <netdev+bounces-56442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412CC80EE33
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7041E1C20ADB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E81D70971;
	Tue, 12 Dec 2023 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFWd6RjX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8264EF2
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:59:00 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2cb54ab7ffeso39291061fa.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702389539; x=1702994339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGUeTzmapTO2JWXaC5c0jxeqygmi7OENU9XpDotTFRQ=;
        b=jFWd6RjXKext4lDwdInlWKX/dvf4SQ5vN89e8iBmRLkPsiWO38DA8MquWD/FvVA/Sc
         XGq/qFBV7QP6xitQ+95EUC6hxKN40FN8bztzPPTdKvQRWKXD2ySt9yhw5qiLC4/TA/Gh
         Dmxopb8bu8HlkggyCAQDqDTBtaa1BPxiWSllNnSXVkkjds6YsdGfIrxEuGbPhnWjNy6T
         6Rq9cFNZ2MBF/Tum+sydBgnEUOv6MTbB6jLbGNrKw+KbhyfUYo825EWynW7lLJCSy+67
         PVYggi1iloHkbQYlBqwkMSjSXtNUZVwIECKXfFLx/5DIC6vWoNPzAUUIqO+hwx17BO39
         nEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389539; x=1702994339;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGUeTzmapTO2JWXaC5c0jxeqygmi7OENU9XpDotTFRQ=;
        b=Ni3odD90dW/P2r+DgCws9RE7S6BirwqqpOg7yFjX3Rnp8sXXXkNt6W/naISMLLh7nt
         lSXDgGLRgq3sboB2rzHY90VunUh3Sx6DrbqV+he1LWFt0r+noUgHop5Z2D2fI6k6gQbz
         ErvV80LYgFC0ODtLGaDlgP0vwh0zyZVYJRpSDYkSJQmjwdZG7AL3max/Z8HYTppuw9aI
         2dkMIPHcrktMT0m8UNHYrBUCIueWHJGqoFWKvxd/4d9fN7ZNUIqTjEN8Rwg4BPc3YXCR
         KNCb2EPmzU/LUr8ccpd7G3ITaAnEWL345iJF0TGItN+/LZKqSIPiUDmVwc3VOP/uDFNe
         abBg==
X-Gm-Message-State: AOJu0YwfJTlmJhvJiVab8C9siO8t1aIKCdHEiMFmg6lMgWBo4jOYHLLd
	1vaR9fLIG0dWYrkoHPetnhs=
X-Google-Smtp-Source: AGHT+IGrOlEwztGc8YwGh/xsY7XhVuwMbUUAB7N7n7oAVyk3abJInlZhz6IjEe0MeDoGwqsAEOA3Tg==
X-Received: by 2002:a2e:a589:0:b0:2cb:2c72:ef70 with SMTP id m9-20020a2ea589000000b002cb2c72ef70mr2669871ljp.18.1702389538442;
        Tue, 12 Dec 2023 05:58:58 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id g20-20020a2e3914000000b002c9fe11efe4sm1498292lja.28.2023.12.12.05.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 05:58:58 -0800 (PST)
Subject: Re: [PATCH net-next 7/7] sfc: add debugfs node for filter table
 contents
To: Simon Horman <horms@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
 <20231211191734.GQ5817@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <38eabc7c-e84b-77af-1ec4-f487154eb408@gmail.com>
Date: Tue, 12 Dec 2023 13:58:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231211191734.GQ5817@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 11/12/2023 19:17, Simon Horman wrote:
> On Mon, Dec 11, 2023 at 05:18:32PM +0000, edward.cree@amd.com wrote:
>> @@ -63,6 +67,45 @@ void efx_fini_debugfs_nic(struct efx_nic *efx);
>>  int efx_init_debugfs(void);
>>  void efx_fini_debugfs(void);
>>  
>> +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec);
>> +
>> +/* Generate operations for a debugfs node with a custom reader function.
>> + * The reader should have signature int (*)(struct seq_file *s, void *data)
>> + * where data is the pointer passed to EFX_DEBUGFS_CREATE_RAW.
>> + */
>> +#define EFX_DEBUGFS_RAW_PARAMETER(_reader)				       \
>> +									       \
>> +static int efx_debugfs_##_reader##_read(struct seq_file *s, void *d)	       \
>> +{									       \
>> +	return _reader(s, s->private);					       \
>> +}									       \
>> +									       \
>> +static int efx_debugfs_##_reader##_open(struct inode *inode, struct file *f)   \
>> +{									       \
>> +	return single_open(f, efx_debugfs_##_reader##_read, inode->i_private); \
>> +}									       \
> 
> Hi Edward,
> 
> I think that probably the above should be static inline.

Yep, in fact there are instances of this from patch 2 onwards (most
 of those aren't even static).  Clearly I hadn't had enough sleep
 the day I wrote this :/
Will fix in v2, along with the build break on #6.
Thanks for reviewing.

-ed

