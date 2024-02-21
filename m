Return-Path: <netdev+bounces-73597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8885D516
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E10C283CFB
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590B3D3B7;
	Wed, 21 Feb 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z70iaKrK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D63D0C9
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509585; cv=none; b=dpcJELaPVQsRqiEQ2YVMLvHKdPQ8JJ6YfQEQguapCPv7LTUvfIsKmF5S2x0Df2cNaSJHdyzqXwB5tIR9Bb5ZxPeVJDaACHKCXpCSkJrrvoTAQAEDE4D5Kq2FHOp8nh2IcrUZtGIbB1aABbh27uY1HjOfUHtsS0RR2+22eB2jYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509585; c=relaxed/simple;
	bh=Gagd+obQqqrBi0zMMmmxt7zCRzBmDirOqA2ya5GjEc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHpfWdZubeMZU6u+77N3j6/5Z6K1WO5fFMJIfhW4UDtdF9aDZD5vcBYuHwsBcNLEWEcXsSfH08jOjEoOYY9731Bc5gkKvNNpLoHdZpfTpGyG7I9Di3aaaKIw3Cy/xRNynR92grExlbpDpTQNKn2yjkmpwwj5S2eBdG0Htvy98LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z70iaKrK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564f176a4d5so9480a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 01:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708509581; x=1709114381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gagd+obQqqrBi0zMMmmxt7zCRzBmDirOqA2ya5GjEc0=;
        b=z70iaKrKOy7YdBdYpPVxt4QiQuTHyPl1YsmaWPQ2IiNEkm0FC59uYMmzLmIMgrB7uf
         F2nutJZjZ655lWOROts7FmYbLnnY7XDc4Qq6IXGx32+umS0Zfk1wmXDLiE3m2rPk0DIJ
         XvNNJ5sR6T17cBBG2h2b1kHy0ZQQf49i/pQVmWM9l/IRWGQ293mHWqBKxRyeI9XYjsLb
         p12UT63iVhtAdLCKV0q6AfQuXs032eRT5J/MPxeFPqQkUCcaf/S5QlmQy+TbBAXzBQVb
         OKz0DDyJWBuQKvrOvrpsQFAWCdzBeqxaMwvDip6hdh8qt95Fj0rVOGEj39UUhcj20x4W
         F5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708509581; x=1709114381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gagd+obQqqrBi0zMMmmxt7zCRzBmDirOqA2ya5GjEc0=;
        b=KgeQx5jhwhyU+2xcfFjZOriONfKVZzpUVohbTrGzVF9EisxRPfsCUsqvXSkoWvKD6f
         6j6fPhooXpWDO7Gqmp4H7ZeNaatbG8ac7v02rFJjShOBRJXjdYwlF8fCeef5c3vNQXB5
         GLVbko8PZHbyL6YXJV/L0D26/wsENMbV35W9XwdnT2Fi3CG0Fq3vAMETEo0n5jeePxqs
         gbI4r+79QEmayJLPeu8vTjdzHh//vYeHJ3X/DUp5K7JHOKUdmfL5//iVopiFLXfideqN
         N48t+ZgwrY97DVeJ/bpfxvrfi/vOJ7fj+4I6jI/XCHfASMO7NgQZJrPAGov8M+6zgHDu
         deGA==
X-Forwarded-Encrypted: i=1; AJvYcCUtOaWt0CyZdwVbVba54UGwECPov0FS3JSeqCRLGjtMPswmvdj71HYyYyRQt4+oqBfbvpLUOlc5szGYFr4Z1MVJb7h/+UAz
X-Gm-Message-State: AOJu0YxDN+Ja0UmiyyCXbOfCzX7+k/vKvH/5hOpbdgn/lve1A2pacXiL
	cex+c5Fwg43ZPT0dama0Hw5P9AlOkg4NqGnyg4kRhEYHaJ92n2HQVO+zC52HNKXH1UCWUiN63vD
	vgyLE6NMM+sQrbc8beTmbfCafbFlZxIQEIx7q
X-Google-Smtp-Source: AGHT+IGrK8KspqYBPrpzHq/6ViJPrMbHNz4Z/cIGK7SD3ay4sn/oJNj1HjJHL8tRvg0uQULHXJvdr15QgFbE0VNG7zc=
X-Received: by 2002:a50:bb29:0:b0:55f:8851:d03b with SMTP id
 y38-20020a50bb29000000b0055f8851d03bmr89235ede.5.1708509581453; Wed, 21 Feb
 2024 01:59:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221025732.68157-1-kerneljasonxing@gmail.com> <20240221025732.68157-8-kerneljasonxing@gmail.com>
In-Reply-To: <20240221025732.68157-8-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Feb 2024 10:59:27 +0100
Message-ID: <CANn89i+EF77F5ZJbbkiDQgwgAqSKWtD3djUF807zQ=AswGvosQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 07/11] tcp: add more specific possible drop
 reasons in tcp_rcv_synsent_state_process()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 3:58=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> This patch does two things:
> 1) add two more new reasons
> 2) only change the return value(1) to various drop reason values
> for the future use
>
> For now, we still cannot trace those two reasons. We'll implement the ful=
l
> function in the subsequent patch in this series.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

