Return-Path: <netdev+bounces-104728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFE590E2CB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD2FB221EC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 05:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D985588B;
	Wed, 19 Jun 2024 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zC77shqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C8324B2A
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718775926; cv=none; b=AnUtcRieq0wzpUrB9uo4R1LoT5mGqClR8te4adkyorLG14bqUNVlC6OvCU5MjPWGOCXeN2kpXutS2ShKxZighnJeX2DFaoe7iuBLj6M5usiKSLcdKGCmGXqeyyJCmFpcvzl6bf2Wo6mio9bn0dJrYwNf3kbXoIHVVPs0cMaJixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718775926; c=relaxed/simple;
	bh=u+6aVQTae9UKhpweiNB0WziXXSptKc5cDjP27PTrwFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwWdOH77oqNjfjm7KHyT20LmzrLQg2nQNkjMqGcYTi0n6TwVvHifJMJbAOj1c17sFhAj3dYrEwBN5F9t706eHJ5v20JLfoKxZxNxMl3OqD3ylLG+YkLrsvMkCKpg8LC1q+IGx5svBW7GFExKlHwldrffunxRYnyEPQW9QvSxJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zC77shqu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec1620a956so59744341fa.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718775922; x=1719380722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBUpXYsRWJCnSelZydra6vNcCLcuzgf3v2FxOtylRHw=;
        b=zC77shquDqTZ5wIqHZowZf6fxCMNs90y5FO5iCmhBJEq14gCzzUEioHJhPBhm2jHqB
         MLqrcgOpcvan9W6bNiGdDHOY85PT3TiuDPry0/xEsgsqiCFh9MkB8gEV5FlYJIAlg+k1
         G6Y7BEnlxLF/6TegHNlrMDEBrQggU6kxno+6JLf41XdfyB1PFyX4iQTcohqh46omc2Sg
         QPIgcK9rmNQ94w0TkuvN3v5X9s3wuyK5alICUKIRfq6rycaI4ZZ78yC6IzMMjP7SA0IO
         Vf1gh4ahNxkUHIlRi3A2IV/10J2GlGrAgk/Akdj/AHHZyRccFBLsdeNtSOG3dZnThy7a
         DCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718775922; x=1719380722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBUpXYsRWJCnSelZydra6vNcCLcuzgf3v2FxOtylRHw=;
        b=UNaeOHnZGcPVCHttQyEeVp+rWb2asy7mNd2VybJ77gxrJGYctq0ADB6USVl9JK/UR+
         4KnPV7Q4Wthn6RwbqPc2MH6RQtRCW7Sr/l0n7ZW0rM7e5v1t7JkyDgLP8oSHh1v1+mey
         sj8udN6wRYNl4QJFltmah2HObII+gF1Ny44rJQUi8FyQsa+QVonZgArFqapU7WUilWvt
         fwJQCKlbPRux4oXzJeq3C9E7EJJKO/+UGn//7M9RVCI988MvJlHuaTbXkx1x1H2akfi+
         6OQwSH3CtsTXeYztML5HFXA9d2X9Jt/oxlgRLIIVoJdMfUZAvNtpUrFKVHt4PdsbGPw2
         ZbNQ==
X-Gm-Message-State: AOJu0YzYevdhte2U2HKkIyC9I/WwiAZEtG+VH6JC0rH8mOl5hmn5Lof9
	jSVCHrhZMaow7sZvLouVs8I5kE0LAG1P+OWV1gyGXIZnag5xYHxlPUhn2VqdT1FXOdW9aUAC2AN
	D
X-Google-Smtp-Source: AGHT+IHULcp5ds4O7fOVdQUeEh65o5RmCsUsHbk0hYjdBf9jpDqDyLmJP2czRpLMC8R+5wtj0LiM+g==
X-Received: by 2002:a05:6512:12cc:b0:52b:79d6:5c28 with SMTP id 2adb3069b0e04-52ccaa926f4mr1024149e87.52.1718775922073;
        Tue, 18 Jun 2024 22:45:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3615d7a1a0csm3582216f8f.23.2024.06.18.22.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:45:21 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:45:16 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnJwbKmy923yye0t@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618140326-mutt-send-email-mst@kernel.org>

Tue, Jun 18, 2024 at 08:18:12PM CEST, mst@redhat.com wrote:
>This looks like a sensible way to do this.
>Yet something to improve:
>
>
>On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 

[...]


>> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
>>  {
>>  	unsigned int len;
>>  	void *ptr;
>>  
>>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> -		++stats->packets;
>> -
>>  		if (!is_xdp_frame(ptr)) {
>> -			struct sk_buff *skb = ptr;
>> +			struct sk_buff *skb = ptr_to_skb(ptr);
>>  
>>  			pr_debug("Sent skb %p\n", skb);
>>  
>> -			stats->bytes += skb->len;
>> +			if (is_orphan_skb(ptr)) {
>> +				stats->packets++;
>> +				stats->bytes += skb->len;
>> +			} else {
>> +				stats->napi_packets++;
>> +				stats->napi_bytes += skb->len;
>> +			}
>>  			napi_consume_skb(skb, in_napi);
>>  		} else {
>>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>>  
>> +			stats->packets++;
>>  			stats->bytes += xdp_get_frame_len(frame);
>>  			xdp_return_frame(frame);
>>  		}
>>  	}
>> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);
>
>Are you sure it's right? You are completing larger and larger
>number of bytes and packets each time.

Not sure I get you. __free_old_xmit() is always called with stats
zeroed. So this is just sum-up of one queue completion run.
I don't see how this could become "larger and larger number" as you
describe.


>
>For example as won't this eventually trigger this inside dql_completed:
>
>        BUG_ON(count > num_queued - dql->num_completed);

Nope, I don't see how we can hit it. Do not complete anything else
in addition to what was started in xmit(). Am I missing something?


>
>?
>
>
>If I am right the perf testing has to be redone with this fixed ...
>
>
>>  }
>>  

[...]

