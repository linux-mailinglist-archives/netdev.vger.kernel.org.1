Return-Path: <netdev+bounces-190780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EDEAB8B0C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C878175938
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8149420B7FE;
	Thu, 15 May 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPUhYzjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEC5211A0D;
	Thu, 15 May 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323650; cv=none; b=mG8nTcDetyR4GUNk/MK/PrLfTH4bKmzbXgXImnHDDKEf3Vv2Z0vMU2/JNiBciW7tSSnMO/phpvQ7VyA2Mu9Y3nrB2w/iuK6T45AfDDUuUAbVU9kG17eLw5L1zbluruf/LpU2TGCbeWypHl2NF0woMovqjtajUPb5/icr+OD0ysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323650; c=relaxed/simple;
	bh=isnxA1U3Y80dnzjuWHMdDuK8gT472yylgVk3Nz9soZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOakhuOUVevR9SUFBxDgX+4MhnPO3Q840qvQn0MZdh5dnWSs2lppKVJsN6E7ao9HzpDHa4O6aM5M8gpXMYmzKuo6R7rp6clW0c0fEZITMuOYtjQdcxonCqE8MCgmSmpm2NYoqRryAn8XN+2t8rnlxs7IAsEC82+EwZUDkhMthU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPUhYzjf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b239763eeddso892970a12.1;
        Thu, 15 May 2025 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747323648; x=1747928448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gmddZo5hbgODLBcL9749K2U4oLVLG2d3XqRGsTj6JdE=;
        b=nPUhYzjfW+w+1/mQ9Hmcl+zLj5SxOdEL25rPb8J8YU/LHE/9WQhTagA4AXtbM0rRTM
         980ycZ4AtjDm6WSzm2p7+KHOoWOXkQkFsMKKEvQtIS53cst0dczw7dNSwdTq4p912pxs
         HWzpcnQJjeW4cil1Fz+foZ+nSnTMPoo0Orxe9mJUdzrPx0Is3e8w252YOTXE+g/Ct8bC
         LB3mFnfOLa3RQM6L1dbrRadnmjXSo41YvI0FQ0NbS7POzdP8FGXBZDpZhMp+0sCKFJSu
         8IxJ6gSoYOJFAGsnNy2pp+5cVNJsF8hAlThLC0GmejeX+qCOm+gzjdpYYVsUIO7B0QED
         rS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747323648; x=1747928448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmddZo5hbgODLBcL9749K2U4oLVLG2d3XqRGsTj6JdE=;
        b=gun5G05cQoW2b4j/C1xRXfWyzznfaR3klvj+iMLCGQx/6LC/I7s5su5f6cbMnuxAC9
         y31pK/k+aB+EiVMqxEC02YYw0Z8Cxu3MVRX0pw9C2qKOWPUWN8HUd08MjeJqnk0os3ub
         arVLxHLr8qxr9j61Di8Er2IOIvgikIufjubTMnueJ0tcJIfBAEfBJwJioAUwtBxMEmyL
         m6SimyoOu+D6IwFPP5lNRWAPQMfCNrspGwHrQX6Ehbz5Zp9tj+B0nyV2JjjTRS0Fxbwb
         Wb4apMlP530Dne1/puv6HLPaIPJ0egyCzPVHRkkMj+DN49gRHwQ7yVocZrhZ/fy9hiQg
         jDLg==
X-Forwarded-Encrypted: i=1; AJvYcCX7c73/dNBYxoMns3ELlM7gID9MuC3PbhxpekHtbwKDInKX7Ln9mt31BiQoEOyDRTvoN9JS8JD64KTYGnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WaHZmh3jI+UfjlVgC+B6SVxUSQbQ4kB7RaPzcmBr0orr3iJC
	BR0bNyNCzaBoV31hNkJh1cP1GHd6nXqCI+iKdc16w3rY8uikHWI=
X-Gm-Gg: ASbGncsue7O9upnCOmQnVopVF31CLHw9te7dYEHmC+YUzFP7/4l010tvWsq4AKiBAOq
	uprvYEwZxNrc5h8PurFNwnpGFsitJXYL+IrqO+oV6zH0YWgt8f1D+f4aXFGtCHt2qFTwm2OAOH8
	P+Cs5IJdN4gQwXohhENMDl7rjjvBrJcQ7lu/gTiTC6gJ5upQaPg4uLLMtgjZKRtv4+aWBzhRAWS
	j1q9tTI7lZVofgSvpxoeQSHIjDtW1f2ggbI7jfGp8c8uXS2Q+0sR/Xj55g3HyWxFeMdPKgMMSAZ
	mwR8TC5K6VPtaT0nT748sxOxuRm7PTHGHXB6GjBB3qck2xnBtAppNwFZlfrOuV91rfIk6gfoHXi
	APZoOKAPS4I3t
X-Google-Smtp-Source: AGHT+IGDgwKqaGt4wIfWcyuMH9A7tr3fIlzPfW/V/Q670JgUBuyMgkn7D4fVvu0QbFyWupBvw0XnAA==
X-Received: by 2002:a17:902:d4d1:b0:224:584:6eef with SMTP id d9443c01a7336-231b601cb46mr42528955ad.41.1747323648179;
        Thu, 15 May 2025 08:40:48 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc773edcesm118706505ad.71.2025.05.15.08.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 08:40:47 -0700 (PDT)
Date: Thu, 15 May 2025 08:40:46 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, jiri@resnulli.us, andrew+netdev@lunn.ch,
	sdf@fomichev.me, linux-kernel@vger.kernel.org,
	syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: grab team lock during team_change_rx_flags
Message-ID: <aCYK_rVZ7Tl7uIbc@mini-arch>
References: <20250514220319.3505158-1-stfomichev@gmail.com>
 <20250515075626.43fbd0e0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515075626.43fbd0e0@kernel.org>

On 05/15, Jakub Kicinski wrote:
> On Wed, 14 May 2025 15:03:19 -0700 Stanislav Fomichev wrote:
> > --- a/drivers/net/team/team_core.c
> > +++ b/drivers/net/team/team_core.c
> > @@ -1778,8 +1778,8 @@ static void team_change_rx_flags(struct net_device *dev, int change)
> >  	struct team_port *port;
> >  	int inc;
> >  
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(port, &team->port_list, list) {
> > +	mutex_lock(&team->lock);
> > +	list_for_each_entry(port, &team->port_list, list) {
> 
> I'm not sure if change_rx_flags is allowed to sleep.
> Could you try to test it on a bond with a child without IFF_UNICAST_FLT,
> add an extra unicast address to the bond and remove it?
> That should flip promisc on and off IIUC.

I see, looks like you're concerned about addr_list_lock spin lock in
dev_set_rx_mode? (or other callers of __dev_set_rx_mode) Let me try
to reproduce with your example, but seems like it's an issue, yes
and we have a lot of ndo_change_rx_flags callbacks that are sleepable :-(

