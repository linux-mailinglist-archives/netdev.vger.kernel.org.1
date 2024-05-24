Return-Path: <netdev+bounces-97914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BB8CDFCF
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 05:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13C21C21B04
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 03:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3845239ADD;
	Fri, 24 May 2024 03:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QwWP97nh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38237703
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521791; cv=none; b=Gn0MuyBXLiGhdXm2V6vDI2TcCgDtoLyBsksGa66yWzvqWSXxFe604TX3OWwwYEdYzscNxu+N5LtUoTCiuRttnpS0t/jusnSEOyH1xoz6dgMlfr7204j/0TpYDLvXdEn7u1JZvHaUQdsL26i9YuumB7eVuLNhaiMBa8or+GnAG78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521791; c=relaxed/simple;
	bh=njn3ZSsQADSh1M5hWmKHI6B2nRPBr2eH8pLPPwf8W4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuUgXCMlPNMScr87XpDl8kOSjj2d00uznjQlwHFg1nKfDv1Lq92QNy0cLKVXPMzqqKi7JKREHW2XoBE+IgWWHvxf8n0G1qgcQxKPGVPB6MdE+x5wDRRWvpPytdN3vnRCdoFe9e0IIQqwhtm5ED+Rz2r1FE1OFM8P2XRZADZj0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QwWP97nh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso5844661e87.3
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716521787; x=1717126587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvqR2HI4wGJZSYx5d6cdYSO9SOYSnPRTRO4QAEGsUG8=;
        b=QwWP97nh0eZVv5dTYIZzvLIWz5/c9QyCRXsvXq4B14ruUf68tkZHeFlpy3O/wlJS/M
         cx/E3/uAHVvJy9AGvRaz/2fgk9k3RIcr6ZQMWqVd+NV06ZIo788rODS602wLKrcyz+hp
         cBLocVOr5fTtgEmJWzPsjAhA0dK9dSjzgVaw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521787; x=1717126587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvqR2HI4wGJZSYx5d6cdYSO9SOYSnPRTRO4QAEGsUG8=;
        b=deGbcVtnvSg3BWbEpOIN/FJ8tydR1uaqM7XFUJqfxKc1LBTNotC3k/6vHb6/KSuwKX
         kPg2HM9ZNJsFEXRe4pv8MhUOlIW0HciAmOQQXJlB+WtuVRJqomINoPwr9tGtMLTCQkAK
         ZFBAkWICU1amEQV9OhPJptHa8yFIfCQGNCrTYfLqc3eEUlyBrgSWS5OQR4yGp+KHXd+v
         N3IiR67A+D/v9no4Qy4oO9G1Lx8KooLjGqg7lkSHNBZtKHAos1mhRrfOaR0UBHUDljha
         6YqREU6hqTNPu3N6o0KF8oyQGcZn+ZDJuQe7/Bh33fahI6/bHHgi8Qq0wZn9R8jBvlQ8
         PxBw==
X-Forwarded-Encrypted: i=1; AJvYcCXyTlFnq1oy2oHW0RSACxgQzhijYNbOtmS+aNqob0QRufWs+xEih4le21EeumfvE/KDuig5XuJE712xVyjp5YV6+//qdmCJ
X-Gm-Message-State: AOJu0YyB/yXDs7/kkK4aFLvorSilDTk7F0Rlat/jMgldSd5UdYVqRIee
	Z8KOOXx/UPl719+7DSw40Pi4KYYD+gPRsp5DSACfBWysSjG9y1puRFOY7ZedxpXT1YFv+7KR7Uc
	=
X-Google-Smtp-Source: AGHT+IFsXqcTlfXzcdhUBJLpW5bXAMxQmYtvAUOwijbZee+b/O3OY+vJpvBXfH506uhTrZYy42Rikw==
X-Received: by 2002:a05:6512:238d:b0:51e:7fa6:d59f with SMTP id 2adb3069b0e04-52966bb200fmr681743e87.53.1716521786440;
        Thu, 23 May 2024 20:36:26 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93b54esm54435266b.89.2024.05.23.20.36.25
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 20:36:26 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6266ffdba8so20729466b.1
        for <netdev@vger.kernel.org>; Thu, 23 May 2024 20:36:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW3+3THTG8gXh7thliM1JsvzO2GPdEGC6nTMBnzAZpQGdMLsYWg5qegWlmmZotWohH978+9Wh0+Ul3Zgn9GvCqBi+BghkS
X-Received: by 2002:a17:906:aa4c:b0:a59:cf38:5338 with SMTP id
 a640c23a62f3a-a62641c8f04mr59702466b.19.1716521785172; Thu, 23 May 2024
 20:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523060934.2883716-1-yinghsu@chromium.org> <CABBYNZKwLTri10NfQ07sywymPCFq2mwvb8==Zjn1QMD-kwpobA@mail.gmail.com>
In-Reply-To: <CABBYNZKwLTri10NfQ07sywymPCFq2mwvb8==Zjn1QMD-kwpobA@mail.gmail.com>
From: Ying Hsu <yinghsu@chromium.org>
Date: Fri, 24 May 2024 11:35:48 +0800
X-Gmail-Original-Message-ID: <CAAa9mD2cq=Px2=HLzVNaBfPugEgYD5FdqhyMvOx8VDpzxmEAMg@mail.gmail.com>
Message-ID: <CAAa9mD2cq=Px2=HLzVNaBfPugEgYD5FdqhyMvOx8VDpzxmEAMg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add vendor-specific packet classification
 for ISO data
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

I'm happy to move btusb_intel_classify_pkt_type into btintel.c in the
next patcheset.
As I only tested it on Intel USB BT controllers, I suggest Intel
further assess its applicability to other transports and future BT
controllers in another change.


On Thu, May 23, 2024 at 10:23=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Ying,
>
> On Thu, May 23, 2024 at 2:09=E2=80=AFAM Ying Hsu <yinghsu@chromium.org> w=
rote:
> >
> > When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> > track CIS/BIS connections. User-space applications have to identify
> > ISO data by maintaining connection information and look up the mapping
> > for each ACL data packet received. Besides, btsnoop log captured in
> > kernel couldn't tell ISO data from ACL data in this case.
> >
> > To avoid additional lookups, this patch introduces vendor-specific
> > packet classification for Intel BT controllers to distinguish
> > ISO data packets from ACL data packets.
> >
> > Signed-off-by: Ying Hsu <yinghsu@chromium.org>
> > ---
> > Tested LE audio unicast recording on a ChromeOS device with Intel AX211
> >
> > Changes in v2:
> > - Adds vendor-specific packet classificaton in hci_dev.
> > - Keeps reclassification in hci_recv_frame.
> >
> >  drivers/bluetooth/btusb.c        | 19 +++++++++++++++++++
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         | 16 ++++++++++++++++
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 79aefdb3324d..75561e749c50 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -966,6 +966,24 @@ static void btusb_intel_cmd_timeout(struct hci_dev=
 *hdev)
> >         gpiod_set_value_cansleep(reset_gpio, 0);
> >  }
> >
> > +#define BT_USB_INTEL_ISODATA_HANDLE_BASE 0x900
> > +
> > +static u8 btusb_intel_classify_pkt_type(struct hci_dev *hdev, struct s=
k_buff *skb)
>
> We might as well move this to btintel.c since it should not be USB specif=
ic.
>
> > +{
> > +       /*
> > +        * Distinguish ISO data packets form ACL data packets
> > +        * based on their conneciton handle value range.
> > +        */
> > +       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
> > +               __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handle=
);
> > +
> > +               if (hci_handle(handle) >=3D BT_USB_INTEL_ISODATA_HANDLE=
_BASE)
> > +                       return HCI_ISODATA_PKT;
> > +       }
> > +
> > +       return hci_skb_pkt_type(skb);
> > +}
> > +
> >  #define RTK_DEVCOREDUMP_CODE_MEMDUMP           0x01
> >  #define RTK_DEVCOREDUMP_CODE_HW_ERR            0x02
> >  #define RTK_DEVCOREDUMP_CODE_CMD_TIMEOUT       0x03
> > @@ -4451,6 +4469,7 @@ static int btusb_probe(struct usb_interface *intf=
,
> >                 /* Transport specific configuration */
> >                 hdev->send =3D btusb_send_frame_intel;
> >                 hdev->cmd_timeout =3D btusb_intel_cmd_timeout;
> > +               hdev->classify_pkt_type =3D btusb_intel_classify_pkt_ty=
pe;
> >
> >                 if (id->driver_info & BTUSB_INTEL_NO_WBS_SUPPORT)
> >                         btintel_set_flag(hdev, INTEL_ROM_LEGACY_NO_WBS_=
SUPPORT);
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 9231396fe96f..7b7068a84ff7 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -649,6 +649,7 @@ struct hci_dev {
> >         int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
> >                                      struct bt_codec *codec, __u8 *vnd_=
len,
> >                                      __u8 **vnd_data);
> > +       u8 (*classify_pkt_type)(struct hci_dev *hdev, struct sk_buff *s=
kb);
> >  };
> >
> >  #define HCI_PHY_HANDLE(handle) (handle & 0xff)
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index b3ee9ff17624..8b817a99cefd 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2941,15 +2941,31 @@ int hci_reset_dev(struct hci_dev *hdev)
> >  }
> >  EXPORT_SYMBOL(hci_reset_dev);
> >
> > +static u8 hci_dev_classify_pkt_type(struct hci_dev *hdev, struct sk_bu=
ff *skb)
> > +{
> > +       if (hdev->classify_pkt_type)
> > +               return hdev->classify_pkt_type(hdev, skb);
> > +
> > +       return hci_skb_pkt_type(skb);
> > +}
> > +
> >  /* Receive frame from HCI drivers */
> >  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
> >  {
> > +       u8 dev_pkt_type;
> > +
> >         if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
> >                       && !test_bit(HCI_INIT, &hdev->flags))) {
> >                 kfree_skb(skb);
> >                 return -ENXIO;
> >         }
> >
> > +       /* Check if the driver agree with packet type classification */
> > +       dev_pkt_type =3D hci_dev_classify_pkt_type(hdev, skb);
> > +       if (hci_skb_pkt_type(skb) !=3D dev_pkt_type) {
> > +               hci_skb_pkt_type(skb) =3D dev_pkt_type;
> > +       }
> > +
> >         switch (hci_skb_pkt_type(skb)) {
> >         case HCI_EVENT_PKT:
> >                 break;
> > --
> > 2.45.1.288.g0e0cd299f1-goog
> >
>
>
> --
> Luiz Augusto von Dentz

