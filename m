Return-Path: <netdev+bounces-218528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D742B3D04C
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 02:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92923AAA7E
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 00:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2139C13C3CD;
	Sun, 31 Aug 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it9hwPLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D27262F
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756600207; cv=none; b=ex1eEFd+FZnfByJ0UN3HIaOjTZBK6IdyVdLWQYx2Qh66VMqbeosWY3Ul8zBWaGYwXRFFkCgX5EAxv05wMGv0WBX4rKjS/p2bA0hmSeRGkJcFmN3qNhnCti3dfXmnvAmDdg84n2DgcQIy48KHrjj08EiUd2vd5UWwuzcILgk4m2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756600207; c=relaxed/simple;
	bh=5QX9HRnpseIDhhh0WjKGnnYIIFEtbPtOugvOOzSnLlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LF+9xfMgCvkoiAG87sbdDHdUY/TpxlMJ474THk2ul5T6baCGNS1zgHccsN83VyXaMaaei/Okq1XcdcfTO0zEzrzga+iQq7o37Js9WXQvYGGW7WGvp6xfzsYA/Yu07QzMImUs/4l+8Ejti0tRJuB6PRVe521GQwciDmnH3Dfh6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it9hwPLQ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ec3b5f05e8so14865085ab.0
        for <netdev@vger.kernel.org>; Sat, 30 Aug 2025 17:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756600204; x=1757205004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QX9HRnpseIDhhh0WjKGnnYIIFEtbPtOugvOOzSnLlg=;
        b=it9hwPLQ45p/8IYnK1YJ+gmDZuS1mDcTxpAgZAP89oHercvy3IX5mroBhkg2r+4olU
         2GZ3HYeS5Y4BiQrCEVz6OZhb3iFZiMtt0ocQ23wCPND7gJUhvOxD5t0SEgWGrr02K8/m
         rZYsGTeaViTd50X5Z8ywPnhfVEgdGzvRgiSpnFoDIruKhpAzniDp8/C+/gP1sNVWu9tM
         34EMPBj+DGnVx/XXEpLmn4VklcR/C2ZjHNAIMhEU+nRim1yzCLonDXDxdQO00EIbos/n
         D83AaSaMwz0cddDHd3AehhVf7oP9ep9lCLtiw4aGi8Yx+upJKlVlrWi7K8YM/2qM2Rk1
         2BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756600204; x=1757205004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QX9HRnpseIDhhh0WjKGnnYIIFEtbPtOugvOOzSnLlg=;
        b=GxKlzVvTYmfkhECe2zSjGvMM14I0RqChnqE3cIv9sN02nm/YgHwHC/fT7jpFkwF/RC
         MeX8GrBIRt0BJwFMBURH6A4rFFnJTRYCDOpDErOmQ4iprK2MxeNVFwtDbC1UDZVt6ZdE
         AubYTcZG1At+5OWla6WaYvZt3wnjS7jovHkqGqCRHtRfWcYl24II18pkwnLH/ICrN25z
         IqCRjIHdIs8Xpk/sDhgImTD2YQ6R1xp/SCuJdwfwM4EskRoAu8QPDebHYSsobSNJ7bcp
         VpPUa0fcGyNOlUejEroEQ1a+FgWyrLM3OsOJDNpDsf0Bdu4HOE5AcQQccYSOgrSZrxnw
         /uKw==
X-Forwarded-Encrypted: i=1; AJvYcCX9Vaznv/7InN6T0m+xMrMi0v2y/illw3VkrDITUMy6Mb2WkHLAghbIthOqe80Xhr66cR7Gb+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZWrPu3HgTXPyS/ctF0fwb6Nm21l4eKw4i8+5kDowPPz9yk1n6
	texsmiCP3XN75g5vDn5xHBJpb79h6fLyEa2KX0lOvejnkulw6fdQAIAZAnGHWPuWk8RRae63Fx+
	H/RbAu9/cJKGNevxrI/NQrCLpzjH28wk=
X-Gm-Gg: ASbGnctR3CUPeu45UWCN7TG/RRD5VjwPvfxDWYMSFONKN4fxSUmNcyUok73o6/26fxp
	T4oAPpMbtYEHYT9lv1E/5SnzKZG+fQgAoHv8z3EqJ6aGuFAUftqcZ/hpwVQTyST3bozBum9Tinw
	xaZRuAf88FAb3StWhum9N9f9BZyHEYK7WeS9Rlb0oTvC1D/ugSLMSlYCBb5y51FEdXWoPk0VdAd
	fnOlpg=
X-Google-Smtp-Source: AGHT+IFzZ4QIyNYs5Jyv8ukbwUgWjCcUqp8HJoe9BxzuZv6Sfeqoqmci55RNJzgUdalP/l7zp4mrVWbOu78JN9VuHXE=
X-Received: by 2002:a05:6e02:12cd:b0:3ef:175e:fd20 with SMTP id
 e9e14a558f8ab-3f400288a46mr82218295ab.8.1756600203659; Sat, 30 Aug 2025
 17:30:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829215641.711664-1-kuniyu@google.com>
In-Reply-To: <20250829215641.711664-1-kuniyu@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 31 Aug 2025 08:29:27 +0800
X-Gm-Features: Ac12FXxthAh0iPfHxFNIQ5GhVRdKBkvAqlVqZYqWE-Xhlt3_3FVKMmpwl0gDYXY
Message-ID: <CAL+tcoBCs2o=KJ=iWPyhUK9iRrfXEAmxT3+CCCJOdrW0Tr9P0w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] tcp: Remove sk->sk_prot->orphan_count.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, 
	Ayush Sawal <ayush.sawal@chelsio.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 5:56=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> TCP tracks the number of orphaned (SOCK_DEAD but not yet destructed)
> sockets in tcp_orphan_count.
>
> In some code that was shared with DCCP, tcp_orphan_count is referenced
> via sk->sk_prot->orphan_count.
>
> Let's reference tcp_orphan_count directly.
>
> inet_csk_prepare_for_destroy_sock() is moved to inet_connection_sock.c
> due to header dependency.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

