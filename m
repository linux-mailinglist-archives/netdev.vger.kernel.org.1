Return-Path: <netdev+bounces-76075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 190BD86C359
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44271F23710
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323B54F205;
	Thu, 29 Feb 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mNUCWGqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708D4C63D
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194893; cv=none; b=X6UGyAg/qiDfKKXY7Tr8TaHP25IJfQIplupPpyEodqF4epK3k6HLrV7y/wsL4px5Uzqm51O/0gtTa7MUjhhfnCNp1bZ4PGaO6kFZ8QllQp+rYFa32rWdnuD0iiyreEKmiatt6J43fAhmBU6FCJTL/uQLBWissTAqgA69vzbXEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194893; c=relaxed/simple;
	bh=CqIfpCCmF4K54HxciJDzn0wo0yA8SRKezymaMpStEYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ymp5CPX9YDo3qdIckbJQI6k65LFXWogd9pyr8SE6mTMQWezVo5ZaVQdpFMmei6Pl3ssYEjA92nalJH0cLfJUzzWZOUVwB7jtWKRGvwDotI6mFf8g2gkndtUNk5UiZlS+B0B6W7mLHOVolIVR5dR8gO6sd+AItirMWA3WZTzvwKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mNUCWGqd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a43f922b2c5so77217566b.3
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709194888; x=1709799688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7+M5t/BmbMJvMb+MHjInifdNdbry65ckw1m7eEUxIAg=;
        b=mNUCWGqdc1tv7DIIwNyHjEjm1DF8LH+jK7CRIBLMAbGDq+zfbUYNqEiVRL6HZ9NZKP
         wFX6xmB2/4OQ7o0aeFWZ8RdeYqTcCVHlLizQHeDfNN7dO4lqfe/0AqkLY7zvp8qGxEZx
         E2ogDd1aAd0F7PVr9mrAFHJpKM7Ga0LGZuVMwxyY+cuNf+DOQy6j3atZtIVHMWLHrNK+
         07xs1x6S7dYGVg3IK6vsebdgUl+FQjfE65DaKLZuIuzgYuHcX0TfvG2S/7vT8aa3+HJd
         1BBDHFV0ornYxzQImkTsTO3cw398I07A4bgrDrNYsz/hOZdXndUKf+591TWBFZFaiFLp
         zyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194888; x=1709799688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+M5t/BmbMJvMb+MHjInifdNdbry65ckw1m7eEUxIAg=;
        b=kBU3hY2jBFWxZpbeSm3ge6Jj51EzkE8x7U2H7MrJnYBYzGBN+3Wq1t6FdXZ03mhmop
         To734AJfXduhS4KUxEKpbIgwIgiy3qDw+2sEWl34bp3wOWtfNQt4PLxGpSFCo9KEbwsS
         FIqIiIwmAlfPPchHZF9qmfjRM+WmvsJEiZP5ak0EMFWRZg/LeRHIt9nZN8V0dpkNOokB
         Emp8S/kg/hPCYeC8Axzu3GVok0B/Iva/0WDARIz7KdNtnpNymZ6mcey5O3k1iKpUm3D0
         a/b4MS/PRQhNhDZ4kSLpZByUZAFdPWZ2crzh0YRfeLv1J3sbMaM02P/DulImyeO387Fs
         A95Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZquHvFrQspXmbmzzLQnqqoZUNpuS/SpOPMQfw3W7EJguM0/xg7L6ZpKcjWUsGeYIqZ3xy3ki/psUpoih/SI0+uV8R8rD
X-Gm-Message-State: AOJu0Yw9UlGRugmitlRS6muCnMNBZCgvqOxqgejqFD7ZDYpA0Ohccto1
	Yz8lTMjv0FVg8Z2DdAn0DLgVSNJbUxFecReFX1Hiy+nsFohnxqeS3Q/Q2bfcl4k=
X-Google-Smtp-Source: AGHT+IH37DBUhvRlHbM0XFsEBFBbCQzM5JBOxYZIqVQ24J4M+1dNwvfnFgBIuhFO5t16UAL77keKhw==
X-Received: by 2002:a17:906:3e11:b0:a44:4fbd:a8fd with SMTP id k17-20020a1709063e1100b00a444fbda8fdmr345893eji.10.1709194888560;
        Thu, 29 Feb 2024 00:21:28 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id vg3-20020a170907d30300b00a43f4722eaesm424080ejc.103.2024.02.29.00.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:21:27 -0800 (PST)
Date: Thu, 29 Feb 2024 09:21:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <ZeA9zvrH2p09YHn6@nanopsycho>
References: <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
 <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
 <ZdhnGeYVB00pLIhO@nanopsycho>
 <20240227180619.7e908ac4@kernel.org>
 <Zd7rRTSSLO9-DM2t@nanopsycho>
 <20240228090604.66c17088@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228090604.66c17088@kernel.org>

Wed, Feb 28, 2024 at 06:06:04PM CET, kuba@kernel.org wrote:
>On Wed, 28 Feb 2024 09:13:57 +0100 Jiri Pirko wrote:
>> >> 2) it is basically a matter of device layout/provisioning that this
>> >>    feature should be enabled, not user configuration.  
>> >
>> >We can still auto-instantiate it, not a deal breaker.  
>> 
>> "Auto-instantiate" in meating of userspace orchestration deamon,
>> not kernel, that's what you mean?
>
>Either kernel, or pass some hints to a user space agent, like networkd
>and have it handle the creation. We have precedent for "kernel side
>bonding" with the VF<>virtio bonding thing.
>
>> >I'm not sure you're right in that assumption, tho. At Meta, we support
>> >container sizes ranging from few CPUs to multiple NUMA nodes. Each NUMA
>> >node may have it's own NIC, and the orchestration needs to stitch and
>> >un-stitch NICs depending on whether the cores were allocated to small
>> >containers or a huge one.  
>> 
>> Yeah, but still, there is one physical port for NIC-numanode pair.
>
>Well, today there is.
>
>> Correct? Does the orchestration setup a bond on top of them or some other
>> master device or let the container use them independently?
>
>Just multi-nexthop routing and binding sockets to the netdev (with
>some BPF magic, I think).

Yeah, so basically 2 independent ports, 2 netdevices working
independently. Not sure I see the parallel to the subject we discuss
here :/


>
>> >So it would be _easier_ to deal with multiple netdevs. Orchestration
>> >layer already understands netdev <> NUMA mapping, it does not understand
>> >multi-NUMA netdevs, and how to match up queues to nodes.
>> >  
>> >> 3) other subsystems like RDMA would benefit the same feature, so this
>> >>    int not netdev specific in general.  
>> >
>> >Yes, looks RDMA-centric. RDMA being infamously bonding-challenged.  
>> 
>> Not really. It's just needed to consider all usecases, not only netdev.
>
>All use cases or lowest common denominator, depends on priorities.

