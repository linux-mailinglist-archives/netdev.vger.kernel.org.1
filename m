Return-Path: <netdev+bounces-56675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374BB8106AC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673901C20A1E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF0394;
	Wed, 13 Dec 2023 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Zd0qF6nd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88992
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:37:19 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6d9d209c9bbso5044470a34.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702427839; x=1703032639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=28YVeWUZWxL+EysOhXyOQaCyUsZJlXdHXys5QdhUXEw=;
        b=Zd0qF6ndBzT30uJ2ZZfD8GyBDTEptPJyyfB4uE4G3AAmkGbPxjjFRRDd94IlScUqIM
         J6CP4oF/PCOMz0raRZR9tEPl+RZ+EbthPLCwUX7qPk07cpk9+k8/J8hKZ9lBJgmdo6m8
         h7+E+fxX0Sdw5RnByETFhBk2u6ydC9xNReYeWcH7pgj3183xhdya82PF8//pmt/KajBL
         bmtTZaNYphZ9XgJtXrDR6b6IshqiFm05rT5pdW/u0xmNvjJknD9y8+oT2tYlYN1EgAAk
         eYi/aPEs5Bll24O1K9X5Oi5o9T4U8V6yaGbUqcwiOCQmf919SXQRQ9U6sPf2JQfiB5h2
         SD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427839; x=1703032639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28YVeWUZWxL+EysOhXyOQaCyUsZJlXdHXys5QdhUXEw=;
        b=tK9rBoNtt+DAr7U6gbCp74whgbSYBHIVyZltGcUVQALhmlSlEaAiBBGLZxpn3GYvI2
         SsshceFgLy/w9eowBAgLPld/XRfIYRKp1tz6MTAGOByiUZ2uzISRwKT3dgATOc/S7DhR
         Vs8BXu0R1KxR4zWBCa6TOKMS5+Yvqx+0NuB+UlUe3a3AS09kmGsDvvKyS1e1+kCmIuBd
         9C6e3C4fmwrqdqgWtvDQIFM0V9FU1ZUg0yoegIksgEst5GyAclA+m/HbOxmu9B5W8v6n
         g24EBwh4EsD4VB2R+DJDOg907fdVzeex31RrlfAJfHhv3F5WCJbyGzkG9bR4i51mGRuj
         vR9w==
X-Gm-Message-State: AOJu0YzqZoMD/S4xfEkLpoZ2pBFdD2DZGGrQzZKlsHkbKJmjHQotj6o/
	ulu4tU+XgGKP2ZvRZ372dSAAE5+w8Y824XrXQR5B0g==
X-Google-Smtp-Source: AGHT+IFK4z7dnqtBzSqo55NWH07p7nRZ3xYyzNsTCHZmhCcAUit9um7GtTDhLh4ckaZ5gR4Fz4aSdQ==
X-Received: by 2002:a05:6830:1a:b0:6d7:f363:eb0 with SMTP id c26-20020a056830001a00b006d7f3630eb0mr7212719otp.35.1702427839085;
        Tue, 12 Dec 2023 16:37:19 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::7:721])
        by smtp.gmail.com with ESMTPSA id c7-20020a056a00008700b006ce458995f8sm8789340pfj.173.2023.12.12.16.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 16:37:18 -0800 (PST)
Message-ID: <12f55a91-1f93-48a0-96b9-63f0c1ea36cb@davidwei.uk>
Date: Tue, 12 Dec 2023 16:37:16 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] netdevsim: allow two netdevsim ports to
 be connected
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231210010448.816126-1-dw@davidwei.uk>
 <20231210010448.816126-2-dw@davidwei.uk> <20231212122441.7c936a28@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20231212122441.7c936a28@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-12 12:24, Jakub Kicinski wrote:
> On Sat,  9 Dec 2023 17:04:46 -0800 David Wei wrote:
>> diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
>> index bcbc1e19edde..3e4378e9dbee 100644
>> --- a/drivers/net/netdevsim/bus.c
>> +++ b/drivers/net/netdevsim/bus.c
>> @@ -364,3 +364,13 @@ void nsim_bus_exit(void)
>>  	driver_unregister(&nsim_driver);
>>  	bus_unregister(&nsim_bus);
>>  }
>> +
>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
> 
> nit: s/get/find/ get sometimes implied taking a reference 

Will do.

> 
>> +{
>> +	struct nsim_bus_dev *nsim_bus_dev;
> 
> new line here, please checkpatch --strict

Sorry, will remember to do this next time.

> 
>> +	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
>> +		if (nsim_bus_dev->dev.id == id)
>> +			return nsim_bus_dev;
> 
> You must assume some lock is being held so that you can walk the list
> and return a meaningful value? :) Please figure out what caller has to
> hold and add an appropriate lockdep assert here.

Will address.

> 
>> +	}
>> +	return NULL;
>> +}
> 
>> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>> +				  size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port;
>> +	struct netdevsim *peer;
>> +	unsigned int id, port;
>> +	char buf[23];
>> +	ssize_t len;
>> +
>> +	nsim_dev_port = file->private_data;
>> +	rcu_read_lock();
>> +	peer = rcu_dereference(nsim_dev_port->ns->peer);
>> +	if (!peer) {
>> +		len = scnprintf(buf, sizeof(buf), "\n");
> 
> Why not return 0?

No reason, wasn't sure what the norm is.

> 
>> +		goto out;
>> +	}
>> +
>> +	id = peer->nsim_bus_dev->dev.id;
>> +	port = peer->nsim_dev_port->port_index;
>> +	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>> +
>> +out:
>> +	rcu_read_unlock();
>> +	return simple_read_from_buffer(data, count, ppos, buf, len);
>> +}
> 
>> @@ -417,3 +418,5 @@ struct nsim_bus_dev {
>>  
>>  int nsim_bus_init(void);
>>  void nsim_bus_exit(void);
>> +
>> +struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
> 
> nit: let this go before the module init/exit funcs, 3 lines up

Will address.

