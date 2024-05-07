Return-Path: <netdev+bounces-94231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7308BEAC2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 19:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025AE1F257B0
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A816C84B;
	Tue,  7 May 2024 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cyzMcWa8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257F516ABC7
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103973; cv=none; b=rEYkoFyC4X0h/kys/OPVxdAvMTfh9JIM1auDduNJlQaI/LgJV6KmOONGGxmraR1VKTNGfpafA0lQKRLba/rK9ZyCB730ZZowT1FyCOAD+R19vcymF3zj5KTa2x/taw9STEknBZlW/iSgMVRJjBtKFnlENjLEE0Cz5Bytrk8NC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103973; c=relaxed/simple;
	bh=b45BXM6azwylKAkF8AuCt3Xr6OvbuLSCL5irRdAFR9M=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YftjqkF2KCHhiSCc/dBoS8lEt15sMuwKZy0TeMkOQT7cLo3V4hcVZQTYfsfXz8wP6tUbslahuvq+00apqz603+MyMop13dAd7t6LgIjHbOVjbqJKXNi632tsxIlq5lyZlBULFfnr0Sd0QEgnkqAS7MhQtrTWPqT7sbzhE/VEnbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cyzMcWa8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso2310362a12.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715103971; x=1715708771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EJii6UXuMvTj7/Fl0gT40oAKTc/ri+4xsPAbWLHgtZc=;
        b=cyzMcWa8lrMAn8zio1JQYT42wQuNck86HnL2J4k2A8HmihFphcQujEy4dTS2rU7Bnk
         oo/CoNfAeoa5mfzeTPhC95JGgtLrQFZBmxHN6u0qXiNDlYhOR5M4eh5M1TP2ftLZbUst
         KQMvTOCHoPUIbr+dsm8NVbDUIhNUsFrTB49IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715103971; x=1715708771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJii6UXuMvTj7/Fl0gT40oAKTc/ri+4xsPAbWLHgtZc=;
        b=wNFO0KkxV3fC56Eaf59kzZ9/9ey2Kv1eN8J1DJ3qvJZyHPsw6gMz0Bx2jWDbulwYwO
         T6xGkj31QsTeOer9eS0tHW8DZr5PhscHP2n8sE9qmf5Ow2ZH2ooJ0lX/dWA2irwjkYKs
         w6UT9OFy1rXRuyO0hEa338LJILJ+P/6y7AshWpwaEB7lLcXsj57RD/0Jy8/kLokNHdWp
         eaBSNDUr0BzQvrHW6qC02mXtfIzvPnOpgz89563aW2p8ZZaO8w4HlK6MTO2mL8En20vL
         lcvYltXRoFQfHKBpuudK9NwwyfFoxzAdUTYztGOrV/1Uyi08bHlPkjhPJ2PxviKrKWe0
         fBfg==
X-Forwarded-Encrypted: i=1; AJvYcCUnnzCWrtLT5F/Gv1IVeKfT8i6DUhtgf2smAOWYJeSx5aIxImGFe/IRRy6UYhkjna0A9pAXjVzpAIGcMl9m/Cs7yXb6abnM
X-Gm-Message-State: AOJu0YxoBX7iSdWmbKQ+XpWdUrsJqhL10bo4JG+ZswZsY2lQEOvXmFRU
	j1lYdu0ZNYbhgOr/Zgq/O+H3u9S43EMIu4QlnthKn0H9X54iK5RXIVTBV3wMVA==
X-Google-Smtp-Source: AGHT+IH58w5YcP8tV50CjXJT1LIW0iDa7P94WPDKqKSCD5Oghv8vmpYhMRRJ94W/3oNLZXf+knov1Q==
X-Received: by 2002:a05:6a21:2d8c:b0:1a9:c28e:bc17 with SMTP id adf61e73a8af0-1afc8db5b44mr439239637.45.1715103971376;
        Tue, 07 May 2024 10:46:11 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id cq13-20020a17090af98d00b002a54222e694sm10103173pjb.51.2024.05.07.10.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:46:10 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Tue, 7 May 2024 13:46:06 -0400
To: David Ahern <dsahern@kernel.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: Driver and H/W APIs Workshop at netdevconf
Message-ID: <Zjpo3u7gu8_y0jaU@C02YVCJELVCG.dhcp.broadcom.net>
References: <c4ae5f08-11f2-48f7-9c2a-496173f3373e@kernel.org>
 <20240506180632.2bfdc996@kernel.org>
 <1c36d251-0218-4e9d-b6e3-0d477a5e6a02@kernel.org>
 <ZjpdV2l7VckPz-jj@C02YVCJELVCG.dhcp.broadcom.net>
 <12ab765e-d808-4bbe-a2d3-87a8c5fb8b54@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ab765e-d808-4bbe-a2d3-87a8c5fb8b54@kernel.org>

On Tue, May 07, 2024 at 11:02:05AM -0600, David Ahern wrote:
> On 5/7/24 10:56 AM, Andy Gospodarek wrote:
> >>
> >> That require driver support, no? e.g., There is no way that queue API is
> >> going to work with the Enfabrica device without driver support.
> > 
> > I defintely think that there should be a consumer of the queue API
> > before it lands upstream, but if it cannot work without a
> > driver/hardware support that seems a bit odd.
> > 
> > Maybe I've missed it on the list, but do you have something you can
> > share about this proposed queue API?
> > 
> 
> commit 087b24de5c825c53f15a9481b94f757223c20610
> Author: Mina Almasry <almasrymina@google.com>
> Date:   Wed May 1 23:25:40 2024 +0000
> 
>     queue_api: define queue api
> 
>     This API enables the net stack to reset the queues used for devmem TCP.
> 
> 
> and then gve support for it:
> 
> commit c93462b914dbf46b0c0256f7784cc79f7c368e45
> Author: Shailend Chand <shailend@google.com>
> Date:   Wed May 1 23:25:49 2024 +0000
> 
>     gve: Implement queue api
> 
>     The new netdev queue api is implemented for gve.

Thanks, good news is I'm aware of those.  I guess I read your statement
a little differently than you probably intended....

Good topic as there are some more things that are worth considering based on
driver/HW nuances that are likely going to be diff for each vendor.

