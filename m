Return-Path: <netdev+bounces-142613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DBB9BFC70
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9CCB2153B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4741FC08;
	Thu,  7 Nov 2024 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdUHj1Z+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718C79F6;
	Thu,  7 Nov 2024 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945686; cv=none; b=soli5ywwetZkS84BThxiIvP3nLMY2QGXaTG28EOFDmQlspZTWK3DA2yNX7xH6Lf6/C5m0xxLUwPFjPySNRGQxCDsOuGCkz+q3M6BgVrDnlpvsBfCGhAihpqCgEx7p7hhQJ3DUU/H/vxdMgVgntsFsvnFmOpwbt+xbLZ4EXldAGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945686; c=relaxed/simple;
	bh=NroRX/zaqmVHTjHP1m6NYAxCznpyc7gMDbA45r9ywAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=gJHcM9RamrCQbNDdIYM+Ps1Ldp1gzOl5N/rMceC1g1eoChZW81beZcydbKExWlgAaFP25U8YSLlGrwLNL/3WBFIshedv9H4dK+rq3/pMnQejECjNMDrJINsnTax22P+ZNxMUveHioZzrhR0LQpxGUg63UZjsWjDQZBslTfZxo/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdUHj1Z+; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3e600ae1664so327058b6e.2;
        Wed, 06 Nov 2024 18:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945684; x=1731550484; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iniZqyOcjuufnHVB00VivkffCis0f4ByaFNR+Q8L4hQ=;
        b=UdUHj1Z+VavA14ncNHdr1omSjN1xfW7EA1LMiWYbDPsJYf8SrGv1Pc9i2kjHWC+TDx
         sFkazuoN9iIUqD3hTstqaqK9LtqvZWS7TRe7uqku1R8ui8Urt7r6e9XwUpxWR9nJga9N
         /QcVu3khwXv8TH5WurBpNhav+XkvWlE0AQEWjX3fuP9igmmG134Zw9shWTMLWXq3mBWw
         6tRgi67UgNsG+o8Y4m95vDPYN9+VXX37GHZUbc6KRRmLUNGaVwc49Y6GrAiuO1NB27kb
         ErAkfxeCDW2+Xngd9DEx1Vo2jC/05uA5+eLSeUw4Cv9ejPlB25jYyMbL19kCQoHqkiGj
         G5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945684; x=1731550484;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iniZqyOcjuufnHVB00VivkffCis0f4ByaFNR+Q8L4hQ=;
        b=bREE5/q2S2BJ0VHjG4ykHks5y9hpY8z5uUFiDk/zswHsH0bqODUC7F8ytb1wjzjUtr
         DQ4R2l7Pi2enwSfFzE6xFqHhDirahfqZANdU+AB7kjYCB4yBXviDJ6ueeP/M9HfmMx63
         B3nEiAg3rZePldOPCVAjvg65AqCAeREk6WA2dLQVaVoDRmYaoiDbqhdrwX512dA+eQgw
         w/ENPlPNCsRx/O+ECrLqH3UFq9K9iamVx/eAD1YuPeXGQOoe899x12WwsaAgzwXNr/k7
         8Ks51GWKHuhYGyM/z9HVIVlGbcCjiloraYSXpbScS1QQKdS2+sE0MVRjCofV8ybSFj15
         Z40A==
X-Forwarded-Encrypted: i=1; AJvYcCVm3yIBrd6OIjGC2aNLpRyToraXzWef1YdUq+o/oJuOqKiJY7f9s32I5tOwjEuYAMgbIBBqkJhv@vger.kernel.org, AJvYcCWEBONtiXbiJMDdIP5xB8Vyjj8umO15rk2VhXpltFScZy8QUuo8+5oHSllLqVbi+muKxUeyWCki8mQ=@vger.kernel.org, AJvYcCWanHwKsJroOuOT3401TIfZnrgqwbz3N5pmhQ4UR5FowFh4HZhuyVQPVOSNirCQ8fuP6ZqqNYEs+auO4CVk@vger.kernel.org
X-Gm-Message-State: AOJu0YwChB4y8lVS4if/rX3XWBoomMxyrWWJgp8p5r/k7MYZg9Rp8RKn
	+I/jDpN8tepxDM5t+lak+BjiLbGf2JO0lBaFgmW0c5ZJb+5nF+9FXadOsc/Livj/0PI4OCVJscP
	bY3LuLAztUad92E9yvpUfp6NBlOg=
X-Google-Smtp-Source: AGHT+IF8NM/16KvZGcGRtiShRZ9ELTk4ceFC12xmUp7e8Fyv/M2FId4BLJ99s1+SGygpNXmBZqU5DlvDsov1Pj4zcKw=
X-Received: by 2002:a05:6808:1314:b0:3e6:134e:3b90 with SMTP id
 5614622812f47-3e6384b4da1mr43372383b6e.30.1730945684246; Wed, 06 Nov 2024
 18:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106002625.1857904-1-sanman.p211993@gmail.com> <Zyq9D1WCvuykHsUv@LQ3V64L9R2>
In-Reply-To: <Zyq9D1WCvuykHsUv@LQ3V64L9R2>
From: Sanman Pradhan <sanman.p211993@gmail.com>
Date: Wed, 6 Nov 2024 18:14:08 -0800
Message-ID: <CAG4C-On1qMo7+KWDt99A+Lyy29E-qmsxT+gH_5iG2_JpPWR85A@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
To: Joe Damato <jdamato@fastly.com>, Sanman Pradhan <sanman.p211993@gmail.com>, netdev@vger.kernel.org, 
	alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	corbet@lwn.net, mohsin.bashr@gmail.com, sanmanpradhan@meta.com, 
	andrew+netdev@lunn.ch, vadim.fedorenko@linux.dev, sdf@fomichev.me, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Nov 2024 at 16:49, Joe Damato <jdamato@fastly.com> wrote:
>
> On Tue, Nov 05, 2024 at 04:26:25PM -0800, Sanman Pradhan wrote:
> > Add PCIe hardware statistics support to the fbnic driver. These stats
> > provide insight into PCIe transaction performance and error conditions,
> > including, read/write and completion TLP counts and DWORD counts and
> > debug counters for tag, completion credit and NP credit exhaustion
>
> The second sentence is long and doesn't have a period at the end of
> it. Maybe break it up a bit into a set of shorter sentences or a
> list or something like that?
>
> > The stats are exposed via ethtool and can be used to monitor PCIe
> > performance and debug PCIe issues.
> >
> > Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> > ---
> >  .../device_drivers/ethernet/meta/fbnic.rst    |  27 +++++
> >  drivers/net/ethernet/meta/fbnic/fbnic.h       |   1 +
> >  drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 ++++++
> >  .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  77 +++++++++++-
> >  .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 114 ++++++++++++++++++
> >  .../net/ethernet/meta/fbnic/fbnic_hw_stats.h  |  17 +++
> >  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |   3 +
> >  drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   2 +
> >  8 files changed, 278 insertions(+), 2 deletions(-)
>
> [...]
>
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > index 1117d5a32867..9f590a42a9df 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> > @@ -6,6 +6,39 @@
>
> [...]
>
> > +
> > +#define FBNIC_HW_FIXED_STATS_LEN ARRAY_SIZE(fbnic_gstrings_hw_stats)
> > +#define FBNIC_HW_STATS_LEN \
> > +     (FBNIC_HW_FIXED_STATS_LEN)
>
> Does the above need to be on a separate line? Might be able to fit
> in under 80 chars?
>
I tried to fit it in under 80 chars, but this seemed to be slightly
more consistent with the out-of-tree driver, so decided to maintain
it.

> >  static int
> >  fbnic_get_ts_info(struct net_device *netdev,
> >                 struct kernel_ethtool_ts_info *tsinfo)
> > @@ -51,6 +84,43 @@ static void fbnic_set_counter(u64 *stat, struct fbnic_stat_counter *counter)
> >               *stat = counter->value;
> >  }
> >
> > +static void fbnic_get_strings(struct net_device *dev, u32 sset, u8 *data)
> > +{
> > +     int i;
> > +
> > +     switch (sset) {
> > +     case ETH_SS_STATS:
> > +             for (i = 0; i < FBNIC_HW_STATS_LEN; i++)
> > +                     ethtool_puts(&data, fbnic_gstrings_hw_stats[i].string);
> > +             break;
> > +     }
> > +}
> > +
> > +static int fbnic_get_sset_count(struct net_device *dev, int sset)
> > +{
> > +     switch (sset) {
> > +     case ETH_SS_STATS:
> > +             return FBNIC_HW_STATS_LEN;
> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static void fbnic_get_ethtool_stats(struct net_device *dev,
> > +                                 struct ethtool_stats *stats, u64 *data)
> > +{
> > +     struct fbnic_net *fbn = netdev_priv(dev);
> > +     const struct fbnic_stat *stat;
> > +     int i;
> > +
> > +     fbnic_get_hw_stats(fbn->fbd);
> > +
> > +     for (i = 0; i < FBNIC_HW_STATS_LEN; i++) {
> > +             stat = &fbnic_gstrings_hw_stats[i];
> > +             data[i] = *(u64 *)((u8 *)&fbn->fbd->hw_stats + stat->offset);
> > +     }
> > +}
> > +
> >  static void
> >  fbnic_get_eth_mac_stats(struct net_device *netdev,
> >                       struct ethtool_eth_mac_stats *eth_mac_stats)
> > @@ -117,10 +187,13 @@ static void fbnic_get_ts_stats(struct net_device *netdev,
> >  }
> >
> >  static const struct ethtool_ops fbnic_ethtool_ops = {
> > -     .get_drvinfo            = fbnic_get_drvinfo,
> >       .get_ts_info            = fbnic_get_ts_info,
> > -     .get_ts_stats           = fbnic_get_ts_stats,
> > +     .get_drvinfo            = fbnic_get_drvinfo,
> > +     .get_strings            = fbnic_get_strings,
> > +     .get_sset_count         = fbnic_get_sset_count,
> > +     .get_ethtool_stats      = fbnic_get_ethtool_stats,
> >       .get_eth_mac_stats      = fbnic_get_eth_mac_stats,
> > +     .get_ts_stats           = fbnic_get_ts_stats,
> >  };
>
> Seems like the two deleted lines were just re-ordered but otherwise
> unchanged?
>
> I don't think it's any reason to hold this back, but limiting
> changes like that in the future is probably a good idea because it
> makes the diff smaller and easier to review.

Yes, I realize that it's just two deleted lines, but I'm trying to
maintain the same order as the order in which ops are defined in the
struct, for readability.
Will try to minimize changes that increase the length of the diffs

Thank you Joe, for reviewing the patch.

