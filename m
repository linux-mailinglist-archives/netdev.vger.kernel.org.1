Return-Path: <netdev+bounces-224154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA34B81492
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 20:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9EA3BDB7F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2702FE074;
	Wed, 17 Sep 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jvb/wxXT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717AE2FB610
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132144; cv=none; b=DDQJ5heLzU2juTCbuLKwuX59GXO/CQi7rVubpZa3CgBmhlysg+fbQEwpczQOzJBm+Q7tO4RALAsxX16ED0IOJwqgO+czLxB9ZGswcaOJYjizFcjVvH/ldZDyHOJTbqOXrCmYQGTeT0WXlwVacKacLwqH3hmk88aspbaprVXME2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132144; c=relaxed/simple;
	bh=73ovSHs59LUQfs2PtVZE2/lS99gP/L0euMt9bK3p+80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYyb/pI08nA3iAy76TM/3DUIhb8cPHm3/nYSiGA/aNZZyAQfuuLHf+rpZkKpqriO8U/lcOFTq0Kpr9+BnqeldyxrHmwYWoruHWb1sOoe/uYgLWBwMY9fiT01Y8UgoPKSpQioisGFfIR+6zjCf7x22OB7Ukvk7QlvynkZM17Ynn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jvb/wxXT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso45248a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758132142; x=1758736942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73ovSHs59LUQfs2PtVZE2/lS99gP/L0euMt9bK3p+80=;
        b=Jvb/wxXT6L0qkWRHVi+HHQXCnkKieTLiqR15crZOTW4b/+32GQ0RO4PIMcFPLy8nwv
         sktGmqy1XjLxSaVLJStUOKv4ba0dBhA3WFOQK8MMGgTGst/kVztOlYSwsbqaJXwh1pi7
         bfdbdnoPL0bdGbCfxSimsVon1JhMktLG30sQ0BITt7auiHsb70EFmEnBQ9cBU9OQYOpB
         +xK0Z27g7VgUzlGSs314g4wVWB2bXZG2Wsp+bdRakJAuKtFonNVBepYCxsNZxGwAyZIO
         MXAX//vOahAVJ1nOOkpA/od1rLfDJIWfnz4tZV2f13rpJr3lTA4KadIRvmMwep6CIZWB
         tjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132142; x=1758736942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73ovSHs59LUQfs2PtVZE2/lS99gP/L0euMt9bK3p+80=;
        b=T4XtIJqPwrQOlUa3q7vPEwojmJoeImLm/Cg3e8iom4l9mdgDjNlQummMcl/uSL2Tf9
         sekl/qScHl5lN+16loa6Jcn9sJPDPiarDj6ONfjFNx6BgOackUuBTw0GEYPC8reqiunR
         Rw1Y6TW04a2B5Pc2ufTed/Czo0KQUhXByDUY/rY+N0BWrgG9pQGtva0d0LBWtumjVY+g
         9qgevjCAu+LCy/j2BAGjAGZBptp41EhoggJ3vbDKmVReDtMiv0Q8v3W++mES5+9rJvTD
         z/iOK2Z0f3lWpLwye6xdLs/alZ3jCyd6ikkmFI2ArOoYvjMWH0ydzdTFg8fPscfjZkpc
         1JYg==
X-Forwarded-Encrypted: i=1; AJvYcCUomf62UmAWhWBCH7m0GuRNmY47rR2ihC3sLCzQ4y+hyegwLSmMeDpZjtSIpGgcNecqWQVDC0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKFygcyA/A8lAPvLbhbXNZXyzipgWYKNwxwNIrBhojONZ8VxD
	fC0bE1R7HKt0MaL4A9TyJlpMlRr30uQjKMrecB9hJQL7cUL35lw6UjLQWpXuhOnlacOozs9gpj3
	JG3dbmyZfORn6cpsGk1zMIklwp6j/+QYxIDqlHHUh
X-Gm-Gg: ASbGncvHM8CMN2iq7GVC4nMqwe/5TRQg4QeK0N22CBJ7/tZJxrjofqImXi6vezCJvBt
	ktfa/6OePLkp05si9SbG2b4Q0i95WaIz7eLm4WXhoNeeeC9Q/y7KF+62/ZU3MszCplkD3AD5rBC
	TsEebliKA0Vbiy+NTH2HuoM/YqNRsS/+WzwLiQEPQChtJUCqeNEoAbDnBbg54VmOZoEXBAW97GT
	Gi3ooVWNai9eTXUg4U2o+SITIlrW8P5ulXfp4JEdNWkHgq1kP/tnkM=
X-Google-Smtp-Source: AGHT+IESPUJqIfTUr1MujWOdNgZ9mRtXrOL6NIiYAqaoUq01b/bjSbjNWo0PezSA+fP9nvezISFhUR7InXx2H9eopg8=
X-Received: by 2002:a17:903:2a84:b0:268:baa6:94ba with SMTP id
 d9443c01a7336-268baa6bd63mr29129655ad.53.1758132141271; Wed, 17 Sep 2025
 11:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com> <20250916160951.541279-7-edumazet@google.com>
In-Reply-To: <20250916160951.541279-7-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 17 Sep 2025 11:02:09 -0700
X-Gm-Features: AS18NWBaBg89kiprH0HiSslc7W5OhfkTl6-sCEeAsqYIW35Iilv1f7wPWEoWNHY
Message-ID: <CAAVpQUD+8gJ_tYoW3s8bGL=Bt-gCvgFG+E_B47oKA2OHtV-Fzg@mail.gmail.com>
Subject: Re: [PATCH net-next 06/10] udp: update sk_rmem_alloc before busylock acquisition
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:10=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Avoid piling too many producers on the busylock
> by updating sk_rmem_alloc before busylock acquisition.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

