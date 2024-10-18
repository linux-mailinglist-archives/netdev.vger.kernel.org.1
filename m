Return-Path: <netdev+bounces-137013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF049A4067
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D84D1C21D0E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF613AA2A;
	Fri, 18 Oct 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/Vf0MyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031D41A84
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259438; cv=none; b=rlN96NAkSuBYDK0CZqxh8fCHaDkDcQHFHyAHcODIXPEFNoKUbS/H+0PZtpmWbuSq0A6qE1F2AdGQ3OCOpW0U61bN+UHnaKxJ3yX0e7twTq3dUJ6TfTk3opm/Vf843dtEHOjwvl6H4XkVrTm6DA5IYcqc4b/GXF67yCQMxserR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259438; c=relaxed/simple;
	bh=XbGrUDKNr3oAG4tRgvH66Ac9yEhSB6sxyKDB3I5uLDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddhqK7jWqLbVg/CXeV8DrD8Ksr1QgHSmToWZ71IpXRTmZrWFZz+iCUvDqKVtEV4KPLXweEtlNYweMNSdFLnyUO+SASdv/m7zb5y33dak3tqYsHxc8psZ6L+n4cmlnSgnONaquUJ6j/0NYasl38whKf/pUGc+/jCSsCCXi/1+n7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/Vf0MyZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so2280314a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259434; x=1729864234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbGrUDKNr3oAG4tRgvH66Ac9yEhSB6sxyKDB3I5uLDM=;
        b=M/Vf0MyZwyimwfqEVPMhnvnAKdCGVlIYqF8Pet0392BJ0kjK5YdfOv1Vv2F1YcSdZn
         LwT83GVp/9bHZ8f7yU0q2U3U2W6hZ9q2ShNSX2/2YnJJy0r2rrJyGasCDaWocV3DBd09
         PjirSxhM0b87yi5Y9RQxbvvk8ZZpE+jXkCniBax3HtkQM2dyUwr7aKbg4tXdrYbyhCOp
         AFo2K8dVkbqT3OGfL1+X9aptfcp7rkHwNvdBDis2exypMx7pC2a7dHe6Sb0SOQnAdgmI
         +X+s0bAG9meybQckDx4v9bZVW7z7WI05lA4dhi/iOj+BFWix4gh47FB7lgbu8X12/GEa
         pq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259434; x=1729864234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbGrUDKNr3oAG4tRgvH66Ac9yEhSB6sxyKDB3I5uLDM=;
        b=uquk3eNHutWmfShgpYSNeTNjtPdBgDnJ85Lj8uTQfIPXozIUolM5TWoPjVFC9j65AY
         ESYgJgNW3F+KBrRxTSy1VI3TXDLylJfFHaVKYWGIwVoD1qL/k5yTQjIofrusfdBXem6C
         XupoVOBRS1aEL3cOXt3gDPc6XQYIRAcIWEiaQFvin2gb95dcFOu9lmBmwJwFyM99b46Z
         TmLQQg3gkDd7rkeZIXbipql5lPgmnGQaeX0TlLSROEMBtlO5kts1hebP296PO3KFkxyG
         aUirMzwrbPGzcAO+ebH/5dkb1/eoq2cMuT4gwUuw05AgKP9V4ei8PmQ/dKHQzeZM2Ynf
         4H7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWT34z2NFWN9WmZJ6ypVIVt2PmaSVTiRNio96Kec/Zkj1dtwvTtgiUM0Y//9Xj2i9mKECSMGGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwjmu9KCdQFaeqhSRPuVBMk1hL6HH4fKuld3Xneo/9diqdkq/
	yF8GCFjXRxZK7EcAwZCzrucaxHsoBOEkGsF3qgqrnrKG7IhDWW2HwUQ1hVFLdsKB1yTjTga8CF3
	ikiNbp/tfYqUGjijDnei4JjKZfpqWvQm/aAa8
X-Google-Smtp-Source: AGHT+IE86dm4lcJIvqnVpIdCcg6hykt5pbTb2jdFdRUMik1iz+HiCp2T0d+uO79mqcdBQCkmTz7ug0TAjF1WvfsRaFQ=
X-Received: by 2002:a05:6402:5206:b0:5ca:d11:44ed with SMTP id
 4fb4d7f45d1cf-5ca0d114585mr1487709a12.22.1729259433930; Fri, 18 Oct 2024
 06:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-3-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:50:22 +0200
Message-ID: <CANn89iJdZ0X1sor3f+WCcHt211ecaKq1-3=B0eHo1L=VEdp-JQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 02/11] ipv4: Factorise RTM_NEWADDR validation
 to inet_validate_rtm().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:23=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> rtm_to_ifaddr() validates some attributes, looks up a netdev,
> allocates struct in_ifaddr, and validates IFA_CACHEINFO.
>
> There is no reason to delay IFA_CACHEINFO validation.
>
> We will push RTNL down to inet_rtm_newaddr(), and then we want
> to complete rtnetlink validation before rtnl_net_lock().
>
> Let's factorise the validation parts.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

