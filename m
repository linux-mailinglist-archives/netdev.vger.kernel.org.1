Return-Path: <netdev+bounces-244632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59319CBBD35
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F05A130021F1
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820D428B4F0;
	Sun, 14 Dec 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mf7aZETZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CE772602
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765728159; cv=none; b=Knwt86dnOsnvrhSodFiOmxg2sHbGKQQuvKhyNVvqtTYEdaZaMDod14vWGwUIqaf9EiZ5LgNLqUdYhNGc/LIiA4nO+Lzx2cF/oCP/LKPGPRNePgkB8B4nT/Nu05C7a8zptaqlpn4Wu7yElua6Sw+lS3n+sZSHfXVJ5CpwpHFLPoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765728159; c=relaxed/simple;
	bh=WClbA3JP9PBCEQbLahbBZ/+egWdj23cqYt7+rBR+M8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5y6m9WUMX7FP5lYOMKhY5/lu9Vw470MXugsQp7IDlI2uWZwFCbK5N5/NiKEuDFthPLsls+e86iYZ9SKjS77mjFGjonqvpQr3XExR+s6f7WfHR+bFWjmGt/mFq1MZeHaKYPWo1x6+T24NGwAq04zhbrJxI/ezufU4i5d7QHMOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mf7aZETZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b736d883ac4so422226566b.2
        for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765728156; x=1766332956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HRjVx+w0FUfej9H+if55vg50Zyzey3BxyfSJanV6SE=;
        b=Mf7aZETZqpALHFu3VbM2xBuKrNXrWug9+mg7W4T27vSOyLlucNUD8oESoWt0F2BkSd
         mLNolIohsR43r8TMH5wKcaGvCcf6o44LjbSF61vf1oTzSfkk7KWkrgg7DQ7BRbztASO7
         1UdxEJSs2bpcLfbWHCa0A8qiMVpGF1xK1BBukWg/Pp48bWthhkQCP0Xgbwe5H6hJMb6x
         WHzf2AcvdVBu2Js/YZH0Zro/+gAGxWrBJMMIdW3rCL9t+jk+uOixVfX18EdNi15yVXt7
         MY/yh4PUw45Tw33LCswO9tqVbwdml17/39LzdSOrh7H7bknQqMZyUsfzhB+zzyNrcZCx
         hw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765728156; x=1766332956;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HRjVx+w0FUfej9H+if55vg50Zyzey3BxyfSJanV6SE=;
        b=mcU3cRf3cNthlI1R8psItTJQlBo0ijD15Uqa+DgmdnmpQhn9t58NIFb7hyibu9sYqi
         Q7sYUnWVTTbojpFGuPnBqk/dkQqnjfQluxg3k4qJK8OjXuDMZ/yfzgz0aMXKnT1QCmya
         M3QaXIxYyHP8U3OgiO3IQHcb1MCEIV8+ELUt6DRZ/s5E+jHISR6QnI6+3fTtmTTZwqNi
         Y+XwwXQqAx0EKmO3uNmug/5RYvy/u7wAFtuyr+fNc+A+b1GMepbHAWJaCagxHHnEyhAm
         1vO7AXd3LD4rrb2eJY+PJJ9qek87IunLh+c546lxZqblDFSHwET3NlV8S/TXzBKRkb2P
         D/Tg==
X-Gm-Message-State: AOJu0Ywm06/YUbZDvAgeeT67zSr8JTVscBnilIvOyfq5DrCCK+f8UhIz
	TGlhnn0ffxKLKRcEFiy8mKulEk7P4nLgYWSqkriyYMMG3XZV3NqnnA7e1uzjIA==
X-Gm-Gg: AY/fxX57ME4zKm5rszETABGnB6VkLg0ZCP50yfo7NBRA4IDk5X7W7NmC+HMXEuU107u
	pe1G8+QYWODbndgqAryiTTcDvcaa6GBecIHkLE2urMYEhhDxpb61PvjEH+WY0d88f46uN52FWPW
	mfb7xgMqbQyPI4Wuam4DMpayK9krauyC6oV2dqoMBHlOqQ0/KGgGUKzE1IIqS+HqrlRjlF8Ad2t
	lQb8w1LGe+x6HNypcfqeAGy7GHiH/ITOKc7fuAG3+3EgrEsNXy+feunt3zNld2SL8I+NLYrOzq2
	iam0ap7A+P5V9fPa1ZknJjWYqNgtNwYoz7PZ1dPky9otVuxPkCoGnpFSEbnll0u4yt1t7jTW9Oo
	7Qd5T0IamRPFVHSnNPGa7yI8+P3dhHoMdDigR0cLd2EziNurNzn7DguCu0PSJGc2sm76nGv9uyK
	51AT2Sd+2xv9Gn90XeNKkqFcuX/oNuCAza5DoIra/0lEGzbf4L6YKfPwB7imBnsaNqaWveAYhM
X-Google-Smtp-Source: AGHT+IFWOX+q/68f3C3UaXjuHgRyTcHnGkkYvoTOTSRdTMz0p4912j7OAGU1Gsmdx9vlNh9tWKRW1Q==
X-Received: by 2002:a17:907:60cb:b0:b73:880a:fdb7 with SMTP id a640c23a62f3a-b7d238fd2f5mr896492366b.35.1765728155474;
        Sun, 14 Dec 2025 08:02:35 -0800 (PST)
Received: from [192.168.0.2] (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29be92sm1132110266b.10.2025.12.14.08.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 08:02:34 -0800 (PST)
Message-ID: <39ba16a9-9b7d-4c26-91b5-cf775a7f8169@gmail.com>
Date: Sun, 14 Dec 2025 17:02:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
To: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tobias@waldekranz.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
References: <20251214131204.4684-1-make24@iscas.ac.cn>
From: Jonas Gorski <jonas.gorski@gmail.com>
Content-Language: en-US
In-Reply-To: <20251214131204.4684-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/14/25 14:12, Ma Ke wrote:
> When of_find_net_device_by_node() successfully acquires a reference to

Your subject is missing the () of dsa_port_parse_of()

> a network device but the subsequent call to dsa_port_parse_cpu()
> fails, dsa_port_parse_of() returns without releasing the reference
> count on the network device.
> 
> of_find_net_device_by_node() increments the reference count of the
> returned structure, which should be balanced with a corresponding
> put_device() when the reference is no longer needed.
> 
> Found by code review.

I agree with the reference not being properly released on failure,
but I don't think this fix is complete.

I was trying to figure out where the put_device() would happen in
the success case (or on removal), and I failed to find it.

Also if the (indirect) top caller of dsa_port_parse_of(),
dsa_switch_probe(), fails at a later place the reference won't be
released either.

The only explicit put_device() that happens is in
dsa_dev_to_net_device(), which seems to convert a device
reference to a netdev reference via dev_hold().

But the only caller of that, dsa_port_parse() immediately
calls dev_put() on it, essentially dropping all references, and
then continuing using it.

dsa_switch_shutdown() talks about dropping references taken via
netdev_upper_dev_link(), but AFAICT this happens only after
dsa_port_parse{,_of}() setup the conduit, so it looks like there
could be a window without any reference held onto the conduit.

So AFAICT the current state is:

dsa_port_parse_of() keeps the device reference.
dsa_port_parse() drops the device reference, and shortly has a
dev_hold(), but it does not extend beyond the function.

Therefore if my analysis is correct (which it may very well not
be), the correct fix(es) here could be:

dsa_port_parse{,_of}() should keep a reference via e.g. dev_hold()
on success to the conduit.

Or maybe they should unconditionally drop if *after* calling
dsa_port_parse_cpu(), and dsa_port_parse_cpu() should take one
when assigning dsa_port::conduit.

Regardless, the end result should be that there is a reference on
the conduit stored in dsa_port::conduit.

dsa_switch_release_ports() should drop the references, as this
seems to be called in all error paths of dsa_port_parse{,of} as
well by dsa_switch_remove().

And maybe dsa_switch_shutdown() then also needs to drop the
reference? Though it may need to then retake the reference on
resume, and I don't know where that exactly should happen. Maybe
it should also lookup the conduit(s) again to be correct.

But here I'm more doing educated guesses then actually knowing
what's correct.

The alternative/quick "fix" would be to just drop the
reference unconditionally, which would align the behaviour
to that of dsa_port_parse(). Not sure if it should mirror the
dev_hold() / dev_put() spiel as well.

Not that I think this would be the correct behaviour though.

Sorry for the lengthy review/train of thought.

Best regards,
Jonas

> 
> Cc: stable@vger.kernel.org
> Fixes: deff710703d8 ("net: dsa: Allow default tag protocol to be overridden from DT")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - simplified the patch as suggestions;
> - modified the Fixes tag as suggestions.
> ---
>  net/dsa/dsa.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
> index a20efabe778f..31b409a47491 100644
> --- a/net/dsa/dsa.c
> +++ b/net/dsa/dsa.c
> @@ -1247,6 +1247,7 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
>  	struct device_node *ethernet = of_parse_phandle(dn, "ethernet", 0);
>  	const char *name = of_get_property(dn, "label", NULL);
>  	bool link = of_property_read_bool(dn, "link");
> +	int err = 0;
>  
>  	dp->dn = dn;
>  
> @@ -1260,7 +1261,11 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
>  			return -EPROBE_DEFER;
>  
>  		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
> -		return dsa_port_parse_cpu(dp, conduit, user_protocol);
> +		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
> +		if (err)
> +			put_device(conduit);
> +
> +		return err;
>  	}
>  
>  	if (link)


