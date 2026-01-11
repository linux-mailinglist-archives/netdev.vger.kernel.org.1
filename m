Return-Path: <netdev+bounces-248846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F058D0F9FF
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 20:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8E43033710
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B61350D49;
	Sun, 11 Jan 2026 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3nGd6dM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB852749CF
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159015; cv=pass; b=Crg/vQ8NH9iKG+TOQJsPnLAxWo8XdnCId358c5TiUpwW3NnkheCmGaTUAYMXDyKDH5NQZd1jKOYVGDqNrm5f/NU43v/GH9STD4Dh7Amds/+CgaGbs9VbUotjsHannIndScd4bjBQllXNgVmZEskvQC/+/VA2ArdwvU+lz3UsMaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159015; c=relaxed/simple;
	bh=GK10uFFBfJnUN7pJIA3veOdTRXwgC+DVFIf9jpvuer8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEX0H1en/UoAGGEpXDqZlZoPn7mGYJB93iauIzPlj4mjDFX0XkOM8O1IvL3CAlBBiOxSwXdw4CCkjZWPkskd068zZzUey4yZuzXrg/kAWtHqHWapXSP2WB5kRwhJB7aNdfssHYvb94x1kXtoI9ueG5cgvbBENOswwNWYBo53EWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3nGd6dM; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b30269328so4759e87.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 11:16:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768159011; cv=none;
        d=google.com; s=arc-20240605;
        b=eaHIUQsOGYB4X6Sk4x7/CrMuc7JfXdfWuzpJuV1JRl9Zy3MqORSLSCHwEnb14n2a1c
         xI7bn36SRSWzPqAkjUG5RAvrJ55JOWhPaonxDDsUJCFEWl1b5SdGwl8KOFgSMdm3NzSE
         EnSW/XiUVxWT7YgXWFUG+EOrVUtjcQQvHh+A4jitpmi3NnQnm0bH/7rkWfpFAH8IHPaI
         zJqkyhvxUco61V3tlXh6CQbbt1qvBNyk3NvXzrOFrjD/3Ae4eXc2nmPaCuQV19VUtOvJ
         3RGFCQsa8SUx5Sugau/UXrNVgWicV9hg6o//ycrZdvLF3aeepVmc3HmdSQ/kv+S+3tga
         O+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        fh=NiCaBCXlKddRqGjSsvAL2HXbpjyt2NQ+KckQwrpdZiU=;
        b=ORuMqLj6AvkIjgRFzULK2PaXo7bfDyF6MIfyV2aqXjr0xyeq4CwK/kaN1ak51gtMJQ
         KKzjaRyZhNeqtgTkrsVLm++5rMs96T+AtKsrFCsBIbJ1KSY193HxI3qGImH967Z8QRz9
         4q/m4Br78re0ILkA0rVHGVZu9YRwUdu0NKc+ZNYHswUpO042BghmQO/qeGF+rEnZd4cI
         8TWkNz8eXku3PIHBPf5smysTDSmJPlTRpx9ib29MXZ7/YUOAJzNYqzlCwK9WKMHl7AlQ
         AnXaIgEQYJApBt6QR2Zv0jTgmHG+alB53IG/d58v7D/yyEX94buUouYWj9LAIoklgBdw
         gU7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768159011; x=1768763811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        b=s3nGd6dMyfhoMdv06lXdfkER/JtrT4HoSJ3vBu4za87ymCF/PBLC5nvDIxAuN6vsVi
         zKQpw38gzADgTLZm1Hfp3800313WuCaiBz/opRLKThuXvyl1duLUOnfbN+aYVRvWEknR
         ETxVCM0Sr5bJnX0r293bgI2EEK669HhP9l+g8D3KvulVWa3/Xm6JEcvmGemId3A6bKBW
         356/bxF6No6IkFZKkcsySU++qElgUj50YuSPYHcGcaEiOv4IhJgtznkk/7LiPUmB1wLg
         QBRFi/hOeRKW9RocG2pnUZIsR5IlMf0v/okY5q3UHifrBjDGUcrYcqyiMoxaQVTRHtEQ
         WL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768159011; x=1768763811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        b=cFl078uUnj4ya30h5+fTS2VfgnVtY1m3VR6SNdFzP/g+D0lhaX3DFPSyNlTvZAibex
         4vaG2uQbSv68NsAyOeRqSeF3kenjLNhvzYxNoyPXu368cGZePtz72yRlym+ukqWqxyio
         8jFedUrqdByQDxu+uzp0JpxpAaLM7MK69iZsZGhhyixEKdN+iqmuOLCn1briAG+gF+JK
         PL3P1lJzg9c4pprNl+/kZhDiP6g8jRGt1hRqX2ZRjLODvCYctxI+QEAMnIyI+BLy/Z5G
         TTUA+4ZkpEUSF7CYKnFEGyeu6AnpQGhldJzzR2T1I2RZ1zFPgENV13cVsqydUW3lGUL1
         nePQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8MNN+GeMe27kTwm+Oomq0h60BBGtL28JqHJrZBGImoo7iFY1fXbj1CA2Q+HjuG1tpvVvRNBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdcCtRHIL1WXiBynWUZO/4ukOFqGqcMkBDekHmMeJwxZ3nOmi
	i3WCm3rVleTAjsB61aDUghUc9vgZDwudqLT/lQt0lN4D29xLxFTOiH3jX5C6XQyRFuFMmabLnJ3
	SGh04oahLJ003fCKMPjZuQ4+7PBX6V70PRlcyPkBL
X-Gm-Gg: AY/fxX7iNlaH57LRjyqRGBkPXJPrUYWXn4JzRAtyg0SbTrmC5IALtErWUwiHS8Nab1a
	ZeRq0wL7Ze7FTP+RHXbeD4EWePbqoi973c9AuUobwcV7sdY00EpK9lj8hKpfapTKYhJtrZTyCJc
	OdwkSAsJVHU2KTCUYrxOlQAyZrafjKQrt6MOifu7+07LYe77WSs6N9o95ITFLmTHLBaC6fe5yd0
	qHF7wLAOKGUESZCKF4reZkUUNUm1k5qZc3DInAL729yBh3LJce19gDnKokIC0lDx3XzYYw=
X-Received: by 2002:a05:6512:1288:b0:597:d606:5b38 with SMTP id
 2adb3069b0e04-59b85911648mr136353e87.6.1768159010781; Sun, 11 Jan 2026
 11:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:16:37 -0800
X-Gm-Features: AZwV_Qir-cv-IZVpPXwaBdmvkArrdmGky4-Qr_YMN1JPM7e8jq7epyBCPXxohO0
Message-ID: <CAHS8izMy_CPHRhzwGMV57hgNnp70Niwvru2WMENPmEJaRfRq5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/5] selftests: drv-net: devmem: add
 autorelease test
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Add test case for autorelease.
>
> The test case is the same as the RX test, but enables autorelease.  The
> original RX test is changed to use the -a 0 flag to disable autorelease.
>
> TAP version 13
> 1..4
> ok 1 devmem.check_rx
> ok 2 devmem.check_rx_autorelease
> ok 3 devmem.check_tx
> ok 4 devmem.check_tx_chunks
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Can you add a test for the problematic/weird scenario I comment on patch 3?

1. User does bind (autorelease on or off)
2. Data is received.
3. User does unbind.
4. User calls recevmsg()
5. User calls dontneed on the frags obtained in 4.

This should work with autorelease=3Don or off, or at least emit a clean
error message (kernel must not splat).

I realize a made a suggestion in patch 3 that may make this hard to
test (i.e. put the kernel in autorelease on/off mode for the boot
session on the first unbind). If we can add a test while making that
simplification great, if not, lets not make the simplification I
guess.

