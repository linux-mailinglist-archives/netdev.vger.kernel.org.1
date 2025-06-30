Return-Path: <netdev+bounces-202435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDBDAEDEE1
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA304003DC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1B148850;
	Mon, 30 Jun 2025 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE6ZrdMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45B39ACF;
	Mon, 30 Jun 2025 13:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751289496; cv=none; b=UZwk6SGd57uey7junHePXmWe6vnqtTtBvgsn2MzMx0T6FtYF7vEJ/gal2DVgQkb5WnkRjT5uMobkSnbfP5gd6iTc1b/J37QgFTR2iwvH1RwiJKGph397K7qfgt6/3g03Pd/MyighmngKgoRzFvNQU1IuuDuxhRBwsqQRRK0KSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751289496; c=relaxed/simple;
	bh=LWtl4j1jLq8PqQO/Pjn8Neb7rM5FiqI9Uwfbvbrse6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlCV2kN3uNR/klKdktA2wDHyJN7H5RA49qPprGYxIexq3BwJcLteQSiFdvBngtwKh5Ukq/8pL5Xv5FjeM8cUG9CcRsZIjLDV0FPWgdc7MzyARUMo0KCNAmPIvSOQHXXhmUx+FIlLzK5jXrU9I9oyZ+TdUS1wK6Fe4G9ueM9S61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE6ZrdMj; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso19488931fa.1;
        Mon, 30 Jun 2025 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751289493; x=1751894293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNOIh/VXRrY1ezaTWJtZc13yn8Bcesz6/VHThRKHEao=;
        b=AE6ZrdMj8waQiU6B0q8emmyFwTsFSfkT3hCljcpfvNiFYdyDCtvxUgpsyu8cTC8IQr
         MdtBxNPg0fdylTVn0Vk25HVSH6IySfmKSgWkHKJvGBEqdB4Wt+kvE5/W1nnvJ9ebLaCT
         1NQ11rrqoP7rAFuWvLy2iv+2r0qC2ZU5hQW7a99JwDmNmdGvXZZTq7mbHPFYNcPPOft6
         Rg6olpTfKZ4V/oq7XO4Lha6qHba5FWbaaWBxnKCQgUCKCIEoKaSphTgqdkJnIABIwoFD
         TEVh+6QdVrvAOt3WdHc0OJ2QO3Baqp5bVei94ZydCHgGXsiw1kcYsc3D/RUu/bAsih8Y
         HfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751289493; x=1751894293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNOIh/VXRrY1ezaTWJtZc13yn8Bcesz6/VHThRKHEao=;
        b=TgYQxMNqHuftJh639DefgiarU7WoXwadq+By2tuMgr0GqDejou4LUUs+P2GDpUXxfd
         Y7hSXCS7vHIg4Q/hDywwTjeyKbS+NJZUdoJksdF346NUYLg4WCY3S+wbO8C7GVQvs0n6
         oT1eApO0Tld8lZ2FPvwNGZdC8fuHcnAizpGWOUPVSXbIP8se+alqNDSXu/V972t3TCeF
         M6L/rq5xV36W2lY62OEsjqYQAB375FPilhK6xfKAtKNFDnEsGyvbJyN+pLl0ACItCjEr
         IUrGnp29VMjQOkR2AFiMfNfyg8eZtS27W/0oH4rq+jHJ0Jqy+X8Smj+HkdcbItTdU7bc
         BQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrMKHX7pzNYqijgtKjOnyRHYKUQK8hlU6WH9XuczmCxZUHPkiSoTyg12hfAUedwjXe/4y+nHn4Qg5WX4hB@vger.kernel.org, AJvYcCXBrsw+4MI9RmPshgI2cqeKJnXvNOEGtCz5Nk2h84J0Zfxy4n4D1ZnQev0g4+7UHzC91ZdxE2ceEj/LqqE0+c0=@vger.kernel.org, AJvYcCXhjkenW3DzBP6Pm/qn+K9X2ac5xVhFsCJYEhSNRhbx93d7daSMIHH7UDmaMm4SzV/5h/WMfTgB@vger.kernel.org
X-Gm-Message-State: AOJu0YwF20ZjdCtM2XHEKdgSczUc6P3+PmVaYmKjNjuA6KqwSm4kjpSC
	O7tf8epBLISPWhXWS0q1qRQktQ+29hv2X0+b4DS3aIB0ptowFwk4C4B/lj7PAXkag9wsfBcSTsS
	A8TIUAYiIM5JENuIwDxHDnFfzkkree2guSs5h4O5DvQ==
X-Gm-Gg: ASbGnctO6F8AJa90/lbnPWt7QhpAMMRg/vQ/aP4BJfzdYfoOOnvzOHmWI+hQEAP4WAn
	cyrsT23IxCSg2UgOgdSwIOsKDQIF6LfZPgvUBnXtYrm1hK0jviKjAg+eXB7lCrI7eAi1YQcs5z1
	UyPMVaiMP69mGVNphzBstHZ0bNI+vkvNP0aQbNiDBmgg==
X-Google-Smtp-Source: AGHT+IHhLUgvQS1IRJmj8+Otz83kPT/LLtNEeqAfUEV7kfIiVy9AOTSEytmM4leWmVTEB8xHQjE6IdmVDFlW7HLS3Vg=
X-Received: by 2002:a2e:b5dc:0:b0:32a:7332:bf7a with SMTP id
 38308e7fff4ca-32cdc49c5c6mr29479231fa.13.1751289492559; Mon, 30 Jun 2025
 06:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630075848.14857-1-ceggers@arri.de>
In-Reply-To: <20250630075848.14857-1-ceggers@arri.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 30 Jun 2025 09:18:00 -0400
X-Gm-Features: Ac12FXzbzgUbhSp5TkUkjZ7zN1R4I8Snqjim6k2-2dTDga8J_iuSbxQCjWfkEFY
Message-ID: <CABBYNZK1u4G3ZTH_Z+aPpDkGLoLj-1PhnRCEmwHEjLjLXAD=fQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: fix disabling of adv instance before
 updating params
To: Christian Eggers <ceggers@arri.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Mon, Jun 30, 2025 at 3:59=E2=80=AFAM Christian Eggers <ceggers@arri.de> =
wrote:
>
> struct adv_info::pending doesn't tell whether advertising is currently
> enabled. This is already checked in hci_disable_ext_adv_instance_sync().
>
> Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue=
 set 2")
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 77b3691f3423..0066627c05eb 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1345,7 +1345,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev =
*hdev, u8 instance)
>          * Command Disallowed error, so we must first disable the
>          * instance if it is active.
>          */
> -       if (adv && !adv->pending) {
> +       if (adv) {
>                 err =3D hci_disable_ext_adv_instance_sync(hdev, instance)=
;
>                 if (err)
>                         return err;
> --
> 2.43.0
>

Ive already submitted a similar fix last week:

https://patchwork.kernel.org/project/bluetooth/patch/20250627163133.430614-=
1-luiz.dentz@gmail.com/

--=20
Luiz Augusto von Dentz

