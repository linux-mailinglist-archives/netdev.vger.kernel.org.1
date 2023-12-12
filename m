Return-Path: <netdev+bounces-56466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F326380EFCE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF681C20AC0
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3875417;
	Tue, 12 Dec 2023 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjhn5m62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD23AA
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:14:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so8089551a12.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702394059; x=1702998859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh9vNN+Zaek+jjdqwQAuUAlKZ2h3cve/+RYuzMV3TOY=;
        b=Pjhn5m62pgzcYeFfk0Cvk/2jCl3ZIBKclX/HJfYH25qRX9QpTo0iBlqUBdu+bHzUcB
         7nVBw71hUynz/IHfQd+7QBS7R7JpEJIkpnv4/K+WxrSmlN4NsZv9Kat6DABXOZgU5mm9
         tk/LNYr7kQ0yM3n1kdXWGJ3/Xil1l5qubNRAkq2MtATz1UxSO4iy1G8C+wOITQ2cvIfy
         GVyFbvbDjmAcsUlvWMUggIosKdFLQriuk2ESResewuqLmN6HeV7rFHDo9jaFivg1ZxW9
         sHEKphh7bvIvsgMFxlfRwzBf+2tcpCGiy/JmscKfjOo5kK9jeIKkuvIB8VWcBDd++qiS
         uxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394059; x=1702998859;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh9vNN+Zaek+jjdqwQAuUAlKZ2h3cve/+RYuzMV3TOY=;
        b=dBCYpnVacO7eE7LkaRL0p/LSmZMtMknyX2naGAVctD54L93yQslIhU+6PCEG/58ci7
         2+eXGrRMI4K3NQWpXrHkYrXGPiTSIR6/7IRLFcADENgtg7BNwl2Lik2swGUhA5qu5qCy
         xAy4i5m6nqaPOKRvPx7GNehmRB6A+L5EWqiMViwRVKnnDRFVkKCFLw/L8VwIJzJXXjuR
         mqbYBgt7tf8sq0iBj66EWHIqCGOyU3x0UeGyGCUkGAwcESJaqbgqtre7miXXOKShnauO
         6I68eYD1d/V1SZg24iJ3EtX0xlGrJsGHyn2YT+TFkYHSKKYtt3jJ0/EGeS3DGVPK2IY5
         eGtA==
X-Gm-Message-State: AOJu0YztLJRz0Q2r2Ou6OnPjBPrlf7r2cWAxnjNtBW3Xc8iwZ1ZgNOgu
	vGlW72mdy2uboQFsQF3M7Wg=
X-Google-Smtp-Source: AGHT+IGpJ6SAhKqvvg0hgj5XzMKbCbT5M122e57gmO6pYKDEK2/YEg//Z2mmP1afD4lYL5P1CfTuOg==
X-Received: by 2002:a50:d0d4:0:b0:551:cb7e:1433 with SMTP id g20-20020a50d0d4000000b00551cb7e1433mr263074edf.62.1702394059179;
        Tue, 12 Dec 2023 07:14:19 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id o29-20020a509b1d000000b0054ca1d90410sm5061494edi.85.2023.12.12.07.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:14:18 -0800 (PST)
Subject: Re: [PATCH net-next 7/7] sfc: add debugfs node for filter table
 contents
From: Edward Cree <ecree.xilinx@gmail.com>
To: Simon Horman <horms@kernel.org>, edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
 <20231211191734.GQ5817@kernel.org>
 <38eabc7c-e84b-77af-1ec4-f487154eb408@gmail.com>
Message-ID: <b9456284-432d-2254-0af2-1dedeca0183d@gmail.com>
Date: Tue, 12 Dec 2023 15:14:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <38eabc7c-e84b-77af-1ec4-f487154eb408@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 12/12/2023 13:58, Edward Cree wrote:
> On 11/12/2023 19:17, Simon Horman wrote:
>> On Mon, Dec 11, 2023 at 05:18:32PM +0000, edward.cree@amd.com wrote:
>>> @@ -63,6 +67,45 @@ void efx_fini_debugfs_nic(struct efx_nic *efx);
>>>  int efx_init_debugfs(void);
>>>  void efx_fini_debugfs(void);
>>>  
>>> +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec);
>>> +
>>> +/* Generate operations for a debugfs node with a custom reader function.
>>> + * The reader should have signature int (*)(struct seq_file *s, void *data)
>>> + * where data is the pointer passed to EFX_DEBUGFS_CREATE_RAW.
>>> + */
>>> +#define EFX_DEBUGFS_RAW_PARAMETER(_reader)				       \
>>> +									       \
>>> +static int efx_debugfs_##_reader##_read(struct seq_file *s, void *d)	       \
>>> +{									       \
>>> +	return _reader(s, s->private);					       \
>>> +}									       \
>>> +									       \
>>> +static int efx_debugfs_##_reader##_open(struct inode *inode, struct file *f)   \
>>> +{									       \
>>> +	return single_open(f, efx_debugfs_##_reader##_read, inode->i_private); \
>>> +}									       \
>>
>> Hi Edward,
>>
>> I think that probably the above should be static inline.
> 
> Yep, in fact there are instances of this from patch 2 onwards (most
>  of those aren't even static).  Clearly I hadn't had enough sleep
>  the day I wrote this :/
Or maybe it's *today* I haven't had enough sleep...
Unlike the functions in patches 2-4, which are stubs for the
 CONFIG_DEBUG_FS=n build, these functions should *not* be "static
 inline", because they are intended to be referenced from ops
 structs or passed as callbacks.
The check on patchwork is actually a false positive here, because
 this is not a function that's defined in the header file.  It's
 part of the body of a *macro*, EFX_DEBUGFS_RAW_PARAMETER.
Functions are only defined when some C file expands the macro.

I will update the commit message to call out and explain this; I
 believe the code is actually fine.

-ed

