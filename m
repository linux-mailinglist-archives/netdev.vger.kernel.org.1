Return-Path: <netdev+bounces-143429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7719C26A1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 21:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA98B2267E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 20:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9890B1C1F22;
	Fri,  8 Nov 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="E0qSAajz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE812D1F1
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098096; cv=none; b=Jz3en9NhTr2XcGKXVHjhZ7MdBCAIxcGA0Olm1mtxPF1Nt5TfhVjN3ioNdcdteD50O1w8O5erPOGv/op9Welpixg1uEJ1jbuXZPrkIyGgNcYrNjjYyiq4Y6kW0XIP/NzOdD00YVahRn5fjZmagKhdl4Ed2YT5YEG5r0334T3UK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098096; c=relaxed/simple;
	bh=XDeUA32M6UkrI+O4Yz67pEys0TaL3Y/pLrSidc7CTEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C22ia2AqMZVswPe01W0G16IGy5pL2B82uVqomL1lMP9WQAdI0NAS/7lM9m4XN6GYcxteKM/Y6ld2UXGMlve0uDoJHwpwVgSGXehKwVuG+guiSJbx7ApmH1S25tVG2Ot375iAdshADFPKdojCzti5Yk5w6STOBsO2ZBhI11cOrTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=E0qSAajz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ce5e3b116so25708005ad.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 12:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731098094; x=1731702894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTOU2n4qZ4+Wnk2OsQVQ6Jg0iFcr/tKFQpARLpPpg8Q=;
        b=E0qSAajz2SMFGFLvSDOFyZStpMjKjNtvOlvJR08vyTCavxya7lyXKiuRH55pJNFskg
         j9RQzNqEcR9G+BngSt7Fzm1WTj/oFL/j+uILV6G4B1sImj207BJNkFRxwC9gNEuijPYi
         mrX6TSLuyCmEgAI6nyPL6xh3QDPRYMtlNbiPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731098094; x=1731702894;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vTOU2n4qZ4+Wnk2OsQVQ6Jg0iFcr/tKFQpARLpPpg8Q=;
        b=GU9a9diRHUEvxrwzxY3AtVhPHTxuSzy+qxMi8UOy1l7q6IEFZ1R6hQS9ISDJq/njKs
         H8oDQ7nWXNjDYa2OJvGGLwHx5jn8ZaJ8ipZOWYHr8vq9h++ZvxmRdRJBWwu5LZNbzJJ1
         2YwCczaORRRfw7g/jKec74fxW9Q5hU/8GMggczghXPYzanjHV3yMDl4tDsDspn/U4pDM
         jlijts33W9QF4exah4Qc8CnGSg1h39z7l6uzkwYA4zOcDhL+JkIEI82Hnxo5c1dUTfI/
         +P2NEUeUQiiT44KMvWJ3xcy0147WoumJpvAHvJ8noP2LXC5FeU1EQfokUwdhe4T5MC3B
         N0Aw==
X-Forwarded-Encrypted: i=1; AJvYcCX4i3B3CofvLzjKOd/qVcQNvyXSHbr3nCgCsZwbOuXYYCmjQA1/guWNHHJawYztkF0cipNnRKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssQBcklSVQtvN9fGwy5YPmOjnrcDAmeOCkc8bAPSujrPZeG4c
	3Ox8Vu9l1n4A9a8iBFo77WtLBJbmZDs79gyG+SMC6Q6oWmWIYevCLFaXJQ6l7tU=
X-Google-Smtp-Source: AGHT+IEr8LBrTlRt+5DGFrvZz/WyS/B+y64pGuoitL0xJBcAhbzPqP9aRalyL7YyfN+nACNVqzJyTw==
X-Received: by 2002:a17:902:e843:b0:206:a87c:2864 with SMTP id d9443c01a7336-21183e11d99mr51521505ad.42.1731098092134;
        Fri, 08 Nov 2024 12:34:52 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc803dsm35176365ad.12.2024.11.08.12.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 12:34:51 -0800 (PST)
Date: Fri, 8 Nov 2024 12:34:49 -0800
From: Joe Damato <jdamato@fastly.com>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, davem@davemloft.net, mkubecek@suse.cz,
	kuba@kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH ethtool-next] rxclass: Make output for RSS context action
 explicit
Message-ID: <Zy516d25BMTUWEo4@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Edward Cree <ecree.xilinx@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
	davem@davemloft.net, mkubecek@suse.cz, kuba@kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, kernel-team@meta.com
References: <890cd515345f7c1ed6fba4bf0e43c53b34ccefaa.1731094323.git.dxu@dxuuu.xyz>
 <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2eb6ca-0f79-26a7-0e61-6450b7f5a9a2@gmail.com>

On Fri, Nov 08, 2024 at 07:56:41PM +0000, Edward Cree wrote:
> On 08/11/2024 19:32, Daniel Xu wrote:
> > Currently, if the action for an ntuple rule is to redirect to an RSS
> > context, the RSS context is printed as an attribute. At the same time,
> > a wrong action is printed. For example:
> > 
> >     # ethtool -X eth0 hfunc toeplitz context new start 24 equal 8
> >     New RSS context is 1
> > 
> >     # ethtool -N eth0 flow-type ip6 dst-ip $IP6 context 1
> >     Added rule with ID 0
> > 
> >     # ethtool -n eth0 rule 0
> >     Filter: 0
> >             Rule Type: Raw IPv6
> >             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
> >             Dest IP addr: <redacted> mask: ::
> >             Traffic Class: 0x0 mask: 0xff
> >             Protocol: 0 mask: 0xff
> >             L4 bytes: 0x0 mask: 0xffffffff
> >             RSS Context ID: 1
> >             Action: Direct to queue 0
> > 
> > This is wrong and misleading. Fix by treating RSS context as a explicit
> > action. The new output looks like this:
> > 
> >     # ./ethtool -n eth0 rule 0
> >     Filter: 0
> >             Rule Type: Raw IPv6
> >             Src IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
> >             Dest IP addr: <redacted> mask: ::
> >             Traffic Class: 0x0 mask: 0xff
> >             Protocol: 0 mask: 0xff
> >             L4 bytes: 0x0 mask: 0xffffffff
> >             Action: Direct to RSS context id 1
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> I believe this patch is incorrect.  My understanding is that on
>  packet reception, the integer returned from the RSS indirection
>  table is *added* to the queue number from the ntuple rule, so
>  that for instance the same indirection table can be used for one
>  rule distributing packets over queues 0-3 and for another rule
>  distributing a different subset of packets over queues 4-7.
> I'm not sure if this behaviour is documented anywhere, and
>  different NICs may have different interpretations, but this is
>  how sfc ef10 behaves.

I just wanted to chime in and say that my understanding has always
been more aligned with Daniel's and I had also found the ethtool
output confusing when directing flows that match a rule to a custom
context.

If Daniel's patch is wrong (I don't know enough to say if it is or
not), would it be possible to have some alternate ethtool output
that's less confusing? Or for this specific output to be outlined in
the documentation somewhere?

