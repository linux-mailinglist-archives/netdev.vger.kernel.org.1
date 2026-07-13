Return-Path: <netdev+bounces-307059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MWpTOlOdVGoUoQMAu9opvQ
	(envelope-from <netdev+bounces-307059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1A5748839
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:09:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=gNxJ1O4E;
	dkim=pass header.d=redhat.com header.s=google header.b=slZhdoK7;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307059-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307059-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B9C3302F713
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9A3A451E;
	Mon, 13 Jul 2026 08:07:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361C335FF6E
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:07:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930055; cv=none; b=Do88FveCo6h4WAgGOkYSZ+mtTM3vq58CFaOfzD6ayiXO1YUE7hmieMfW1CvxYUWkzYzQrjvRil/emSnefCkUGP+2JQRVhiomggZGJpN6Z9pbn7vFTaA46F4O8ctqwcJ72medim+gFzqMejBWrrkuU5/BJid4Eb7OLdbRZvrPdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930055; c=relaxed/simple;
	bh=0IpsmfvEmMqkex7BPY7BGtGubPGVo/SskO3Sqpdp1Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWhOLS00TLeqQAuQUduJbqT5Gxxxs+gkQ4y8lXAXfN9x5KzlLJhkocdpfOx6U2Uqn+t9cSGEr7RBNBoe+F34jY7kE+12dRo8sqok/njMPgrTSEy18PAkC0rdlqWx3JjgaND6k1BkUmcQIPyShgR+hX5wwgDOnvPDqnT0dbmkUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNxJ1O4E; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=slZhdoK7; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdgI9eqUTq9TIeFzgPazf8q2VN2/VSVYVij24j7254c=;
	b=gNxJ1O4E5ZDSjekPJ3a6F5BSE+7KevDh/XhnzNggaNlxaVy7iD+3CVx7wboCN0qoVqIjZx
	qxhuJLDB9X0u6OtPYs9mIoH1twxpocC9eYiY1o68U5/mWNgpAJUsyt0LO49vzEOKfvDY4f
	yWRIgQ3ChAErSIPW6QjquYBLrIkBnzo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-zAL2LhN1N7mpzG1SKKuOrA-1; Mon, 13 Jul 2026 04:07:31 -0400
X-MC-Unique: zAL2LhN1N7mpzG1SKKuOrA-1
X-Mimecast-MFC-AGG-ID: zAL2LhN1N7mpzG1SKKuOrA_1783930051
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bdaf8549so28638505e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783930050; x=1784534850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rdgI9eqUTq9TIeFzgPazf8q2VN2/VSVYVij24j7254c=;
        b=slZhdoK7avZV3vJ/K6LtPRLtxdu0rSCuRE5v5+m7VbMiML9sTOgXm7DURkAZR2IVtm
         9Vc0cclcGodkS76zxTyH7ADg0D/QH1Ssxb0aJwyeCEXu7A8ZBhqkH369VgFSOht3p5Tl
         4t0vrFJydTW5/3BvhVmI995bVaIw2A/oeyxel0Z9hxzCStD2XQZDMAwWZnHuKWk/jqpo
         kqU4lthdV5V2Of88/e5v8r4B1kWYDwBPJAv/qabAQfWBN/KssqxsdDkXEWAPYFy98Rdn
         WZrql1AIDydUyeHqOzsYvcHU9+fu4W/YaTUh2ogwaxhSTAfQParQEayirF5bFAfhUy4W
         PnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783930050; x=1784534850;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdgI9eqUTq9TIeFzgPazf8q2VN2/VSVYVij24j7254c=;
        b=Onmb3DZgGNQhJYbGc1wy6a1SoOx14NyzOtfwWtqzQtSWKZyfoFgZ1pOw3pBpwVBcQo
         iMd7TeXWWdp7tP9cCbzpkEaZEC3pW6F1+qPXPO/voUUaYcXHRpAdYWdTnQnb++K9Tnb8
         ykqYvXyVqkkEVlggjln7dwWqiO1KrZF87+1K21LlsFW+FO5DI9NigcwIwMCdv+pt4uTr
         zgXaR6/daS9V4u1BLXlhMmm2sENktI1uR0AxKZFUokjQtwLwWHqzCR3E+JIad70PCg8x
         sjDeyYdx+Ux01e4pmMaOFw7ZN+qXf5wNk/WEUJPRVN+kXqdB1SUrhAvEry/iakGKlNMX
         4XzQ==
X-Gm-Message-State: AOJu0YyxGSccKlClOJGCl4YvzmOmzKPc5n//WlMvv/ZKE4mFOIsT3GWG
	vUxF80T7TZy5rqgmqBudsp6D8g/TIcjRfnGlvjaualJXNv592P/FxGiKtFq97kUb5ai2Jd7TVYT
	qDZBPTWglUaSJ+Y5npz5Xf3sDbIwhtvXo6KdICrqaJcJGmbw8oERKV1lhfA==
X-Gm-Gg: AfdE7cm7eHsCDHrTLFD6bnukqa6lz7oWaCrey6C1qOJhmmLV93Sg8GTm5n2gq6mUsf8
	e5bD6SCPNjQEORDOoZQT5YieIjLYQLXU0+d1aqFK808OqhyhuHvZn64XxG/iUqbtsdCazHwyOYp
	oatJrdZttAA+HAPArSWPLT6H4REijn2SYUJLT1zWhLsx6jghiJRkqUoApL/DvpQqW/62K90F3yv
	xVtXHO2GH0Mdlyiu2XR4iIndLuNSnKFkYxUWNymgXkHGxHYrbHVtgcB/SiYyLkw7gmrjY4/OoKU
	sJU3yZr1Zu0/h3tvw6SbSL+LRDBtCwJsqNnDhYTmbK6hb3NgMnbdZlZFY4OyRMVshlGCR7WPOxF
	X3DI2jGiHqg==
X-Received: by 2002:a05:600c:3d8b:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493f8818e5dmr86384255e9.20.1783930050581;
        Mon, 13 Jul 2026 01:07:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8b:b0:48a:906b:14ca with SMTP id 5b1f17b1804b1-493f8818e5dmr86383885e9.20.1783930050003;
        Mon, 13 Jul 2026 01:07:30 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm367350355e9.8.2026.07.13.01.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 01:07:29 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:07:28 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	zdi-disclosures@trendmicro.com, security@kernel.org,
	victor@mojatatu.com, jiri@resnulli.us
Subject: Re: [PATCH] net/sched: act_tunnel_key: Defer dst_release to RCU
 callback
Message-ID: <alScwJe_d_QXfBs_@dcaratti.users.ipa.redhat.com>
References: <20260711150537.7946-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711150537.7946-1-jhs@mojatatu.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:zdi-disclosures@trendmicro.com,m:security@kernel.org,m:victor@mojatatu.com,m:jiri@resnulli.us,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F1A5748839

On Sat, Jul 11, 2026 at 11:05:37AM -0400, Jamal Hadi Salim wrote:
> Fix a race-condition use-after-free in tunnel_key_release_params().
> 
> The function releases the metadata_dst of the old params synchronously
> via dst_release() while deferring the params struct free with
> kfree_rcu(). A concurrent tunnel_key_act() reader on the datapath may
> still hold the old params pointer (under rcu_read_lock_bh) and proceed
> to call dst_clone(&params->tcft_enc_metadata->dst) after the writer's
> dst_release has already pushed the dst's rcuref to RCUREF_DEAD.

hello Jamal and Victor,

[...]
 
> Fix by moving dst_release() into a custom RCU callback that runs
> after the grace period, matching the lifetime of the containing
> params struct.  Readers in the datapath therefore always find a live
> rcuref when calling dst_clone().
> 
> Fixes: 9174c3df1cd18 ("net/sched: act_tunnel_key: fix memory leak in case of action replace")
> Reported-by: zdi-disclosures@trendmicro.com
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/act_tunnel_key.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Thanks for this patch, LGTM!

Reviewed-by: Davide Caratti <dcaratti@redhat.com>


