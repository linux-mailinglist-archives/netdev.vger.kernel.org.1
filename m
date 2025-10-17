Return-Path: <netdev+bounces-230364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1821BE70E5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EE43B40B3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9C32673A5;
	Fri, 17 Oct 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="j3NRwna2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AE265CCD
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760688375; cv=none; b=Z2GqN5GGAOCzJRxdodFbrraDiZutpaYSyMTV5s0KkG2z56WJOpmsKOPX4Z4qv+W9RrlZ5R1eOW7+bpAMQpNikVpT6Ph3ZrHFBHSJhWe4OQCnr+SNS+txEue4nQCfRPSuvulvYuOCEV7Mc/eRIZl06BJB6hmMBdvGcctwP4C+0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760688375; c=relaxed/simple;
	bh=7VAHq0ca7HuOlzPv3viNp/o3c0j9Goapdwpz6d3kK7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us/UULtmLEAJqP7c+Nuef0GkDJVU8gT+xz0eMLGbFX/x9hT1wN2RjSrq2lWc+xS1HQSJSDtqrd/KEstaqxGtRpdRjvNFzOmC+hUSyUA5a1mzrdeSdvc0WSXRbYBgie0n7fDDZbR2Nt3dbe8mD+qWtDDNkHNcj/yHT5xXF5jTsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=j3NRwna2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112a73785so11538485e9.3
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1760688371; x=1761293171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zu033k7YwLme3oq6cJUENa9OJRVvLivBJ0kW8ltDB58=;
        b=j3NRwna2WitDo+bw+MNJz77DNqqw4Jqb3LMKZudJz0Q44kEHeWcM/TbIc0z2iDFUuZ
         6KZBTpMOxFtqPNet3AzxwFw8HBEC88rT/+G+o2hm8Eln2OTx5wVrBYgU8KePbaguLhNg
         GoqHt2CHqElBkqIhxiBJjOR6Yp2J8fCVHWc8YkE67oJfrZG6JRXVgRPw6F6MnS5bSdhW
         QhnJI+3O+qNMS8EXxwSA0KKl9ASqxC/l1ugGy+k3j3DVJpbGwj8WKkC2VnGDEcyrsXdQ
         u0wYP9m0yzYAsMdGzK+3A5suYdxcBzuqToie0jJ57/jXmk/LVCwHpNqfLa30SiSnRlFo
         06gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760688371; x=1761293171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zu033k7YwLme3oq6cJUENa9OJRVvLivBJ0kW8ltDB58=;
        b=XKmCYas/kkv3fRced+Hr3ruS+cyO6/9/594LOiEobdlvbALHJn3HSH7TSTvEB+3SaP
         gip9gNXk0XvC7AQvYOHZ37DbixTNBIhir7D0yM4KTpElZxgPGt/mn6dMKwJ7LpF4AkoB
         Fodl3O7aq0YH9x5IyRY5nUoAie0EVtZV/mo/XQzbjAAoP1NnZl+ZoW+Ywo3SNy/mwT86
         BMNn5Ex+0Uq9lHZnJje5u+hSshjHvdUNL/ZoL7fMGfc7HdbmQLX3dpsp2NxTnhlYNPTJ
         LERsDkMdnOc1JTeNiGrAJqKZLhcgQ1lo08nzZWAN8UW4A6G42iK9YVnd01ooTZyYRuuh
         hOKw==
X-Forwarded-Encrypted: i=1; AJvYcCWaLp+uAYrZQjEGuWzxQJDTlMGoapcJpWSH3LPGFzIsjVBLClvxr3vq6s2ITa5ZY4/bNzQMNCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcisE87jNXxdPeJarmbvwuMbqrB8kItC9je2iYM62b5VKyoJsQ
	5Iiz+FNsXhuqO23ag+92dosg61ISU06xE14TXR9vN4dhbAsTxCv7Z/fPFTtfJFMT8ws=
X-Gm-Gg: ASbGncsUcJ/x/9N8CKxxQzt5jGUcBtzGXg7ZRVTtc8xw2WysJaRrKSHGSflLyzGFIGk
	gMc71xCDG1TjonuR5fWLEX7mWGe6oC1FygRH99kXdK0ZOlhTbmSkzLc4Mw6ANKd5Mst3AcN4/HW
	Ktqa+ST1GkH3PIWTE+4i/IGDcFHuQo5uL3nLqOWN7aNMaGZpIensKzQEKaEJsuqrzUyFCf7/x1o
	OQUKLBIJhd0sbrbls2//2/x4YqmXhNzJYcNfxDFKxax6gXAKYCQb/+z9TZDyV1iUd97DjognhDW
	Wby3XPMzm29iuMcvkSe8ona32Bp955IlJkV7dutzAhwhfSXdp3mOXngqV+4PzznVavGEua7JBX/
	1F8LPm3NdSA3/gDuIDrLtFGO34mZFMly881PUkhZN7ROy1OYbwkDKD3RQeO56e6cLfMdiJeiKd0
	XvXFV1IqLshs7Sgt/oklrL6Dl6Row=
X-Google-Smtp-Source: AGHT+IG6cZNvp9AZaQEUue2pRtN3coidb/IsW2tLsmAXWgWx6KDT1aBYGYRZozRXiH+ezZGd19CdgA==
X-Received: by 2002:a05:600c:3513:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-471178a2547mr19145165e9.11.1760688370782;
        Fri, 17 Oct 2025 01:06:10 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144239f4sm68798855e9.2.2025.10.17.01.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:06:10 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:06:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, mbloch@nvidia.com, Parav Pandit <parav@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next 1/3] devlink: Introduce devlink eswitch state
Message-ID: <e6omssmcsl46duba44gdsb5fawnhbyzbqmma3qxfcz4nncvrkr@wipq2lrvzlc7>
References: <20251016013618.2030940-1-saeed@kernel.org>
 <20251016013618.2030940-2-saeed@kernel.org>
 <6uzvaczuh6vpflpwnyknmq32ogcw52u35djzab7yd7jlgwasdc@paq2c2yznfti>
 <aPEsjG-mFIx-IqtV@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEsjG-mFIx-IqtV@x130>

Thu, Oct 16, 2025 at 07:34:04PM +0200, saeed@kernel.org wrote:
>On 16 Oct 11:16, Jiri Pirko wrote:
>> Thu, Oct 16, 2025 at 03:36:16AM +0200, saeed@kernel.org wrote:
>> > From: Parav Pandit <parav@nvidia.com>
>> 
>> [...]
>> 
>> 
>> > @@ -722,6 +734,24 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
>> > 			return err;
>> > 	}
>> > 
>> > +	state = DEVLINK_ESWITCH_STATE_ACTIVE;
>> > +	if (info->attrs[DEVLINK_ATTR_ESWITCH_STATE]) {
>> > +		if (!ops->eswitch_state_set)
>> > +			return -EOPNOTSUPP;
>> > +		state = nla_get_u8(info->attrs[DEVLINK_ATTR_ESWITCH_STATE]);
>> > +	}
>> > +	/* If user did not supply the state attribute, the default is
>> > +	 * active state. If the state was not explicitly set, set the default
>> > +	 * state for drivers that support eswitch state.
>> > +	 * Keep this after mode-set as state handling can be dependent on
>> > +	 * the eswitch mode.
>> > +	 */
>> > +	if (ops->eswitch_state_set) {
>> > +		err = ops->eswitch_state_set(devlink, state, info->extack);
>> 
>> Calling state_set() upon every DEVLINK_CMD_ESWITCH_SET call,
>> even if STATE attr is not present, is plain wrong. Don't do it.
>> I don't really understand why you do so.
>> 
>
>I don't get the "plain wrong" part? Please explain.
>
>Here's is what we are trying to solve and why I think this way is the best
>way to solve it, unless you have a better idea.
>
>We want to preserve backwards compatibility, think of:
> - old devlink iproute2 (doesn't provide STATE attr).
> - new kernel (expects new STATE attr).
>
>Upon your request we split mode and state handling into separate callbacks,
>meaning, you set mode first and then state in DEVLINK_CMD_ESWITCH_SET.
>
>ops->mode_set(); doesn't have information on state, so a drivers that
>implement state_set() will expect state_set() to be called after
>mode_set(), otherwise, state will remain inactive for that driver.
>
>If state attr is not provided (e.g. old devlink userspace) but the user
>expects state to be active, then if we do what you ask for, we don't
>call state_set() and after mode_set() we will be in an inactive state,
>while user expects active (default behavior) for backward compatibility.
>
>To solve this we always default state = ACTIVE (if state attr wasn't
>provided) and call state_set();
>
>Let me know if you have better ideas, on how to solve this problem.
>Otherwise, this patch's way of preserving backward compatibility is not
>"plain wrong".
>
>We can optimize to call set_state() only if (mode || state) attr was
>provided. Let me know if that works for you.

I'm just saying you have a bug in the code. You assume user *always*
sets mode. That is not the case however. User might set only:
inline-mode
encap-mode
In that cases, you wrongly call state_set() without any reason.


