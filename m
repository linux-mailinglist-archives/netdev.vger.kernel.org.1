Return-Path: <netdev+bounces-141016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317299B91A6
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A9A1C220EA
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F6E19F485;
	Fri,  1 Nov 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlZ9wyTy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6405F15F40B
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466870; cv=none; b=chipEDh7PgmufnMli9GXCqRkIZEI4AAXnqcNK1DETOZHVLduNDmjfl85ZpC7saPtrBU1KcfqDmD72gtWk5Ode1tkCdDQllf2Qsl4SIzbvWtemwt1UqOsrYZqkQD0k5/On79fatlgRIVjeYgpkzOufBErLfP7I3kalV1Py87CIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466870; c=relaxed/simple;
	bh=6aAmFsJss1QRu8uaL79qqcvFWlGka3N/28+aWyODFkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iRqPTmVVGRyp2PbavpvPt+5VwbZdAz14N+XaAHVokh3wUjzGu4q8EHQv//E1CupTH/84GtSeptxbPurAzxj4XEZtwWv+JeCYaHvYz4QR4da02/hPXJsFdWXJymZgY3y6AyTjrZtCaA2ma3F+baPmsYVRV8yo5uqdupDEmFIdMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlZ9wyTy; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so293485ab.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730466866; x=1731071666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWlXIahODzpoNdr0NLzeKSp3oyNmpJuqBRxB/KAVeiw=;
        b=mlZ9wyTyoHQPVwpDfsBP3O56lnVDYrr3wKodSOtNYp2fs4X21iRRssET5xOsUcYybV
         jman7LeX4aGQqdgZZjuF3qEZBXqBRu+76J5w6GZcZyn3NldjfTgwIi90Vgn978AgiBfd
         vYB0jYR5arbGmRRKk2PJJ+6ILWr5UugPjRwrx1DsTbuwjd4ZrgpjRMiusEqPot4Esi4N
         qizfMsUeq8kdzQB6gwW3aVSTnZ3njHfnq560JsDTKvNruRmfI+8cxr03THKNKdoCjF32
         VYufzQwIT1dB3Oh6sDAinR6mKX3JytM5DPrVd7GBLz3C8ZXuDS1PXTa/wAkLlwFEYT/W
         5Mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466866; x=1731071666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWlXIahODzpoNdr0NLzeKSp3oyNmpJuqBRxB/KAVeiw=;
        b=D43e49KzF5gNZDw/1wiTWFflz0zveRJQ72r6SsaA6hKKejtJa64qpWXdXsPgoNDwsw
         Gz6vOhSO5iPxVdHSEIcThT5FAceWhPAW/Yl1qyW3GFD1vKY6xzuRmOZ8RGcspmRGyJvY
         cFMIREwFaPc7UsKbj5kZBnLl0dMtiZuwU9VRHWF1v6G645Pls2nyW/X+QV8qk3YHBL11
         1UiqM0hxCyxj79RQBRpcbE/M8xgfTlsRnmUoX6acLReP/jf0yWtj/rV6/hu+oIPWT9/j
         fGuyVEsP15POsp2ngoBnJqyiD/rQKn6y4p/SgH4Op7j7NNC3NLtZgrzXO9TsvMceMfKX
         ki4A==
X-Gm-Message-State: AOJu0YymevnAjYwuA1zcAL60UiQJgER4ve+unZUtRpsvpoVAnbGt9M35
	bp7e/p/E+XoGMrbqECt2mcX72yUzLtoWEftPwknd4syrFI/38iJ2QQ1birJIPcuIlrTxMEDYqbj
	sNIQ3c6XvAHtnrcPDuWZmzYZIDsGrhaC2sMRy
X-Gm-Gg: ASbGncuVJi8WIgZ3Q+yR5KLolUcSBxHrN1335LB1kZLz765H6sCMx3FxVQ7K9z3A5gp
	nyi1EMZFfTRhJaNrtkq31C/J2NhfP5UI=
X-Google-Smtp-Source: AGHT+IG9zSpv682re0C/0/lu+w1kkJ6uERs+tlXRbzXuyVLvZia/fQo8HxQNYuQYLETlY2WFrk/vuONmvkFszIhPjCI=
X-Received: by 2002:a05:6e02:3f0f:b0:39d:2555:aa2e with SMTP id
 e9e14a558f8ab-3a6a94371dfmr7307805ab.13.1730466866197; Fri, 01 Nov 2024
 06:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029205524.1306364-1-almasrymina@google.com> <20241031194101.301f1f72@kernel.org>
In-Reply-To: <20241031194101.301f1f72@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 06:14:14 -0700
Message-ID: <CAHS8izO-UhDfctAsjpdipRV=WyCvUAu9VnAes0mBe2wSvV3_9g@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/7] devmem TCP fixes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 29 Oct 2024 20:55:20 +0000 Mina Almasry wrote:
> > A few unrelated devmem TCP fixes bundled in a series for some
> > convenience (if that's ok).
>
> These two should go to net I presume? It's missing input validation.
>
> Either way you gotta repost either as two properly separate series,
> or combine them as one, cause right now they are neither and patchwork
> doesn't recognize they are related.
>

Yeah my apologies. I made a mistake posting the series and posted the
cover letter twice. Looks like that confused patchwork very much.

I'll also repost targeting net since these are fixes to existing code.

But what is the 'missing input validation'? Do you mean the input
validation for the SO_DEVMEM_DONTNEED API? That should be handled in
the patch  "net: fix SO_DEVMEM_DONTNEED looping too long" in this
series, unless I missed something.

--
Thanks,
Mina

