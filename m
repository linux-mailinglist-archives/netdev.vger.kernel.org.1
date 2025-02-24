Return-Path: <netdev+bounces-168921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65EA418F0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D377A820E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F94724A07A;
	Mon, 24 Feb 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o73NoStB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCAA245014
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388958; cv=none; b=VZImOYV9ZINZrcThzSwQl2IQJxDMuHm8+lsPvM1BxUXReBc0m1BierSgXTHUA8z8Fd/wVyc9ct2wCqWSQqjog7vmlovrRAOnG6smmD0rq/JqQs2Gv8iJcQsonTEByTxLF3z400kFye2SNZDuBj2RM7oXPsnlXQN4XyQBEOmFkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388958; c=relaxed/simple;
	bh=6JPAG2RU/kFzr4cSU/vWPx30eJsO7iy+g7ZoLc03Pag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8fsoHvUtcWJIxsSCEQJ+yI0UD50fuoTRZPNw84G9iqGt2N5DTYK1MxUDpeWb1Q9M2qPHjsi6j3h68iKjHgN33F8SP1uUNIP03vv2x4A/YhzwWy7RiH7RRNCuVVnhwmFxM/A5UFeCZEIF9fhHvy4dyitXXNucFEvrnt7qY8RpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o73NoStB; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so6827073a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 01:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740388955; x=1740993755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcfMGdqmDz/gJTfycx8s4U1MjYZduqFDKxMJXtqNP6Q=;
        b=o73NoStBrRMzEUMWTFKVjuGALz19AsvOk4l0TQSzVUtqBB26pizMMvKFzZoUdq/Gn5
         g0Hko5gZGfTTMwsda0uPc3fB1Jqi92lpcx9xfpE7S0pBmMqb+C4Au3TGluKsjpGiNRKM
         AoSOL1S4ImcT2NxOWwM6w9ESSp8RGffxVQlWxclyUpQa5A2Rvb5ku8235OJfxL+x99Xn
         UF4P/DYFNdaXcWVsQ5RAjfiC2R07YEnPjhz4lcMsBtpx7d8ATp0tEWvGVSQDvoYMIGsZ
         nRmXaCSbs74z/14/YqVakFHWWsZ3Zp4BumVssSKOr5L3YLGypSq4KoBzLYMm5UEW/hfW
         5bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740388955; x=1740993755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcfMGdqmDz/gJTfycx8s4U1MjYZduqFDKxMJXtqNP6Q=;
        b=qirxSgwfPfh9IIvm86oTbxOvH6T6dcaCMDsVnO1n9nFu4GNTEX/VJSxmEm4TewRLVf
         sOPf7m6Ni95cR7R+P/eSer6kzGFeEp7hPjwLM4FOJ2THbfDyk9VK1LYWmBxW1oTWGzD6
         0FFNmNTM5/b1qGTULYMkwRkSMf3bExM3XrP/mahf2X7SY/AD7h5tMwsLo+Qf1MpTYxGj
         wT+PskXHrVfhHxOTX2TVkzt7E4NYhIOacEbW254ifLe3X5DXuyMfVq6RtM7R70xyFLKc
         TGBGOFbw9Y0acSn9l3tg1p3mdZ4O4+9qqn/Q2Q/cs4FqEy9wrfCn40/NMOP2bsUzawmb
         XXjA==
X-Forwarded-Encrypted: i=1; AJvYcCXMN2L/K5W/WpYMIP6qBQkh52oik2xr8dQy3FAikHEZg5wwUVB1rpJbUPbK+x3xdYEAshvhOxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYTcOcgq9VUksFOy3hbFLim/NJUHMKHd00WwWsKcOkzP5vxnN
	bf1b+WFVOBFDf2B/CW0qTrgRRKFQGKG2Fi7DfmEDQimiH1Rqehx+KFing2WnO816JqsCjO01KCc
	NWFBfxFdjvSbKekCxifPSn1y8gQh954pgwj14
X-Gm-Gg: ASbGncvxfcK1pD0Cz00rpMzSPLauRi9ZGGkIsk6pvfmWXNpljXdrmqZCNFdmA6w5n7h
	mftPlsE8NpnOkSSlGX3t/fbK93VHDPh3f2PGzBbdVTcr7+P1nl6c3lAdIoJR3swYk9VEMjlJHzJ
	zVPuPb+Q==
X-Google-Smtp-Source: AGHT+IGabaNdusDiH8OXo4sXZKFvUMlkLkQwD/q1euXqQNlegBQSbJr2Ira0Zl/Q38W6p7sXmb6ub1s279w0IoMFW+U=
X-Received: by 2002:a05:6402:4403:b0:5dc:7643:4f3d with SMTP id
 4fb4d7f45d1cf-5e0b70cd8e5mr11463044a12.1.1740388954732; Mon, 24 Feb 2025
 01:22:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224090047.50748-1-wanghai38@huawei.com>
In-Reply-To: <20250224090047.50748-1-wanghai38@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 10:22:23 +0100
X-Gm-Features: AWEUYZnlBN-tmPKVZhHFnrw1BdIQxdBl9zi2hsn6vjPY0kRDwROiM5wg5YEBs6I
Message-ID: <CANn89iLXxRKH_tQCggxn=yuNk=+QEZ+uJuxYozxO7TEpkJHB0w@mail.gmail.com>
Subject: Re: [PATCH v3 net] tcp: Defer ts_recent changes until req is owned
To: Wang Hai <wanghai38@huawei.com>
Cc: kerneljasonxing@gmail.com, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, zhangchangzhong@huawei.com, liujian56@huawei.com, 
	yuehaibing@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 10:03=E2=80=AFAM Wang Hai <wanghai38@huawei.com> wr=
ote:
>
> Recently a bug was discovered where the server had entered TCP_ESTABLISHE=
D
> state, but the upper layers were not notified.
>
> The same 5-tuple packet may be processed by different CPUSs, so two
> CPUs may receive different ack packets at the same time when the
> state is TCP_NEW_SYN_RECV.
>
> In that case, req->ts_recent in tcp_check_req may be changed concurrently=
,
> which will probably cause the newsk's ts_recent to be incorrectly large.
> So that tcp_validate_incoming will fail. At this point, newsk will not be
> able to enter the TCP_ESTABLISHED.
>
> cpu1                                    cpu2
> tcp_check_req
>                                         tcp_check_req
>  req->ts_recent =3D rcv_tsval =3D t1
>                                          req->ts_recent =3D rcv_tsval =3D=
 t2
>
>  syn_recv_sock
>   tcp_sk(child)->rx_opt.ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> tcp_child_process
>  tcp_rcv_state_process
>   tcp_validate_incoming
>    tcp_paws_check
>     if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win)
>         // t2 - t1 > paws_win, failed
>                                         tcp_v4_do_rcv
>                                          tcp_rcv_state_process
>                                          // TCP_ESTABLISHED
>
> The cpu2's skb or a newly received skb will call tcp_v4_do_rcv to get
> the newsk into the TCP_ESTABLISHED state, but at this point it is no
> longer possible to notify the upper layer application. A notification
> mechanism could be added here, but the fix is more complex, so the
> current fix is used.
>
> In tcp_check_req, req->ts_recent is used to assign a value to
> tcp_sk(child)->rx_opt.ts_recent, so removing the change in req->ts_recent
> and changing tcp_sk(child)->rx_opt.ts_recent directly after owning the
> req fixes this bug.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks for the fix !

