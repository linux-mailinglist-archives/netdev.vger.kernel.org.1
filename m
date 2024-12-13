Return-Path: <netdev+bounces-151584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B519F01F8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 02:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DC6288523
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 01:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2571E2A1BB;
	Fri, 13 Dec 2024 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiQ5hBkw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641217C61
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734052741; cv=none; b=E+hmQqJ0peY9SUCAT1FTO2ZJq62O1kBVYix/bvowYGigolNT2aSVpnl927/zHzPmvXrQaOp22vB5d4R2lMGlq8CSMpeu0PqRhktDckbkikhqm4y38+7iJ+hvfm6hOTsUE4a23/5Ho6q0iYmNYvrJIpbhf4NEJGhD9BMOikub+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734052741; c=relaxed/simple;
	bh=SW6ovQJIjZkJmBRxQLGIsTOvaQ9ODv32lBKTsFw1sYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj5WlkJXUsSSBLw9QeItmK7+TuYlaHNC6J/nyE8wAc5E483k42EWobUXzAHVBb5Y2Z8qv5CLm9ZjuoVxZ5XuCZW/4WbeX7Sy3TEwITG0IlrI5sOG77vgE8qKAEM48e5/Qq0rHdPR2HA4STV+fIctnmkRhO4pImbAfWFkvonqk5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiQ5hBkw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-728f1e66418so1105703b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 17:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734052739; x=1734657539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mexmDLsHK0muZtBfCntlwGrXOj1KRLo9wqvnjNy8lYs=;
        b=KiQ5hBkw7o6+UShotU5wlZk+0UWJOxnSDuOJI549C06t+ei8xq3p2unFtL7nyClJuq
         yF9s1jyaifNx5Bp0DOu1JSpUmMlfN0o4i3a+E7lTTOB/6BdFK8jwJyS7eqISPXye3c33
         WuXqOdOreCMc9oQK/8lIl07GK5NmALFhXwJp2SehKeY4F7BGyBeFuO4aiJSaUXNxi1CZ
         oetLoTK2bXC7dk/nvgeB5TNPCpo+K257kyb+QOxk154WKnzr69g1bJAte1Ps+nZYYK87
         nnPYwPHOG/PYxZkYC3yyMQPJ48DvQ/EdZCM/CNHzf852iDDf8oXfMnMq5VXu3JIfCCS5
         ihfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734052739; x=1734657539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mexmDLsHK0muZtBfCntlwGrXOj1KRLo9wqvnjNy8lYs=;
        b=JUwdwy+rZSWfk+UIXX8+Tgz7lOSt/vmIihs1FnAwfqW6BWQYf3ACkEhS6qcTMzN/uW
         YKXNTJQo5KQ8ev6zAv5dvPpnhc2Bz4mjvN72Ght0vG9/8YToDnK2R8ZRzz38r84VyGu3
         lT0BWjFCzDcfz5kJHE6SNusiQqodg5tbhtf1wkRKeb/nnIv+Z8x0kzO3UqhGpxNMj7W3
         iWxXe52sf4Zb4ek+bRbNC8fcXcEbtnUlCWvNFwYkvEZ1hPQKyDNGfwW942pFnBzGNART
         DTF28gVeaeXLpCqR0izWfWuunU9Dqv5l7GaLTs74K6BIcoi5b8mvqEXi123WjJK8bzV9
         VUdA==
X-Forwarded-Encrypted: i=1; AJvYcCXeyh83BYiAq0cLVanrkRLfIuTN6UwykVWTh7zGUqPV0zTZjBXpNcW+dCiimO/j581d86DLeM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThU6EtWN7I+GjAGSkwkwKU+GubjS5LimkwKcxBGPTGb5E1KCw
	GqpUvP4km39h4zEwnedsLBbSgQD9rYSHHCiW/SA3D3CwzX3ST5Q=
X-Gm-Gg: ASbGncuGLUYHmI23INMMW12Q/1eK47LwnVaH6fkglfVefwph6cJYP83aE6yR4V+/E9R
	PsP5gkhu3zulZe9O2bi8u/gI1FPnlvQZ6RRbEvizK79G8ewv6geW7rWE0gmXiLU81Lz9Wy4oxny
	wTRrwPAxqkYGg2BkH0YirQrFVEcErfXivO6mLiw/A28zuTfJkqFKQ+5skBdPoWVqhfZeM0NNRjp
	/CdmKtbBkh5Rc0NmXBicROd7o7T4vfvqcBeL7ePYR50tjSMYk8C68wz
X-Google-Smtp-Source: AGHT+IGYk1QNk+zeGlBU15znHZa5L7NiYg0lGTha4po+GFB5+flyLS5zEbOqTx74fzSqKfsqG2n+/A==
X-Received: by 2002:a05:6a00:301a:b0:725:ea30:aafc with SMTP id d2e1a72fcca58-7290c0dfcaemr1305940b3a.5.1734052738828;
        Thu, 12 Dec 2024 17:18:58 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725efb60607sm7621628b3a.164.2024.12.12.17.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 17:18:58 -0800 (PST)
Date: Thu, 12 Dec 2024 17:18:57 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 00/13] selftests: ncdevmem: Add ncdevmem to ksft
Message-ID: <Z1uLgXIA8HApli8v@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <ZuNFcP6UM4e5EdUX@mini-arch>
 <CAHS8izM8e4OhOFjRm9cF2LuN=ePWPgd-EY09fZHSybgcOaH4MA@mail.gmail.com>
 <ZuNgklyeerU5BjqG@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuNgklyeerU5BjqG@mini-arch>

On 09/12, Stanislav Fomichev wrote:
> On 09/12, Mina Almasry wrote:
> > On Thu, Sep 12, 2024 at 12:48 PM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > >
> > > On 09/12, Stanislav Fomichev wrote:
> > > > The goal of the series is to simplify and make it possible to use
> > > > ncdevmem in an automated way from the ksft python wrapper.
> > > >
> > > > ncdevmem is slowly mutated into a state where it uses stdout
> > > > to print the payload and the python wrapper is added to
> > > > make sure the arrived payload matches the expected one.
> > >
> > > Mina, what's your plan/progress on the upstreamable TX side? I hope
> > > you're still gonna finish it up?
> > >
> > 
> > I'm very open to someone pushing the TX side, but there is a bit of a
> > need here to get the TX side done sooner than later. In reality I
> > don't think anyone cares as much as me to push this ASAP so I
> > plan/hope to look into it. I have made some progress but a bit to be
> > worked through at the moment. I hope to have something ready as the
> > merge window reopens; very likely doable.
> 
> Perfect!

Hey Mina,

Any updates on this? Any chance getting something out this merge window?

I was hoping you'd post something in the previous merge window (late Sep),
but if you're still busy with other things, should I post a v2 RFC? I have
moved to the mode which you suggested where tx dmabuf is associated
with the socket; this lets me drop all tx ref counts (socket holds
dmabuf, skb holds socket until tx completion). I also moved to a
more performant offset->dma_addr resolution logic in tcp_sendmsg and
fixed a bunch of things on the test side...

