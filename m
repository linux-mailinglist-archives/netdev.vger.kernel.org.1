Return-Path: <netdev+bounces-94612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839018BFFF1
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B522D1C208FA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930884A39;
	Wed,  8 May 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGkFL2bG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA459165
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178413; cv=none; b=tNq+d1RYpWXjrFoGTQ57tswcZHrqGWd14cMzirLPEGYV7oGb91SJ7Khghrgf4PiNkJzHItGzMU5lQ5UR1CW9teKApAId3PRZLL24ZYJOkukXnje9/rtQYFxBHMg1/pCvzoIIz6ZICPqw1acuZlbBv6k5i09CJBNZ5UfEbXkqA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178413; c=relaxed/simple;
	bh=cVjCEwd3gVZ8f6QvSaqDuWh9CZede2kpUEEDA7qOvKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7phuLunrFjYoWxIM/hKsW4g8wBIAA3NKxpxOFUwo25MVcsbp/7qEYxATsPIvgdebC3dgYT3w6tbucdkCSlD2Ql3WNgTL8HrEidSB1KXQ3texiuHbOu+O2SGlpG0JhXLn68bkxv9/WalFbUASaQP2SDKTidb7whgSPKa/0uZETw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGkFL2bG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso4200754b3a.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715178411; x=1715783211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9q9hz/JKnm2PviX/WgqNY9EhNMfYPqaR2aV3sphxsrk=;
        b=PGkFL2bG10GZMst1P3X/258EEvUbE6eXHSGpknpXpuhPzyoObVhtL5pAYk6FxIOgXc
         nfp/RpMyIxdWUIAY0tYEpUKKzcVE6xW2sDcMDW/E1Efxpqk503tEnNRJu8AizgqD3M2o
         Wlpt3RW0/uzAZh+L+rWDdfcXPn7vMBQjIttCNzwxQhTz3XZB9LsuF9ee4gQryJx6MI4g
         a31y2r0iZJ3uor9CpwAZuKTDMaAW32TvrOblSJR7HmIE2zxqcJSa55Bx0m8olsWnvuoj
         FhmTMNHmMTZV+RYH5uaV6wB+cZ3KlXDJvwZAe+BB8GkltQ4wSTxbMLXmBF2AOwf4+Sz5
         h6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178411; x=1715783211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q9hz/JKnm2PviX/WgqNY9EhNMfYPqaR2aV3sphxsrk=;
        b=HAmMszqydN4BpAZto1sCAzrAOeY1gXWuN9pztd8cQlx8wMhq99brJrudCOjld6RAYi
         ttldGDezN90Nrt/S7uUhuokRWf11nSRW0TTnNg6qlBl1lG3lE040LCyeHfq+OCHkxbmI
         QOWsyeltJdgzW95ikEf9RvyXorcgp22aQlrRp4fo7MlxqzRN5z9msPAj1L4d3hdW95cA
         VApvSaJwM/YDNtlOMIoYUcK/3PbRcWg7IyFNHg17l+arACzzvU+C3Z8sLY44I9WEWibu
         oG9EPbVD9iyOWu27c9GpVb/Et/ZVU3xjJZ10AEfmS8uPClmP5EBVgZjGwffeaTjxZ+iI
         xp1Q==
X-Gm-Message-State: AOJu0YxdNaEahvg8V3DJTeKxo804Lo6BO2iG6W7ZiSvy1DrxVPbSepEH
	QX4JAwosGRD2nFEdlolsbvQZEQY5WjpCk535uAiJYph5GvPVrvCb
X-Google-Smtp-Source: AGHT+IGlPhHeo1E7FFre9g73t7p99FD6GwvFhHOWXuPrePj2CFZp2qE5jwKHxSdDK9mpi17lyTftnA==
X-Received: by 2002:a05:6a21:3296:b0:1af:b0b6:a35f with SMTP id adf61e73a8af0-1afc8d05bcdmr3485867637.2.1715178411432;
        Wed, 08 May 2024 07:26:51 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b006eac9eb84besm11182599pfh.204.2024.05.08.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:26:51 -0700 (PDT)
Date: Wed, 8 May 2024 22:26:46 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCHv2 net] ipv6: sr: fix invalid unregister error path
Message-ID: <ZjuLplygL6JudnlF@Laptop-X1>
References: <20240508025502.3928296-1-liuhangbin@gmail.com>
 <20240508094053.GA1738122@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508094053.GA1738122@kernel.org>

On Wed, May 08, 2024 at 10:40:53AM +0100, Simon Horman wrote:
> On Wed, May 08, 2024 at 10:55:02AM +0800, Hangbin Liu wrote:
> > The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
> > is not defined. In that case if seg6_hmac_init() fails, the
> > genl_unregister_family() isn't called.
> > 
> > At the same time, add seg6_local_exit() and fix the genl unregister order
> > in seg6_exit().
> 
> It seems that this fixes two, or perhaps three different problems.
> Perhaps we should consider two or three patches?

Yeah..
> 
> Also, could you explain the implications of changing the unregister order
> in the patch description: it should describe why a change is made.

Sure, I will.

> 
> > Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
> 
> I agree that the current manifestation of the first problem
> was introduced. But didn't a very similar problem exist before then?
> I suspect the fixes tag should refer to an earlier commit.

Yes, I will check previous commits.

> 
> > Reported-by: Guillaume Nault <gnault@redhat.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> I think these bugs are pretty good examples of why not
> to sprinkle #ifdef inside of functions - it makes the
> logic hard to reason with.
> 
> So while I agree that a minimal fix, along the lines of this patch, is
> suitable for 'net'. Could we consider, as a follow-up, refactoring the code
> to remove this #ifdef spaghetti? F.e. by providing dummy implementations
> of seg6_iptunnel_init()/seg6_iptunnel_exit() and so on.

Makes sense.

Thanks
Hangbin

