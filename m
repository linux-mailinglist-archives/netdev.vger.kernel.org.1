Return-Path: <netdev+bounces-154167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D29F9FBD91
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 13:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17C8163806
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ACB1B3954;
	Tue, 24 Dec 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/mcVMLH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CD98836
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735044652; cv=none; b=JUWh9NAwVFKJ+vifeodTft0Od36Qro4IUF2/X0FDdKt19UxcztZ/q3G69JsUW22ZoVuJH/DyYPRTmdKrptn/tKu7b+dEGHCNmG2+5figQ9yimBKQpVa3Y4WauqlFjbYTaegR0c/W0moo2QNprJ5rCxR/kVDCGOHB22ox4g1/99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735044652; c=relaxed/simple;
	bh=/txl0AtC3Ee2YVwk9Mlkb7bibIdExSGTfUgjqfhVdR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GC4K7zjzAd0oRbjgM/klXbheipsztD5K4x37KA6v0wuDi8RerA0ne1DY1/doH98LoHYy6ZWMAhUVMBPdO5SvZ8hYozvuMWYsSQHWFiNOwLROot9RpsSigRONQyg8WjomFBDhFGMam/jOaL5l+Vod1OLSse6cdbe6mcDXjUCYpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/mcVMLH; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso4014400276.2
        for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735044649; x=1735649449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93thr2Fkhs8J+WvRWFlnKgwOZGtiTbWQbLNkyOWAhxw=;
        b=O/mcVMLHymVxWkfYX8422lGkSPQkWhx+LyqkhfFmafSWTc5k/o9DD1n9hMoWVg9DWy
         YkcwlKNEbN10sb4svSBNW32+dXD9+rrEAT3Nocm0nZeINcbVi2KjRlrwj6aqVirJ19lM
         Rx5gDX9UiZCBwU1EHBBgCiUzbu0k3wtnVQciZ3T/18xZQ53KLIS8nFyQoW3UpzKFtx0A
         Wc406dlFhCXDbAyTvcc0bZoh3IBjEIUnevzie7r/1imnqnFzpdJ0Pr2NMNDe/HHmmRZI
         yGIOMdJNrg/0hHN1tezKf12a8pINuEQOrUrW4a0lpWt1iCSYe01sgMP+T98MIfp6k6mS
         BENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735044649; x=1735649449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93thr2Fkhs8J+WvRWFlnKgwOZGtiTbWQbLNkyOWAhxw=;
        b=JM0290KT/g9NFxwydVslwVcF/PCxZo0oSubEkqZBZqS74+bCG3QVFeVB4qLRMu6UzL
         BigUDg58vNCkr3uvzfAmIPdA3pRZSz4R94P9SPzV2bUx5aymi6Ja3zViBzJI6TLDc7N5
         9EaUf3ovoIgJg+Za5UgtPokOgWvAZikRF+NbyV3tLdts0+4TCRnCZGgdsj0XneRfmNp7
         p85GtkVRSllBkoAZFGfqr3s1fHjy3qEtqcKO8tBiLiL41eY++/wR9XDzG35V1fm56f+i
         y9kuGAUgY2GVQ1U1YhSNAxdwkyyZIvMr07t27fuYpz7Iv7c2zPOfVr5K9NtAqhkwJnq3
         zSOA==
X-Gm-Message-State: AOJu0YwOUyhNWmN7kUq1L1BJ9AbaMOe20WFxOx9cV6sZme6A18DAJLwy
	ihXCsk+Vg6ocDi5MbVEzm8hR7CSVqbN6Xc8Fn47dkJkVnFqKgCNgdz2NTGJP26bxk20HZGL+uFp
	/+38+zasjKtgp/tuEyF6sjPoaib0=
X-Gm-Gg: ASbGncvCSA7oHEm946aWb7Vstey2IpRNoC+ex4av97Zs1+6FS0w7eMSkGzoB/ZHlG3B
	QfErE3f3otgAWEDb2XyCaXi//lSOT9jDERkNEWtIZ
X-Google-Smtp-Source: AGHT+IECjU9Z7HwYD1PTFaHWmgW5UP5ero20TPyF8or++JBxs4NO0YNQgvb4KNvqXrVBlMPSgfvTLKEjp199VveBh0E=
X-Received: by 2002:a25:6889:0:b0:e53:d870:76f6 with SMTP id
 3f1490d57ef6-e53d8707b26mr841855276.43.1735044649140; Tue, 24 Dec 2024
 04:50:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA=kqWJWjEr36iZXZ+GFeaqxx35kXTO0WdGZXsL4Q7cvsT3GYg@mail.gmail.com>
 <20241224120049.bjcxfqrwaaxazosw@skbuf>
In-Reply-To: <20241224120049.bjcxfqrwaaxazosw@skbuf>
From: sai kumar <skmr537@gmail.com>
Date: Tue, 24 Dec 2024 18:20:38 +0530
Message-ID: <CAA=kqW++FYvBfWU8c111pdYVFJk5=rhF5R5_N+wk5uUs=3fo=g@mail.gmail.com>
Subject: Re: DSA Switch: query: Switch configuration, data plane doesn't work
 whereas control plane works
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Vladimir for your inputs.

I tried checking the statistics, the in_broadcasts count increases
with respect to client dhcp discover broadcasts.
But the same is not happening with external cpu port eth1, the eth1
in_broadcasts and in_accepted are 0 , Observing the rx frame errors on
eth1 but
this count doesn't match to the clients broadcast packets count.

ethtool -S lan1
NIC statistics:
     tx_packets: 7
     tx_bytes: 626
     rx_packets: 0
     rx_bytes: 0
     in_good_octets: 18112
     in_bad_octets: 0
     in_unicast: 0
     in_broadcasts: 51
     in_multicasts: 5
     in_pause: 0
     in_undersize: 0
     in_fragments: 0
     in_oversize: 0
     in_jabber: 0
     in_rx_error: 0
     in_fcs_error: 0
     out_octets: 7792
     out_unicast: 0
     out_broadcasts: 105
     out_multicasts: 12
     out_pause: 0
     excessive: 0
     collisions: 0
     deferred: 0
     single: 0
     multiple: 0
     out_fcs_error: 0
     late: 0
     hist_64bytes: 105
     hist_65_127bytes: 17
     hist_128_255bytes: 0
     hist_256_511bytes: 51
     hist_512_1023bytes: 0
     hist_1024_max_bytes: 0
     in_discards: 0
     in_filtered: 0
     in_accepted: 56
     in_bad_accepted: 0
     in_good_avb_class_a: 0
     in_good_avb_class_b: 0
     in_bad_avb_class_a: 0
     in_bad_avb_class_b: 0
     tcam_counter_0: 0
     tcam_counter_1: 0
     tcam_counter_2: 0
     tcam_counter_3: 0
     in_da_unknown: 5
     in_management: 4
     out_queue_0: 117
     out_queue_1: 0
     out_queue_2: 0
     out_queue_3: 0
     out_queue_4: 0
     out_queue_5: 0
     out_queue_6: 0
     out_queue_7: 0
     out_cut_through: 0
     out_octets_a: 0
     out_octets_b: 0
     out_management: 0
     atu_member_violation: 0
     atu_miss_violation: 0
     atu_full_violation: 0
     vtu_member_violation: 0
     vtu_miss_violation: 0


ethtool -S eth1
NIC statistics:
     interrupts [CPU 0]: 12
     interrupts [CPU 1]: 9
     interrupts [CPU 2]: 5
     interrupts [CPU 3]: 7
     interrupts [TOTAL]: 33
     rx packets [CPU 0]: 0
     rx packets [CPU 1]: 0
     rx packets [CPU 2]: 0
     rx packets [CPU 3]: 0
     rx packets [TOTAL]: 0
     tx packets [CPU 0]: 2
     tx packets [CPU 1]: 0
     tx packets [CPU 2]: 12
     tx packets [CPU 3]: 0
     tx packets [TOTAL]: 14
     tx recycled [CPU 0]: 0
     tx recycled [CPU 1]: 0
     tx recycled [CPU 2]: 0
     tx recycled [CPU 3]: 0
     tx recycled [TOTAL]: 0
     tx confirm [CPU 0]: 6
     tx confirm [CPU 1]: 3
     tx confirm [CPU 2]: 2
     tx confirm [CPU 3]: 3
     tx confirm [TOTAL]: 14
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
     rx error [CPU 0]: 6
     rx error [CPU 1]: 6
     rx error [CPU 2]: 3
     rx error [CPU 3]: 4
     rx error [TOTAL]: 19
     bp count [CPU 0]: 128
     bp count [CPU 1]: 128
     bp count [CPU 2]: 128
     bp count [CPU 3]: 128
     bp count [TOTAL]: 512
     rx dma error: 0
     rx frame physical error: 2
     rx frame size error: 17
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
     p00_in_good_octets: 0
     p00_in_bad_octets: 2
     p00_in_unicast: 0
     p00_in_broadcasts: 0
     p00_in_multicasts: 0
     p00_in_pause: 0
     p00_in_undersize: 0
     p00_in_fragments: 0
     p00_in_oversize: 0
     p00_in_jabber: 0
     p00_in_rx_error: 1
     p00_in_fcs_error: 0
     p00_out_octets: 45440
     p00_out_unicast: 0
     p00_out_broadcasts: 312
     p00_out_multicasts: 63
     p00_out_pause: 0
     p00_excessive: 0
     p00_collisions: 0
     p00_deferred: 0
     p00_single: 0
     p00_multiple: 0
     p00_out_fcs_error: 0
     p00_late: 0
     p00_hist_64bytes: 0
     p00_hist_65_127bytes: 306
     p00_hist_128_255bytes: 8
     p00_hist_256_511bytes: 61
     p00_hist_512_1023bytes: 0
     p00_hist_1024_max_bytes: 0
     p00_in_discards: 0
     p00_in_filtered: 0
     p00_in_accepted: 0
     p00_in_bad_accepted: 0
     p00_in_good_avb_class_a: 0
     p00_in_good_avb_class_b: 0
     p00_in_bad_avb_class_a: 0
     p00_in_bad_avb_class_b: 0
     p00_tcam_counter_0: 0
     p00_tcam_counter_1: 0
     p00_tcam_counter_2: 0
     p00_tcam_counter_3: 0
     p00_in_da_unknown: 0
     p00_in_management: 0
     p00_out_queue_0: 373
     p00_out_queue_1: 0
     p00_out_queue_2: 0
     p00_out_queue_3: 0
     p00_out_queue_4: 0
     p00_out_queue_5: 0
     p00_out_queue_6: 2
     p00_out_queue_7: 0
     p00_out_cut_through: 0
     p00_out_octets_a: 0
     p00_out_octets_b: 0
     p00_out_management: 11
     p00_atu_member_violation: 0
     p00_atu_miss_violation: 0
     p00_atu_full_violation: 0
     p00_vtu_member_violation: 0
     p00_vtu_miss_violation: 0


On Tue, Dec 24, 2024 at 5:30=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Tue, Dec 24, 2024 at 03:00:17PM +0530, sai kumar wrote:
> > Hi Team,
> >
> > This could be basic question related to DSA, if possible please help
> > to share your feedback,. Thanks.
> >
> >
> > External CPU eth1 ---RGMII---- Switch Port 0 (cpu port)
> > Switch Port 1 (lan1) --- DHCP client
> >
> > I am using marvell 88E6390 evaluation board, modified the device tree
> > to support MDIO control over USB.
> > The switch control plane works, we are unable to dump registers and
>
> unable -> able, right?
[SK] Yes, typo it was able.
>
> > see port status.
> >
> > The kernel version on board with external cpu is 6.1
> >
> > I have connected a dhcp client to port 1 of the switch and the
> > discover packet is not reaching the cpu port (port 0) and external cpu
> > interface eth1.
> > Using the bridge without vlan to configure, able to see the client
> > device mac addr in bridge fdb show
> > with vlan id as 4095.
> >
> > tcpdump on external cpu port eth1 and bridge br0 to listen for
> > incoming packets from the client . No discover packets are being
> > received on those interfaces.
> >
> > Could you please let us know if any configuration is being missed for
> > switch data plane to work ? Thanks.
> >
> >
> > The below are the commands used to configure the bridge:
>
> I don't immediately see something obviously wrong. Could you run
> ethtool -S on lan1 and on eth0, and try to find a positive correlation
> between the DHCP requests and a certain packet counter incrementing in
> the switch? We should determine whether there is packet loss in the
> switch or whether there is some other reason for the lack of connectivity=
.

