Return-Path: <netdev+bounces-186796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC3EAA11B2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 18:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5693B2DD8
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2FF2459FA;
	Tue, 29 Apr 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="a4FKzEKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E324500A
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944739; cv=none; b=tvYe8Xk7VlCYNbDnLUNA7UMaWJj2jDQRhhihDAIrSp2z40Jka8awWW5PxsJbFG/Bm5KrY39wusGbrN+q5H31W2QzK71aGoeUH/vw7kcXjQdmrmBTNMIxNZsZQyXi1gU4Jr/RCmeECJedjSnq7W2807jViwOQ1JxE01q8aZ9RxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944739; c=relaxed/simple;
	bh=hR8Y+nK0cX/CZdCBzLn+W3sfxRoUxjFKeCQdBb+BaYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGMmC7bPgFK0OPqd5jmIOyZ15Cn8UmgLH97GMx8Fe76HrbkmlSWIVM+d6qmNBFu21FPm5OhZDvRM+lbcyc0O1gbuf8vxbVvF3U3HoSdZU7ViFenSq+RnPzFWFS7UVK7ibhbXq56x1qFOe8gIaKVKpXxwgM55UCWaQB73h7Oa/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=a4FKzEKN; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e730b8d934aso4671230276.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1745944736; x=1746549536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKJPPGmtZ4Q4FEXLrbVF+XChkMZLyTXErk0JCwdy/xQ=;
        b=a4FKzEKN+YLks3QNu8GVGLGXipONF0ukBLVeDOqGDULOPB8dCvDeDGrOrnG2RF+Hbr
         yj90RDrwwu4hbJr0gZpboNQ6SlQ1zmGb/Tj+8KbTvpeG0HhlV0AzKjtIxG3p9pFcFyTp
         ifIAYzatPar1wSeTyGSSSr/NGndkUv9h4DG+tSibE0LLbjDpvGtNL3n1FhTPw8PYIYGA
         ltEM8zccIR10PxRsidosJwORNXUeRMb0vFCFzaXakK+eYN2UMH+Fa/RBVpgbZMqZuyNO
         T/7ZwWvxkJUCihGYXtlNRY2V2a03DMeuEPDaWouoIeRKqaxY1ily/jHzf8a8vNuyVUUn
         cypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944736; x=1746549536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKJPPGmtZ4Q4FEXLrbVF+XChkMZLyTXErk0JCwdy/xQ=;
        b=AWUO6NGyyAayx95iGKszUeB8WCn6hI5njxtjllWMTxNuQXZMatDmPsRYxjaU5YLUuH
         dWp769XitlXIcEyfMVgB9Zx5H+5Uuyy+FsWswp7Y9/4bvb4BEx27zWD1aH6SA15UWbLy
         r9UGzmyMzErRGrTLUkVWj4xAguyrxoevsT6XX84nltMUa9IBdyFeLH+A6Ue+ILxhD4Dj
         8y9ZGPXElpt0Lnpn8tXW9W+HJI76pfSfCzTnsHiBnjKH0/yff0U79VaLxG8UGP8B4kt3
         IFW/tKeA1MibqPf5Pks7Y2TtAcfgNZic4ertmWq5bhqVggKS8pQORiEjZ7RJ1x4XRYff
         3sBA==
X-Forwarded-Encrypted: i=1; AJvYcCXH2ousWzDZJMZyz1Rp3VbitvoCUVOKzgB699zg5y5KpGwnt9M37/vNeINuO3orPOZcKTOFRus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRGtSKL9YcT1EjWe7NtKtvBNc2PmVgPd3JtBdTBbWSWgSSrqyk
	GOrEODegSy4NFyo9zsuoSxBazD7g2NNUkM4P31e61+L8FvqHBYXGqB2+E1gNNmICo9XJNSlWibM
	KviqOooaQSmLCI2yIYJKOrIU7w24vWEn30Vlqxw==
X-Gm-Gg: ASbGncu/uxjGXtay/aQSEV2EN7i57XQmIvrXt65GooVWtng37gdIMPIjcHSTkrkqr6L
	S4kZ11H9v4qVv/B500xPo8koqdp84MbKQv7sXNrEUPCHZ8TbWvVCozqhlaptxq3XG0xYhCSaU8c
	uGKGqHNE2G8rccEkJPO1WgnOpYAB4PfPI/oSjrfvbG5OXlvtEvcRQ=
X-Google-Smtp-Source: AGHT+IEBBaq5tsglGxhuINvv6IZSxaRI9dE1eDAka1Xuo1qsb8GlnVfNRulVXOsQNgsWdqejnZiq9iGFOJQ10Z6pJ+o=
X-Received: by 2002:a05:6902:154a:b0:e72:a02e:a797 with SMTP id
 3f1490d57ef6-e73511f984dmr5201544276.44.1745944736100; Tue, 29 Apr 2025
 09:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
In-Reply-To: <20241107125209.1736277-1-michael.nemanov@ti.com>
From: Ezra Buehler <ezra@easyb.ch>
Date: Tue, 29 Apr 2025 18:38:20 +0200
X-Gm-Features: ATxdqUHV5CP1dNwzjt8THrj9C95bgv7pJhkhoTGKgrCVvTrrD0jY5bAxDeZ-Gnw
Message-ID: <CAM1KZSnvDqUHd2ENKyaZc=WyRgL18TrsF766_ZJVeeAiPth+Vw@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] wifi: cc33xx: Add driver for new TI CC33xx
 wireless device family
To: Michael Nemanov <michael.nemanov@ti.com>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sabeeh Khan <sabeeh-khan@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, Nov 7, 2024 at 1:51=E2=80=AFPM Michael Nemanov <michael.nemanov@ti.=
com> wrote:
> This series adds support for CC33xx which is a new family of WLAN IEEE802=
.11 a/b/g/n/ax
> and BLE 5.4 transceivers by Texas Instruments.

Thanks for going through the effort of upstreaming the driver.

We have started looking into the CC33xx chips (in conjunction with the
AM62L SoC) and noticed the following behavior:

# curl https://speedtest.init7.net/1GB.dd >/dev/null
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Cur=
rent
                                 Dload  Upload   Total   Spent    Left  Spe=
ed
  4 1024M    4 42.4M    0     0  2358k      0  0:07:24  0:00:18  0:07:06   =
  0

After downloading some megabytes of data, with reasonable speed,
something seems to lock up and no further communication is possible
through the Wi-Fi interface.

AFAICT nothing is logged, however, when I unload the driver, I see errors
like:

[16590.256433] cc33xx: ERROR failed to initiate cmd role disable
[16590.256446] cc33xx: CC33xx driver attempting recovery
[16590.256455] cc33xx: Driver being removed, recovery disabled
[16590.272950] wlan0: deauthenticating from ab:cd:ef:01:23:45 by local
choice (Reason: 3=3DDEAUTH_LEAVING)
[16590.784390] cc33xx: WARNING Unable to flush all TX buffers, timed
out (timeout 500 ms
[16591.296388] cc33xx: WARNING Unable to flush all TX buffers, timed
out (timeout 500 ms
[16591.808379] cc33xx: WARNING Unable to flush all TX buffers, timed
out (timeout 500 ms
[16591.816792] wlan0: failed to remove key (0, ab:cd:ef:01:23:45) from
hardware (-11)
[16593.840379] cc33xx: WARNING CONFIGURE command NOK
[16593.845172] cc33xx: WARNING tx param cfg failed: -5
[16595.856352] cc33xx: WARNING CONFIGURE command NOK
[16595.861159] cc33xx: WARNING tx param cfg failed: -5
[16597.872323] cc33xx: WARNING CONFIGURE command NOK
[16597.877079] cc33xx: WARNING tx param cfg failed: -5
[16599.888317] cc33xx: WARNING CONFIGURE command NOK
[16599.893069] cc33xx: WARNING tx param cfg failed: -5
[16600.400303] cc33xx: WARNING Unable to flush all TX buffers, timed
out (timeout 500 ms
[16600.912270] cc33xx: WARNING Unable to flush all TX buffers, timed
out (timeout 500 ms
[16600.920388] wlan0: failed to remove key (1, ff:ff:ff:ff:ff:ff) from
hardware (-11)

We can easily reproduce this behavior on our ATMDS62LEVM board in
conjunction with the M2-CC3351 card. We run a Yocto-based distribution
(Scarthgap) using the latest linux-ti-staging-6.12 kernel recipe (Linux
6.12.17+).

So far, I haven't tried to dig into this deeper. Any ideas on how to
debug this further?

Cheers,
Ezra.

