Return-Path: <netdev+bounces-191096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6565AABA0C9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3418B1C010A9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB541C5D46;
	Fri, 16 May 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzTLUTjl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F517A2FA
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412972; cv=none; b=WDSxv4GgLCnZZKxLhHzPU0PdWZdm3cZx3FTutMvtJdi6Dp62Wp87fdndgJ/6PGnoc8SzmTcW866Tc2+ii/kN/DkeYmuQg5AQdQv6BwJ8teNQAqCrdnvXARSumSA5akPvPuplNQZ5ro55IKbRPGpW1JqHE7I8lVOU6aAzlb6u+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412972; c=relaxed/simple;
	bh=rylh6WL3Q1ZaGtDRQVbqJTJxVf6dqIfr3z0RPObmYZo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Vdm8/mq6Vdbmh/mnCP5Ip3DjxabfPlGSNXi3+K44T3PsK1VuwaxyZDGCFnBGlt/Fzfu1QrNu19vXTdBBITSEo10l+8k+vOmlx9s7emyfHt3U1P575zPvNKZR/Ywa779WZ1ikyCvkzJQi61q6Y08iRHuwo5j0Z8obf8GrA3QYdi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzTLUTjl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f6e5172edcso35437836d6.2
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747412970; x=1748017770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5gc/iVuBjrvlcWvB9cJUPkmLfgs9UwIYQuhrkRMSMA=;
        b=RzTLUTjlh03MY22vUcAIx59tA9HhOUsBV9VJrlzseFWidZNh1sI0P/9kVFZPuGHr1g
         ExUPE5ap3KT/S2Uq+LNWID+GrdCqjSr2/6Sww8V3kU5fJH/Z7R8mQPekAo4MIWO5qr0V
         FB4NUXIlP2ccRFZF/t4J10mLf6VhorjKJHE9WsM4S/3SuJw4A0bfR8fu2brpP4rsbyDr
         noeDlC9KfOt8N1PybP65ZBESNzW2OZRK5edsYN3nfg82EfCSjKhYVcc9q4v0jaanl0yy
         rSpE8y0Zs2iiqm0skfN3mY0v/wErg1uEocp6tgWmZ8BY6hLwpG9gDj3fuNUqxuRXnigD
         Q0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747412970; x=1748017770;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L5gc/iVuBjrvlcWvB9cJUPkmLfgs9UwIYQuhrkRMSMA=;
        b=FEM8jxCl9ExF5guuEYjC2SaLDHW4Yi4sp32nLMruPMVQnfKiL8USNl6wHPPrQtOjfl
         f8CqZ0+/6h4vfqVk6qh3Qj+W9mceiiS79JNmGJEPNKnfOEMGW5pvm8psV2UeX5MHfHoj
         nwMw1TIWqGYugPLM4dfrYq5U32q6DuVY0T60PhFxroIYAymjHbDpVKekYK79foB1B5Nj
         vK7MHZUjx9ghPptip4W8bpYv0i3XdOf8WSSAaZPnppnOOV/ubvGGJyPSB1rh4rHVnSlz
         ccF5L9ZLq89jkQjn3m6XFL30WcxFP8r0TXY3w5nj1w/BtFVcyHEkAE9hfh7m6caFptUu
         y8Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXl7D04IlwTQx+5NqX91jS7lVAwHKmDseSCBEgob17LWdDwQY9mBx+Zq9enoa/c3N6oXq54BPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEHwwWXpxFgih3amYX9+Bnkb6kk9/3Fw5t6FFgoB21fTLYokTd
	NvG0lu6asBpwhMyMMld95IpYN1ctqDU/KSPv1o4Kwm6sz7NiHTsYvFP/Iy6W3A==
X-Gm-Gg: ASbGncsh26v0MR5Jf9z8SBd+lzGPJrYkraBMu6D6F/AiBiXbCWCebvMaeIPwrMohPFu
	lQlqlIcKj64NKte2vwSGMvCM+28ov8+REA1OvEr2P6Oi09/SJ0iL6sPlw8CSXJD347ir7FeFVvg
	H+310rPlgEE7bsxwrHQQVhpbXsXexGPj76CS8VzW2auysesyyBo+ufuYarbcwUvcBNw4gUYM3Yh
	7Sb6KZu9SeymuBzekIVVlJLmrailpTLv8LoBac+R4WSZ7BRFawyQ6WHtrQQn2SHyjSnhUPF10Ex
	Cp6h3E86VL8K5WjwWmj1I+9P/87gK2IhlTvySec1l/6vPfbDnOP+jGoksy/B8wWw2ijQuiLkM2H
	FfTH+Ut6bMHRZt8ToYmmClms=
X-Google-Smtp-Source: AGHT+IFy/l89oSAXWyDQ/5TJ9pruqm7HBMEWbNwGO+/m3sv/pSIQdCyKSA3ZGBcN+nJ5PYEhTcHuFA==
X-Received: by 2002:a05:622a:4a13:b0:480:9ba4:3022 with SMTP id d75a77b69052e-494b078d909mr48247671cf.17.1747412959406;
        Fri, 16 May 2025 09:29:19 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae3cdb85sm12967151cf.7.2025.05.16.09.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:29:18 -0700 (PDT)
Date: Fri, 16 May 2025 12:29:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <682767de92644_2af52b294e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250515224946.6931-7-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
 <20250515224946.6931-7-kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC}
 to struct sock.
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
> As explained in the next patch, SO_PASSRIGHTS would have a problem
> if we assigned a corresponding bit to socket->flags, so it must be
> managed in struct sock.
> 
> Mixing socket->flags and sk->sk_flags for similar options will look
> confusing, and sk->sk_flags does not have enough space on 32bit system.
> 
> Also, as mentioned in commit 16e572626961 ("af_unix: dont send
> SCM_CREDENTIALS by default"), SOCK_PASSCRED and SOCK_PASSPID handling
> is known to be slow, and managing the flags in struct socket cannot
> avoid that for embryo sockets.
> 
> Let's move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
> 
> While at it, other SOCK_XXX flags in net.h are grouped as enum.
> 
> Note that assign_bit() was atomic, so the writer side is moved down
> after lock_sock() in setsockopt(), but the bit is only read once
> in sendmsg() and recvmsg(), so lock_sock() is not needed there.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

