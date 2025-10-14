Return-Path: <netdev+bounces-229317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 804D2BDA8FD
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 880204E9105
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB5C2FF66A;
	Tue, 14 Oct 2025 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUfuwCQg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD32BE62D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457991; cv=none; b=BodZfJb7wSHDCxLqA4Uoy28ANuWMnj841Q+RBXeOc0DygwLjmnL7o3LQHPbn5ppbRZ8sXY01HlyFEnePJyhkqG2UgP5I7tFFxw8fauEOwRkUSJjr/eilj+Ib6C7GkvKaXqAVO5LJAd9DZInWHbumWPBcXjVkXWL+InSBHkK/vw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457991; c=relaxed/simple;
	bh=zy2TByA6c2LXcksdvCsl5wdzasTnAvjrtawWQf+nbuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AY7Xlh7qgSXt49UPkMVHOINiOXWoWFsiU7UmY9YqPe6ybyj+zE8veW2vFPOENF56QO/ZqA7Q2fT6ZfJLslJ3UWX0sQxEkTHv4aihQrvWoi3S2IDJYoOV5kS5dUl8HyvbRBQ1/fTQlMMp5b6/gGAArZ6ZryWD+/TCdzLB4C/ZuNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUfuwCQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCE3C4CEE7;
	Tue, 14 Oct 2025 16:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760457990;
	bh=zy2TByA6c2LXcksdvCsl5wdzasTnAvjrtawWQf+nbuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XUfuwCQgCAfS0HkEZfyEdJaXqEuuG5ncIqKI8Tx9Icspw/VwWMseJLtL0DrFqGiSR
	 JN8P2wWXRrkylTTnH4h7FYHp2v1foGl+O5uUpJ+LV+1Eb6Lo3B6P1bMJIuPFBS6S0c
	 gfWzkUvOaxDBqCO+AovtmYEZ2KJ88Qbk8S/7AA1ztDoYhNTOljp2fjs+OLsZt22SFn
	 WYRMUCcT7PVKriH6dGrH2a5Z8ZhnnnOaq/DvdeQH4Yo7TQBbSkOCup1hF0LEHAVCi5
	 nqs6l2TUf/H+ab74RI4iUbWT9FGqV8xWKD35JF9VUJfXoxgP4NK0jo1WYIi2CEV1O+
	 sh4/vZtDIdN6g==
Date: Tue, 14 Oct 2025 09:06:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established
 flows
Message-ID: <20251014090629.7373baa7@kernel.org>
In-Reply-To: <CANn89iLyO66z_r0hfY62dFBuhA-WmYcW+YhuAkDHaShmhUMZwQ@mail.gmail.com>
References: <20251013145926.833198-1-edumazet@google.com>
	<3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
	<CANn89iKu7jjnjc1QdUrvbetti2AGhKe0VR+srecrpJ2s-hfkKA@mail.gmail.com>
	<CANn89iL8YKZZQZSmg5WqrYVtyd2PanNXzTZ2Z0cObpv9_XSmoQ@mail.gmail.com>
	<ffa599b8-2a9c-4c25-a65f-ed79cee4fa21@redhat.com>
	<CANn89iLyO66z_r0hfY62dFBuhA-WmYcW+YhuAkDHaShmhUMZwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 02:40:39 -0700 Eric Dumazet wrote:
> > What about using a nf rule to drop all the 'tun0' egress packet, instead
> > of a qdisc?
> >
> > In any case I think the pending patches should be ok.  
> 
> Or add a best effort, so that TCP can have some clue, vast majority of
> cases is that the batch is 1 skb :)

FWIW I don't see an official submission and CI is quite behind 
so I'll set the test to ignored for now.

