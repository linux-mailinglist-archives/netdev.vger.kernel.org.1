Return-Path: <netdev+bounces-133837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAC09972D2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7E02829CA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C7A1E00BD;
	Wed,  9 Oct 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qpmnluQG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BC1DFD84
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494034; cv=none; b=dvgllVvsP54oOwrWZvpaavlRFkaJBtK3frkssktmKobIXbOdWMkYzgsZlOZ5A+psHne/A3ldwi+mnYomht+sefaEBCEUI3SewNSI1O81bxipYsXlU8oT0BUAt/PdXBFxqnAjL6nlIKqiDUl8JnPW68FR+O74RBA7EE/ZCy0oOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494034; c=relaxed/simple;
	bh=klMNfne84d1kgkHC4atcIfdIjejvE4rVNstBvQFCWHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjgKAPXzpza5G56+RXPqMQ5fHy5YUk6lUK5adodAkOZZ3JqCuHElfURAuOCkt4SocP8tfHQ/pa8C1peijMYeukH/+v63mWn1Qk7Gi6sOntB3dIMkEygB31e4qLaDob6jQgACm1bsdjNkAZ748fr91obuZZtVm6osoxYCRF/EM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qpmnluQG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so82661a91.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728494032; x=1729098832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUJ9rnG2uJ0j7bwfLc8ihegGzcRS1BQcJMo5xx5rPvM=;
        b=qpmnluQGthP+JZpYp/wf9jFrHqgfd5E4vPB5mn4K37r87DlKCTvOMH96/P2cV6LxVN
         5BDehINgCN/GJEVs6rn3pZluioSSL3Ya9ZPUSR+7NnG4eqYmyDTIlANNZeJsmj21tTVz
         9P5d4IB8d1pz0ARCRYwCgpJIgvDKtiHI8Wkf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728494032; x=1729098832;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUJ9rnG2uJ0j7bwfLc8ihegGzcRS1BQcJMo5xx5rPvM=;
        b=tzt83YyluAM+K0bI4yvvg5+/eokRTGUSMSHpTbbvFjJyZhQeKzH2IKdM5GRNxmgxaz
         riAVckRS92eD0HvPMd5IW6WFULgDoxFhMchRsT63EhIZ3bzGHRvw2r3cNQNG92gjhhgT
         VlvlP/UmUN7RoYCBrhlbSTgTqWed6wDfXIn0l55nwQ2yIX/mLStD+odG2tCogOKLY13W
         lqchxgFGiB2r6HAZIZaTAkdFfxvfsKs8cyFJKTpnaN2dat1xzSPIrKSVaUOqEWdwijt9
         GQ23t0vRB7qsGSfm/S+0MKn373XxJL2+zKK7Pfv5ER6gwgrx5h0hqJTiYXD9rrdxkgk3
         jZ7g==
X-Gm-Message-State: AOJu0YyZ4jg2VtxdgcXoIsp+ddjJSjGrbjfVE6x6vZl+spxnL5AL6Hvb
	67oUW/G31nujoD81aBeT/ml+D/AZbKR7gOCHAtr6JVORzKQTrVWSDikX+rP8UW/gqh2TYSvYaLB
	A
X-Google-Smtp-Source: AGHT+IGCxMaZ1teuexWUVBV5sBk+xGYqduyCYApVj9E/JdnEvtvGwcwBKdd3sP443QuWLbWgg5eCfA==
X-Received: by 2002:a17:90a:9e6:b0:2e2:b45e:88b7 with SMTP id 98e67ed59e1d1-2e2b45e89a4mr2237542a91.26.1728494032134;
        Wed, 09 Oct 2024 10:13:52 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a55ffa00sm1944174a91.21.2024.10.09.10.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:51 -0700 (PDT)
Date: Wed, 9 Oct 2024 10:13:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [RFC net-next 0/2] igc: Link IRQs and queues to NAPIs
Message-ID: <Zwa5zdhtxlqJxIj7@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jakub Kicinski <kuba@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
References: <20241003233850.199495-1-jdamato@fastly.com>
 <87h69ntt23.fsf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h69ntt23.fsf@intel.com>

On Mon, Oct 07, 2024 at 04:03:00PM -0700, Vinicius Costa Gomes wrote:
> Joe Damato <jdamato@fastly.com> writes:
> 
> > Greetings:
> >
> > This is an RFC to get feedback before submitting an actual series and
> > because I have a question for igc maintainers, see below.
> >
> > This series addss support for netdev-genl to igc so that userland apps
> > can query IRQ, queue, and NAPI instance relationships. This is useful
> > because developers who have igc NICs (for example, in their Intel NUCs)
> > who are working on epoll-based busy polling apps and using
> > SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
> > queues.
> >
> > See the commit messages of each patch for example output I got on my igc
> > hardware.
> >
> > My question for maintainers:
> >
> > In patch 2, the linking should be avoided for XDP queues. Is there a way
> > to test that somehow in the driver? I looked around a bit, but didn't
> > notice anything. Sorry if I'm missing something obvious.
> >
> 
> From a quick look, it seems that you could "unlink" the XDP queues in
> igc_xdp_enable_pool() and (re-)link them in igc_xdp_disable_poll().

That approach seems reasonable to me, but I am not an igc expert by
any means :)

I checked and it seems that igc_xdp_enable_pool and
igc_xdp_disable_poll are only called while RTNL is held, which is
good because netif_queue_set_napi uses ASSERT_RTNL.
 
> Or just the existence of the flag IGC_RING_FLAG_AF_XDP_ZC in the rings
> associated with the queue is enough?

I didn't notice that flag, thanks for pointing that out.

It might be better to go the link/unlink route as you described
above, though.

> I still have to take a better look at your work to help more, sorry.

No worries, thanks for taking a look.

I'll implement what you suggested above and send another RFC.

