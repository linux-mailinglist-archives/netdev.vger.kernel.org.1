Return-Path: <netdev+bounces-56866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32B8110D1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 13:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5FE2818A1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED428E08;
	Wed, 13 Dec 2023 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEovZsJy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ACA9A
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:08 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bfd8d5c77so7853651e87.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702469706; x=1703074506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGmpHYTW9S3vl3puS381PDZTb3jivoBGyatqfVxW4Mc=;
        b=fEovZsJy4QZm4kW7AQae9oQf2OaonAgfalJAcPJLlK4qdVpARWMnDtDwnQWkMDTxpn
         8cewKjFWzSeA0stYR1vgiNshStcpW82yPeaU6c4H0GlKywUD1Wv3Yuwilr+hryounf8a
         cYAhneyWQiNLh4MCZ1IYJfG6ZswU3K5lq1uDgw3UIGwLoKtoG98rUW4ucXrtRZ5RC8m4
         pvmHYk6LdvjZd9KviZmbp0WaNRQ3prWVrA1nds9egv2PYdnyYXbLhVzUlJHumSkvujE1
         3G3wAdd4P4MxNF/lF1R4t5yrYOk9rkejbPbH8HiMxKr1HoQ8ylF9dB9Qc1A0llnvlkOv
         s76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469706; x=1703074506;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xGmpHYTW9S3vl3puS381PDZTb3jivoBGyatqfVxW4Mc=;
        b=BuyD5pRNF68lZlwoJ8HdwOCxhG6QkAj5skCoibjNlqHS64IODq2/X3w5o7Q/yXfQgH
         Vog05I0QpFeZ7q5XjSbZNOXDu7iiy7bXdrJBEZD8pf55ezbUE3+YRKw8qTww+THN6UY7
         KZkoZP4h4+MDudb8oX7vIrdaHtmy6+wIFbnE1WGu1hdL/p7i19tVCqLlpXun4yA3PZWO
         YPrNpJn+vYu0MgqjeVh5tK8pyPC69TepvJHg7rBeegooWBQfVk6/F7vre6lDgwfs0gNk
         TEP3qDbNX5Z91lziPjabA5gQ948uN+eS4msaMxHkXgi7rB7nZzX+zeF9QK0isoV4iyNn
         33DA==
X-Gm-Message-State: AOJu0Yxd8HcxUnHt7JBqP6i5vAID9LF8Cj6QIyQHdNWsDAnrRivrqdMT
	zhSLlFX3fReTS6I3vliTEHA=
X-Google-Smtp-Source: AGHT+IG3GE07twPttHXOMYZDALIJK351fh/PQyty/OmV/BSuldWib4FBG6OiMoPn9G+Y7Dq8qiabWQ==
X-Received: by 2002:ac2:592b:0:b0:50b:f90a:717c with SMTP id v11-20020ac2592b000000b0050bf90a717cmr1567380lfi.83.1702469706176;
        Wed, 13 Dec 2023 04:15:06 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2592d000000b0050c001ce064sm1591215lfi.80.2023.12.13.04.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 04:15:05 -0800 (PST)
Subject: Re: [PATCH net-next 7/7] sfc: add debugfs node for filter table
 contents
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, edward.cree@amd.com,
 linux-net-drivers@amd.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, habetsm.xilinx@gmail.com,
 Jonathan Cooper <jonathan.s.cooper@amd.com>
References: <cover.1702314694.git.ecree.xilinx@gmail.com>
 <0cf27cb7a42cc81c8d360b5812690e636a100244.1702314695.git.ecree.xilinx@gmail.com>
 <20231211191734.GQ5817@kernel.org>
 <38eabc7c-e84b-77af-1ec4-f487154eb408@gmail.com>
 <b9456284-432d-2254-0af2-1dedeca0183d@gmail.com>
 <20231212081944.2480f57b@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6258c258-b1c2-0856-aff7-cca33be15bf6@gmail.com>
Date: Wed, 13 Dec 2023 12:15:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231212081944.2480f57b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 12/12/2023 16:19, Jakub Kicinski wrote:
> On Tue, 12 Dec 2023 15:14:17 +0000 Edward Cree wrote:
>> I will update the commit message to call out and explain this; I
>>  believe the code is actually fine.
> 
> Fair point, second time in a ~month we see this sort of false positive.
> I'll throw [^\\]$ at the end of the regex to try to avoid matching stuff
> that's most likely a macro.

Sounds good, thanks.

> This one looks legit tho:
> 
> +void efx_debugfs_print_filter(char *s, size_t l, struct efx_filter_spec *spec) {}

Yep, that one's real, will be fixed in v2.
And this time I'll actually build-test with CONFIG_DEBUG_FS=n,
 which I forgot to do with v1 (sorry).

-ed

