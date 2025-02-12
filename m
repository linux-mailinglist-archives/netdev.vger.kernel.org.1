Return-Path: <netdev+bounces-165704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3901A332B4
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAE164C03
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59B920408A;
	Wed, 12 Feb 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVgzoqot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC6D202C50;
	Wed, 12 Feb 2025 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399580; cv=none; b=RoQ5VMNTknmgnxn+poWwc4co80beoD/LVrVHoX3GyPCoE0BQyx6pXTvUQjfkPUeOpeeiiK0yH0uoL3lfhgVSptyPLP1WVZQM1IepGuXmlnElaeeo2WY8MGf6LuuAtjkaG6dKblb9jCSth1OoVlG4P6UOV726aD7x372pfTEHV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399580; c=relaxed/simple;
	bh=Kht5JajSoFbjqk7SI1NfFmvei1QSTACfDSlpKDRNAMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHD5jY4zUZTrEr1lQ55SADp7ctxyQG+itqV4GYSgJLGXyhPkhSfjj+ef30Fmj28ANnWLIca3WayFDlCTZUnRHdhXiYxo3oxp7zxGBMWv+4kImrdHaHgsscaWA10sfxT3/f+0+d6XheZsL7hsF3Tnlynq+xXK9LmBoMz4+s7DGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVgzoqot; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-866e8a51fa9so118547241.1;
        Wed, 12 Feb 2025 14:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739399578; x=1740004378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjD5c5Z/nOcFqJ1zoOXQlAY5nML8UX6BLoysdrIad+g=;
        b=EVgzoqotRmebpYI2ouivokutJvWtP2uC8re/43FORdzWU0YPK1HZsPcxtnUth/7aQp
         gXpdT78oiNu38MVxl4N4+ycw8p+Wmbgxfq1DkaeA5TMEgCdA37+Nm4KWc4/iYbeWiZOa
         Ue6wchMHCi0ARwL0ZsBo0inJnD1jGsU9bjzkyBQjEuTDTO6VvRMBdLGOFfXlqweoXpAk
         uu1giRZLjJXoDvSzp59zfg0OhDAuRrEwsCB/TrUmYyXNd6Lj1AwqN6e9NJXDr0QoaetK
         A+PYXr4+xkH11/tl0XSZ4AqsqsIvTuZa5aETHsjFbvzTq5atCuQ/m7Zjv89wKn4KWSCm
         jB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399578; x=1740004378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjD5c5Z/nOcFqJ1zoOXQlAY5nML8UX6BLoysdrIad+g=;
        b=LPhDaq7TiUfJ57tVcvP18EosYi6ErjlcU/OVq2gtYlsqAifwHQnGF1AufzSXzAunYT
         W1FPXkbhJ0lMNnyIYVWkhQHFIOgoYu13OKbNNxEuG+eDVEoEJh//h1cdbcUj5bGgnhKm
         SDU3GhTVr9YXWn4LX9LUfQZFrHRj3gWcYjsy+e292/gtQNkpNg6vgKUJ2vKpJn4ml5pp
         aLaRqvmvTeMxstBFIIBHp7yVorPZOlUFxMkTn/k621PSE7RU3mbg3fut2852kz7PdCnw
         viYEXJ4kMAHVcGvunYh1CbHqCZ0j9fxn2cAaaWleGzCjjV4QHH2r0ckcTFG7aoGC4CEW
         cMkw==
X-Forwarded-Encrypted: i=1; AJvYcCVrNecVBvPhUUH5gBKKp/jKlOmQ2v7tZ+tl2cWTQaGNH07fgdp5Z9loNCqPbnOo7/h/9DbG9ONyKUW+soY=@vger.kernel.org, AJvYcCXb7ozutBy1rc/Qlw3bA6sFbe7q89X+0sPzO2rBs+X+4GdcClSL8HcO1axNrb1IZTeBkzbcHobM@vger.kernel.org
X-Gm-Message-State: AOJu0YzqcMV9Cs/sptA1aMEhUdGVcnXIROhGp+y3N3jMnja8g+QoU1kR
	JzBIvoMrxHk72Eym2cmAXBBZ8vn1vzrRa3aYQKqyNIXCpH3/Dt2J2SgfykK2ixku7ntGKXZG/DH
	KLzRsPqC3EGflE2gSr/ardwX+a5w=
X-Gm-Gg: ASbGncuY3oLfH4USnOQiban0Z7GqjuMtlW5n6N0HMWMZ7QXbzlJcCiX3bnO6Wl1ee1C
	vDNZwUpUFWoN4HRYdGgLM3Dz6kG8MfqQAbc44XEzUqEHiZySbKJszoXtJZRl6tDhtDLznSz5R6g
	dnz4mf4tWM+6dCliTy4YatQhM4Bgv6
X-Google-Smtp-Source: AGHT+IEc/svxJP9ZEqxO5z1spAxd5auUZZJlH9tuH8voVu2R9q6y4QOFPq0FU+OTG7o6Xj5WRxohz7nCkF9vt/f/ozY=
X-Received: by 2002:a05:6102:511f:b0:4bb:ccf5:c24b with SMTP id
 ada2fe7eead31-4bc04dc08famr990664137.2.1739399577848; Wed, 12 Feb 2025
 14:32:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208154350.75316-1-wejmanpm@gmail.com> <7d0fccb0-6fee-44d9-8f1c-455c889a21a1@intel.com>
In-Reply-To: <7d0fccb0-6fee-44d9-8f1c-455c889a21a1@intel.com>
From: Piotr Wejman <wejmanpm@gmail.com>
Date: Wed, 12 Feb 2025 23:32:46 +0100
X-Gm-Features: AWEUYZn2ddEQE9HrtaK8of06GwCrWd9kvlYSrFkI_l8dCvrsOFD7F0AasaLhrvs
Message-ID: <CAMRHcQyp0MppaoL8fT+U7hh45zkZbFFRsDFU=nrYBpqFptTu6g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] net: e1000e: convert to
 ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:10=E2=80=AFPM Lifshits, Vitaly
<vitaly.lifshits@intel.com> wrote:
>
>
>
> On 2/8/2025 5:43 PM, Piotr Wejman wrote:
> > Update the driver to use the new hardware timestamping API added in com=
mit
> > 66f7223039c0 ("net: add NDOs for configuring hardware timestamping").
> > Use Netlink extack for error reporting in e1000e_hwtstamp_set.
> > Align the indentation of net_device_ops.
> >
> > Signed-off-by: Piotr Wejman <wejmanpm@gmail.com>
> > ---
> > Changes in v2:
> >    - amend commit message
> >    - use extack for error reporting
> >    - rename e1000_mii_ioctl to e1000_ioctl
> >    - Link to v1: https://lore.kernel.org/netdev/20250202170839.47375-1-=
piotrwejman90@gmail.com/
> >
> >   drivers/net/ethernet/intel/e1000e/e1000.h  |  2 +-
> >   drivers/net/ethernet/intel/e1000e/netdev.c | 68 ++++++++++-----------=
-
> >   2 files changed, 31 insertions(+), 39 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/et=
hernet/intel/e1000e/e1000.h
> > index ba9c19e6994c..952898151565 100644
> > --- a/drivers/net/ethernet/intel/e1000e/e1000.h
> > +++ b/drivers/net/ethernet/intel/e1000e/e1000.h
> > @@ -319,7 +319,7 @@ struct e1000_adapter {
> >       u16 tx_ring_count;
> >       u16 rx_ring_count;
> >
> > -     struct hwtstamp_config hwtstamp_config;
> > +     struct kernel_hwtstamp_config hwtstamp_config;
> >       struct delayed_work systim_overflow_work;
> >       struct sk_buff *tx_hwtstamp_skb;
> >       unsigned long tx_hwtstamp_start;
> > diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/e=
thernet/intel/e1000e/netdev.c
> > index 286155efcedf..43933e64819b 100644
> > --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> > +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> > @@ -3574,6 +3574,7 @@ s32 e1000e_get_base_timinca(struct e1000_adapter =
*adapter, u32 *timinca)
> >    * e1000e_config_hwtstamp - configure the hwtstamp registers and enab=
le/disable
> >    * @adapter: board private structure
> >    * @config: timestamp configuration
> > + * @extack: netlink extended ACK for error report
> >    *
> >    * Outgoing time stamping can be enabled and disabled. Play nice and
> >    * disable it when requested, although it shouldn't cause any overhea=
d
> > @@ -3587,7 +3588,8 @@ s32 e1000e_get_base_timinca(struct e1000_adapter =
*adapter, u32 *timinca)
> >    * exception of "all V2 events regardless of level 2 or 4".
> >    **/
> >   static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
> > -                               struct hwtstamp_config *config)
> > +                               struct kernel_hwtstamp_config *config,
> > +                               struct netlink_ext_ack *extack)
> >   {
> >       struct e1000_hw *hw =3D &adapter->hw;
> >       u32 tsync_tx_ctl =3D E1000_TSYNCTXCTL_ENABLED;
> > @@ -3598,8 +3600,10 @@ static int e1000e_config_hwtstamp(struct e1000_a=
dapter *adapter,
> >       bool is_l2 =3D false;
> >       u32 regval;
> >
> > -     if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP))
> > +     if (!(adapter->flags & FLAG_HAS_HW_TIMESTAMP)) {
> > +             NL_SET_ERR_MSG(extack, "No HW timestamp support\n");
> >               return -EINVAL;
> > +     }
> >
> >       switch (config->tx_type) {
> >       case HWTSTAMP_TX_OFF:
> > @@ -3608,6 +3612,7 @@ static int e1000e_config_hwtstamp(struct e1000_ad=
apter *adapter,
> >       case HWTSTAMP_TX_ON:
> >               break;
> >       default:
> > +             NL_SET_ERR_MSG(extack, "Unsupported TX HW timestamp type\=
n");
> >               return -ERANGE;
> >       }
> >
> > @@ -3681,6 +3686,7 @@ static int e1000e_config_hwtstamp(struct e1000_ad=
apter *adapter,
> >               config->rx_filter =3D HWTSTAMP_FILTER_ALL;
> >               break;
> >       default:
> > +             NL_SET_ERR_MSG(extack, "Unsupported RX HW timestamp filte=
r\n");
> >               return -ERANGE;
> >       }
> >
> > @@ -3693,7 +3699,7 @@ static int e1000e_config_hwtstamp(struct e1000_ad=
apter *adapter,
> >       ew32(TSYNCTXCTL, regval);
> >       if ((er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_ENABLED) !=3D
> >           (regval & E1000_TSYNCTXCTL_ENABLED)) {
> > -             e_err("Timesync Tx Control register not set as expected\n=
");
> > +             NL_SET_ERR_MSG(extack, "Timesync Tx Control register not =
set as expected\n");
>
> In the case where this function is being called from e1000e_systim_reset
> function, won't it cause this debug print to do nothing?

Yes, you're right.

>
> >               return -EAGAIN;
> >       }
> >
> > @@ -3706,7 +3712,7 @@ static int e1000e_config_hwtstamp(struct e1000_ad=
apter *adapter,
> >                                E1000_TSYNCRXCTL_TYPE_MASK)) !=3D
> >           (regval & (E1000_TSYNCRXCTL_ENABLED |
> >                      E1000_TSYNCRXCTL_TYPE_MASK))) {
> > -             e_err("Timesync Rx Control register not set as expected\n=
");
>
> Same question here.
>
> > +             NL_SET_ERR_MSG(extack, "Timesync Rx Control register not =
set as expected\n");
> >               return -EAGAIN;
> >       }
> >
> > @@ -3932,7 +3938,7 @@ static void e1000e_systim_reset(struct e1000_adap=
ter *adapter)
> >       spin_unlock_irqrestore(&adapter->systim_lock, flags);
> >
> >       /* restore the previous hwtstamp configuration settings */
> > -     e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config);
> > +     e1000e_config_hwtstamp(adapter, &adapter->hwtstamp_config, NULL);

I'll pass an extack instead of NULL and add a print here.

> >   }
> >
> >   /**
> > @@ -6079,8 +6085,8 @@ static int e1000_change_mtu(struct net_device *ne=
tdev, int new_mtu)
> >       return 0;
> >   }
> >
> > -static int e1000_mii_ioctl(struct net_device *netdev, struct ifreq *if=
r,
> > -                        int cmd)
> > +static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr,
> > +                    int cmd)
> >   {
> >       struct e1000_adapter *adapter =3D netdev_priv(netdev);
> >       struct mii_ioctl_data *data =3D if_mii(ifr);
> > @@ -6140,7 +6146,8 @@ static int e1000_mii_ioctl(struct net_device *net=
dev, struct ifreq *ifr,
> >   /**
> >    * e1000e_hwtstamp_set - control hardware time stamping
> >    * @netdev: network interface device structure
> > - * @ifr: interface request
> > + * @config: timestamp configuration
> > + * @extack: netlink extended ACK report
> >    *
> >    * Outgoing time stamping can be enabled and disabled. Play nice and
> >    * disable it when requested, although it shouldn't cause any overhea=
d
> > @@ -6153,20 +6160,18 @@ static int e1000_mii_ioctl(struct net_device *n=
etdev, struct ifreq *ifr,
> >    * specified. Matching the kind of event packet is not supported, wit=
h the
> >    * exception of "all V2 events regardless of level 2 or 4".
> >    **/
> > -static int e1000e_hwtstamp_set(struct net_device *netdev, struct ifreq=
 *ifr)
> > +static int e1000e_hwtstamp_set(struct net_device *netdev,
> > +                            struct kernel_hwtstamp_config *config,
> > +                            struct netlink_ext_ack *extack)
> >   {
> >       struct e1000_adapter *adapter =3D netdev_priv(netdev);
> > -     struct hwtstamp_config config;
> >       int ret_val;
> >
> > -     if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
> > -             return -EFAULT;
> > -
> > -     ret_val =3D e1000e_config_hwtstamp(adapter, &config);
> > +     ret_val =3D e1000e_config_hwtstamp(adapter, config, extack);
> >       if (ret_val)
> >               return ret_val;
> >
> > -     switch (config.rx_filter) {
> > +     switch (config->rx_filter) {
> >       case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> >       case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
> >       case HWTSTAMP_FILTER_PTP_V2_SYNC:
> > @@ -6178,38 +6183,23 @@ static int e1000e_hwtstamp_set(struct net_devic=
e *netdev, struct ifreq *ifr)
> >                * by hardware so notify the caller the requested packets=
 plus
> >                * some others are time stamped.
> >                */
> > -             config.rx_filter =3D HWTSTAMP_FILTER_SOME;
> > +             config->rx_filter =3D HWTSTAMP_FILTER_SOME;
> >               break;
> >       default:
> >               break;
> >       }
> >
> > -     return copy_to_user(ifr->ifr_data, &config,
> > -                         sizeof(config)) ? -EFAULT : 0;
> > +     return 0;
> >   }
> >
> > -static int e1000e_hwtstamp_get(struct net_device *netdev, struct ifreq=
 *ifr)
> > +static int e1000e_hwtstamp_get(struct net_device *netdev,
> > +                            struct kernel_hwtstamp_config *kernel_conf=
ig)
> >   {
> >       struct e1000_adapter *adapter =3D netdev_priv(netdev);
> >
> > -     return copy_to_user(ifr->ifr_data, &adapter->hwtstamp_config,
> > -                         sizeof(adapter->hwtstamp_config)) ? -EFAULT :=
 0;
> > -}
> > +     *kernel_config =3D adapter->hwtstamp_config;
> >
> > -static int e1000_ioctl(struct net_device *netdev, struct ifreq *ifr, i=
nt cmd)
> > -{
> > -     switch (cmd) {
> > -     case SIOCGMIIPHY:
> > -     case SIOCGMIIREG:
> > -     case SIOCSMIIREG:
> > -             return e1000_mii_ioctl(netdev, ifr, cmd);
> > -     case SIOCSHWTSTAMP:
> > -             return e1000e_hwtstamp_set(netdev, ifr);
> > -     case SIOCGHWTSTAMP:
> > -             return e1000e_hwtstamp_get(netdev, ifr);
> > -     default:
> > -             return -EOPNOTSUPP;
> > -     }
> > +     return 0;
> >   }
> >
> >   static int e1000_init_phy_wakeup(struct e1000_adapter *adapter, u32 w=
ufc)
> > @@ -7346,9 +7336,11 @@ static const struct net_device_ops e1000e_netdev=
_ops =3D {
> >   #ifdef CONFIG_NET_POLL_CONTROLLER
> >       .ndo_poll_controller    =3D e1000_netpoll,
> >   #endif
> > -     .ndo_set_features =3D e1000_set_features,
> > -     .ndo_fix_features =3D e1000_fix_features,
> > +     .ndo_set_features       =3D e1000_set_features,
> > +     .ndo_fix_features       =3D e1000_fix_features,
> >       .ndo_features_check     =3D passthru_features_check,
> > +     .ndo_hwtstamp_get       =3D e1000e_hwtstamp_get,
> > +     .ndo_hwtstamp_set       =3D e1000e_hwtstamp_set,
> >   };
> >
> >   /**
> >
>
>
> Also you are missing a subject prefix, I assume that you mean to send it
> to iwl-next since it is not a bug fix. Please add it to your patch.

