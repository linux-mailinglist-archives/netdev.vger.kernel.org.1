Return-Path: <netdev+bounces-205729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C9CAFFE5F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A485F4A5731
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 09:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A154225409;
	Thu, 10 Jul 2025 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyEgR3Cu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88954A11
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140729; cv=none; b=eC6dXp91c39B+NVCtvdHne6VqyLcSOSVkb5olwCiRkftH1AjlrsJLqJVmpVQzxjG68zyrJKO8xE/6aYr/wnGVXG/GBO1q7EEQ8d3F85+GUfyl6saoA+z2oEkeOepxhnmUUMYNgD6TFlHXkA376kWFzdttIC0fQWERlkRj8ovgNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140729; c=relaxed/simple;
	bh=JlnkxCIv0A+XUGmXVKm3btkcFzONpJvdoaAGgcaznDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbBx6KrEQVfszu5U29aJHzBCjl+6Z+KxKEFkiiFWBV8r8MVuIYLzM63EORC/G+dgNNb74QYVA2e2fbVdlQK3i6r+cp7zOpAyzHXMmkwf8we2cwb8AktHx2nbKc2ImS243kjESSNaLBOdDnNsPay/n2Xgn1T/PF4MwNBmhlhXTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyEgR3Cu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752140726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUAxbira/r5SIShQiasbpM4nbYjRL/yH1GhuiP1RbY0=;
	b=VyEgR3CuviBs5pb1q/kDzElGspwFqx6eQF4cisKyYKKp4cbxQTmTs3/DgXo17i9cmcRvdh
	+xZXHJPvvXdsA66RTjAh/3r9tpUwRlI/9DD+yBrCtlKHVpJGXf+3MPPrh4y/tM0TGcVxWU
	lEQrCFkImkhObJLMmpQodTd83MU3m+4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-96rasl3HNbiCmHZUrSiZLg-1; Thu, 10 Jul 2025 05:45:23 -0400
X-MC-Unique: 96rasl3HNbiCmHZUrSiZLg-1
X-Mimecast-MFC-AGG-ID: 96rasl3HNbiCmHZUrSiZLg_1752140722
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4ff581df3so348557f8f.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752140722; x=1752745522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUAxbira/r5SIShQiasbpM4nbYjRL/yH1GhuiP1RbY0=;
        b=xO6E3eO0YOFfOnfc3iYOYO/VMdRGU3RubRFqXQZe/TGLQ87RDksWDqGCyjidyFDgVu
         TBKrkVdPLQ1GIkARdLP7T/3rObaSg50WfLR/5brJfgbiiF8NCgZClzERm3y5X4QvjFll
         /77NttHLTEZLexbGE75xvvK84s1ZNWsYvMtSAexYdB1ooFLw4iT8gFPIX/JXaCv9zU/9
         REDstX4spjwBG4ipZbemMveRC8/intxheOPMGVcadl24NJKIb/g5jGeqwIzM3AEBK86x
         M5ZP9Vve/7MUwlwtY1V5pNLBQdi8e9GrDYxXsAwbaXLIG7rEg5uQNW7MVBg9QN1h3nY/
         PLmg==
X-Forwarded-Encrypted: i=1; AJvYcCWNSwi8UxqQfrgLTyY99nmGRVhJiCV6l/zd7oeT3YDwGYOdpWETAsghqAK1OCvA8z+lE8UQpAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOAMNexOrgTkpGDmo9GQhBw5nazwGJo5929MEtpw2F33OZ69oe
	xwNzVNGFWQYyqjObZvZZ1TaiHPrw/RS5M3PUuIk7bmxrBlmJwDB3V51Q3yzmhY+5dxMADgK0I6T
	K4MlDlu7dXkIMCumqpA5qfGi6xCGLXZcmRPir6xz9NEbgajfwhKHRDtzxuw==
X-Gm-Gg: ASbGncs8eURLZLL34ORBYIiAcmq6eMwijjPGX/kC4t/q411H4qgPhuEV22ebsffW25I
	O9Jh49vx/S3jHVMY9G7wfXYsacSZGgJ8OFs8i40TG+3iMmvs44tb5+3Oi7c65srZhEOlqd/s03u
	y1UCsJQZU1rq2WbXO2iNDe1VrFIG0Ac1nY+Gt9Zs9nXTgACDa0ckWGsPVWby4KnRXxw7EVWQLFo
	ER6aVmahIyPfBaukPpqrLZlXAUwGZKUncrdgP6Lgn1+HWI19ZoQaxbiowqH9w2KKxsBFd4rYRQA
	6LlcN+Omshmd9W0BgaQ8ENOePh56+nywuKenbpYGk55c6wToBUDFqHLlrd8mCqZYo/pnJA==
X-Received: by 2002:a05:6000:270c:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b5e7f3c37emr1936760f8f.27.1752140722202;
        Thu, 10 Jul 2025 02:45:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAU0818OS0GFMNvZXLmrF58uahx/2e0rE4pqDfjpuGrM9Qb11XhYvO9Rvlg7UQpUVyPxlOJw==
X-Received: by 2002:a05:6000:270c:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b5e7f3c37emr1936721f8f.27.1752140721706;
        Thu, 10 Jul 2025 02:45:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271f:bc10:144e:d87a:be22:d005? ([2a0d:3344:271f:bc10:144e:d87a:be22:d005])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103082sm51729085e9.29.2025.07.10.02.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 02:45:21 -0700 (PDT)
Message-ID: <38cb3493-1b13-4b8a-b84c-81a6845d876f@redhat.com>
Date: Thu, 10 Jul 2025 11:45:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Fix RPS table slot collision overwriting flow
To: Krishna Kumar <krikku@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com
Cc: tom@herbertland.com, bhutchings@solarflare.com, kuba@kernel.org,
 horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, atenart@kernel.org, jdamato@fastly.com,
 krishna.ku@flipkart.com
References: <20250708081516.53048-1-krikku@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250708081516.53048-1-krikku@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

The patch subject is slightly misleading, as this is a control plane
improvement more than a fix. Also please specify the target tree
('net-next' in this case) in the subj prefix.

On 7/8/25 10:15 AM, Krishna Kumar wrote:
> +/**
> + * rps_flow_is_active - check whether the flow is recently active.
> + * @rflow: Specific flow to check activity.
> + * @flow_table: Check activity against the flow_table's size.
> + * @cpu: CPU saved in @rflow.
> + *
> + * If the CPU has processed many packets since the flow's last activity
> + * (beyond 10 times the table size), the flow is considered stale.
> + *
> + * Return values:
> + *	True:  Flow has recent activity.
> + *	False: Flow does not have recent activity.
> + */
> +static inline bool rps_flow_is_active(struct rps_dev_flow *rflow,
> +				      struct rps_dev_flow_table *flow_table,
> +				      unsigned int cpu)

No 'inline' function in c files.

> +{
> +	return cpu < nr_cpu_ids &&
> +	       ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
> +		READ_ONCE(rflow->last_qtail)) < (int)(10 << flow_table->log));
> +}
> +
>  static struct rps_dev_flow *
>  set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
> -	    struct rps_dev_flow *rflow, u16 next_cpu)
> +	    struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
> +	    u32 flow_id)
>  {
>  	if (next_cpu < nr_cpu_ids) {
>  		u32 head;
> @@ -4847,8 +4870,9 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		struct netdev_rx_queue *rxqueue;
>  		struct rps_dev_flow_table *flow_table;
>  		struct rps_dev_flow *old_rflow;
> +		struct rps_dev_flow *tmp_rflow;
> +		unsigned int tmp_cpu;
>  		u16 rxq_index;
> -		u32 flow_id;
>  		int rc;
>  
>  		/* Should we steer this flow to a different hardware queue? */
> @@ -4863,14 +4887,54 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
>  		flow_table = rcu_dereference(rxqueue->rps_flow_table);
>  		if (!flow_table)
>  			goto out;
> -		flow_id = rfs_slot(skb_get_hash(skb), flow_table);

Consolidating the flow_id computation in the caller looks like a nice
improvement, but not strictly related to rest of the changes here. I
think it should be moved into a separate patch.

/P


