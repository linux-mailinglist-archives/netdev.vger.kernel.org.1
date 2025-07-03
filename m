Return-Path: <netdev+bounces-203828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF87CAF75FB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C49F3BD777
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691682D5418;
	Thu,  3 Jul 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6lmP4xQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A92222B4;
	Thu,  3 Jul 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751550161; cv=none; b=d0dTJzINGbEl6or8AbmRs3wN3TgjscAad10wW/XWyNlERB83ocPrTogx+yNqBv3TFN0mtmPqS9QFuPz1f1/YIOAiWacx+mHey06TaaY2xGnoq0IdjtR/CwAfqd912lDMDTiWyr9EukTBBDk8XZ16G0XVlMMdEAivGfgKNRkUWiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751550161; c=relaxed/simple;
	bh=tavQcEGaObxidlIkQzXjJ++BUyUCiEeX6N3ES4TeMI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFchWEMClkTVod/TmGQbYfAg3UDQlpRxLndw5G00XY1vaJDMCxY/bHrfUBUktAj/4sVW2ty/xgtTZqhtRm0BX4FX1Jj7lmTAOXb6rgF+UF7TBNroQvTLzoYyVI50afGoyO/0TAe6vpwtNLyAFxkZ07CrmRNoCu6M5LP2okSueyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6lmP4xQ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b553e33e6so48826361fa.2;
        Thu, 03 Jul 2025 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751550158; x=1752154958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFNqw5vvbvpKQuxgS3RLj0oHSG6zw8ZBvyqT3A0POSI=;
        b=A6lmP4xQ/aTs5EFT/hOOPjMgwYh2GZmdDeL/3YfgTyTY+Vvw1CV/jgoWF8aWdZAgvW
         BroDq21ROcZw6uHxrjyTnmIff/u1sURMI4QzS1u71CcdSgKsyYyykpvPBEh2AYVKonWX
         vxVBYNLWi028IEefl/OcoM1W3viF9Xo19um8eUS5W38W9Rt9RLPwRJz8WFNgNVMGftmx
         rxSbBO7HWMWrKhE2tWKvm4h4S74ZHNCSgeoKwx6EAuBxA7B3Oo54yyXodmZaCANxfHV1
         FBuR67O4bcdDopXAYn67yz7UeVhHUi2DXl9PX24Vi2fT3J6tjjQ64DOUEBb/thlbbkIU
         /GBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751550158; x=1752154958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFNqw5vvbvpKQuxgS3RLj0oHSG6zw8ZBvyqT3A0POSI=;
        b=RQ1OuBgDMas5dOXHBkINo9ndUqZKOI1nSdFzquYFZ6XFGfd6JpZhJqY/XmIJ7Vgxpe
         X32x6b5A5KaOfBE3ogSh4DCvqvwORZAAAA6DmM/a1H4bEKKXeDMYg+LfLFLIfh01LMoP
         7VAzOrCnRjLeNtge6IwmThYw9kgi0Cnvy9SXyn+CroPYfHLBYvG+ywSKG+yI2M7LEV6q
         FiNhwa3oxjM5cRCNpteIIcySDKuWpaCqhByYcnckAtNz8Rw79W/zFX5Fk7QM0nMH4Hpn
         2wsSOYlywUnx36Xzv2DUc4YlugnDlMUANMeYgDhVyz/sRu8LNizJeMrJtmSBnHm5q5nt
         xZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP57BGMN5QJ9jNn0RIvSjZkZf1H16Q1CWCRQHHQpMNcy12DA574dh15F746tpu2tDqCaD5ll13RDtYQWNMjNI=@vger.kernel.org, AJvYcCWRuiEjvI73Jog1/dia8Ah+z+ayuElq1antPI75LG9SRUnlkQMymzycrjeooPSLbHky9ZtsmB08@vger.kernel.org, AJvYcCWf658de3A2si8z75716UjCpV+0X+M9Qq78wxjjbH+7cT62uebf4kFt8FuEhfGVCOtQemYq41pKQZDTZy0q@vger.kernel.org
X-Gm-Message-State: AOJu0YwOaZJD04efkxK0/7oDUD3eegFaTHmAz7vxKsLkMC2clNfevLQp
	v2Zdj8zj/CrWd5WTNgrdzM1Jiq8u44KEmipuFK7faFDnT43/tstyjd82UBA7tbJ5blnOQJL+SkG
	ruHeJvcVvuM4ITfDGHd/bLanEZ3eUK+A=
X-Gm-Gg: ASbGncvGdzHmXpqJHkaGHlrhtL+R3XhceSq0zEVdEtt/a7lNc3/IXHyGwrgYxy/FO57
	ibWWCzLMQiFQK9uMnmwjupQ+Hg1frk0RRBZzVFP39o3mgOpGeTWzf7hnPwL2DDckFbRjQQA5yZx
	KQYh0JohGGvU3m4KG4lxqVyDDPewTBySZqNt1brzVDHQ==
X-Google-Smtp-Source: AGHT+IEJwE1g4YnSLqje9oO3w/5JCMMzalfAYURIzR+idPnMXcOc8GmRto0P9wd9n73uBaY7LwalrXFGw49te1yx/Y4=
X-Received: by 2002:a05:651c:4001:b0:32a:651c:9aea with SMTP id
 38308e7fff4ca-32e0009ad64mr19007641fa.34.1751550157391; Thu, 03 Jul 2025
 06:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250703125941.1659700-1-neeraj.sanjaykale@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Jul 2025 09:42:24 -0400
X-Gm-Features: Ac12FXxaJZkUcMMuvEfhaCIQVNH4xMzK0iXdJhhq4GoOYF0l2cqU-Les31hBC0w
Message-ID: <CABBYNZKN+mHcvJkMB=1vvOyExF8_Tg2BnD-CemX3b14PoA1vkg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Bluetooth: coredump: Add hci_devcd_unregister()
 for cleanup
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, amitkumar.karwar@nxp.com, sherry.sun@nxp.com, 
	manjeet.gupta@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neeraj,

On Thu, Jul 3, 2025 at 9:17=E2=80=AFAM Neeraj Sanjay Kale
<neeraj.sanjaykale@nxp.com> wrote:
>
> This adds hci_devcd_unregister() which can be called when driver is
> removed, which will cleanup the devcoredump data and cancel delayed
> dump_timeout work.
>
> With BTNXPUART driver, it is observed that after FW dump, if driver is
> removed and re-loaded, it creates hci1 interface instead of hci0
> interface.
>
> But after DEVCD_TIMEOUT (5 minutes) if driver is re-loaded, hci0 is
> created. This is because after FW dump, hci0 is not unregistered
> properly for DEVCD_TIMEOUT.
>
> With this patch, BTNXPUART is able to create hci0 after every FW dump
> and driver reload.
>
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  include/net/bluetooth/coredump.h | 3 +++
>  net/bluetooth/coredump.c         | 8 ++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/include/net/bluetooth/coredump.h b/include/net/bluetooth/cor=
edump.h
> index 72f51b587a04..bc8856e4bfe7 100644
> --- a/include/net/bluetooth/coredump.h
> +++ b/include/net/bluetooth/coredump.h
> @@ -66,6 +66,7 @@ void hci_devcd_timeout(struct work_struct *work);
>
>  int hci_devcd_register(struct hci_dev *hdev, coredump_t coredump,
>                        dmp_hdr_t dmp_hdr, notify_change_t notify_change);
> +void hci_devcd_unregister(struct hci_dev *hdev);
>  int hci_devcd_init(struct hci_dev *hdev, u32 dump_size);
>  int hci_devcd_append(struct hci_dev *hdev, struct sk_buff *skb);
>  int hci_devcd_append_pattern(struct hci_dev *hdev, u8 pattern, u32 len);
> @@ -85,6 +86,8 @@ static inline int hci_devcd_register(struct hci_dev *hd=
ev, coredump_t coredump,
>         return -EOPNOTSUPP;
>  }
>
> +static inline void hci_devcd_unregister(struct hci_dev *hdev) {}
> +
>  static inline int hci_devcd_init(struct hci_dev *hdev, u32 dump_size)
>  {
>         return -EOPNOTSUPP;
> diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> index 819eacb38762..dd7bd40e3eba 100644
> --- a/net/bluetooth/coredump.c
> +++ b/net/bluetooth/coredump.c
> @@ -442,6 +442,14 @@ int hci_devcd_register(struct hci_dev *hdev, coredum=
p_t coredump,
>  }
>  EXPORT_SYMBOL(hci_devcd_register);
>
> +void hci_devcd_unregister(struct hci_dev *hdev)
> +{
> +       cancel_delayed_work(&hdev->dump.dump_timeout);
> +       skb_queue_purge(&hdev->dump.dump_q);
> +       dev_coredump_put(&hdev->dev);
> +}
> +EXPORT_SYMBOL_GPL(hci_devcd_unregister);

The fact that the dump lives inside hdev is sort of the source of
these problems, specially if the dumps are not HCI traffic it might be
better off having the driver control its lifetime and not use
hdev->workqueue to schedule it.

>  static inline bool hci_devcd_enabled(struct hci_dev *hdev)
>  {
>         return hdev->dump.supported;
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

