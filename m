Return-Path: <netdev+bounces-171637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC1A4DEE9
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9851771AC
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621B204859;
	Tue,  4 Mar 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="z+bptIGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769432046AD
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093908; cv=none; b=Gg5RB9fHtKea27ZSU6eDTHnqtxlp5DgfGTXrB0xWia1efjhHNST1s6s8Wq1x6ATVvN0ORKpk+1vprT9TXuOh8XV5262dfLsEyefjH38rv+ph/vtdGoDTc7MS0X2Qg31/9nujiRKzi68/rl31gOdzTn8vY+GyiJU24CGLxj3qgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093908; c=relaxed/simple;
	bh=tDgS2N+oEjaE59AQhUdYRwDy42rEFkMF2eAp3yg7I+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUVtE9UUi5MNaO9jfs+JgMKev8cT8n28EsOwAweLPFuN9KAIAjesF+JGERMBCeypqZBbX2H2EG5bp+wzlpW24nMDD/Gn1g/EJXQW2p6AOwfo5tIUOk08fEwtwBXRWBVNXrCA1tdZdXx9gJ9l9XTq8rK4ErEqMvBRtkW5Dw9U1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=z+bptIGK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390cf7458f5so5225982f8f.2
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 05:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741093904; x=1741698704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6csbr7N97SmUY46nLkO7qroozpuU+v+KaDyJZFwj+a0=;
        b=z+bptIGKYTFqpnYASRCYsa5mu+t7ujC8SOc/BuPePLwFLqEuJQVQtFcXWHetVGqeBG
         OMuLd6vnEa9/jmmCgmPkiH4RQMVgrNmrOFY7zCmp7XwNB1tXzXajjINANg1AmhQZVJbb
         /qjChC/PGSXdl1CiDolpw2OtFJUsgNRKcDly5rfJgPBX+0od9dIPVv9J3UIN8zHsgVYx
         ERHhVi9fyQi8U+zunuvBwyJwsspKpzXZfdSYRlpVlqnlgZ8nNCOWRF3ha8vySZ0LcwLm
         p/P/2Ks3ajlFFpbBN2GVuv04jyQfjVXdrqS3BcTxtLrIdizOr6gewomyh9GeC7TRXqzj
         oIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093904; x=1741698704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6csbr7N97SmUY46nLkO7qroozpuU+v+KaDyJZFwj+a0=;
        b=DkTeeKMqn+4nvep3jSjqBdX1OhCpJg227D73Fd1tp1R3P/7dR/xny2bjHPcpniPzn9
         K38uf97FPhooxJY2+rnkeQUMD4igRw9/I1De+SR+KuVpmC4mKCZ8L54sSBuHknJpjxe3
         w+DKk8J6oFDwby27f+vAt96qIFVDLWRcUKvoM/VI5OREnZqMuOI4Ea/SCojCUsmEbu//
         O1YTe2JShJgAfvpq+gVU8OLWGPcyyuAc6hxWi8nwMuGF12QgUjwrYHbPObTnTs4AMHbc
         N7EDSo4nEsH8mntaryr7VvXrd3ivGul6c+V7WxKZpJdBGoyLqKqKS8FpPm9J1dkUa727
         zERg==
X-Forwarded-Encrypted: i=1; AJvYcCVwaJ0dcejGWU3WXMPWX50jpfRhxvzhJdDbNfK+8ocbEBGsjbDogOYJRhPI66zkQ4rzQilzfos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7ZujKnDuJejj56LhSUH1HdBtKa95jDI4J3WB0Y9NudMJbyhP
	jKADoQb3ULV8jl48uTpoOGJY6D8kUjKTCszvtqeGEfK5/JNu12Zaktldo0glEOk=
X-Gm-Gg: ASbGncvo/9M9OPyXbmLQJSOrgls9XoLdQ2ZCI0c2XJlFcN6RF+Yg2d+RhVAr7Chdp3Q
	y9Mx3rXDa/k04LCF4+dpLIs6HzvLsJkUH2ODOIqqYq1Xm5EdW173sN9mI67++drOkrOP+5mgt8L
	9OAF7IDAocEPP3OFbsJz/UKJf4FBXIxfFMpQKoSHEllzpPd5lLkEY3leKtBt8k1uYSh9b7tLs51
	RFFjPn/MREgcnH/tRQYH6Dq2PxtMKP7+x7+STwwgi0DMVeuYNCCaO8ilvDC1mB5diq0Zg6koxPM
	TP1oke7ZeKKOaaqiJLSvK9tlT9O62YrccfuHgKwKZWrTXNYToihDMsMVChOqVWu0YOCiMpg8
X-Google-Smtp-Source: AGHT+IEoaw6OyEzUKOB9UT6taJ+N313+wMgHvOG7uqiuGpJnD+3ybJTiUnotZ/4iv4k8s+zpwaLR9g==
X-Received: by 2002:a5d:60c2:0:b0:38f:3245:21fc with SMTP id ffacd0b85a97d-390eca257e4mr13870699f8f.50.1741093904421;
        Tue, 04 Mar 2025 05:11:44 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc88f3a2esm46697415e9.27.2025.03.04.05.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:11:43 -0800 (PST)
Date: Tue, 4 Mar 2025 14:11:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <ytupptfmds5nptspek6qvraotyzrky3gzjhzkuvt7magplva4f@dpusiuluch3a>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
 <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
 <20250218182130.757cc582@kernel.org>
 <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
 <20250225174005.189f048d@kernel.org>
 <wgbtvsogtf4wgxyz7q4i6etcvlvk6oi3xyckie2f7mwb3gyrl4@m7ybivypoojl>
 <20250226185310.42305482@kernel.org>
 <kmjgcuyao7a7zb2u4554rj724ucpd2xqmf5yru4spdqim7zafk@2ry67hbehjgx>
 <20250303140623.5df9f990@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303140623.5df9f990@kernel.org>

Mon, Mar 03, 2025 at 11:06:23PM +0100, kuba@kernel.org wrote:
>On Thu, 27 Feb 2025 13:22:25 +0100 Jiri Pirko wrote:
>> >> I'm not sure how you imagine getting rid of them. One PCI PF
>> >> instantiates one devlink now. There are lots of configuration (e.g. params)
>> >> that is per-PF. You need this instance for that, how else would you do
>> >> per-PF things on shared ASIC instance?  
>> >
>> >There are per-PF ports, right?  
>> 
>> Depends. On normal host sr-iov, no. On smartnic where you have PF in
>> host, yes.
>
>Yet another "great choice" in mlx5 other drivers have foreseen
>problems with and avoided.

What do you mean? How else to model it? Do you suggest having PF devlink
port for the PF that instantiates? That would sound like Uroboros to me.


>
>> >> Creating SFs is per-PF operation for example. I didn't to thorough
>> >> analysis, but I'm sure there are couple of per-PF things like these.  
>> >
>> >Seems like adding a port attribute to SF creation would be a much
>> >smaller extension than adding a layer of objects.
>> >  
>> >> Also not breaking the existing users may be an argument to keep per-PF
>> >> instances.  
>> >
>> >We're talking about multi-PF devices only. Besides pretty sure we 
>> >moved multiple params and health reporters to be per port, so IDK 
>> >what changed now.  
>> 
>> Looks like pretty much all current NICs are multi-PFs, aren't they?
>
>Not in a way which requires cross-port state sharing, no.
>You should know this.

This is not about cross-port state sharing. This is about per-PF
configuration. What am I missing?


