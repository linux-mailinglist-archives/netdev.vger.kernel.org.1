Return-Path: <netdev+bounces-213847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC7B270EA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864F51CE0C11
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ADB279DAA;
	Thu, 14 Aug 2025 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4zJQZk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B112798E1;
	Thu, 14 Aug 2025 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755207467; cv=none; b=g7RGojUFrcVoWySjVJcKcGVU5XmKE0xqW3sOqtkoiOM88JNwIhbf+W0k418qFr3cRtFRjk9arQCXqcd/ld53V0XYvF7dvQPaX56+hJvK7R95SBkmiKqQl8XbMJkRPjZCo+27E3K2E/9R6tkAIykmoT/iT7kqEFsxy7X1bCyeE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755207467; c=relaxed/simple;
	bh=o02N445rRoeQTRrB+aNxGiyHOWW2iVqXtaa4iVa67qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyN4RMxDLQjXBIFa5jJeeZ2MeU0srWNJDtphS6//NdnL5lD//2e7UOt+UlUhqHhQMyHBF1FKt8jqdMWeiECfIE36IvxY9bcOP8Wz22sBaTIuvUsJM1fs03hB/GfYCg35Dt57mhiixui0Kq9JhAiwZCyl+OYNGVmtzwXibGfMkyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4zJQZk8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e20aadso1870102a91.2;
        Thu, 14 Aug 2025 14:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755207465; x=1755812265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vYw3GsEP5T/zhqlLRwEN+W3JUIy6Z3umGKTorlB7Ks8=;
        b=P4zJQZk85oKvHdLmVna08+y1ZE2JLha163oV5ffL7U3AfWYW7g4okQIP3Wr/BlLjah
         T/Kl/GTuYoyqP+x7NLXLMdRaTnXv12kUfmcRyxc7EF3CR9YyEEC2/bLKSQ8ikOsr9J4V
         g3piz6vrPnqk/cPOuRWMnmsZlyK7kdZZidlrpsl6PDKRMPEKfT9xg1Px4hAAfriBI1ws
         OChm3IiXGczb+aeRcvvugZOLjNsNZAMOPpkaoP9uQcCjisdBdPkg43RZz2r1V3hXXrK1
         AhbYiiSC9CGokuQQ/BVEQvEGdNmw9vGjUvrRzlFG9BBrBCwyLcJsUdTMmwE0NBUVltMX
         4neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755207465; x=1755812265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYw3GsEP5T/zhqlLRwEN+W3JUIy6Z3umGKTorlB7Ks8=;
        b=V57WO6lB1/0OXZYxgeBrMZWfPKgscWvjNRsbccqyfX7ggEwNls+QswsY+qz368nXAG
         nJr6yqR/AzsG6WP0Tf7tB1t9sK00L35SRmT18E/9+JrXtXhpOvlDLOBBSLma1bBzDZnc
         Izkmqf7ZSGJhYuGWEphtPH6RIx/CGkehJMot5Uz9cGazCClKrJeJWLBPv2XfS+mtlF5D
         tzUN0HMMlHPELSBlGglkPzLz5FRPjAEbZJyMQt4hA2ER89WMfPot+7VzpuTwwcEzyZJY
         jfHms8vu71d3lQAdIQEIFyKT0XaS076y+XHJ5QUcvCtTpTuYWf7PDqp5ibTPHbo5Rw32
         E2Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWCs0S5fjxcNMwnsz9RuEUOR3DfVrNBbReoYXe7RZgLnOh3A/say37HVKUsc5YAe125pd9i7EF2@vger.kernel.org, AJvYcCWEyCnBg88oT/CB3yB+zQX/7MBtvnX75gJiDRDDy+1iWvaTImbScSUXqMLmYjKkbU0xKLUWVjwcGAEGWf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxiRycwmF/mPODy8mRh1kezzJt5/ZHu8PtMX0Be3UUMSXrZlUE
	KBGQF0AvwHri42aIiZC6syW8Tkw32P4KfGczz56HahC0I7UrVTTwW1om
X-Gm-Gg: ASbGncu2prS5js8k1AaFypFWcnZwgUvOM82r/QFCUHE1MMdB8FU2j4evmQ21UCUT7Oe
	jInMcolJPbelTsSnBbZ9EWFam2mxEcV0xKEQvyQllCHy4J3nLmkpK81iz7hkCXFdZ1/T8Wcovjc
	hb5FKkXs9HFPGUxaenqmEzVPgHVlP67Ooe0xrkPNW0W6szW6uKDOmVqte9zopz76XXxEtB53UuX
	oca7W/vdUs4/NckqW5I5C1xDhnEeMTPTkluuDlz9UpfvvdIuEkrBGBfDhSjEhRq0HEHnYbHkxyD
	ATpRwf7DPpFxwqgj2jBzhdP9KTru7NTSeT0E3xgtng9y2nNBBQU4CjdnGT09FLpTeskTjQyXQiB
	WAnZOYkYYjRq8O5/AxKPsZA==
X-Google-Smtp-Source: AGHT+IFCbK4yM42Aj+5kTYh4/wqb1OFptHIo/GuiobZceKUu7nSQyGKoXcCLUpNsT+zfbVZbDEr6zQ==
X-Received: by 2002:a17:90b:1b47:b0:323:28cc:7706 with SMTP id 98e67ed59e1d1-32328cc78e4mr6874379a91.2.1755207465330;
        Thu, 14 Aug 2025 14:37:45 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330db1784sm2830169a91.0.2025.08.14.14.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 14:37:44 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:37:42 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: openvswitch: Use for_each_cpu_from() where
 appropriate
Message-ID: <aJ5XJmDa-Ltpdmn3@yury>
References: <20250814195838.388693-1-yury.norov@gmail.com>
 <c5b583a8-65da-4adb-8cf1-73bf679c0593@ovn.org>
 <aJ5Pl1i0RczgaHyI@yury>
 <2dc70249-7de2-4178-9184-2d50cc0dffe9@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dc70249-7de2-4178-9184-2d50cc0dffe9@ovn.org>

On Thu, Aug 14, 2025 at 11:21:02PM +0200, Ilya Maximets wrote:
> On 8/14/25 11:05 PM, Yury Norov wrote:
> > On Thu, Aug 14, 2025 at 10:49:30PM +0200, Ilya Maximets wrote:
> >> On 8/14/25 9:58 PM, Yury Norov wrote:
> >>> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> >>>
> >>> Openvswitch opencodes for_each_cpu_from(). Fix it and drop some
> >>> housekeeping code.
> >>>
> >>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> >>> ---
> >>>  net/openvswitch/flow.c       | 14 ++++++--------
> >>>  net/openvswitch/flow_table.c |  8 ++++----
> >>>  2 files changed, 10 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
> >>> index b80bd3a90773..b464ab120731 100644
> >>> --- a/net/openvswitch/flow.c
> >>> +++ b/net/openvswitch/flow.c
> >>> @@ -129,15 +129,14 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
> >>>  			struct ovs_flow_stats *ovs_stats,
> >>>  			unsigned long *used, __be16 *tcp_flags)
> >>>  {
> >>> -	int cpu;
> >>> +	/* CPU 0 is always considered */
> >>> +	unsigned int cpu = 1;
> >>
> >> Hmm.  I'm a bit confused here.  Where is CPU 0 considered if we start
> >> iteration from 1?
> > 
> > I didn't touch this part of the original comment, as you see, and I'm
> > not a domain expert, so don't know what does this wording mean.
> > 
> > Most likely 'always considered' means that CPU0 is not accounted in this
> > statistics.
> >   
> >>>  	*used = 0;
> >>>  	*tcp_flags = 0;
> >>>  	memset(ovs_stats, 0, sizeof(*ovs_stats));
> >>>  
> >>> -	/* We open code this to make sure cpu 0 is always considered */
> >>> -	for (cpu = 0; cpu < nr_cpu_ids;
> >>> -	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
> >>> +	for_each_cpu_from(cpu, flow->cpu_used_mask) {
> >>
> >> And why it needs to be a for_each_cpu_from() and not just for_each_cpu() ?
> > 
> > The original code explicitly ignores CPU0.
> 
> No, it's not.  The loop explicitly starts from zero.  And the comments
> are saying that the loop is open-coded specifically to always have zero
> in the iteration.

OK, I see now. That indentation has fooled me. So the comment means
that CPU0 is included even if flow->cpu_used_mask has it cleared. And
to avoid opencoding, we need to do like:
        
        for_each_cpu_or(cpu, flow->cpu_used_mask, cpumask_of(0))

I'll send v2 shortly.

Thanks for pointing to this, eagle eye :).

