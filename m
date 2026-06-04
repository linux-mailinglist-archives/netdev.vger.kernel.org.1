Return-Path: <netdev+bounces-295117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hCQLADRAIWrdBwEAu9opvQ
	(envelope-from <netdev+bounces-295117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:07:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDB063E578
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 11:06:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s42ztUpo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295117-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295117-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39B13302ED6F
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E9A3CC337;
	Thu,  4 Jun 2026 08:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45315373BEB
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 08:50:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563014; cv=none; b=TtMuKuOkRfWXwEecviLd1RHwnXPxtCv/mNScwbfz2pWTSohwWAnQHbVrelEJnXfqLZYMpzDu950wqFFDlgZuhnqPrPG/aFZjrCkbLjZsDMhARSz9vVRSRkDQ3ypvkxba2pKnnPxE+fVx2loMCEfHBSS0BcIh9FnNgd7p0S/9X0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563014; c=relaxed/simple;
	bh=cN3GYDYGdfIRk/xGq7e7i9c6SplFkqWMiAa3artP++A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbblOvpqW3gziwFHGY4XNjgxHZOHxrUA9icrrbxDwT6fEKTuPwgfFdgOL57KtXPv6wNHYIHw3xgAdKZpV7rzbg2US4kQJMuXOIJ6SPR3PwvOTQe+ROG0BErI0M9Pxl7ZKqEIJa/mwiyt47b+6jkwjipnlFloUx1qn0UmU+nDyXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s42ztUpo; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ebafde87cso317935f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780563012; x=1781167812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRiYMliuSQAUYMFdmOihHUU9eCsvr1hWSuEoUDPjWaE=;
        b=s42ztUpoKTYeJ+wXQohzHwc9+OdYXDKXrSzJ2gafUnIxQz8tvz+bJzC/xX0bTzcX3J
         GxGOO4P/xiTu38LXKsi9WVqAWgZll7QEFaFVd/HJsXcmgR/yWL7RS4PDscCWmW2dVqzG
         SsBPziNBDrxjhH6FRbrxK26L4jDGuX6g8o+SDgfauT76JL8wawrDpGzwaIfLAccubz3x
         e/V48aaAUJVgECyqLBufdb6bEKgVIwiNxuoGp0WUSw0KvdfJEZ6z6cmG7W7GTlWAMEjU
         nQVzRc09XF9sYK5StI84MuBSfjToxQm0Me+uwzOGsB4PyOVbJuhbU4PY4sd1Xm+Va5xm
         /tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780563012; x=1781167812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WRiYMliuSQAUYMFdmOihHUU9eCsvr1hWSuEoUDPjWaE=;
        b=jKMWolgdo1p1uVolzX5QDIXUa4kCcagLbJH2wuKtl+hS8b+MIBXbH130ZgywXQtV8y
         MXSNiNJQ1tXqI8Ll+PQH+1KLmqUi86Utci23TRZWn0dkpQaJpI668yi/hsjTwtc0xAPP
         Db0+QnkgUQzML4dUunN6MT86uk5n3uqqDvBGbqWvipXzqKEKc8WvZmIEVf1ijH7ygsKq
         6xc9nmhuHpBEA/UgbW4SQMdiIbio7h8y9JKdatR8vUSdurRHhIwiZi3j8MrKbKsszyKf
         r81IV2brkll5i9hpV0TizvgyiZWTPYOhaT/UpUoK9astrSYXcfq1DCMYiVIGGyjtalup
         oOvg==
X-Gm-Message-State: AOJu0YwHjqcPweXQ38vhW4Y55O49ShiRNSdMUmyHkVdjAdJZoPgMFHSR
	O1EgEothFwgSIwnn4UoVmfMOBRwtcKSKKcUUGxpzV1Gr12JR/hnzSSpR
X-Gm-Gg: Acq92OEdKaVpN9kUwgQjPWlQPvAAT6JMSRNXC1vh/6jLRxs5Ii5X7Wn3XB8PVezS/fS
	ME/OHjFJeR3ebaXBI4SiMGdBRKkAlozAdhFwuHQC5f9lYUJMV5+Mbxp1D9ClTejdwOgfPJ/wXHS
	5cluDvnhRhyfj5ivk+6KsdhbEnNQwsyxmdGzKzdVuA1xeD+rpaN0jg7+gRqube7FWgBQfmowB53
	S1aNlMus7TP8UxC1sddRGVWHBR3O9eL1Ji552RRHHlYqbPVzknYlgDSG9A/ktu7Hhqw7fCbG4b2
	+X60IiLVSv5l4wQO4udGbeYsuzfGrR8TDfYXuRWgtEH677a5e1LVv6U3/Lsj5VqVfs6/IOTofuq
	Ti7osydMYZdco09VLIktn+7EmVk6XbTEfxefXUmlU6s6VRnQ69ZN0QscgM5kkfx47rZlnhqLlXu
	cENPIpYvfTCLIxAVK98r1KseNqXtcuPIkKp1K7G+RgVAnzzo+AE2C2rGljWXXTtoJgm/AGOVE=
X-Received: by 2002:a5d:5f8e:0:b0:45e:dacb:8885 with SMTP id ffacd0b85a97d-460217600f5mr10672512f8f.35.1780563011569;
        Thu, 04 Jun 2026 01:50:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm14846055f8f.16.2026.06.04.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:50:11 -0700 (PDT)
Date: Thu, 4 Jun 2026 09:50:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] net: b44: use ethtool_puts
Message-ID: <20260604095010.35476abb@pumpkin>
In-Reply-To: <20260531000334.388351-1-rosenp@gmail.com>
References: <20260531000334.388351-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:michael.chan@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EDB063E578

On Sat, 30 May 2026 17:03:34 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> There's a subtle error with the memcpy here, where b44_gstrings should
> not be dereferenced. Dereferening causes the following error with W=1:

The definition is:
static const char b44_gstrings[][ETH_GSTRING_LEN] = ...

There is nothing wrong with using memcpy().

> 
> In file included from drivers/net/ethernet/broadcom/b44.c:17:
> In file included from ./include/linux/module.h:18:
> In file included from ./include/linux/kmod.h:9:
> In file included from ./include/linux/umh.h:4:
> In file included from ./include/linux/gfp.h:7:
> In file included from ./include/linux/mmzone.h:8:
> In file included from ./include/linux/spinlock.h:56:
> In file included from ./include/linux/preempt.h:79:
> In file included from ./arch/powerpc/include/asm/preempt.h:5:
> In file included from ./include/asm-generic/preempt.h:5:
> In file included from ./include/linux/thread_info.h:23:
> In file included from ./arch/powerpc/include/asm/current.h:13:
> In file included from ./arch/powerpc/include/asm/paca.h:16:
> In file included from ./include/linux/string.h:386:
> ./include/linux/fortify-string.h:578:4: error: call to
> '__read_overflow2_field' declared with 'warning' attribute: detected read
> beyond size of field (2nd parameter); maybe use>
>   578 |                        __read_overflow2_field(q_size_field, size);
>       |                         ^
> 
> Instead of fixing the memcpy, use ethtool_puts, which is the proper
> helper for printing ethtool gstrings.

ethtool_puts() lets you pass short strings as well as ones that don't
contain a '\0' terminator.
It isn't needed here because all the strings are already padded.

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/b44.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
> index 90df02e0039c..f994636fbd5f 100644
> --- a/drivers/net/ethernet/broadcom/b44.c
> +++ b/drivers/net/ethernet/broadcom/b44.c
> @@ -2031,11 +2031,11 @@ static int b44_set_pauseparam(struct net_device *dev,
>  
>  static void b44_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  {
> -	switch(stringset) {
> -	case ETH_SS_STATS:
> -		memcpy(data, *b44_gstrings, sizeof(b44_gstrings));

Just remove the * or replace with an & - either is valid.
The existing code is reading b44_gstrings[0] so overruns into the following
strings.

-- David

> -		break;
> -	}
> +	if (stringset != ETH_SS_STATS)
> +		return;
> +
> +	for (int i = 0; i < ARRAY_SIZE(b44_gstrings); i++)
> +		ethtool_puts(&data, b44_gstrings[i]);
>  }
>  
>  static int b44_get_sset_count(struct net_device *dev, int sset)


