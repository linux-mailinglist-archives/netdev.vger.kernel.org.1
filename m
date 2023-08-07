Return-Path: <netdev+bounces-24819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2997771CA5
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837E51C209B7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19C5C2D6;
	Mon,  7 Aug 2023 08:54:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5C138E
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:54:57 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4789B10FD
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:54:55 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9b458b441so7790521fa.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 01:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398493; x=1692003293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6/N/2BWCZVt4vpliwKkLCg3WqtEz74CuKiBhIx40us=;
        b=Ytb+4vBrcAqT6E0uWe+xNL32/O61SG6ejZbInH4IOxxco2kjpFPUPfl/d1ijRlx+1T
         BDgUULjt24hLe9bcVRAjY8qsK59BCH8zk6MOuaanLIJ99ZB+YRCJkEpTHKOZvW3KXAF7
         PZMT3k2yOMfgJzqVPZ4nmrskngY6FWiMEopumYiRdRt1/XEoTkV9uC5tOF3ei3zXpJTf
         uxc+NzGD5gtGb3f9wJ7KTSBO1Rl4gAoV8WCZO3T2oKU+VWmcyTb/Rug4TJH0kOIky4D/
         ei2fvfbZh3fLtV0xDEFtNHFTH2qKUrpY4LZYEFRn7nnUUlzNrefpqfy6Oeyq4ftac77J
         vhKA==
X-Gm-Message-State: ABy/qLYD5j8zmIRHm+/6FjssmzbNzKMwHaDEYZwy/+4KtEQv6BS3xRpu
	s6a1v0vxr2sH7kIQAuUrn+g=
X-Google-Smtp-Source: APBJJlEGcMVKwl0W7c8WvYG+q4frq5Hi4j3WsVsQ1We3MBIWusK1fRwqVOTAjh4sAE67WwjClGV2Hg==
X-Received: by 2002:a2e:bc84:0:b0:2b9:54bd:caed with SMTP id h4-20020a2ebc84000000b002b954bdcaedmr16416061ljf.1.1691398493118;
        Mon, 07 Aug 2023 01:54:53 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b00985ed2f1584sm4859899ejd.187.2023.08.07.01.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:54:52 -0700 (PDT)
Message-ID: <40f2231a-df19-fd4d-f6f1-105aab5e5d84@grimberg.me>
Date: Mon, 7 Aug 2023 11:54:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230807071022.10091-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230807071022.10091-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> When flushing the backlog after decoding a record we don't really
> know how much data the caller want us to evaluate, so use INT_MAX
> and 0 as arguments to tls_read_flush_backlog() to ensure we flush
> at 128k of data. Otherwise we might be reading too much data and
> trigger a TCP window full.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

This looks fine to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

