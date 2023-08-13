Return-Path: <netdev+bounces-27121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD38E77A69F
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000AB280F06
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 13:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D9D6FA3;
	Sun, 13 Aug 2023 13:52:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32EC5235
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 13:52:17 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B5B1713
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 06:52:16 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5230f92b303so1053746a12.0
        for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 06:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691934735; x=1692539535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/IOYqnYoR5gtf5lH6c6YptleVOmBT9CB02y3etRVezY=;
        b=Oi0DREFpZsbvkVn/NXqo/l/5toEUh7dKwF4+ELGLFs7NMLc3cyTcdAhLJyAZ5IBTJ7
         0lI0kugO4RKmRV4O+kEwa8Of2Bijf7x8zpEG+CfiimLuz/3ApCrST5b6NWF7BrhZ374B
         5TaYc2wYIeUczUS6RoFx+sJrnjQU7TH1P1XmV/W43pvH6EUSLwcARMbiUppCfWPt8V5C
         /NHp8vpjfwaz3dATZDGLo4W6BUBXodowf7AMpWJC+QLduweWWhGndh4mtw53sgbC941+
         TZk0/j7Wh64PdNVYAdNWcvlk1pFdjq8PWNxyr4qEw9tan3nvRWk0uDSgFiHGKkpV+fib
         a7vg==
X-Gm-Message-State: AOJu0Ywf+F9LL8l090T1RrhjH0vgsRknumEh07iAmYIzgkHQbZEDhT6f
	l1QKV7KLx4k4dIGPqHN8vkk=
X-Google-Smtp-Source: AGHT+IFKY3gmiZuUmM+fopOwnlK2jWbDppldax6PCcLwGf0E3PvMf8gzB4oPxT8TAx4Z5SstJ5+a/w==
X-Received: by 2002:a17:906:7394:b0:99b:d682:f306 with SMTP id f20-20020a170906739400b0099bd682f306mr5017687ejl.4.1691934734514;
        Sun, 13 Aug 2023 06:52:14 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906858200b00997e00e78e6sm4593122ejx.112.2023.08.13.06.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 06:52:13 -0700 (PDT)
Message-ID: <6746b78c-3593-468c-5401-8b1de79f0a8e@grimberg.me>
Date: Sun, 13 Aug 2023 16:52:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/17] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230811121755.24715-1-hare@suse.de>
 <20230811121755.24715-9-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811121755.24715-9-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I *think* this looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

