Return-Path: <netdev+bounces-206385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D28EB02D2A
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 23:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD2E4A24E7
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 21:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BDB21B9DB;
	Sat, 12 Jul 2025 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+X8/216"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987BF2206BB
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354729; cv=none; b=b1CyrTv2TV52zFd2cjiiu9eOa8I3Rpw7bU4LQJO2/aHiRLiNReZ6up7t1C2r4RVqN1j4pozDRYOMycbBhbDxs5f7LeQ0Dat23ndz25s3pV2sFCxX0jK9hJO4/Gv2Z7VpGEJED8eGsuSUigmluIvAe77TtmDSZBppp+nNCrmZF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354729; c=relaxed/simple;
	bh=MoDtDbP0YFxuDH/+1SuRsmy69O8Pw/0YdqsPzDF2evI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukb4q4S7NpZNheM2q1gpam4Cj7nit6YsmOR3nyPhLH853YyjioniOA5/PajOsjBTbHLmv/qm+c9YzeIlV3B8sJvNcLvknIYj7+5Zr1r+TPfs0C8kTh9dP2RQtYXM7clhouupPLx3wlx/6YMjGeVV8sEW0NPOmRUsMUmGG9unH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e+X8/216; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso3268631a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 14:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752354727; x=1752959527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoDtDbP0YFxuDH/+1SuRsmy69O8Pw/0YdqsPzDF2evI=;
        b=e+X8/216c4/B1l/3YaW6U7+SPyrDZ778zTb30Q1da8UMrvbyWxIwaueVT/mTHdC1pb
         8k07zLIwuJwFL/3QM0j5pAXVozjvEi2rajezqDjWaccokuOGSONN8DdrMhnK4+oWrp7t
         ++ayGcmCv7gIl/ECC8LDWaCUdMlAvwfguyLfQkFBv8QcyEV37nptKIYL+WesOR3Nmx79
         Bjtx1wm6kNIzvVhHcnH48kBC4CZbXjV0SvYmfZQR8hJCqhKsDQjS5Jp0MC3ER/SPVelM
         PI7dFVJmOO5Zp/Hl33rfMtsGzI5ALOpP/zNCY7GztnqClV30rE1kbcptAJb1ymdL1c3i
         CoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354727; x=1752959527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoDtDbP0YFxuDH/+1SuRsmy69O8Pw/0YdqsPzDF2evI=;
        b=L/R+wF9wCDHHaac3sGyeWm983MhOndp3qsXzClwP6Ok9plcy9VZnlORWErlV4sAoqs
         eEcYfWlKR7tp7GqjgIguHhxBw+z/2Y+Dj63wSTopwQATEDMoOG7dHwW064TBbO/4HWge
         v7JvMaCamnOXC5eI/9WYmwWEpqASOcpXf3Ka5Zhca/FVlW8JPN2yXa3WVI1uYZw4be44
         j8c327HowfZoIWkGs3ULMYRaB2zts8hQqcqlu+4y9/MeREGGRuu3C/GdSn6R6xML0McO
         FJy5DwA6FIvLIdvcZLwXHo7bqoV4uzIMKByQ72/Dit5uCSdwyc+5laimuNCJYiThHlqI
         diOw==
X-Forwarded-Encrypted: i=1; AJvYcCXbIs3Qz0tRg32RjbxfiF3nxpAC/IzQVL03grfYjS3cp8z/XTjPeig/89ehZHJ71zL/Ap1o6LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4S2K2gp6RRYEmcKsK9L0oMdh/3JIQGelBLPd4e5PBmgdzZnpU
	6dJDuZleqlfYq3hlXbhv6lkMm0EEDFR/TIdwpY58AVs3etqjD/7dABO59U+WgdQDrGqyWkSodFC
	YoWSnzJe9MNYAN8gwZnPeXUE/mvNWCV9Tu6Wo34hl
X-Gm-Gg: ASbGnct8XqLQR46OCZtJ5HAh+6I6325CKmz3uyY73KH3S2BK5V8X5OCocPzzMgwZlGc
	n0FkPXmMRSDpWD2tnHtte+8m8Aw0zaypIT4iQOQN3d5V7bszFKlVjINviq+bWcDKtWIvvUMGx2o
	lInVSfcl20EuwKxlTF5/8ZQaAHdsC7zO+NWz39lU4zUGk+wagOjC+vFQt5DbvNOTTwyhBrB4JT0
	0R2HEhVJ2wNZna3Zvpv/fsDe1OJyYmicNvyHK13
X-Google-Smtp-Source: AGHT+IFiO72spmSrY4RtvHl1AKlICLdLR0c6CK5zP8dzcFaGhA3Smmzd/1c6H7XotRF6xmMaoYZcXUEgB4fIzBcIAxI=
X-Received: by 2002:a17:90b:58f0:b0:311:df4b:4b94 with SMTP id
 98e67ed59e1d1-31c4ca64d62mr12297786a91.4.1752354726604; Sat, 12 Jul 2025
 14:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com> <20250711114006.480026-5-edumazet@google.com>
In-Reply-To: <20250711114006.480026-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 12 Jul 2025 14:11:54 -0700
X-Gm-Features: Ac12FXxV8wNl9usAukcOCZxr-VP2PjM6eXVtNdE0XRMiCKeIz3tmHqZeRRcCC40
Message-ID: <CAAVpQUAfuefjm9d4_ny8EP2F4XUB2Nk8-VgvufJLQ+8Rq=NuBQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] tcp: call tcp_measure_rcv_mss() for ooo packets
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 4:40=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_measure_rcv_mss() is used to update icsk->icsk_ack.rcv_mss
> (tcpi_rcv_mss in tcp_info) and tp->scaling_ratio.
>
> Calling it from tcp_data_queue_ofo() makes sure these
> fields are updated, and permits a better tuning
> of sk->sk_rcvbuf, in the case a new flow receives many ooo
> packets.
>
> Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

