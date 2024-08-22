Return-Path: <netdev+bounces-120920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CF395B35B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DCA1F2411E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B52185936;
	Thu, 22 Aug 2024 11:00:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4561850B6;
	Thu, 22 Aug 2024 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324407; cv=none; b=Ika7SmwkmXnFJ6NWDGh2Nklh2UX20dQKA9hRLISNdRW1E7L5/xB8NruXvjRP1CqzY4Ct3vBhq132R4Cdk3map15VcJ9tZ4dcwQ+WBbe8hCEsPJE6Zlx+J6AUJ1kZQVttMWATNIcLFK6Qta/RfdAEnNrlp/jQJMLWyqHab1YwsW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324407; c=relaxed/simple;
	bh=tsj8wNjiLlZC3DrbW6llGYMikgPdxVPIsEy9bqFyxEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STlUCvE2LoiQCM6oPiHzYNtolRRBXg7Fn9b3d8IkMzNrdbS9tvY09urPaoP1mHfZ24A5diaWl7PCkaPUyWrGQ+V55EAPyNnqkkFpVihpfqrP3UnDxH2bqbwSz1xKZTmFZnUhRVvvsXfDn6ytKS/8yYRCId27GR0fqZQe2WupcEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86984e035aso28097466b.2;
        Thu, 22 Aug 2024 04:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724324404; x=1724929204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXav5ea0ttZidZUshIDeqG+jlv7MuDZssQmcmhYi3W8=;
        b=hJLDs0cBaNoifFr1WcWrNC7J91N1hTcBn1oGTwUAVwIDDe4kZk6+VEBEn506SzWGpr
         IeySNFtKMVG17++ggv5yLfXE9jqpSOwzZoAcTFTqbSbsRwoEyUAvdokx4TqHvfm4sLeq
         D6pz2CLaMKizKixSCh3WPb/PdMI7h5aON2XYNhxWt+psI/hnSYD8GJtOtf8MDyqs8hKs
         t5VnTPMDwJ3b+17V0okJ67bOjno7pQYM+x3WJsF/oYopWZCyRVjHLftOEJga6CJa0EAt
         aMwac6ywF0Yvqt71sV+7Rt7HOp8I0doaMeoeKERNXOokHixhZi+MSq/qrLJje2g8TcA5
         nYBA==
X-Forwarded-Encrypted: i=1; AJvYcCVZa2uZlZrs27GPPqYuF7o5HvfQPY+sfudHKx+N69VZQ66HkiJB1t9hmObpMMa6hHXrkG7UjfRT@vger.kernel.org, AJvYcCWssgV+iC8r47Z3XQC1hgz2wL0UQtNLshreN+ugGW5MhdkJb+K0zhHFrXoX+y/thj/fEiEJrJPE8xyiiOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnqrAsaDLGEO+32LUeVbvksiAJnwmrpoWy9NhK/OK3SFSFh78
	/nha07gsYPoookCQIR37Ih2kFTdbC9nHEiL/xOtUQh/n9PlMHMrwhHbqvA==
X-Google-Smtp-Source: AGHT+IFMbrWbzp6WQb0W8vJCPoFh+b4nkmLALfcZ7m0+8FrEj+1rfKebSOMSK337bFY6kN3D5INLiA==
X-Received: by 2002:a17:907:2d0a:b0:a86:963f:ea90 with SMTP id a640c23a62f3a-a86963ff812mr62331166b.46.1724324403876;
        Thu, 22 Aug 2024 04:00:03 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a869b2d89c5sm9379266b.143.2024.08.22.04.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:00:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 04:00:01 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aijay Adams <aijay@meta.com>
Subject: Re: [PATCH net-next v2 3/3] netconsole: Populate dynamic entry even
 if netpoll fails
Message-ID: <ZscaMfmnU3HmZWm5@gmail.com>
References: <20240819103616.2260006-1-leitao@debian.org>
 <20240819103616.2260006-4-leitao@debian.org>
 <20240820162725.6b9064f8@kernel.org>
 <ZsWjpuoszvApM1I0@gmail.com>
 <20240821154926.14785d66@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821154926.14785d66@kernel.org>

Hello Jakub,

On Wed, Aug 21, 2024 at 03:49:26PM -0700, Jakub Kicinski wrote:
> On Wed, 21 Aug 2024 01:21:58 -0700 Breno Leitao wrote:
> > Another way to write this is:
> > 
> >         err = netpoll_setup(&nt->np);
> >         if (err) {
> >                 pr_err("Not enabling netconsole. Netpoll setup failed\n");
> >                 if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
> >                         goto fail
> >         } else {
> >                 nt->enabled = true;
> >         }
> > 
> > is it better? Or, Is there a even better way to write this?
> 
> Yes, I think this is better! Or at least I wouldn't have made the same
> mistake reading it if it was written this way :)
> 
> > > As for the message would it be more helpful to indicate target will be
> > > disabled? Move the print after the check for dynamic and say "Netpoll
> > > setup failed, netconsole target will be disabled" ?  
> > 
> > In both cases the target will be disabled, right? In one case, it will
> > populate the cmdline0 configfs (if CONFIG_NETCONSOLE_DYNAMIC is set),
> > otherwise it will fail completely. Either way, netconsole will be
> > disabled.
> 
> No strong feelings. I was trying to highlight that it's a single target
> that ends up being disabled "netconsole disabled" sounds like the whole
> netconsole module is completely out of commission.

That is fair, let me print the cmdline number, so, we can see something
as:

	netpoll: netconsole: local port 6666
	netpoll: netconsole: local IPv6 address 2401:db00:3120:21a9:face:0:270:0
	netpoll: netconsole: interface 'ethX'
	netpoll: netconsole: remote port 1514
	netpoll: netconsole: remote IPv6 address 2803:6080:a89c:a670::1
	netpoll: netconsole: remote ethernet address 02:90:fb:66:aa:e5
	netpoll: netconsole: ethX doesn't exist, aborting
	netconsole: Not enabling netconsole for cmdline0. Netpoll setup failed

