Return-Path: <netdev+bounces-71730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F0E854DC1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082291F210D1
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827345FB90;
	Wed, 14 Feb 2024 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1uFNsPA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35945D756
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927044; cv=none; b=KHdRqn6YfSa7jSrGCJrIjqTkptDxfDlZtWLitJFC5NjX0qI/lmNmut9wPOyEiSbaFD3DQLshFdbHDCi1txUxYR+LNiZuFNkMVYlTBfKZSiQK+cEKUg+SlRlwC+0TvQaI8EEvqXfWJqkmkoY1OGIT4byT0797Pnm+GFCSBc6LbCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927044; c=relaxed/simple;
	bh=30v3lYAtpaPYxSwiAPvY0qje6hvFiXSTCRdMDzvhhPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3Cll1vM0eQtsS9Kmkzkfq0K+U+/UOYlfwoKc0X911ggmIO037OZmjEa0Q/hI+GTBhdMAU0lwG3eSk6ouDu7kpS1H+DNun/OSYCD0NdIyqkisnow+9lKdKO1uAkwgVw3ozgO2e7VM352ZFFFPDycexmM6RuaK21Gbn/H/3ExKKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1uFNsPA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707927041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Sj5BEEhclo/uZN9ordtnjQEVq8f/n2e0/Z6sFTgpZc=;
	b=f1uFNsPAp85LMpaTLihbHfDd0iJ+pCgBJbg5Z+7h38/vJU9VeNLP1Xl5HZE4fjAAf5n8MA
	U3E3U5NekR+aeiVz2U2mqNmPXmXlQOi/q1mYBiXY/9axm1CvIpuxzVjNEuZwtPOosVTRt7
	QvXCGRkVSloXkwzYmvYZryDjqSRfaUM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-KvqY7AiiPzyK88Nl7WGgFA-1; Wed, 14 Feb 2024 11:10:40 -0500
X-MC-Unique: KvqY7AiiPzyK88Nl7WGgFA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33cf63e72b7so31805f8f.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 08:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927039; x=1708531839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Sj5BEEhclo/uZN9ordtnjQEVq8f/n2e0/Z6sFTgpZc=;
        b=xAoYLTNG+xx5va8vH8IkkIvIJhiB6TH4KLcw8A7EEf0nxHXjfEM/5fQ/Rik7lAzdCK
         YcI4WfRMDkksIPBVGmvrEoZcZePt4drzDBn8y4cz6iBsNs6MMY23VrBvYc5WVDdm96LS
         GRBwhCKvh+pcBOStvitVJdKq8aKF+8RuKbJr92n/J95S/j+dOMA/HGoP5Ai4gYZGXqdb
         BixT0+bMKVAQhirS3wJflMcMra9kvwGfF04CIkn2Xai0u1bJsgQu0DFRtginTWSqkMSy
         AayE3RHx3uoqW/QAznfkZzIU7y9bBTKV8uLnv7XnHzMcCZy9F4TxCgB934kCPrduJv1x
         xgBw==
X-Forwarded-Encrypted: i=1; AJvYcCUSE6Ap5HDAY0V2fkPqnCSSVxB2ZbLNx/MY+S5Tn+vRhFFxDNLC8VPxVterCIFf95/RFKAT0a52ZHeHcPuLIwCqU/qbQ1jr
X-Gm-Message-State: AOJu0YyU+wF6X7hjUPIjlH3rZUp3z8CHBCgY4B2+g6xGW3ljk/wKYQXU
	n+vo34mpayM9SKP9Sk5PnIS2ncqqwebYMt5ojcH1//fJt9lmEIGAnqoUEYvSFS609lN4F4FucnL
	CopXrZTYBTsABnQ5/SVoLAg6eb3Mz3OZeXTW31lMU+U47S4vzaw3G9A==
X-Received: by 2002:a5d:6588:0:b0:33b:61f7:1592 with SMTP id q8-20020a5d6588000000b0033b61f71592mr2235057wru.30.1707927039095;
        Wed, 14 Feb 2024 08:10:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmZb2B+VH2mzrfczdtynjptfWYPzTeIFTk+z6FjIf1xw0hIobcdwLLITxDW3Cqgfr7GrWp/A==
X-Received: by 2002:a5d:6588:0:b0:33b:61f7:1592 with SMTP id q8-20020a5d6588000000b0033b61f71592mr2235041wru.30.1707927038737;
        Wed, 14 Feb 2024 08:10:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXHBkBFwSKt1bjqAF1H+pmWUrreYllyoy+reIC9EDphYFD8O+aMeRNpSf+BaRqtTPQcv0C3iaV0rFRIhNYQa1BRLTeVMcydxZRG0mfmcoqEDj1hOZGS886zEDtJeTgHKN5WqR+akfX9XbEmsPVSnP2I6eKvZ99idhtQXaGHuWA9Cmh1BTF2le+zXmaqdNfOAhFsERM4kTofSbIGHxUCtEWWGGIQIpnUTcnxDnEP5D02B6rh85dBbSyL0cGhse0Iym93bIaW+L5FuFJWkzSDuOVLXFKwbI2dmzdy19ONHkJ2lg8F9PWB
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id bo26-20020a056000069a00b0033cd06387ddsm5441937wrb.82.2024.02.14.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 08:10:38 -0800 (PST)
Date: Wed, 14 Feb 2024 17:10:37 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	xiyou.wangcong@gmail.com, jiri@resnulli.us,
	shmulik.ladkani@gmail.com
Subject: Re: [PATCH net] net/sched: act_mirred: use the backlog for mirred
 ingress
Message-ID: <Zczl_QQ200PvyzH5@dcaratti.users.ipa.redhat.com>
References: <20240209235413.3717039-1-kuba@kernel.org>
 <CAM0EoMmXrLv4aPo1btG2_oi4fTX=gZzO90jyHQzWvM26ZUFbww@mail.gmail.com>
 <CAM0EoM=sUpX1yOL7yO5Z4UGOakxw1+GK97yqs4U5WyOy7U+SxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=sUpX1yOL7yO5Z4UGOakxw1+GK97yqs4U5WyOy7U+SxQ@mail.gmail.com>

On Wed, Feb 14, 2024 at 10:28:27AM -0500, Jamal Hadi Salim wrote:
> On Wed, Feb 14, 2024 at 10:11 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > On Fri, Feb 9, 2024 at 6:54 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > The test Davide added in commit ca22da2fbd69 ("act_mirred: use the backlog
> > > for nested calls to mirred ingress") hangs our testing VMs every 10 or so
> > > runs, with the familiar tcp_v4_rcv -> tcp_v4_rcv deadlock reported by
> > > lockdep.

[...]

> > Doing a quick test of this and other patch i saw..
> 
> 
> So tests pass - but on the list i only see one patch and the other is
> on lore, not sure how to ACK something that is not on email, but FWIW:
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> The second patch avoids the recursion issue (which was the root cause)
> and the first patch is really undoing ca22da2fbd693

If I well read, Jakub's patch [1] uses the backlog for egress->ingress
regardless of the "nest level": no more calls to netif_receive_skb():
It's the same as my initial proposal for fixing the OVS soft-lockup [2],
the code is different because now we have tcf_mirred_to_dev().

I'm ok with this solution, and maybe we need to re-think if it's
really a problem to loose the statistics for action subsequent to a
mirred redirect egress->ingress. IMHO it's not a problem to loose them:
if RPS or RX timestamping is enabled on the RX target device, we would
loose this information anyways (maybe this answers to Jiri's question
above in the thread).

The other patch [3] fixes the reported UAF, but if the Fixes: tag is
correct it will probably need some special care if it propagates to
stable branches.

thanks,
-- 
davide

[1] https://lore.kernel.org/netdev/20240209235413.3717039-1-kuba@kernel.org/
[2] https://lore.kernel.org/netdev/33dc43f587ec1388ba456b4915c75f02a8aae226.1663945716.git.dcaratti@redhat.com/ 
[3] https://lore.kernel.org/netdev/20240214033848.981211-2-kuba@kernel.org/


