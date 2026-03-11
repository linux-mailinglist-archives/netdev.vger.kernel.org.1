Return-Path: <netdev+bounces-266610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FY0N/ZEsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:33:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86204262422
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 132223017DDE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004313CEBB6;
	Wed, 11 Mar 2026 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eo2cDWuo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E73CEB8C
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225121; cv=none; b=YTmOQi1WFWQB7ibZqqA4IHa8qSk19yIZf+HrYfzh57ZDApXPvn/OANSyC6O6/yXClCJKBm70lm799cr012yd9w3ihMWBV5rgNFuVQbbIFU1BlOjc/pBRsPUXtQXJrgQY3TDLnc4iyIPas5DgSlzvTKxk1sH/Uv4xJPKtscp9GkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225121; c=relaxed/simple;
	bh=fyQi05yi+YGHZZzn8QiQsCM+51WDtHDJDoJqobfhF3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVmh2z5rrsTmN9o70TSpTSvR0ljhwrXcPXusF0uT/gbobMvi03kMSh81n2DzXcZYEsHIe/qhnNjVuNAMKS7kVubJ9J9zUHgYOt4L5f/F1vF8GZKM2UcrP+EyrkQxuKAe+vXS1hdq3VPOST8aeQXLZEjqmr0hb6+qNVXgQZdSSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eo2cDWuo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-829b2018c94so2739478b3a.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773225120; x=1773829920; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jbZwl7Vu7mvZt6WrQMimlStcWrx+rKxwiIubtts6C+E=;
        b=Eo2cDWuol05Emf7RMl0ApqtSfkeC0bsVV2qxGT2C4o8pbPF4uL2gDsTgwKRBv5RLRw
         KKA9TEI7sn0ZzgG5PDxQI2ey7Hgnqr1gSWCN+MWxW11aT0OPZsrvNa6P7pHV2FAZZ8Ne
         IIvoMM0SCB6q1lOoqD6WVP73xTloww0ZuFaBll+FGosMJC0+V+jiXYgQA1MLwuDbGkqs
         8fuwlXNh2zadzF3PfAHvDhj/9+Fd0skiw2n1mJ+y04AXKGqJ0W4CO2DfUMPXD1/IkqBK
         tY+ciQ1wAdeFQjcTthHYgx22k/pEexbPGplviGOKBrenmiDZTjjMSaaEjD760ZvzoLfN
         Bf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225120; x=1773829920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbZwl7Vu7mvZt6WrQMimlStcWrx+rKxwiIubtts6C+E=;
        b=qhV3P++xKF1z7UBEQ/3PpHKWBeRt4Mjmdt7vzQxHh0xHcxnSQKVaElICrFe1ikVlu7
         b1DrebaTojb/1o4s3tV/CYaSMS/OAsjXTo5g8go+KLXHY1hLEYKaFo9RqVH406QtD2QS
         9CiIkfhmNZZhcOKs25RSEEOCMStt6YOekZ7PW5k0qgd/hQUSGl2HLaGrtHk9A/Hms1Cp
         w9MiGm3gMYAEyk+PVexFZiGXnHtCCx2wBt+vcgW1Y9zITq0jLFJvSQed95Qhvj8uC0qI
         4Pp3Moks0nc3fEYH/ruuTIZ+nqW1XcI8R2uIZntp4Cq7izRoTWG58D1c00ntjlMOlzcI
         ARmg==
X-Forwarded-Encrypted: i=1; AJvYcCXplyoOvQsjewhX+GQEgoyeTiKftrDzGDKGDOxu21EGJb967Ihu+aVe7nO0fwCszCslxbKk8Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtpfA0e+iqwcYXnaUPW3reY6MXXXB86xQR+XxWKKecdI81/oY
	sMmf5VmkTF8kO94r72zupDbzXxiwx3c2BFbQLr08yExQq5HpFBPBR4/i
X-Gm-Gg: ATEYQzwi/xJ7TI91/Bs8rZiGKq7mEBdnqzAI79ddAkPTVipQovfA4BEgYdO/nIvdyfd
	EQDQQn/RT15lIMJIR2/rez6LBD5dd8QtNQso0Sl7Y+UkfNQmHomgoYXSMqWVIW/l/cGQkqSgRdR
	/Ycdaok01t02I/VnPqvFj6R02p56aXMo6shhFK7rm8VQfpUR4jfK1AO3Jn0OdeYjMYxRgy2HAh+
	QaeTPbhwIQT0hpUIdUEnjGQbWEcKLlI+JDzw5UzgBk4jUM+NrdUyDxirsXat1UBRl+hBeUbJsFQ
	5j+UWKGKFruMp/zpRKpkgriSVgFvJahnpnnVQlTpUpxS8a3jRjSdKBBqbjvfxW0s1YmvSVWH+sZ
	9lKLxxHLoo+3X20M2dL8740ETTxkEkAO+CHqUocNowLzJulJ/u4fNFl8jJn1eEghMCjA9aYWcc8
	808/KmJ1/MgT+76hj3At0YuR0tH6kc1da3Glgvi7h8Bw==
X-Received: by 2002:a05:6a00:985:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-829f6ebbbf0mr2145569b3a.24.1773225119879;
        Wed, 11 Mar 2026 03:31:59 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6f26dbasm2024859b3a.43.2026.03.11.03.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:31:59 -0700 (PDT)
Date: Wed, 11 Mar 2026 19:31:51 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eyal Birger <eyal.birger@gmail.com>, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in
 xfrm_nat_keepalive_net_fini()
Message-ID: <abFEl98lHzRIORgb@v4bel>
References: <abBf_R81PYmafhWv@v4bel>
 <abCh2CgVS3Uw7W-_@krikkit>
 <CAHsH6GtYpoowPJe5VWMcm=CCdUernc1q-Sk6HznXxMy7LDAmrQ@mail.gmail.com>
 <abE1Q7BMvZ1l14jF@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abE1Q7BMvZ1l14jF@krikkit>
X-Rspamd-Queue-Id: 86204262422
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266610-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 10:26:27AM +0100, Sabrina Dubroca wrote:
> 2026-03-10, 17:14:19 -0700, Eyal Birger wrote:
> > Hi,
> > 
> > On Tue, Mar 10, 2026 at 3:57 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > >
> > > Please also CC the author, and maybe additional contributors, of the
> > > patch that introduced the problem you're fixing.
> > >
> > > 2026-03-11, 03:16:29 +0900, Hyunwoo Kim wrote:
> > > > After cancel_delayed_work_sync() is called from
> > > > xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> > > > states via __xfrm_state_delete(), which calls
> > > > xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.
> > >
> > > Eyal, I'm wondering why __xfrm_state_delete() calls
> > > xfrm_nat_keepalive_state_updated(). At this point the state has been
> > > removed from the walk list so nat_keepalive_work() won't do
> > > anything. Am I missing something?
> > 
> > I don't remember for sure, but I think the idea was to have the work
> > run "now" so that when deleting the last nat-keepalive state it
> > won't run in the future, and in general to refresh the interval and
> > not wait for the next iteration.
> > 
> > Eyal.
> 
> Ok. I thought about this, but I'm not seeing the benefit of doing
> that. Assuming we're deleting just this one state, the next run will
> process all the remaining states in the same way, whether it happens
> right now or at the previously scheduled time:
> 
>  - if the next run was needed by the peer we're deleting, not much
>    changes except that we're recomputing the delay earlier than
>    otherwise (right now instead of when deleted_state's interval runs
>    out)
> 
>  - if some other state was the first to need a keepalive, we do a run
>    for nothing
> 
> So I think we could drop the xfrm_nat_keepalive_state_updated call
> from __xfrm_state_delete.
> 
> 
> @Hyunwoo here again I'm not opposed to s/cancel/disable/, it makes
> sense to use disable_ in a "destruct" operation where we don't plan to
> need the work again. But AFAICT this schedule_delayed_work isn't
> really useful.

Thank you for the review. 
Should I submit a v2 patch that removes the 
xfrm_nat_keepalive_state_updated() call from __xfrm_state_delete()?


Best regards,
Hyunwoo Kim

