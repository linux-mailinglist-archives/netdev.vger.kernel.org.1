Return-Path: <netdev+bounces-157212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C332A096D9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A762516948B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263CB212B29;
	Fri, 10 Jan 2025 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsZnAGR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC1211A14
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736525527; cv=none; b=cI0sVw/Mnv3yymPPnV6BQ2anbxg1Ie29HtJa/GuexKhbWSs7ZRsiQp/DNXbvn1pRy8sGHkLy0x62ahyTIvr55PNmVfCBB1qagV+eKjoqdbSIbxD4XqMx9FGNMbuu2q7A21hIrOGwJCDiGPMze7OMfGfiQvkaZFKvRKnxV4nW5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736525527; c=relaxed/simple;
	bh=HEbirC8iSgw624MVMUKYzU5HArUL9eu1fHCRZym4WwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdtyaHH4xaE2cS8HrrTmFQjDhJqisJlkHxQDmqWMHsiPBesPxi+R+kN4HW+NrQcY3pDUMT7mNQ1+ag3pWrjWiw8QtwuYO17SQx84g3AFYkE883/xFdQLrrf1r0BphWqqZ+/7KrOLsIDhdV0KcEU6/tdMlPz5qnlF72qZvRuy7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dsZnAGR1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4679b5c66d0so239841cf.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736525524; x=1737130324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX4Yhzz0qOhfER7PUIMgz7kOsk1jnegY3+wUj90Zz5A=;
        b=dsZnAGR13VUKRr0mHLxcvk6CO1Q2kE+OZhDLk6a0iLGeJ/7g6BSCDMSsmatzXdUk12
         ZC44Oij5CzccSNHprD5UFzwsL00mXVbYZQkt1WWyyTIbFE0XVLJzVJCX421DGhvlFZmP
         K47rSpT/+EL19pF6bng57D+40eWRy+OTMdHPH6jLHcs2zdAUhHQpKGZxfBDjS69fdrmA
         5owF7WD22CEeMxxyTCqXGhjJstd/7dh2fchh3wxbglqizTrGd6oRH/KL+WRShJMLhzjS
         IX056v7VY1KJLfFPsk812ugHEQuPxMkvXuSWiHMpDm0kugeMyOyBabfQ4KOvG5TXYoCw
         p5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736525524; x=1737130324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zX4Yhzz0qOhfER7PUIMgz7kOsk1jnegY3+wUj90Zz5A=;
        b=rE8bmrSHZETL2Ofsb+1MH1Yx4RhUvETM4yIriLTLcp+z43JRpaJvfR1wxf2fnkVAmJ
         ereyYSTfqR03owOBAQHoXnmCaMr26/sD6ySgWS/CT9/PnZw7n8cxyZoXmTSvlfLY7mgI
         CiQqx2K18FhoQm48vCpWkdnRva+s5D2uurq3JZvEe4eIryIVfhI6QwJzNeTN28Tl6IWB
         yyiexMSAOtRXOiLGAhWJtM/E+Yq2QsLnBhx/WmnQMehmlzyua0qhtFNK+JgaWUConfc2
         KAeraVlHd6ZLI24VpkUhFk8QfLdABqqssrlK+Q+eaqTiQPl7t7Vdtd8Y3hwOj54su1xS
         qDdA==
X-Forwarded-Encrypted: i=1; AJvYcCWnZO5+POK49pEnPP6F7kFVcOp7QYGHc5JXIyWpa31JbB3vYHP3j21ivKQaOaG7SsNVnZW6od8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQL2LZydNdKCZBxltK4DuYFMt5K5h/zTcjgIqLxI0zDqW9F5z
	ZMj0GsNFdMRh3aBzyy8U+Ra56jKkIptyAlBE1Yuzczilzmw94nR/3Qbg5kri2TBARUc1DnhttQo
	4u3aN6F/1BQb4ogeh61hXdPgIp4+xG/wUC2aL
X-Gm-Gg: ASbGncvjujoyObVryTPkIarOB2r90xg4/AfZz0wC25QKSY7pW+jxd4LaugQ/4xujdNC
	EghzAyJyM2clXUT0tK7KzFlsE5pX8xNzYF9c6Ulaypumi8k//v7bt/7euDCoUOUnQaqx5CA==
X-Google-Smtp-Source: AGHT+IHgYpqkxUbmncPzXTA3eXAy+hwnWrMoJQttCoYeFkn/EKMRlXHYA1K2Z8fuvIM+IZ1TB+XWbSFA7z3CtuTd2dE=
X-Received: by 2002:a05:622a:201:b0:466:975f:b219 with SMTP id
 d75a77b69052e-46c87e0cfc5mr3845391cf.8.1736525524211; Fri, 10 Jan 2025
 08:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110143315.571872-1-edumazet@google.com> <20250110143315.571872-3-edumazet@google.com>
In-Reply-To: <20250110143315.571872-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 10 Jan 2025 11:11:48 -0500
X-Gm-Features: AbW1kvb5rKe0nelzmIJ-ZXpmSzKI1RW-GKQ-rsYwDLuGKwa5WvTLAkIH2DufTOc
Message-ID: <CADVnQymDMfoOEnYOXVM0zSRN=uWHb3X1JaLUyW8XEsnrbXUpqw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: add TCP_RFC7323_PAWS_ACK drop reason
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 9:33=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> XPS can cause reorders because of the relaxed OOO
> conditions for pure ACK packets.
>
> For hosts not using RFS, what can happpen is that ACK
> packets are sent on behalf of the cpu processing NIC
> interrupts, selecting TX queue A for ACK packet P1.
>
> Then a subsequent sendmsg() can run on another cpu.
> TX queue selection uses the socket hash and can choose
> another queue B for packets P2 (with payload).
>
> If queue A is more congested than queue B,
> the ACK packet P1 could be sent on the wire after
> P2.
>
> A linux receiver when processing P2 currently increments
> LINUX_MIB_PAWSESTABREJECTED (TcpExtPAWSEstab)
> and use TCP_RFC7323_PAWS drop reason.
> It might also send a DUPACK if not rate limited.
>
> In order to better understand this pattern, this
> patch adds a new drop_reason : TCP_RFC7323_PAWS_ACK.
>
> For old ACKS like these, we no longer increment
> LINUX_MIB_PAWSESTABREJECTED and no longer sends a DUPACK,
> keeping credit for other more interesting DUPACK.
>
> perf record -e skb:kfree_skb -a
> perf script
> ...
>          swapper       0 [148] 27475.438637: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438706: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.438908: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439010: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [148] 27475.439214: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
>          swapper       0 [208] 27475.439286: skb:kfree_skb: ... location=
=3Dtcp_validate_incoming+0x4f0 reason: TCP_RFC7323_PAWS_ACK
> ...
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/dropreason-core.h |  5 +++++
>  net/ipv4/tcp_input.c          | 10 +++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)

Looks great to me. Thanks, Eric!

Reviewed-by: Neal Cardwell <ncardwell@google.com>

neal

