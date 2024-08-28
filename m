Return-Path: <netdev+bounces-122865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F825962DD1
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E33B2180F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA0519E81F;
	Wed, 28 Aug 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMbTXSXf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5A8188013
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863283; cv=none; b=i85jaYYm5O4mcETlZNikhlPwPWrkq8wntEx/8Gws5gjkWhR+qZrhSMJH0KR9j/Ik58k7VX1MmW4J5hUWaQ2879vm5aEhrGTeiKw7gGJX0XkD4QS0uE5ZkNZsDlKxh6yuwM61JFSoJT/GhhImczmnATKFArjh4EujagYelOvrz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863283; c=relaxed/simple;
	bh=ZNcyztTA0WYUC7Ak5joVJnpHuBW/rsURliB0OX+n4Z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OWmJVnbWjNeXQvO5ymTbKWA34bk7HhyHJ6AnK5bE0tW9L8QTZokOJCw+FJVKnMJ836YWYVSLpICJ6xxcJ2B9JtBGBv68XKDCwaAW/5EKx8MImgx/hEBo61dWp8TmqZlvXvZFwYzdrbGdc+nXlPIzBPPRwgVy8XrHHoO850iepxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMbTXSXf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71423273c62so5102810b3a.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724863281; x=1725468081; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7+/m9D5JU93oKc83Y2eE7LuN0gCR1LvTCMbpZRdSYOg=;
        b=mMbTXSXf59W6oIXrRtK9HpjYFVSWWOCpfIF5IWXF2f5iKzlTBQSKzReVZGIiXNPryj
         82KUXV1nFBNNTsiyU4KWBY+ecpac5whGf1UN5F1xaO8vaTrbJF2eN8GZ692pePsGh5Rp
         0n3um+pe8aRL6nhGWxTHrsn+He2mMxbPN5hArdwm3am8q5Kpmp0z7xYMbHT26Ph2e+Xd
         V/9+3dPapdNNW0GGA5qInJmxm/5g+FVpLt4MpP8qktec75jGCJpDdyMzcTjVTTDrfOyf
         NkAf8pKTbg0hAB1zwYJFOBntycvDg4EYVOET3ZyfxUQPxkjZZ6TjXDd5dX3edxKa5YZf
         Tcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724863281; x=1725468081;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+/m9D5JU93oKc83Y2eE7LuN0gCR1LvTCMbpZRdSYOg=;
        b=cltFDDMy5WgCp8VEaoHT8f1whJG04AHk1grBKFlQHNL+9RQGvC0fz6HObJr+kn9Cwb
         pXIFSYvIwydf6VkYBf8X174dnf/Mjuy0iilRhYchbKSKNLp2oqSECZd1bItNCcOpfQ97
         pUKKHqqJIyPp0cJfZwLcCS0asGDwNUFPmB8U6n/RsxkpbtCeQL1ckn7y+/V6STDvzQP9
         NxJ5C+oSzXRrE6+WIkkiV5Ql5E5wE+R/X5rlR/frw9qOgftk4BHo13qrzeJZN1GLonO4
         n+ZhvZG+kNjTg98mMrzWWXKil/czSVkoFrNtIBceuH8xjGs5DD/Mcf2gCF7P6q1tXwhj
         mbXA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5Mh0hKXKwv9knDxwjTo8bav0shyVxciF48j3Rr9eDy4heaCXRsB+lgCJilUQBRtRRKoqXbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvNSKcvLFCgd5EfoxskF65ZPX7QKLyPWti95XDa4A7YAD7qUKh
	brm6OAGnAm+2qAAcKuhp5wjwxiN4wn/bv50RQVl9M4Tq6APQYu1Z
X-Google-Smtp-Source: AGHT+IGmwzMmR+X2bjSXfEQuuAVWD6re/iNneBlQQsJIcqzPddDgBL4DP4OVoJTW3y9Ll4PMDbc2rw==
X-Received: by 2002:a05:6a20:d49a:b0:1cc:9ff8:e76c with SMTP id adf61e73a8af0-1cc9ff8eb58mr13449577637.52.1724863280981;
        Wed, 28 Aug 2024 09:41:20 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-714342fc340sm11187239b3a.143.2024.08.28.09.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:41:20 -0700 (PDT)
Message-ID: <b2d98851b62e1cf18bad0996736cd0b6de265f06.camel@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add support to fetch group
 stats
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Mohsin Bashir
	 <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, andrew@lunn.ch,
 davem@davemloft.net,  edumazet@google.com, pabeni@redhat.com,
 kernel-team@meta.com,  sanmanpradhan@meta.com, sdf@fomichev.me,
 jdamato@fastly.com
Date: Wed, 28 Aug 2024 09:41:19 -0700
In-Reply-To: <36253a7b-3326-4786-8275-e653573e8aed@amd.com>
References: <20240827205904.1944066-1-mohsin.bashr@gmail.com>
	 <20240827205904.1944066-3-mohsin.bashr@gmail.com>
	 <36253a7b-3326-4786-8275-e653573e8aed@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 17:30 -0700, Nelson, Shannon wrote:
> On 8/27/2024 1:59 PM, Mohsin Bashir wrote:
> >=20
> > Add support for group stats for mac. The fbnic_set_counter helps preven=
t
> > overriding the default values for counters which are not collected by t=
he device.
> >=20
> > The 'reset' flag in 'get_eth_mac_stats' allows choosing between
> > resetting the counter to recent most value or fecthing the aggregate
> > values of counters. This is important to cater for cases such as
> > device reset.
> >=20
> > The 'fbnic_stat_rd64' read 64b stats counters in a consistent fashion u=
sing
> > high-low-high approach. This allows to isolate cases where counter is
> > wrapped between the reads.
> >=20
> > Command: ethtool -S eth0 --groups eth-mac
> > Example Output:
> > eth-mac-FramesTransmittedOK: 421644
> > eth-mac-FramesReceivedOK: 3849708
> > eth-mac-FrameCheckSequenceErrors: 0
> > eth-mac-AlignmentErrors: 0
> > eth-mac-OctetsTransmittedOK: 64799060
> > eth-mac-FramesLostDueToIntMACXmitError: 0
> > eth-mac-OctetsReceivedOK: 5134513531
> > eth-mac-FramesLostDueToIntMACRcvError: 0
> > eth-mac-MulticastFramesXmittedOK: 568
> > eth-mac-BroadcastFramesXmittedOK: 454
> > eth-mac-MulticastFramesReceivedOK: 276106
> > eth-mac-BroadcastFramesReceivedOK: 26119
> > eth-mac-FrameTooLongErrors: 0
> >=20
> > Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> > ---
> > v2: Rebase to the latest
> >=20
> > v1: https://lore.kernel.org/netdev/20240807002445.3833895-1-mohsin.bash=
r@gmail.com
> > ---
> >   drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
> >   drivers/net/ethernet/meta/fbnic/fbnic.h       |  4 ++
> >   drivers/net/ethernet/meta/fbnic/fbnic_csr.h   | 37 ++++++++++++++
> >   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 49 ++++++++++++++++++
> >   .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 27 ++++++++++
> >   .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  | 40 +++++++++++++++
> >   drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 50 ++++++++++++++++++=
+
> >   drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  3 ++
> >   8 files changed, 211 insertions(+)
> >   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> >   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
> >=20
> > diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/eth=
ernet/meta/fbnic/Makefile
> > index 37cfc34a5118..ed4533a73c57 100644
> > --- a/drivers/net/ethernet/meta/fbnic/Makefile
> > +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_FBNIC) +=3D fbnic.o
> >   fbnic-y :=3D fbnic_devlink.o \
> >             fbnic_ethtool.o \
> >             fbnic_fw.o \
> > +          fbnic_hw_stats.o \
> >             fbnic_irq.o \
> >             fbnic_mac.o \
> >             fbnic_netdev.o \
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethe=
rnet/meta/fbnic/fbnic.h
> > index 28d970f81bfc..0f9e8d79461c 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> > @@ -11,6 +11,7 @@
> >=20
> >   #include "fbnic_csr.h"
> >   #include "fbnic_fw.h"
> > +#include "fbnic_hw_stats.h"
> >   #include "fbnic_mac.h"
> >   #include "fbnic_rpc.h"
> >=20
> > @@ -47,6 +48,9 @@ struct fbnic_dev {
> >=20
> >          /* Number of TCQs/RCQs available on hardware */
> >          u16 max_num_queues;
> > +
> > +       /* Local copy of hardware statistics */
> > +       struct fbnic_hw_stats hw_stats;
> >   };
> >=20
> >   /* Reserve entry 0 in the MSI-X "others" array until we have filled a=
ll
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/=
ethernet/meta/fbnic/fbnic_csr.h
> > index a64360de0552..21db509acbc1 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > @@ -660,6 +660,43 @@ enum {
> >   #define FBNIC_SIG_PCS_INTR_MASK                0x11816         /* 0x4=
6058 */
> >   #define FBNIC_CSR_END_SIG              0x1184e /* CSR section delimit=
er */
> >=20
> > +#define FBNIC_CSR_START_MAC_STAT       0x11a00
> > +#define FBNIC_MAC_STAT_RX_BYTE_COUNT_L 0x11a08         /* 0x46820 */
> > +#define FBNIC_MAC_STAT_RX_BYTE_COUNT_H 0x11a09         /* 0x46824 */
> > +#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_L \
> > +                                       0x11a0a         /* 0x46828 */
> > +#define FBNIC_MAC_STAT_RX_ALIGN_ERROR_H \
> > +                                       0x11a0b         /* 0x4682c */
> > +#define FBNIC_MAC_STAT_RX_TOOLONG_L    0x11a0e         /* 0x46838 */
> > +#define FBNIC_MAC_STAT_RX_TOOLONG_H    0x11a0f         /* 0x4683c */
> > +#define FBNIC_MAC_STAT_RX_RECEIVED_OK_L        \
> > +                                       0x11a12         /* 0x46848 */
> > +#define FBNIC_MAC_STAT_RX_RECEIVED_OK_H        \
> > +                                       0x11a13         /* 0x4684c */
> > +#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_L \
> > +                                       0x11a14         /* 0x46850 */
> > +#define FBNIC_MAC_STAT_RX_PACKET_BAD_FCS_H \
> > +                                       0x11a15         /* 0x46854 */
> > +#define FBNIC_MAC_STAT_RX_IFINERRORS_L 0x11a18         /* 0x46860 */
> > +#define FBNIC_MAC_STAT_RX_IFINERRORS_H 0x11a19         /* 0x46864 */
> > +#define FBNIC_MAC_STAT_RX_MULTICAST_L  0x11a1c         /* 0x46870 */
> > +#define FBNIC_MAC_STAT_RX_MULTICAST_H  0x11a1d         /* 0x46874 */
> > +#define FBNIC_MAC_STAT_RX_BROADCAST_L  0x11a1e         /* 0x46878 */
> > +#define FBNIC_MAC_STAT_RX_BROADCAST_H  0x11a1f         /* 0x4687c */
> > +#define FBNIC_MAC_STAT_TX_BYTE_COUNT_L 0x11a3e         /* 0x468f8 */
> > +#define FBNIC_MAC_STAT_TX_BYTE_COUNT_H 0x11a3f         /* 0x468fc */
> > +#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_L \
> > +                                       0x11a42         /* 0x46908 */
> > +#define FBNIC_MAC_STAT_TX_TRANSMITTED_OK_H \
> > +                                       0x11a43         /* 0x4690c */
> > +#define FBNIC_MAC_STAT_TX_IFOUTERRORS_L \
> > +                                       0x11a46         /* 0x46918 */
> > +#define FBNIC_MAC_STAT_TX_IFOUTERRORS_H \
> > +                                       0x11a47         /* 0x4691c */
> > +#define FBNIC_MAC_STAT_TX_MULTICAST_L  0x11a4a         /* 0x46928 */
> > +#define FBNIC_MAC_STAT_TX_MULTICAST_H  0x11a4b         /* 0x4692c */
> > +#define FBNIC_MAC_STAT_TX_BROADCAST_L  0x11a4c         /* 0x46930 */
> > +#define FBNIC_MAC_STAT_TX_BROADCAST_H  0x11a4d         /* 0x46934 */
>=20
> These might be more readable if you add another tab between the name and=
=20
> the value, then you wouldn't need to do line wraps.

We were trying to keep the format consistent from the top of these
defines to the bottom. If I recall the comment on the byte offset would
end up going past 80 characters if we shifted that over.

> >   /* PUL User Registers */
> >   #define FBNIC_CSR_START_PUL_USER       0x31000 /* CSR section delimit=
er */
> >   #define FBNIC_PUL_OB_TLP_HDR_AW_CFG    0x3103d         /* 0xc40f4 */
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/=
net/ethernet/meta/fbnic/fbnic_ethtool.c
> > index 7064dfc9f5b0..5d980e178941 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > @@ -16,8 +16,57 @@ fbnic_get_drvinfo(struct net_device *netdev, struct =
ethtool_drvinfo *drvinfo)
> >                                      sizeof(drvinfo->fw_version));
> >   }
> >=20
> > +static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *co=
unter)
> > +{
> > +       if (counter->reported)
> > +               *stat =3D counter->value;
> > +}
> > +
> > +static void
> > +fbnic_get_eth_mac_stats(struct net_device *netdev,
> > +                       struct ethtool_eth_mac_stats *eth_mac_stats)
> > +{
> > +       struct fbnic_net *fbn =3D netdev_priv(netdev);
> > +       struct fbnic_mac_stats *mac_stats;
> > +       struct fbnic_dev *fbd =3D fbn->fbd;
> > +       const struct fbnic_mac *mac;
> > +
> > +       mac_stats =3D &fbd->hw_stats.mac;
> > +       mac =3D fbd->mac;
> > +
> > +       mac->get_eth_mac_stats(fbd, false, &mac_stats->eth_mac);
> > +
> > +       fbnic_set_counter(&eth_mac_stats->FramesTransmittedOK,
> > +                         &mac_stats->eth_mac.FramesTransmittedOK);
> > +       fbnic_set_counter(&eth_mac_stats->FramesReceivedOK,
> > +                         &mac_stats->eth_mac.FramesReceivedOK);
> > +       fbnic_set_counter(&eth_mac_stats->FrameCheckSequenceErrors,
> > +                         &mac_stats->eth_mac.FrameCheckSequenceErrors)=
;
> > +       fbnic_set_counter(&eth_mac_stats->AlignmentErrors,
> > +                         &mac_stats->eth_mac.AlignmentErrors);
> > +       fbnic_set_counter(&eth_mac_stats->OctetsTransmittedOK,
> > +                         &mac_stats->eth_mac.OctetsTransmittedOK);
> > +       fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACXmitErro=
r,
> > +                         &mac_stats->eth_mac.FramesLostDueToIntMACXmit=
Error);
> > +       fbnic_set_counter(&eth_mac_stats->OctetsReceivedOK,
> > +                         &mac_stats->eth_mac.OctetsReceivedOK);
> > +       fbnic_set_counter(&eth_mac_stats->FramesLostDueToIntMACRcvError=
,
> > +                         &mac_stats->eth_mac.FramesLostDueToIntMACRcvE=
rror);
> > +       fbnic_set_counter(&eth_mac_stats->MulticastFramesXmittedOK,
> > +                         &mac_stats->eth_mac.MulticastFramesXmittedOK)=
;
> > +       fbnic_set_counter(&eth_mac_stats->BroadcastFramesXmittedOK,
> > +                         &mac_stats->eth_mac.BroadcastFramesXmittedOK)=
;
> > +       fbnic_set_counter(&eth_mac_stats->MulticastFramesReceivedOK,
> > +                         &mac_stats->eth_mac.MulticastFramesReceivedOK=
);
> > +       fbnic_set_counter(&eth_mac_stats->BroadcastFramesReceivedOK,
> > +                         &mac_stats->eth_mac.BroadcastFramesReceivedOK=
);
> > +       fbnic_set_counter(&eth_mac_stats->FrameTooLongErrors,
> > +                         &mac_stats->eth_mac.FrameTooLongErrors);
> > +}
> > +
> >   static const struct ethtool_ops fbnic_ethtool_ops =3D {
> >          .get_drvinfo            =3D fbnic_get_drvinfo,
> > +       .get_eth_mac_stats      =3D fbnic_get_eth_mac_stats,
> >   };
> >=20
> >   void fbnic_set_ethtool_ops(struct net_device *dev)
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers=
/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> > new file mode 100644
> > index 000000000000..a0acc7606aa1
> > --- /dev/null
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
> > @@ -0,0 +1,27 @@
> > +#include "fbnic.h"
> > +
> > +u64 fbnic_stat_rd64(struct fbnic_dev *fbd, u32 reg, u32 offset)
> > +{
> > +       u32 prev_upper, upper, lower, diff;
> > +
> > +       prev_upper =3D rd32(fbd, reg + offset);
> > +       lower =3D rd32(fbd, reg);
> > +       upper =3D rd32(fbd, reg + offset);
> > +
> > +       diff =3D upper - prev_upper;
> > +       if (!diff)
> > +               return ((u64)upper << 32) | lower;
>=20
> Is there any particular reason you didn't use u64_stats_fetch_begin()=20
> and u64_stats_fetch_retry() around these to protect the reads?
>=20
> sln

The thing is there isn't another thread to race against. The checking
here is against hardware so it cannot cooperate with the
stats_fetch_begin/retry.

That said we do have a function that is collecting the 32b register
stats that we probably do need to add this wrapper for as it has to run
in the service task to update the stats.

