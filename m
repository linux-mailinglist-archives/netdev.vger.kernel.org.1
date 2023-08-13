Return-Path: <netdev+bounces-27125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F81F77A6AE
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCFE1C20832
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEA16FB4;
	Sun, 13 Aug 2023 14:02:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B572C9D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 14:02:12 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E69D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:02:11 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-317604e2bdfso871100f8f.0
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691935330; x=1692540130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBM3kLO+OmxSA5ObktuYd2lmMDcK+c/9PBGCKy5Y4PE=;
        b=SVcTide7RuId2YXqg96HUtXg0WTCBD2V2+yFwT0SVe4+tWSsBWr4OAxRCcecctGB/j
         r08HeMKT7i0fCN/rS2cYQJOTThM8JrS2B+vYPN4BoNQjE/KcAaJW0czlm3TJs4x+A0Jh
         N/orZY2LmYkECdhw6QxuR5R2x/0jD8ivpWMFit4azBabMx7DL/5GsR7AmPIjOr+JsUa4
         fBUgcn9M9FTeTEbkF7ByLrPV3mTIGYXAvpZXH969B7W2gf+RwTNilPIGBv0IEhOm6kBN
         UmoBWgAt/TdO9nZm/ZlkI0p1wwybFzuUFGLEYzcAw32Z4UqEWtt8UHisoO9ikwQeRVie
         v+Qg==
X-Gm-Message-State: AOJu0Yw5+Sd7tRuJ9M//FCLkfDqyE39KMWp6ByNaFoBbrUXt3MRwIgU3
	0WD0gqqk3cH+7b0K5S34dio=
X-Google-Smtp-Source: AGHT+IGIgOVI+FguTWh9hn/ikaP+DRPRd8rmGrcS6bqxy7tsftxpoHVO6ZFqMHU4hy0A+xOBEKC4BA==
X-Received: by 2002:a5d:5041:0:b0:319:7624:4c88 with SMTP id h1-20020a5d5041000000b0031976244c88mr633217wrt.0.1691935330051;
        Sun, 13 Aug 2023 07:02:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id g18-20020a1709067c5200b0099316c56db9sm4570136ejp.127.2023.08.13.07.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:02:09 -0700 (PDT)
Message-ID: <8bdecca4-4f05-1cd9-ef82-8384fe5b16c5@grimberg.me>
Date: Sun, 13 Aug 2023 17:02:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/17] nvmet: Set 'TREQ' to 'required' when TLS is enabled
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-16-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-16-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

