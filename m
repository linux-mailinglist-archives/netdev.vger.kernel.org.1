Return-Path: <netdev+bounces-68558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 732238472B7
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F897297CC3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C3514533E;
	Fri,  2 Feb 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6M/nLi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC531872
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886629; cv=none; b=CrR1P3+HOSOICX3ayfsszPle+c5W2oZlFv5jt7g2UViPCWTWEopSg4XGPKTzjzl84dFd0Uyo5pAb5PoC3eZZQ+lNjRNJIsj1zsVUbYiryizFkfiGoxpKBzGYbG3v8OEzftdXsWqDkvG32H8m6jpkpJIlZaqBqHU4jxBFNjYWGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886629; c=relaxed/simple;
	bh=n8W9L7Z9Aka9+qA2vZBp1bVnSxKUx9jxFQZFjnPmWqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyUmxbtlbTF1x6Ee2KzaazSBzTShnzAC6IHCjxIWQk4BCwU7n29iytdKOdyq4oGil2c5zW2k7Ipov3Xg7Y06lrpMQNn0FoT95C4eKmI2f0crHUfjd2u+0Ymhag40+oqPULYWyeU77mTMeDoQ6Jknn9DS1eC4KHbbZKl8zwbDzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6M/nLi/; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso86527039f.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 07:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886627; x=1707491427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8W9L7Z9Aka9+qA2vZBp1bVnSxKUx9jxFQZFjnPmWqc=;
        b=S6M/nLi/A/OkRoGNVp8dN43xWtQmzADDUSGQ3CrtVQR+UOwQfzJ9mmq4TnmmKPxSmc
         EEL9dfsqXkoSVxQL7idXfVZxb394LIg4gFxA73tzKZpFJNIG7dlOlk3OWjTXvYT2PoVO
         0oiwfuGKIsHpQ7xIwcWZ7G8WhiU+Oppm7PtuYaoNBS4E3qfcqNg+KFb2bhYGbLRXPrgj
         5T3vUzDPrwsB0AWSV8grUDUx/vngTVmYsPBRhL9BQUjh30Yk3AkPfmvN6w6lWKw4ophl
         qccBp9uldHJu2pnumFLJRhNci+oAxBRIgP0HBfuOTu+Gb/h+clg4NWtUjksKmlZ9C9z2
         l6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886627; x=1707491427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8W9L7Z9Aka9+qA2vZBp1bVnSxKUx9jxFQZFjnPmWqc=;
        b=IO21rRgeXjk7T7+KXpZnw3TbmUKeqqi0Ny+ZDim9G9txw2nmgxLLPpTrnrwhwjU3pJ
         zPwrc5J4R/0h4H+gefADYpUr4s/dZEeHjBqcVv/Wq5JgOrMgQsRsVrq//gvJesprWy/Y
         lGh7mMkJreEHhFaCeRwWklGRJzqJaVnjoYtn9FPwIsmW3HQTsFaCXQFVNmrvUEPUSC13
         kWpgBip1bg5TYaVx6dJX2mtyVAQqPP5bNcOT7gIrRQWNVELLvuofr0NZPZiSJeG+4ukD
         0ey2fV7boIpgjKag+EzB2/k+C6nADuMg1QMexUe9DT2igTbe1mX7e3hcr5puZvnm+1Lx
         lNRA==
X-Gm-Message-State: AOJu0YxEtTRf3sKxF8g1iCncn5NDZBa+7RO8z9UbTEwtue7JbMF5EM9I
	LgChOUQjtlCDjL54YdJgResuyom/nTgZMrmVDllrpg28UU6lAyfl6+8y2x2/meuXhsHbvXNFlE+
	KSex1VTohqlNXUVHLkpylXrofXC4=
X-Google-Smtp-Source: AGHT+IGIn97ttptNkTu/MTtJivAavAr/VxgAI76tSU1U1RJyZZ5xWMTw+kuK0VJY7DhVJ4uPYluvSyPgMXmCts/5fu0=
X-Received: by 2002:a05:6e02:506:b0:35f:b61f:a8a8 with SMTP id
 d6-20020a056e02050600b0035fb61fa8a8mr2368011ils.26.1706886626724; Fri, 02 Feb
 2024 07:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202101403.344408-1-edumazet@google.com>
In-Reply-To: <20240202101403.344408-1-edumazet@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 2 Feb 2024 10:10:15 -0500
Message-ID: <CADvbK_eZg12i3Ay=RKbZ_OjXSMxNK3wfeEdznE1aU2zXu8vebA@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: preserve const qualifier in sctp_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> We can change sctp_sk() to propagate its argument const qualifier,
> thanks to container_of_const().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Cc: Xin Long <lucien.xin@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

