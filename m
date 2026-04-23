Return-Path: <netdev+bounces-280664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLt6Gr7Y6WmglQIAu9opvQ
	(envelope-from <netdev+bounces-280664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66144E8DF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D838C3002D3A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C13DE438;
	Thu, 23 Apr 2026 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P50L9eOl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrXh+vPr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645333644CE
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933048; cv=none; b=gqWm22cNC7lVYEK4yUpB4GSPM8q31EM2Wmripipg7T0rKSnzjgaCIs4Fkldu4HqLgRIA67RAmkmPf2Lk4d4FPEm3U2w+Jo0TU6o8C5WsZPaW2UupmXkJdoQMNh3zuFXvFF1oNyCgE+UNwmop0hGVd1O2CtFiXRKAm7uIklXCvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933048; c=relaxed/simple;
	bh=HtQGa4h/mM8qaFVtVqCiksqWvvknewStgG7bDuVnMc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeKfHnh+hVhZPc9THTfToQyXFQcUObmKoQpIfyCS7mTlT5JMFtKztOkFqGGIyuEEmuZZackyofHojTSHzvfAe8zAy5HtwwrH0PO/9QHrekvWXI1Oib1fhrHDO4qFPMfM3LDnaEy77LLxZ2UDTzKDZxOr0d5d9RomXOak3BIPZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P50L9eOl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrXh+vPr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776933045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLQ2QJLY+AQR6FFwHQfI1wULr2cHcwHy9LUPLxUKoMQ=;
	b=P50L9eOlRbhoB3L+jCQk4RLbT4C0Id43EMbtCLnHOWX9BNxUfYIVA5t6UC+lLXXUDhSwTa
	GBHyTBUpktPQYnKkqvSgHcswzp1BoNm1X/mubw+BGpozJUIJTopLl2tvwxytNtDDmadTjf
	uD+NwrWxJhLR3R+FwtWSr1gduv3G33s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-3wYCuIXHMlaqgMOKQz7hdA-1; Thu, 23 Apr 2026 04:30:42 -0400
X-MC-Unique: 3wYCuIXHMlaqgMOKQz7hdA-1
X-Mimecast-MFC-AGG-ID: 3wYCuIXHMlaqgMOKQz7hdA_1776933042
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a55ecc32cso23178485e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776933041; x=1777537841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gLQ2QJLY+AQR6FFwHQfI1wULr2cHcwHy9LUPLxUKoMQ=;
        b=BrXh+vPrmm0+X989qfqxefjqytTItrmNJOqlWvDJo/Rz4Jgg1X5qVN82t7B1mXFkMw
         bB0uBTobl5wgzfPDATI4CxPQqJv+VRoPQInJP4vw/MMuuYY3UW0BCLOdEL6H8xkDmayE
         u8Jre/a9OCw0EPvq45kjf8QgnUpdbKwHLsgFRNpAxl3QQushnReyxrNpXm4JMpuojRtK
         mQsDER/CIcwdfnIcW+ggPnsu5qwv8PZvszq4/BnhxZbTpwTJB7ptqwyHr7xc3qLVaRJ9
         cGQElQYUvXuzNURKgMUUi3GphinSQ7C8SXiBfM00hNUnIWXU90HcJU52rhDzllrUAt7y
         rCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933041; x=1777537841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLQ2QJLY+AQR6FFwHQfI1wULr2cHcwHy9LUPLxUKoMQ=;
        b=FMh6sNSgVRESbTmyllOqWTfloi9HUwf40fidtNAFioM7wws0c200UClCWByD8aKrvO
         WGOtIRrAQnb8MjASX5mUzUijliq7P26WWyVxsgaW4k/24vF9cvpRy+pKAC1vpcaL/lRw
         FqPV+APSkeQv3PhLMLn65e6ZpQuGxfgwdaflci9W6/rNCfLupmiJq+pnC9Yb3fDn4gZm
         Yxcn5ivtBgl27WRnjXJHo6suZa+97MC8SaFkokvGKTftG6j/bjk3K/X+e2sVDYF9C3HI
         07hYVEFsSz0nRaL/7MpdXuFnT1Sban0rHovy6go5JRaPOGqaZ/y6/Nnu1VoraJeeJRrG
         9cFg==
X-Forwarded-Encrypted: i=1; AFNElJ+5gOA6LTipj1xLCPIyPeTiyoGiBxmlGGA976d6v78zrZo/QEPfNCugY6b4fj66GuFUWmdCsFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbY3ui66gaqiO/VIFUSCa8Qg7+W0ZXF1BAOYIuQic/GdckmYz
	At6mrXM3wSdx2xfG4L7R1eQatl58m9Knjc5XSk613ZSM2nT7Z+vlhK2Iq0klG19ciKxd07tj/N5
	ZTKvjntM8WcXeacDy8YVTd0j2FI32vX5cnjimAso1mvC+RJjadubWMCtIeg==
X-Gm-Gg: AeBDievgSCgGfC/uW6k1c5CKDeY1/UIKAZD0rg4hV2wXG1NZO4v9OBfrivb1MjutCQm
	EQzpBYGh94k+rU3X3fN6tZTtH+wfPfDofWtzjoh1ZVXPuNoKDz69iXSxCDe0V7Nu/91x6CBGmG8
	wYomR3Q9B16PV/1wjdPkmf17F4WLztooe1TD4n7FQz2EZj38SHDQAmDLwva086w5y67EIZV/qYr
	5mKsAyE3ZrgN2YehT6P5enEM4yPcObuhAfrHmfc6qDBVFZI0XAyy6V0uGMfTgLGhK9f7dyUkTbK
	9c0xugsuvWYp0MsX+ds0he+xhnPj8/39u+Np2VYIG5HGsNXL8Pdp0GnkT1bmZEHJEs/rCko/ZeC
	fXDSwGEPThYxP+4PuqpkMrd/bwBUFPTzwBRIT7SA9J2f8iR+S53IWqR2g626FBKlJlWg=
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488fb73aa3bmr388953925e9.3.1776933041320;
        Thu, 23 Apr 2026 01:30:41 -0700 (PDT)
X-Received: by 2002:a05:600c:64c7:b0:488:a2ac:a334 with SMTP id 5b1f17b1804b1-488fb73aa3bmr388952835e9.3.1776933040577;
        Thu, 23 Apr 2026 01:30:40 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb77b001sm238148475e9.3.2026.04.23.01.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 01:30:40 -0700 (PDT)
Message-ID: <31829d8e-f760-4460-8f38-613f26206d87@redhat.com>
Date: Thu, 23 Apr 2026 10:30:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
To: Daniel Golle <daniel@makrotopia.org>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Frank Wunderlich <frank.wunderlich@linux.dev>,
 John Crispin <john@phrozen.org>
References: <58aff8b5b1d691872342a6ffd3315f27854788a6.1776595131.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <58aff8b5b1d691872342a6ffd3315f27854788a6.1776595131.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280664-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,arinc9.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arinc9.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,makrotopia.org:email]
X-Rspamd-Queue-Id: AC66144E8DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 12:43 PM, Daniel Golle wrote:
> The .get_stats64 callback runs in atomic context, but on
> MDIO-connected switches every register read acquires the MDIO bus
> mutex, which can sleep:
> [   12.645973] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:609
> [   12.654442] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 759, name: grep
> [   12.663377] preempt_count: 0, expected: 0
> [   12.667410] RCU nest depth: 1, expected: 0
> [   12.671511] INFO: lockdep is turned off.
> [   12.675441] CPU: 0 UID: 0 PID: 759 Comm: grep Tainted: G S      W           7.0.0+ #0 PREEMPT
> [   12.675453] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [   12.675456] Hardware name: Bananapi BPI-R64 (DT)
> [   12.675459] Call trace:
> [   12.675462]  show_stack+0x14/0x1c (C)
> [   12.675477]  dump_stack_lvl+0x68/0x8c
> [   12.675487]  dump_stack+0x14/0x1c
> [   12.675495]  __might_resched+0x14c/0x220
> [   12.675504]  __might_sleep+0x44/0x80
> [   12.675511]  __mutex_lock+0x50/0xb10
> [   12.675523]  mutex_lock_nested+0x20/0x30
> [   12.675532]  mt7530_get_stats64+0x40/0x2ac
> [   12.675542]  dsa_user_get_stats64+0x2c/0x40
> [   12.675553]  dev_get_stats+0x44/0x1e0
> [   12.675564]  dev_seq_printf_stats+0x24/0xe0
> [   12.675575]  dev_seq_show+0x14/0x3c
> [   12.675583]  seq_read_iter+0x37c/0x480
> [   12.675595]  seq_read+0xd0/0xec
> [   12.675605]  proc_reg_read+0x94/0xe4
> [   12.675615]  vfs_read+0x98/0x29c
> [   12.675625]  ksys_read+0x54/0xdc
> [   12.675633]  __arm64_sys_read+0x18/0x20
> [   12.675642]  invoke_syscall.constprop.0+0x54/0xec
> [   12.675653]  do_el0_svc+0x3c/0xb4
> [   12.675662]  el0_svc+0x38/0x200
> [   12.675670]  el0t_64_sync_handler+0x98/0xdc
> [   12.675679]  el0t_64_sync+0x158/0x15c
> 
> For MDIO-connected switches, poll MIB counters asynchronously using a
> delayed workqueue every second and let .get_stats64 return the cached
> values under a spinlock. A mod_delayed_work() call on each read
> triggers an immediate refresh so counters stay responsive when queried
> more frequently.
> 
> MMIO-connected switches (MT7988, EN7581, AN7583) are not affected
> because their regmap does not sleep, so they continue to read MIB
> counters directly in .get_stats64.
> 
> Fixes: 88c810f35ed5 ("net: dsa: mt7530: implement .get_stats64")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2:
>  * use spin_lock_bh()/spin_unlock_bh() to prevent potential deadlock
>  * rate-limit mod_delayed_work() refresh to at most once per 100ms
>  * move cancel_delayed_work_sync() after dsa_unregister_switch()
>  * add mt753x_teardown() callback to cancel the stats work
>  * fix commit message
> 
>  drivers/net/dsa/mt7530.c | 66 ++++++++++++++++++++++++++++++++++++++--
>  drivers/net/dsa/mt7530.h |  8 +++++
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index b9423389c2ef0..8c1186ba2279b 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -25,6 +25,9 @@
>  
>  #include "mt7530.h"
>  
> +#define MT7530_STATS_POLL_INTERVAL	(1 * HZ)
> +#define MT7530_STATS_RATE_LIMIT		(HZ / 10)
> +
>  static struct mt753x_pcs *pcs_to_mt753x_pcs(struct phylink_pcs *pcs)
>  {
>  	return container_of(pcs, struct mt753x_pcs, pcs);
> @@ -906,10 +909,9 @@ static void mt7530_get_rmon_stats(struct dsa_switch *ds, int port,
>  	*ranges = mt7530_rmon_ranges;
>  }
>  
> -static void mt7530_get_stats64(struct dsa_switch *ds, int port,
> -			       struct rtnl_link_stats64 *storage)
> +static void mt7530_read_port_stats64(struct mt7530_priv *priv, int port,
> +				     struct rtnl_link_stats64 *storage)
>  {
> -	struct mt7530_priv *priv = ds->priv;
>  	uint64_t data;
>  
>  	/* MIB counter doesn't provide a FramesTransmittedOK but instead
> @@ -951,6 +953,45 @@ static void mt7530_get_stats64(struct dsa_switch *ds, int port,
>  			       &storage->rx_crc_errors);
>  }
>  
> +static void mt7530_stats_poll(struct work_struct *work)
> +{
> +	struct mt7530_priv *priv = container_of(work, struct mt7530_priv,
> +						stats_work.work);
> +	struct rtnl_link_stats64 stats = {};
> +	struct dsa_port *dp;
> +	int port;
> +
> +	dsa_switch_for_each_user_port(dp, priv->ds) {
> +		port = dp->index;
> +
> +		mt7530_read_port_stats64(priv, port, &stats);
> +
> +		spin_lock_bh(&priv->stats_lock);
> +		priv->ports[port].stats = stats;
> +		spin_unlock_bh(&priv->stats_lock);
> +	}
> +
> +	priv->stats_last = jiffies;
> +	schedule_delayed_work(&priv->stats_work,
> +			      MT7530_STATS_POLL_INTERVAL);
> +}
> +
> +static void mt7530_get_stats64(struct dsa_switch *ds, int port,
> +			       struct rtnl_link_stats64 *storage)
> +{
> +	struct mt7530_priv *priv = ds->priv;
> +
> +	if (priv->bus) {
> +		spin_lock_bh(&priv->stats_lock);
> +		*storage = priv->ports[port].stats;
> +		spin_unlock_bh(&priv->stats_lock);
> +		if (time_after(jiffies, priv->stats_last + MT7530_STATS_RATE_LIMIT))

Since both the `stats_last` access and read are lockless, it looks like
they may race leading wrong/unexpected delay. I think it would be better
move both under the spinlock (yes, the write will happen multiple times
per stats update, I don't think it will matter).

/P


