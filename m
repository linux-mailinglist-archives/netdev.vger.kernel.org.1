Return-Path: <netdev+bounces-93061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D28B9E22
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 18:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1037286652
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D5C15E1F6;
	Thu,  2 May 2024 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJhfJIcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0815D5BE
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665834; cv=none; b=hPXZKtUGZdFjF9kDSlRnJiX5XvrtlAaUiZAZwz10zw0c1UA+q5xJdHfsbkBCcF5CXYp27Qq9/YDCDf0RK112Pu5IVH+wSRNSmXFLNUgqyyGrNxaTjK79MC/XLIhiqBSXM9BfAaRUz0d73LlcxLughHbbwWrmNSCcOTuTZK5Ll7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665834; c=relaxed/simple;
	bh=1e82K3Ua6k4IUiosWcJpsPWipzQfQxYKyxwgm1RKcz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O14RFYtd73M6F9klblBbIKwjwOIEKK0UPGIISlokYuEdJP+FUkJuvjTc6AcBsjWJ+/VwOlB7vBGg5TP7qL77xf2I5PTMjl1jR+6K87VGBxEEppK/+MXj7e9gyldDzF3+veEoXGv+wfsW+L0sqQ6YJ7rthi7lq+W0k0Hb8KOvSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJhfJIcJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-572afdee2a8so7368a12.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714665831; x=1715270631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1e82K3Ua6k4IUiosWcJpsPWipzQfQxYKyxwgm1RKcz0=;
        b=bJhfJIcJijEVDVdEklX9IZarORf59HwVcEIF1cuer3TYXmOwKg+GhwRiATv48YrRBj
         bJgrAyZ11OdqVqi8x1jxKvXIUS2tiB1SDvap8Ivcdfmve22r2FaMITKysBzF89nrrIpI
         SBgDQdwCFh07CW6Odx1uZ3wFgPJIbbWO8rI68zGBy9zRVvFqsYkqjjYs2oN2jqhftNfo
         yZX1FF+bDTdvbj/hF8diOfv4aCmwfLBj39kRpX8BO/AlAnyQx1gOeJflqcDCa+vuFl4e
         6S/JlDFn+IjJFDhoWEAL7P0Jk8+MUeUQGQlx+Y+9s/jZFR2ToqK3Ftw+26Ek2z+l6ubO
         /VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714665831; x=1715270631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1e82K3Ua6k4IUiosWcJpsPWipzQfQxYKyxwgm1RKcz0=;
        b=Q6IYzizySI0ZSerWh3qh52IIrxRIVLLnPQetBCokHXIIGgHOn9tTQaI6x+R2MW2PbT
         bf9m0PxJTUXiIJfaLG8/34j+kbQtayO9WYdvBwr/K7lQTTh2hNSwEFEfpdvZOBrq6nvd
         AiT3skM0xqNnsxuqU28eMk0WDwJFGEzPFp1b3KY7swPEUDMo6rA6NiKZSksHyjeZKZkV
         rcKg3att5l/y5VrQUsYz+kj8xvJZSR5LmHMb3tgTAVXBFabqf3PuJdFPEgnYPXcq/kub
         qK74A8fLhUh+YrAF2ehQ9q8VXtFq2J5V6MLRJoKdFE78zeISelMeXvVAZgCSoTeDLWe7
         vJYg==
X-Forwarded-Encrypted: i=1; AJvYcCWfk3EzzWXeGMAcZEbLHvrjXuz1PYFVZKak1wHO6/14kVIwi+7LISGVIIA5aEVIrTIBh/zOR82CHctLzhQPFg3PWk5S91UF
X-Gm-Message-State: AOJu0YwsqTmL+FsFkP7uZPwvUzUuiqDzS+aMTozTJ2Y5nOPg0I3dsazc
	kiEFBQuCP6hoVkJyU4nG7xRPNFmWIEdoOfl/BVhF6B5hPykHqsXKevGwmxiB89o5HWhGmliMRxI
	vnRKDWc2OSNSz8HDTbsfn1duxIKD9uA6YnMWw
X-Google-Smtp-Source: AGHT+IGiOCHLERSdspuoVfuSNJY+R3Yo9cPLAvytq3MVmvBd/qZK7spNwOC8TPHEZNAGm/OReIBgVqJsEmoaAeENAp8=
X-Received: by 2002:aa7:c6d1:0:b0:572:7c06:9c0 with SMTP id
 4fb4d7f45d1cf-572bb3e9f13mr261417a12.0.1714665830800; Thu, 02 May 2024
 09:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502113748.1622637-1-edumazet@google.com> <20240502113748.1622637-2-edumazet@google.com>
 <d09f8831-293e-45ec-93fb-6feab25d47f2@kernel.org>
In-Reply-To: <d09f8831-293e-45ec-93fb-6feab25d47f2@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 May 2024 18:03:39 +0200
Message-ID: <CANn89iKPSp9_bZAZpFM4biEg7vFXxMmY2nQfEmTfLsiHGdBTxg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] rtnetlink: change rtnl_stats_dump() return value
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:59=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 5/2/24 5:37 AM, Eric Dumazet wrote:
> > By returning 0 (or an error) instead of skb->len,
> > we allow NLMSG_DONE to be appended to the current
> > skb at the end of a dump, saving a couple of recvmsg()
> > system calls.
>
> any concern that a patch similar to:
> https://lore.kernel.org/netdev/20240411180202.399246-1-kuba@kernel.org/
> will be needed again here?

This has been discussed, Jakub answer was :

https://lore.kernel.org/netdev/20240411115748.05faa636@kernel.org/

So the plan is to change functions until a regression is reported.

