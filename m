Return-Path: <netdev+bounces-153316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E129F7974
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3341895E87
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF415221D8C;
	Thu, 19 Dec 2024 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa+z7KFE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF254727
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603683; cv=none; b=lvBdAny4hl1wVtoR9cCNApad3iUXPkKsuN1KtX2AOIhYwxLxCLQeUtaM+DrnqEaqKY7OAzJAArkpUDgZlH0kVUqvBRyOdwmxG2lWoSayJdOP1BL6xm0npn+YRryNUJhVuVK8tMqS/emZVNkmsDcu/FGeGHxvp+HKT+aIAWXcFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603683; c=relaxed/simple;
	bh=+bH3K7pBMWHA9CAhc0JMMa4S0aWKCBgpoi9I3vJHOyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hw7aJBndD9yve8zZBQlTzlMLxkEuC57xOKQc1VwuhejyX9jwOQz15XjgP2+KfsbD7PiK/ybpKQ7zxSUHli/zYRvPeRJzj++WF24zjIWk1EvH1PyZ1FuIotoBBARYWx5aC55KeuU2MGRrBW1CFHne3gnReeUagtXjR63CQZoucWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa+z7KFE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734603680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1rn7Q4xREFyKwST1TUIfeiNM6wzi4y08dTglc/WzBE=;
	b=Xa+z7KFE0YnTriRaskpDoLIsKpCIL16o7lMMMGsz5b6iLkWBh6Rr5ruxubZrsaDyxPtSGE
	3a7VyArifwl/+sYSamty27Hi03Ct0Fb1G2CFSomhQjPMbX1c3MdyXocETMB0x5c+fsTScC
	k43E7pTjFDhcrhpYHf+kt8cjy61wGEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-hsEY49a3M1qIfqCOMqMrlQ-1; Thu, 19 Dec 2024 05:21:15 -0500
X-MC-Unique: hsEY49a3M1qIfqCOMqMrlQ-1
X-Mimecast-MFC-AGG-ID: hsEY49a3M1qIfqCOMqMrlQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so5091935e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 02:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734603673; x=1735208473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l1rn7Q4xREFyKwST1TUIfeiNM6wzi4y08dTglc/WzBE=;
        b=mE+NZFK7KjFmqAV4gKj/BojjWLXtkYlVuV7+1pA57H4Xc8B1ttpgspGrgJA5btDH02
         RcWf0nd/Z0iWeUeGycHZeMOKSXgoDDAgns6bXEtM77a66zJLCweAOs3ClGWgrM+/qf8n
         AtTgud2PrbEgKcjLlPZNVVwYlC3s4KccC5gFvBPnkPvoM4/nicdJac8TDjxy7r04bOG1
         419/r2XeLkib1dfMRknhvysgUMUou+YUOaaHiiWi78Rq40OvHJz4Ar6ydixDBCfVv6Wa
         SdhGvGAPHdDFOHY4quw6AIztQ1QIvkwfEjdf3yM2n/nxTxOVQuvxuBtPqvXrUEau1s3c
         dK2w==
X-Gm-Message-State: AOJu0YwI+n0kP9gaxHifVqgS6r8ytJcSUS3Va9n+uMdaVkVMdv+hdPcJ
	p9/V9+abrrpW/zeSRHDiOdExhMEcwGUUDBSD+T6KUoc4f0CQ4FwK3L8sBlhvVW7w2Pib7xHuZxN
	jxic+QX8C1K+bsU8+wewUFMKBbzIZRcHqDtp/pjMHtyvmitKNJvfNxQ==
X-Gm-Gg: ASbGnctTaqLKuddmI61HpJwu71f/RGYrmQRNjIPZKZgysFL+itpNraJ9k2lerudGy+N
	eUM3urxEVzTRJ1L3OOUy9XkwTR3PZaJkJp6THUqcmw/PoYtLqoHlS9vqYYrliE1doJT134sh08X
	EXKvwis0PXdcyN2FWFQHiTi9KocThux7s/hVDmhRmgGv+mDM1tItpzlv2IZiaAlZUUsCD5tooah
	wwi+nm3MTHm+o4QzP2RCZ4TtGtQhnXUjrT+KJKHoGwN2Ti5qAr9KgKZtkZqRfpORfLf7K2axPao
	dcfQwF5+nA==
X-Received: by 2002:a5d:47ab:0:b0:385:f2a5:ef6a with SMTP id ffacd0b85a97d-388e4d4b590mr5763933f8f.15.1734603672930;
        Thu, 19 Dec 2024 02:21:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3jsazlxDK2iO3mglVl9yY9u0NZR2F+lON2AMyuKym+rULOi/I7sbYklOcmDzhy07STjrGMA==
X-Received: by 2002:a5d:47ab:0:b0:385:f2a5:ef6a with SMTP id ffacd0b85a97d-388e4d4b590mr5763916f8f.15.1734603672614;
        Thu, 19 Dec 2024 02:21:12 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b015absm47867405e9.13.2024.12.19.02.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:21:12 -0800 (PST)
Message-ID: <13a68f91-b691-4024-8ae8-5f108b4e4587@redhat.com>
Date: Thu, 19 Dec 2024 11:21:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: mv643xx_eth: fix an OF node reference leak
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, sebastian.hesselbarth@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, dan.carpenter@linaro.org
References: <20241218012849.3214468-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241218012849.3214468-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 02:28, Joe Hattori wrote:
> Current implementation of mv643xx_eth_shared_of_add_port() calls
> of_parse_phandle(), but does not release the refcount on error. Call
> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
> 
> This bug was found by an experimental verification tool that I am
> developing.
> 
> Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in v3:
> - Insert a NULL check for port_platdev[n].
> Changes in v2:
> - Insert a NULL check before accessing the platform data.

I'm sorry for nit-picking, but many little things are adding-up and
should be noticed.

The subj prefix must include the correct revision number (v3 in this case).
You must avoid submitting new revisions within the 24h grace period, see:

https://elixir.bootlin.com/linux/v6.12.5/source/Documentation/process/maintainer-netdev.rst#L414

> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index a06048719e84..0e2ebfcaad1c 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2705,8 +2705,14 @@ static struct platform_device *port_platdev[3];
>  static void mv643xx_eth_shared_of_remove(void)
>  {
>  	int n;
> +	struct mv643xx_eth_platform_data *pd;

Please respect the reverse xmas tree above, see:

https://elixir.bootlin.com/linux/v6.12.5/source/Documentation/process/maintainer-netdev.rst#L360

Otherwise LGTM, thanks!

Paolo


