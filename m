Return-Path: <netdev+bounces-236843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 619C7C40A0B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 16:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDD31A4500B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0732B993;
	Fri,  7 Nov 2025 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUjwOTCD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF632D7F7
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529862; cv=none; b=NS5+5awfj8tnBXhXKq0pduYlwToqYfYfHEndBHGtlsgpKGkkq3O92rYbCvZRkEKGOPQnvStQeHplCtrMNK1u0orvC2tqGBUJ+zbv/nGqmeOcK8+wEFe+6NSa2q1UqtInXpewykFLhgfzAJKAslCXKU3ow5sana8IpB+qhAn4828=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529862; c=relaxed/simple;
	bh=PcTNp6i17O0e+BLHYjsVXsCRYYYllDagEWviEpSI6Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo42bd8cP6H8L9oK3gg0gVa+DHj3FhB558cjMwcXpuPL/upCSsHT9fr6461bSlIJM4jK7yrrJec7dutgJ7Ff7QDg/le7MMut5z0jhHz0WsbASMa8y7ug2dKQsO/2I1INS9en68rE9VrlX5PUeNCimNP7922BDaGepnmuPlKBhwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUjwOTCD; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-948614ceac0so57508339f.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 07:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529860; x=1763134660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcTNp6i17O0e+BLHYjsVXsCRYYYllDagEWviEpSI6Tg=;
        b=mUjwOTCDzOO2yYEhwD8qxIkbCjZMjTPbSXqR/wVTRQ2nQvpdKbBlWpACcYOka1K39e
         xwL4vF07eXyltIS1qJw5e3m3P9JHclM+A2ENH0JWKDOwYPEmM1FOe7D/973FGZYkoLhK
         I31OC6aZ+5rX/JyQZiXmZ45GlClp3VgPZ4QL9JfHQXfpOtlZMBknStMDjUXWDWRDTJtZ
         Y5rZweIGqws7nRsTYVrpACHYYNafa0h2Taq7xPo0z05h1lhxDjjKK7T4ALcE81UpA294
         OCjdwF2SowJnvElPIAsTTxkGNEmWjEWaHczr+tnL/ajYi1uffDsRHxhL90Jg2xCau94k
         GAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529860; x=1763134660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PcTNp6i17O0e+BLHYjsVXsCRYYYllDagEWviEpSI6Tg=;
        b=Md97go2uXPEujFvMOIOjXfkrybUa5LzzHltV9roqkJQUK5lpwyQrUuIqReyYvzlMf6
         SlHLAUrXv+3ZRZUtiyPXTDPudhoYig5kJ40afTHYeco8KhRqIJ+R4PfBGJ0CDhpA+l0g
         4EyNTa+hFPqxijqal9ta7jrmUEyRsQmBCczjaOQN4iko4iGa1BUuZrv6fx8wS0pCLB69
         HlJaYnPteO3+cUn5Kf6xPx2TRYIR5Ai6jxOZgOSj+y3dLAt9wnmTu+HHfCb0VBpcLV08
         Gk6qLtIDDEXy0eFzcIVD4+iAReaezRIJ7sfAb+brdDJXJJDI2Nuv33dIa8H5P2vqgSNO
         Ii7A==
X-Forwarded-Encrypted: i=1; AJvYcCWT9syGqWeqBqsU05ynShT1hXmeerFHINmk1NF2jMMheoHXNgTTRr6HQXSMI+saBR/YnMdjWR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJaveSeX0PquGrNyR7M3zLRWvIKNzhsAvPiIuD3i+8LFMdDXD
	Oy/dQvxkIZ4dg1u2wzdhEkx1mVzwCnDSlf6p5Xai/hCNHHP/xVQjNsIThZN7uFd0mDO6hx/sgy8
	fwuxhSUk4CZWk1kwJua7euwoJ1bGLaYA=
X-Gm-Gg: ASbGncsFFbhimU8hDXugEiAFHsSdJ64YrS+C+iSrCB0CBN17m7M+OwvXpGZ/nX2hw3i
	CFLw51ZMkj1bayxbE/ea7oadAg1GsKfVMgg61D3uJrijdYeBq9P7crEK0llNF3ogw/LE29mwVxx
	YomANbDE1GP5+PbfBe71sIuzfTx60K7FcLIv5CPC802BaNFGk2/MSYhIJFWmw3HYE4y35POHBcB
	VFPeTht3tH8Mo7ehMT1BK1BrRRME0JL7njoRAh5sv0vJKkOb4xnanQL1K3kRljJ
X-Google-Smtp-Source: AGHT+IHimwf6Y5QF0sEpiCsBaAvWY3LxV+5d6j8uyAuBqbth/ogckKBGyuJsUJSnpaoB/l2L2VP4SQhtKBDMnefk2eQ=
X-Received: by 2002:a05:6e02:3704:b0:433:4fc9:7b28 with SMTP id
 e9e14a558f8ab-4335f46f7c3mr48036935ab.28.1762529860086; Fri, 07 Nov 2025
 07:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106202935.1776179-1-edumazet@google.com> <20251106202935.1776179-4-edumazet@google.com>
In-Reply-To: <20251106202935.1776179-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Nov 2025 23:37:04 +0800
X-Gm-Features: AWmQ_blkK19nMa7HpFy9lL2LpTPugUD0NAN-zyXno2LX6bCptl63L6jLF65DTg8
Message-ID: <CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: increase skb_defer_max default to 128
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> skb_defer_max value is very conservative, and can be increased
> to avoid too many calls to kick_defer_list_purge().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I was thinking if we ought to enlarge NAPI_SKB_CACHE_SIZE() to 128 as
well since the freeing skb happens in the softirq context, which I
came up with when I was doing the optimization for af_xdp. That is
also used to defer freeing skb to obtain some improvement in
performance. I'd like to know your opinion on this, thanks in advance!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

