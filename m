Return-Path: <netdev+bounces-51285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BC7F9F30
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310C3280404
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E325A1BDD3;
	Mon, 27 Nov 2023 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gxrjdEnG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F3C8F
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:00:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a02d12a2444so601499066b.3
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701086408; x=1701691208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YHqQ4VCYHOtxAlaMpe16q5Y5lW4x/R8htrpfpg8Ugig=;
        b=gxrjdEnGSja5FZzkg3bhwU7MuZLSmDHyCECz+rEyRi5R4ZFXF2zS259zRbRz+y+Pye
         thM97MsJjZmDSpxswxJsNNnRbFWmH9nyLZpawyPJSu97IL2kJjzPO4c7DbOmRMTaIM+4
         UewY208LwRL2qCI3xAQya7Ml3yja6EqfJBxXCtwPKYJHsV+YtffH7kV/abboLS2xjLAR
         /W8StzVCk+dYnY1jr2WumN6UtF7WD9Mq3YY4oO3IfL+BoBObS3bjcjCpVOJCZ7gKt1CI
         KLBSHPwXZ4WZnSMPfq5AGuT2pd6n4y1rHNH3HR+bDaa2nyzklJmiHxoYg1uRAAqBO5BE
         o5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701086408; x=1701691208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHqQ4VCYHOtxAlaMpe16q5Y5lW4x/R8htrpfpg8Ugig=;
        b=jf0A+kd8SGJrawrGTdQHH/kUhCo18UzD7EJOL6GnaQ7IwYjDE7iNqi/wu6nn7mfCSl
         a+/6nIyA6bNOEFlezvScNbjRUmpNaj+2zygbrrYGQtBXDhkweJ1c+u2syJBO7ajjM5TE
         8MoWZs8lLrSnJai1Sp4ePNQdhoXWuxrty6do2ZzmQWTABJiTz9w6A/WUl4fnehz6BZXU
         G/G0PbRpBpGBecKGjDY6DZF5axvH/G0+PbT8ClcylB26nLLCbccY4dwV+tFYLuQyqFz1
         zwYL/1H7R0K2/UhJvJL2EHAlbsdYkkjISLk85JERgm9Vm32yOQvv5+VKOwZI9uxuupHD
         MFkA==
X-Gm-Message-State: AOJu0YyHYS+SVXIZRGY/AE5GuFIzKLE/lG4AA8jn5wMcdhMqql51gngo
	pBvagLkbjRmWBZ05amRalNisPA==
X-Google-Smtp-Source: AGHT+IEpoK7kj52UVSHQlDACbPy8tL1AH1RFxXvHSZFY3eIuY3t8z8sTIbSNrp9sZ0RdYVPDvt7SRw==
X-Received: by 2002:a17:906:d112:b0:a11:9b46:773f with SMTP id b18-20020a170906d11200b00a119b46773fmr406210ejz.38.1701086408487;
        Mon, 27 Nov 2023 04:00:08 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bk25-20020a170906b0d900b00a0a2553ec99sm3812593ejb.65.2023.11.27.04.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:00:07 -0800 (PST)
Date: Mon, 27 Nov 2023 13:00:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWSExkaxgLUXoJgt@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <c1ac61d8a51a985f25848f480191c0677b3ed0b7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ac61d8a51a985f25848f480191c0677b3ed0b7.camel@redhat.com>

Mon, Nov 27, 2023 at 12:13:09PM CET, pabeni@redhat.com wrote:
>On Thu, 2023-11-23 at 19:15 +0100, Jiri Pirko wrote:
>[...]
>> +/**
>> + * genl_sk_priv_store - Store per-socket private pointer for family
>> + *
>> + * @sk: socket
>> + * @family: family
>> + * @priv: private pointer
>> + *
>> + * Store a private pointer per-socket for a specified
>> + * Generic netlink family.
>> + *
>> + * Caller has to make sure this is not called in parallel multiple times
>> + * for the same sock and also in parallel to genl_release() for the same sock.
>> + *
>> + * Returns: previously stored private pointer for the family (could be NULL)
>> + * on success, otherwise negative error value encoded by ERR_PTR().
>> + */
>> +void *genl_sk_priv_store(struct sock *sk, struct genl_family *family,
>> +			 void *priv)
>> +{
>> +	struct genl_sk_ctx *ctx;
>> +	void *old_priv;
>> +
>> +	ctx = rcu_dereference_raw(nlk_sk(sk)->priv);
>
>Minor nit: Looking at the following patch, this will be called under
>the rtnl lock. Since a look is needed to ensure the priv ptr

Well, depends on the user (as the comment says). Devlink does not call
it with rtnl lock. Relies on the socket skb processing and cleanup
flows.


>consistency, what about adding the relevant lockdep annotation here?
>
>No need to repost for the above.
>
>Cheers,
>
>Paolo
>

