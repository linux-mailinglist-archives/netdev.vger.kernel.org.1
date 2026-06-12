Return-Path: <netdev+bounces-298517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8vFJBrbCK2olEgQAu9opvQ
	(envelope-from <netdev+bounces-298517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:26:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 648E9677CBF
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:26:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b="AK/4S+RG";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298517-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298517-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345A430393A1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A96368277;
	Fri, 12 Jun 2026 08:26:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7489536405A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 08:26:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781252773; cv=none; b=nDt5UdsS8dhwb2DNjmmLXli4Wk+b35F4jo10wsv4cRP2mRnIIU5/qyJEi5m4wYDXEyPOuWIqiIeMngetnxUR+vAlZ7WxWygq9+jXm6U6R2ImJDxZvuXUb277YAEM1FMUGy4TWsqzFTPcCyt7NCj/Ml00w7CNX7R1bFucNxhTigE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781252773; c=relaxed/simple;
	bh=yunkd6Bn6c/Mt2Vp7v8ZZtH4GNK+T67PIaiWUEUNy+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf1RL1ZMZMq8l1kpe4Qs9wxJC1LaCd/tmHdXgzEXBekohGI8X4tVKFCQieXsbmASaIvMdTlLfbvYJ5MT0uIfkHZRgPTvaqY2qGL3UsenWxf1qlZTAdi574l6iGUiRDUR5wi6trXU9anAnM9giefFVSgq7cwkbDpGZxxyFQAzqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=AK/4S+RG; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-46066e640easo374206f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781252767; x=1781857567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kk7PFzycgY3eDC9P54eIgjAqx/pkRN2cuIOJlvdAVik=;
        b=AK/4S+RGVPvvD6YWyYzAi/N2n90VGDFTltZujqfDN1BvwuTNxeD79Oa0q90j6/nat9
         ZrSgiF0Px1r3b5GZTjRx90q84gGsZqHYclluWDW3TPGKY1sIQ2nkiwY8j/Knj0bclHsq
         UDGGc1DYdghSf59vKZb9NrOWdIcadigcyi6chhGee0zWiJp8mzNDcBdI2s8BqwJuKnYB
         K6gA/87aFKE+vEepg0o6q+5mCxgXMm0+2uC+TrohSWmFMPaoAcunHt1qQUFS6jbTMj7y
         2ffQ91CfNkjUuvQeiaiRm+LN1kDqeTU0VxNnIj0bvLYCVwl3jnW8EomGiNuSJMyT6mmA
         Bo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781252767; x=1781857567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk7PFzycgY3eDC9P54eIgjAqx/pkRN2cuIOJlvdAVik=;
        b=ir7XWMndptWKcXFPTySJtrjpImELak0/jqd5oniedMbNM5+exs2JOFkju2zjB3bH3q
         SavDPMO7RyNEV11YDuxgtjH8bNna/YgWA2r9LPO/kE6vThF34Fr6UZEtF/oP4Tb8A8bT
         wCzX6H9h6K5ouOQOLXsZ/utRF2vlWRmwZomwcqxYam1nLuY17xXTG++l900vlOyM1NaM
         Td7jFlm/p6g3tKBWTBWKOK8ajELUvjhZ89Cj7t/bHo8rp5rchWDzyMtFlqllYyWDVso4
         YwUrqPoHkpxlz/BeRYWhU6BUszgr6W2RgH54iu4+fImk031CV3nypBezQq7FCcktXB6E
         e1yg==
X-Forwarded-Encrypted: i=1; AFNElJ9aLc/iHgX2ZvfuT+0L3qzRR2A07rLXoYo70Zx7TeN3C4fUwGW19zQjltoCZSd3K3yYuScs76I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/gXgbe2BHArTJh5nmyrlvPeCyixI78lLIVwS/qXQY73w0cip
	TXnb2M8YFLy+Hivs7aiAo/CW5EZGr1FGqAZbH8skRRUa75+zAk/nBJvcq8dhs66hi3I=
X-Gm-Gg: Acq92OHRJ/9S0OaQiXr0evpp7OJxe5T8jvh4qkwiEXmNK2ThzxvNJMEST/LtwvyoxQl
	Iq5VPWeElVQ7Id8D/hS8dWLFcNWyOooEnhrmi4RBBkcOZaWpiIfMlgvjUIACMhDXH+RZt3ovn7N
	G8H+7zBeWqiFACLvJBftNG45h+4g0vh1Z8ujwT/bP6SU/+QXpnsnNs3phKvkP1xgwdgjQRuWfem
	KR/FmBc5e0hNEpDFm08FjarafceVUsA4WOSkbL+mygpArBLUfqbMsJiXnqlY7yxKV1UHnQ+x04V
	4jjGOQS8JOnoqd/4SKTc7h8QCnWe5cUXDXkw2i29887Fa/6SqohWMxEZ4sIwNZWFNE6mydtpYlX
	VRIUKUkcRDeRUAlb+Tucji/CXF7c3Yc/OS30e0h6VZJUj0u3tZhXmwxJxqbJfUr9BaJqJtO2/Oq
	BduO8TPQ0iljLH1gL6LauDKGQj/1tk5/E=
X-Received: by 2002:a05:6000:2087:b0:45f:f142:d569 with SMTP id ffacd0b85a97d-4606db8dd7fmr2332029f8f.15.1781252766905;
        Fri, 12 Jun 2026 01:26:06 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2c3fcfsm3525465f8f.26.2026.06.12.01.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 01:26:06 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:26:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] devlink: fix refcount leak in devlink_nl_reload_doit()
Message-ID: <aivCLGzQHYTFPcey@FV6GYCPJ69>
References: <20260611162557.98150-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611162557.98150-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298517-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iscas.ac.cn:email,FV6GYCPJ69:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 648E9677CBF

Thu, Jun 11, 2026 at 06:25:57PM +0200, vulab@iscas.ac.cn wrote:
>When devlink_nl_reload_doit() is asked to change network namespace
>(via DEVLINK_ATTR_NETNS_*) but the reload action is not
>DEVLINK_RELOAD_ACTION_DRIVER_REINIT, it calls devlink_netns_get()
>which acquires a reference on the destination net namespace. Then,
>after detecting that namespace change is only supported for reinit
>action, it returns -EOPNOTSUPP without releasing the reference, thus
>leaking the net namespace.
>
>Fix the leak by releasing the reference with put_net() before
>returning the error, for example by adding it directly on that error
>path. A cleaner alternative is to introduce a common cleanup label
>that performs the put_net() if the pointer is non-NULL.

This para is very odd. Your AI is probably providing you 2 alternatives.
Please adjust. Fix looks fine to me as is.


>
>Cc: stable@vger.kernel.org

No need to cc that, afaik.


>Fixes: 2edd92570441 ("devlink: don't allow to change net namespace for FW_ACTIVATE reload action")
>Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
>---
> net/devlink/dev.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/devlink/dev.c b/net/devlink/dev.c
>index 57b2b8f03543..fd5633fa88ec 100644
>--- a/net/devlink/dev.c
>+++ b/net/devlink/dev.c
>@@ -578,6 +578,7 @@ int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
> 		    action != DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
> 			NL_SET_ERR_MSG_MOD(info->extack,
> 					   "Changing namespace is only supported for reinit action");
>+			put_net(dest_net);
> 			return -EOPNOTSUPP;
> 		}
> 	}
>-- 
>2.50.1 (Apple Git-155)
>

