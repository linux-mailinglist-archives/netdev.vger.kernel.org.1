Return-Path: <netdev+bounces-12665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987FC73862D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DAF21C20EEC
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D4318AED;
	Wed, 21 Jun 2023 14:06:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B05C97
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 14:06:09 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA91FF0;
	Wed, 21 Jun 2023 07:05:46 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso14546345e9.0;
        Wed, 21 Jun 2023 07:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687356345; x=1689948345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjWf42UQYA0pstvW1dY+TJV0OEUfplMXQFAUiulmBpE=;
        b=fflWFxzSZ3mpNCxCW4OUleSon2OfFBVzBOukFGnfsiqvnZRPnzBv+YFYggxT1ciydY
         rNpiLs+c2OQO+ZVga5KNFnIWsaGWgqHkibDl88cc4CG6xfH1NY5+r2HsXP37ZlptEW8y
         UdnqnZlvxcwIR/twobbhdcZbshnLiYow/nQNfzExJCQ8y+M+aHDBNfbx/18hcD+JoxjS
         PtbfU285HqD9ZR7TbVlBXUbkln2unusQcBwwpv4mY2waqOg+vTRcVC9k+iOAuJbEYP+7
         9edpxx2AKtsLs6QWdThnN2OhmptBcLFk9qYqJGwEGa8GaVSQopxY0B2pKC2RcLB4TmO6
         VaCg==
X-Gm-Message-State: AC+VfDzGbL1bHW8rzjm5ghbGmH0XmA2Jp2SDr9R0TMcH2YSMRVb7YE0a
	iFlMecnEgYLalU/FBroMPf0=
X-Google-Smtp-Source: ACHHUZ5J/At+CMQhWo/1+EsLpTfsPUzSaVSoS/7W21QNNoZrlL3BW+yga2Pv1xjVTP20UsMLpE8hHQ==
X-Received: by 2002:a05:600c:3ba8:b0:3f9:b445:9037 with SMTP id n40-20020a05600c3ba800b003f9b4459037mr5958214wms.2.1687356344797;
        Wed, 21 Jun 2023 07:05:44 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x23-20020a1c7c17000000b003f72468833esm5114935wmc.26.2023.06.21.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 07:05:44 -0700 (PDT)
Message-ID: <361c3135-51c4-ae81-e4e2-30c54db4eb39@grimberg.me>
Date: Wed, 21 Jun 2023 17:05:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <87f547b0-7826-b232-cd01-c879b6829951@grimberg.me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <1733833.1687350915@warthog.procyon.org.uk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1733833.1687350915@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> What tree will this be going from btw?
> 
> It's aimed at net-next, as mentioned in the subject line.

ok, thanks.

