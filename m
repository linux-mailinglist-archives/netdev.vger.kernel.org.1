Return-Path: <netdev+bounces-154189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90F59FBFDC
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADD3165CC8
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F801B0F1E;
	Tue, 24 Dec 2024 16:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJleuEGP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8A86326
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056023; cv=none; b=bpKR5rvq4Efayn6IQqIa5A9x8k7c+0mzEIzRkhUzkBD1a9C90j7n0xEEe2HeYTfm5xq1v4vx8jAqNy1MlLDX1sLp1VrblV74exB8VC21WmK+xwLWnS9bI7Qh4IcAB2g5BxKTNwsw65mNcz5VtroI9h9G2aCHnwVAjeKP17PkzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056023; c=relaxed/simple;
	bh=S6/k/CV5q8zu+ECD4dgNprEzKlldHbIIIyyqP23+sRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8tgILHQ7NVqujJPYT4Ih1A9jjFT9nOZ3oHMf+SmKOTPaJuJzQukA8bfHuV5MA70eOU14uhwMB5HRT+tnG6BLXeJuO3YAoefSHV3WQ/it1O/0gWirdFPu8Er5K0iy0+LQigLSIlm2G+V0L8N+ewX7eE3zjIT9L+lb2Pu5LzlwVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJleuEGP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa67bc91f87so87726566b.1
        for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 08:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735056020; x=1735660820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vttUJ5ULPn241NPrstO/qKrmuW43SdJKTX0aJlH+Lgo=;
        b=mJleuEGPVXpfWz2FSEZLISyVPiTuKtl4UGgJRiHTmw6qs2dvZ29HBruxc099XY3IUV
         VohEcrfTQhXaBC7g82yuu5XOaI7d0K442jnzxW/49DDYbz1J79xq2PtG5KGLobG8lgIm
         UmQpez+nbsIIGrIwVi0nUDv//cQ98Bf4wcwecM9WNfiaf9J6DCKw3NQKUNMssL014Mas
         hi5LKa5oxUhN0NlHLnlItYeNoBNvQ3fC3ZzYM3t2as+UaPM7h1i2/4KTFZXSaI3Vhw1q
         KyfAfGCSE+ZzkZVyiArWcXYfcFKXQ28A53VHhwKfXTtMC+J7VxNnx4vQhb/GIMrf2cNH
         Wodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735056020; x=1735660820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vttUJ5ULPn241NPrstO/qKrmuW43SdJKTX0aJlH+Lgo=;
        b=SDkfAwjgK/WMXiuxvJEVYZMkcYxdsRV1nRv0ylibtLwXUGVobeBXMAgNeJ0qF4gLid
         q1mYrBoIpJpmX0zNx3NHMhgimxEyY1BaDHmcrmapRADHFI+iXWTyDn5XjGzXxaxFAEGx
         M/S1uKAltU480YGFL+nqtfpTWIiLv5IYMsilDCLhlG4WhNSdmOehT9xtz/djkZO1TY0X
         hZf+UU9GK1x+TZJcObW0Dfr79EfrlLIn6R2+OlU5M/lB11AeXnbk7/ibUPoMZ58VW0kd
         P/6ISnh2e1MR1eKSWZEREHO50xDWOJJzXoyCjXoeL4POnBdH9L5TEorbYI0XHeJCqrQJ
         ixJg==
X-Gm-Message-State: AOJu0Yw6a5h0UyFitsA2lrmGRwpaB+vF6OYDrMf3QWgsv/YRkHOIAGTf
	dT1K1Tad7QOyUOL2zaT1He5s/EGYx2OaUJozLmJF4eOofigNzMCw
X-Gm-Gg: ASbGncu0NkExNcsOBkmyr8m/ZPo8SeKAuYhz05xuE39Vk5emnET38lp3fywlXjovawc
	xOiLB3HUYTdoTwVvcRiPwFv5cbcpYb+v5DA8B1tRRKPCi2kMnHixT6MTCKEmJVYY0QrNpAJ1vEv
	jCFB9QRatqQ9yovhQaTKCUwdP9Y1R/mFFJ7kUPAR5YZHi/6CmYiW8IbDAqL2eCZlnPuv91w7NHg
	iNmt6IFYgqwa0ThRm7wYGSrl9XQXRjCTQKxAyCWVlge
X-Google-Smtp-Source: AGHT+IFNeTGe2oyPMcZ0+hX0swmQ5zffRnyKQErK3aOTKFIugU0qeT4yzUTxn6CTeZayhlT2hXg2xg==
X-Received: by 2002:a17:907:2d26:b0:aa6:8f79:713e with SMTP id a640c23a62f3a-aac2d42f207mr507722066b.8.1735056019691;
        Tue, 24 Dec 2024 08:00:19 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f05fd7csm671255566b.172.2024.12.24.08.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 08:00:18 -0800 (PST)
Date: Tue, 24 Dec 2024 18:00:16 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: sai kumar <skmr537@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: DSA Switch: query: Switch configuration, data plane doesn't work
 whereas control plane works
Message-ID: <20241224160016.2ufkj5w5a4okblhg@skbuf>
References: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
 <20241224120049.bjcxfqrwaaxazosw@skbuf>
 <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
 <20241224120049.bjcxfqrwaaxazosw@skbuf>
 <CAA=kqW++FYvBfWU8c111pdYVFJk5=rhF5R5_N+wk5uUs=3fo=g@mail.gmail.com>
 <CAA=kqW++FYvBfWU8c111pdYVFJk5=rhF5R5_N+wk5uUs=3fo=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=kqW++FYvBfWU8c111pdYVFJk5=rhF5R5_N+wk5uUs=3fo=g@mail.gmail.com>
 <CAA=kqW++FYvBfWU8c111pdYVFJk5=rhF5R5_N+wk5uUs=3fo=g@mail.gmail.com>

On Tue, Dec 24, 2024 at 06:20:38PM +0530, sai kumar wrote:
> Thanks Vladimir for your inputs.
> 
> I tried checking the statistics, the in_broadcasts count increases
> with respect to client dhcp discover broadcasts.
> But the same is not happening with external cpu port eth1, the eth1
> in_broadcasts and in_accepted are 0 , Observing the rx frame errors on
> eth1 but
> this count doesn't match to the clients broadcast packets count.
> 
> ethtool -S lan1
> NIC statistics:
>      tx_packets: 7
>      tx_bytes: 626
>      rx_packets: 0
>      rx_bytes: 0
>      in_good_octets: 18112
>      in_bad_octets: 0
>      in_unicast: 0
>      in_broadcasts: 51
>      in_multicasts: 5
>      in_pause: 0
>      in_undersize: 0
>      in_fragments: 0
>      in_oversize: 0
>      in_jabber: 0
>      in_rx_error: 0
>      in_fcs_error: 0
>      out_octets: 7792
>      out_unicast: 0
>      out_broadcasts: 105
>      out_multicasts: 12
>      out_pause: 0
>      excessive: 0
>      collisions: 0
>      deferred: 0
>      single: 0
>      multiple: 0
>      out_fcs_error: 0
>      late: 0
>      hist_64bytes: 105
>      hist_65_127bytes: 17
>      hist_128_255bytes: 0
>      hist_256_511bytes: 51
>      hist_512_1023bytes: 0
>      hist_1024_max_bytes: 0
>      in_discards: 0
>      in_filtered: 0
>      in_accepted: 56
>      in_bad_accepted: 0
>      in_good_avb_class_a: 0
>      in_good_avb_class_b: 0
>      in_bad_avb_class_a: 0
>      in_bad_avb_class_b: 0
>      tcam_counter_0: 0
>      tcam_counter_1: 0
>      tcam_counter_2: 0
>      tcam_counter_3: 0
>      in_da_unknown: 5
>      in_management: 4
>      out_queue_0: 117
>      out_queue_1: 0
>      out_queue_2: 0
>      out_queue_3: 0
>      out_queue_4: 0
>      out_queue_5: 0
>      out_queue_6: 0
>      out_queue_7: 0
>      out_cut_through: 0
>      out_octets_a: 0
>      out_octets_b: 0
>      out_management: 0
>      atu_member_violation: 0
>      atu_miss_violation: 0
>      atu_full_violation: 0
>      vtu_member_violation: 0
>      vtu_miss_violation: 0
> 
> 
> ethtool -S eth1
> NIC statistics:
>      interrupts [CPU 0]: 12
>      interrupts [CPU 1]: 9
>      interrupts [CPU 2]: 5
>      interrupts [CPU 3]: 7
>      interrupts [TOTAL]: 33
>      rx packets [CPU 0]: 0
>      rx packets [CPU 1]: 0
>      rx packets [CPU 2]: 0
>      rx packets [CPU 3]: 0
>      rx packets [TOTAL]: 0
>      tx packets [CPU 0]: 2
>      tx packets [CPU 1]: 0
>      tx packets [CPU 2]: 12
>      tx packets [CPU 3]: 0
>      tx packets [TOTAL]: 14
>      tx recycled [CPU 0]: 0
>      tx recycled [CPU 1]: 0
>      tx recycled [CPU 2]: 0
>      tx recycled [CPU 3]: 0
>      tx recycled [TOTAL]: 0
>      tx confirm [CPU 0]: 6
>      tx confirm [CPU 1]: 3
>      tx confirm [CPU 2]: 2
>      tx confirm [CPU 3]: 3
>      tx confirm [TOTAL]: 14
>      tx S/G [CPU 0]: 0
>      tx S/G [CPU 1]: 0
>      tx S/G [CPU 2]: 0
>      tx S/G [CPU 3]: 0
>      tx S/G [TOTAL]: 0
>      rx S/G [CPU 0]: 0
>      rx S/G [CPU 1]: 0
>      rx S/G [CPU 2]: 0
>      rx S/G [CPU 3]: 0
>      rx S/G [TOTAL]: 0
>      tx error [CPU 0]: 0
>      tx error [CPU 1]: 0
>      tx error [CPU 2]: 0
>      tx error [CPU 3]: 0
>      tx error [TOTAL]: 0
>      rx error [CPU 0]: 6
>      rx error [CPU 1]: 6
>      rx error [CPU 2]: 3
>      rx error [CPU 3]: 4
>      rx error [TOTAL]: 19
>      bp count [CPU 0]: 128
>      bp count [CPU 1]: 128
>      bp count [CPU 2]: 128
>      bp count [CPU 3]: 128
>      bp count [TOTAL]: 512
>      rx dma error: 0
>      rx frame physical error: 2
>      rx frame size error: 17
>      rx header error: 0
>      rx csum error: 0
>      qman cg_tdrop: 0
>      qman wred: 0
>      qman error cond: 0
>      qman early window: 0
>      qman late window: 0
>      qman fq tdrop: 0
>      qman fq retired: 0
>      qman orp disabled: 0
>      congestion time (ms): 0
>      entered congestion: 0
>      congested (0/1): 0
>      p00_in_good_octets: 0
>      p00_in_bad_octets: 2
>      p00_in_unicast: 0
>      p00_in_broadcasts: 0
>      p00_in_multicasts: 0
>      p00_in_pause: 0
>      p00_in_undersize: 0
>      p00_in_fragments: 0
>      p00_in_oversize: 0
>      p00_in_jabber: 0
>      p00_in_rx_error: 1
>      p00_in_fcs_error: 0
>      p00_out_octets: 45440
>      p00_out_unicast: 0
>      p00_out_broadcasts: 312
>      p00_out_multicasts: 63
>      p00_out_pause: 0
>      p00_excessive: 0
>      p00_collisions: 0
>      p00_deferred: 0
>      p00_single: 0
>      p00_multiple: 0
>      p00_out_fcs_error: 0
>      p00_late: 0
>      p00_hist_64bytes: 0
>      p00_hist_65_127bytes: 306
>      p00_hist_128_255bytes: 8
>      p00_hist_256_511bytes: 61
>      p00_hist_512_1023bytes: 0
>      p00_hist_1024_max_bytes: 0
>      p00_in_discards: 0
>      p00_in_filtered: 0
>      p00_in_accepted: 0
>      p00_in_bad_accepted: 0
>      p00_in_good_avb_class_a: 0
>      p00_in_good_avb_class_b: 0
>      p00_in_bad_avb_class_a: 0
>      p00_in_bad_avb_class_b: 0
>      p00_tcam_counter_0: 0
>      p00_tcam_counter_1: 0
>      p00_tcam_counter_2: 0
>      p00_tcam_counter_3: 0
>      p00_in_da_unknown: 0
>      p00_in_management: 0
>      p00_out_queue_0: 373
>      p00_out_queue_1: 0
>      p00_out_queue_2: 0
>      p00_out_queue_3: 0
>      p00_out_queue_4: 0
>      p00_out_queue_5: 0
>      p00_out_queue_6: 2
>      p00_out_queue_7: 0
>      p00_out_cut_through: 0
>      p00_out_octets_a: 0
>      p00_out_octets_b: 0
>      p00_out_management: 11
>      p00_atu_member_violation: 0
>      p00_atu_miss_violation: 0
>      p00_atu_full_violation: 0
>      p00_vtu_member_violation: 0
>      p00_vtu_miss_violation: 0

Hmmm....

I recognize the ethtool stats as belonging to the DPAA1 Ethernet driver.

And I see that the Marvell 6390 has undocumented EDSA tag support, thus
using DSA (with no EtherType) by default. This reminds me of this
discussion with Tobias Waldekranz. The FMan parser sees errors due to
the somewhat controversial Marvell original DSA tag decisions:
https://lore.kernel.org/netdev/20210323102326.3677940-1-tobias@waldekranz.com/

Could you please force EDSA with this switch and see if the packet loss
situation improves? Simplest way would be:

ip link set eth0 down
echo edsa > /sys/class/net/eth0/dsa/tagging
ip link set lan1 up

If this helps, I would recommend reading
Documentation/devicetree/bindings/net/dsa/dsa-port.yaml to see how to
make this board use edsa persistently.

