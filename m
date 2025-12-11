Return-Path: <netdev+bounces-244352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F3CB5605
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 799183007241
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BD2F747F;
	Thu, 11 Dec 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HXwO3gwA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511721FF33
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445929; cv=none; b=PRQ6sLUbuHk2JLdYoHnuZYvtMHoYq3zW5pczsouL322taNN71LDCRO5rkuUCFptZtINslNb+YvBcpW1TwvcxE+XY+O657NXDa+0Wqd6F2JH1d8OtnbDOUvzEZ1DShLtto4v72MuB22WIMEVh2B6QbLQ5t3B55LsnSuuqdAEEMpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445929; c=relaxed/simple;
	bh=XU70a7FbHIID1lPxChrNrgm+U0s8j1JYpkTV4aDyf38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xeo47gh8H5FAVZe+Gdg9AVYwohoLdPafGCqB9atJfDuEBFvuqQacwwEPZGovkPxrgF4k3SYrJZC84EsBJMT3Ff1fKn78EkSbagzjVKETom6XuCghm4x9t+G58P0dapLXAeF5W8bGpuctBZRbttVDONfXl0d+AJnRbUlRr//DFDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HXwO3gwA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e239ec0so420223f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765445925; x=1766050725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+ujfgkaGFD17NnPfs71eaPuRIxFTNVHHONeVIjDE7E=;
        b=HXwO3gwAN1l+zdpmCOSGVnGmnlaB7jgK5jVk5JxESVHOG2eJYnMWw1RRNs64tveIbL
         fcKHe/IfiwEAsBFaDyz8yIT/y/+o7SPUspc9l29QTKGR49k+CIBxITVgo/qiBGOh09df
         rPkBxdB8v0OgS2KTkUVg1yIrqJ2QOLYH3VP63fx0L4bdT6ZPJYBvG3xTC/aTLP51fB8n
         JaYFxCgB7W9hlTNWVQhiMDFjqdP0t1AUn4sayoTXB7TUbQd9paIlTA3DE//8MsuJBbqV
         41FRgemmNytAuQ++eC1CeOkROicRrWdqM2gS6ZQzzoIU2XWVLQNWCuLzu+NFePZhFJMA
         v8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765445925; x=1766050725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+ujfgkaGFD17NnPfs71eaPuRIxFTNVHHONeVIjDE7E=;
        b=bXp481VpkS5styP5/nUkUI2k3VnfS217YZONFZwPRf0kJ/x6EUp71gxBGpGSuol4x2
         mxiwS/sZBRTq2a6NSKxwkTzF91KOyluy7qhq7D1v6iNutPPs9qy0AHpWapxCVireLnyl
         9wI5b5VlFaIWpF/C8ABAk2lMMsdZ0yCXHSTptlXdOR8CypGtg4FXAeNYTaJ1xE7QLDnf
         1wlaJeEw9eyxfN1qUpbK9awdWCRj0dsvVBTugRKvUHBYQpiNFytGl+dhvB7Mlut6BCmy
         w1bbSAmT8zm8tBHOp04QyilKIkjBRUxBq7THuFT4ZV7Mg3yx2S+yqabGu2MpNj4dSuuV
         Z+rg==
X-Forwarded-Encrypted: i=1; AJvYcCVmMowIQPKm6sdN6Plbjr6PBuczA2x+arT2/2l+YJGfYeaBxk9NU5c0I1BjKjnIJvLav0nOjLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaVo7tgiFqZOSC0NJeRhGi/VuSiLTyQjh5J1TtwctjzspKkGhf
	VKrg1shnl0ktBAz0aAE/7O2OChR+S88kq56fDruR8nz672NNLFh8R64EU5Wi3qP3fok=
X-Gm-Gg: AY/fxX7TwvoDkFEIT3luLl69nvQ5Q2C7t0SyvzZks2wudPUVOK6Bz2Bo6MP1rq6R/Gk
	xaTn7cw62bTUL7slL1j34P8KyCoQ9y5ECJh19UepDxjmBbYmXEwhGV99ilBcuYWqa89KyvnlPyG
	9RjHSQMtBfMp76rl6df1nO/3/vFjG42DujYf/q758Srk5/2/Y4qNFF4UI0nYbKQul3ZEiTFASmo
	OI8Jf46mH5R0KPO2/5zZ8lcuKU18td7hMYcjNnKaATAusZtSb133kHchKWjGRte37A0KHHnBqwV
	HIETOANn1vVeIk1zJlIH+vFeU4nY2rcIjtCMUEijo/wVfbLqfBVLwiPT/59sINqvqY2hrwNkJuv
	kqWEU2CCF9cRj0XaCZcOv+1b+t5C/I2NwNEnuC3NYkhNTMKlj4T++Fc7sInDiiJvRx9X4+F1NUj
	u6LI5KUl9oHX0lDrHTyb0=
X-Google-Smtp-Source: AGHT+IEcVQHnl5nlVmDwHCHtf8GeroB9zS/N6wnPtae2Cjhrr5b2qK8zazpvYP7ori6Ryg/NLT03aA==
X-Received: by 2002:a05:6000:2382:b0:42f:9f4d:a490 with SMTP id ffacd0b85a97d-42fa39cee26mr5647287f8f.12.1765445924890;
        Thu, 11 Dec 2025 01:38:44 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a67832sm4529063f8f.8.2025.12.11.01.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 01:38:44 -0800 (PST)
Date: Thu, 11 Dec 2025 10:38:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Simon Horman <horms@kernel.org>
Cc: Dharanitharan R <dharanitharan725@gmail.com>, 
	syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] team: fix qom_list corruption by using
 list_del_init_rcu()
Message-ID: <pyaaf6vhfvkab4rpsgkojguixnp5vdxgzle6i6p3shuxgzwwaw@rdwgw47rgvzb>
References: <20251210053104.23608-2-dharanitharan725@gmail.com>
 <aTls21jR6BvTaV-k@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTls21jR6BvTaV-k@horms.kernel.org>

Wed, Dec 10, 2025 at 01:51:39PM +0100, horms@kernel.org wrote:
>On Wed, Dec 10, 2025 at 05:31:05AM +0000, Dharanitharan R wrote:
>> In __team_queue_override_port_del(), repeated deletion of the same port
>> using list_del_rcu() could corrupt the RCU-protected qom_list. This
>> happens if the function is called multiple times on the same port, for
>> example during port removal or team reconfiguration.
>> 
>> This patch replaces list_del_rcu() with list_del_init_rcu() to:
>> 
>>   - Ensure safe repeated deletion of the same port
>>   - Keep the RCU list consistent
>>   - Avoid potential use-after-free and list corruption issues
>> 
>> Testing:
>>   - Syzbot-reported crash is eliminated in testing.
>>   - Kernel builds and runs cleanly
>> 
>> Fixes: 108f9405ce81 ("team: add queue override configuration mechanism")
>> Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=422806e5f4cce722a71f
>> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>
>
>Thanks for addressing my review of v1.
>The commit message looks much better to me.
>
>However, I am unable to find the cited commit in net.
>
>And I am still curious about the cause: are you sure it is repeated deletion?

It looks like it is. But I believe we need to fix the root cause, why
the list_del is called twice and don't blindly take AI made fix with AI
made patch description :O

I actually think that following path might the be problematic one:
1) Port is enabled, queue_id != 0, in qom_list
2) Port gets disabled
	-> team_port_disable()
        -> team_queue_override_port_del()
        -> del (removed from list)
3) Port is disabled, queue_id != 0, not in any list
4) Priority changes
        -> team_queue_override_port_prio_changed()
	-> checks: port disabled && queue_id != 0
        -> calls del - hits the BUG as it is removed already

Will test the fix and submit shortly.

#syz test

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 4d5c9ae8f221..c08a5c1bd6e4 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -878,7 +878,7 @@ static void __team_queue_override_enabled_check(struct team *team)
 static void team_queue_override_port_prio_changed(struct team *team,
 						  struct team_port *port)
 {
-	if (!port->queue_id || team_port_enabled(port))
+	if (!port->queue_id || !team_port_enabled(port))
 		return;
 	__team_queue_override_port_del(team, port);
 	__team_queue_override_port_add(team, port);

