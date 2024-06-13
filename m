Return-Path: <netdev+bounces-103119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B28159065AD
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4281F25F67
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E813C90B;
	Thu, 13 Jun 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZJVw7/f"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091013CF8A
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265073; cv=none; b=Dh1Y9ibdgmkyedTcDtDHmv5tvP7ZAPA/EJSDw00hC8W0hskES3J9/RVW5djVPRRYX85MAl3l76aSAEwR11JNj+ZUkQloNBSBFXfeWEs0ejMNHzZVNtJCymyIDR9MQjKof8pmcxw6xHjYDu2qlPGTyArdc48lS7qayjlp/jEAITM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265073; c=relaxed/simple;
	bh=GFIcxWXQwNCRH03Z9cLHboBcOBzSFyWQjvAxn613bA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIqMgOAkYKu7VegbxD+pX0rEIVbvqNFHwQxAQPEBZe32chGsa5i2DlLtRN8oiNH4QqBSgRe5S/9bVXAZDAUrBfv1jaLx8hNDU8zUPdy0Zt9V7bu5Cu0fjmWtT5y+MePApsxeAZOJ96AXNL4IRCHw/kglzU1mKGo/mB+r1YZEURE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZJVw7/f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718265070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A/n+AhuyhqSsJr+vWl3tvLtoPgeLWQoTZ3U+G+ztgvo=;
	b=YZJVw7/fCNrUvFGc74dKfyWA0ptIKW0ST6ZajHG67FR5cyoRIhCgAOx+ifyKnbIuo7txHV
	8v7kz/hjVFkqzNbISFMBWwaOLO8DsUWuDve/qch2ETmXzifcU9u+crskkEVSAKfv7Ql1HI
	zOLsdKi6dwOQTI9WVonuOU5REFp/oNE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-MUAE8IiVMTiu4MOX1b2tMg-1; Thu, 13 Jun 2024 03:51:05 -0400
X-MC-Unique: MUAE8IiVMTiu4MOX1b2tMg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f09791466so388096f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718265064; x=1718869864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/n+AhuyhqSsJr+vWl3tvLtoPgeLWQoTZ3U+G+ztgvo=;
        b=abmx2z9Szff2w5ZUBPu90IdMvq1PJUBlYVE/coYbtsan37OcVYrUEMYeDikSKioZnd
         x6CeYKDpBKloo0PXbTIdMaLfpd947n4PGNJaLpPruoGPUIiTxVr6u1E8onmAEe+5jrN4
         orlvwvTvM/LN79SNeflL6Qo73EiwpVsS8neey4Q/GaSE+yW0s76wObvat+YLsEg0leER
         yMcbnpPvyI6sBW/5wcTJIkBHTxDZ6pWKGuT3HSbH+/Z/R9bfEQgJVpvC+BEHSvRO89IL
         Q4Vp7hb2lkmCc5C8abJxCaAuJJTPn65S9XS+51H6X1nUoDc5Xn8eSFA4mzqMcFZ/5+93
         bf1g==
X-Forwarded-Encrypted: i=1; AJvYcCX9Gfd0sD4Tgp9DMnzGApVI/e3N7yqV2W/OxZ9LCD3ZriAX+mXnlBwQdpX1XIqdii/780S+YSN5xglBwKq+j3x+6923rgPQ
X-Gm-Message-State: AOJu0YxuQhDvpantSQ3zAOqspYJjp0pa0vGmh3YmdP+oOORZMYftcc7u
	CBBJe15VwZwQt7B6yS4PxBQ8hl7zK+JQuq3KrBsamZTxQZuv+s/7ig6gbGC4xYjaExgeKZeSUM4
	iU/zqcImHw8+Mlq0jIZkMZULyyMTpsFRqdlFv7MHkPyM7saLnQFBi+A==
X-Received: by 2002:a05:6000:d:b0:360:75b3:2cd9 with SMTP id ffacd0b85a97d-36075b32d48mr830145f8f.65.1718265063714;
        Thu, 13 Jun 2024 00:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGecT5yUVKpC78rMOjYPpZNfe8ITqSuJs063PFj3s8mFpH0gfLFXFffpfByk9P/e9suAjpbJA==
X-Received: by 2002:a05:6000:d:b0:360:75b3:2cd9 with SMTP id ffacd0b85a97d-36075b32d48mr830121f8f.65.1718265063171;
        Thu, 13 Jun 2024 00:51:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:94c5:b48b:41a4:81c0:f1c8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093d58sm894451f8f.4.2024.06.13.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:51:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 03:50:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Cindy Lu <lulu@redhat.com>,
	dtatulea@nvidia.com, jasowang@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: support set mac address from vdpa tool
Message-ID: <20240613034647-mutt-send-email-mst@kernel.org>
References: <20240611053239.516996-1-lulu@redhat.com>
 <20240611185810.14b63d7d@kernel.org>
 <ZmlAYcRHMqCgYBJD@nanopsycho.orion>
 <20240612031356-mutt-send-email-mst@kernel.org>
 <ZmlMuGGY2po6LLCY@nanopsycho.orion>
 <20240613024756-mutt-send-email-mst@kernel.org>
 <Zmqd45TnVVZYPwp8@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmqd45TnVVZYPwp8@nanopsycho.orion>

On Thu, Jun 13, 2024 at 09:21:07AM +0200, Jiri Pirko wrote:
> Thu, Jun 13, 2024 at 08:49:25AM CEST, mst@redhat.com wrote:
> >On Wed, Jun 12, 2024 at 09:22:32AM +0200, Jiri Pirko wrote:
> >> Wed, Jun 12, 2024 at 09:15:44AM CEST, mst@redhat.com wrote:
> >> >On Wed, Jun 12, 2024 at 08:29:53AM +0200, Jiri Pirko wrote:
> >> >> Wed, Jun 12, 2024 at 03:58:10AM CEST, kuba@kernel.org wrote:
> >> >> >On Tue, 11 Jun 2024 13:32:32 +0800 Cindy Lu wrote:
> >> >> >> Add new UAPI to support the mac address from vdpa tool
> >> >> >> Function vdpa_nl_cmd_dev_config_set_doit() will get the
> >> >> >> MAC address from the vdpa tool and then set it to the device.
> >> >> >> 
> >> >> >> The usage is: vdpa dev set name vdpa_name mac **:**:**:**:**:**
> >> >> >
> >> >> >Why don't you use devlink?
> >> >> 
> >> >> Fair question. Why does vdpa-specific uapi even exist? To have
> >> >> driver-specific uapi Does not make any sense to me :/
> >> >
> >> >I am not sure which uapi do you refer to? The one this patch proposes or
> >> >the existing one?
> >> 
> >> Sure, I'm sure pointing out, that devlink should have been the answer
> >> instead of vdpa netlink introduction. That ship is sailed,
> >
> >> now we have
> >> unfortunate api duplication which leads to questions like Jakub's one.
> >> That's all :/
> >
> >
> >
> >Yea there's no point to argue now, there were arguments this and that
> >way.  I don't think we currently have a lot
> >of duplication, do we?
> 
> True. I think it would be good to establish guidelines for api
> extensions in this area.
> 
> >
> >-- 
> >MST
> >


Guidelines are good, are there existing examples of such guidelines in
Linux to follow though? Specifically after reviewing this some more, I
think what Cindy is trying to do is actually provisioning as opposed to
programming.

-- 
MST


