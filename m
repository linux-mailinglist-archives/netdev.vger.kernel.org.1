Return-Path: <netdev+bounces-49099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF187F0D11
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C5E1C210E6
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 07:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A70D513;
	Mon, 20 Nov 2023 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="raiDCEx5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B65B9
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:58:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9f2a53704aaso527440466b.3
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700467088; x=1701071888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SFM17V6sxpc3n6Rd90VeEKHwn5w1C7DDXqAsMGbFouo=;
        b=raiDCEx5T9de6puc/n3kYBrqihCoux8r/vheCW963i3Sp3+R6B5ZFcATRh7PIVy3Ni
         pTkguyZ9VAwI8tA6p/orvrBMu+QbVpWCPuou/90sTo80N5/E8okdd3NaoZ2vP+d4iaLy
         XS7UcbNXKr4jVUuNI1EBJ1XT1XSlve/tBXbUKbhmK7MDJM5Qys3AxViWeoSyKAytKAZ8
         IxFKyhcGQBAJt+TwMBhDufLoZUwuuLs316YkOahLmgUBrEkSCYFpTlCBMlEDG5kZo9F+
         xFfTq+1yKVekRwKjKyjbWu9n8PybHBgWrOrqeZ+T9o/nx0KNyD7Rq7yWSW4+tuwbs5AQ
         U3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700467088; x=1701071888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFM17V6sxpc3n6Rd90VeEKHwn5w1C7DDXqAsMGbFouo=;
        b=V4xK0XwPu+Zsn6PUVJu5p69ESbEcRGAuEINaJOMwb+1FTp1pmGQqIC0RZw32f30KNL
         /gFCNyAbx+ZBFKpzaEue5ppVqomD35URheNSmbhLinnb1os7KENDX8p4O7exOsHn2Ilo
         yrqY7ha/BCYLvi7WwXUpIj2uJPAt9NNFonC8dTblaTts75eP+GLQLnmuygzDjifdrxFn
         J10vGFQhLOiiN0rnpD5kL70ZmXoEVhWyGV0lCXtAl51gW9kFM54pLJA5pwu3rJV9RHi4
         BFXQlvu97m6X6sjhViiD5qZgLHulRiQtmGYlwvqZcQBfxVFyY6he2H31fBZcETlCJmut
         4LAg==
X-Gm-Message-State: AOJu0YyeHk6tCVALNYHDPxiXHzz8GZ2WWehKF67kD/wnLQc/emOexywP
	A7+Rt9Vb7kQUzMsFZLwQtZ0zVg==
X-Google-Smtp-Source: AGHT+IH6RD1dn65fAJTVmhMS/a2BCRxcxHoRxJi2U7hQKZvQK7WNZG8jiLc0NOgw4QpI7/ZFcIJxnQ==
X-Received: by 2002:a17:906:5188:b0:9e5:19c2:e5f9 with SMTP id y8-20020a170906518800b009e519c2e5f9mr5125471ejk.12.1700467088333;
        Sun, 19 Nov 2023 23:58:08 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id m23-20020a1709062ad700b0099297782aa9sm3609029eje.49.2023.11.19.23.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:58:07 -0800 (PST)
Date: Mon, 20 Nov 2023 08:58:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com, amritha.nambiar@intel.com,
	sdf@google.com
Subject: Re: [patch net-next v2 6/9] netlink: introduce typedef for filter
 function
Message-ID: <ZVsRjiMg2/vGnBCi@nanopsycho>
References: <20231116164822.427485-1-jiri@resnulli.us>
 <20231116164822.427485-7-jiri@resnulli.us>
 <20231119145855.GA186930@vergenet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119145855.GA186930@vergenet.net>

Sun, Nov 19, 2023 at 03:58:55PM CET, horms@kernel.org wrote:
>On Thu, Nov 16, 2023 at 05:48:18PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Make the code using filter function a bit nicer by consolidating the
>> filter function arguments using typedef.
>> 
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - new patch
>> ---
>>  drivers/connector/connector.c | 5 ++---
>>  include/linux/connector.h     | 6 ++----
>>  include/linux/netlink.h       | 6 ++++--
>>  net/netlink/af_netlink.c      | 6 ++----
>>  4 files changed, 10 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
>> index 7f7b94f616a6..4028e8eeba82 100644
>> --- a/drivers/connector/connector.c
>> +++ b/drivers/connector/connector.c
>> @@ -59,9 +59,8 @@ static int cn_already_initialized;
>>   * both, or if both are zero then the group is looked up and sent there.
>>   */
>>  int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
>> -	gfp_t gfp_mask,
>> -	int (*filter)(struct sock *dsk, struct sk_buff *skb, void *data),
>> -	void *filter_data)
>> +			 gfp_t gfp_mask, netlink_filter_fn filter,
>> +			 void *filter_data)
>>  {
>>  	struct cn_callback_entry *__cbq;
>>  	unsigned int size;
>> diff --git a/include/linux/connector.h b/include/linux/connector.h
>> index cec2d99ae902..cb18d70d623f 100644
>> --- a/include/linux/connector.h
>> +++ b/include/linux/connector.h
>> @@ -98,10 +98,8 @@ void cn_del_callback(const struct cb_id *id);
>>   *
>>   * If there are no listeners for given group %-ESRCH can be returned.
>>   */
>> -int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
>> -			 u32 group, gfp_t gfp_mask,
>> -			 int (*filter)(struct sock *dsk, struct sk_buff *skb,
>> -				       void *data),
>> +int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid, u32 __group,
>> +			 gfp_t gfp_mask, netlink_filter_fn filter,
>>  			 void *filter_data);
>
>nit: It might be good to update the kernel doc to account for
>     group => group.
>     Curiously the kernel doc already documents filter_data rather
>     than data.

Ah, I copied this from .c file. There is an inconsistency in the
existing code. Will keep the inconsistency.


>
>...

