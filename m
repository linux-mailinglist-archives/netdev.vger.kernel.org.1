Return-Path: <netdev+bounces-178012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F2FA73FD9
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 298881B63DCA
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26411D9A5D;
	Thu, 27 Mar 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgrZjECp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76F1D6DD8
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109025; cv=none; b=iN/3DjSmZGnjkBjncRIKsLMTHMzdsJjgi7/w+wg9jMlcfFdmxDJ/3oUA/91IUjj4eb0MA/zSyRmkbRyv7VTHaEDY9O4u1jIwjm4v2l5LaeXawgc9pv0WDmKeIWROqlTl5+FGcpcHQ0HeSjJmqg+nnHWnptWz3DwTDR0G12Xzkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109025; c=relaxed/simple;
	bh=4u68GZqQFu8WD4E8Eqgs0VIXNT7ep4tbCk4n8I6rRrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3BXKaW2vm6zxd3jkz/hGY4al610ZBxPZubvQ6GTKccuCWE8kR+HulhAjZpL2sx/bo66j90F5YE7XMXgX1S7ZPSuMAKHt/ArwdTObg3sqRH4kYHCXmqAiPkn4dKnCDRgWtY9YHZAykWy3T3IlJkS5+RKHgMrHoblMwqZbo1m7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgrZjECp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2260c915749so22667815ad.3
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109023; x=1743713823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vI5wkIVDrrbhm+l4aOzsb3x8R5aGDet9ULJatnFQM1w=;
        b=SgrZjECpUGTWUy85Cn7mjAhWLbP2FO+M+xZioMdFkd/mcQFbkLRrBgEfOwRpegOoar
         LnULNXDj+fUKyiTdVcF03fsk3fH9IJHTmdsQnVuMrodu9q06NGeA2za4MBfPpsQSCc09
         6xqBv5xqbnc1vbet+tIKTzhufn2nSuKteEJMRZfGvD6izU17JU3oe0L+cC12/t0cv+X0
         aTF9qLR9yWKhfILp+r5EUW2F4sgFwV2USP0/rj11UE9PLeblRl1JE7BwDd89F4fJ9VNG
         f8bMLV5aRHt2kNzLZXEngRR+yUshKfvF1coKIQO1u2g8DB/MgsUhzyk5KWXKWeSgZ7SZ
         bIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109023; x=1743713823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vI5wkIVDrrbhm+l4aOzsb3x8R5aGDet9ULJatnFQM1w=;
        b=HoF5TeNwMDAG8MsueZLsh/0ccsI6Pwb6w13ydgzD1XWiLvqS08Wl5enNhzjICE79mz
         t3I6tqRflkKVQ/1LHs2OWGGIlzWQgZkggyqD0BwY7GKlw9KUpMW8vcXtct1vv7s6SGfL
         dcR1IT050BVPnNSXG6YekNOahU4QRHFD/WfnKb0BNAalA/4QpgMC4Dw2zBZ0rA0YavyV
         2tyv+RRZJ6pC9fidDIervAljO6QXV0uu57hQuylZGM5XV9cqC0UCSVX1tATsm2OyhweK
         G/3d7TOq48dXM3dFLNVjVaUuRfuCs4wMQyR1Kze1tLRwl6upOB97ullcj6wTDZrKAxsO
         6Zyw==
X-Forwarded-Encrypted: i=1; AJvYcCUkuFKPecIzZ0DWK2Bg+XEj8CBOaO1mvi5EUTWl07XQl8667XiMhISbtYZMqcigpSAWZMrcz70=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCrxahPe5IaH2PCsLefugNw3KEFlYJQGylJrSIBp/FUQGUj05
	bVtCxLgJV+I0d1zqoyTTqSy/8NnpuqzAn5YDu/0uwRb4Je/FhDd8zFGFoHAJ7Q==
X-Gm-Gg: ASbGncuxyVOEDqW0quprfQ2KWIDSVtr0OxDd65f4RgKkEENjcrPQbUNFJ2lFSqSkASc
	LbWnz05hC538aMsRahQ1GLU1U/lct4d3raCGxWVQL3pjSFcPZVlOojIQDUmoQDr42Zxhg5Co2TD
	TjQY7vwAgb7oMkQ32/+uPmpQRSqYAogoxNEWKFXjaw1bLrKesndY3Erm/N6vTm2IU3AtxsLPkum
	F7OzD8blVwmxVdJ7UHeK/tgKT0IR+7rCpoLkDmxrOxnEwHd8GY9Qb7OB80dYzUQoBNZs2IMdmZo
	lG2uyWfaKBuVUF+jR7WIRuh9fCIE6+KsN5/tGd/tk3YD
X-Google-Smtp-Source: AGHT+IE3j+W+jk/u8ZquE9yKsEiWmztPX+XrfZmpzZnDNd8WJ7HYrJQCHe/tSnmC6mz25+GBXqeIyA==
X-Received: by 2002:a05:6a21:33a2:b0:1f5:884a:7549 with SMTP id adf61e73a8af0-1fea2fe8434mr8818458637.41.1743109023194;
        Thu, 27 Mar 2025 13:57:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93b6a093bsm342197a12.28.2025.03.27.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 13:57:02 -0700 (PDT)
Date: Thu, 27 Mar 2025 13:57:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v2 08/11] docs: net: document netdev notifier
 expectations
Message-ID: <Z-W7nfFdv8u-SZTY@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-9-sdf@fomichev.me>
 <20250327121613.4d4f36ea@kernel.org>
 <20250327123403.6147088d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327123403.6147088d@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 12:16:13 -0700 Jakub Kicinski wrote:
> > > +* ``NETDEV_REGISTER``
> > > +* ``NETDEV_UP``
> > > +* ``NETDEV_UNREGISTER``  
> > 
> > Can I ask the obvious question - anything specific that's hard in also
> > taking it in DOWN or just no time to investigate? Symmetry would be
> > great.

The latter: I added locks for DOWN, hit a dev_close somewhere, and
decided no to go down the rabbit hole.

> Looking at patch 4 maybe we should do the opposite. This was my
> original commit msg for locking UNREGISTER:
> 
>     net: make NETDEV_UNREGISTER and instance lock more consistent
>     
>     The NETDEV_UNREGISTER notifier gets called under the ops lock
>     when device changes namespace but not during real unregistration.
>     Take it consistently, XSK tries to poke at netdev queue state
>     from this notifier.
> 
> So if the only caller currently under the lock is netns change, and 
> we already split that to release the lock - maybe we can make
> UNREGISTER always unlocked instead?

That sounds very sensible, let me try it out and run the tests.
I'll have to drop the lock twice, once for NETDEV_UNREGISTER
and another time for move_netdevice_notifiers_dev_net, but since
the device is unlisted, nothing should touch it (in theory)?

netif_change_net_namespace is already the first thing that happens
in do_setlink, so I won't be converting it to dev_xxx (lmk if I
miss something here).

If it goes well, I'll also hack your xsk patch to grab the ops lock
in xsk_notifier:NETDEV_UNREGISTER, I think that's the only thing
that needs changes. The ugly bonding and teaming unlock/locks
will go away (which is a very nice side effect).

