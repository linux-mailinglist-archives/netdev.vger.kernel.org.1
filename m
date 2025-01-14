Return-Path: <netdev+bounces-158053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC2A1042B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00528168DA0
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7A01ADC63;
	Tue, 14 Jan 2025 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7XeDEs3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3B229612
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 10:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850658; cv=none; b=VD1Gw4gUFu9e9dTEWC1ZM5QBAgjB1GoZ9cCQEpp8kh8eKjg/ZgTY4Nkt25nR4YvEjD3OtQBixhJcmwyWIexzjC9eYfJyLljSPIBlkXpwNR9FRqR/VKaoc7s/TIrSSorhpSq3jtzOcy/mhM6k8s6kTn/er6Xw1agDibphYIkSf3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850658; c=relaxed/simple;
	bh=zhSlYWEnl8HbDc8zjE9o5ACVrQ4wzDKSCOjvzcKLKKs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FLvKi+Rg/PJ+JYq6qLq0nMi0wZDLtU57Fr0I/lP6iJlLIOMHGmO+L0LpfC8gXyVJ9kbnjKGDRg5GGRsGXY9i/Ru7powXeIzLXe2dkeo7BkcEgaNMk+LE8hah9CWV6P1i98jQfalLPs0K6F4ELvV2zliLrEkefwvyv0QVnHpuB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7XeDEs3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-467838e75ffso67797411cf.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 02:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736850656; x=1737455456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/4EbrSOAJuIZk8J336Lg0KE8WAdSupSpKD+eDZUg64=;
        b=E7XeDEs3lfVQj8tpIbkw6vldz2m9p4Rzo3NTNjDFYcR+KigXQ+NujSYKpPOn49pK39
         S5aPaTqHjYyduivTKkgFDLWNNngXhC/R2BlvI36OCRfxH61v4NVP08ZFx6dKR51QT+Iu
         Ww0y4mgSCwzCn9SGKyEootdT52Jh1PoUD2iXPzWXIy4nlWPjdCqzH5RrG2x43GVk3D5W
         erAQTire355lS5uBPL/G9a1ysl+mkoIOJFazzUJiz5/lgrJUyeZo0i1KSJIxXEPFl/Jb
         keW52XYRCG9Ji73Eqiih27pc+7g5Lq4O7u2rkUZy9AsONIXXlFFZBvYt6zrfvYo3ptGj
         49lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736850656; x=1737455456;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v/4EbrSOAJuIZk8J336Lg0KE8WAdSupSpKD+eDZUg64=;
        b=Eu6qdGBAd7PO/UBJoKE8QxpyaBsZYQ4ezYdSCxPhzzaxHBJBKK9d9whtHmigIzowk4
         Sc//PBD0ZK7YnsPYnHUEs1T3B5wG71iPMAcJVKv66HFqaU4TVel+5hWqqejC/YqVxkiB
         G3XnxXY+gh9SHperJ7NvIXIPwNzO8LRbtZYFdVuyA6NUKh4S16KpElp7UwI9i5aVjLt7
         EG8KweiabgDieb88frevDP7GsxSiYmsJAy9iKCEMecvHyBo37nZkVsuKWzLBUhi7TXGn
         knqUEUN0LWWpeKEYUMhf/VBMM3Pt5CACp4veF9GKbMYFbDzmkDwWSMzz+2gb9i+dc6mw
         raJA==
X-Gm-Message-State: AOJu0YybGHGroKbVojEL/uiNjANvF/K6TcxHM4DivR2e+5NwebaBU4pB
	o1itE8ZcZZhRBftqa1cG2iOtNeb+9cRxASez0AvtBHuamiI6ZhZzMBUeOw==
X-Gm-Gg: ASbGncsV4pBGaqEp5rPmfxwVJuDwmY9HN5W0HvCRuWiwazvpUTZXN3rA2g7CmvsFWUw
	oTZ0aoPE/J4zibfnP+HuO9Tba+jT1Bd0aFMlcEhRw74scWV9Wpacsf4FqM7AQa5Ieb8QUK4YaKV
	zGpbgiQggy5VFYfQNn14r7qTayq/hPmtOIDovsvN3loBDwjdlI1qkM9qBOTJRhHVAylIA+b/YZp
	Dlz9Db/9yxyJbR/1Jzi3CsX5lrBmEcHvubUDxlRnaYzWRdg+ED5RCV03jOsmmglG43xunBruw7d
	JmoFrzHKR1YrsbCVolJ3ZrSer5ax
X-Google-Smtp-Source: AGHT+IGKcw3Ff7Jh3eUNUtLu+QxKCy5Q809X88yQe8ynUKKWz6XASkFOWN6HpUOp3ZMx+3z2EPZy4w==
X-Received: by 2002:a05:622a:1a06:b0:466:9824:16ef with SMTP id d75a77b69052e-46c70fd2960mr401622621cf.3.1736850655833;
        Tue, 14 Jan 2025 02:30:55 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad88142asm51579396d6.27.2025.01.14.02.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 02:30:54 -0800 (PST)
Date: Tue, 14 Jan 2025 05:30:54 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Olech, Milena" <milena.olech@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 "Hay, Joshua A" <joshua.a.hay@intel.com>
Message-ID: <67863cde6f20b_231a7929448@willemb.c.googlers.com.notmuch>
In-Reply-To: <MW4PR11MB5889B67F0F83D75AC91DE9B78E1F2@MW4PR11MB5889.namprd11.prod.outlook.com>
References: <20241219094411.110082-1-milena.olech@intel.com>
 <20241219094411.110082-9-milena.olech@intel.com>
 <677d4042a293e_25382b2948@willemb.c.googlers.com.notmuch>
 <MW4PR11MB58891AC5F86EFECEA76B58D38E1C2@MW4PR11MB5889.namprd11.prod.outlook.com>
 <67819233d3382_34732294ca@willemb.c.googlers.com.notmuch>
 <MW4PR11MB5889B67F0F83D75AC91DE9B78E1F2@MW4PR11MB5889.namprd11.prod.outlook.com>
Subject: RE: [PATCH v3 iwl-next 08/10] idpf: add Tx timestamp flows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Olech, Milena wrote:
> On 01/10/2025 10:34PM Willem de Bruijn wrote:
> 
> > > > > Add functions to request Tx timestamp for the PTP packets, read the Tx
> > > > > timestamp when the completion tag for that packet is being received,
> > > > > extend the Tx timestamp value and set the supported timestamping modes.
> > > > > 
> > > > > Tx timestamp is requested for the PTP packets by setting a TSYN bit and
> > > > > index value in the Tx context descriptor. The driver assumption is that
> > > > > the Tx timestamp value is ready to be read when the completion tag is
> > > > > received. Then the driver schedules delayed work and the Tx timestamp
> > > > > value read is requested through virtchnl message. At the end, the Tx
> > > > > timestamp value is extended to 64-bit and provided back to the skb.
> > > > > 
> > > > > Co-developed-by: Josh Hay <joshua.a.hay@intel.com>
> > > > > Signed-off-by: Josh Hay <joshua.a.hay@intel.com>
> > > > > Signed-off-by: Milena Olech <milena.olech@intel.com>
> > > > > ---
> > > > > v2 -> v3: change get_timestamp_filter function name, split stats
> > > > > into vport-based and tx queue-based
> > > > > v1 -> v2: add timestamping stats, use ndo_hwtamp_get/ndo_hwstamp_set
> > > > > 
> > > > >  drivers/net/ethernet/intel/idpf/idpf.h        |  20 ++
> > > > >  .../net/ethernet/intel/idpf/idpf_ethtool.c    |  69 ++++-
> > > > >  .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
> > > > >  drivers/net/ethernet/intel/idpf/idpf_lib.c    |  47 ++++
> > > > >  drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 236 +++++++++++++++++-
> > > > >  drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  52 ++++
> > > > >  drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 139 ++++++++++-
> > > > >  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  11 +-
> > > > >  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   6 +-
> > > > >  .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 235 +++++++++++++++++
> > > > >  10 files changed, 814 insertions(+), 14 deletions(-)
> > > > > 
> > > > 
> > > > > +/**
> > > > > + * idpf_get_timestamp_filters - Get the supported timestamping mode
> > > > > + * @vport: Virtual port structure
> > > > > + * @info: ethtool timestamping info structure
> > > > > + *
> > > > > + * Get the Tx/Rx timestamp filters.
> > > > > + */
> > > > > +static void idpf_get_timestamp_filters(const struct idpf_vport *vport,
> > > > > +				       struct kernel_ethtool_ts_info *info)
> > > > > +{
> > > > > +	if (!vport->tx_tstamp_caps ||
> > > > > +	    vport->adapter->ptp->tx_tstamp_access == IDPF_PTP_NONE)
> > > > > +		return;
> > > > 
> > > > Is making SOF_TIMESTAMPING_RX_HARDWARE and SOF_TIMESTAMPING_RAW_HARDWARE
> > > > conditional on tx_tstamp_access intentional?
> > > 
> > > Hmmm, good catch.
> > > I guess I will change the SOF_TIMESTAMPING_RX_HARDWARE to be not
> > > conditional.
> > > 
> > > About the SOF_TIMESTAMPING_RAW_HARDWARE - it should rely on the
> > > tx_statmp_access.
> >
> > For Tx, but it also applies to Rx.
> 
> Right, there was a misunderstanding because the documentation says:
> "Report hardware timestamps as generated by
>  SOF_TIMESTAMPING_TX_HARDWARE when available."
> 
> So I assumed that it's Tx only.

Indeed. This was fixed fairly recently in commit e503f82e304b. It now
reads

"
SOF_TIMESTAMPING_RAW_HARDWARE:
  Report hardware timestamps as generated by
  SOF_TIMESTAMPING_TX_HARDWARE or SOF_TIMESTAMPING_RX_HARDWARE
  when available.
"

 
> > > > > +
> > > > > +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> > > > > +				SOF_TIMESTAMPING_TX_HARDWARE |
> > > > > +				SOF_TIMESTAMPING_RX_HARDWARE |
> > > > > +				SOF_TIMESTAMPING_RAW_HARDWARE;
> > > > > +
> > > > > +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> > > > > +}
> > > > > +
> > > > > +
> > > > > +static int idpf_hwtstamp_get(struct net_device *netdev,
> > > > > +			     struct kernel_hwtstamp_config *config)
> > > > > +{
> > > > > +	struct idpf_adapter *adapter = idpf_netdev_to_adapter(netdev);
> > > > > +	struct idpf_vport *vport;
> > > > > +
> > > > > +	idpf_vport_cfg_lock(adapter);
> > > > > +	vport = idpf_netdev_to_vport(netdev);
> > > > > +
> > > > > +	if (!idpf_ptp_get_vport_tstamp_capability(vport)) {
> > > > > +		idpf_vport_cfg_unlock(adapter);
> > > > > +		return -EOPNOTSUPP;
> > > > 
> > > > Should this return an empty config and return 0, rather than return
> > > > error?
> > > > 
> > > 
> > > I'd prefer to return NOTSUPP, as the feature itself relies on the CP
> > > policy.
> > 
> > Does that make ethtool -T $DEV fail? It should ideally succeed while
> > only advertising software receive timestamping (which is implemented
> > device independent).
> 
> Ok, I'll change then.

I did not actually check whether it would return in failure at the
application layer, to be clear. Just saying that if that would be the
consequence, then that would not be good.

> > > > > +/**
> > > > > + * idpf_ptp_tstamp_extend_32b_to_64b - Convert a 32b nanoseconds Tx timestamp
> > > > > + *				       to 64b.
> > > > > + * @cached_phc_time: recently cached copy of PHC time
> > > > > + * @in_timestamp: Ingress/egress 32b nanoseconds timestamp value
> > > > > + *
> > > > > + * Hardware captures timestamps which contain only 32 bits of nominal
> > > > > + * nanoseconds, as opposed to the 64bit timestamps that the stack expects.
> > > > > + *
> > > > > + * Return: Tx timestamp value extended to 64 bits based on cached PHC time.
> > > > > + */
> > > > > +u64 idpf_ptp_tstamp_extend_32b_to_64b(u64 cached_phc_time, u32 in_timestamp)
> > > > > +{
> > > > > +	u32 delta, phc_lo;
> > > > > +	u64 ns;
> > > > > +
> > > > > +	phc_lo = lower_32_bits(cached_phc_time);
> > > > > +	delta = in_timestamp - phc_lo;
> > > > > +
> > > > > +	if (delta > S32_MAX) {
> > > > > +		delta = phc_lo - in_timestamp;
> > > > > +		ns = cached_phc_time - delta;
> > > > > +	} else {
> > > > > +		ns = cached_phc_time + delta;
> > > > > +	}
> > > > 
> > > > If using s64 delta and ns, no need for branch?
> > > 
> > > To make it more readable, I'll change the condition in v4.
> > > I'll check if the phc_lo is greater than in_stamp.
> > > 
> > > If phc_lo is bigger, then tx tstamp value was captured before
> > > caching PHC time and case 1 will be applicable.
> > 
> > My point is that with signed arithmetic there is no need to
> > invert delta and switch from addition to deletion.
> 
> This ns value is used - at the end of the day - in ns_to_ktime function,
> which requires u64, so IMO it is easier to differentiate at this point,
> rather than introducing new logic in f.e. idpf_ptp_extend_ts.
> 
> But to remove this condition signed delta is enough, and it may work.

Just a suggestion. Feel free to leave as is if you prefer.

