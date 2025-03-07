Return-Path: <netdev+bounces-173112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7630BA57652
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0EDF16A4DD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 23:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BCA20F079;
	Fri,  7 Mar 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahLh/z2X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0D208990;
	Fri,  7 Mar 2025 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390988; cv=none; b=kiiQlCCu4u6LiHYb2r8MDwvPtoOjYjTjcH9dLXMVj+2byPTDBrLtiEKFwioF/aK3ahEvlgBvNqB6yr0K29EUWZlQ9pK5WYAFMpngc3KPLEBTIobLMDbs1quRBgLVB5SbWBn4PLSY75qDmUFtKbEcyGcHGfZocZ6dk2AyPzafuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390988; c=relaxed/simple;
	bh=s7G4Mz3i0+XMsPGmVw931qBJK50RBXeMBVMCnuxuAUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QncH2hGC9tymcFSxraQPVpq02BaGJwA9OdYy2x/Nllp6caoCf07zFXn3Su38L+EdvoMSvyz7zH7r569UmezTm67pwiT0YA8xzYePiQ2eVy9PUTlXTFte+KMsSuUHc1+P3RBYqKBbiHEg2/7bNgRNy88L9uZnhMuwYwZJJRJ1uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahLh/z2X; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22355618fd9so46772965ad.3;
        Fri, 07 Mar 2025 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390986; x=1741995786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dR7q5Oi6I0yj6XVM3V0P4sV762dT4tqVEROsbEl7ztI=;
        b=ahLh/z2XgWH/RcQ/GelHI4I2cmv0KVwyKBMMsis5EigJ6qnGNbkd+csUJCUgfyopyS
         hzYHUn1z/lE9dPrbLeohp44TabMn22exeHSfuJbIXsv9ZoJowxmW95wpnygMD/t0IXas
         nnm7E3kMG35LUCB9wapIo7kTM/l9ZImJR/I6/JFPkocYx9+aXGoAff0G6W7SgT7md0JX
         q4upz3MKXvH6DXg2MKOhRyTAcPt7KWPGqBjHd+MY5GV5ye2PqM30N6oP8jshiFXj1QDY
         4r9T+x+ol/LHg4BDwUTfVfen2BC2amJYEjPjb++SmB4Q7H0GRfzGRbF7/LlYXZYaMs9d
         bvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390986; x=1741995786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR7q5Oi6I0yj6XVM3V0P4sV762dT4tqVEROsbEl7ztI=;
        b=PwltfC6o+QZAlojXaDBxiCxkzScTQSHZKsa5RQP18vLzFcxzQur9yshVsu29ayLMjp
         j2pc8WdkCZtQgP2LT7+fxE9/PwZCNStbBPStRylLJJJ+V4xt1OXfwFbEKcE1zQ/nTsRc
         Fk67r2/UHsUvVRW3H0/bwHv44ug524Mpt0GQebwKhlzWEUuXtPEX01Hdd+CkdccYZtvE
         qOSOoDAtBgUlBDNALC9SJ4srimHp8fkjHcRBwkqgZdyJESVTJLqoWjd9aJysn+egowA/
         7LDNB7Vmx8FY3g74D1uoJyInS5Sne5rJ/uCd3s4Q7yOOM3DnakKambORsQy4KleDSJuB
         XMFg==
X-Forwarded-Encrypted: i=1; AJvYcCVvmqwVJWB4S3bEcp+OMSDkqHqyQmR07hBms+fMe9KoHGS4cgTY2xfW5JPboDAPSqIhf6G2Jj5E@vger.kernel.org, AJvYcCXacn2hAAuHusfVns7jTq2FKudJ3hVrmP83wq8wzU7JLQPFk7mO8jZMCEvkD1bb3gpSR59JiyXGgbTmPM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMvvcfXtQWbKhcyVLzpBlOMUKXX9+vXy0oH4266YC2ry5HUB/
	YwjgfjgdtzeB5NOvEEXhVXMG+7a9HF6JsTQ9gBFUAsLXlkc8/BnASkct
X-Gm-Gg: ASbGncuOnAVyw3t+fvLuuANA5RHcTEFMs6Oge9J6BcFV1zkCszyxKN8BZcbMemzX/87
	y+OI1I7se5Y/ApLyoR0F9XPBYMgbOHvzo987wdyMewgDedp5mjPdMC5VvH8niVdVdz3Im8rdy5o
	kyOxKjQ9ffjPGYHWa4Gavmv3vuvKx/JPQSJyGFswtGIV6/6R1HpQeCQCeW7h9Jtzh9hJJFOF4Yj
	YDTyEMqvIlHnlu+fksqBgnQJt9YgfSO2WRZcICKgvwCk/QXx6iAdoguVfbGpMtRkE+Yrhq4lYgo
	OBI3pCrjXYMWHIdJjmu/oUTQTI/w++4t4KrmFFYOTD1Q
X-Google-Smtp-Source: AGHT+IHZuZ4cz7/DGE/LCo6+x10+ePCHWq9URP8sQ5+tptJPLHduN8Yj2lDI0dsLqpubetZeSYK9GA==
X-Received: by 2002:a17:90b:1c05:b0:2fe:d766:ad95 with SMTP id 98e67ed59e1d1-2ff7ce86f60mr8882188a91.9.1741390986320;
        Fri, 07 Mar 2025 15:43:06 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff4e7ffdd3sm5557502a91.39.2025.03.07.15.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:43:05 -0800 (PST)
Date: Fri, 7 Mar 2025 15:43:05 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com,
	almasrymina@google.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v1 3/4] net: add granular lock for the netdev
 netlink socket
Message-ID: <Z8uEiRW91GdYI7sL@mini-arch>
References: <20250307155725.219009-1-sdf@fomichev.me>
 <20250307155725.219009-4-sdf@fomichev.me>
 <20250307153456.7c698a1a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307153456.7c698a1a@kernel.org>

On 03/07, Jakub Kicinski wrote:
> On Fri,  7 Mar 2025 07:57:24 -0800 Stanislav Fomichev wrote:
> > diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> > index a219be90c739..8acdeeae24e7 100644
> > --- a/net/core/netdev-genl.c
> > +++ b/net/core/netdev-genl.c
> > @@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >  		goto err_genlmsg_free;
> >  	}
> >  
> > +	mutex_lock(&priv->lock);
> >  	rtnl_lock();
> >  
> >  	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> > @@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
> >  	net_devmem_unbind_dmabuf(binding);
> >  err_unlock:
> >  	rtnl_unlock();
> > +	mutex_unlock(&priv->lock);
> >  err_genlmsg_free:
> >  	nlmsg_free(rsp);
> >  	return err;
> 
> I think you're missing an unlock before successful return here no?

Yes, thanks! :-( I have tested some of this code with Mina's latest TX + my
loopback mode, but it doesn't have any RX tests.. Will try to hack
something together to run RX bind before I repost.

