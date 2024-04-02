Return-Path: <netdev+bounces-83990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 611128952FE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161B71F25F26
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C63611A;
	Tue,  2 Apr 2024 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vdjQ06Bg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA9179BC
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061098; cv=none; b=KoHwv+/NZR0P6krvuBNX3z95TTakVlxW5dLJhRXJqNWDC6Nn1HsYW28pTPlKmbVMYxH9WVuVZZT464fzKk5SeRGN4VnQ4fC8dUIorLUp7fvVJwunpWsnX9Q+x661BjGs1JVbLdlw6f3uQpv1U4emTtcMEN0tlOYsl0AfSnxRNcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061098; c=relaxed/simple;
	bh=u4TqurvDSYaDyG20izaiR67Vx1pyxp7agqu+p333Hp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYR40avmWevA1r3UgrylVl5dks818UjGOfqEAZqUNvtMuwtJst/TKfEzMf2pCVO/4trM5/upLihotkCE/XTvM7QPFc0r/GL3OuOthRPe6oIe9j9/IlCrpFDNTFjhIxh9hgm0hkuVRdPpW/qKFaTQC7VVaFdbdF96jBcQlvfa988=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vdjQ06Bg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4161bd0a4ecso3729535e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712061095; x=1712665895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8cPdJ2DC4s1xwaIRwwZa1ZKVK0gXJ5ygNpZWfwADz78=;
        b=vdjQ06Bg9SW73eO+9usQ+Y1Lij390Spo9PuqH7mBJZE1n1gaP6ESBW4HOFuoBTxdfw
         6WdqmFImO1SPczmEqIrZTavszcO/txTcM+mxNpVXlNeaxhMXjaK9rCVprRLcfEA3JBLM
         DuofQNQfuh1PnNlbP9vhEUMEXRHCgrxY4LrhFM6R2nxW2zE+79vrx3pI/usN7t6HRnMq
         Zhyyqmnktx8K+TKiqh2vTPzNDyVBQ2+jpz2eQqnkGv6ih56AiM04GNBJDiV40Z1GAf5e
         9semdD8xFVc2tUvgAvsiB2ffWMtOdaEk4beFiA6c4dlBsiH60Xt/824zT045VR7L8La5
         3grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061095; x=1712665895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cPdJ2DC4s1xwaIRwwZa1ZKVK0gXJ5ygNpZWfwADz78=;
        b=l6EaVv66cvfIGkkcPiT1WPebrAw3LGBtPwN0AtfS1Z+PBcVryrmUKqhgviP9sxTcwq
         uVvFCP72zK1v91HEH4Vr50/lvXZIWkD/UoljZXc9obk2R6gY+Bj7pa9BWQJ5XosAopJR
         ZEoq2Nh/7eH6slKbIrW1VLX9IcXVhFRzwIXKW4u+Gzr7KWX2rc0OAVKF6qt3u/9KK1aE
         lbRDrIJyRxAv1qsl0ogn6wfmerPUDl09qIUtcEVcSiQ+TQ7mzL1JQnCMcdTsahXEjBXg
         8bVoJUF68ouACRs+YU1YSIFTQw8MVIHx/ZUwFL1GLYtyQ8XoPHekSUFcddoE56IVYfM9
         /uOw==
X-Gm-Message-State: AOJu0YyruW/v5/Sjbxj7uRdIGSg+hlpe+KUw6+MJQ8gOTTXLTw5Z/lMn
	mM9mfhLH5iKw+KFn57YfaymKOSaJIUbVywUrR7Hsa0voklG0OAjAL+8XFRF6ciUnEzfyxicD/QS
	a8xs=
X-Google-Smtp-Source: AGHT+IH6F276XKPfLLESEg2CvuS6EJ1WD9Utu2NYmDX0fj9u/h9oL4neKmhrTYQ8XusSQEJO4uh4nQ==
X-Received: by 2002:a7b:cd0c:0:b0:414:610b:13c3 with SMTP id f12-20020a7bcd0c000000b00414610b13c3mr9266507wmj.27.1712061094941;
        Tue, 02 Apr 2024 05:31:34 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bq24-20020a5d5a18000000b0033e45930f35sm14305489wrb.6.2024.04.02.05.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:31:34 -0700 (PDT)
Date: Tue, 2 Apr 2024 14:31:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, victor@mojatatu.com,
	kuba@kernel.org, pctammela@mojatatu.com, martin@strongswan.org,
	horms@kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2 1/2] rtnetlink: add guard for RTNL
Message-ID: <Zgv6o3rcgFu1DXpV@nanopsycho>
References: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>

Thu, Mar 28, 2024 at 08:27:49AM CET, johannes@sipsolutions.net wrote:
>From: Johannes Berg <johannes.berg@intel.com>
>
>The new guard/scoped_gard can be useful for the RTNL as well,
>so add a guard definition for it. It gets used like
>
> {
>   guard(rtnl)();
>   // RTNL held until end of block
> }
>
>or
>
>  scoped_guard(rtnl) {
>    // RTNL held in this block
>  }
>
>as with any other guard/scoped_guard.
>
>Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Since you add couple of helpers, I believe it is a nice custom to add a
couple of patches that actually uses them. Would that make sense?


>---
>v2: resend
>---
> include/linux/rtnetlink.h | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
>index cdfc897f1e3c..a7da7dfc06a2 100644
>--- a/include/linux/rtnetlink.h
>+++ b/include/linux/rtnetlink.h
>@@ -7,6 +7,7 @@
> #include <linux/netdevice.h>
> #include <linux/wait.h>
> #include <linux/refcount.h>
>+#include <linux/cleanup.h>
> #include <uapi/linux/rtnetlink.h>
> 
> extern int rtnetlink_send(struct sk_buff *skb, struct net *net, u32 pid, u32 group, int echo);
>@@ -46,6 +47,8 @@ extern int rtnl_is_locked(void);
> extern int rtnl_lock_killable(void);
> extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
> 
>+DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())
>+
> extern wait_queue_head_t netdev_unregistering_wq;
> extern atomic_t dev_unreg_count;
> extern struct rw_semaphore pernet_ops_rwsem;
>-- 
>2.44.0
>

