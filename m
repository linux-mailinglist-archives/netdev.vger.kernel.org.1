Return-Path: <netdev+bounces-79917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0987C08F
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7551C2086B
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6971B3C;
	Thu, 14 Mar 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsVQ06hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51A70CDE
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431047; cv=none; b=oag9OzXBU2jIJRVmfm+Y4n7cLojqA/qfDxfdC29mh09HBYVGBeeFaXDM3b+fDIMcvpxrj1eUiB/c6OvMwGjAf5M14AqGCciZWQ9/l38EYecllntpJDRGWqrcpozBbIeLjUVyCbSWE1F48dWXOXLYHI8EuXXo9A08JKQE8dXZDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431047; c=relaxed/simple;
	bh=T9fUQ6jf27iqj+w09bVD5QP5CkMdzHxyuBlN+SxIKzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRXno5cR/OBw9gmm3I37X6Za6yhdPVObUdsia+zAL/JqEiQCm/65GK9Lo7rmZFNdipp2EKln0yTFSeYc5fzNvLNISYt7vhyVRaTpB56k9tnZ7OvLGV2WLPKubAOFSsl5/4ygLuwWXYhcUMUjouhP2vfgqmUDD2koDwSC6dmyTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsVQ06hu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568898e47e2so18576a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710431044; x=1711035844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJSgSDZJ8L8fadItbrXccdSSsXk5qvQttzRofRmXtXE=;
        b=FsVQ06huP9NCI8JgwZL9jIqCFEfT0wsKr5G5kBSp5nYsddKtA8JvXSFPc3wEOHV9F9
         VXrJmol3ao62uUOjdHceAhCN9DfO3XCNF48XpBr6jyFaM/xUI04Iy+o3TEk5/aIZGmeW
         soCAxIUfO76mYBoBWY14FADs/SYQ0Pu4+0XndQSVbzbK1t+GHAJFBnrLhxAAjNjPg+uX
         TMJgPlW8MHTqpfCwmk3dBmANVcrskXc22TKg2FvEe1Dj8kD7snWOAzmvGm63SToSSs1O
         jbenEAQPWQ3UQ8qPGmA8B0Gte1JMd6vvbNFnZRfsC9WDPGEkZxGYSbyQvgMNGOk9frkN
         Ox0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431044; x=1711035844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJSgSDZJ8L8fadItbrXccdSSsXk5qvQttzRofRmXtXE=;
        b=jLJP80eTnfJ9rlMY02HtMLRIfB6PUlt546oqCOYRqVNMsu74Dovx7ELOBKUiM8MXx8
         s+eJdor/55CskZUl1tVxObhUTT2x0VSjFfweHoIRNJH/aD6TPSiUhwpZ+j1IU+vctbj0
         Q6n44WygAudaaAc2l+iFgcUlf1picGMTIsDTvA8ZvE6WRx+yIsQ0/GbR7YmSSx+eFAeF
         6x4NdpW7r95g4lTL3uL6qIU8IF67TGJHPtQIBMC0/76AMmVVgIePlL25tpur3JE2LI93
         2ROq0/w6oGWWL4Geri8AWUq7H6INWA5MvrqgpJvvxjZ5O+wsQN5F0y9lWpPLa6rZb7gy
         YWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG6JIHSUnlTzXm4T4aTyglREKJGZl8nBljEN7OLsxsLqIieS6X69khJJNZy/x8Cz1+Kw4QTOBYgAJmFy8nkXNweOAoZ4zK
X-Gm-Message-State: AOJu0YxXwYNUWmZLgivO9wl6rOKIAUcf8IwEo66o1Ze7HiyRIjAm/PdN
	LUX2iTBmk4ywYjl8Q9dVBTdwnrLBftNu8eYwX4we2s79hiyS1dU5D+o87Ir1/OV9LV8eYCI5ehI
	iIeoBf9WbVXkNb7XnMI950VsuOn6OZjC02GL0
X-Google-Smtp-Source: AGHT+IF1gsbPqUWByeaKHKHhpSEG0QbcA0cyNl1S315GkokJKPdkFLH0M+wqnWDNsMi//scCDuW8QiUhPdwMqbjKdOM=
X-Received: by 2002:aa7:d905:0:b0:568:551d:9e09 with SMTP id
 a5-20020aa7d905000000b00568551d9e09mr193817edr.6.1710431044420; Thu, 14 Mar
 2024 08:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141816.2640229-1-edumazet@google.com> <65f318db70f3f_3f8f5b2945b@willemb.c.googlers.com.notmuch>
In-Reply-To: <65f318db70f3f_3f8f5b2945b@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Mar 2024 16:43:53 +0100
Message-ID: <CANn89iJVrZ0bT2V0VkmhNnfe=uOruOMWvaya_WcNe-JmtAJSgw@mail.gmail.com>
Subject: Re: [PATCH net] packet: annotate data-races around ignore_outgoing
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:33=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Should we also include a WRITE_ONCE on the fanout prot_hook:
>
>         match->prot_hook.ignore_outgoing =3D type_flags & PACKET_FANOUT_F=
LAG_IGNORE_OUTGOING;

This is not needed, the variable is not yet visible by other cpus.

