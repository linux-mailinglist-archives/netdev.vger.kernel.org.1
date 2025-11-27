Return-Path: <netdev+bounces-242234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F0FC8DD82
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 11:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED93034B277
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 10:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796A532ABCF;
	Thu, 27 Nov 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6ZkOMpx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDobi9ht"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56CC315D3E
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240789; cv=none; b=qkShhK1BVhXxU1H7fH9bntGlc/v0K9iR+94c9M4yQTnLIsAA2tq81ujggH5lF0+CR9t9ihV5/bTSIDAyEQAZ3O/wDT7zZ1wjQ3BlGhjRcg0SUyZBaHRFvvMmQZDBcbFVDGSmBr8YrRZ/iBSEmJ3cMTrYdf4UCKtfF7rk1hM8vRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240789; c=relaxed/simple;
	bh=dcwrY/ZJN91y8VKMVtZWMrFkXvzI5f8E1cX3IfcGFlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJ5wMJV2W2FwiSI5vkRS0qvTbK1+hh1FOHKC0KcUd3bsr7ZawWSG7/PE4S3kDG8M5d5gqmnWU67Cx0pjwknSALjo2l+7zYoENTnig8pn5dwObu/TbbKyc71gFiFrt3CXvvoGkOondBwgz/yyR1sn0lbQfe54cVlmu4YAhgoLQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6ZkOMpx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDobi9ht; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764240786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ia9KLe6KKWosICN6WhPtsQJNk42J7XjtbWZtakRXDh8=;
	b=h6ZkOMpxF2kZPd+LGmDZ8ItesLKjz2uEVujPawUkQMoxA6m5VBgXd8QKgyXy+nhFwX7ifK
	wLleQCyPEOxOr4PzSTG6W460ITa7R/M0xEikW5kok50u2W5Jm/d/9rYyVIZFs6AlK1LnGH
	KVTQHLjnBVDZLhKvlZSUlhMJP/cYlQI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-66z5w6qLO8-U3UEVq6QElw-1; Thu, 27 Nov 2025 05:53:04 -0500
X-MC-Unique: 66z5w6qLO8-U3UEVq6QElw-1
X-Mimecast-MFC-AGG-ID: 66z5w6qLO8-U3UEVq6QElw_1764240783
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6411fc67650so1014360a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 02:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764240783; x=1764845583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ia9KLe6KKWosICN6WhPtsQJNk42J7XjtbWZtakRXDh8=;
        b=VDobi9htot0b//4JIG6gpekF0SrRDd40rwQ6rhYTzmO5opmj3Lf6N9e8W0fgxjULJk
         tffeJwoTk9h6xjXRTF4Q2hnmDtH1uEX+KLLMR9izOe0sFdR5E+nzEnzcabh7csP7FdzX
         192xL+mtFq3XQki3Pek6cx2AqOaZJbAGTSzYAaUfKUMrLteWR9O+tVau1qDA2SJcQaW0
         rrLyHs+Wo7+FGSq7KqCIqUKYMuga95u/GvN0vJjanpOyEXyd/svf9ZHZADR/AIVc0rau
         h5frWRc8OVuzj9DvYIic7HrwAgwkvsm3ffuGmvkRLXjW/zdZ+teOQRhMt1GHqKZHg2zX
         akmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764240783; x=1764845583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ia9KLe6KKWosICN6WhPtsQJNk42J7XjtbWZtakRXDh8=;
        b=Y3wjboEUJqPl1Ho9Av5+LygGrbJbH7MXsaNx+12hOZZX30CFMxttFDJhws0qc3gd7o
         tND1MbD2WvDrUHfGzAZhV5MqrZM7PAwP8br7PZ2NJO0Wvv7Cgp+l0MZgLz01DQHfCdSQ
         +cLTnk6qph8GZLOJAkuQLZbOIiw9DfCJAG4mT/wbux7AUpnj8nfYvlssLUeOwcOvl/1i
         hZwSMDncyUR4QkPLC1/Hn8z9ayW7TUceS/qJhwKlNs/8ULikwzRN/0fncC/cDFnTW77d
         IEGyc2dc2fWEmv+vn/3KB9/bQFS4knQyIo2oC88T3/ShcfKIZQKRhxbq5Os4dzRQu7f9
         L17w==
X-Forwarded-Encrypted: i=1; AJvYcCXRVAY01EAwnpxUqtK4Ogw14Xg6J0xFr+FEObR1Vq4IHgPJKknKcVkVljb6yx2eQ3LFElb+FiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPkSv1PnpChKywWqY0UrR8qteuzsMcULhaVKNm8iQsKlM7fWC
	ZYD8noWvRa787F36xYltAsiVc5I/9HTRr4CfS/umJ1ptRN4RKkwgX/EytCqlzKweiwklPSVID7V
	Pwjv5vf+kbxuUsaifz3hAfryM7ooRcnLQHJSokS0Kk9ln8LNvaiCx4hp9VQ==
X-Gm-Gg: ASbGncvUa5KmHciiBP4NX02gZMAvVnC4+LBzFhp0osJsvhEOTr7k1FdsgfeHojVcMuJ
	gdcS2G9oC3QOXywdQbpP5ZZqhP8g5g3wt8/tLRX8XhF3W70qbWQJE/1rHhc/qkqpDTG3TcvojnO
	a42Nezl56602IuLEKWEfl7T5WZdQhUT75M7UBPdOUrd4mnLvp3y9RsD+GGLZu+1tBMevs1tQA05
	b6sMJwZCRgQ/zaD0zeAU+d7+OabvUwADDwyhVbFoxXYUMJ3cci/Z1zCzOmC6cTpgzBCmicMbGho
	QhhUDVQdEsebVWrE6nUwdvhwdkLR1xsAMDcVIK3SVYNhzEV8XN2h2SN58NHC451Bmj3LEpXeaBU
	I/bonZFhcGVgy8Q==
X-Received: by 2002:a05:6402:3054:20b0:645:c6b1:5f9d with SMTP id 4fb4d7f45d1cf-645c6b15fd9mr10852295a12.5.1764240783197;
        Thu, 27 Nov 2025 02:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeDyRIqcyD3zKEeif485rXKITX1uTQeYkqs0WbdFhc4RqC7yJG2evwVTiptKplRdNES0CvPg==
X-Received: by 2002:a05:6402:3054:20b0:645:c6b1:5f9d with SMTP id 4fb4d7f45d1cf-645c6b15fd9mr10852281a12.5.1764240782769;
        Thu, 27 Nov 2025 02:53:02 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647509896d1sm1316264a12.0.2025.11.27.02.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 02:53:02 -0800 (PST)
Message-ID: <383aed26-aa07-4759-92b9-5448161ba6a4@redhat.com>
Date: Thu, 27 Nov 2025 11:53:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: Introduce
 netif_xmit_time_out_duration() helper
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Jian Shen <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jijie Shao <shaojijie@huawei.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Yael Chemla <ychemla@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
References: <1764054776-1308696-1-git-send-email-tariqt@nvidia.com>
 <1764054776-1308696-2-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1764054776-1308696-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 8:12 AM, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Introduce a new helper function netif_xmit_time_out_duration() to
> check if a TX queue has timed out and report the timeout duration.
> This helper consolidates the logic that is duplicated in several
> locations and also encapsulates the check for whether the TX queue
> is stopped.
> 
> As the first user, convert dev_watchdog() to use this helper.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  include/linux/netdevice.h | 15 +++++++++++++++
>  net/sched/sch_generic.c   |  7 +++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index e808071dbb7d..3cd73769fcfa 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3680,6 +3680,21 @@ static inline bool netif_xmit_stopped(const struct netdev_queue *dev_queue)
>  	return dev_queue->state & QUEUE_STATE_ANY_XOFF;
>  }
>  
> +static inline unsigned int
> +netif_xmit_timeout_ms(struct netdev_queue *txq, unsigned long *trans_start)
> +{
> +	unsigned long txq_trans_start = READ_ONCE(txq->trans_start);
> +
> +	if (trans_start)
> +		*trans_start = txq_trans_start;

What about making this argument mandatory?

> +
> +	if (netif_xmit_stopped(txq) &&

Why restricting to the <queue stopped> case? AFAICS the watchdog is
intended to additionally catch the scenarios where the rx ring is not
full but the H/W is stuck for whatever reasons, and this change will not
catch them anymore.

/P


