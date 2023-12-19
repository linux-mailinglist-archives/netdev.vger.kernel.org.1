Return-Path: <netdev+bounces-58954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24A818B02
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F2B0B20B05
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DB1C2BB;
	Tue, 19 Dec 2023 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+OjxsQD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C871CA83
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-552eaf800abso16673a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702999075; x=1703603875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNRkbdVZuemnh1yFK45bipp6+UrqkjQfduv8PlT282w=;
        b=H+OjxsQDnWChVWLVm31Cit4ah3nz+wA7vOxrgUlQZ1FfhfQJerVbE/rIib3VLiOeNN
         6KYrkY0sR+8GWIcXh55l9WRLndlhFxvUTpLKpoPCDLSFLg/hlNxO59AZfJ2N2Lp2mWtF
         LJongjro5q4M+XGcEbBE5DAgVvJkR+Opbu1M/0e/4bvRR3r/BBeywxKhUd2ntfsWIjol
         w0NpdtJuC1H5DXW2Ncgrgox6yGyxQtRV8b0VGQ7zrogk+TzViHtV6leVFhQ1if6+gup0
         KpBQOzDNMT/iyh6+3TnIXkTteRC+qgCssPOSut2bOcG6w6qMdQdscN/YbQ6RBRlPl4ry
         QP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999075; x=1703603875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNRkbdVZuemnh1yFK45bipp6+UrqkjQfduv8PlT282w=;
        b=OdT0Y8CFhbzc0CrLOpj7EJ52IeRRfFqLzsCV5RpGvsJDm4Lj+Gre4578Hb1dQvcdwx
         XfvnOJAWuHerxDh7OQSvDqPx0Dd9KiRbzbHSSTRmp5LB97FXDix7WXn020kUBCeX3Vgs
         57dyQZkDoa5PcT/gRJ3ARLfDrhTc3qc6QjFQBR51j50xw4jySv6+5erg7mRTD5rJdpAI
         G3aTauGcI7f1eGAc7LQioDV+cgVXIEh1U1254T7onEkdpcfnGkDMYgOuRbbYNnMmFLwx
         6slsAZVb7yuHyuCT6/GHlM/tFM0bRGpGhGltrQvKCoxENNIN8X3nPPvVuGXD533VGuVH
         glsQ==
X-Gm-Message-State: AOJu0Yx2i1PdaFk2KCOVOn4v+O1oDYQiB05LkOl7vAq0nqQKrLrjYxcZ
	DLVpnJKVo34mtbI4ZZvWDTMre8W68YBt/Oah++o1tDsmAGeW
X-Google-Smtp-Source: AGHT+IH11TC8MfyJIMPPTfwj3TUM5YksvAenbSL28erJHcmMMPFkPUmNphLon2fMfu3Fi4UPfL/nXYeR+UTgV/xwbuk=
X-Received: by 2002:aa7:cf19:0:b0:553:9935:294a with SMTP id
 a25-20020aa7cf19000000b005539935294amr147000edy.5.1702999074468; Tue, 19 Dec
 2023 07:17:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219001833.10122-1-kuniyu@amazon.com> <20231219001833.10122-3-kuniyu@amazon.com>
In-Reply-To: <20231219001833.10122-3-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 16:17:43 +0100
Message-ID: <CANn89iK28G4O0vfF2U7Q175XiRc1NwdWOLbSRD9jqr7G=CQ+dg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 net-next 02/12] tcp: Rearrange tests in inet_bind2_bucket_(addr_match|match_addr_any)().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 1:19=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> The protocol family tests in inet_bind2_bucket_addr_match() and
> inet_bind2_bucket_match_addr_any() are ordered as follows.
>
>   if (sk->sk_family !=3D tb2->family)
>   else if (sk->sk_family =3D=3D AF_INET6)
>   else
>
> This patch rearranges them so that AF_INET6 socket is handled first
> to make the following patch tidy, where tb2->family will be removed.
>
>   if (sk->sk_family =3D=3D AF_INET6)
>   else if (tb2->family =3D=3D AF_INET6)
>   else
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

