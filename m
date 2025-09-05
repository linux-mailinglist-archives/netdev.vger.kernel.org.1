Return-Path: <netdev+bounces-220294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5026B45544
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 12:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA185A648DF
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 10:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4A431354C;
	Fri,  5 Sep 2025 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYaKJiyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8992A3148BA
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069238; cv=none; b=JG0w+fG0C/FqVHfnzy4WmEktrLYmQXMgwiBS6K5hH58Bx5KHN5K/hh7vuQVrpR87N5ROXZrvKp6MtaYOCOVyIslYmvSPp9eEyZRKkQGuO2D8lrZbtNCqEQuoh8n8tvPiDIiHEPW0q/JC/PTYyIFpgUhr8HtwC5YHubViDQLI36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069238; c=relaxed/simple;
	bh=tqiu3s9zFltkSv11AxpsXkUUUkqMUieGxD3BL7JwWec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlwX/miNuFIS1wxjnTCc69Mitjbgr2RKRADhcfCVY27Q8JR4Wo04B5v3ajZOZ70VNO6vqq8SKz+vfL+Bup29m1XMIWSNG3XnPlj3fj6a/aPhX16gag2A/65GZAUohubiQ6qzcL+WycPgD473DAUWzxkura0UtvUvyqVWzGD5nJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYaKJiyi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-811dc3fdc11so16701685a.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757069234; x=1757674034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy3M+/QDMFTe34OIV0nD0yl53yFOocCSebdPGEJFkD0=;
        b=WYaKJiyimC59PycZD+Wl6RgPGCNG7VhTffk98C//szr3/mhYdc2yP1J4kJGcsCetyQ
         vvCwhkNCkv6am91orhrcgj6yl4ZrjyjrOscI2xnBEO9HnYrxnTGpLma/VJqKGF52BLSA
         usEdJDTV8nHIU9bk6LzpAOUWMUztse7/SQaOHUT+ic3xjE3bJxkhUlh3UI6Ugeeiwi3w
         IC816SC8yC1QhfgtKs6WWiBJ2pI+N4BKPIv6UWeEsQxgfbTDZZh0N3ULBKxrWpmI7FSk
         vdxJpwGXIYz+D9oTUeq6YHgtoRuqb8UwFAd5mPryJ41W7CnWw47hfQiTzsjQitVjq8D6
         tbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757069234; x=1757674034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy3M+/QDMFTe34OIV0nD0yl53yFOocCSebdPGEJFkD0=;
        b=rAmLiEqypPRzspdK/16v0y9FbsLGCtV6doJDnDpivetlRfbnlSHx5oij6igjp1KaUl
         rEMvYDZB1arXq8vVQttrkHLrhC1r62a0KZNQQVXNzq2CIqPBi5PlI9kyjjLif/ObbRBI
         Mpk/KK1bNRx/ARoE59gfsNJqAAq64zjGsKXv5JTr++YoUV9o+qPlj47FeZImvN3S7NYb
         ud258cW29fsy9lyjaXHBO08f3Z6xdq6vNPgx/8bugJOXW5OaJO3ocNqH+hvSDElvVUrz
         xcRpmLdInae3UcTNifMPTXuw9xsQ9LTAl72V32SSvnzSSZy2hxNs7CCU+h8mDOJHIRPZ
         rGrw==
X-Gm-Message-State: AOJu0Yw54lncKk9AA6eCDDEV/GxWV1S1CL7Q9kA/cCrzFFvkPg+ClHTY
	tJZkU2Ddxs0+lz9mHiHnL+EmFz3sIN9eurvz/+5RCxSSWZ8rjujEfSOgB7e2/y6YiwcpSlhNcKI
	9T8SPARcCMWUzScVm6PVQDBhpb6UPoht53EXUKMZZ
X-Gm-Gg: ASbGnctPY949GgQewNICw6Ruxg3ulvfs47HCrQC4xxuMHyY2BVj0g/cazwmb5aJZOX6
	OnuI7LC9cIXzBtct2NigYxdYvT8JPcQ/88hVDAOEuiwMmU+m39w2T7pVSO8u6m+sOJH4LakSeon
	1QXHduxPkiWwkICfoOVkpFH6bI6kvHUNn9xJoiqtLm9SQIqu27KouIBUvbxP8rpP3KQYcMzRwaM
	O+ldW0JLrdTyt9xDtYV1Kyg
X-Google-Smtp-Source: AGHT+IEf/phnrXIkufCTZk4sFshrIxsZkHhdjyS4/aEGRW+A2spzOP7s35tJPyhD8Xp2ObBAoTmD8NeiPLucXfyQr3w=
X-Received: by 2002:a05:620a:4016:b0:7e7:fe1e:80ce with SMTP id
 af79cd13be357-7ff27b20314mr2475069885a.19.1757069233923; Fri, 05 Sep 2025
 03:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902112652.26293-1-disclosure@aisle.com> <20250903181915.6359-1-disclosure@aisle.com>
In-Reply-To: <20250903181915.6359-1-disclosure@aisle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Sep 2025 03:47:02 -0700
X-Gm-Features: Ac12FXzy0Cy-WdhGEnYslQBiaE0zk7uzikMaUzSMrpzivq_gHWsb4MyLhAXuOfI
Message-ID: <CANn89iJKZCfsNzM8D=JQqQ=vyaun38oXfcC77AC6BTC0MWvUog@mail.gmail.com>
Subject: Re: [PATCH net v3] netrom: linearize and validate lengths in nr_rx_frame()
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-hams@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:19=E2=80=AFAM Stanislav Fort <stanislav.fort@aisl=
e.com> wrote:
>
> Linearize skb and add targeted length checks in nr_rx_frame() to avoid ou=
t-of-bounds reads and potential use-after-free when processing malformed NE=
T/ROM frames.
>
> - Linearize skb and require at least NR_NETWORK_LEN + NR_TRANSPORT_LEN (2=
0 bytes) before reading network/transport fields.
> - For existing sockets path, ensure NR_CONNACK includes the window byte (=
>=3D 21 bytes).
> - For CONNREQ handling, ensure window (byte 20) and user address (bytes 2=
1-27) are present (>=3D 28 bytes).
> - Maintain existing BPQ extension handling:
>   - NR_CONNACK len =3D=3D 22 implies 1 extra byte (TTL)
>   - NR_CONNREQ len =3D=3D 37 implies 2 extra bytes (timeout)
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Stanislav Fort <disclosure@aisle.com>
> Signed-off-by: Stanislav Fort <disclosure@aisle.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

