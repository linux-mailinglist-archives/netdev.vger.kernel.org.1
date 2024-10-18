Return-Path: <netdev+bounces-137021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0012D9A408E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CED6B207C6
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844B558BB;
	Fri, 18 Oct 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEDOE2IN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37C2F9E6
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259828; cv=none; b=fW50lhBVkCpWH599vjnTdBJajwo4/usmaBG0Phbq2n2hE/MrKBrZhyDUUOc9ftRUtYBkL+fm6ziSC3Fu8j5ADPq/80ZdK9Hi/39H/TGtdol75vSJCrsJ+j6OXYlANIBlzDsMPVYE4gS9sS6zGthEAILBfKKxpTD/68AELBR67gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259828; c=relaxed/simple;
	bh=M81mLAjwj5aDRsz+qEeQsnrsJ6Dkptv6/3sdnEN9asg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Exz8SLIlMNFEAjATbD9nBcI00IBFTgP72aPhg8UYwoDITmzIAdWIt6Wyw4uQKfJWV6QSWIFp6sTQGxYllxcC7R1gwG9EpcpgdLkfp1MBO65ZkeyXvEHTZ++5jVCDa33APiqYcM4CKHLGSuwNDgMF8kNFo2y/XmFMUS2GFm+Wc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEDOE2IN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso2439083a12.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729259825; x=1729864625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M81mLAjwj5aDRsz+qEeQsnrsJ6Dkptv6/3sdnEN9asg=;
        b=YEDOE2IN6pbOBZWgvyj5sC0/DfNFovSY9jbEq5ASL86NmbI4oRsDOkvHgyNAX/T5wv
         G0VzAzmge9zv/KwuJgosbF9HrWBNjIhk3Zth/W/L+jdHqKuDLru4nNAsb76bpUf3LaHt
         6H3gUZBX2MUvRliWBF2CqTemzfBE5G6pD7ixwRDAlzaPiAxlBw93fhK1tgKVT2weTlJc
         0SLTw4DDfrS6nSJAfoxMmwPZ+lZB4+gHCbzVZTBk2ydwFcGeqc+J3BXDOiUZGNTfAHFG
         409YTu2RBepBdP1zi3UvZ3Hz33hg6LnmhmKoIzxT/r+pnpKfzin3fEQJvQpulJquO543
         MUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729259825; x=1729864625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M81mLAjwj5aDRsz+qEeQsnrsJ6Dkptv6/3sdnEN9asg=;
        b=w+Sm2u8FXnMUKl/1wpWKMX8Nxd0UhWtCOawzmR4awb97a15CHuA+REn3akA3ibKO6W
         Q8XFMvL9lWwySs5mjyUltivue2rcbRrUro/MwJw9aZ28V0aVQDA6EgUt+rsxVKak6jvf
         2NE7mRVH+b1zNIZsly4wwvjdcpxlnxeycwaTDs+SGBAYW/t9BoblUbhUw6pZHJ8dPr9r
         0QanLp2iZvLuJfihEnTePuPpA0YwisbnEc1azoHakRXkhDdvdNtxe/UBMp3IhhMUr/TH
         otSqr6gchiVYiP8Hb0FBadkinNIj24Zh9RivKYcLvCq0504RmR53/eZowRqapKGPUWDE
         iGBA==
X-Forwarded-Encrypted: i=1; AJvYcCU5QHB4t38pycDMHPn384sGipNUVwbwa6ZLSFlKcTv9wNywISP/39RaqqErJbY+DXJton8s0zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SwR4IMYdwIeWIpX7uhWHBnBQaU+gaTjx4EAc42RVkOYPAU2F
	nKJJ7AYGLyOqSIn+apNKyb6n/tF8kPvymSv+CpOAmeu7snJkVlpsi5vOJoEFx5RLOljIKcEnJ9Y
	5WSmh4lcvqbb5o4blO3xbwWRCkijKG5NKCZg1IdvRuVcdoDpk2F60
X-Google-Smtp-Source: AGHT+IGxwRMA8SekD6/ww0ImNltMsB6fMY6lyE/kD6ViYkPQs8/pMNHv3RyDFMsnGHClaGPglJ+sd5SmUdVlAP91amo=
X-Received: by 2002:a05:6402:358a:b0:5c9:7dd9:3eda with SMTP id
 4fb4d7f45d1cf-5ca0ac442a2mr2079719a12.5.1729259824936; Fri, 18 Oct 2024
 06:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018012225.90409-1-kuniyu@amazon.com> <20241018012225.90409-11-kuniyu@amazon.com>
In-Reply-To: <20241018012225.90409-11-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 18 Oct 2024 15:56:53 +0200
Message-ID: <CANn89iLzD21j3sQS24Db_YBrd5N2OEAAXrR03g+pHRfTXY5yEA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/11] ipv4: Convert devinet_ioctl() to
 per-netns RTNL except for SIOCSIFFLAGS.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:25=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Basically, devinet_ioctl() operates on a single netns.
>
> However, ioctl(SIOCSIFFLAGS) will trigger the netdev notifier
> that could touch another netdev in different netns.
>
> Let's use per-netns RTNL helper in devinet_ioctl() and place
> ASSERT_RTNL() for SIOCSIFFLAGS.
>
> We will remove ASSERT_RTNL() once RTM_SETLINK and RTM_DELLINK
> are converted.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

