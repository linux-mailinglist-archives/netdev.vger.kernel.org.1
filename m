Return-Path: <netdev+bounces-24789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6D771B2C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1108B1C20966
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85B93D81;
	Mon,  7 Aug 2023 07:08:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA21210D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:08:57 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842010EC
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:08:54 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3159b524c56so973757f8f.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 00:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392133; x=1691996933;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWV3RfP0hrUSuT+rQTv0qiwOZILUNksPQ3sV763KM68=;
        b=QIe4mobvyZQvKMTz9xBD24cpRgncF9Cz80MB9RDSMCPvYRVSUmtjffFEkUC48R7bZ5
         5QuhDD1t7aDx7ymFhi8IAo8mRHkvJ/M1J8HqVv0c2SbvKDtnGRLrmVkTM/Ftq2JaVyVC
         YPeZvrIpATbsKz7uEHekS0cEfcdBU7VxOu9ZTdl/tkqxUa+5UNbU5ILwFu69p07mTbJI
         /dYY9d2DoKrbBD0+D7iP2LXUvaWnPRZTG1NdKLn8WCDIIAGuZVpe0APiwq/ekzJaEQwa
         KbMVV27mhp5U6EdSXXtxLufCprEenY9ba4BVpNtAi5FHjIxfmORq5yX0w6zv7O9Sx3Vj
         6dbQ==
X-Gm-Message-State: ABy/qLZzOcO/rzNOMLQ4sjsyqpDhLou9w9lfjgF/ptgb1tnS0JFQkqIl
	Z36yZUmmLXZwCnE6O0IV7vg=
X-Google-Smtp-Source: APBJJlGpZcydgX6SXxywKayHnJPbGM42xAyFmfoOBPthu8aX/ZBLl806eV2weN4x6XBZ03vt0JkBRg==
X-Received: by 2002:a5d:4443:0:b0:317:3d35:b809 with SMTP id x3-20020a5d4443000000b003173d35b809mr18190349wrr.2.1691392133058;
        Mon, 07 Aug 2023 00:08:53 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020adfff86000000b003175f00e555sm9555878wrr.97.2023.08.07.00.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:08:52 -0700 (PDT)
Message-ID: <5e04afe0-7bf3-1bdf-f4f1-49b0c7bb5dba@grimberg.me>
Date: Mon, 7 Aug 2023 10:08:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net/tls: avoid TCP window full during ->read_sock()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230803100809.29864-1-hare@suse.de>
 <20230804175700.1f88604b@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230804175700.1f88604b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> When flushing the backlog after decoding each record in ->read_sock()
>> we may end up with really long records, causing a TCP window full as
>> the TCP window would only be increased again after we process the
>> record. So we should rather process the record first to allow the
>> TCP window to be increased again before flushing the backlog.
> 
>> -			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
>> -							  decrypted, &flushed_at);
>>   			skb = darg.skb;
>> +			/* TLS 1.3 may have updated the length by more than overhead */
> 
>> +			rxm = strp_msg(skb);
>> +			tlm = tls_msg(skb);
>>   			decrypted += rxm->full_len;
>>   
>>   			tls_rx_rec_done(ctx);
>> @@ -2280,6 +2275,12 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
>>   			goto read_sock_requeue;
>>   		}
>>   		copied += used;
>> +		/*
>> +		 * flush backlog after processing the TLS record, otherwise we might
>> +		 * end up with really large records and triggering a TCP window full.
>> +		 */
>> +		released = tls_read_flush_backlog(sk, prot, decrypted - copied, decrypted,
>> +						  copied, &flushed_at);
> 
> I'm surprised moving the flushing out makes a difference.
> rx_list should generally hold at most 1 skb (16kB) unless something
> is PEEKing the data.
> 
> Looking at it closer I think the problem may be calling args to
> tls_read_flush_backlog(). Since we don't know how much data
> reader wants we can't sensibly evaluate the first condition,
> so how would it work if instead of this patch we did:
> 
> -			released = tls_read_flush_backlog(sk, prot, rxm->full_len, to_decrypt,
> +			released = tls_read_flush_backlog(sk, prot, INT_MAX, 0,
> 							  decrypted, &flushed_at);
> 
> That would give us a flush every 128k of data (or every record if
> inq is shorter than 16kB).

What happens if the window is smaller than 128K ? isn't that what
Hannes is trying to solve for?

Hannes, do you have some absolute numbers to how the window behaves?

