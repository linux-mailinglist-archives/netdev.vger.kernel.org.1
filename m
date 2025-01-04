Return-Path: <netdev+bounces-155141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE4A01371
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE03163B7E
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A815B12A;
	Sat,  4 Jan 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y83UoNus"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872B14A0A4
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735981016; cv=none; b=beapN3nlHbz95vSP6cd9kg7LXglwqxTILHcnmzSwmRz0DXkkIu+JOjHlaW/V49lLYsPWXHuHuyW6BBw4hLBeh+bf1atORMAQNVRIvyGd2d+IpUSpkPzq2gx3gXNOgzo0vbr3DWF6uhWqItXqS3wFLcPu3NxR2+C5oDUuJfAlDjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735981016; c=relaxed/simple;
	bh=hQMHPzDN0yoZtoXNjeZZHBzttxE2Ia2uEc1Zknxka3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEQ9YxugvjXHPsPkm3TzNQozw1oBkrPD7UDAlJ/g6A6o/RyMRRwpacEPduUg11YGup0mHejcCWN/FbFINWCdL/+zSUv8yn99Z3h6lgfx/0bLs0A1aedVW9N0dvTAFXEqzaXijmsGxFSN4r1ATgewGtUVGezkmU02kh1YxR9fmhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y83UoNus; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so24502961a12.1
        for <netdev@vger.kernel.org>; Sat, 04 Jan 2025 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735981013; x=1736585813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQMHPzDN0yoZtoXNjeZZHBzttxE2Ia2uEc1Zknxka3E=;
        b=Y83UoNusExUTW4fyN3GDPxi3Ulmu72NjJlcz6l7CxVdli97WjEx39/cQAt6TnAq3cH
         GAXmBqckvWXdRBm63yZ8vO29WGF9ehSfGVFyCy63vc2//lIaDn6ooEaI5WJZk6oQ9025
         QuiRun1hkmx1K8UGEsS5n23WuIk3RNML5x3NgywO26jq+amrxIOARJzYaTgNO6G5W0xs
         k8uNDcG39vBex7fZhoEEzsLOZ1qAQgQ//bDYTLLVBRmhT//r6Xemlv1HwD9cF5TyH5WQ
         6JNtwGCIAoVgCKvCvHrKuNjeXyOvEiZyJHL0brdZK2LKnkGf2VtyvSCeoQ1DSxnqDT76
         tEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735981013; x=1736585813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQMHPzDN0yoZtoXNjeZZHBzttxE2Ia2uEc1Zknxka3E=;
        b=tRKMeiOClCFJfSOksgRxY/o0ePx+1E2tF+QikXudfhuwZcrQ1aDt6k3LOlDP2iOXKg
         3DH9fFEC6yYJ21g9XkC3NppldREi4suLpmT9AfDqL4lWrFnYG4MP/tXDyUryLZtCk130
         3TEPXr2YQnjdocvuEhH2cRB4YgLtcEhT84nRk8i0DlFlP8tbilfiFPoK75+UZaBRArFP
         vq20AnF46ynFb8xJuEdR/FC6sWiqFpLDGQp9t5+RboRWQqkgHmpQF6nDBhMVyXW3yhNz
         qkxNm804KyjGjmnpKqLzUprnGOgIcq0FrrhTFnIvIPefMHSA/KLe7dxm+1KfcQBQ6sG6
         vp0g==
X-Forwarded-Encrypted: i=1; AJvYcCWw5VFCnFrxCSp2a7Pn2s+rvmFD+SElwZNqkePBrEC/o4BE7nQTXphZzF7RruTLsKxG+uqBJUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxV/ibM15ehn0hoqifFUbl6/+D8va9Byn3hLA//rsGrLzoohrS
	9f9NaSFERTRlqqndqGM8gSTd51SNJOVuyALfJYSajk8OH5rg2Z61VnvNf1pliO+W2Tq36/qKtTy
	9u5U4MN9eo5F1Nrugo328SvbHeyFJ3P4dNVCU
X-Gm-Gg: ASbGncvxFGNT6nh0SEDTJKV6fjLO8rC+/VcoYGZquDmJqQ1xl2i7jPzFQs9wA23MtkS
	vRCA6ya3W9MeqEWOiZqfraJq/IRO9cfyxqDjw0WU=
X-Google-Smtp-Source: AGHT+IGKfC7xcIH95JYHVnYeVXfkViHWxIbpO8wES3+NmM059AGnIrzx67MmLJFJJns12Ayp7Vrwo6nbK561P1caI8Y=
X-Received: by 2002:a05:6402:51d4:b0:5d0:b61a:89c9 with SMTP id
 4fb4d7f45d1cf-5d81e71a1c3mr49129278a12.5.1735981012902; Sat, 04 Jan 2025
 00:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250104082149.48493-1-kuniyu@amazon.com> <20250104082149.48493-3-kuniyu@amazon.com>
In-Reply-To: <20250104082149.48493-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 4 Jan 2025 09:56:41 +0100
Message-ID: <CANn89i+ua-8MWK_W2KtaBLk5tCAcqB7gy42nAP3te+am=xFjEw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/2] dev: Hold per-netns RTNL in (un)?register_netdev().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 9:23=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> Let's hold per-netns RTNL of dev_net(dev) in register_netdev()
> and unregister_netdev().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

