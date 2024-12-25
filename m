Return-Path: <netdev+bounces-154247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E649FC447
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630A81640FD
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50A614F125;
	Wed, 25 Dec 2024 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXKN/LkX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C811494B2
	for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735116809; cv=none; b=Uu8OPXxEZw8SCIPo0+sKQNJP8TR+GzsxzCnbmlekNFcvvBgp46L/XG1mM6WDavVuTt11lacIbag1ZxdaEoA3v6Yomw6PQSVuvX4iIV+ET1o+/rjIDoWfNh63fcdGIZ9icXMEMjOVPGWyg6D9VW9x+UZaMbrtegIHkVD35I31V7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735116809; c=relaxed/simple;
	bh=gLhdJJNfe1L4EB076JnIkPOvwVC7sBqr+aTcZ25YGGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMecBzqJ68zc3CPuYTKjh/SLSOJgqsy9LG20aGuGKN1cA0h23uJDZoYJmryZMmOBbB7VdkvFSkgr+prJo+rI30ybzU/MpHO6sBefRbzLozEQs+PwDUZoKrTSdO2CtA7u+lNDWqCuJ81ZZV6CwEjzh8eySmxZgGyYEdiwFoNLxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXKN/LkX; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3990bbe22cso5148418276.1
        for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735116805; x=1735721605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky7B+jGcAxFB2+8nbZldePzzMlgfQ9Ac5LpdsZtgixM=;
        b=mXKN/LkXmCfkLXNNw04ntzuSe7YazJGaqcqoVljx8CiPfpVjVL8b6eIFtvyNzn7eL9
         DeS6ZRi+AvX58M0CqbL2/aKIspR23gwPwszlds81eyOsb5FRHxxGQC/qV5lkEqauIGKm
         HhB1dQ2Ht0bLC7DSjemsT2Z5QyLZqEcDrjKcR36l4Re/6qmDdlmNbn317plgJ5XVNkqA
         lzfl8SFdj0qVtQiY2IZ+rIYFshS94+4058QW0NI8KrJ1HVw7ewZuac03IgY8gH2mkDSm
         PJMpwOIzkZCSYW4y3tMGUnW0krPxVVfzBoiGFIqubQggDi7+4IS8E2VkDoxM4irfNunW
         MEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735116805; x=1735721605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ky7B+jGcAxFB2+8nbZldePzzMlgfQ9Ac5LpdsZtgixM=;
        b=kNebZkJkWrRXguRxUaL4Tnkp4v6Pa9IX/PyjFCqmkQKbFEmKXMlZjuDyNblGcuUEZb
         1ETSrWM8Ok7B4rxTpnkCwBl+DPcS4NV9LbBZzIML0eP4cgB7Z4S3U8OT/zMmAkTkNjyd
         Q+hHELHDfHOvKQ9Mo2pHJIEyjy8hwpwdvYKaAXKXBiu1EYE0S5fUJbe9wk/2RaAo9wm9
         UD2SUVXzYNvrmFziQvCGhdnLRZeB+wbfinF+tRpUe0hoYSrqi47O3qaleEkW1TBwG+VF
         v/vwRlRxPB0TQPxsq/dBxblhqp6qa0tmUzsQOEjyrjbF43Ubex6ew8873dV1d1u+aUTu
         pr3w==
X-Gm-Message-State: AOJu0YzpsoXs2s4lE/1pqWIUHr2ICuG0+yh8RdkdewlIj9T7ZvuzLdAh
	4EK9B0XskH5Eikfqv3exMmbVYRLrTKBe/mtxaru0nMlJb3rHWnvQGhEZ2aqC16xsRNnuZmsqWeB
	Dag1VJU9TDZEaTOSj+H5i3w427PGOtmwT
X-Gm-Gg: ASbGnctl65+VXtW3pJB+bQmeNzzAvu1A778FUBlcRCii6Cl0NB+iU+NhS7S/3ma4Bu3
	8XZT5bufMTZ4U09Ce4AgyeHPuwnmGjgcI1iV1
X-Google-Smtp-Source: AGHT+IFet4aSIuffxHr+X850oKhquptMSRt/HvnQlXvpaJ7r5XxJrW1qfQm0eXnNiHaKp9aakwPAfXSmi3BnB1En7Dw=
X-Received: by 2002:a25:2747:0:b0:e49:5f2d:e72c with SMTP id
 3f1490d57ef6-e53b4445abamr5044295276.1.1735116804758; Wed, 25 Dec 2024
 00:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
 <20241224120049.bjcxfqrwaaxazosw@skbuf> <CAA=kqW++FYvBfWU8c111pdYVFJk5=rhF5R5_N+wk5uUs=3fo=g@mail.gmail.com>
 <20241224160016.2ufkj5w5a4okblhg@skbuf>
In-Reply-To: <20241224160016.2ufkj5w5a4okblhg@skbuf>
From: sai kumar <skmr537@gmail.com>
Date: Wed, 25 Dec 2024 14:23:13 +0530
Message-ID: <CAA=kqW+9Esn_e063evZVdhW9yjN+hC69Jj4KnM6SB8CZYwg03A@mail.gmail.com>
Subject: Re: DSA Switch: query: Switch configuration, data plane doesn't work
 whereas control plane works
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Vladimir for your inputs.

While trying to follow your suggestion to update the device tree with
dsa-tag-protocol =3D "edsa";

Found there is a mismatch with respect to phymode; in cpu port port 0
phy-mode =3D "rgmii-id"; and fman enet phy-connection-type =3D "rgmii";

I tried changing the phy-mode of switch cpu port to match fman enet phy mod=
e,

Now the switch works as expected and dhcp discover of client connected
to port 1 reaches external cpu enet port eth1 with even tag protocol
as dsa.
and errors vanished on eth1.

Somehow this missed the radar earlier since eth1 link got up quietly,
and didn't observe any error in dmesg with respect to phymode mismatch
between fman eth1 and switch cpu port 0.

Thanks for your help for immediate responses.

cat /sys/class/net/eth1/dsa/tagging
dsa

ethtool -S eth1
NIC statistics:
     interrupts [CPU 0]: 33
     interrupts [CPU 1]: 19
     interrupts [CPU 2]: 15
     interrupts [CPU 3]: 24
     interrupts [TOTAL]: 91
     rx packets [CPU 0]: 16
     rx packets [CPU 1]: 11
     rx packets [CPU 2]: 9
     rx packets [CPU 3]: 18
     rx packets [TOTAL]: 54
     tx packets [CPU 0]: 1
     tx packets [CPU 1]: 21
     tx packets [CPU 2]: 10
     tx packets [CPU 3]: 5
     tx packets [TOTAL]: 37
     tx recycled [CPU 0]: 0
     tx recycled [CPU 1]: 0
     tx recycled [CPU 2]: 0
     tx recycled [CPU 3]: 0
     tx recycled [TOTAL]: 0
     tx confirm [CPU 0]: 17
     tx confirm [CPU 1]: 8
     tx confirm [CPU 2]: 6
     tx confirm [CPU 3]: 6
     tx confirm [TOTAL]: 37
     tx S/G [CPU 0]: 0
     tx S/G [CPU 1]: 0
     tx S/G [CPU 2]: 0
     tx S/G [CPU 3]: 0
     tx S/G [TOTAL]: 0
     rx S/G [CPU 0]: 0
     rx S/G [CPU 1]: 0
     rx S/G [CPU 2]: 0
     rx S/G [CPU 3]: 0
     rx S/G [TOTAL]: 0
     tx error [CPU 0]: 0
     tx error [CPU 1]: 0
     tx error [CPU 2]: 0
     tx error [CPU 3]: 0
     tx error [TOTAL]: 0
     rx error [CPU 0]: 0
     rx error [CPU 1]: 0
     rx error [CPU 2]: 0
     rx error [CPU 3]: 0
     rx error [TOTAL]: 0
     bp count [CPU 0]: 112
     bp count [CPU 1]: 117
     bp count [CPU 2]: 119
     bp count [CPU 3]: 110
     bp count [TOTAL]: 458
     rx dma error: 0
     rx frame physical error: 0
     rx frame size error: 0
     rx header error: 0
     rx csum error: 0
     qman cg_tdrop: 0
     qman wred: 0
     qman error cond: 0
     qman early window: 0
     qman late window: 0
     qman fq tdrop: 0
     qman fq retired: 0
     qman orp disabled: 0
     congestion time (ms): 0
     entered congestion: 0
     congested (0/1): 0
     p00_in_good_octets: 2404
     p00_in_bad_octets: 0
     p00_in_unicast: 0
     p00_in_broadcasts: 0
     p00_in_multicasts: 24
     p00_in_pause: 0
     p00_in_undersize: 0
     p00_in_fragments: 0
     p00_in_oversize: 0
     p00_in_jabber: 0
     p00_in_rx_error: 0
     p00_in_fcs_error: 0
     p00_out_octets: 14374
     p00_out_unicast: 0
     p00_out_broadcasts: 37
     p00_out_multicasts: 14
     p00_out_pause: 0
     p00_excessive: 0
     p00_collisions: 0
     p00_deferred: 0
     p00_single: 0
     p00_multiple: 0
     p00_out_fcs_error: 0
     p00_late: 0
     p00_hist_64bytes: 0
     p00_hist_65_127bytes: 38
     p00_hist_128_255bytes: 0
     p00_hist_256_511bytes: 37
     p00_hist_512_1023bytes: 0
     p00_hist_1024_max_bytes: 0
     p00_in_discards: 0
     p00_in_filtered: 0
     p00_in_accepted: 24
     p00_in_bad_accepted: 0
     p00_in_good_avb_class_a: 0
     p00_in_good_avb_class_b: 0
     p00_in_bad_avb_class_a: 0
     p00_in_bad_avb_class_b: 0
     p00_tcam_counter_0: 0
     p00_tcam_counter_1: 0
     p00_tcam_counter_2: 0
     p00_tcam_counter_3: 0
     p00_in_da_unknown: 24
     p00_in_management: 15
     p00_out_queue_0: 46
     p00_out_queue_1: 0
     p00_out_queue_2: 0
     p00_out_queue_3: 5
     p00_out_queue_4: 0
     p00_out_queue_5: 0
     p00_out_queue_6: 0
     p00_out_queue_7: 0
     p00_out_cut_through: 0
     p00_out_octets_a: 0
     p00_out_octets_b: 0
     p00_out_management: 13
     p00_atu_member_violation: 0
     p00_atu_miss_violation: 0
     p00_atu_full_violation: 0
     p00_vtu_member_violation: 0
     p00_vtu_miss_violation: 0

On Tue, Dec 24, 2024 at 9:30=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Tue, Dec 24, 2024 at 06:20:38PM +0530, sai kumar wrote:
> > Thanks Vladimir for your inputs.
> >
> > I tried checking the statistics, the in_broadcasts count increases
> > with respect to client dhcp discover broadcasts.
> > But the same is not happening with external cpu port eth1, the eth1
> > in_broadcasts and in_accepted are 0 , Observing the rx frame errors on
> > eth1 but
> > this count doesn't match to the clients broadcast packets count.
> >
> > ethtool -S lan1
> > NIC statistics:
> >      tx_packets: 7
> >      tx_bytes: 626
> >      rx_packets: 0
> >      rx_bytes: 0
> >      in_good_octets: 18112
> >      in_bad_octets: 0
> >      in_unicast: 0
> >      in_broadcasts: 51
> >      in_multicasts: 5
> >      in_pause: 0
> >      in_undersize: 0
> >      in_fragments: 0
> >      in_oversize: 0
> >      in_jabber: 0
> >      in_rx_error: 0
> >      in_fcs_error: 0
> >      out_octets: 7792
> >      out_unicast: 0
> >      out_broadcasts: 105
> >      out_multicasts: 12
> >      out_pause: 0
> >      excessive: 0
> >      collisions: 0
> >      deferred: 0
> >      single: 0
> >      multiple: 0
> >      out_fcs_error: 0
> >      late: 0
> >      hist_64bytes: 105
> >      hist_65_127bytes: 17
> >      hist_128_255bytes: 0
> >      hist_256_511bytes: 51
> >      hist_512_1023bytes: 0
> >      hist_1024_max_bytes: 0
> >      in_discards: 0
> >      in_filtered: 0
> >      in_accepted: 56
> >      in_bad_accepted: 0
> >      in_good_avb_class_a: 0
> >      in_good_avb_class_b: 0
> >      in_bad_avb_class_a: 0
> >      in_bad_avb_class_b: 0
> >      tcam_counter_0: 0
> >      tcam_counter_1: 0
> >      tcam_counter_2: 0
> >      tcam_counter_3: 0
> >      in_da_unknown: 5
> >      in_management: 4
> >      out_queue_0: 117
> >      out_queue_1: 0
> >      out_queue_2: 0
> >      out_queue_3: 0
> >      out_queue_4: 0
> >      out_queue_5: 0
> >      out_queue_6: 0
> >      out_queue_7: 0
> >      out_cut_through: 0
> >      out_octets_a: 0
> >      out_octets_b: 0
> >      out_management: 0
> >      atu_member_violation: 0
> >      atu_miss_violation: 0
> >      atu_full_violation: 0
> >      vtu_member_violation: 0
> >      vtu_miss_violation: 0
> >
> >
> > ethtool -S eth1
> > NIC statistics:
> >      interrupts [CPU 0]: 12
> >      interrupts [CPU 1]: 9
> >      interrupts [CPU 2]: 5
> >      interrupts [CPU 3]: 7
> >      interrupts [TOTAL]: 33
> >      rx packets [CPU 0]: 0
> >      rx packets [CPU 1]: 0
> >      rx packets [CPU 2]: 0
> >      rx packets [CPU 3]: 0
> >      rx packets [TOTAL]: 0
> >      tx packets [CPU 0]: 2
> >      tx packets [CPU 1]: 0
> >      tx packets [CPU 2]: 12
> >      tx packets [CPU 3]: 0
> >      tx packets [TOTAL]: 14
> >      tx recycled [CPU 0]: 0
> >      tx recycled [CPU 1]: 0
> >      tx recycled [CPU 2]: 0
> >      tx recycled [CPU 3]: 0
> >      tx recycled [TOTAL]: 0
> >      tx confirm [CPU 0]: 6
> >      tx confirm [CPU 1]: 3
> >      tx confirm [CPU 2]: 2
> >      tx confirm [CPU 3]: 3
> >      tx confirm [TOTAL]: 14
> >      tx S/G [CPU 0]: 0
> >      tx S/G [CPU 1]: 0
> >      tx S/G [CPU 2]: 0
> >      tx S/G [CPU 3]: 0
> >      tx S/G [TOTAL]: 0
> >      rx S/G [CPU 0]: 0
> >      rx S/G [CPU 1]: 0
> >      rx S/G [CPU 2]: 0
> >      rx S/G [CPU 3]: 0
> >      rx S/G [TOTAL]: 0
> >      tx error [CPU 0]: 0
> >      tx error [CPU 1]: 0
> >      tx error [CPU 2]: 0
> >      tx error [CPU 3]: 0
> >      tx error [TOTAL]: 0
> >      rx error [CPU 0]: 6
> >      rx error [CPU 1]: 6
> >      rx error [CPU 2]: 3
> >      rx error [CPU 3]: 4
> >      rx error [TOTAL]: 19
> >      bp count [CPU 0]: 128
> >      bp count [CPU 1]: 128
> >      bp count [CPU 2]: 128
> >      bp count [CPU 3]: 128
> >      bp count [TOTAL]: 512
> >      rx dma error: 0
> >      rx frame physical error: 2
> >      rx frame size error: 17
> >      rx header error: 0
> >      rx csum error: 0
> >      qman cg_tdrop: 0
> >      qman wred: 0
> >      qman error cond: 0
> >      qman early window: 0
> >      qman late window: 0
> >      qman fq tdrop: 0
> >      qman fq retired: 0
> >      qman orp disabled: 0
> >      congestion time (ms): 0
> >      entered congestion: 0
> >      congested (0/1): 0
> >      p00_in_good_octets: 0
> >      p00_in_bad_octets: 2
> >      p00_in_unicast: 0
> >      p00_in_broadcasts: 0
> >      p00_in_multicasts: 0
> >      p00_in_pause: 0
> >      p00_in_undersize: 0
> >      p00_in_fragments: 0
> >      p00_in_oversize: 0
> >      p00_in_jabber: 0
> >      p00_in_rx_error: 1
> >      p00_in_fcs_error: 0
> >      p00_out_octets: 45440
> >      p00_out_unicast: 0
> >      p00_out_broadcasts: 312
> >      p00_out_multicasts: 63
> >      p00_out_pause: 0
> >      p00_excessive: 0
> >      p00_collisions: 0
> >      p00_deferred: 0
> >      p00_single: 0
> >      p00_multiple: 0
> >      p00_out_fcs_error: 0
> >      p00_late: 0
> >      p00_hist_64bytes: 0
> >      p00_hist_65_127bytes: 306
> >      p00_hist_128_255bytes: 8
> >      p00_hist_256_511bytes: 61
> >      p00_hist_512_1023bytes: 0
> >      p00_hist_1024_max_bytes: 0
> >      p00_in_discards: 0
> >      p00_in_filtered: 0
> >      p00_in_accepted: 0
> >      p00_in_bad_accepted: 0
> >      p00_in_good_avb_class_a: 0
> >      p00_in_good_avb_class_b: 0
> >      p00_in_bad_avb_class_a: 0
> >      p00_in_bad_avb_class_b: 0
> >      p00_tcam_counter_0: 0
> >      p00_tcam_counter_1: 0
> >      p00_tcam_counter_2: 0
> >      p00_tcam_counter_3: 0
> >      p00_in_da_unknown: 0
> >      p00_in_management: 0
> >      p00_out_queue_0: 373
> >      p00_out_queue_1: 0
> >      p00_out_queue_2: 0
> >      p00_out_queue_3: 0
> >      p00_out_queue_4: 0
> >      p00_out_queue_5: 0
> >      p00_out_queue_6: 2
> >      p00_out_queue_7: 0
> >      p00_out_cut_through: 0
> >      p00_out_octets_a: 0
> >      p00_out_octets_b: 0
> >      p00_out_management: 11
> >      p00_atu_member_violation: 0
> >      p00_atu_miss_violation: 0
> >      p00_atu_full_violation: 0
> >      p00_vtu_member_violation: 0
> >      p00_vtu_miss_violation: 0
>
> Hmmm....
>
> I recognize the ethtool stats as belonging to the DPAA1 Ethernet driver.
>
> And I see that the Marvell 6390 has undocumented EDSA tag support, thus
> using DSA (with no EtherType) by default. This reminds me of this
> discussion with Tobias Waldekranz. The FMan parser sees errors due to
> the somewhat controversial Marvell original DSA tag decisions:
> https://lore.kernel.org/netdev/20210323102326.3677940-1-tobias@waldekranz=
.com/
>
> Could you please force EDSA with this switch and see if the packet loss
> situation improves? Simplest way would be:
>
> ip link set eth0 down
> echo edsa > /sys/class/net/eth0/dsa/tagging
> ip link set lan1 up
>
> If this helps, I would recommend reading
> Documentation/devicetree/bindings/net/dsa/dsa-port.yaml to see how to
> make this board use edsa persistently.

