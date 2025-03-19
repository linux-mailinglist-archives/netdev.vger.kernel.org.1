Return-Path: <netdev+bounces-176232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236DA696C5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1869919C47FB
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88004205E16;
	Wed, 19 Mar 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c536cHJd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45DA1E5B8A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 17:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742406297; cv=none; b=hNSAPWad3+MhvkuAPiIbDlOXhvithOSHqrvByj/MKkRki8Q2Wu+yUo+ZiKwUwu3sWC2VfpHiOJjffJh9H2Cl4G6dU34VXMAr3xMKSV3xF3kfq/i578hiNxaRi1m4uGwyMnp4PJLjAmydn3Z7TE1t2Mgnz4lX76abbTf5PWNToP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742406297; c=relaxed/simple;
	bh=qgmBVv1+iO1zBtNLuGNVbOE7noKD+lcS9LJZdfGI2nU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aQwxdeloM1v3DrutBAm3T5jFNH3q8XIVhOH+X00B4+ObyXTG8vp+57WZwbJNlGq3K8Dt1aQ6X7qFxWxZ+eCZbdT3UjTEGdGk/yr4TRfbHcMWAp9XIST1v4zFBAoXUf3jgl3yN1ZQ8cbX4cXyfYj0DRAwsJXd5dcDmbTtVZEmBQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c536cHJd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c554d7dc2aso1113116185a.3
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 10:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742406295; x=1743011095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+o6ofympSPYwfyUQQxw/T2qMcpCmSc7tPx/FfKUNzg=;
        b=c536cHJdbJQ9r0foGPBgzLuSfFGkTflDANNwIB7Xo3YtCQCnAT+8z4TBTmqNdVz5yK
         ANf0sn3tFDgcFvOS3bzZEG2q12GLVoz48HTrBtAH8jJmasbdb26gW+JFASQPzthaza1E
         v3zyUf5v46K6HUQ0Xh34yLXYdWM3CLjFKnXikTIgy7ZicWPwU/JzOl27yJv3VSjPjGaZ
         vLCJoeLsPR6fFTSVJxBDzKRbMgQSnNpNcbI4jicOjeidwGH6HL6OlyRH8rT5zUYS/wgf
         2qFhkrkpzigY6jcvBx4kKtztjwn579kbPi82G6VFdOZQ0kbqUoQAaOnxeBKwQh0G5OkA
         Nj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742406295; x=1743011095;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M+o6ofympSPYwfyUQQxw/T2qMcpCmSc7tPx/FfKUNzg=;
        b=OM6GSkHUsK6nqZYmcwmbBw7TAEfCtpgGeYzF+FMQFhn0WspKrVO6Rv3JrNqZZUl8fK
         x1QXK4IodYGXdbbakM5XyYV81UAswBmHUBDUeAIwzDtOCacRpgprNhUTpt90misjjfmk
         82uRbn2Y3SN3jGXYE9nDI1Ct17+GDTabmHbBhpKgm/2vLvIFIRSSuHFfdYnFS+WfoZjq
         5wRc9b7H4Gn8nVTyuL3HyC6b+JICv3SvnulZpazrGpydgMUwrXlqtDKq2z0D8IgDCsl5
         +8tQZN9Wo6t49RKfC9bnRNMExogWKrqigglhDpRoMq+0a1scMhq5SPbNd4rsXQLLDI/H
         4YWA==
X-Forwarded-Encrypted: i=1; AJvYcCXWFRoB7Mzhz70C3s/KkbJ7oS8D9MFEwDLwzwqx2fHa6IPJpcsmZ1sAPLuYMQNTwBWaCxJuLy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6FD3RJ3NZvJRUYVXKyoDQ1+018NEqamqk7p6s3pcxR9G4U/t
	3govEGULY5v9UJugE20rfPvA99kR9KU5BUHGKdL3kU6vd6xTCOmY
X-Gm-Gg: ASbGnctftNUk+ax+EYSuPK57VOCD7W+vmIWqanOOI794vDMrVVpuBvqb1bSGcACoovT
	ZdZGG4mpbyBp7C7ZkYpJfOaeLEVD102+G7itJ+HoRL/R35kdI5f9ER32k5xhwVBzutmtInYiIxE
	ZMAcyDTCrKq2AsZvWI3ycFHfQXMRJ5UoVplTGZbhxV38FoctOB4Y5LBM57cKqGvyUkfxJ8HEO07
	gdwZSdmu87OupI+rQm2gvZTH/JMUsv5/wUfhLl8bVypotzaqeC7J2MaXYuj15i7YyZNDAsSrVY8
	NHsN7HK6+KyiKFMNt5Pz/bh9yXUysJUGUmkWUupxTQKY80zMUmjYJnh2UhhIKIoP9fDOOg2dQgF
	IrkpiLJvaXKVfWjxttorOyg==
X-Google-Smtp-Source: AGHT+IESPBgjo2/deVdlU1+KWDduu04TTHZz2JkBaZOTcFjRb5OkFlzzL+qc3wyeSVln7cfC2dXhIA==
X-Received: by 2002:a05:620a:4550:b0:7c3:cde7:a685 with SMTP id af79cd13be357-7c5a8396ad0mr480743285a.13.1742406294526;
        Wed, 19 Mar 2025 10:44:54 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c7859bsm883613985a.34.2025.03.19.10.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:44:54 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:44:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 steffen.klassert@secunet.com
Message-ID: <67db0295aca11_1367b2949e@willemb.c.googlers.com.notmuch>
In-Reply-To: <4619a067-6e54-47fd-aa8b-3397a032aae0@redhat.com>
References: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
 <67dad64082fc5_594829474@willemb.c.googlers.com.notmuch>
 <4619a067-6e54-47fd-aa8b-3397a032aae0@redhat.com>
Subject: Re: [PATCH net-next] udp_tunnel: properly deal with xfrm gro encap.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> 
> 
> On 3/19/25 3:35 PM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> The blamed commit below does not take in account that xfrm
> >> can enable GRO over UDP encapsulation without going through
> >> setup_udp_tunnel_sock().
> >>
> >> At deletion time such socket will still go through
> >> udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
> >> trigger the reported warning.
> >>
> >> We can safely remove such warning, simply performing no action
> >> on failed GRO type lookup at deletion time.
> >>
> >> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> >> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> >> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> >> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > 
> > Because XFRM does not call udp_tunnel_update_gro_rcv when enabling its
> > UDP GRO offload, from set_xfrm_gro_udp_encap_rcv. But it does call it
> > when disabling the offload, as called for all udp sockest from
> > udp(v6)_destroy_sock. (Just to verify my understanding.)
> 
> Exactly.
> 
> > Not calling udp_tunnel_update_gro_rcv on add will have the unintended
> > side effect of enabling the static call if one other tunnel is also
> > active, breaking UDP GRO for XFRM socket, right?
> 
> Ouch, right again. I think we can/should do better.
> 
> Given syzkaller has found another splat with no reproducer on the other
> UDP GRO change of mine [1] and we are almost at merge window time, I'm
> considering reverting entirely such changes and re-submit later
> (hopefully fixed). WDYT?

Your call. I suspect that we can forward fix this. But yes, that is
always the riskier approach. And from a first quick look at the
report, the right fix is not immediately glaringly obvious indeed.

> Thanks,
> 
> Paolo
> 
> [1] https://syzkaller.appspot.com/bug?extid=1fb3291cc1beeb3c315a
> I *think* moving:
> 
> 	if (!up->tunnel_list.pprev)
> 
> from udp_tunnel_cleanup_gro() into udp_tunnel_update_gro_lookup(), under
> the udp_tunnel_gro_lock spinlock should fix it, but without a repro it's
> a bit risky,
> 



