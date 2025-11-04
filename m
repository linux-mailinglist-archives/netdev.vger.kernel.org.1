Return-Path: <netdev+bounces-235535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A678C3230F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D56B4E228F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912F299A94;
	Tue,  4 Nov 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFAR+LVE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2D13AD05
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275629; cv=none; b=S9xqNp4Nvgew9bSiG+O4HZQGuoEgHNZRoHgzMQBZ3YKzx4Cn9kYF61HIlZHoUIFpQAomzhY2C9MpVIv+1qvyyct7mt+fjzrQkP1NIS97026g4HBx7x+3oaYTXHcCfWBR0ECV4+RWV3rE70hjdsc163+JIKB86biNWMJX2IzqHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275629; c=relaxed/simple;
	bh=fNKxR8Huz8fa7FD9nwQcgMFYT6NMnhgEmGSLfWUUPiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMbPZkorTEIfP1CoqzxYFgW6nd+/R3vzYiT5dLjw/mzTuTGjlfFEQRivRmnhuSOBbiWoFghYum3E1kuAMRianf+tURKyw+GapyCb8PJCxvoYmqJP1EnhXkwITjl7icx4EtENl0Qkdw93dd4li4ysEZGpI8yNf8TaglQLrCcN/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFAR+LVE; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ed612ac7a7so11917481cf.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762275626; x=1762880426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLkr+toBJEkXFzMqz8dqv7JYuTKc8UDp6rSXr+gKLa0=;
        b=iFAR+LVEkMa3u2S5mF7i1mTtoZX8nfiZ2cKvdaDkHyFPMyuFl2tdGRgRgBYW3kpiB4
         99CQ51cqPYrdzVg7fHbz5dBHvSIVdkLi/XbZF91MzL0fdA2XOBvDYhZ6jnEJQJzP9IGg
         e5coIVl4jnetJLqZf5ejwq+/Oebe0KfHWY1ArCm88jEj1itMriD76XCFFeOmRcLWe+LW
         zMEBF/Oon1lm/Oeq9FgAHkGpatt5HlCXy1TQtCeX6/EWV6IgVqtfy4C6KqR6TN5nwrzl
         eZB+jTKZZx8DLwCElEU7F9QAcsB7cWDFHvcfUPPItZHb3UsMJSgYtS83p+qaoabKKr2W
         bMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762275626; x=1762880426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLkr+toBJEkXFzMqz8dqv7JYuTKc8UDp6rSXr+gKLa0=;
        b=M1bke3aQr5NVFBCtYt99GwjxmCYc8+k0FQmXCzlA/yFaCYHxPF3NbvjlNclQIy4w8d
         HXRj80Vd4wVu7XcNJz84yVCCJn1Jze7x70vPhAehIsURfeMai/Nj7j1rLD+vK+4b+Frc
         9x8ZRWEXQK/7bu0RmGGqJ47miZkuQQG7DbJG3rxvSewzSVvRAqgNVippwBeyOTYf8dRR
         rrjTZvsiB4SHficdYMa90Q4Jyter/D8lsbMejPRQAL97BDY0uoK04GSO5FFYmQlHCvoi
         llioFyjEmKLu9qwyjgWFCSalHNawIyr2M0jVMYoa5p2VPZ67+yeU+2NzRKRs6LBoNWEi
         yMQw==
X-Forwarded-Encrypted: i=1; AJvYcCXFTIjw9mRNM510qolY1pBVaAxMWxKNjfC3c4FT5g7mbUQguTybRNeH3Nt+ZL+nQZEj9OcDHoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKzuIZHEGQuXFaJkJKAixbONXGlDdF2L+PmlGKT8X4jPuzhNq
	hWGaeVFVYDP0p+zhzqxBfmpRsBupAIdB6u1obcouNpgPRmic/cSoXXVNaHTOhbBhXTwv/+uqd+h
	FQfsqiVUsPuiR6a/AP2+LIHfL4QKxdwJXNyXEXI+T
X-Gm-Gg: ASbGncuvX2obqd/SmlxxoT2p2RFSSpgFRrrA7JU7/wnhF3XYIzrhkpwstAgZf9y+c2i
	G8hKeYzwlXo5KTCosI1/64W+J5Ycqk6b+mPO3qdRvtiFcblatAIncgd0lS2eGpeXM/RlN7v3AVl
	LnPVIpQJ0q9z4o76MpUAjE/Nb4Nvz4kGfp3LyLQY9dEB9+WfJHcVDO2qU1Zc4lNovGCSxSQ1rh3
	g2aLQNrJq5gVzHrzEqcAIUgxOqjOdkQtHQe+oCtcjl2taICUIDKpsPs669b
X-Google-Smtp-Source: AGHT+IHyzDdpfQy1ogOmLinZQFR4B08PtdTVqgFkjFVLjt+FqIzXGcrnMNTyXjkb4SiZpnz28193KoiXFhUYGydLiv4=
X-Received: by 2002:a05:622a:13d1:b0:4c4:dfac:683f with SMTP id
 d75a77b69052e-4ed725ff575mr2114981cf.56.1762275625640; Tue, 04 Nov 2025
 09:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de> <20251104161327.41004-2-simon.schippers@tu-dortmund.de>
In-Reply-To: <20251104161327.41004-2-simon.schippers@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Nov 2025 09:00:14 -0800
X-Gm-Features: AWmQ_bmeXlUhR0iNRG8sd-M8ii4vznUNqZK8bfVckHH7T2JL75mp-YQvDeczkds
Message-ID: <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:14=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> The usbnet driver currently relies on fixed transmit queue lengths, which
> can lead to bufferbloat and large latency spikes under load -
> particularly with cellular modems.
> This patch adds support for Byte Queue Limits (BQL) to dynamically manage
> the transmit queue size and reduce latency without sacrificing
> throughput.
>
> Testing was performed on various devices using the usbnet driver for
> packet transmission:
>
> - DELOCK 66045: USB3 to 2.5 GbE adapter (ax88179_178a)
> - DELOCK 61969: USB2 to 1 GbE adapter (asix)
> - Quectel RM520: 5G modem (qmi_wwan)
> - USB2 Android tethering (cdc_ncm)
>
> No performance degradation was observed for iperf3 TCP or UDP traffic,
> while latency for a prioritized ping application was significantly
> reduced. For example, using the USB3 to 2.5 GbE adapter, which was fully
> utilized by iperf3 UDP traffic, the prioritized ping was improved from
> 1.6 ms to 0.6 ms. With the same setup but with a 100 Mbit/s Ethernet
> connection, the prioritized ping was improved from 35 ms to 5 ms.
>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/usb/usbnet.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 62a85dbad31a..1994f03a78ad 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -831,6 +831,7 @@ int usbnet_stop(struct net_device *net)
>
>         clear_bit(EVENT_DEV_OPEN, &dev->flags);
>         netif_stop_queue (net);
> +       netdev_reset_queue(net);
>
>         netif_info(dev, ifdown, dev->net,
>                    "stop stats: rx/tx %lu/%lu, errs %lu/%lu\n",
> @@ -939,6 +940,7 @@ int usbnet_open(struct net_device *net)
>         }
>
>         set_bit(EVENT_DEV_OPEN, &dev->flags);
> +       netdev_reset_queue(net);
>         netif_start_queue (net);
>         netif_info(dev, ifup, dev->net,
>                    "open: enable queueing (rx %d, tx %d) mtu %d %s framin=
g\n",
> @@ -1500,6 +1502,7 @@ netdev_tx_t usbnet_start_xmit(struct sk_buff *skb, =
struct net_device *net)
>         case 0:
>                 netif_trans_update(net);
>                 __usbnet_queue_skb(&dev->txq, skb, tx_start);
> +               netdev_sent_queue(net, skb->len);
>                 if (dev->txq.qlen >=3D TX_QLEN (dev))
>                         netif_stop_queue (net);
>         }
> @@ -1563,6 +1566,7 @@ static inline void usb_free_skb(struct sk_buff *skb=
)
>  static void usbnet_bh(struct timer_list *t)
>  {
>         struct usbnet           *dev =3D timer_container_of(dev, t, delay=
);
> +       unsigned int bytes_compl =3D 0, pkts_compl =3D 0;
>         struct sk_buff          *skb;
>         struct skb_data         *entry;
>
> @@ -1574,6 +1578,8 @@ static void usbnet_bh(struct timer_list *t)
>                                 usb_free_skb(skb);
>                         continue;
>                 case tx_done:
> +                       bytes_compl +=3D skb->len;
> +                       pkts_compl++;
>                         kfree(entry->urb->sg);
>                         fallthrough;
>                 case rx_cleanup:
> @@ -1584,6 +1590,8 @@ static void usbnet_bh(struct timer_list *t)
>                 }
>         }
>
> +       netdev_completed_queue(dev->net, pkts_compl, bytes_compl);
> +
>         /* restart RX again after disabling due to high error rate */
>         clear_bit(EVENT_RX_KILL, &dev->flags);
>

I think this is racy. usbnet_bh() can run from two different contexts,
at the same time (from two cpus)

1) From process context :
usbnet_bh_work()

2) From a timer. (dev->delay)


To use BQL, you will need to add mutual exclusion.

