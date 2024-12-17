Return-Path: <netdev+bounces-152649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBA9F503A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B2E16FE68
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638CB1F8ACB;
	Tue, 17 Dec 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mIodXlFg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DA1F8937
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450443; cv=none; b=rrYC9DQI80/Wsr6YUp0c+2BV+Hbw1nf9YCeaCfcKBL4Nmcq+iDmTnFvVLbniQWZcmzG/7yq0SxbKMD/MPC6FDpz7N/ljmf7sSxnjwXJq98OgytrIIcVLu6WXfBZCe8P+MSPFBuzsH6BdVL90cZMGhCeWz5mc6iVpjhzz9EBUq3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450443; c=relaxed/simple;
	bh=SmsffRxiHrvcbmtv13M6U+b/+RcItZvvBWNEaOjqyKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXsrd8VC+lhdfZoHSl29HEYoYq4USc0j/7C2F39L7zYIpNbxUQ6Y+uOxOLqOGTQFU6Bgtmq340lPEmNh23nsWYb8UGUEtwHpwCaOLJBsQf1BRix6L44m8TEzvKA0Yv6TpCTTgaEWRXhfaf5uGLvUynWgeXxeMm6wwQjZ4xljXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mIodXlFg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso9964288a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734450439; x=1735055239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmTBwLz765G6la21hd3l68WxQOcuNECsxaNLvoKan0o=;
        b=mIodXlFgXePcnpecKH5Y+NckXRqmirTARIsqOgWuENMytDg9QwcwAQ9ROO3xTDGpHx
         PjiO3Gq8yJyV1MAx+B1wHpxUkOyilMTh1a0lJR9PpBPUFPG/5tjGCZOUiLv0ots68nQA
         6sXk3LK3/FHYNKiX0ga1zsJ7TmTNXgQY9RfUN9p7yhndmvFOR5wgpH7UddQMQR71L5mz
         rTH5/k8bq5SwBu5yWCKuh4MfkR1sDuOY3A+DM/3Lflb9LYkcDzaLubOu+8t6rmH55tFT
         i++68Hrm/0buKChODffGO/chvREMhzL1WSu4uZ+aMF2AbsyDV5YlcYj1tfx6ED/HNLUC
         oolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734450439; x=1735055239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmTBwLz765G6la21hd3l68WxQOcuNECsxaNLvoKan0o=;
        b=W2ahy3J6t0fOoPJn4E2SK3NXOk1mv0otx4vtDsSlCxPRgswg0bjVJWCLrBcyxgArqo
         GFSrTqQ9psUVxr6T/HmB4uXkyR2yq1PvvtYJbBRI1bkyXckYZ1vRkVbMrQZnT3VpmZCr
         NzTXchmwc8VjyRdZeDoL3qhv81AoH6QBIuESnMWnlRC8RFPR3GSBpLu2IXmUNKV1+ymZ
         RTND4z1KZjckWs6Piuj08HM7IyXMEXgvyqdfQfE7EOEY2DkOQ/vEXq+k9cfDmCbjlTRX
         0v86k9mMS2RBumIZ3ZtZ6DH5LdSNCppRhTl+hBpNOC1kbasSmGKqOZgvtjQoRiKpekxZ
         eXmw==
X-Forwarded-Encrypted: i=1; AJvYcCWNiACnKhx/DcInNJ8N3kFAIUBKCQCN7Xto6QirAHWydkqArmS32afLpLmIHqfgTokeIvtRBIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9zQI9NUGxP5GmCDvA0QR3V8T9H4Vf2f9I5h647xV47fKrgKn
	u3VRdYRslMcvvJREp3CB4z4+co9nVJbVaG93RtlOG5NqH5iRovUJR4gl4LhN8vHTWNtZleSJ6fc
	+xyeuh9Xqk+KI7d5HxWx19i+09Zp7P0L+dmiL
X-Gm-Gg: ASbGncurs0qAYg7rs/Zx2G79U/CQk/JVTAJp8/8HEauuXg1ysohmww4Sv6bGdKkASG4
	UpVM8h0qj53M5JuiW0xqL/JH3liKN3lTFMqKwh2kNdJFicfCKNDmIzDGNybhU5k+QxWb58S6u
X-Google-Smtp-Source: AGHT+IE+A4Ntq5Co36HwJSOWn+xlmSxN3h9rnUqF/TS4fcTTdHu/vzmGmttm6hfPGlLzDLJlX2V/Il03N+f7M4BkZmg=
X-Received: by 2002:a05:6402:43c6:b0:5d1:f009:9266 with SMTP id
 4fb4d7f45d1cf-5d63c2f8266mr15551047a12.2.1734450438574; Tue, 17 Dec 2024
 07:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217140323.782346-1-kory.maincent@bootlin.com>
In-Reply-To: <20241217140323.782346-1-kory.maincent@bootlin.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 16:47:07 +0100
Message-ID: <CANn89iJ3sax3eRDPCF+sgk4FQzTn45eFuz+c+tE9sD+gE_f4jA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethtool: Fix suspicious rcu_dereference usage
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com, 
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:03=E2=80=AFPM Kory Maincent <kory.maincent@bootli=
n.com> wrote:
>
> The __ethtool_get_ts_info function can be called with or without the
> rtnl lock held. When the rtnl lock is not held, using rtnl_dereference()
> triggers a warning due to improper lock context.
>
> Replace rtnl_dereference() with rcu_dereference_rtnl() to safely
> dereference the RCU pointer in both scenarios, ensuring proper handling
> regardless of the rtnl lock state.
>
> Reported-by: syzbot+a344326c05c98ba19682@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/676147f8.050a0220.37aaf.0154.GAE@g=
oogle.com/
> Fixes: b9e3f7dc9ed9 ("net: ethtool: tsinfo: Enhance tsinfo to support sev=
eral hwtstamp by net topology")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  net/ethtool/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 02f941f667dd..ec6f2e2caaf9 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -870,7 +870,7 @@ int __ethtool_get_ts_info(struct net_device *dev,
>  {
>         struct hwtstamp_provider *hwprov;
>
> -       hwprov =3D rtnl_dereference(dev->hwprov);
> +       hwprov =3D rcu_dereference_rtnl(dev->hwprov);
>         /* No provider specified, use default behavior */
>         if (!hwprov) {
>                 const struct ethtool_ops *ops =3D dev->ethtool_ops;

I have to ask : Can you tell how this patch has been tested ?

rcu is not held according to syzbot report.

If rtnl and rcu are not held, lockdep will still complain.

