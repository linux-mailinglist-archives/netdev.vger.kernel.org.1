Return-Path: <netdev+bounces-106564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B19916D59
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F1D1F25566
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019016F91B;
	Tue, 25 Jun 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2QPMugl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72981172BC2
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330180; cv=none; b=gJOQPD65j49i5j0PEQbreyEaV8Ag4uoUDBrHzSgMjLAQAbDRcT4j2ClLML3QP42r6vwccxcNXirP0rE5gDiJ74HPttVg6lVOwgCy1r96IjY5ElrOCKZUnKV898zSZSQFNSpM+cmcKELOud+nNNTKrKcN1XlEG9NS3B1seNtzRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330180; c=relaxed/simple;
	bh=txNOGyRY53dlUad69BGVxtVaxoLEp4azdwC4bHVsxy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDK7aqk5E74TI9p2H09hoPkRgvBtBmmfYHgXTYwc9thvrYIoMQeXZQzRvqYAvKVZrZHh09qk/cHvWqUXU5QD6u4nxzaiQx4q3vivJ1O7IQdU3Ddd2HXNH/SHrQ2tzfvR7h3ylbIio5FMmyhIh4L5GQQoDChqNo3SvsjRwowTrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2QPMugl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719330175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHjDjQkkVV5MnIFI/wThRjGzfK8qMKOd15SXf1Vtg8o=;
	b=a2QPMuglKsyHg0VK5LmuRJmGGg5DKfdrAFQivbJtH+CJrGw+N5Iynx0yW+gnKGiFFuLvGD
	M70ScZzuP+UBR2sTouHP7V+IBKFa5NdSdiYY/G7/5Kqlykk+x+ggxL7azJrwPh5LJ0BxbZ
	sehRbadENwh2Uo6rt5gAOAaEjX/KiaQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-thVqwetgPQGkGi_TcQnQOw-1; Tue, 25 Jun 2024 11:42:52 -0400
X-MC-Unique: thVqwetgPQGkGi_TcQnQOw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79c10dc2365so40550085a.0
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330171; x=1719934971;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHjDjQkkVV5MnIFI/wThRjGzfK8qMKOd15SXf1Vtg8o=;
        b=DP/zyF7fsDr972BzOyEw6fGWhI7XhwvmkRMwyHq9JpRkSJ45Lj1+SqZsDId0Xz5BqC
         obSGnM4stuIAOf+bRuq8IRu4y5JeyFx6CpNSclhr02ZmW0cm6Eutj6i+3yosIzSMi1cl
         uACrmD4POnJnzSlQOQPQqhKmbPKdiFJxbM3Duw/uXByO8DFYPZC38ktUB8u2aLjlImsV
         KbXUqlYSYa7T8BVI/xV5UXaAo5WlQi2E54edwhZ3PjVwQSeFgrzI6RRITMeqCUJs2+Ci
         2NSqELxL0N1EsBWEKew5SOO/TupbBCdq/fzQW74GC6pmwlbmbAEUu+3o4tLgDQYhGjI1
         16Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVk7efGwaX3WH1A5/PqXHsRESZfF6eGzAE+XXXnLEqL8VdorCLUWBb1raIIjcdFWiRpKqpdWV1fzplwsO3oUGbFalnZEMmC
X-Gm-Message-State: AOJu0Ywylp9rCBKNIjndeMAL+VU7//WjOBThkCyStaNvjBqkX6GlB6qi
	Wm7JAqpnNTDWWm3S4HSiUcZ5Bw0IwvWLWr0OQFSb5KSMw4cg5VbBwbztAC9efZQZShwSdef2Sh4
	pW5P4AoP4iPd1n24I3AviEp/ELC67pWGYGriB+gsPaxy8IK7WLiCgdw==
X-Received: by 2002:a05:620a:17a0:b0:795:7abd:12e2 with SMTP id af79cd13be357-79bfd66d20amr693260385a.17.1719330171150;
        Tue, 25 Jun 2024 08:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHva43U36s/7Ml2cOyugoxc0TbehJGQitemaODb2b3+TkL7l4BU91CFLUjdniODZSXocu0RnA==
X-Received: by 2002:a05:620a:17a0:b0:795:7abd:12e2 with SMTP id af79cd13be357-79bfd66d20amr693243585a.17.1719330168725;
        Tue, 25 Jun 2024 08:42:48 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91f16esm415648285a.77.2024.06.25.08.42.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2024 08:42:48 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:41:49 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240625174149.3d37ed88@elisabeth>
In-Reply-To: <20240625070654.6a00efef@kernel.org>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	<f7th6dhgnvm.fsf@redhat.com>
	<20240625070654.6a00efef@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 07:06:54 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 25 Jun 2024 09:20:29 -0400 Aaron Conole wrote:
> > > I'm still wondering if the issue is Kconfig-related (plus possibly bad
> > > interaction with vng). I don't see the OVS knob enabled in the self-
> > > tests config. If it's implied by some other knob, and ends-up being
> > > selected as a module, vng could stumble upon loading the module at
> > > runtime, especially on incremental build (at least I experience that
> > > problem locally). I'm not even sure if the KCI is building
> > > incrementally or not, so all the above could is quite a wild guess.
> > >
> > > In any case I think adding the explicit CONFIG_OPENVSWITCH=y the
> > > selftest config would make the scenario more well defined.    
> > 
> > That is in 7/7 - but there was a collision with a netfilter knob getting
> > turned on.  I can repost it as-is (just after rebasing) if you think
> > that is the only issue.  
> 
> Sorry for not checking it earlier, looks like the runner was missing
> pyroute:
> 
> # python3 ./tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> Need to install the python pyroute2 package >= 0.6.
> 
> I guess run_cmd counter-productively eats the stderr output ? :(

Yes, otherwise it's rather noisy, but you can run the thing with
VERBOSE=1, see also 56490b623aa0 ("selftests: Add debugging options to
pmtu.sh").

Before that change, we didn't eat standard error, but in the general
case I guess it's quite an improvement.

-- 
Stefano


