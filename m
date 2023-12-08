Return-Path: <netdev+bounces-55315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F880A555
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16611C20E68
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927341DFD3;
	Fri,  8 Dec 2023 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TxpwQuHC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE91995
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 06:21:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so6708194a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 06:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702045314; x=1702650114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X0kaZmwq4s0c4ajw946RHyZvluKYZHrCZKcTclsvENA=;
        b=TxpwQuHCPQ+QZF6bfoJ3BayK1D44E5/adf6qFhpDsDnoF7u7G+8AmhylqiYnmhmcCm
         0zMDoea3IZavQOvGeplIdwlXaqcKdtDtOJ1iF+BfRU8yRbmrh3CTVRqDEbBP7ZJmuE++
         AC9JQrUThvJi1PpYS4blmkzlQ7Zxfh7VmBfRtkHT/aMhy4wgPAyDRiE/O4K7l1VUiHoy
         BNWsdQxz25uQa43/odFu+kaawBuQs6G2NpZlLjTiBIkzuzGX9BjjJzJ9K/B2IBJomode
         tNpe/+vY1Kq7orpx/uzzKT003a2CPswZMgtJpxQYC/dP+TNoQi1/5k54HzkwxlkhTC4e
         3l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702045314; x=1702650114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0kaZmwq4s0c4ajw946RHyZvluKYZHrCZKcTclsvENA=;
        b=Yghi80ujqn95w1LWT3FgvVegcswdIk92wwCozFMKKYvaHMBg4+IqRItzqXN+DF+eHS
         dCGFVnJRJJzynUviv/UR1XEkZ54VdBcN7u/ZlegxGgTviH/SjjM5CnkDdIdCdgYQtmQV
         Bqat2e7WTpj0vEReKPImwx89NjwmYaNVA6t67hab8vGjMBGfsGP7TAvtQWlSunEsAWU3
         x/qeiuV6IcoI4/IhO0d8Wg8KyVtTS9hOZJsAamQ74VIDaGC7Tjacj38gHMHEYlJaQj0v
         pY9c5TCQpt/H/IQw488ULlpIJrw0m4eQ2IrLdwsuIJ0TLj+YKA6tld+UpCmp2+V0Kpe7
         9geg==
X-Gm-Message-State: AOJu0YyJwTEV5SUcegq0dAlLwuqoy4icbbFRybGBFsL48VSrfY59dJBZ
	iyL9m3dfOHLdtlJ7PFDrW1dtCg==
X-Google-Smtp-Source: AGHT+IGaiU4XkNalIZlb9Q9SFnRs0fipRKZoRWEM/2GphWhdBQWyj8/J+QOcz79YebJw01Upir/Ekw==
X-Received: by 2002:a17:907:6887:b0:a1d:b773:ae8b with SMTP id qy7-20020a170907688700b00a1db773ae8bmr1225783ejc.17.1702045314571;
        Fri, 08 Dec 2023 06:21:54 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ry9-20020a1709068d8900b009adc77fe164sm1064891ejc.66.2023.12.08.06.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 06:21:53 -0800 (PST)
Date: Fri, 8 Dec 2023 15:21:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v5 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZXMmgJHPdBUFlROg@nanopsycho>
References: <20231206182120.957225-1-jiri@resnulli.us>
 <20231206182120.957225-6-jiri@resnulli.us>
 <20231207185526.5e59ab53@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207185526.5e59ab53@kernel.org>

Fri, Dec 08, 2023 at 03:55:26AM CET, kuba@kernel.org wrote:
>On Wed,  6 Dec 2023 19:21:16 +0100 Jiri Pirko wrote:

[...]

>> +static struct genl_sk_priv *genl_sk_priv_alloc(struct genl_family *family)
>> +{
>> +	struct genl_sk_priv *priv;
>> +
>> +	priv = kzalloc(size_add(sizeof(*priv), family->sock_priv_size),
>> +		       GFP_KERNEL);
>> +	if (!priv)
>> +		return ERR_PTR(-ENOMEM);
>> +	priv->destructor = family->sock_priv_destroy;
>
>family->sock_priv_destroy may be in module memory.
>I think you need to wipe them when family goes :(

Crap. That's a bit problematic. Family can unregister and register
again, with user having the same sock sill opened with legitimate
expectation of filter being applied. Don't see now how to handle this
other then no-destroy and just kfree here in genetlink.c :/ Going back
to v4?


>
>> +	if (family->sock_priv_init)
>> +		family->sock_priv_init(priv->priv);
>> +	return priv;
>> +}

[...]

