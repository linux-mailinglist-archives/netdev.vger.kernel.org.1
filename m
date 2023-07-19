Return-Path: <netdev+bounces-19005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1217594AD
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E0D28172D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF2913AF9;
	Wed, 19 Jul 2023 11:54:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAB14261
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:54:42 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F5D3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:54:41 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso11887575e9.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767679; x=1690372479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=g5UM/B+22hN+jFGr93Zsqnle+Rytem77AjqqYKaA04xcLKWYtyrlZxZ6G1svKr/PGP
         NG1tcsa+gydfeV2FGIAilb92hMI2L+bX2sCdTSKegFyESc1zvzOdsccuRlhbGoKUKZkj
         rC4feBx4kFuCWZ53o9ktqqrd6rqRYgKzuAZ208XL+SZkaVPUbY9jT17sBwdWudocvssy
         gb9bzAITrnWBtxfiXX8zpJsqdPvw+SDSx7zKY9XYwC9zaIk5aTTRA00K3A2YfUIYlCzP
         K+4fXJNnVs0n9mEW9aWiYPumEkVjefJ5rbz0GBYboy9NfE/gl26xm84UCkSGIpYA8uy+
         37Xw==
X-Gm-Message-State: ABy/qLY5NkgHR0gXNKMBSeonJrfB0SEYeQdpzlDObZSoXB0W93BQv1+P
	1HOvzqH1f1g4ScmqdjXFLS8=
X-Google-Smtp-Source: APBJJlFx8Nd2zlU9HdityaHbsCvPzRJ8CDYkz7ZT0B5SWlmZjncwynDWN9bPd9GX29OqJ7s1zk4sKw==
X-Received: by 2002:a05:600c:860f:b0:3fb:3dd9:89c with SMTP id ha15-20020a05600c860f00b003fb3dd9089cmr2154320wmb.0.1689767679449;
        Wed, 19 Jul 2023 04:54:39 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fbc30825fbsm1498095wmk.39.2023.07.19.04.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:54:38 -0700 (PDT)
Message-ID: <9bbb2635-c4fd-884e-4cf4-0a01c3e29415@grimberg.me>
Date: Wed, 19 Jul 2023 14:54:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] net/tls: Use tcp_read_sock() instead of
 ops->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230719113836.68859-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

