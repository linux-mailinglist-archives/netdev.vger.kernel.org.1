Return-Path: <netdev+bounces-240072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D28DEC70199
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 17:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id E65262FAB6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920F36923F;
	Wed, 19 Nov 2025 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTTDoma3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7C036E558
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569483; cv=none; b=CLl2eKzEf4ZKxc/B6yfvkjSwuh5+o7WJP4rXnHco0IZWx/oM6Y0sziNRSYz4TBEZbm9SRLh81ap4rMLrtbWfd8wEm8rPCQgnS1RElQFD0O8NiN2NXDD5vXBXMWOBWJh6P4pvJp2sG3d/ePw6r2zfs2E5W2n5hfrCj+ffrE7oAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569483; c=relaxed/simple;
	bh=UUiLN5PsGhbk/UslXZY/UEJEemNxtVPnF9dd1BorKkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D401pfwT6ImZih1SzdlkkTzIMXa0FfOJ45tvUjniiZLherojjSo+y+FHjiJGfrxSVJTg4fhMF/4qAODPySDl+GWSosL4+++7f1GPRTcx4EqdKmli3BZmnaCh4scvHyPkALhj3wjslsmW8WG/bC17DgnXCnhW3JF9rpvVvtmHCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTTDoma3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so1042206166b.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763569480; x=1764174280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p3N9ErNANzGGwfgeY1v7mT4M/wDvg0ygAOwvykoq3xY=;
        b=UTTDoma3AA7WP5zj6S33a2gyCwsHucTsX4Qf9IbXgMKbr54cSrplyArIV+eZMu+8TV
         W+zYWYLULscpo/gOM8KgwjyW5NOniGeQwAPElUu5dsdsOaongtgHTdsiJ+ZlYudsYidm
         FnTSeVqARjFBy3Hcn6VBfK/9taKNdVDSFRnfcRi75WmFNgX+3FD+SMe86IDmjoSaWTDO
         7b6G0Cm8wT8HXLgWjpD1KlnUwR2qzdYwIcp7v8rK/wayOqCW9RJ8/dzBbJOvjWx5bjQ2
         7Dr+niwS8RlXl4W1jcoykKDVmGaa78xwfV677YrKgBuIOMVmaSUSfM071mW+81hFMHP+
         9K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569480; x=1764174280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3N9ErNANzGGwfgeY1v7mT4M/wDvg0ygAOwvykoq3xY=;
        b=A7JSXFSFAqS/RLPUlSthEK50KbmLseROhVOseoEeGdAKeDJZiBCNRL+O2s2gTotDQB
         0pVS7O9pRTEETaILNIcPOHTCiOWpOVZcqpQd7fe0gLxEI9JRZ6SwE2UvHoyVoi6tTPNE
         yzdeYqgVEgutyH0et2GBUyLyMov1vss9sWliZfiAfIjnVu191lae6xox6fSAatHrAlTm
         EzigUvrQqtTKPHeFGfsiOunzXk7oLsf/UfKG9s8TJuTa2j4b0zo/L+Q9znt0n5Dp/QZ7
         0mfgXVC1VcQl3I6jdZiAlvJXW2P8g0EXuELCFRdXyaLbNDhY0ojVIxSJwTeKoLGereNV
         8Fzg==
X-Forwarded-Encrypted: i=1; AJvYcCXLLedwuE4epEN+P88nZFa1Km8aNg8J+y8dnB8pmK3Audmc5/FVOXb5Be1UXTII5en7E0ZFKwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ZTEORqNu2Za5SwOKNBLW47XIjrU0IpP6iuYdpKf9LaZ+UQZ0
	93WM0eMuQuzSeC/IilEv1vK47em3XdsGs/8tC3foMJRQw8Bklmh2/KuY
X-Gm-Gg: ASbGncsg8L7IzvHgdX6vzCc8dLE46Rz+M1YSAPQXQK8tCEt7ojNiHboZOmM4YFqnUdU
	wXTrRdnk9Gdk3GjKbpbawqRuHoJCKQuScx9QMT4VjFEQ1/gDozP1NYagvt0xS9FDtriO9Dx8CjO
	VvIAOYreSQuN5xH66w5ZDToLtCteyZ5t7TYxXzai2TWZnStlLTF7g5Glc0RtzYTF9Zant6QBXXx
	Q5HdU3DxH7Yf6DHKjGnLkxdHhEFc7MhozwOaiBuGUESlwLgR7OEqCn5vcFGzmnFqpLk7CuVWfF5
	WUnYB1XkhZf/7/L6JybhgcO6bvqn9wfGLPTYqpYWKaN8NJ5OcAQonhPE//AtXJXemzxLVKRssDR
	10g3XTU4fWoFxKni6V0B/GXRj/mWLKmOXF1D3pdc8ZD5H+ytj2e2m7a5/iV0YYZweoqL+OfUFWM
	TS8IwhTlR6iafi04F/EVlo5Q==
X-Google-Smtp-Source: AGHT+IEhDRw4dV8UjCbRWVY4aY/eenqpiZBRwRmszWkO7M5Mr++PemeK3uIbC0+zEzuxM0+Ytez6Zw==
X-Received: by 2002:a17:907:7f02:b0:b73:9be1:33ec with SMTP id a640c23a62f3a-b739be13868mr1255076266b.9.1763569480058;
        Wed, 19 Nov 2025 08:24:40 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fedb91bsm1639328366b.70.2025.11.19.08.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:24:39 -0800 (PST)
Date: Wed, 19 Nov 2025 18:24:37 +0200
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+a2a3b519de727b0f7903@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: Move team device type change at the end of
 team_port_add
Message-ID: <vv54er56wgnehntr2zh5jk6iz5s36jpyi4jfwjnkfabfwithtl@aizn2anzknjm>
References: <20251112003444.2465-1-zlatistiv@gmail.com>
 <c6fa0160-aac6-4fc4-b252-7151a0cb91d3@redhat.com>
 <mekjl7qqrb6nkk6ru4fztqxzemldzbsplf5tzuu7amc7yaa5j3@rulh6ijsppaq>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mekjl7qqrb6nkk6ru4fztqxzemldzbsplf5tzuu7amc7yaa5j3@rulh6ijsppaq>

On Wed, Nov 19, 2025 at 05:10:15PM +0100, Jiri Pirko wrote:
> Tue, Nov 18, 2025 at 12:46:36PM +0100, pabeni@redhat.com wrote:
> >On 11/12/25 1:34 AM, Nikola Z. Ivanov wrote:
> >> @@ -1233,6 +1231,10 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
> >>  		}
> >>  	}
> >>  
> >> +	err = team_dev_type_check_change(dev, port_dev);
> >> +	if (err)
> >> +		goto err_set_dev_type;
> >
> >Please don't add unneeded new labels, instead reuse the exiting
> >`err_set_slave_promisc`.
> 
> Well, that is how error labels are done in team. "action" and
> "err_action" is always paired. Why to break this consistent pattern?

Hi Jiri,

This pattern is already broken in the same function by this:

        /* set promiscuity level to new slave */
        if (dev->flags & IFF_PROMISC) {
                err = dev_set_promiscuity(port_dev, 1);
                if (err)
                        goto err_set_slave_promisc;
        }

        /* set allmulti level to new slave */
        if (dev->flags & IFF_ALLMULTI) {
                err = dev_set_allmulti(port_dev, 1);
                if (err) {
                        if (dev->flags & IFF_PROMISC)
                                dev_set_promiscuity(port_dev, -1);
                        goto err_set_slave_promisc;
                }
        }

So I guess I should also "break" it or do it as you've just
suggested and add another label "err_set_slave_allmulti"
so that we are at least consistent with this.

Thank you!

