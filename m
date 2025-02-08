Return-Path: <netdev+bounces-164296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF157A2D429
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C323A2CD9
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE814F9E2;
	Sat,  8 Feb 2025 05:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTR55U0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2066FBF
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 05:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738993582; cv=none; b=C4F9a90AKDjSqKhVyUtIrIbbBGMfSWW2rGyxwLSdDryMsujAHui5Uiyugox18KwOI4LavB+FK52dQFrKx+S+vRSa5HSrfZqKqEEBnyiNYWpXG7KlDjS/N8EbJYSXDQiAQB0HczupQFkm6BkZifyIoX5R+W6qTafc/y0deXEjRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738993582; c=relaxed/simple;
	bh=wCHv0Obj4nbWbMOcMkkJwAphqldP5qnPqfx5fbcovFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXMozXg+ERBsP+2m4bUAlRU8/ZcaeFDpuXKtgcYeDzc+CCpkUg9CnltELonKg9+9xk2rY2TQHqn7A/E1WG2aaz1FwFvMs79U/CqczXqUtzFdS55PIp29bVuu6VPep3zcHiiJ1lbBHz2GkIc2XUlvDMAXHt7wdaSQmp6VytevNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTR55U0Z; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so7583835ab.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 21:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738993580; x=1739598380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCHv0Obj4nbWbMOcMkkJwAphqldP5qnPqfx5fbcovFQ=;
        b=OTR55U0ZliwFC/JcJIiLNlGiTOxTh+o0k9m0xRcedewFx/IYQCiWi8bhbf+smi+s5x
         XCp6yUVOX77LbaKwv2si6A6XtqpWyUyveWGXbzDd3zSnCeX/bMrTa/Ob13CgxJvg40Ki
         n4cC20YRaWYJXabfokM3cQxPQYQs9HEbEij6M6xMhNVDetp6rNC5TBie9vCJIKI+0C2r
         nVgiCF/7YnkWlpAwFMyO+ke2V5iYRY6t5FFtEDjFYDe069oJ9A/EU204WmDPwrvbBGiL
         LokkCgKs0qO/YgG3LD0I4GPe8tjCd/0HST9H7+algzSMgyuqMbcUu29kACewagHridWt
         n5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738993580; x=1739598380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCHv0Obj4nbWbMOcMkkJwAphqldP5qnPqfx5fbcovFQ=;
        b=FtgzHELxWyoneBtiJ8aO1AleI8/W17wlinrE82IqN2Q1R3xZXgwr0AWVaOXZrJAZoJ
         O8A4gRXENhaqQO8OD5Z2RuRQDV4zg2majJHU7Gc1iCmL915nNAyKe5njVZWXp4C6tGVq
         6xwFSC1eD7B+4j7KLKTTyuKr1nbAJ5tlTKcJol5cvefh3ADK8GZtEdSpCGuI4vd5gNjo
         bpCwEkdnNK8WD7tfYF7ku0jz6fnGml84tqKaAFvKkcne1z7ClJWPhdbEBq6on2oc/HhC
         dZi7Zebt0gYvGSm7v8dXw6xBKaim3xhOSHdB1siwsnRLQgeUCT3UaUGsYeFYDN8UGf3l
         FMFA==
X-Forwarded-Encrypted: i=1; AJvYcCWYLbZjgKL4dco4nsoHtXKGnx4JuXyDD2/Tf8z41eUcVMujeuA3ezJBvyrI9IXntkCDhz2JHq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gml6ZjvX5xnyBeD8bd/yT7h6yazhUGSMC335yLxm/6cxa/c5
	TTk7c7cGNwyCboyv0PkY2lYxTArdPluJj00PxHXL16+tvvyhPaapJNyfVBtsx4HH4nOhr59h/gl
	IwXTE7I5BTrlE2LZ63vfRbElrbqA=
X-Gm-Gg: ASbGncvnRx17XiSC+ZCc7Xm7VJ+oP9hwFF0K6RiWzQUPvX2U9x6MtU71bioIJR3qtp9
	V7hnmlp6XQeukYK7XpXT4tVrt0aEqr/yVbcZzHp/xmJ45gV0BiBiYM//YzJuOAfAcWNrAJYc=
X-Google-Smtp-Source: AGHT+IFM1ug+Al9a5JYJRVqYF0wnf9OCNaGekKeyuMA8FKPfP+X07+eNL+3bWa8hQ4SdFwqWJr0uav3bNWqvuwcD8/M=
X-Received: by 2002:a05:6e02:b43:b0:3d0:23ac:b29f with SMTP id
 e9e14a558f8ab-3d13dcee786mr49557565ab.1.1738993579820; Fri, 07 Feb 2025
 21:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-6-edumazet@google.com>
In-Reply-To: <20250207152830.2527578-6-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Feb 2025 13:45:43 +0800
X-Gm-Features: AWEUYZlmp34zcTmz0OoQQmGxIZxffF4ylIA7JussKjYuZXRi4jyqd6SghotBfbA
Message-ID: <CAL+tcoDRCu48Dbs-T4-JvBJ4kVnbT8peK5RhBvKv11HwmR0N+Q@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] tcp: add tcp_rto_max_ms sysctl
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:30=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Previous patch added a TCP_RTO_MAX_MS socket option
> to tune a TCP socket max RTO value.
>
> Many setups prefer to change a per netns sysctl.
>
> This patch adds /proc/sys/net/ipv4/tcp_rto_max_ms
>
> Its initial value is 120000 (120 seconds).
>
> Keep in mind that a decrease of tcp_rto_max_ms
> means shorter overall timeouts, unless tcp_retries2
> sysctl is increased.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks for picking up my incomplete patch/work and fulfilling it at last :)

Thanks,
Jason

