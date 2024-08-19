Return-Path: <netdev+bounces-119763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D22956E09
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2A51C20E77
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF7D174EDB;
	Mon, 19 Aug 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juWnYIVB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E216C68F
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079619; cv=none; b=FVPxrXo1FOnh+G3AJPWW3emVWVdEQODtjKXf/Sr3NwJ0gUDfy4vd4XA5M9Gj+rGFBU/gHyjjchWG71L+6AQeHd8O80xIgBN6E608tJx/koNdyCwJiw02v+Kpc9ILZKtZIbYnsiXdUKjY0D2y53UCb7HdM/NPhgLtAlqmOKy4o7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079619; c=relaxed/simple;
	bh=Ww3J8IFp/F1l6l/7oArA0tSsaSCrLyoW4y9vTlAxxSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyYvq7SGNS8g5GWXgR0A4JP0O48pGrmGp3jm/tXj7h5jsHs44qcx9Lsq+n3JZzu0EoSwvSP2cJitlOouGg7GbQY+p9bB4/FscFe3JzmJsP4oSp2VKHvXhJoRCBaIgxmf7IIRdJ4/82HJDvOC6T6lJJdWSrSbmSjJk+97JAYXXWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juWnYIVB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso539226166b.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724079616; x=1724684416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww3J8IFp/F1l6l/7oArA0tSsaSCrLyoW4y9vTlAxxSc=;
        b=juWnYIVB416DGKghTDLaIt9GO0tztsgEOiJ/M8LL+RhO2hUsoJWc96jKlhSRrF3jX4
         +2gJWrgbfzI93rr5r+War/+cpojwVVbnbFS2oU69NbUaDUQQNpsFdZnxqVZMoGOj+aG9
         HIDh4bNlAc0z3CAV7xfcRq4zMoCT3ngVkH0MuWbx1ZbM7LyPoRSEWhpatxSNGLQDdhpq
         d4Ac+cpbZOUXWPhrgCubZlENnKtN9m5texiNBIV3R/406WFjpylldjzKUgtfecnA8ArN
         pDBaKXarar4q4OJKqjGHSXEnViXswrMi8qou/Lk7QNFPflqRRoStnN8L9a4KR/pzKEp1
         GqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724079616; x=1724684416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ww3J8IFp/F1l6l/7oArA0tSsaSCrLyoW4y9vTlAxxSc=;
        b=WKQ+QVk/lsy2Y747O57c8qfSRyrFc8xArD0/qDLdUf3ldFK53FHiZznT2yVhqrHQuB
         t+wKYA3HyoEXcBk3237etNnmzw7y4d+lTgQrxpBWohB8jvJHOzVUdrLNb/8qPWoFnYXl
         MsPOFiwSgBHp/5p1euvuvW0bEkIyOgLGvHde0MJDb7uu00qggk4ri58aN0m/ELKqyLG/
         psqWIJkw3ZVD1WmoE6h5WIvCUFBC5HQU7J1V7/i++Jvq3GvkFUdpG+/M1rOhtw45/nLc
         LO9HZB7/Dn2EwjWcnlKHV9pwbaUYpsh1Wj8rr17mGmb2qskNGoqFFsVtCkEV/1KIi5df
         fkCQ==
X-Gm-Message-State: AOJu0YxPvlkbGBqhnGmws1VA4EmrO0W1ksm3vpn3EoC8hn2CO735B8vB
	/YPBYhJ7xEjTwJqM8wJTyQ7uU+ZUGFzSRu5gyXfoTjBwCFfRxnkHiJhablUIT9TRRzXjCKmzRjO
	XTHeiLTSwGSeUn9IwZweB0KHt7fRzhRpNNCVI
X-Google-Smtp-Source: AGHT+IG40uXPgAiOwqakY4m4m7e327cJj33TYg75Uak70iHDFHwb/1Aztr+2UcPqtsN7qBHhwgW0QqM2UqX0/zyEFpk=
X-Received: by 2002:a17:906:bc17:b0:a7a:d1ba:af30 with SMTP id
 a640c23a62f3a-a8392a491f6mr728709666b.57.1724079615781; Mon, 19 Aug 2024
 08:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819143333.3204957-1-jchapman@katalix.com>
In-Reply-To: <20240819143333.3204957-1-jchapman@katalix.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 17:00:03 +0200
Message-ID: <CANn89i+rxrBX7n6YkukO+2KfXDCudvETQ6fesLXR=yimZX19gg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] l2tp: use skb_queue_purge in l2tp_ip_destroy_sock
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 4:33=E2=80=AFPM James Chapman <jchapman@katalix.com=
> wrote:
>
> Recent commit ed8ebee6def7 ("l2tp: have l2tp_ip_destroy_sock use
> ip_flush_pending_frames") was incorrect in that l2tp_ip does not use
> socket cork and ip_flush_pending_frames is for sockets that do. Use
> __skb_queue_purge instead and remove the unnecessary lock.
>
> Also unexport ip_flush_pending_frames since it was originally exported
> in commit 4ff8863419cd ("ipv4: export ip_flush_pending_frames") for
> l2tp and is not used by other modules.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

