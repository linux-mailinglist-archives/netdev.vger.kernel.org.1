Return-Path: <netdev+bounces-228143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6EEBC2DCB
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 00:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB87A4E61E0
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50DB246BC6;
	Tue,  7 Oct 2025 22:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ4/G6Nx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F0123BCF0
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875952; cv=none; b=PsUARKdHII790ouo8XKP/wmxIemYAj6QDyFYxKCw28TjNuia5gv/oY8cinvX0NiBg3FGm1f5ouTndvQXjaEwONLjh5b/7O46ig1EjDeUfXbGxJr4mEkjQjnZ/G417LsPYWqUXgZ529TkbHGfIogeQxWxJKEiQ5rfheuBg06py94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875952; c=relaxed/simple;
	bh=i5+0tfm/Mct0J/3Ho9N8KRW8rMQpcogmoeJad+Y+haE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Y9j7mC/aIpo2twDpYZuf6pBtO06wfxVQBu0OtO6piCnHJMRrqecWpIvzdh0mXGXAO/EM+Da8nth1H3WXhhKD7toJwkxdYUckfF4UrbbTosxkMova1PaKoEIxLIkKyT7xmh66aSJcm3zSqsi3QURB1/2M6uh4iWnSlYGrGtan9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ4/G6Nx; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-59d576379b9so3246916137.1
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 15:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759875950; x=1760480750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00IZi10YYVM2X3YETEvHno0ALGz2ALjuRwvjrr60loI=;
        b=KQ4/G6Nx2q8I8Bl1bn1XdjuJeTj6nm0Eagf3pF8Iw2cm1ZD6qRTLXWNoa3CHB6yMpv
         Vs1jQfzhkLsVtVOpQdlKtGoJPQXHsBi+jkLjZ1L3QmzSkCymupdxEXkieeHqxd0ZvSD/
         Rh4lVgBovKS/wQVP/o4VBg6ZcpzPXZhfamuGMMQnBlixQno6c44go50vZBf/pBepEFsz
         14+3/sI5xHDTNDv3/L+syAICrKqIXy2TYlJNrDzAy2xuuTIuFpQBHI7WdcLnIo9BQ2c+
         aT5L3R2ASxMzJuwNGYZgpIEe2txCUU13Y4DxWDE9xvuINkUIH0PRhTpd43+tB/ZD+fAl
         6ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759875950; x=1760480750;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00IZi10YYVM2X3YETEvHno0ALGz2ALjuRwvjrr60loI=;
        b=MnKPNwiga1viz1YL0dLFVZntJtvPmxA4HmC1AlqlaJtRaialTQUYffSpz6eWijK1vK
         wOhVAKYakosYnktJcC3EwxqiPveTw3EOl60nny7G+Sjl4TGDq+Y1utNKn52kywkys3Ku
         8+xGIz6O9jEwPwENJMT5OCQFU2mL2ozoHszes7gML5b1Nh13psTp2koBiGdwhi+szzu2
         L4MeuwcUt6cTKFD8iQxWb00cJKmPZj/4+1QoJ/elnC7HvdZEuSJKhFasqzM7Rt6Aqn0y
         Gli+MvOB+CNjxE3XkOrfw+4TQ7y9OGJxm1tDzsoyRUQGw9KiGsG79w/YLP+vSUnATWmT
         dveg==
X-Forwarded-Encrypted: i=1; AJvYcCU4tYj4P8Gshtho2fFMI2hBex9Bqa07Tdoi0N3DDyIXfrLphD3WpAGOD77wmWLBtYaxOW3zKKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBjDsc2bF3Gbt3hWbbdH0dL6oL19Ojsn8voq5rrz+ddFw9xd8
	DK0fVKzRjy05y25ootnxzxsFMY8nAiVkp/nl9Dh3yO+WXVgtQXl/fU5V
X-Gm-Gg: ASbGncuBdS3UTuePiWau8HJkoLpYnDqYYlNITu1EmxWrZZJpI0jmPQ8ZrquoCuhevEi
	rUKkWKtXxaJpKxP+nTvfa+3qUcGlntGzuR8Vzc0GqcCMRv/ep1kGyKYkfFk2OYlEz8WYLXu/zw5
	hZTBf34Rw8oB5looFKo0LFzpzXDTwTRoS/Ri+cJT/OixVUPukOVFntCpv3pD9KNFPCAH8xWyJ6D
	fVQXhqTY2etIoSWejP+/gN0mMhCS9on06jtB5Ai1GXFTdlztFLxNUkoeaC6n3GEAqFH+Dh210yO
	eoukOgxYHO8ZhQR8qF/GMotKMl2mav//etLOJpisoitnooEnMz59LgH//m45DUFPkHA//7oaY/+
	91Hn5ZyJ9JOOMgab2NrLCkiXFlV9qslQ4XuKPsn4VWynDBtlG3PTQa9WyDzH8Lbv4/dSxWSbhp4
	gD0slgTYky2PjPA1ySkQ==
X-Google-Smtp-Source: AGHT+IF9KBpZjh2CPxOiR8/zKE/kd2Ivb0hcCldc5KfJ8zVmkw2TDO0ByZBr8LTxlSgSniNrdDpwLA==
X-Received: by 2002:a05:6102:4492:b0:521:760c:7aa8 with SMTP id ada2fe7eead31-5d5e23aa038mr477313137.27.1759875949625;
        Tue, 07 Oct 2025 15:25:49 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5d5d386216csm1129909137.6.2025.10.07.15.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:25:48 -0700 (PDT)
Date: Tue, 07 Oct 2025 18:25:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@idosch.org>, 
 Dmitry <demetriousz@proton.me>, 
 willemdebruijn.kernel@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3a8157265761f@gmail.com>
In-Reply-To: <aOVIAWAxpWto8ETd@shredder>
References: <20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me>
 <aOPEYwnyGnMQCp-f@shredder>
 <MZruGuax8jyrCcZTXAVhH0AaAMOZ-2Gcj5VeZO8xy8wS9FqwA3EMhPFpHLZs67FAKCu6z3GpEVeArSX2qGdSUqsysI-0o13dKK1ZmUhK_l0=@proton.me>
 <aOVIAWAxpWto8ETd@shredder>
Subject: Re: [PATCH net-next] net: ipv6: respect route prfsrc and fill empty
 saddr before ECMP hash
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> On Mon, Oct 06, 2025 at 06:31:10PM +0000, Dmitry wrote:
> > If the 5-tuple is not changed, then both the hash and the outgoing interface
> > (OIF) should remain consistent, which is not the case.

With git fetch over SSH, the process apparenty explicitly changes DSCP
(by calling setsockopt IPV6_TCLASS?). Which triggers a dst reset,
which that may trigger a different path. That is WAI, right?

Policy routing can explicitly specify different egress devices for
different DSCP settings.

Is this the entire issue? The original message states

> In an IPv6 ECMP scenario, if a multi-homed host initiates a connection,
> `saddr` may remain empty during the initial call to `rt6_multipath_hash()`.
> It gets filled later, once the outgoing interface (OIF) is determined and
> `ipv6_dev_get_saddr()` (RFC 6724) selects the proper source address.
>
> In some cases, this can cause the flow to switch paths: the first packets
> go via one link, while the rest of the flow is routed over another.

That sounds as if the OIF can change in between the rt6_multipath_hash
and ipv6_dev_get_saddr calls for a regular socket, without such
explicit DSCP changes. Does this happen?


> > Only with the fix does it
> > respect the configured SRC and produce a consistent, correct 5-tuple with the
> > proper hash.
> > 
> > Therefore, in my opinion, this should be fixed.
> 
> Note that even if the hash is consistent throughout the lifetime of the
> socket, it is still possible for packets to be routed out of different
> interfaces. This can happen, for example, if one of the nexthop devices
> loses its carrier. This will change the hash thresholds in the ECMP
> group and can cause packets to egress a different interface even if the
> current one is not the one that went down. Obviously packets can also
> change paths due to changes in other routers between you and the
> destination. A network design that results in connections being severed
> every time a flow is routed differently seems fragile to me.
> 
> If you still want to address the issue, then I believe that the correct
> way to do it would be to align tcp_v6_connect() with tcp_v4_connect().
> I'm not sure why they differ, but the IPv4 version will first do a route
> lookup to determine the source address, then allocate a source port and
> only when all the parameters are known it will do a final route lookup
> and cache the result in the socket. IPv6 on the other hand, does a
> single route lookup with an unknown source address and an unknown source
> port.
> 
> This is explained in the comment above ip_route_connect_init() and
> Willem also explained it here:
> 
> https://lore.kernel.org/all/20250424143549.669426-2-willemdebruijn.kernel@gmail.com/
> 
> Willem, do you happen to know why tcp_v6_connect() only performs a
> single route lookup?

I did not fully get to the historical reasons for the differences.
From v1 of that patch:

"Side-quest: I wonder if the second route lookup in ip_route_connect
is vestigial since the introduction of the third route lookup with
ip_route_newports. IPv6 has neither second nor third lookup, which
hints that perhaps both can be removed. "

https://lore.kernel.org/netdev/20250420180537.2973960-2-willemdebruijn.kernel@gmail.com/
 
> Link to the original patch:
> 
> https://lore.kernel.org/netdev/20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me/
> 
> Thanks



