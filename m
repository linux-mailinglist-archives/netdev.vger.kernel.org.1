Return-Path: <netdev+bounces-19007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9BC7594AF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 13:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165BD280CF9
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 11:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F231614262;
	Wed, 19 Jul 2023 11:55:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C414261
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:55:36 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8270DCD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:55:35 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3159adb7cb5so1636767f8f.0
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 04:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767734; x=1692359734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=O++uRTcu0oZ6mF7V56ZgeWFA0m6CaCnRjf6MyaX4C/kyCE1FDBgJ4gcSUSLMgn/YwF
         fdhMEc+tS0l/8c6dnBLWyFOV7usLyXyzlA+L6+OCSEKmBCbtATkWwdHPL2tq0jzAxxDQ
         H7FKJWNCbp2qS1ntjDWN8puLnizTFozbZrX9Ty7iIZVF0QlLzLM6Cj5artrSyqWSnhwU
         WwfAEwE3xAGXLpACVOg8FxYnfSfJcp/wqo/S0vo8NLl2Rupa2yOEehlD4tTMCgerbFJF
         FA+AAtR/jXmFLqv5KApeM8ZgH0BIso7FfAAMu6kCgoKg3KJ4fiMlnRW+syGm/0NQWeJl
         2zZg==
X-Gm-Message-State: ABy/qLYn0OXLju6seiIXBTGG55oVgO3cyNLJNkFziLeZowTo9KE7EzQX
	4nSBxc6eI9KrcMgstptLUIxCdhhqIls=
X-Google-Smtp-Source: APBJJlH7gcILuvDgVDV9JO5o/DGB1QwafkQlP7u0x7eqMAt+VWPp/xc+Wz1AyeQEVRS8PmenMpT8aw==
X-Received: by 2002:adf:e307:0:b0:2c7:1c72:699f with SMTP id b7-20020adfe307000000b002c71c72699fmr1845368wrj.4.1689767733874;
        Wed, 19 Jul 2023 04:55:33 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id y16-20020adffa50000000b003144b95e1ecsm5135684wrr.93.2023.07.19.04.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:55:33 -0700 (PDT)
Message-ID: <f2b4d732-6168-4582-5aab-f3b335df31a2@grimberg.me>
Date: Wed, 19 Jul 2023 14:55:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] net/tls: split tls_rx_reader_lock
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230719113836.68859-6-hare@suse.de>
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

