Return-Path: <netdev+bounces-178237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F44A75D61
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 01:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5D216870E
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63D513A87C;
	Sun, 30 Mar 2025 23:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhMPx5of"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F61876
	for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743378586; cv=none; b=pCmR55XmlWIXQlQhl8BRnqLlmkYJAAGdD3fiM69AY7gRhpL228p7BQZ0LyvUBbnWIp/gM/tVMv4W5fXTf16Izme2O8v++dz5jftRKcOhHpx7F0ogCTQsvHHRrnUClhxQc26frDaFbsEgTJAY2V1BeX9rYpyd5cbGAsf7Om4AROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743378586; c=relaxed/simple;
	bh=TdsbyzqE/BRm5yvM6DDMLeYTc8NnZwEXyzBgW+Hzp2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVSPqSIlY2mEJJod3nw7KNoKVhAvx9Igo2V4iwpN0yt56ImfcQpBEjf62YHmWKT1KkjyyxNlvpZ9Tnx/eY4wNQDz5Dp1ITWmJdCFuMCkt6EfUKZGKopJWRRl7kb/Qqaxa4DNoT5icAQPwC3DI1OIOxigsbQwMnMwJVp2wiMFUCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhMPx5of; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3015001f862so4941075a91.3
        for <netdev@vger.kernel.org>; Sun, 30 Mar 2025 16:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743378584; x=1743983384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQjojrz09ahIhmYWnfLDrETJCnTCmN3sNR4Gh3yQ50o=;
        b=bhMPx5ofvwn2NBr/17IdecPIVJEaY6a47/KyCZC/pk+AgqAxPam9jkfPQyz8NhNa54
         hiLGnB20lYwvjAOxlTUtHwRq+lKzDYH85Owd8fBNAPdOw2bAB9tPtTodGWKXjXxLzzyQ
         CAqRSJr4m7eD0la7Ob0gWyVnHmnuRzL4dsbdZpLbSWsOoaz/Du2w16DnxL+qTMLtZbVp
         LTJwg1uVXFuhq3W/sLGgeasdvs/kExF6GGq9PWxo2iJIyxf8xSzwhOKxnV2ggT9i5Rsn
         1tMJQhjHvotRie+pn6zQaQYUwvmny0+QcPxRdFD7t7aVP5R+q686p/mYAjAhYJm5nnNS
         7ycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743378584; x=1743983384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQjojrz09ahIhmYWnfLDrETJCnTCmN3sNR4Gh3yQ50o=;
        b=qGboIBIuDGXd+O+mDJO6YKEEr1Qst76gmq+0j2f1aW6a6l/RIynn8GIMWFeC9rn9rQ
         WicQBT90Z/1T9m15IOR7JkURNS4WtF7aIJl5TVnWA7ypXZqubdam8yr3lhY98Z2WCy8e
         Im2LuZCZ+OXfxVt5rBQxB7Lfyaf37bgQvdR12pFOY3khZ1mZ3DLGVWGsrTW061OY8awI
         UaZbE5hckQ0sazxG81lfuqrwvxg6dWBBQ1dfp4EQJ33I6jBqRdpFI51ATq7X2kpRfvwi
         RrYqFj1QzpRauXlAXgDheXNlAe/cBU1wsdlVMk5Rx1GeA3e5g7vCOSJo0IDzw3kX/Ky0
         IuaA==
X-Forwarded-Encrypted: i=1; AJvYcCWL9LZwbBgnPu5tttJo5VLqJKLt4Get7Gl4bOrcOScSMbd0MnNgXMj2jk5pUK5UIPbA5rnWp30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNtHGu2ULIpZGi7iYGpHVrjiRVki2iqheWuPk1cQCPILrLxcYS
	jqQNsC7iNeTfc7nSQKgv5anCsLJ7ZYxtQ2SvSrUGEPmWbRSmeaDG
X-Gm-Gg: ASbGncvi20G4E0i1iE6SZtmWPh0UbwBGPWuldbYDw8kqsoYzYIQnI2/jN2ZbaWuxrBa
	pX7KXLk0Gv9rWx362dxMMXA48u+EaQJrBH4mz6x78HnOVS/3ZmjzqIZ0iFhuRFl/FON069bKMW1
	XqVW24TI7SUs2eHfo0MJGsPXqWCjsIH2uK5gQpc7v5dnX4dBuIzujrPni4i563J3LbwDR+7YbOV
	VC4TFih0G81/gHiy6NKOI6cw95EoCg/LCRawJg2gSfyamPNwu4He84Q8h8p2kLcRPKvD906erMY
	/Jnh45ZAMCPFjyD8nBvySBn7/i0o6hsEKDOM6KZUHZc6h53x6ZE=
X-Google-Smtp-Source: AGHT+IHgWCre4XdNN1tvdXqfvfhP9t5mnMTvRA86+x002VjlmN1k+8HfK7RJ0Kz5hrKcBSYhDTDmYA==
X-Received: by 2002:a17:90b:4ec6:b0:2ff:692b:b15 with SMTP id 98e67ed59e1d1-3053215a24cmr12700635a91.33.1743378584464;
        Sun, 30 Mar 2025 16:49:44 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:b144:63a1:57bb:af94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec71besm58152235ad.14.2025.03.30.16.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Mar 2025 16:49:43 -0700 (PDT)
Date: Sun, 30 Mar 2025 16:49:42 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Octavian Purdila <tavip@google.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/3] net_sched: sch_sfq: use a temporary work area
 for validating configuration
Message-ID: <Z+nYlgveEBukySzX@pop-os.localdomain>
References: <20250328201634.3876474-1-tavip@google.com>
 <20250328201634.3876474-2-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328201634.3876474-2-tavip@google.com>

On Fri, Mar 28, 2025 at 01:16:32PM -0700, Octavian Purdila wrote:
> Many configuration parameters have influence on others (e.g. divisor
> -> flows -> limit, depth -> limit) and so it is difficult to correctly
> do all of the validation before applying the configuration. And if a
> validation error is detected late it is difficult to roll back a
> partially applied configuration.
> 
> To avoid these issues use a temporary work area to update and validate
> the configuration and only then apply the configuration to the
> internal state.
> 
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
>  net/sched/sch_sfq.c | 60 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 48 insertions(+), 12 deletions(-)
> 
> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index 65d5b59da583..027a3fde2139 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -631,6 +631,18 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
>  	struct red_parms *p = NULL;
>  	struct sk_buff *to_free = NULL;
>  	struct sk_buff *tail = NULL;
> +	/* work area for validating changes before committing them */
> +	struct {
> +		int limit;
> +		unsigned int divisor;
> +		unsigned int maxflows;
> +		int perturb_period;
> +		unsigned int quantum;
> +		u8 headdrop;
> +		u8 maxdepth;
> +		u8 flags;
> +	} tmp;

Thanks for your patch. It reminds me again about the lacking of complete
RCU support in TC. ;-)

Instead of using a temporary struct, how about introducing a new one
called struct sfq_sched_opt and putting it inside struct sfq_sched_data?
It looks more elegant to me.

Regards,
Cong

