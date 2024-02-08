Return-Path: <netdev+bounces-70204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F26984E00F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 12:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63136B215A6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE216F095;
	Thu,  8 Feb 2024 11:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDam9rKJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A056F07E
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 11:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393236; cv=none; b=KcX95vkUtLfuC/yQTSt9+pK04G0RPfMLzeJExvG+YEzHSl/L3SbPyYxO7jbRc4FhumkkzSX78p98Wcd6kgj9Sx962wzPq2b4aSACF0TgSBMG+NIdJswXnWoSaCJOmMG2CIb57MUpac1JZB0bEMN39GJIKxuqcsZOFzPk+GywIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393236; c=relaxed/simple;
	bh=8INX3gXFyPwaJ3xpSmapjpgxEnV//uSzxNdoy7HVzbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfz1s9FUlTfdN8LAMaC7cxfDYRfodgUmdrf4va1XuQmRsMfW632PVReTwTxU5xyPDnaZylNCl/2wlJ5V0o64wktm/nL4u+XAjXhpKowvHpeEM52uvQwy4M11+35Q4FBtqjmvi3VKPIZCiw1aLgmyzuGwvwUQ/lNo6E4LH4Gjfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDam9rKJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-560daf8e9eeso10478a12.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 03:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707393233; x=1707998033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPPgHWrOcFiJp0CCum5RuwERKKwCj2kRr3c6EHzlwts=;
        b=nDam9rKJWdMyyiIseRX+zbNPt+mxhIfDMJdB8vqK0jZJXg8dgPOA79fix3SV1ruR7V
         g+QNQtfUHzAUmYaeQDqMcWqNsOIMyadPZXNCycpUc8/jdknRR+VwvUC/b0LjrHyeH+CH
         10OpFrVvdolN+SJEX46WUKRFmSis9UNE0cy5CE4MEdVtt5aRJdZBfNME5HP6ns81V907
         eWhRUVPuFQ/nP7ZKkkS15PyMPeyHY+gv3wncbHbe1zZS/BIuLNZmDRApuTa7ZHFzuJrE
         DP4oV1c1W0gmpR6qH+Ho67vfk4y30nu7svUmpRH+zShHhrOcux3vCSQd9kyvH9Usmuzh
         rK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707393233; x=1707998033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPPgHWrOcFiJp0CCum5RuwERKKwCj2kRr3c6EHzlwts=;
        b=tYfsysG8hH6YVmw9aOXLcLiZY24hhFnQbCEA/nTAqyjVUnk7K+jY2vxY81yWggPWI4
         3SQ5yXkzNIgvQy6Rt6enrofKyCEEc8HKknc8ASNEKuHi7itMZrzL+gjtY7KDtdE1oOfO
         pCOaqEw+C8hCEjvyZfKkI+JxmERuJtiDmkf6WIWrGLJuRnszksE/HFo1nlUNQt3u4Ttk
         TVzv1tTs2PCKYBeY6SRHR57w7L8t4isDONwcGRkN3I7v5hX3Buz9U6yQSFk87xPs5buk
         Kgy4sXLW3euzMELIcGfj4fUhWTzeLGp9daBlX2nowW01RW4F6E5Ly/gwLNxjzjZjGSlI
         3zoA==
X-Gm-Message-State: AOJu0Yyp3q1+y9afg8n7Hd5WUIQwmAJTpbTSWaZ8lQHDXGyWpBbVPXYu
	PLVvCKQLQ4/j1TjtGWptnCUHdc2nRiiEz8DrVa+ssmW2wqK2EntS7qOevhKM/0Kulk7BjQfgfOy
	rbkVRmL2rqEzAMjo/U4wFhly59yPMzaEy3Hvg
X-Google-Smtp-Source: AGHT+IE1ZF0BWfMjpnK+kkxayZpYOpxO1aMpZMXo6bVXHJjehBLq7ey+fRpVbIMCIz6w3I8hO6n8MoUVa95fb8AZbFA=
X-Received: by 2002:aa7:cfc6:0:b0:560:e82e:2cc4 with SMTP id
 r6-20020aa7cfc6000000b00560e82e2cc4mr268771edy.3.1707393232612; Thu, 08 Feb
 2024 03:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208111646.535705-1-edumazet@google.com> <20240208111646.535705-4-edumazet@google.com>
In-Reply-To: <20240208111646.535705-4-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 8 Feb 2024 12:53:38 +0100
Message-ID: <CANn89iL=-V=f4Kzdi-AdrLXQzLYLi_=nz7eW7tWN-=1XrWnEHQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] ipmr: use exit_batch_rtnl method
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 12:16=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Using exit_batch_rtnl method instead of exit_batch avoids
> one rtnl_lock()/rtnl_unlock() pair in netns dismantle.
>



>
>  static struct pernet_operations ipmr_net_ops =3D {
>         .init =3D ipmr_net_init,
>         .exit =3D ipmr_net_exit,
> -       .exit_batch =3D ipmr_net_exit_batch,
> +       .exit_batch =3D ipmr_exit_batch_rtnl,
>  };

Oh well, I thought I fixed this error, I must have missed a step.

