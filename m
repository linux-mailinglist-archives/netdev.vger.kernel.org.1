Return-Path: <netdev+bounces-208515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2B3B0BEE0
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 10:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5492189D0FC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D122D781;
	Mon, 21 Jul 2025 08:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GMih/YP/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A171AD23
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086540; cv=none; b=NLCnbiNV67IARQD2ELdNal+pwCffUCe++Ixmh1KdPlsbq3t233sf4oHce5K40/L+EQiVvgVJ4fiJFf6ymTrm7X+ObG5ve70MXv0kmZFPBG9bfm50PttQxMsUXV5XU7iljgOeN4L0AJdU3HuUcsFDbST3VDNHV602XTg7qAVmZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086540; c=relaxed/simple;
	bh=sD5fupAFY3cWNYxzoEYi8Uvi8fOOKhtqoQ9ZJbpFsCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3vvJsQi03hiCTnxPJpykc9AVLPR3DWgPyXvGjrBmwj1LZY2uY9ZPkVhK6XXiygR8DaxFVkTrBP03COo76qOUjcqrHUPFhtICx5Hh32sEApEcKHjagn6e9IKMTTItljlTopzlbscDayRLi2tA02ceA4k6C32lrkYjZ1FeYAKr24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GMih/YP/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e2c920058fso484607285a.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753086538; x=1753691338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD5fupAFY3cWNYxzoEYi8Uvi8fOOKhtqoQ9ZJbpFsCA=;
        b=GMih/YP/h48qhsG/Dwa9QAJWtYvFVvF1OLy4htt62/dEcyqLA2rtZTtx74JaUEh3B1
         CcRegjg/DM85hrqusJdsArsJChyhC39Kir3b2gQUesoT+DxNd31QO8IuZGGg1oz/gBCL
         4eoaKpukGGOon6fvafeov8WkKRS4PF3EmqpguEm09v2GFmIrv88HgWQv/1c6Qk/wdcoM
         JYyBLwLEkAgsfjeZ5yMaWw1YUiUCkH/S4/jwMcw1Pe1nHOjfj9zWaj5tmu05u8xQZwnL
         g2qIvhVKY9MIYmWoMxA4RbJLo5KLN93M/k7QDcgiiLDPVJoKfIoM88SHHia38N1AmPe3
         OJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086538; x=1753691338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sD5fupAFY3cWNYxzoEYi8Uvi8fOOKhtqoQ9ZJbpFsCA=;
        b=RFsJc8IyRmhiOqMc2AhNZl4sNiTU/sE1A0368f3NjGUG8w9EOLxCaKZwsSbZ6rnBpS
         D0sxmbX8SvEsyOgkMmXL+nau2OTTPAWl1VzESw8eog/hn0Vz0R4N45lQhPaLPO0lxH1s
         ufiIbSZW9BPHpTAk43mx9oDF9M38PHqKpLyTQI2wYF5vvjOR0ewf+r18jGc4aacEfZE+
         YrVJ6T46MLocUU1QqZ4rpxZdiFNrpNa5ejcER0xH7ttSOyFZk4wcFGGp0ba3DiJQRNfo
         ENZjzSk2OvQEUHtzi5lfTbAvBKkUqd/DnS4kqBRohn3ZE5i/taa+5+/v9hryPVFagKRp
         R4mA==
X-Gm-Message-State: AOJu0Yz1TqpJDamiD1MG6nHssvAYoR5QGWUznlui8A2fSGcQW5CeN+EA
	O+l+Ua8sDORK5iHOaOLohyTvtx8dqEKqhd/jwxqkjImp77En9mUXiMJtaVZbhYLIji+BLyI9/6J
	aoh4IcLHimfOHs5XVTTJVTFQ8Bxmqjt+YCqjkC/7m
X-Gm-Gg: ASbGncs0Dyhph62IDN4H/UymCDnYOvFnsWa40NHfDEMCPtPVmxTHBaBWVJqkANgpyNU
	u3ZFx691KQPbY44lT9Hocn6YCtmCyJoi0ohxwvMvxac569TOYYDAK/d3tUV4rHn04a7jTGss60p
	CpQWWnaoPcg3Of1QkGwT1Ogval4K8AgARztpAwwVgLVe2Fl71J+dSgcCcv9WUl/MJ5tir6ReFFy
	zeXzfQ=
X-Google-Smtp-Source: AGHT+IHPBXqyOyEunWi/gCkMWhRCan2B/dX4snUGm7/dLBaCL9B3H9UEHzRSXqUVU9OIL2dqkE5NH4mzDzkajPB/P0Q=
X-Received: by 2002:a05:622a:c:b0:4ab:95a7:5f4 with SMTP id
 d75a77b69052e-4aba269c6d3mr241483581cf.27.1753086537813; Mon, 21 Jul 2025
 01:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752859383.git.pabeni@redhat.com> <33f764b857dd28273784da12a3bac8dac039fbcb.1752859383.git.pabeni@redhat.com>
In-Reply-To: <33f764b857dd28273784da12a3bac8dac039fbcb.1752859383.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 01:28:47 -0700
X-Gm-Features: Ac12FXx3BduS17pB4TpaqdBF43K6G9Zs9rAmnG8X_eS_VGQ3OqYpAmdf-kZV1bg
Message-ID: <CANn89iJe8P4Ra--EArxeiS6hGdB4dKzprTP-VZhrKfQcmng3Xw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: do not increment BeyondWindow MIB for
 old seq
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Matthieu Baerts <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 10:25=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> The mentioned MIB is currently incremented even when a packet
> with an old sequence number (i.e. a zero window probe) is received,
> which is IMHO misleading.
>
> Explicitly restrict such MIB increment at the relevant events.
>
> Fixes: 6c758062c64d ("tcp: add LINUX_MIB_BEYOND_WINDOW")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

