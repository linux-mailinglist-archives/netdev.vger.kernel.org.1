Return-Path: <netdev+bounces-177745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516E0A7181B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD92A16AB25
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30E1B653C;
	Wed, 26 Mar 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P25SKem3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CDB18EB0
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998160; cv=none; b=fWtPqJhyJAs3VancKfNh9DPJWIugg/JKZlVHJ/jW/NP7LNipGndH4HDPUSPk+4iUgi+5qGJWkoq+ilEg04jpDLcsRo+ijpIjmRCFDB0OvclG/YyW8Qun0jyOaHWQ4k5rPTNUcM2B8hENC5HXlck3A597DMGsWzfpOLnaSyldNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998160; c=relaxed/simple;
	bh=kqt7JrNYPkUN4HcfjIW/R963pK4UlTo3T83v10WuMzY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UyFP7afbNY4PWCB0ll9klA/ZilqD0XvSd5ZVoqW5cvL8itDhuC82GeKt3FpJ/AA/XHDOkt2WwIoP1iIVyJNm1MAOker5JNLLIiZ/P9nML6Hgtli/n/KdK3Svqffd9dhBzVjVRMaoweCtMc4WxNpILApcSAl3GBIq6i60WpuuFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P25SKem3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47690a4ec97so70519251cf.2
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742998157; x=1743602957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmogFX1YAVBT/bWfMsM2wHXnoV+i1l95uTRI/yz2esk=;
        b=P25SKem3G6QGrDVnvRrN1ktW9Go/nfmKru0BhYtqqkqaX17aVg6+rA6nrNHPnyhbnF
         a8GQrs/r39qj156u114txM07HiLtxTHHSfe9O/RA94MVaEkTt+yJgQOLSP3dWdSO4z/X
         WMw5z1r2VkFq0KBYxLdz27tBTnwp4GAboKJp5mDkBWXYTmu5zaCSsexzBEFBxtn8FLa7
         xqi+vdL4gN84dFZT33Lx9/lc0uUXA0uV3zvYslMZs1IKqLwbsg5ykfyxxjgG8Gj999pv
         2GaMpZBTn/jwe4/jcbuS6a19UFGj6Mt1COMIXyyWNFREHAhOIh9PkTIozWm8RX3J/HLl
         S5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998157; x=1743602957;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MmogFX1YAVBT/bWfMsM2wHXnoV+i1l95uTRI/yz2esk=;
        b=TJr4l5Zkz91505bcEZrHZTg9sYCxzAs7/JEgd4sE9jVuR8o79aqeGdl+mQxzggfpX2
         otO2tGNyE9HmUXNp7tX2zQF3RroFbsYjE0wLnGhCUJ0YF918v+IkgDtTQXxTgfEb9Tqs
         0tYTROVSAYO6apUB2T45jpPw3nlR/U4KuQisaXyrSgwOL0QhKITDdyOMyeJWriabe6Lo
         7+StqZvVRFV6gATGvG6SFy7NuqQDtIHuLIMrwtcpf2X6bcQ9px69pNLG+rLSJ//zqyN9
         mh2gCZDsy7why4QdvfNN9VcD8A40+3n/gumNbZlIN/8oYiQM2U3Gkr3AflCjfsf4dQke
         ifWw==
X-Forwarded-Encrypted: i=1; AJvYcCUmibzCraK6KOpngo1RbL3ClJz/i/72AqV5xnKPVV1vbSJShtZiX9gvF3L+cvHkGt0ywMuYUy8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2pMzrLW5Q48edMS53DHPw4UAVrK3K8QBf5cPZuXB+c2dLEcp
	EbLk3wcMDr/lvRZVKkgwiw7XYREpFGj9ixP6COqUchPHJBBEXZE3WzB0WA==
X-Gm-Gg: ASbGncsUF89PE6sPjCf4dUlC0+lhN20NHUXviTKJJ1o1WFVYzC2R+sqvd3pLPaO0PNW
	1rC89xD2w/XV/Khk1wakFhPrFF6EGVoI/dVmeBrkGOEl+xRGe7osciNumKobSZnUwO6cSW1JHYg
	ZFtWdmySCBQ97abuDLkou7E72FvTLI2gZXnafpFTLOvFGP92OxwuZOBH9XtPnAhTJ6Yh+NOTPvy
	8P/lH+Hy9y+TaO8AkjFzQjb43V0y2Cjw6rcONMQ9Wg2EDm5I2kgFeFenVRhugWiInuGWhOquiAU
	LB1tpEJuNHw5zqPtUdzFQcPSsC3ggCnr6QTLa/ZcmJ9GEvW6qL7R7+nmKGLkrcR3dai26OwimvS
	MIg9HWPsGf4kxyy3g7JMk6g==
X-Google-Smtp-Source: AGHT+IFI9iXJ3qjcV/7T6H6DjOG7O98lL7anLlm+w0fS5i6139LsMqWeeiE3aGDDiRqt4FzvsqRssA==
X-Received: by 2002:a05:622a:544d:b0:476:653d:5aea with SMTP id d75a77b69052e-4771dd6283fmr361956831cf.4.1742998157035;
        Wed, 26 Mar 2025 07:09:17 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f6a3sm71925821cf.38.2025.03.26.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:09:16 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:09:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <67e40a8bdadc2_4bb5c294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250325195826.52385-2-kuniyu@amazon.com>
References: <20250325195826.52385-1-kuniyu@amazon.com>
 <20250325195826.52385-2-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net 1/3] udp: Fix multiple wraparounds of
 sk->sk_rmem_alloc.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> __udp_enqueue_schedule_skb() has the following condition:
> 
>   if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
>           goto drop;
> 
> sk->sk_rcvbuf is initialised by net.core.rmem_default and later can
> be configured by SO_RCVBUF, which is limited by net.core.rmem_max,
> or SO_RCVBUFFORCE.
> 
> If we set INT_MAX to sk->sk_rcvbuf, the condition is always false
> as sk->sk_rmem_alloc is also signed int.
> 
> Then, the size of the incoming skb is added to sk->sk_rmem_alloc
> unconditionally.
> 
> This results in integer overflow (possibly multiple times) on
> sk->sk_rmem_alloc and allows a single socket to have skb up to
> net.core.udp_mem[1].
> 
> For example, if we set a large value to udp_mem[1] and INT_MAX to
> sk->sk_rcvbuf and flood packets to the socket, we can see multiple
> overflows:
> 
>   # cat /proc/net/sockstat | grep UDP:
>   UDP: inuse 3 mem 7956736  <-- (7956736 << 12) bytes > INT_MAX * 15
>                                              ^- PAGE_SHIFT
>   # ss -uam
>   State  Recv-Q      ...
>   UNCONN -1757018048 ...    <-- flipping the sign repeatedly
>          skmem:(r2537949248,rb2147483646,t0,tb212992,f1984,w0,o0,bl0,d0)
> 
> Previously, we had a boundary check for INT_MAX, which was removed by
> commit 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc").
> 
> A complete fix would be to revert it and cap the right operand by
> INT_MAX:
> 
>   rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
>   if (rmem > min(size + (unsigned int)sk->sk_rcvbuf, INT_MAX))
>           goto uncharge_drop;
> 
> but we do not want to add the expensive atomic_add_return() back just
> for the corner case.
> 
> Casting rmem to unsigned int prevents multiple wraparounds, but we still
> allow a single wraparound.
> 
>   # cat /proc/net/sockstat | grep UDP:
>   UDP: inuse 3 mem 524288  <-- (INT_MAX + 1) >> 12
> 
>   # ss -uam
>   State  Recv-Q      ...
>   UNCONN -2147482816 ...   <-- INT_MAX + 831 bytes
>          skmem:(r2147484480,rb2147483646,t0,tb212992,f3264,w0,o0,bl0,d14468947)
> 
> So, let's define rmem and rcvbuf as unsigned int and check skb->truesize
> only when rcvbuf is large enough to lower the overflow possibility.
> 
> Note that we still have a small chance to see overflow if multiple skbs
> to the same socket are processed on different core at the same time and
> each size does not exceed the limit but the total size does.
> 
> Note also that we must ignore skb->truesize for a small buffer as
> explained in commit 363dc73acacb ("udp: be less conservative with
> sock rmem accounting").
> 
> Fixes: 6a1f12dd85a8 ("udp: relax atomic operation on sk->sk_rmem_alloc")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

