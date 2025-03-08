Return-Path: <netdev+bounces-173158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CE5A578C6
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 07:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD63A3B3F0E
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E370F18FC74;
	Sat,  8 Mar 2025 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdYqKpo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086B184540
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741416102; cv=none; b=I26inZqrwvj6Ibfr08y0AZwl30U+wpHnjR3VXng90bL1XZMLkJr2tHQ0Z7Wi9h5BTV2YrYFD99kyO3dj/CX4AnNpMWoP4R1ZiLCBTXjdKbRoSGm1DfRi963dxm/Topeyqn8C6PwjCUVj1W3yuxcW4WfyM75OnboDjbP0eC32xJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741416102; c=relaxed/simple;
	bh=mjXPEAUzfnISY0ZB5Qdk6ZqkNFSViNSHUixjtjhaCsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adYUzpEbq0RRNumQBne4KkfxRfZSNoaiVZ0o333zaqUpXo0Bcgkpq+Z+WF9T71bKPbBqzDzCal5ueILjKw/GNy0yp8Ud8V66A+yMVTikoZmu+ZXj9xnUkuOyVAlQ9sYAh/DRU1ELRQavKdXcOX7FoY2fTeuPSKdtSD/dCZsOZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdYqKpo5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47509ac80cbso11570011cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 22:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741416099; x=1742020899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjXPEAUzfnISY0ZB5Qdk6ZqkNFSViNSHUixjtjhaCsM=;
        b=tdYqKpo5mktSxKY1FOn2TiNPTX/sYR8C0/Smr7KIz89eGpSvzxW7jtlR8SQ9GeOh/i
         Q8JRRCh6OXkQIuJWyEfNmugd9CuexhJbII1B85AubppeGD28u8gJVU4oRRSyHnaSgY+i
         XwQgXorFsprEO68HuDnGIBHRbB7Pno+R4WVVZE82OkPhbiC05fDJGIxmsbyS7Zb2M+Lp
         x7iVvm7W8v4VT4GZGxgCOZNcpitU2DewCeIEz5J1gesXKl7w7WURMsFoOMUs8WOFNeHH
         2Iej9yyXfqc1gfzVZ1FdcRrllRRNXi50icRRwnDvBk/6O3kh3ti03iwADk0OZJC0Xs2O
         rdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741416099; x=1742020899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjXPEAUzfnISY0ZB5Qdk6ZqkNFSViNSHUixjtjhaCsM=;
        b=Cc51MudMyLGecHOEbW5DMiqX5oTuk66If4lI7GVbDDCBcl9JB+SBgZud9ckJTF3ivK
         71fobbu731xO7JcbvlFKYSMK0b5wu64BUwXGbgJbQsUm0+x9kcU3VCEKmo66jPinSEvn
         dYGmuX2MLPI4YTqS2ZGcEkTi3RCj1xFgDQ6gM8p40rvf2HGabfendmyJ5qkCbFq/pK/6
         GeqTZOpKDgH7UT2BIu63lua/T4GWnL+3qQl8g9I/wcTVz1tx87hFceS9LA7vCFdPEmy/
         0opy1q5xbQL/xOl0GA+HKHo2Cg9677dB3Zaz//8fO8aUTYC+oscV8gcof6IPhh9aStU2
         RybQ==
X-Gm-Message-State: AOJu0Yx2KdmvwaA33d1dxpiGgTND/cbTnFQeZHsPZakwNnkNIAuHcgbu
	ftxcGfHR9Onr+5DTC1iobedubUrb8XrYcaaQXLVh84h+3BfTvXHbDFtkQmap5k8L8Msyh+kXFkc
	pdZ5tV4Kpf1zMB/EOnTQxbVAf7ZiRUGSDG/xy
X-Gm-Gg: ASbGncvpirD7mALZxAsE5a/jZ0d7nYx+LB7r1nhb5jihukka+48LS/FfEiJVg8uMEAm
	PuByQZHnKEhFhcQmy738mYbrJ80EwLSYf/1aaid6q5B/Wf9yY8rX64vSl0Si9T020OrtJ4J032l
	8ixHhwPBw3YN1eQN6Fc3RgKihDFGlLpCJwFnk=
X-Google-Smtp-Source: AGHT+IH0eaLgh+XEDCWC3SYaInWPdIV9YE7cJpJB2zom7UsiOlycuB30zhF8t9x6msXH3oGPL8h6ICGxTYOXbXt0l5c=
X-Received: by 2002:ac8:5d52:0:b0:476:7327:383e with SMTP id
 d75a77b69052e-4767327436emr891981cf.13.1741416098891; Fri, 07 Mar 2025
 22:41:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308044726.1193222-1-sdf@fomichev.me>
In-Reply-To: <20250308044726.1193222-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 8 Mar 2025 07:41:28 +0100
X-Gm-Features: AQ5f1Jo-nG_abX2mxVG0F6FyAQP3SKkSj2fRU5w8sH3E0_u7XuD1N8-7npTR7nI
Message-ID: <CANn89iLV6mLh8mWhYket7gBWTX+3TcCrJDA4EU5YU4ebV2nPYw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: revert to lockless TC_SETUP_BLOCK and TC_SETUP_FT
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, horms@kernel.org, 
	corbet@lwn.net, andrew+netdev@lunn.ch, pablo@netfilter.org, 
	kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:47=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me>=
 wrote:
>
> There is a couple of places from which we can arrive to ndo_setup_tc
> with TC_SETUP_BLOCK/TC_SETUP_FT:
> - netlink
> - netlink notifier
> - netdev notifier
>
> Locking netdev too deep in this call chain seems to be problematic
> (especially assuming some/all of the call_netdevice_notifiers
> NETDEV_UNREGISTER) might soon be running with the instance lock).
> Revert to lockless ndo_setup_tc for TC_SETUP_BLOCK/TC_SETUP_FT. NFT
> framework already takes care of most of the locking. Document
> the assumptions.
>


>
> Fixes: c4f0f30b424e ("net: hold netdev instance lock during nft ndo_setup=
_tc")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

I think you forgot to mention syzbot.

Reported-by: syzbot+0afb4bcf91e5a1afdcad@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67cb88d1.050a0220.d8275.022d.GAE@goo=
gle.com/T/#u

Thanks.

