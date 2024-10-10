Return-Path: <netdev+bounces-134202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270399862A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A2A1F21E6D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545C1C1AD9;
	Thu, 10 Oct 2024 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6wvtZ2p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A321BD00B
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563808; cv=none; b=gzceksIM3Gcb3+CCEtLd4QdvRkx51vGmn7dgBGJwcRBBEfnh92Tl68SNCaysKwJLbhMvH+AKiGgNspM2d8vVbrGZoNFj8kl50yoNCd+qqUPAkJ6Weu+ipA3W26uzKXTrPNFGb7IJRNJugf29AE4lummT5CkDQj7DU6jqwKJEKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563808; c=relaxed/simple;
	bh=bVCNHgt+JYKurlhPmm77zzqSe/B1PNThc3dxAG9YRdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGIoXFkQQbzxv9eSBNCogQoWK0o/+vpf0SCGuGanIg+qbD8HJw/TD8qbU0UGV9Fr5sJPRi9hkyUplJ0mu4Ec9ItjCai4TnBj96UnM+dLaV22N20JZkUv4vMBSeHnpStQsnS4PVj19ld00VDvWSP0NFy3alR/KAQcxl5lgOPQYzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6wvtZ2p; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso635868a12.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563804; x=1729168604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVCNHgt+JYKurlhPmm77zzqSe/B1PNThc3dxAG9YRdI=;
        b=O6wvtZ2pO24fPGkKKQGFX+wP/f/eOtG0SNdBzaOKliMG2Det8VlGUdjjPpXyuyOgXl
         oD545qoasqRXTG5nV5A7WV6vDj8hbyOxiKbRlFQaFzRuHuBrV4us6QqPYKf/kSmPKXn/
         O2AqMef/VYJmsiOgIlzk6o7bexG/nzFkUxJgc0BTV2FVGVN2s4iZXd/kLtxofi+skkrw
         a/83TuJN4BcgaKTCbcpQ0LC2oeYH8Xb0G+39tsC84wKcX5RigN1C/dnLUz31FRud392Y
         HpQngHb2xKjXeHIr1618vu9i5I3aDxrPjO7WFiIyhn3D4C5wllwvLT+zmmx+SPVTM2n1
         Parw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563804; x=1729168604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVCNHgt+JYKurlhPmm77zzqSe/B1PNThc3dxAG9YRdI=;
        b=XvSBFxAwSZHVVSj1syA27LTMv35ciAwDJqxxcA7uXSuzViXsgiChaLqqCNft2+0W/E
         C50x3mZI0bpptREhQ9EcpnUnix87+6atK4URMCTW0DJfBHelGFMqseCLoYYH08eEx5sW
         msQm0J1mKSFT6jan6iBxPbponzoA11Y7pjDsBhL6cRBEa8iRs4n0GvFtGrKy5V8B9wUP
         ZzddsTUKYVxd96WqUxkgEQYMgsTGxsehAlxCBeGJ0IKdNkDCJTsOJl5gHB9NHNHJ3Efx
         VjpMfhoHT39LJhQQ7DNZZAj0JvD3eWo0y28SI2sgwMJKYOplVH4NpThVGoMaHvTrfdiK
         3TJA==
X-Forwarded-Encrypted: i=1; AJvYcCXzRQ5YQPtRgoVPAk+ubDVFfuXMQSmnk3EOLe3ZkgG9AZEei/YxuHOnXh0QkiSsAoAEFhAmgFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAws7JNKOtzjN72eaAg8Z8k4dR7Cv36JFoRdBpXF8Y45Gyr/CX
	G5MCkdNezqH18ufc4ri6nu3Q5YTWRB52Cjk6njEHm171mBbxTxgNvMpqF62GMuitpH5wl1K1AR1
	tDaqn3Q7C2bwuAPxX4gapmVVo61+cjyDCSWfo
X-Google-Smtp-Source: AGHT+IFCcAL72aKhkyOL2a3jMhk9XGpu8oB9MiVy18doJkxjf5pL5+5iwgHEQNao7+SApxXxDMKCkD8BQ5AKI0WQT0s=
X-Received: by 2002:a05:6402:248c:b0:5c5:b8bd:c873 with SMTP id
 4fb4d7f45d1cf-5c91d5a5531mr6041976a12.16.1728563804103; Thu, 10 Oct 2024
 05:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-2-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 14:36:32 +0200
Message-ID: <CANn89iJ1sfqG+M=2ZAePKpOm9j_iKPSfY=N0+tG3h8cv4i04LA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 01/13] rtnetlink: Allocate linkinfo[] as
 struct rtnl_newlink_tbs.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:17=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> We will move linkinfo to rtnl_newlink() and pass it down to other
> functions.
>
> Let's pack it into rtnl_newlink_tbs.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

