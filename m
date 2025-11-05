Return-Path: <netdev+bounces-236065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0FEC382B4
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A04E6E98
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B17F2E62A2;
	Wed,  5 Nov 2025 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg26vQ7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D02EBDDE
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381204; cv=none; b=gPmxgQL7JzVKMa8Q/YOj4jquZ7v9EzLcjcbm5MsxgdlKpGH8KV6TgkLa2EOjXJklqUCBNIFj08nnjX0DXp1lOpR0DQu4/02ydaMB1YsxVTAReNuvsrqWvoiNLqnqm5vVKVNNgGuRrsIY6ACTimTK50rG/7z1nUzMhPwS2M0sKvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381204; c=relaxed/simple;
	bh=EYKxP/O/E3xqBmODbiboV3aBEJpx7ZMxu1D3mOtTn3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnO3nUr/l5RCgYPxPUqw76qT6vFAnetRLLjckijvVPVaZr3sTvGVgnqEqstGCjd2x26l7uRoEIkD3MUj/7+hnoUTHIX+OmUQp+rgiHdBn0k8bzo+WBx6zZsmhgY3JajQT6vkLBDohC8/F+fM2cMAI4nCkYOA5QDkPChRamZ5p8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg26vQ7F; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ba507fe592dso171566a12.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 14:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762381201; x=1762986001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ui2U0Ij5vkKFB7H5IIU3rlE4C90Li/F+qZfil4Xomfo=;
        b=Kg26vQ7Fw8IrfAVf/vxnizhVNu3GwZ9LPJPCBtPPlaOr3DR5yTVp/uxlLX/VY5qdkd
         +dJ4GPNTw4TRQm2NqdPS72mnPPUI3dmqrguNSDdbojGovgfyuo6bqaM6hvqkSEURAs1g
         JH79JAMFkcRK4uA3uatwOr46o2eoZMaylGA//0wl0nJiJ7LbBc/92OGjNEuwBEiOL9/4
         KoSHB5oTRZ3L0/RxiZrL6XQUR1piFw1TcTGOJVqMd2lKO+POhVriLc84tMRqM/I0BGUo
         rmXjLCvFVXT1rpjt6UhDRnWkMOwEELE3OmGq26oNyarLGUqxzF2OdU1p/Eu84kY32SY1
         q6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762381201; x=1762986001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui2U0Ij5vkKFB7H5IIU3rlE4C90Li/F+qZfil4Xomfo=;
        b=nMaT1atJ2Eo12RvDLsG5G8XrO5lofFt3n76+5IfgMSAxleo/kZGaawBPxttIZUhyBH
         mFvUs5f9K5rHF+tehsBu6z4pVnKaKFCDY43+LqrqnFxrQ+NGBKbp+trl6SPnNvz0Li+C
         +bTNqJtq9XxBXE3sWexju0KkuJbqbZy78ywXrz549dcdbRyR/thAif9jJ7Rreo+zDyXX
         okZVc/rKJyImOzDK+faF7b1ga7C1e9LaO5xQrX93Nto3Ry+kyZc3Wib3Ut8kgk+zRkWy
         G4sd96UrVFFZGDEPZjfJ+Ch0g67hGVS7iuB0cPraqCZruN66NEiG3HWxadasXtG6ChPu
         iNkw==
X-Gm-Message-State: AOJu0YxpNSX4UwKpI/caXIjmD53i7m4bIv3IOyR3B7XOaw3DNqtg9L8S
	lg0jul0HEzDoN6cZ2l8sY1fsXkjJsG+fmvBkEm6dR/EGdL0YhbpyrgyFOQoPMkmto1rbrenW2Is
	DnwTyCh5M6/f+qOECJKTE7mWVjm9hIxw=
X-Gm-Gg: ASbGncsNtprWpgM/bS6+GR1xjqNNkqmb+PglbYSlGltUZhmvs2gSPwl6hINNHCquVdn
	41w3dfvFZhCxtNQcJ5cnt3GlZGKTEIbrJ7lcZ0s8b9ytDl3Ha28IkBr2o20sMzDT95ecs+RL8am
	Se9rY3GhhL87yniENH74WWb+MoCMnw4wnWv5mQ34GvmTlSDutrfdWcLHfAQNskXhz1kEAkNmxMM
	g1j2ZdpgKSocDLFT+A9d4G6qBdXLpVqxEGJdE+O1ulS8GqwjpyHdy5pLDNo
X-Google-Smtp-Source: AGHT+IEDvGlUuVEideahYZY+ODYUe4guvkm4F0yQbQ2rOAGZccJElktFd+64A9TEF3O1cn/fjQ78uoSBDOooxDIQsAU=
X-Received: by 2002:a17:902:db05:b0:295:6850:a389 with SMTP id
 d9443c01a7336-2962ad2b2c3mr69533935ad.20.1762381201200; Wed, 05 Nov 2025
 14:20:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <20251103184145.17b23780@kernel.org>
In-Reply-To: <20251103184145.17b23780@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 5 Nov 2025 17:19:49 -0500
X-Gm-Features: AWmQ_bk5zH6aZ8eA6Di6ajFu_oTzlSNpD7ldH11olJifIEsUkj_P9OR2FBRf4E0
Message-ID: <CADvbK_fdph6C5+nnUix2259TQb9-vBVEPOxMpzzpEy5xhR-xTA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/15] net: introduce QUIC infrastructure and
 core subcomponents
To: Jakub Kicinski <kuba@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 29 Oct 2025 10:35:42 -0400 Xin Long wrote:
> >  net/Kconfig               |    1 +
> >  net/Makefile              |    1 +
>
> Haven't gotten to reviewing yet myself, hopefully Paolo will find time
> tomorrow. But you're definitely missing a MAINTAINERS entry...

I was planning to add the MAINTAINERS entry in the second patchset,
since that patch will introduce Documentation/networking/quic.rst,
which should be listed in the entry as:

F:      Documentation/networking/quic.rst

I guess it should be fine to add the MAINTAINERS entry now without
this F: line in the current patchset, and then update it in the second
patchset once the file exists.

Thanks.

