Return-Path: <netdev+bounces-271840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yChxJSXCxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:20:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEA732F50A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C082730224C9
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD1F288B8;
	Thu, 26 Mar 2026 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FOeqHfUp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2FB1624DF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502417; cv=none; b=UEW3PPHhyxjksteCR/ofq6zgLIPlXTW8sJc8wT7luq1b5vH0rBjBDOrpNDG+i3fCVF3bBZKVeS9vWPCgfga5Dfe6F2RELsdWFuqBD8jUUFgrmQZkIM5lU3u/LEX2PWJ0tv346EvsK7XN3xKaoqZeHKoiOUxahwJO0SAzR3mHxVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502417; c=relaxed/simple;
	bh=yjj61wupU95wN0DoWgQq7AukJQ++oGi9vaiAVfcSylE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+LVO266CadsGRLL+qK3J78mypZgvOmejIUTfWJ7u2SDPEVIBodWl6HJHWQ5paOXv7xOPEGd1IQplTJOh73agBf+UKNM7NeNRGZf2r+ZRU3IeQVmkwpCZ66xhFUi2wX1FhngmVsyCRTy0q+A1w0i7SxJW+9yxqlWftTLGJz0YwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FOeqHfUp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so6716675e9.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774502412; x=1775107212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aa8Oo9ESgQItRaqaOQ9DNzXFkC6kr5Y7gZP1T5Pf6R4=;
        b=FOeqHfUpmBBhC3llKmE0IGKfddVJ/Wo/46ujksUONgkSwIBeP90E0AqZdUO7Wsckjg
         SH+7AZ6ZnydnILW+1d4NdNWDAplh1+27o6fnrYiTTf3ZRq/+JaRGrFHhZDUA3OVsF5Xt
         sGIBwxHe9udOL1BCZp1Pa2bU9kAnDWkFIH7XIUOaXjoOQ/+WGa4hRUsyqV50zb5HK+ua
         0I+JezBRFKuYTIDcvExquoUJK+V+HBrQD/nGkkN3rXROmxJXTNmfRgddBcPgmLiox/Hi
         l8qr5hec3tARJW+J7nogNuP0ZPB6Tw1wjZazkBsr8MOt+apYWvSvU3WgfdEuArEevRDE
         7hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502412; x=1775107212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa8Oo9ESgQItRaqaOQ9DNzXFkC6kr5Y7gZP1T5Pf6R4=;
        b=QWzbiO1fyf/VsFvXFqsTw02M1U+fDzvWNkgob6urJ8G1x5hx1J7zeD1dG7mhBhWld5
         BfjU9XlngL8gCz5AO+vkYPwsIM70Bbn+imAa/MlZtN/KSngpbFwAdecezFQTh63O51Pl
         qsfmfhdZqDBjfILA1UGkhHte9vCVRbQeKJYY4DttsqfYxAz/YtE+Y5x4Xri/Rs+3pM3i
         2jCiLhWEpeSFeIApmjlirt1pO2rp2lWDlUhdfjY7eLMkym81IBeo277sbSZJTYYOtFFi
         U19oFXQ49a87lUf3apWd4FhWacI69k0UJq+MT1P4tE5cwCiXAVlBVOS5gU9jT6aQvcnL
         gjKQ==
X-Gm-Message-State: AOJu0YzEc7BhShnGWNplWDoIqzop7kzNpwv/h6zhrt/iFGtDnsWSBVc+
	TFOoHSBHsIMif7k+W9pbuZGpvJmtL+BzI2JiNcPhvDSzfCIJGyIbK3PrxmY5VcotLmg=
X-Gm-Gg: ATEYQzwKguqxDP2dtu3je1sbCuiVrZKmiUi7RRPFViB/b7ryOeZCv3I8l48/vYb8Nd6
	n1XTBcvsObINif5OceQiMAOO1FQHSM/8RSJwn7kiegoGXgsX9Yyqvu9bNnOQdjf0nx4RnTxgbo1
	2sijSzmNGYkUkIldEcSHuP+jd4+0gZqzmqkZZEfwedOnBsZFvC8C3wC9Y6GLKONxesHF7q20Rku
	JYpFiOXWRtULbx7vCZmu7w0B2tyjIcUnP3T4P0WPpQHNEALw9+cQPgype0A32+OmvcOJd2PsZve
	/09fGJLUlHtuk4WTW+jXhR2rvJWKDmrhR/hQRFkr479OzUsCrFslGbrNsQpkVhjaDz+gx9FQa9u
	3cJIufNEGTtdPYMioB/xtKmL3VBcsxDpr3GX7UQAZDPyMObnj+ugCz8mhbrAWOAwTqbIj/P6PGp
	rmooEe8Cy8mzmDLnaX/BTqRdY183gNY9PLoys=
X-Received: by 2002:a05:600c:34ca:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-48715f0369fmr89461225e9.0.1774502411215;
        Wed, 25 Mar 2026 22:20:11 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cefd7sm5204040f8f.17.2026.03.25.22.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 22:20:10 -0700 (PDT)
Date: Thu, 26 Mar 2026 06:20:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, edumazet@google.com, horms@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH net-next 2/2] devlink: unregister shared devlink
 resources on destroy
Message-ID: <aa7hsleso6z6zaubb6phx4lexqnthgdvkns5cpg75gk6w3pi3o@7skrmgryitsj>
References: <20260325063143.261806-1-przemyslaw.kitszel@intel.com>
 <20260325063143.261806-3-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325063143.261806-3-przemyslaw.kitszel@intel.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-271840-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2BEA732F50A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Mar 25, 2026 at 07:26:53AM +0100, przemyslaw.kitszel@intel.com wrote:
>Since shared devlink acts as a normal devlink instance, capable of all
>usual devlink operations, it must unregister its resources.
>
>I plan to make use of devlink resources on a shared instance for ice
>driver by separate series, coming soon.
>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>---
> net/devlink/sh_dev.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/devlink/sh_dev.c b/net/devlink/sh_dev.c
>index b85e5cb1edbe..5de138bf3630 100644
>--- a/net/devlink/sh_dev.c
>+++ b/net/devlink/sh_dev.c
>@@ -71,6 +71,7 @@ static void devlink_shd_destroy(struct devlink_shd *shd)
> 
> 	list_del(&shd->list);
> 	devl_lock(devlink);
>+	devl_resources_unregister(devlink);

Hmm. It is driver's responsibility to call this on appropriate place,
symmetric to resource register. Why to have this in code for sh?

The idea I had was to have callbacks to driver to do things like this
and more eventually. Would it work for you?


> 	devl_unregister(devlink);
> 	devl_unlock(devlink);
> 	kfree(shd->id);
>-- 
>2.51.1
>

