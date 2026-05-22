Return-Path: <netdev+bounces-290749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL9yKcIiEGqsUAYAu9opvQ
	(envelope-from <netdev+bounces-290749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:32:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B65B13E7
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBBE93001CDE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DBA3B6348;
	Fri, 22 May 2026 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Po7fQ/UG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFBD309EEB
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442367; cv=none; b=W0RN7kmHOsJyJfO0GmkYaQNSUmoxszzJo112gVqpmWimI+lX1mrnBLZQ6F2oIkspePxwoD5o70sVFAb+n2CW6tecFuG62gjVe6fMOdhmDpNHTTyTPkvy1cRnBEMg/0JcegVdWWUSKKBt4jrG4fL+X8mHaPKE8Sb0nO5NV34A3jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442367; c=relaxed/simple;
	bh=ZRjCuZ5soSFViM1XZQXf90a0RcXMaYkUfCNCYoq8/jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrQrnCUp1zwDhOkEB78pg0VkNroVaG1WwKvIcHgUpz559wOsMqBP0tLqRKU1CyKp9pRzmcdY86bvNS29fhramNbMaSIMFEf40E1Co9khMfXOHGe8AycPOEoqT1ixZjpIapZipI9k+Cw1EYoOLs9yox/hf7LHAfgrq7NmuRrq1rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Po7fQ/UG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891b0786beso48898405e9.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779442364; x=1780047164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oc9ICJHMobRwgOuWr4AWp3EfDxst640rEjbN9WZW1c8=;
        b=Po7fQ/UGepQJcGJPriHz6vu6l/LdpQmipSjmrpNlX4/3RWQwdXbP2oGxpudDdveqBd
         wCReJigp6bPKEvS10u6i0TM10hcTvkt6SO9p/rqYdPtm+eocsL7WoI7t6wwQBOpFLjux
         du9i/Tc4io4VtT2bGpBfHZQUUdKOKzKfBbLM0hNB+WPwXg5UPXqZS3Nk+4L/cnK1xOHC
         lb4D+WLPULck4GrtdszojAeKY1SFIFODKtmUNJGnE3yEPQsZGTxe7IzbtbE5JiPnZIeE
         rW2ilSQvVbwDRpXV4MYtgrQDy0AhmHt+M6//gK2SdlI56eViblchgAPIyUYg3VALVMRF
         8YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779442364; x=1780047164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc9ICJHMobRwgOuWr4AWp3EfDxst640rEjbN9WZW1c8=;
        b=LQ0VJ10R7JadlP3aQs2LLM20TVcyY9R/8kP1MSJ5x4lde8s1XrwjFJpmByBiyk5oBr
         y5IoK58/v5BrBdnmKZ5j6NA0awYikLU6hh0WKvzInC79YgMYnKWd7R45EhHNYuMUM7el
         mkyRCUWP03UPZofq1K2aaMNIc4lAOXFjpibyZqRcs5gHXlE8jpkU5/y21wNSX9STUun2
         fs3jAIP5IZ9AaUi2JbgydVXc8avhXJm6TytTgtVgIHWkhVLFHtRScl+7dJk4od0vWwn5
         Em1MGraQgcba26128i6P3y0EVJwxwLqZHu1VhRtXtuiq3WMFum8BVg2xymlvHNgepHiO
         ++Tw==
X-Forwarded-Encrypted: i=1; AFNElJ9YUCwAktFsd+0zZjMoN36+vr9JSoVfFRD+GuXRn+yjfg/PDQKvWkaAIPzV9yRgWpa5p8XFaFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwV1Awekf6nNBwDhmKmiYHmyHBpoxJ5Ns/juVl2jPImjKl8h5
	0F2OrwmnJCjXd8x38U6LiA61pYRSz+Y9wCIJpVY6ES5rt3qEhV1Ak0oKNHCT43O/up0=
X-Gm-Gg: Acq92OHWobTbzNuqyftEXlxDhW82NAwkiQNryCck6p3YyaAJF0J7GFVJk5w9uafxFG6
	Qbu0yWUvUThdEva2jNG2IMIGmSsFWe3Vjgu6oUr8YEjd0o/LSAbkFlHbFIK3txiGdoom+UU0SYq
	yADkWonYr9pWWcrIhsLB/1VzSZn/4ometeA9lHfUl1sjhXYzr54SAWFPxgk1hWcjAN6cnD4+k/p
	aA09tV+cwvyb5zmkePkoxk3lKCTwNeS/y6vQbu84L3tQS2gJ+3RsDPYEnwuyxWIykk7VuTLVss8
	/4nRG+k0WrQ76JkDLt44+Qtp7s6gfcdQs6rvMXuINzamZNz4KJ5PVw4VtNU8v8/1zMPiyQJ0RPH
	I6SP57FuqRVvLCKbiH9ljt/18waFqC337rX6q+ho1/73zG7WbNvIAB4umd5GTmIgo5i4dTY8GMy
	w3UW/8R60YgrjU29am
X-Received: by 2002:a05:600c:468a:b0:490:3d62:f5df with SMTP id 5b1f17b1804b1-490428e5a6amr37844205e9.30.1779442364229;
        Fri, 22 May 2026 02:32:44 -0700 (PDT)
Received: from localhost ([46.211.85.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5ed84sm2631974f8f.31.2026.05.22.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 02:32:43 -0700 (PDT)
Date: Fri, 22 May 2026 12:32:42 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 00/11] bridge: prepare lockless
 br_port_fill_attrs() (I)
Message-ID: <ahAiurFaIYuJ9_Vg@penguin>
References: <20260521131916.3627204-1-edumazet@google.com>
 <20260522084538.GA829572@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522084538.GA829572@shredder>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D0B65B13E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:45:38AM +0300, Ido Schimmel wrote:
> On Thu, May 21, 2026 at 01:19:05PM +0000, Eric Dumazet wrote:
> > medium-term goal is to allow "ip link show" dump commands to run without RTNL.
> > 
> > This round of patches adds/fixes some lockess accesses in bridge.
> > 
> > This is not complete, more patches will come later.
> > 
> > Ultimately all changes to p->flags should use set_bit()/clear_bit().
> 
> Thanks for the patches, Eric. I have two fixes [1][2] that I am planning
> to submit next week where I mention some of these issues. There might be
> a small conflict between both patchsets. I can review on Sunday unless
> it's critical to merge the set before that.
> 
> [1] https://github.com/idosch/linux/commit/3350834468428df21c279acca1c37f67e68e1626.patch
> [2] https://github.com/idosch/linux/commit/dd63fb916cdeec9e69685726ef65a40b57bd74fb.patch

+1
I'm on the road next two days and will be able to review them properly
on Sunday at the earliest.

Cheers,
 Nik

