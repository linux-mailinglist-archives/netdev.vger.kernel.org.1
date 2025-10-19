Return-Path: <netdev+bounces-230757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED04EBEEBCF
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 21:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A58401B78
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 19:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E05224AEF;
	Sun, 19 Oct 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zwsFiE88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60641632DD
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 19:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760901975; cv=none; b=L7kZB7YSjqvnhQ+6dGInrAz6QJNOteO7o+uNFSaCTOJoHIEf7FUG0eMhhQ7GHfvR1yjYOGPREHjzcXYSOFX49odo+7HS49y3UWkkwEpZR8LtwS9rJvUtvQD4iA/7RZMeJvIj/0UiFB8q6MuvYxyNnnNsE5ueiCqbtNe5A38bNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760901975; c=relaxed/simple;
	bh=nCIMZWpRoTrIZBfCj1SAgW17vOUJl20ocKBjh/okZDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsJCsNuZAlDg73lLv6+xgxZmV8xleqsEg8bvlW6IXFm77TmW0B7y4wBXk63epel13UYjcqW5n8l6Q8Nip6Am6T0Ze5MOmbwa/CBZiXcLqi53Q6JTyTyVzY743rkVlw33VFRd7fCwoq3a8RhlQVRZYquAeWnyMn+FVvGnOA17VXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zwsFiE88; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27ee41e0798so58541745ad.1
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 12:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760901973; x=1761506773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCIMZWpRoTrIZBfCj1SAgW17vOUJl20ocKBjh/okZDc=;
        b=zwsFiE88QLug4hr7q055kGElTPO+NtGb+lpQDlo9tn2TtL3yUwUZPwif/KuVHjvgig
         OOeTjk2QoOX91a1A+kEGyZiQMNKMzKA71zWeHCuGJK/21ny+GyQV9AnYJwXoIspkVQd0
         P7Vv1DZjQhBrQq9fz43kVUdSHkWDAzkaeFKbC5XMksouLJNk4cPmHJTTM0HDLpvRMBY5
         TmeTNXf8i+jsiBWY7ARXJc8o8vdmjFtMEccIamqzBUTaPHMmb5jFNRUk+YWckji8NaiF
         B9ibOuTx0PAYNaAjSdBV1SjqGk6jdJ0urDRVTmRqfDkrzT8rF4tzc+ne+486rvBU/GKn
         rS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760901973; x=1761506773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCIMZWpRoTrIZBfCj1SAgW17vOUJl20ocKBjh/okZDc=;
        b=LG+R3XCEEuy3sPpM2vFzX5+qdZM5pXwYrg5AQ3sJP5IYeFWURjYckKNJE4jagYR0Cw
         7WGtPsCj3siHQP2bTwGsoaQgEiZF78Y6zBKt8pjl+QgUJqidw/58ZTIW340UIP2/w1xu
         FBL+l07WlmgoHzqa/Nd0dzpN2lg3QCzWKjks0KeARiDHBLH/hK5NR28CMDHn44ow6KLj
         T4iHafJafMAwuoFkqhVj3tCRVDUNIaf9YpDNEeQQpppSuHIiS/Ma1LGogj+pM5qI7ODs
         RxFpVZF2mlee8XRrrH40rzcx4Ok4B4QItK5Q9uPnL48M1nY0/P/gsBSbxH15nCcqS4eq
         p8vw==
X-Forwarded-Encrypted: i=1; AJvYcCW1OthZ0tNVQCU0AlmfC3svfi+aO3dASWfJzmbixK3qjvQ16jhkwXf/blCyVAI98bFBQJqzSNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdaPUz0aUeqDf+iyYPi+Oc5gw0TZn8vhijZ1kpHeJL5h+KTof
	ZaZbQi2YvA3yXJUVSIbO2euanhus//+fXEjiNyImrvMW+aOnNfIBAeSi269QDCGF1qQ2UWvDtj5
	cRozT5LmVMK+PBiTj/+gHnW2ptNiciBCav6+3Lbd1
X-Gm-Gg: ASbGncufT4755QlMRZZhAvzNvaOQAb5rpzPMWHtw+MyfxHKZecS3P7umo7JtMDh2BOy
	Gg72iukXw6oBOudunp7NHukKiBWGV/T4HlRIrPvFaFYBYEa3ZfDRpwf9BTU6JXczZ5LI4RGMVBX
	oU67GugngJh16iELiabcp6p+EnkqDfG6ObCmVi/BK5cNllRgqYWF9KrjIxS5BXHQunhfNMFyuNS
	d8n9PVqut2mTqN1aKs2FBz5+nGlCWg2Ars1gjeXXXQOPr7k1yp11LRbTQMdly6dhkRsAKQbCBCG
	1n4Iy6BH+5ZrjDyCuQ==
X-Google-Smtp-Source: AGHT+IGqqeB7t9xhXDKptGsxon2wnEAxAo7r4tVSmuzTScDvBvQkpwY/J3PGgv7VfeScIiGvTgipUCxNy7cNDucnZPQ=
X-Received: by 2002:a17:903:3586:b0:262:cd8c:bfa8 with SMTP id
 d9443c01a7336-290cb9473f9mr125446605ad.34.1760901972897; Sun, 19 Oct 2025
 12:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017133712.2842665-1-edumazet@google.com>
In-Reply-To: <20251017133712.2842665-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 19 Oct 2025 12:26:01 -0700
X-Gm-Features: AS18NWDl_dZMqCFeAC0XFLMEqk_JtDjIR38IU3ArUTnCrhpEs0Iahk4-pxXlTvE
Message-ID: <CAAVpQUBCENDVZV1KYujdEnQicaRRa8b_FrusD4N7k=tO4CQJug@mail.gmail.com>
Subject: Re: [PATCH net-next] net: avoid extra acces to sk->sk_wmem_alloc in sock_wfree()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 6:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> UDP TX packets destructor is sock_wfree().
>
> It suffers from a cache line bouncing in sock_def_write_space_wfree().
>
> Instead of reading sk->sk_wmem_alloc after we just did an atomic RMW
> on it, use __refcount_sub_and_test() to get the old value for free,
> and pass the new value to sock_def_write_space_wfree().
>
> Add __sock_writeable() helper.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!

