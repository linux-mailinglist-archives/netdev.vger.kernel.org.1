Return-Path: <netdev+bounces-27446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6D77C051
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACD81C2039F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBECA64;
	Mon, 14 Aug 2023 19:05:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33049CA4B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:05:39 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F41703
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:05:35 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1472643a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039934; x=1692644734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDF226U8s20wd6YP8ikmSWH6z2gzB09wST2WRKhovQI=;
        b=Xq6aeQsI/++pZGYhFW5g/Oekagwq8ic+IfaQQwhma0/Z9JmnWagZamrWqhdpXpHnsP
         GP39cebY5LDZCv046Odm+fmbIl7kR+tlQq6FP71+To+v9ejAwk/jmT5inMe2Vis0prET
         H6ea6FZAz7TPKu233zLymo0THZiswqh5K5lMD2RCV8HH/jdBiabsAmqtxn5M1r2qiW1A
         /+iT7YUloayrMn4fw6PSACoo+QMynNSB6RkIcgstrjPaLFIXXHBNLZm6QQ1ou7hpAe4p
         2+VQMFw683YY9WsJHFTYI79+MjDDSs09rDOe0l8x1/h/rgMD/m+AuRPB/1x5pXA0B0c2
         bhgQ==
X-Gm-Message-State: AOJu0Yzo1EBhkJ7CckZHNIe30v9QKikGtdNkTPb5iOB2KGwAh8SGpnGr
	n4lgXjuWPQdSR+WGE13Mfwk=
X-Google-Smtp-Source: AGHT+IFshae9uLDqcs3fwT3y7Y9Y0Q99ktIq4atrQ1uA+SbbrnZrfL2r3M0L0wS54JnFHSmVpifWrA==
X-Received: by 2002:a17:906:1041:b0:99c:5711:da5 with SMTP id j1-20020a170906104100b0099c57110da5mr7729118ejj.5.1692039933918;
        Mon, 14 Aug 2023 12:05:33 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id a17-20020a170906671100b0099bd8c1f67esm5955053ejp.109.2023.08.14.12.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:05:33 -0700 (PDT)
Message-ID: <b9ec8b98-dcde-1d89-9431-4799240f0c80@grimberg.me>
Date: Mon, 14 Aug 2023 22:05:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/17] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-18-hare@suse.de>
 <304bc2f7-5f77-6e08-bcdb-f382233f611b@grimberg.me>
 <f9ebbd9d-31be-8e2c-f8a2-1f5b95a83344@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f9ebbd9d-31be-8e2c-f8a2-1f5b95a83344@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/23 16:18, Hannes Reinecke wrote:
> On 8/14/23 14:11, Sagi Grimberg wrote:
>>
>>> Incoming connection might be either 'normal' NVMe-TCP connections
>>> starting with icreq or TLS handshakes. To ensure that 'normal'
>>> connections can still be handled we need to peek the first packet
>>> and only start TLS handshake if it's not an icreq.
>>
>> That depends if we want to do that.
>> Why should we let so called normal connections if tls1.3 is
>> enabled?
> 
> Because of the TREQ setting.
> TREQ can be 'not specified, 'required', or 'not required'.
> Consequently when TSAS is set to 'tls1.3', and TREQ to 'not required' 
> the initiator can choose whether he wants to do TLS.
> 
> And we don't need this weird 'select TREQ required' when TLS is active;
> never particularly liked that one.

The guideline should be that treq 'not required' should be the explicit
setting in tls and not the other way around. We should be strict by
default and permissive only if the user explicitly chose it, and log
a warning in the log.

