Return-Path: <netdev+bounces-203341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB1BAF5836
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680CA17CB0A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AC824DD18;
	Wed,  2 Jul 2025 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ0G1moi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B2275AE1;
	Wed,  2 Jul 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461967; cv=none; b=HLbtpYlOgRkzFT0t28tDqeCykxYb2zFnOrRgj4LHNTwo/QsE3cmtTLDzjftVyln9JvTZs5CHB3Zsq3XTfRO8wPp9u0Jg2Zc1i3l7NT0kigDZrzyWoInCHrGnh25VsGAaJZn7SEoBNiPPXW1cpLpy5VoIG6jRRtdeei2HapLw2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461967; c=relaxed/simple;
	bh=MgQNz4dEC0SLAEBB3RiBeye3YKmJ4vwfWWZgI0Pp/dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNFCIYWLFy0FUAwGHLXnI6ObQx9kn2ELbVBldca/DmLOp5yG/UrrZUiszKJQYyZdRUMWz5xk700sFF2hBUxhFaVcDHS//KgUO1vOZCWYRunG1XUNcO7TBFFLktPfze75beVw34+u8VRr9gaN6synarsFKXsOu6blxDa7eGs4yHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ0G1moi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235d6de331fso56329195ad.3;
        Wed, 02 Jul 2025 06:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751461965; x=1752066765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAUdGOTuFlPs8wTSiUvt9x4J/6CDUvI907ibRwBkztU=;
        b=NJ0G1moiq3wYfnudOSxzPl2zo7OnpozpxYQW+k3sAafFN+TWSW/QtNdP01e0x2N5p1
         7SRNiJ5KSea4SP9maOV1PmXkDRLbclU7eqCiR94Aju2X0E4iAcMn33UVn7/B/9qbSahi
         wbwqYsc4wxieEGXBCmaIEdEjwxu1cLsViu96jx0UNl/kotSPdr7QC46Y+Ric0AW/tfan
         bg7M9qLexDT0XDeVg5TOtRLCkgbYbq05QL+auXXGBH+sP80S6x/KFoSL0Bb48ejziP6Q
         X9/xe4+vxJ31Rqy0o3aoCCPk5LsLsyGjmHXufbsh3dybslG0FE1dTToNHnanRePhuYH6
         t1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751461965; x=1752066765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAUdGOTuFlPs8wTSiUvt9x4J/6CDUvI907ibRwBkztU=;
        b=iepebH4sxhEGDrFU8XVdWD1wt+z3E/j7N+t6fxk5xcweUEIb5iPhZAugqojcQ8mGyj
         HIsOxfIzLzXo8jD8s8hNDukt+c/PeokfB/rEM6VNSV3i7wu7GhsPhIdcVT16FmMCiaW/
         ccHMJVWoTDXWU7YnQ6XeGXt64JBO7gs7a5u3KO2VbiDEMUC3Cd9St5znrorhfvEDzoQm
         p85vtcU6+wBljSWhTAy2pymRdQYyZm7FOCK4jBGYmf1SpOnpRCzW1K8eV7BGBAVq9R3h
         IpuyGeyL81Z3neO7IgpfRnUDE9Em9Kh0s52NzkRIQpNb5ks18d9LaG4ybSBVr9WPjZCW
         9aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyk/3JWYGI1+toeKkdX9QAYF5HfgLMRYsk4SAGC89WRcfwSJKNPKn+91wA2b0PVdF99kY8flLMtYYlcQ+K@vger.kernel.org, AJvYcCX/t/HWGmRzL7oogT3rrksddrLOTlmIScBUz6CEmNZgn1pJ11r0C+UZgEyfa0FCbx46IE2s8szAtFSbyQgGczQ=@vger.kernel.org, AJvYcCXh8iSJVGn0CuMMGmOYPZ9xceZtoZgn3ptm8UdkjPK8CEcj8u69yBgOI9WKIWhbh5iNzpB0YgVZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyWW+S0GD039pSeEWz3BCt/vS6k6v2H/YiN9Opkm9Qw/HFblKsK
	bp+UqOShQeu8S6IpKe2hRozkEKypR/Ywt103bpyu4JuGJU7mmB3NT2C0WLaQSEPHJ0Gu2nB77XT
	XPOkDqshcHNw2AWvnO/lBZIIZsgDlDRg=
X-Gm-Gg: ASbGncuIcGZVzQjEu2NJBbsiePaNYPOK6BO0pwP7VmDTJngkAZuz21W+uD8sjFTkdbN
	cetVzEi7WA1+vcm7aUq4sk9jiO7L1f26z4szL9ChrWrsnu2XYPfE3vQDooahWqwDP26zwciJdD/
	WNCcxTs3jsf7ySmvH5Vz44kEKUGYZGHsHR6/NQNHcysg==
X-Google-Smtp-Source: AGHT+IHduoQh6O4l5Z18+1AmchmVOhPxqEfTDtzBghb4I9edO1Fehrb2D9vNnAqhAfRg638dUuT+mlQI8E1DGuiG3j4=
X-Received: by 2002:a17:90b:4a85:b0:312:e279:9ccf with SMTP id
 98e67ed59e1d1-31a90b1a2d9mr4400769a91.5.1751461964833; Wed, 02 Jul 2025
 06:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
In-Reply-To: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 2 Jul 2025 09:12:26 -0400
X-Gm-Features: Ac12FXxoOT18Fne-l3qVCdnz06AB2wu9x0tMPmHVrMsBAFF-8F_BAPNqGAZZAjs
Message-ID: <CABBYNZJCsiKVD4F0WkRmES4RXANNSPK1jvfRs-r9J-15fhN7Gg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: lookup pa sync need check BIG sync state
To: yang.li@amlogic.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 1, 2025 at 9:18=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> Ignore the big sync connections, we are looking for the PA
> sync connection that was created as a result of the PA sync
> established event.

Were you seeing an issue with this, if you do please describe it and
add the traces, debug logs, etc.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  include/net/bluetooth/hci_core.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 3ce1fb6f5822..646b0c5fd7a5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1400,6 +1400,13 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev=
 *hdev, __u16 sync_handle)
>                 if (c->type !=3D BIS_LINK)
>                         continue;
>
> +               /* Ignore the big sync connections, we are looking
> +                * for the PA sync connection that was created as
> +                * a result of the PA sync established event.
> +                */
> +               if (test_bit(HCI_CONN_BIG_SYNC, &c->flags))
> +                       continue;
> +

hci_conn_hash_lookup_pa_sync_big_handle does:

        if (c->type !=3D BIS_LINK ||
            !test_bit(HCI_CONN_PA_SYNC, &c->flags))

>                 /* Ignore the listen hcon, we are looking
>                  * for the child hcon that was created as
>                  * a result of the PA sync established event.
>
> ---
> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> change-id: 20250701-pa_sync-2fc7fc9f592c
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>


--=20
Luiz Augusto von Dentz

