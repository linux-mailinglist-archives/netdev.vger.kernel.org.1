Return-Path: <netdev+bounces-151492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A79EFB5D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D21916C36D
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109814AD20;
	Thu, 12 Dec 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvtP2qer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C5E2F2F
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029214; cv=none; b=XbRcGrFo3cepjnBY1xg5u4l7Gp9achWwn4o3Y75soIXXeBo+HTvboWBlX1m0UZ0aHPx8UBuMcncJxr4D94XuFzKr6onHjjwDDQ6kVHiCvFiIyCy7JbEWKohpGP30g5HDZlbOoEn/1c495KtFw/yBAVSg5/Ee5bTJ02GiQ5oZ7a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029214; c=relaxed/simple;
	bh=LuYuKrJu+xJCcM21n+3YuvP825aQMOA5qA/+RUsEDwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKkfypgA6O3r7dy5IKaIsZKd6NbGzWfmK+cWwG6V5Gg5SGMZkOX++ykZ/ZytVKesiPgwMzRQ9bexwWumjmB+nXs65WEsbnuTOv7gg6iS5+7amO35/yGqXYshnC7X6WPEMYV0DIAgDClQ3brTdMvC2+R45KCEBpxMlFxzfb1GvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvtP2qer; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43616c12d72so1119865e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 10:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734029211; x=1734634011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LIbwIzETGYq2+d4G2R9oUVlDxuGvN8nTtvlLlVWHvUk=;
        b=bvtP2qertx2+ex7dgwlatQJmefhEmM9jCUsK+g2KvIUuxC8zvfhwncZHyyUq5hWb3h
         3Tu1gqHAAlYCMbbezHmfNQNrErs2M9Qypgr3/nj3Jfw/4GW2t8PpAxvs7Ps8G5gkb4KP
         rCOwaj6KUW6HmWSzkDhg2iRMoYrF1QRzGbbbstD/GuagUjC3pSKW4+ClC1j1TizNr8HM
         3VNMCnfiaA1Jtz67Qh8ktW2/usrCU8fKn+4HYkMAggEqsJsCOn59GxvZhQCPChz0YtOD
         Tl1v6oP5+EOssnbEuwDpuTGDf3tsTU0VcaauDBoK0UiS8YJocK3/H246CIL7O2/ZAWD/
         DGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734029211; x=1734634011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIbwIzETGYq2+d4G2R9oUVlDxuGvN8nTtvlLlVWHvUk=;
        b=j1R734phsRTuc7726tJBG7/E4ZXRQXxDEY+gB0M5QnjmiQB4hE5aYpGRYAv464lx5N
         PhODpnPZdThNMA4FFRiBPSn3dkcwv0msBQrV6oS+pVPp5x+JnodU6bBPlmhoU1z3qPvp
         bzRHgvNqAoUJYFHis3/EKN3XW8aVoq1N6DEvhxULG6WElkdoC7g7iMlZQtU25h7V7XSk
         mBY2PvGj59R2CDKTLP8QMr3KDcQEWx0jJJobOji6fvuWuuZ9yEiLi1HgWHRxu3qOhfH6
         ucUH2kVJBR9h7s60PEYfpySCfSGRjvql4oIbtJOawuzEwfvwKDViY84Uwo9dNorWZ/x+
         ntWQ==
X-Gm-Message-State: AOJu0YxGYrNuMUVTcCSz/hUpENGiY/kaSb9IR5rZq0GQXiL6dXTnUhJ2
	OXBf4KyG9vlny6mAjb0HFLqlbtlJu8JG/YBTAvoqYMHkk8n4j99E
X-Gm-Gg: ASbGncvVIL2Z6Xbeo4GRuU+Agcu3GqsgfFqcilAQLFmDgrlii/jEJGQetpscU4mprKh
	BDLJHu8iwMF9u3FrkhkJoFdCmQ+gEjtmH86t3JlZrDgBffpsV8Y9EsPIeOye7oXdEnOdsgbclM4
	oRAu3Go0dD3uTgq2UI5/G06PJlnWX0jVQ8Vy6NnPH80XW+7k5+yyAAifsHhW8ZXSd9apGeAB9oW
	0atcyVKDLjnEJJ7RNLqttqKUy+H1sh3klG7qqdNccTq
X-Google-Smtp-Source: AGHT+IErqsxVE9TtGZmNDuVVVhym8cLK3pTI3jDfRhw21a9Fu/73ObWksPYLxB+teFNU97A+9jeO8w==
X-Received: by 2002:a05:600c:3109:b0:434:f586:7535 with SMTP id 5b1f17b1804b1-4361c2b8497mr24265965e9.0.1734029210876;
        Thu, 12 Dec 2024 10:46:50 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436255531f2sm24440095e9.9.2024.12.12.10.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:46:49 -0800 (PST)
Date: Thu, 12 Dec 2024 20:46:47 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, nbd@nbd.name, sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com, lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241212184647.t5n7t2yynh6ro2mz@skbuf>
References: <cover.1733930558.git.lorenzo@kernel.org>
 <20241211154109.dvkihluzdouhtamr@skbuf>
 <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1sXTPeekJ5See_u@lore-desk>

On Thu, Dec 12, 2024 at 06:03:08PM +0100, Lorenzo Bianconi wrote:
> > Explain "the mac chip forwards (in hw) the WAN traffic to the DSA switch
> > via the CPU port". How many packets does airoha_dev_select_queue() see?
> > All of them, or only the first of a flow? What operations does the
> > offload consist of?
> 
> I am referring to the netfilter flowtable offload where the kernel receives
> just the 3-way handshake of a TCP connection and then the traffic is fully
> offloaded (the hw receives a flower rule to route the traffic between
> interfaces applying NAT mangling if requested).

And how do the follow-up packets know to go to the same conduit queue as
the initial packets of the flow?

As mentioned, my trouble with your current proposal is that I don't
think it reacts adequately to the user space request. Given your command,
packets forwarded from lan1 to lan0 should also go through lan0's ETS
scheduler, but my understanding is that they won't, because they bypass
the conduit. I don't encourage adding new net_device_ops infrastructure
to implement unexpected behavior.

I'm trying to look at the big picture and abstract away the flowtable a
bit. I don't think the tc rule should be on the user port. Can the
redirection of packets destined towards a particular switch port be
accomplished with a tc u32 filter on the conduit interface instead?
If the tc primitives for either the filter or the action don't exist,
maybe those could be added instead? Like DSA keys in "flower" which gain
introspection into the encapsulated packet headers?

> Re-thinking about it, I guess it is better to post flowtable support
> first and then continue the discussion about QoS offloading, what do
> you think?

I don't know about Andrew, but I'm really not familiar with the
netfilter flowtable (and there's another series from Eric Woudstra
waiting for me to know everything about it).

Though, I don't think this can continue for long, we need to find a
common starting place for discussions, since the development for chips
with flowtable offload is starting to put pressure on DSA. What to read
as a starting point for a basic understanding?

