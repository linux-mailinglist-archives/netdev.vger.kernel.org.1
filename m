Return-Path: <netdev+bounces-15089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BA7459A7
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F386A280C96
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C2441F;
	Mon,  3 Jul 2023 10:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6804419
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 10:07:08 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7279E73
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 03:07:02 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso11011045e9.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 03:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688378821; x=1690970821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhORNoU3ciKX2xP8peaOJGSJDkiRCI9EgxfOrsQf3GA=;
        b=C/HCTFwDlnNM2h9AzZQbUWaPTnY0M3YCOXaz3zmX7cCmSuNU4cjPCnt7zuOx9xmggo
         PQ6Yo9H+0h55tdmhWzvMcxFi/ghPikDzU994bDVyHjx02BryP6ijkK7q7QJRxvNCoslC
         8uwA4i1y+RnViiiXCrfZOzn9b6CGlEDRQTePPWjZ4yXrc/9ZZCTwz/rzmPux58hDqiKN
         pyEKtI+mJ1V1PPK3Cj/IwCmoeIp+a1EQHw+OdZoRfFzn3VrBtM5h5qcT2F5AR+8BKGTe
         WZ17GFOg0VL+TJTb+w7LEyxZI/ezj3SID4BsQpotm0R/+8r5SE76JNJT7zceo70yGiJV
         G3kA==
X-Gm-Message-State: ABy/qLb5lsbfch1tjiyXwVlCb+mz8uVh+bt+YaS2YSJ4JIuGu+q/Yddq
	5GBtVCSjBytXrlbygNmJWl0=
X-Google-Smtp-Source: APBJJlHZsBsOfb54U+00VvImXcEPKqtex2r/HSSKxS0kYmdww2Zo1jSovvBgwP2qMZFtPyfWBNq4TQ==
X-Received: by 2002:adf:eece:0:b0:313:edb0:e8a8 with SMTP id a14-20020adfeece000000b00313edb0e8a8mr8349414wrp.2.1688378820796;
        Mon, 03 Jul 2023 03:07:00 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w11-20020adfec4b000000b0031437ec7ec1sm1914654wrn.2.2023.07.03.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:07:00 -0700 (PDT)
Message-ID: <1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
Date: Mon, 3 Jul 2023 13:06:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] net/tls: split tls_rx_reader_lock
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <20230703090444.38734-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230703090444.38734-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/3/23 12:04, Hannes Reinecke wrote:
> Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
> the actual locking part.
> With that we can use the tls_rx_reader_lock in situations where
> the socket is already locked.
> 
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   net/tls/tls_sw.c | 38 ++++++++++++++++++++++----------------
>   1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 9aef45e870a5..d0636ea13009 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1848,13 +1848,10 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
>   	return sk_flush_backlog(sk);
>   }
>   
> -static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
> -			      bool nonblock)
> +static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
> +				 bool nonblock)

Nit: I still think tls_rx_reader_enter/tls_rx_reader_exit are more
appropriate names.

