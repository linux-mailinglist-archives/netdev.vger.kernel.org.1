Return-Path: <netdev+bounces-213043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D3B22E7D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC7B2A33DE
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25B2FA0E9;
	Tue, 12 Aug 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+uXnEM6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D2423D7E3
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017924; cv=none; b=MhhkI4Y8oLRiODuHA9bmOnPcIW8Sh9fg3beEuRChDtBC4bPeCJMqWB8L1b/pW1rJkIwmblVrWavBd8uAUfiJzS2GCUCY3V/f+KRw1DeQfNNry4v6/pDvj5egKSvUopCiaayFKe8S917vVgUIQILec62vFDc5GioGNxb0KF5jero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017924; c=relaxed/simple;
	bh=Qy9oS0z+URawKAcMl/2Vd9gSleJAKrBFL589siNML9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+9mZGX2iBkTlYk79cDl7obkiLmxIf0j08OSsb6a4s8SaWbGaAxZkNOmj7a2uCCfCPE5MrpsL0hUTyv8MbPXKTaGvFbG0LFScs2TjPvFZFUAPPqY/GKCmzvq4M2cJXX74vxWzYveGG83Hjj861/9uDojNy0kxROgSrJOiqHxcU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+uXnEM6; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55cc715d0easo377e87.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755017920; x=1755622720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy9oS0z+URawKAcMl/2Vd9gSleJAKrBFL589siNML9o=;
        b=g+uXnEM6tpzDUt1p63ATLoazdFNurAWHMkp6FPZ5ukVKYeir59mL8iFiH9ycSzC0Hs
         NCIhWWSkVXm2F0VN2BA7Gax9STclrMIz5mdP5eJE5e14pGRty5jMnBBaYULgwXiLQt3c
         Trjpn355ZiFp8PZebTHBFCtWJ0xHJtOSPrLCpQGPC+tPK5bIwMQrVUhjJ9m9hknY4zYi
         4qbv2r7KCHqrerWRKmKTQ9aQ3Gr4PI12guCobwQlH+iKQpSOIixwgKLCdQiXP6qOaexY
         /GUZXHOpVcAzUMsvm7IhR4ZdzSN/bGgMkDDeuqObVlymfuD88FO+Gmx/1pzpydH7XHqm
         fg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755017920; x=1755622720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy9oS0z+URawKAcMl/2Vd9gSleJAKrBFL589siNML9o=;
        b=G/iIerUhZLYys+syH9RBCD6xkxPlH0tNUTw9RSeW5gsOao9h2DRme/R7JyPFIP1Sv1
         eNK+JbPvmMY4dMYiqFkQogC4CYfRILhINJCcTGVX1Oq7VCPAntEqzGt0Z0lroXNBs9j5
         4Vq7p574rxBb6ZoeMxcBRZ2PKOeaJu8bLX1zih1unqN48k8IvT5vZvVRzV54qDBFcPP2
         e5Jfg4FqkT2BtVACesZXb8nP8w/9opTeS/LbUFsWj297WznUHz/YvMFK7CNchaHyDEzS
         bU2J4zuHaLtDOGV4KpCj2kCazFHN5Dco5JEjQ4oL4uBvlgxvsG6B7aD/bRnb5XVsDRLD
         esVA==
X-Forwarded-Encrypted: i=1; AJvYcCWBCFNNbhELlmI6T2WVYq14Crdlao6jyPm00hNHOFK/Kd1DHGsSmmIr6zW12KTjCbWcy8IBO7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6FH8xnTGH5fL8t4jJLO0RfOOFjzFM1tVEQ+jI4alM+LloSJj
	GtI3mz+IWf4GUiaGOp+HlcNAXmV1P3hPeYXQzHEcQ1ocM9Ltg2zWZ+2XdZMe64QhaR2i7nytusM
	rG76H8FHTrEqXSkCTp5m6b/eEyQFRJwKLm40giVWH
X-Gm-Gg: ASbGncuQ/FyfIao5oWUwDTgP6U9YnWAGWF9ClxpP9hrwUsMkBkqBmChgUHyxBmXwAP+
	881fldRUuFC3M1MBx1kJNRB4DLif7cRctJmqR7R7e0FADlZWm+vnglqgQepyMo9wFogSErQS8K8
	avmEcUwG0/GL3T4f/tu0kAZCE/46nLPdBInj97oXgtnV4tJF1r/lpb+0jTQqGINL5/xIjmUh9in
	X1HwavWqYc6+E5bVnyrbPk4vp23xanB5a6bbfNr9QhW5FDu
X-Google-Smtp-Source: AGHT+IHFO3hu6qLIYD4pNak/e7/kyr5MizAqIZP39928lL/DShmP8FSt4bKE2xbS7kM4+Wzc4y7I1WoLhK6H6m2xWlk=
X-Received: by 2002:ac2:4e8f:0:b0:55a:2d72:de56 with SMTP id
 2adb3069b0e04-55cd9c8e601mr248681e87.5.1755017920305; Tue, 12 Aug 2025
 09:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811231334.561137-1-kuba@kernel.org> <20250811231334.561137-3-kuba@kernel.org>
In-Reply-To: <20250811231334.561137-3-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Aug 2025 09:58:28 -0700
X-Gm-Features: Ac12FXzgFjbwrj8oRSzZ5U6kExdIoKfRjmESYbnIZDyNVwm10F_iDRcuuAZxx_U
Message-ID: <CAHS8izPOYNyj7v9ZaVC1Z_+pZhHGjCLjFCK+55i_zk-VPrP2Tw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/5] selftests: drv-net: devmem: remove sudo from
 system() calls
To: Jakub Kicinski <kuba@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Shivaji Kant <shivajikant@google.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org, 
	sdf@fomichev.me, noren@nvidia.com, linux-kselftest@vger.kernel.org, 
	ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The general expectations for network HW selftests is that they
> will be run as root. sudo doesn't seem to work on NIPA VMs.
> While it's probably something solvable in the setup I think we should
> remove the sudos. devmem is the only networking test using sudo.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I suspect this breaks my test setup, but I can probably figure out how
to run our tests as sudo. I can't argue with consistency with the rest
of the tests which don't sudo anyway :D

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

