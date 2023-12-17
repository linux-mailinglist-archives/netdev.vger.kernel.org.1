Return-Path: <netdev+bounces-58367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A45815F9E
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 15:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483CEB20F11
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F864439B;
	Sun, 17 Dec 2023 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="P2XYUglC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A544C67
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e34a72660so396154e87.1
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702822756; x=1703427556; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmGWE5bYA6UKRJlAZJpKIM/zxwJcprdeJdasY+3Mhto=;
        b=P2XYUglCTD3GohBR3AX2Vk1VIGCT6mPirgwpq9JD8mjWY+pF/WLfYAdWeHosHrwzyC
         IBtgCYU3ii1vFOf5ErPOnR3CThs6jnGUC7pYt4b4hXeBtEDb8uRj4CNeF+Kq+PS9f9BV
         ed6AeTOvjwls7q2km7mtdljbLn+YeMpYc3l1SVKJ0eN7Uk97gJXGLtcuRzTizpHI4vbS
         mbl8puN73NEMachkxWgyJdr6GckBb9sl9anvGTS8ZvGwlKrbWrnFFQQ+JnBm7XMPX61b
         qjgbJh/LxuZeXsVDCaXdvdlGvmRtUio0nIPy/ZS8PDRXeJPCs/DoYUiwJ+6eyK+GFXSB
         wVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702822756; x=1703427556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmGWE5bYA6UKRJlAZJpKIM/zxwJcprdeJdasY+3Mhto=;
        b=d0kcYNbsOTNlV/hziWl4bzlkLH/JnGeBYGXDIcSmUCumsK8E12SypqH1Hfd75HkCl0
         R6ANkuiSwF3t/099i8VTNnuJ5EfCnXB79bMa1IkVEB83WkeeAV/h8CtyUSjdLPlCOWTD
         rYCqm9jMlKU+BH8qOIGDjXBJVuK3SnZZZaIM40i09LkE5u5IxZpFaK8M/jqnndTJRCx+
         g+4P9WTyLkwZKPXfXE4CCvusjIk1zKvLGouNV7JQMQvrRSzXyPRAbqLTVKh17I/yFs3E
         I+YuvdC5RBDJwrF8sQlDLz6P2c/4ORiGrK9A6yK0x0u2Ag/0G5RBeNeafNLRtWFRcPYA
         l3+Q==
X-Gm-Message-State: AOJu0YwvRrKb/DM5AwfZxMLz7WglM2SstuJrSAIXNBF3UaNy9iqJTGo/
	Om0EIt/lXnodg+gU1+t196AP+Q==
X-Google-Smtp-Source: AGHT+IENXEgKzjyStK+FZAEt8RmS5Co8Q5/KeDksXvuf7ONikFN4cuJXldBZRkxwXhS4cL2yYopfWA==
X-Received: by 2002:ac2:4acf:0:b0:50b:f8d8:b176 with SMTP id m15-20020ac24acf000000b0050bf8d8b176mr6430079lfp.124.1702822756453;
        Sun, 17 Dec 2023 06:19:16 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id cx12-20020a170907168c00b00a1caa9dd507sm13068110ejd.52.2023.12.17.06.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:19:15 -0800 (PST)
Message-ID: <7d2eae85-1b13-48c6-8722-e5d139ca316d@blackwall.org>
Date: Sun, 17 Dec 2023 16:19:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: rtnl: introduce
 rcu_replace_pointer_rtnl
To: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 victor@mojatatu.com, martin@strongswan.org, idosch@nvidia.com,
 lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com
References: <20231215175711.323784-1-pctammela@mojatatu.com>
 <20231215175711.323784-2-pctammela@mojatatu.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231215175711.323784-2-pctammela@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 19:57, Pedro Tammela wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> Introduce the rcu_replace_pointer_rtnl helper to lockdep check rtnl lock
> rcu replacements, alongside the already existing helpers.
> 
> This is a quality of life helper so instead of using:
>    rcu_replace_pointer(rp, p, lockdep_rtnl_is_held())
>    .. or the open coded..
>    rtnl_dereference() / rcu_assign_pointer()
>    .. or the lazy check version ..
>    rcu_replace_pointer(rp, p, 1)
> Use:
>    rcu_replace_pointer_rtnl(rp, p)
> 
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  include/linux/rtnetlink.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index 6a8543b34e2c..410529fca18b 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -79,6 +79,18 @@ static inline bool lockdep_rtnl_is_held(void)
>  #define rtnl_dereference(p)					\
>  	rcu_dereference_protected(p, lockdep_rtnl_is_held())
>  
> +/**
> + * rcu_replace_pointer_rtnl - replace an RCU pointer under rtnl_lock, returning
> + * its old value
> + * @rp: RCU pointer, whose value is returned
> + * @p: regular pointer
> + *
> + * Perform a replacement under rtnl_lock, where @rp is an RCU-annotated
> + * pointer. The old value of @rp is returned, and @rp is set to @p
> + */
> +#define rcu_replace_pointer_rtnl(rp, p)			\
> +	rcu_replace_pointer(rp, p, lockdep_rtnl_is_held())
> +
>  static inline struct netdev_queue *dev_ingress_queue(struct net_device *dev)
>  {
>  	return rtnl_dereference(dev->ingress_queue);

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


