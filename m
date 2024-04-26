Return-Path: <netdev+bounces-91561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3E38B3117
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63583B24742
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4AB13B2A9;
	Fri, 26 Apr 2024 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1nzFXP6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468B13AD33
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115438; cv=none; b=eBZQGtSdyfXOiskItjrpJcJglfgHIIZJnaflbEn8DFtwuWTGFOlM5Eld+jIhHv8uHf+JebrHr1H63DQ1j0rHLdxr+M717zT1/P3yQKx/b6PTs2LvJki8DZtzJQ2F3bXp8nuNDotmcPzNktdZqeqzyaV2RmCxmeyi1y8304amfNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115438; c=relaxed/simple;
	bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULxN2U7DGvqJuAIMoqIpE0c5Im2RAGVnL+5H7641iuf8iIyQRmq/tiHFwpk2WfTGnayGHic6GPcwtUcfPHIJ5b29kEM5KXisr351zB60s6OhsSguXT4gdZWpnqmGUarl25BRLaWNgvp2dYcQgjpOwKer4RZAHPRpyRbAqBZH2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1nzFXP6; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-518948e1ec8so2400e87.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115435; x=1714720235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
        b=V1nzFXP6Qc8Ri5JkSMuMOxlH2DEcILCGuV7Z0Ip/YkwZCySI5Zv80HJ0CjS/iHLQ+s
         yYzPRacuQUQZtbf26qcfbUjIK0IrBer7iXf1U1ZsUIu+XyC2+A4HDoVoUIdPBUkqg3mL
         9IozcjxsJrmYxvpWclXpYqTYBOwAv1Mgw8qvwiX76Ih2SA/84dgxatUjI0nALUvYkWQb
         D4uiJ3zWlCFtIjXo66VLxNkNWMcrb5o6ylN/yix/1fIXAfwKFLXjqFQg75WSEhaqPcuw
         6m9i2ci1OiI2ozowsNmFLyiiu5bl79XbX/laruOuBQkR4bizk6U8ezBbpycO5TiSFk/Z
         SdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115435; x=1714720235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
        b=dXYgBjfTTkXvive5AONwbiuFZ1tYo2s04oRd8LeDsBlWoCKtZT3h42bBx4vVLjn3Bu
         EcdEWjVhsDVklIOPiuAeq4bq5m2owe8BjbDb82DqQm0wiqWsiFsval3IbxHuMXgsvBDh
         TuCQKOja9/9HlbMUAJ8tHbbw2FEQF9mVyoW3+NgB6n57AInKM9m1SJCtppgThHg36IZ0
         N6XIyLujyd68Ie7dx5wTtBBQ5dQIOzme9HzQ0hQJi6CujWJSahEvztvpIR/t7xkhXYMu
         a/hoQsLLi6B/bwqit8CHewCaaVeDwHbsk7QTz373dkIb38IUmw48/xu2Yr7ssbrIMOdt
         L1FA==
X-Forwarded-Encrypted: i=1; AJvYcCWfx932xbMXW2hmvFsyPurgph1bXAgWciTPURMI+IvTD0nKMaQroMKEwHyCiv1ZIxkB6SRRU30mpq3d68FxXqoa0zwMZ2Yv
X-Gm-Message-State: AOJu0YzO4UOU/2sa2NQ2w7S0s5zhZg/5Zvm4Bz/sB53wATOvdjZXMF44
	nb/+VyvzVlaWC/PChNUucX5PI0anifjYA5Aww9fM2eqZs/aNGVnOmqYJkhZNBnsvAYsPP5u/SqQ
	pa4jPy77wWspebehZfpDe8R82ig78mbsTilqp
X-Google-Smtp-Source: AGHT+IFLgpcyXrDmw4mPYNfyBndZ+UooKXi1ffmkUY+z0h851PXJpHkoqiepekOpKxRIe7dBf7Vsq7Vu2v8cQmWJEz8=
X-Received: by 2002:a19:384e:0:b0:51b:badf:a650 with SMTP id
 d14-20020a19384e000000b0051bbadfa650mr87566lfj.4.1714115434548; Fri, 26 Apr
 2024 00:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:10:23 +0200
Message-ID: <CANn89iKbzuPGN=M4YcE5gFGBXDR+DrDigf3E7FfGSr5ac8u=WQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/7] rstreason: prepare for passive reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Adjust the parameter and support passing reason of reset which
> is for now NOT_SPECIFIED. No functional changes.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

