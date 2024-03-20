Return-Path: <netdev+bounces-80796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D65288119B
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164D7284F64
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB763FB85;
	Wed, 20 Mar 2024 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NSUiLflQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D143DBB7
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710937437; cv=none; b=Nv7nMCdsFftQ/jw2Wg4+rNoFpEi1b+g8kZDrV+1iYoOkm7r78ALRhvuAP8bkmlDwFZxeJrsjt32KHSpSZS95fjDtJRm79oAeLZC5hza3n2d79P1Fr3yVCBB1SO9fiG/z352OniaSgHRL/P5wAo2QD4nrMh2+efy8BI204t6ag+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710937437; c=relaxed/simple;
	bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEJ5XSZSYneH1Z7r08pri+gZRx5YarEJr3AH7Y3nCN0J+lGlfxjWeBCKB/tFAi86NCDoERQ2jl1tcq1NIrpN/8S5keBXtB9yWOZf+joLfi/oGoS8TDrTHXgpI/Mt6w5+DnqeSKAxOO9CLbiFWUYrMqsVfGIYWxgeWccUS9Rnsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NSUiLflQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4146e9e45c8so1968685e9.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710937433; x=1711542233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
        b=NSUiLflQsFZrJcTy9HNt0D+03APSNlTLySOzRCr8/z2df6InbuxCojYJqk9QBWxlVD
         1TfM4ipK4kasMHBrNmQAKQW8o2MdNQPEoZecWJGCUFyMBdyCpUEzdFa5CeCCo6dDcSxX
         JpmU4mwSmSNKXGhZ0rFP0O3wlPwJrri9aN5L4N7qLPhtSurYDoaVlUBGAppPahKDNstu
         ENtke0L9J4A29aWIPAnlyZMWrt/NgfyDmW0tdYU48vaIF1vuZCFsfZR64CS1QE2f22xQ
         JD0S0MIF+TmebuIIVrvcYBWjQSsF1cn7/k7c8UeLHPaJE2EUIJS+fVrucMO6+yfr3yct
         ulLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710937433; x=1711542233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=256hIVOWqKGNs0clZdEecQjT2nDPiAh+uHQB0f0lp0s=;
        b=tRLbCzRz2/dNu3nsh3FjvHtED3GKchSxSGcC9eFkVSXgSwl3NPKeskmvXgR7GKc0yw
         Y46NmRKHy5+iWsHYvP4usaUb3HQE2C+WDxx2Fa+nyacS0T0vI57aCJq1Om9gVU9rXXFR
         GRzgJ84SJtJOxsrQamr+8HCTot93ej/pL+/yiggzpLltDw8r+fqnu9NZIrkQf4G74sIA
         zLvG8a0it1Fu/WCy9JUStZR2VfqZ7w7coFwKHMA7HknZPi3p7IAVvN+9l197lrp+PDvT
         IVT/1McFKrlEsnLdlfoAHb9t0c+6iVmddbvXHecbx+58OLQB4RZnl/VHoU1jygCqRBFn
         IHAw==
X-Forwarded-Encrypted: i=1; AJvYcCUilYAcBzYVWtOMDcgKtaJmuqduRPeRxpU5zI2ANloRv2HUCY0kugzUz9zKZNaiRgDA7mRci+ZlRhSocFE81qxKXmd6k5Ke
X-Gm-Message-State: AOJu0YxNEOYGl2FdO97FNEb7hnUoPSemRV8EtDRToFvBPMuFj+VL365u
	LLJznlPKSpN/jMelRIlnaSV5LiSH5UFNNFaC2/uVD72dCp/9kjbTVI2BZlFMd9w=
X-Google-Smtp-Source: AGHT+IEeP+QulfChhn2oDlevD/cXp00IH9MWfPkU71hEwGa+tm6JDBn0nfQzXtMpTmqHCqJzlI6TMw==
X-Received: by 2002:a7b:cbd0:0:b0:414:6467:d8e9 with SMTP id n16-20020a7bcbd0000000b004146467d8e9mr2347163wmi.17.1710937433216;
        Wed, 20 Mar 2024 05:23:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z20-20020a05600c0a1400b004146c80ade5sm1725802wmp.12.2024.03.20.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 05:23:52 -0700 (PDT)
Date: Wed, 20 Mar 2024 13:23:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Michael  S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <ZfrVVGUG5rGZxjRx@nanopsycho>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
 <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
 <ZfgxSug4sekWGyNd@nanopsycho>
 <316ea06417279a45d2d54bf4cc4afd2d775b419a.camel@redhat.com>
 <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710921861.9268863-1-xuanzhuo@linux.alibaba.com>

Wed, Mar 20, 2024 at 09:04:21AM CET, xuanzhuo@linux.alibaba.com wrote:
>On Tue, 19 Mar 2024 11:12:23 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
>> On Mon, 2024-03-18 at 13:19 +0100, Jiri Pirko wrote:
>> > Mon, Mar 18, 2024 at 12:53:38PM CET, xuanzhuo@linux.alibaba.com wrote:
>> > > On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
>> > > > > As the spec:
>> > > > >
>> > > > > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>> > > > >
>> > > > > The virtio net supports to get device stats.
>> > > > >
>> > > > > Please review.
>> > > >
>> > > > net-next is closed. Please resubmit next week.
>> > >
>> > >
>> > > For review.
>> >
>> > RFC, or wait.
>>
>> @Xuan, please note that you received exactly the same feedback on your
>> previous submission, a few days ago. While I do understand the legit
>> interest in reviews, ignoring explicit feedback tend to bring no
>> feedback at all.
>
>Sorry.
>
>I have a question regarding the workflow for feature discussions. If we
>consistently engage in discussions about a particular feature, this may result
>in the submission of multiple patch sets. In light of this, should we modify the
>usage of "PATCH" or "RFC" in our submissions depending on whether the merge

No, just wait 2 weeks, simple.


>window is open or closed? This causes the title of our patch sets to keep
>changing.
>
>Or I miss something.
>
>
>Thanks.
>
>
>>
>> Paolo
>>

