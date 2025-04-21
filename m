Return-Path: <netdev+bounces-184401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D56A9538C
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D16B7A761E
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F31C84B2;
	Mon, 21 Apr 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlMTsq5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57B1494D8
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249099; cv=none; b=GrmrpIQ+/9NYkxkgtdcHckBA88+kNVAmlaZMGeA0vV32LKObl/6TfK81eBKJqiootYmxw9NkoJYSwUz3xg5Got0399OVbH8J/lz8ojYG6lY4Aney/tuoTJ8Z6WZnX4L7H2kJ7i4Gq6O/8j3eQc4c3t6q7XJ+UCzMiH5pmDnEha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249099; c=relaxed/simple;
	bh=PSsu7s5apfrcQZpdyBiLXltkkAMOZHa/sViOI4N88rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMgjnG6DhjNusMULA+nYMp4KGihQbafovFs70eSBycFQHmwEL7P5rPH1UuVYRUEl4c5JJGSjB6fJ9kJwj/wFaPpptUqrKfXZPu1sJi61fNGkoxzzBB17500FIBt/3kc8VU9CqZ3kMlJztXbgeH1bVQcoEKlcupiz5otAHthmIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlMTsq5K; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22928d629faso40151655ad.3
        for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745249096; x=1745853896; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ljq3CD+gP9uIP1/pgrR81MZhOW+Yvp3oRWzgVuH+JTM=;
        b=MlMTsq5KLQwB9S2AQNebtO5Ze2hM4VMtB5s54Pl6sf8opuZ+RRgP9cviohoaKl0qE9
         0QbA0qsUQ6W1MO7YoWT7cPyBRPjy2YwCuCZOg0QoSsqdrMPfy/Mbc72JzmPRVXHaX1od
         2gzAwkQH3m0g1LQrbDhNze6nzLr8CriMptTEEoVOf/aRjmyuw5ULbEx2/+AaZDbq/Ege
         p7R6yVUVNh3uW1KZkMD50kMPrdmp7iukeNdJYncRJ7DPv8wwmPhskmWzLfn4Ezutjhw6
         hNB8lBBuoJIKsIljDe92gvKXG9heK76+sjdJLig2zETq8Aek6RugxBGtviIdq0ToeFa1
         eDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745249096; x=1745853896;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ljq3CD+gP9uIP1/pgrR81MZhOW+Yvp3oRWzgVuH+JTM=;
        b=CERTBRrW7KSxAiXy+D6FSADsgri6tcuWk22KFOEhlLpfvTzIBowAU1xd6Z5rn0/X57
         /8T07mFgg+pUomsUl8E3rLRvNPnTdK+TqnNdGacccPNeaiYvuvu6EQaXlKEQVPP66t+0
         6pa02rRVQb+QUllDUQM9nEgQY3O1O+2dedpli73J61x9rtqKEoAwk/OiFx4A86/S0yDC
         G6UJk7EXr2BNKU8mRRbqPrar55QIZddmKMMcBILcrYxGgQJR0KH2bkveUbdpwA58AjOz
         cNVc2u05PKZwviwM2RKo34w6gYumJsTH4yWEFOhHHm8tjVqthojhA91l0uJH/UXcw4QE
         5HXw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4VTZHFU8mnNCKvSzVDk+pU/DcPZGuD5w2Wl2tVbC0urh/q7vA2BW6Ms2hLIE0AAntx5LyRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+omx0s/74ItVlk83KgtA0ImWGj+KaUqR9BWSrLDuXiO8UWg7
	mxBBr+SUH+QYSb0eI4x1OvHIo/+mZSX7X8xVK/uPFxs3wzy/vzdsjO0/
X-Gm-Gg: ASbGnct4G2A/HL7ykE7jPBzf3mM4aMga8gditct8D8479kJpgOYZCOyvOlgMrNoZnmx
	DhiFkIz70WKyXX4HSMM8x21hhQ31KzgyPJnlMyMerfKid5PHK5D8NQf0wWvsnRr9JOEdlS43E9T
	v6onFWcCf32YJtTCoSlScqZD/PP7eEDVXsaa8hhn0BZo/1RaAOizxaRlnSomtuGwtPc7FQRE58v
	F/jucBnQcC6Dvv+uj21gdsQZwmMYqXVe3NTZI/DyNJXc7IyRrNP/iFBfWA6MAInpts847RsIwBQ
	hzob8giiHwAo/o8JoyDw70xnlaLQ19EsR4VpfFnX
X-Google-Smtp-Source: AGHT+IHX3ak7yJt4WUvtK3JK068HhEoYCK0bu7DqYqoIWqEF/nRZHaMSm452NKxjba/998s7tSyJjA==
X-Received: by 2002:a17:902:c944:b0:221:7e36:b13e with SMTP id d9443c01a7336-22c5357e7a5mr194035675ad.12.1745249096369;
        Mon, 21 Apr 2025 08:24:56 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73dbfae9a4csm6721979b3a.161.2025.04.21.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 08:24:55 -0700 (PDT)
Date: Mon, 21 Apr 2025 08:24:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com,
	sdf@fomichev.me, ap420073@gmail.com
Subject: Re: [PATCH net] net: fix the missing unlock for detached devices
Message-ID: <aAZjRhnO2RBxf9Fb@mini-arch>
References: <20250418015317.1954107-1-kuba@kernel.org>
 <CAHS8izMnK0C0sQpK+5NoL-ETNjJ+6BUhx_Bgq9drViUaic+W1A@mail.gmail.com>
 <aAJeMtRlBIMGfdN2@mini-arch>
 <CAHS8izMw=Rfa+AT-xCaUspb-GYvhsE1iugPM=_c-FFD+2KBE7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMw=Rfa+AT-xCaUspb-GYvhsE1iugPM=_c-FFD+2KBE7A@mail.gmail.com>

On 04/18, Mina Almasry wrote:
> On Fri, Apr 18, 2025 at 7:14 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 04/18, Mina Almasry wrote:
> > > On Thu, Apr 17, 2025 at 6:53 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > The combined condition was left as is when we converted
> > > > from __dev_get_by_index() to netdev_get_by_index_lock().
> > > > There was no need to undo anything with the former, for
> > > > the latter we need an unlock.
> > > >
> > > > Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> > > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > >
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> >
> > Mina, the same (unlock netedev on !present) needs to happen for
> > https://lore.kernel.org/netdev/20250417231540.2780723-5-almasrymina@google.com/
> >
> > Presumably you'll do another repost at some point?
> 
> Yes, and there is also a lot going on in that series outside of this
> locking point. If the rest of the series looks good and is merged I
> can also look into porting this fix to the tx path as a follow up, if
> acceptable.

I'd be surprised if the maintainers gonna pull buggy code :-) Why not
repost with a fix? It's a three lines change.

