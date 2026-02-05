Return-Path: <netdev+bounces-256921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEalDBUBhGkbwwMAu9opvQ
	(envelope-from <netdev+bounces-256921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:31:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1AEDFB5
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 046AD300334F
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 02:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6262836A0;
	Thu,  5 Feb 2026 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/v6TQrV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30227F18B
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 02:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258706; cv=none; b=JP0XO7RSQu+cKDVq/913zEzFB7mIhfFngoAOl66oQBo0nCxjvN6XaofGGdNgdm5I4XGldJQqKIpskM+CJLUJXj/H5uZqURPkPSrvfQ7xE6/8O4+VFIsG2r+w8LuiHoPb54NBcg51YvJ92ySuZ4nR79WU0V7fkFaKbcBjr/F1tOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258706; c=relaxed/simple;
	bh=w7KERoN540cx3QqhBuSU2wfOEQkv9V8bg8zZv6YIxl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPeb6vYBhT5uACI/x8NBY/UxvkaDjzbdyLd8W+t7IeARhre6iT6oPu3YPpvYfgkW9w81eXhKhy8HaLUkF0yo6au4AyV8HDyPbuynAVfQvNTU+QMoqACri9yoeqY3/n1cH/VKhIbY5n9MiaaBeeCMFR+KVeF9A5mrerLeHkcoH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/v6TQrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B084C4CEF7;
	Thu,  5 Feb 2026 02:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258706;
	bh=w7KERoN540cx3QqhBuSU2wfOEQkv9V8bg8zZv6YIxl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/v6TQrVjo1iceQxGgXGFCLTbxBycB8ilOVmis+MjwwERxt+lVM49ZHKTfbuMwi40
	 bKxkn89OYruGmyEOCSVs7uyp+gIM2iGvu8e3iZdHKqlV6F/svCC3KponicMCcPJQsp
	 CebhXnrwyuPsXolro41fTeo5rVVklP0VBzwKyH+TILQZXqstJCnh41dWms7xEnNn5A
	 gs9sjXDNv1W1XyQMgVug+acgF6XGqzmMkVnzxcCX+Jk0aPqlcuyNOkSr28AUyr5o5P
	 O9C3VodycfEitKNCmtiI2gFGYBv1pf4pgHEPbNChbd5myLp4pPooQZ/kMsw+FxtJGi
	 KOC6CDkghpcZw==
Date: Wed, 4 Feb 2026 18:31:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, davem@davemloft.net, guwen@linux.alibaba.com,
 lulie@linux.alibaba.com, hkallweit1@gmail.com, edumazet@google.com,
 lukas.bulwahn@redhat.com, andrew@lunn.ch, dong100@mucse.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org
Subject: Re: [net-next,v25,4/6] eea: create/destroy rx,tx queues for
 netdevice open and stop
Message-ID: <20260204183144.5c5941ed@kernel.org>
In-Reply-To: <1770205572.2731752-1-xuanzhuo@linux.alibaba.com>
References: <20260202090638.46836-1-xuanzhuo@linux.alibaba.com>
	<20260202090638.46836-5-xuanzhuo@linux.alibaba.com>
	<20260204040054.1698677-2-kuba@kernel.org>
	<20260203201237.35c5f756@kernel.org>
	<1770205572.2731752-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256921-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,linux.dev,davemloft.net,linux.alibaba.com,gmail.com,google.com,mucse.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2F1AEDFB5
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 19:46:12 +0800 Xuan Zhuo wrote:
> > I think AI is slightly confused here but so am I. I don't get where you
> > free he previous resources in this flow. The "bind_new_q_and_cfg" just
> > overrides stuff, who frees the old set of rings?  
> 
> 
> 	err = eea_alloc_rxtx_q_mem(ctx);
> 	if (err) {
> 		netdev_warn(enet->netdev,
> 			    "eea reset: alloc q failed. stop reset. err %d\n",
> 			    err);
> 		return err;
> 	}
> 
> 	eea_netdev_stop(enet->netdev); <---- here call eea_free_rxtx_q_mem

Ah, thanks for explaining.
FWIW when I write this sort of logic I use _stop() as "stop the HW"
hence the confusion. Should have read the code..

That said freeing the resources here will prevent you from going 
back to the old config. For instance the sysfs handling
(netif_set_real_num_queues()) could fail during increase.

Best way to implement this is to "swap" the resources between enet 
and ctx, so that you can go back.

