Return-Path: <netdev+bounces-161541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AE8A2229A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 18:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA893A71C5
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 17:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366F1DFD8C;
	Wed, 29 Jan 2025 17:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15B1DF975
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170760; cv=none; b=MbxnC9w+uiv+ZMqv2QtfrQ1EOGpYW4KJjGtoPcX4tOzx1mrqIMXTXpfO9oQSvHPhROFKvoJ++eMtUgY5OPMkRdZETXII47C74cmzRbzkV3yHAMiWg+xu1/tFr7xpa6ssPXh8CPbsNsp4Q8mmg8eWLJDtnD7fKOsEdrYsYVZ4IMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170760; c=relaxed/simple;
	bh=IxsRd6cNQepHsUvJtKYmg5JSzMGb5rO4OaT7zgyifDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+sUgP2o4EH3AE6tadJQSorhINvWGP+BsdR5IaVwRHu61WrdRo8QSRiinohyF3ldUB8A0QzLMgFD3YWCbwmlKknTX1XhSvmEs9zvHupA9BMFnN6DDgu0h4geZdnvrs1PWJE4jRtZxqEPHr297McktZZX8cE1Qm/37pjwhXuuetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3dce16a3dso1942589a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 09:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170757; x=1738775557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnHIhVhHuUTgcEKFgibp5Dqb0u6FQLhR0Ir35xRb85I=;
        b=g0zOU5GWj9sDO9/zF6NgCx5ibykrAxnmZtzbSCunBf4cIqlSwsyZ3yG8ow5nTIBXsy
         fojbUOSZP4WA2hHUMB/ArJWxfE1Wfp1R1CvglOIOWE5sANpWsPtUTv1RFvWVfRzEbkVE
         gwu69qN2PgvBaI7gcbUjKGjzebj9OCLgTqWMWqBg3MQBOQIits2oHy6a9AM9ehSS5638
         r8GwjrpPVZyXqspuxM81ZjbW4NgQd1bsCptK9u/I0WwWuz2CmhRLnjDDz5Xz0tGtfa3k
         Hsyfh7SC+2k4ODwBjvKQaT3sXihB8H63PDWxHBqjshLrvWlKfPSaiXPzkUReufjy3XMn
         PXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy8MgCTbpYmwXcgPh1CQHBt2Fi5xpX/agMext0sKxrmdh0YUcDp2IboPOqq75HNau/8eRJJkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJeX1yv33ZVCAGC99OeUVMzwRb50JxPnN2b+ofwobzLcKjifV
	/bXfElkXhSeLAvvEcv00wbLQWBDmcPNeXS1fl7RELO/zPXmyzrYiRPE55Q==
X-Gm-Gg: ASbGnctAUQ0EZCqCcle4wImspkhnXjdXUtKYor3LEiPAAypxbDLO7F+CFyfpn1BMeMq
	i0294ca6GPEQGqaSbbuSrRHTfiauRImUj681khRXPdlppMupX4dpsWpkU8BN/6Rp7r98lKm/sHX
	nmsmvSl/gDBppQzCmsVt3kmOcBTnyn+m5P/ZQpWkuzbTiApL8gN7w+a6F3FUZCyJiK+ZGKskKlP
	aKJbKDSi6Q4JAbByCMA02K3v9i6eUXzsXAQJ67VuGiy9rgtiuAew325YFSWmvXtxn5eq7FJbbLz
	IC3m7A==
X-Google-Smtp-Source: AGHT+IFx3qzzAYKw8f4joEM4F+b1uy708zZOZn636FT0o66pIMpi26QlxWhhPwcN1bDnZsxg4xcsnA==
X-Received: by 2002:a05:6402:3592:b0:5d3:e99c:6bda with SMTP id 4fb4d7f45d1cf-5dc6f64e8damr68359a12.16.1738170756423;
        Wed, 29 Jan 2025 09:12:36 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186b37absm8799927a12.53.2025.01.29.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:12:35 -0800 (PST)
Date: Wed, 29 Jan 2025 09:12:33 -0800
From: Breno Leitao <leitao@debian.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: pavan.chebbi@broadcom.com, netdev@vger.kernel.org, kuba@kernel.org,
	kernel-team@meta.com
Subject: Re: bnxt_en: NETDEV WATCHDOG in 6.13-rc7
Message-ID: <20250129-quiet-ermine-of-growth-0ee6b6@leitao>
References: <20250117-frisky-macho-bustard-e92632@leitao>
 <CACKFLik4bdefMtUe_CjKcQuekadPj+kqExUnNrim2qiyyhG-QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLik4bdefMtUe_CjKcQuekadPj+kqExUnNrim2qiyyhG-QQ@mail.gmail.com>

Hello Michael,

On Fri, Jan 17, 2025 at 09:44:12AM -0800, Michael Chan wrote:
> On Fri, Jan 17, 2025 at 4:08 AM Breno Leitao <leitao@debian.org> wrote:
> 
> >          Showing all locks held in the system:
> 
> >          7 locks held by kworker/u144:3/208:
> >          4 locks held by kworker/u144:4/290:
> >           #0: ffff88811db39948 ((wq_completion)bnxt_pf_wq){+.+.}-{0:0}, at: process_one_work+0x1090/0x1950
> >           #1: ffffc9000303fda0 ((work_completion)(&bp->sp_task)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x1950
> >           #2: ffffffff86f71208 (rtnl_mutex){+.+.}-{4:4}, at: bnxt_reset+0x30/0xa0
> >           #3: ffff88811e41d160 (&bp->hwrm_cmd_lock){+.+.}-{4:4}, at: __hwrm_send+0x2f6/0x28d0
> 
> Since there is TX timeout, we will call bnxt_reset() from
> bnxt_sp_task() workqueue.  rtnl_lock will be held and we will hold the
> hwrm_cmd_lock mutex for every command we send to the firmware.
> Perhaps there is a problem communicating with the firmware.  This will
> cause the firmware command to timeout in about a second with these
> locks held.  We send many commands to the firmware and this can take a
> while if firmware is not responding.
> 
> >          3 locks held by kworker/u144:6/322:
> >           #0: ffff88810812a948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1090/0x1950
> >           #1: ffffc90003a4fda0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x7eb/0x1950
> >           #2: ffffffff86f71208 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0xe/0x60
> 
> Meanwhile linkwatch is trying to get the rtnl_lock.
> 
> >
> >
> > Full log at https://pastebin.com/4pWmaayt
> >
> 
> I will take a closer look at the full log today.  Thanks.

Thanks. Have you had a chance to look at it?

Do you suggest anything I can do on my side to get more data?

Thanks
--breno

