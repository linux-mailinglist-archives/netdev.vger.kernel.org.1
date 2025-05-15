Return-Path: <netdev+bounces-190812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1BCAB8F0E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED22C1C014A6
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2D62798FF;
	Thu, 15 May 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rby+fKUH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B99268FF4;
	Thu, 15 May 2025 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747333585; cv=none; b=GkbwXlIDvFMvCQwzYhQVovhcNVWkBWwASikD9T8ruT6KF8/M0vbb1ioPHxaM5eMMIje9klDvtWu8R+fpw9Szkt8ttoKjcXKHTkj4GQL/cI8DLZj3IN7Cq8JYWzp57VeiXc43Nq+9Sy1Cg8PaUzVVsLs47FbUshLPubIG5rR0QXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747333585; c=relaxed/simple;
	bh=Er8ny9lxCBgUWnz+sHHvT4Fhbs6msiuWaemw09FZeBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk2/dQlNruGk0GO13eu8NxRgAIKN+717xdn1/5DyONzgBsO2eIwMULjxqkawQXk1I/sS8tpxsiDG9GVXhAh7wfqNNbDH5RpYzI/eMDQ7KNL3B/NR7aSnU/1iYT38KkxabkX9v41BGSiht3PgfaCPYOK0hy7ppzeVAXpEqJYCmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rby+fKUH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7376e311086so1645610b3a.3;
        Thu, 15 May 2025 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747333583; x=1747938383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Uj0LtzRLhIFWXGcUWC5fKiB0khJM4entuRQ4J8wuno=;
        b=Rby+fKUHTl7Rrnndcl3PbNcYQ9NBhQeq8mvguXOREGUZZwhso9jsafnbYuXqKBj5tV
         icfF025TanXmTFqn7vc/7cfJ0der2o7AXrOQXGFL4Xvcrh0ZZdE1EiEkbj02aoCZrjmV
         3Y+YmMdbXdvjA74iVvSKKDAy53n5tQeZmJKb/NYmsU32sF/AzVo5LL/HX8F2hiSspqn/
         qTS47TK4Qh9f2QofXYi24hc3e3BhRh7zy1q8n76qUF3We7c9UnaPM48z1kBf6opTD2tg
         w2aw1bNprMkrYGxQK6kiZFMvI0lDrNg98Ctd0Wf+rHnziwR3dKZdiSUGGr1EhqsWw8gU
         qRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747333583; x=1747938383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Uj0LtzRLhIFWXGcUWC5fKiB0khJM4entuRQ4J8wuno=;
        b=DUF30jP+ogkQwnlf+8o1tebtEmubLwKFmNCdaWoPKRUfKs2J9n6M0qFI5TJMCRaZo1
         O7n9ycSnKKfGItrLhQ13e24KQ8cSes6BqIO3knYTgsNfaD7SZaSx0knM8E1vbUqjif7/
         XUR4t/IpM+OH9YpNnXebl+qBkHeyum3F8sCIspIgfghkzl/DdwaUoBYe+mmfrvfZA5r5
         b6+DOBVY9cvENENi4QUDMBBT93le+KJAajVo0MoHZir7LlWOk5A34bfXwgKkNPdFHAlB
         29VBZeUUsh3pLiO5RMGhEnEaa74MBd0GDG6ECdJYkwOaoN1KczjMHmXMszoOoAuYoEll
         U33Q==
X-Forwarded-Encrypted: i=1; AJvYcCUo/4FdKHIobxlTJg+qD7iUZUQ4GVZnS57nWu7/EL4Pz1wrg2Wp0eLIChSt5SnZNQI//VEIeQNGhLthQ6Q=@vger.kernel.org, AJvYcCX2C0jKKMib7eFbw8E/e1zaWHIfbFSYgtShjeXdqGEovF3kvGLn1MxI7tchNfoxpVtDo0q/Xrpa@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsvISDQIxEH1TPahL4Ig3JPDAF+6gi7O4O10fZ4L9FKcV7Asu
	p0mwNa8Nn/ySyb1C0ZtQv7maHwv2ftM99//mUjXyVsglN3yRCxZ0fII=
X-Gm-Gg: ASbGncv/QiR1cGOIR2CvOy4Dk3Ai61WYILfXvmoxRtgxgsfUF20wvnML30R3tUTEtbL
	Bp5a0wjDKfF8EMnyqpTGZH7BPrG3ZpR+5MN1r4SvcGZRvvH7BVwXoOpnqAsvPqqGpuiWft+pXaD
	D/ZCIypDooFEA5Vc/6MVgrIloj+fbjFydjQqWlDGClBIMWs+19+5bYbZWV7HUPmZaAK/UdfZHo9
	NqLwaJ/OQIOf4ar/NOQ101/94iqreoMzWWWr0Sp+G5xfuBQpxMcIVgyKBovHKzunQAQ1hgorfAg
	JrwUqYgGrZgfo8i5SmQnINoOz/ADYH9KELIhXHUgMnaOzzTZ8LPGOUVkZSucd3s9tKkUux3Kmdm
	42AbjJ7TmEeKy
X-Google-Smtp-Source: AGHT+IEyujidwhcs5yH88nlHnevAd0s2OHIa7bOr/AGAYmCSk71YOYn+TYoH6RSFnHZ5Wd0wf3fAvQ==
X-Received: by 2002:a05:6a00:114e:b0:740:6fa3:e429 with SMTP id d2e1a72fcca58-742a9802ff9mr500996b3a.11.1747333583141;
        Thu, 15 May 2025 11:26:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a970d7c5sm128599b3a.67.2025.05.15.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:26:22 -0700 (PDT)
Date: Thu, 15 May 2025 11:26:21 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	jiri@resnulli.us, andrew+netdev@lunn.ch, sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: grab team lock during team_change_rx_flags
Message-ID: <aCYxzeCgsNI3AKSH@mini-arch>
References: <20250514220319.3505158-1-stfomichev@gmail.com>
 <20250515075626.43fbd0e0@kernel.org>
 <aCYK_rVZ7Tl7uIbc@mini-arch>
 <aCYUezCpbcadrQfu@mini-arch>
 <47315.1747327157@vermin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47315.1747327157@vermin>

On 05/15, Jay Vosburgh wrote:
> Stanislav Fomichev <stfomichev@gmail.com> wrote:
> 
> >On 05/15, Stanislav Fomichev wrote:
> >> On 05/15, Jakub Kicinski wrote:
> >> > On Wed, 14 May 2025 15:03:19 -0700 Stanislav Fomichev wrote:
> >> > > --- a/drivers/net/team/team_core.c
> >> > > +++ b/drivers/net/team/team_core.c
> >> > > @@ -1778,8 +1778,8 @@ static void team_change_rx_flags(struct net_device *dev, int change)
> >> > >  	struct team_port *port;
> >> > >  	int inc;
> >> > >  
> >> > > -	rcu_read_lock();
> >> > > -	list_for_each_entry_rcu(port, &team->port_list, list) {
> >> > > +	mutex_lock(&team->lock);
> >> > > +	list_for_each_entry(port, &team->port_list, list) {
> >> > 
> >> > I'm not sure if change_rx_flags is allowed to sleep.
> >> > Could you try to test it on a bond with a child without IFF_UNICAST_FLT,
> >> > add an extra unicast address to the bond and remove it?
> >> > That should flip promisc on and off IIUC.
> >> 
> >> I see, looks like you're concerned about addr_list_lock spin lock in
> >> dev_set_rx_mode? (or other callers of __dev_set_rx_mode) Let me try
> >> to reproduce with your example, but seems like it's an issue, yes
> >> and we have a lot of ndo_change_rx_flags callbacks that are sleepable :-(
> >
> >Hmm, both bond and team set IFF_UNICAST_FLT, so it seems adding/removing uc
> >address on the bonding device should not flip promisc. But still will
> >verify for real.
> 
> 	I think Jakub is saying that adding a unicast address to the
> bond would change promisc on the underlying device that's part of the
> bond (a not-IFF_UNICAST_FLT interface), not on the bond itself.  The
> question is whether that change of promisc in turn generates a sleeping
> function warning.
> 
> 	FWIW, I think an easy way to add a unicast MAC to a bond is to
> configure a VLAN above the bond, then change the MAC address of the VLAN
> interface (so it doesn't match the bond's).

This seems to work (using teaming instead of bonding, but should not matter):

  ip link add name dummy1 type dummy
  ip link add name team0 type team
  #ip link set team0 down # hit team_port_add vs team_set_rx_mode
  ip link set dev dummy1 master team0 # promisc enabled here

  ip link set dummy1 up
  ip link set team0 up # or here (if was down previously)

  ip link add link team0 name team0.100 type vlan id 100
  ip link set dev team0.100 address 00:00:00:00:00:02
  ip link set team0.100 up

But mostly because promisc is enabled via team_port_add->dev_uc_sync_multiple
(when team is up when adding a port) or via
do_setlink->netif_change_flags->ndo_set_rx_mode->team_set_rx_mode (when
upping team). The subsequent calls to __dev_set_rx_mode are noops
because the device is already in promisc. IOW, I don't see how we can
reach team_change_rx_flags from here.

