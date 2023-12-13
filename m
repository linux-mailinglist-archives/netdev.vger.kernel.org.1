Return-Path: <netdev+bounces-56776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0581A810CC4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F43BB20B53
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361B1EB3C;
	Wed, 13 Dec 2023 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K5dSWxgA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB51AD
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:50:46 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1915034144so868004366b.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702457445; x=1703062245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzZ0wHOCKxKt46yMwc5YoqqAju6eznko5SbWpJoTnT0=;
        b=K5dSWxgAHfAlDFQAtjwi1QXnKLsqwcI8uwV0DH9KdZ8BAD3fQnrswfBy/9sJyDzBjs
         bIZl/8155xXXtWnrvuMGVrviU1fu1V9dpMSNwT0co9bD7YbYB0NpojYVcIgEib+/9ucM
         NnI5HJfg1bWF9HG9M9j0nM1aAxA6C6kqYD5lP4ye/FeFVj2AitQ8hpFFct9fLfZEoapY
         iEyJzcz7zL2Wm+LTGpzS9/Ed0eCNtsWMJNshMRINnqP5ixW4qAD6FCUQXwxsIDskhOCm
         U3CJ6H/eXa0AZyp/5UKODpRLtZjLDK0FmzS5RWeidfn8aicMoz7rpNjIsKk61qqHGjoy
         RF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702457445; x=1703062245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzZ0wHOCKxKt46yMwc5YoqqAju6eznko5SbWpJoTnT0=;
        b=rUzW1FpV8EZsam8KcvdXoW29cpwQ1YceUN8rAgKw8J96U90jgC04RZFOz2ji7/dNHL
         GUei1XFYw3tmPAUHIJSwInD4fWbFh6yTxo1bz7iSLt2qBi1PR9rORImpPIOWz1iSCVVh
         JaOxpuItRrlmfHvEvcu7Zeeu35Qfq3hvwHbGrztdmSsXlLwHA4jGoIKR7qZV8F0qULEZ
         3rZEHsc/b1OQsx2EwrJpENNcB7qN7mkiOrCJC9MEVT1KTuf+ptNlVMohea20wvzuRAvY
         B1HFQzmMPX6d3LW+3tamcZcLBSe//MwyXc2S+khx8DMXpGPl/Ogwr11sYjYCAyne8Vm/
         Is4A==
X-Gm-Message-State: AOJu0YwI8abZuw6k3IhE5f9kqoqxl+psRbE+5dSWVQPwD4idD5+FNCSZ
	Dn7nPy42Xh12N1FmQonWlIbmfQ==
X-Google-Smtp-Source: AGHT+IFAzNPzEOzVBDYRyNptP5VHVJvjvP3Y0K/S5C602offreD3t+NuHOjcJhCK2rEmjAgYarwTaw==
X-Received: by 2002:a17:906:2207:b0:a1f:b467:9b93 with SMTP id s7-20020a170906220700b00a1fb4679b93mr1884164ejs.78.1702457444903;
        Wed, 13 Dec 2023 00:50:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id th18-20020a1709078e1200b00a1f8df4e2d5sm5166485ejc.178.2023.12.13.00.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 00:50:44 -0800 (PST)
Date: Wed, 13 Dec 2023 09:50:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
	przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v6 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <ZXlwY5NxMCEzT/MM@nanopsycho>
References: <20231212101736.1112671-1-jiri@resnulli.us>
 <20231212101736.1112671-6-jiri@resnulli.us>
 <20231212154938.6e68fc1d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212154938.6e68fc1d@kernel.org>

Wed, Dec 13, 2023 at 12:49:38AM CET, kuba@kernel.org wrote:
>On Tue, 12 Dec 2023 11:17:32 +0100 Jiri Pirko wrote:
>> +static void genl_sk_priv_free(struct genl_sk_priv *priv)
>> +{
>> +	spin_lock(&priv->family->sock_priv_list->lock);
>> +	list_del(&priv->list);
>> +	spin_unlock(&priv->family->sock_priv_list->lock);
>> +	if (priv->destructor)
>> +		priv->destructor(priv->priv);
>> +	kfree(priv);
>
>> +static void genl_sk_priv_list_free(const struct genl_family *family)
>> +{
>> +	struct genl_sk_priv *priv, *tmp;
>> +
>> +	if (!family->sock_priv_size)
>> +		return;
>> +
>> +	list_for_each_entry_safe(priv, tmp, &family->sock_priv_list->list, list)
>> +		genl_sk_priv_free(priv);
>> +	kfree(family->sock_priv_list);
>
>Is this not racy for socket close vs family unregister?
>Once family starts to unregister no new privs can be installed
>(on the basis that such family's callbacks can no longer be called).
>But a socket may get closed in the meantime, and we'll end up entering
>genl_sk_priv_free() both from genl_release() and genl_sk_priv_list_free().
>
>Also I'm afraid there is a race still between removing the entry from
>the list and calling destroy.

Moreover, priv is not erased from gsk->family_privs xarray. Sigh, this
is pain.

