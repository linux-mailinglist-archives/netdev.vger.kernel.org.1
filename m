Return-Path: <netdev+bounces-64291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678A832174
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 23:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6FB283E74
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0733175C;
	Thu, 18 Jan 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eRfhscnN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755012E84B
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616079; cv=none; b=BTPgNOkFVGzzH3LZIddwH5344vKVY0SVqqmgpkRpYqWOuRDtUmyF2ci/YuaRu5cUIGjBekA2P9zDy3oZlz2s/iEkpXwpdPOAjRiGrkDxjScKFZTgwrbxbnjcfeEpa2emAVfwjKjlMNsn86OVEhu7rqYoNOexMy8Aq0+yCUcliOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616079; c=relaxed/simple;
	bh=r4D/KgXUbuRgy0qDViJsMuhNnjQ/FXP+A1V7tLwcPPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUQZsnn6ruHMOeUZJPZrO59icnt4O6SiH3gGV3PemVIYBe92e7/M63Drbv4wCwe7Gz1biKxbTDB0+c9m/wUDYqcL4IBRTmoeQQ//5cwgbirQHKLr1qusdzYqStWavaXVnB/x8yYn0ud2p9mawjyvE70ki+eiW+3QGgj2gIBO/oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eRfhscnN; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50edf4f4aa4so838e87.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 14:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705616075; x=1706220875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4D/KgXUbuRgy0qDViJsMuhNnjQ/FXP+A1V7tLwcPPc=;
        b=eRfhscnNUNIXZU/scq/MzJTOOQdlFks1hvZ7cAEeBb5nmXGdlcC3fc5rqqsEFTjvtl
         olhqP0dAqXj/uFChyZKiF/nBBpOZeRl1MKb1lxmzBRSuRYXGFfDAgp5YfHqAxgdrr0s3
         P603Z2DGh5qOZ0YSlMLOIKsEttUG+p4/0V6Rotpm6Y4wPHbrqvOzV65t9sOuo7D5xGK2
         VjCw224Ou3kHw8Ct/qPA/kfOfUlOu2shiJmZawxnJRlAwLN6pzdoRpl9VeJFHJP6ECti
         7F8s65Hpli8+gtgKvSpWkeWm9gR/6+FBhqsPoiVibEas87OKsREk9Ar5805vnyCqmmCq
         TCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705616075; x=1706220875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4D/KgXUbuRgy0qDViJsMuhNnjQ/FXP+A1V7tLwcPPc=;
        b=VupKQVTudQwBaSJz8B08vsHWMkKIOZa1SiAFBKb5m9MQYh+hGnREw+Bi9yJHLsngb5
         EOd0dTXdrF7qTiOFct9O5BGT6rk45G0TItTJjUJjSVfcdpzNah87pVHGDNRrH+3O40Ii
         FmY4ZedMYmTg1ChKn8CdhGs53CjT/WueYGqWcfB+mitI4svJqyQwkysitrUsFYDrG/mr
         cjiFWg9dbtKzatbB/nmFbv1U/5imymfymvCb5YIIi+/l039qJdc9gLYfx7Uy+7QF/Whi
         4Ly2hSEsW4Lyh4I6WoED3gRESrYP0UOubXD+TYJ2LBC2+tHIucljpySLwaKW3NZphmYD
         UkUA==
X-Gm-Message-State: AOJu0YwcxuERXE9eN/wJD9HD7jM7WnnhklZ8DdzYrdsYqIlAnwTyL12t
	kQTKgjI56897WkgEL9H0WdfRLCJZyn6F11sd3s5xmC1kr9Q9NTohxxz8rb4HATnoCBlZGoRRefs
	85AtAWyFLz5d/e7dONek/C023vhvQ9t7Hl+cP+I1AR6I6omiDwA==
X-Google-Smtp-Source: AGHT+IHUjJlZfRbqFOZkMRsgEsxAv84pvuIuOwlF2OEhCQ1GyAOoIsRXO4vpxhP0fCbSYPXcVwnXq7uE/eNeU5L4hss=
X-Received: by 2002:a19:e005:0:b0:50e:a70c:d0da with SMTP id
 x5-20020a19e005000000b0050ea70cd0damr31934lfg.0.1705616075064; Thu, 18 Jan
 2024 14:14:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118183625.4007013-1-edumazet@google.com> <20240118215854.40268-1-kuniyu@amazon.com>
In-Reply-To: <20240118215854.40268-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 23:14:21 +0100
Message-ID: <CANn89i+=WbG00Qo9mqk4GuJjv0T9fEkgoDUCOXKVue-=_LAEsQ@mail.gmail.com>
Subject: Re: [PATCH net] llc: make llc_ui_sendmsg() more robust against
 bonding changes
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+2a7024e9502df538e8ef@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 10:59=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>

> Probably we need not check SOCK_ZAPPED again after llc_ui_autobind() ?
>

Possibly, I was not sure if the socket could be disconnected or not.

This would be a nop, or a correct check if disconnect is implemented.

Do you see a problem with a strict validation ?

I am tired of syzbot reports about llc, I want to add every possible checks=
.

