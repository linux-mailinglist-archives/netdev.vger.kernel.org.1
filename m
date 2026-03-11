Return-Path: <netdev+bounces-266438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLcxG03bsGmHnwIAu9opvQ
	(envelope-from <netdev+bounces-266438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:02:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AEE25B3DC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE19330743F7
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149F2F3C3E;
	Wed, 11 Mar 2026 03:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtphgnUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468B1D5174
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198151; cv=none; b=S9WU03GW7u3bzujz6Nwa39R6eQ82mb9VkgNMRisT2ae8WxJjuA2gzxYkmnF4MwqWosAh0wXHrouxxeAxZmHjBj/b5LrlfHBAfeuGb+ISkwgW2+gtF/1Bz7JWEUVpjhUhShJEVaB2pNBa0oLOApaEgFL0WWrD2i9itebsJWfaB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198151; c=relaxed/simple;
	bh=mPp/K2GhcYeb1+cWEjjfMUOOqDfykcclJnqOVh6Hx4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTbXhJEf9tfJDj/CIILg+j3PdR68iMHvZkGXnd76vTbk2pmKksN6AcLPoCZcS3vfXCiQegKjtGAQJu+P2CBVw1QP+yq9+Zp2FJ0+tUehvkj8Y+pADoq4Djrw3qMRn+P8fM5d98NNy7VcZMo4tKoqS2xvWbc1jGfzSZ95+58mwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtphgnUG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35983877dc5so4568135a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773198150; x=1773802950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Evom+iUYo6uZan7knSuRApLIlU//ZridbfvXdJv+L0=;
        b=JtphgnUGxRamNJnUwHP8K4wMST+noai15dPl8Fr9CycKhyr2Ro+EDu0inEMwlD/IAw
         fwpWJ8N8171+c3YxefM5Dl98jbIZnSPWsd75lYyiUGRP+b12fTZoGWBl3BgKjfujSvbP
         7EMhSBCiTkGGQ6Ae47ujf0PvHqW6fS4ECSD3qiER+HA1gulI+fPBLj4kvs4+POsQrDob
         sF6jJQJ4hOF3UXWJLtLRKrdp8MkjBd8xBr9nmr/kX6joGXPowaYcTpkt8r/naF0yHkOH
         nqzmYuTCOeII2iGIsZsY+uW6lmJdr57bOIKkfJlqPw90i9FVQAdDCBuXRA4c8tFlLuwm
         FmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773198150; x=1773802950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Evom+iUYo6uZan7knSuRApLIlU//ZridbfvXdJv+L0=;
        b=UfRrA/sycnBSOIVF/UksgVNGcpkHlxKsGNbHtd3ynhfOjVq2KsW4wcWnsqGoZv4Zqd
         27ilzq/gi9UFttI03SWQvAC90gBOl7V7RmINUcu9N7ZUkpXiUJdFqUsIveBfbjbjBUkc
         /xSg0fD0ju1Gtvqt5Acqotx9tbt4vAGu8GKx2wlZTVdEIGtLGClpsNo3zAH4fnHU+qGp
         OPBFMqU13Ka0AZXfn5TmgG7k5Y43EBX1rcg7c4xxIuf5sRntWe9GeaLm2/Pxh/MP2Y4+
         tu8U1Cb/qxxtrxp71LtezkucvGd2jOXy3cNPs2VOYfhvp9mAu9Xw7XTFdIu3mrYwKVSU
         r5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXQt4xg8o4NHTSAQb8riqVhl/HSRkuona5BXa7zyPLu9c1dt5vo1gY7im/ehEVbYwoSWML/VGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEh+acpkKTvsCs2K9jwyzs6B1UdQcgag1JObTnymR9U6IIeL6
	LB2ep1HIsFyVqpbHAhfYX6lIW+ATdbqfoPpRHKufPSjOm1rT20TLBqN1
X-Gm-Gg: ATEYQzx2+EGSQ71nwOcaXrAuLMPwFDM3ayRJ8V1ptAbOsEedSGLgQq+nxJZegSEhVf3
	FL2FUA34+efgDmJ63wEtxhSqNAgMpD/Sy0S8H2M5xK0XQrlisORfneY74QEILz5W0JmSw5PBWhj
	L5l8Y2C4RYy7zZzDQystk96NRVUSMipu3tk8FhuqEWucOI65qL1Jzi5yNrctt8dmQAxkqAaonPv
	2+ddjvZQOkRLsd39tSK1+k24ygq0pPN/+0/tJoQTl22/Kgac0iVU4frtGOj/70aF5koNZZ5ukD5
	J+K6WSAYdaVOCUkDYdCgdsifxTS5ODZjifRrwf8l6URbKGPSpqzUsR//6euE9UPAT9l1NcfM0+Z
	h6y/F1zzhHeo7vmlXYh7STkcn5qMhfkiq/6y9cs+8V14VLNxd/4rHvnP2Yc+WvxnxATDi3eIK8E
	Jw8JuDKyc5yhRieQv7gxybBzNQEohVaFbylqhKSkUnLxdbilH1rSlS
X-Received: by 2002:a17:90a:d2c8:b0:359:974a:b73d with SMTP id 98e67ed59e1d1-35a01a99cbcmr981954a91.35.1773198149923;
        Tue, 10 Mar 2026 20:02:29 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e7a2edsm488911a91.7.2026.03.10.20.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:02:29 -0700 (PDT)
Date: Wed, 11 Mar 2026 12:02:20 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, v4bel@gmail.com,
	henrik.bjoernlund@microchip.com, horatiu.vultur@microchip.com,
	nikolay@nvidia.com, sd@queasysnail.net
Subject: Re: [PATCH net] bridge: cfm: Fix race condition in peer_mep deletion
Message-ID: <abDbPJ5nZ1u9fZRi@v4bel>
References: <abBgYT5K_FI9rD1a@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBgYT5K_FI9rD1a@v4bel>
X-Rspamd-Queue-Id: C3AEE25B3DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266438-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,microchip.com,nvidia.com,queasysnail.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 03:18:09AM +0900, Hyunwoo Kim wrote:
> When a peer MEP is being deleted, cancel_delayed_work_sync() is called
> on ccm_rx_dwork before freeing. However, br_cfm_frame_rx() runs in
> softirq context under rcu_read_lock (without RTNL) and can re-schedule
> ccm_rx_dwork via ccm_rx_timer_start() between cancel_delayed_work_sync()
> returning and kfree_rcu() being called.
> 
> The following is a simple race scenario:
> 
>            cpu0                                     cpu1
> 
> mep_delete_implementation()
>   cancel_delayed_work_sync(ccm_rx_dwork);
>                                            br_cfm_frame_rx()
>                                              // peer_mep still in hlist
>                                              if (peer_mep->ccm_defect)
>                                                ccm_rx_timer_start()
>                                                  queue_delayed_work(ccm_rx_dwork)
>   hlist_del_rcu(&peer_mep->head);
>   kfree_rcu(peer_mep, rcu);
>                                            ccm_rx_work_expired()
>                                              // on freed peer_mep
> 
> To prevent this, cancel_delayed_work_sync() is replaced with
> disable_delayed_work_sync() in both peer MEP deletion paths, so
> that subsequent queue_delayed_work() calls from br_cfm_frame_rx()
> are silently rejected.
> 
> The cc_peer_disable() helper retains cancel_delayed_work_sync()
> because it is also used for the CC enable/disable toggle path where
> the work must remain re-schedulable.
> 
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/bridge/br_cfm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_cfm.c b/net/bridge/br_cfm.c
> index 2c70fe47de38..118c7ea48c35 100644
> --- a/net/bridge/br_cfm.c
> +++ b/net/bridge/br_cfm.c
> @@ -576,7 +576,7 @@ static void mep_delete_implementation(struct net_bridge *br,
>  
>  	/* Empty and free peer MEP list */
>  	hlist_for_each_entry_safe(peer_mep, n_store, &mep->peer_mep_list, head) {
> -		cancel_delayed_work_sync(&peer_mep->ccm_rx_dwork);
> +		disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
>  		hlist_del_rcu(&peer_mep->head);
>  		kfree_rcu(peer_mep, rcu);
>  	}
> @@ -732,7 +732,7 @@ int br_cfm_cc_peer_mep_remove(struct net_bridge *br, const u32 instance,
>  		return -ENOENT;
>  	}
>  
> -	cc_peer_disable(peer_mep);
> +	disable_delayed_work_sync(&peer_mep->ccm_rx_dwork);
>  
>  	hlist_del_rcu(&peer_mep->head);
>  	kfree_rcu(peer_mep, rcu);
> -- 
> 2.43.0
> 

CC'ing the Fixes patch authors and Sabrina, who is familiar with this bug pattern.


Best regards,
Hyunwoo Kim

