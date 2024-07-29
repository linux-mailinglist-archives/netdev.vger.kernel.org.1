Return-Path: <netdev+bounces-113612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508693F4A7
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB76E280366
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBF146000;
	Mon, 29 Jul 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VlRVDaIi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99954146003
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 11:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254172; cv=none; b=QTdwvfpYpUFeOd9xAgF6xWWxjfR46uTq3vAOmqi7T0aYiyTJY+znXq/yymZvbrxFrLD7UdFEbuELmX9LLDITx5wMVL6Os/mMbSC3dJkdwQ1r8PEvdZDdgYGTi/uDt9XxHGzEL7ko2S0YeWNT7kjM4iLBnhlwcOiIBBMQiHHBdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254172; c=relaxed/simple;
	bh=i9I3/N05FbGwbs91KpB69t9soACd1NmRqKErtbYjxfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoJexm9wn79p8eaH4eOd9S6NiwnWFUUUgQgsj/7NVGZMR8UKg2hY9ldQrXwdwp+alnXOAgOyPxjO/2couBi7DUqaVvB1MXpHpWoLhPMD8fWw524HhdcqbDAHiz+LHdXnvYB7F/TKWBom+7LW284pwQw3RYxXUoVVDNBayR8bGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VlRVDaIi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so43207061fa.1
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722254169; x=1722858969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lqilmYMNLKW9grtztpOwsuGdNvh+NjmMFJBCfbrWzM=;
        b=VlRVDaIidmvG9OURb/KvjjAUO1JQpyAogP87mz5A39PExXtoJLaS80MFW87AudAGDh
         82HtdsxbcFvU1qamlNyf02qOXYtI5ccc6x2bfSMOvcp0h/w1p/EVgz59iQxvF/c9x59P
         hcyAt7YpLrvckKtjHIzktQG6VxFbsOCl/VwVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722254169; x=1722858969;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lqilmYMNLKW9grtztpOwsuGdNvh+NjmMFJBCfbrWzM=;
        b=cp+ZzVZ5ntOrZGGw1g2k373isORpP542d3v1v8j9ycxYDKHJoinHdpl2YDSEtOHoCu
         /rQ1xcb6HoJPFyO3kgEZFNnJ86YoYKPRT7npN4CO7sPDWbmlNCj69BOgJtWTAAkbCqd7
         cqWzPR7PVgCzu3nR9tqziXqOeU570O6LpZJeTOckcdmOuTPTNQGVrIFIj2vKhncYj7wj
         jVqJkPbKnkg/cfeKf6COxOwUJoj99VzAIHiOoNWg63Nw+TYgww5QVdTfEvmbwoPN+BPY
         hsu1F3iRzkSK1faQS17W5AP1+C3BTe/EO2G1lxmZM+nAQEIsaMxauuIus2KeeDI7/kCB
         9upQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW1FKreipYntoWdpDqOGKzkBzx68vDUePKV0CWr/mI/dmhaxLcMq0OBVxiQnewFPJaP865AwxmCBQhe+n+/9CDKKhZXRJX
X-Gm-Message-State: AOJu0Yy3RBPn33LXsDUHHJY4/Na5m5vt2709PS1AMnWz7/eVnbKYKCOF
	KGNkBRZbR7KIi2WkBPkmfpldOj44BT3GarbLwYWSxIFMx+hN+IaNEGNTrmRKXok=
X-Google-Smtp-Source: AGHT+IEJSwMOihyNplXaU0oXw+JPkRM618PqXZc6xYxwDAEuy3NmLkQA4X67+R5kP5xzh5UzltTrZw==
X-Received: by 2002:a2e:a78d:0:b0:2ef:2dfe:f058 with SMTP id 38308e7fff4ca-2f12ee2eac5mr44883831fa.42.1722254168694;
        Mon, 29 Jul 2024 04:56:08 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03cf30aacsm12885391fa.48.2024.07.29.04.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:56:08 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:56:06 +0100
From: Joe Damato <jdamato@fastly.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	"rkannoth@marvell.com" <rkannoth@marvell.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v25 08/13] rtase: Implement net_device_ops
Message-ID: <ZqeDVl5rGXfEjv4m@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Justin Lai <justinlai0215@realtek.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>,
	"rkannoth@marvell.com" <rkannoth@marvell.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
 <20240729062121.335080-9-justinlai0215@realtek.com>
 <ZqdvAmRc3sBzDFYI@LQ3V64L9R2>
 <f55076d3231f40dead386fe6d7de58c9@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55076d3231f40dead386fe6d7de58c9@realtek.com>

On Mon, Jul 29, 2024 at 11:39:03AM +0000, Justin Lai wrote:
> > On Mon, Jul 29, 2024 at 02:21:16PM +0800, Justin Lai wrote:
> > > 1. Implement .ndo_set_rx_mode so that the device can change address
> > > list filtering.
> > > 2. Implement .ndo_set_mac_address so that mac address can be changed.
> > > 3. Implement .ndo_change_mtu so that mtu can be changed.
> > > 4. Implement .ndo_tx_timeout to perform related processing when the
> > > transmitter does not make any progress.
> > > 5. Implement .ndo_get_stats64 to provide statistics that are called
> > > when the user wants to get network device usage.
> > > 6. Implement .ndo_vlan_rx_add_vid to register VLAN ID when the device
> > > supports VLAN filtering.
> > > 7. Implement .ndo_vlan_rx_kill_vid to unregister VLAN ID when the
> > > device supports VLAN filtering.
> > > 8. Implement the .ndo_setup_tc to enable setting any "tc" scheduler,
> > > classifier or action on dev.
> > > 9. Implement .ndo_fix_features enables adjusting requested feature
> > > flags based on device-specific constraints.
> > > 10. Implement .ndo_set_features enables updating device configuration
> > > to new features.
> > >
> > > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > > ---
> > >  .../net/ethernet/realtek/rtase/rtase_main.c   | 235 ++++++++++++++++++
> > >  1 file changed, 235 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > > index 8fd69d96219f..80673fa1e9a3 100644
> > 
> > [...]
> > 
> > > +static void rtase_dump_state(const struct net_device *dev) {
> > 
> > [...]
> > 
> > > +
> > > +     netdev_err(dev, "tx_packets %lld\n",
> > > +                le64_to_cpu(counters->tx_packets));
> > > +     netdev_err(dev, "rx_packets %lld\n",
> > > +                le64_to_cpu(counters->rx_packets));
> > > +     netdev_err(dev, "tx_errors %lld\n",
> > > +                le64_to_cpu(counters->tx_errors));
> > > +     netdev_err(dev, "rx_errors %d\n",
> > > +                le32_to_cpu(counters->rx_errors));
> > > +     netdev_err(dev, "rx_missed %d\n",
> > > +                le16_to_cpu(counters->rx_missed));
> > > +     netdev_err(dev, "align_errors %d\n",
> > > +                le16_to_cpu(counters->align_errors));
> > > +     netdev_err(dev, "tx_one_collision %d\n",
> > > +                le32_to_cpu(counters->tx_one_collision));
> > > +     netdev_err(dev, "tx_multi_collision %d\n",
> > > +                le32_to_cpu(counters->tx_multi_collision));
> > > +     netdev_err(dev, "rx_unicast %lld\n",
> > > +                le64_to_cpu(counters->rx_unicast));
> > > +     netdev_err(dev, "rx_broadcast %lld\n",
> > > +                le64_to_cpu(counters->rx_broadcast));
> > > +     netdev_err(dev, "rx_multicast %d\n",
> > > +                le32_to_cpu(counters->rx_multicast));
> > > +     netdev_err(dev, "tx_aborted %d\n",
> > > +                le16_to_cpu(counters->tx_aborted));
> > > +     netdev_err(dev, "tx_underun %d\n",
> > > +                le16_to_cpu(counters->tx_underun));
> > 
> > You use le64/32/16_to_cpu here for all stats, but below in rtase_get_stats64, it
> > is only used for tx_errors.
> > 
> > The code should probably be consistent? Either you do or don't need to use
> > them?
> > 
> > > +}
> > > +
> > [...]
> > > +
> > > +static void rtase_get_stats64(struct net_device *dev,
> > > +                           struct rtnl_link_stats64 *stats) {
> > > +     const struct rtase_private *tp = netdev_priv(dev);
> > > +     const struct rtase_counters *counters;
> > > +
> > > +     counters = tp->tally_vaddr;
> > > +
> > > +     dev_fetch_sw_netstats(stats, dev->tstats);
> > > +
> > > +     /* fetch additional counter values missing in stats collected by driver
> > > +      * from tally counter
> > > +      */
> > > +     rtase_dump_tally_counter(tp);
> > > +     stats->rx_errors = tp->stats.rx_errors;
> > > +     stats->tx_errors = le64_to_cpu(counters->tx_errors);
> > > +     stats->rx_dropped = tp->stats.rx_dropped;
> > > +     stats->tx_dropped = tp->stats.tx_dropped;
> > > +     stats->multicast = tp->stats.multicast;
> > > +     stats->rx_length_errors = tp->stats.rx_length_errors;
> > 
> > See above; le64_to_cpu for tx_errors, but not the rest of the stats. Why?
> 
> The rtase_dump_state() function is primarily used to dump certain hardware
> information. Following discussions with Jakub, it was suggested that we
> should design functions to accumulate the 16-bit and 32-bit counter values
> to prevent potential overflow issues due to the limited size of the
> counters. However, the final decision was to temporarily refrain from
> reporting 16-bit and 32-bit counter information. Additionally, since
> tx_packet and rx_packet data are already provided through tstat, we
> ultimately opted to modify it to the current rtase_get_stats64() function.

Your response was a bit confusing, but after re-reading the code I
think I understand now that I misread the code above.

The answer seems to be that tx_errors is accumulated in
rtase_counters (which needs le*_to_cpu), but the other counters are
accumulated in tp->stats which do not need le*_to_cpu because they
are already being accounted in whatever endianness the CPU uses.

OK.

