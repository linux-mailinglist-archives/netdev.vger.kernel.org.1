Return-Path: <netdev+bounces-227179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBCBA985D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B048E189353F
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55410304BAF;
	Mon, 29 Sep 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="migt2gP7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FF126C17
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155627; cv=none; b=WhNiFrzYtpIW7MnTsVUcOpi0hCmVeI+eCPeE/c6Zzfi3UyEWjx8Rcdxusx2iJu4jpPJqnMCsO60GIjbGXqSz0Rk+JRdPRvZVzmQgf0am5n6sfxDYFI0QfOCtbx082l436lbmpgRPgjCYM65LPwyWvnkb3r2VjmgAxjBfDQzWVNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155627; c=relaxed/simple;
	bh=9e2ic1wvWE8WehJ3kuMdIIYPcBrUXcQZlimQJDH4mOk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iZuWwdkq0qiFAHpqdPn+OXSshLWhgWWH078KZwebuo0TezoyRy5Rnfmaj2u0GIvNB/RdwPZ1oHNskstifjcSJgxYOIZVsMMnKlAozTeOpg7xyw9zQNx+uegJTmhiiRxKAqxpFBLgdib8/7apiaixLN5Ead4KztlNdxG7vQZr4Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=migt2gP7; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8eafd5a7a23so2454636241.1
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759155624; x=1759760424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W46uqCXD/DYO2PsPrvcdafdEqjimB/+hIZDXBFn2C/g=;
        b=migt2gP7GWj2JTQdTzSijFdUfLmym/CdjD2yBM7RMm9Ys2Iub+1GmA9yByytm23g40
         hRTqJpeXVCM/lsHhKnOYnwUdX32Y63CJAG84G6bOQhiHSRXKY4xH3jlDD50Eoe/Vs34/
         zcrT81NarET/9WgLk6FJN4vEOHMZy+xQaD6oEm8zDdySWShnjNl0u+xuEMidVjjw5l1J
         O3lwJCP2y17x3mXs9W6NbodFvRnS/y49X/J+6k51a8wKpJETDfYG1iIAktkyTRfcYHJd
         cb3Lbp05axpR2c+jTW2l5XSe6L/l4EYu1qFiBYkqjW32piEWd6D5XCOJvcabOBm3TLGH
         itEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155624; x=1759760424;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W46uqCXD/DYO2PsPrvcdafdEqjimB/+hIZDXBFn2C/g=;
        b=Gnd6GJ+NZ03RsWbe7ABk6F+lvqGu9LeMDEsxgySFxUmQ9Sivr756/a49AQdk9E8c3f
         ZSY8ItSyuYFz5WLSfALgUf58yiERrkzo8Mj1/hNtOkdB8zh6lLra8KQiA8+NXJaIa7sv
         0MfSvhIXZ5DpQR+wBHYyTV6n9n/V5cdPMcXDUT/i388gtZTFiBCay2NOnInckixLszns
         Pn3X4VkgoNEddo5ifQV8cwuLLwRpoaCxbMkdX9nDbX6zh0KJ0t1dwg38cp1WXAPHg2di
         kbYqwtilejm388v+yHFJ8RDSRIQX9aLcBMakv/iAxIStpQ+BsQNvgT+BPMLvrak8ZoVA
         LddQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG73a3yyRiXoDNO7EWlDSanYjJfYpV4AbeSxRbnvguB8D0fVc8x8HinGDpuHp5d1KhlNct/Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0TvQht7CYwKMWGo4v9TgDHLj5xS1XfGWC311vZEdVdpXcscTj
	EoUkEkFrd+FOguy74d9hlvCXng1KusZq5T+TbXfMUak8DYcVdoyjwpvH
X-Gm-Gg: ASbGncvAVwniA5htPyQK10lwnoOLn6vpP7Qx71xakhrtbqbse567Aa6ZtozLSwaqZad
	U60C6cfQuQTYXXhE34zoEbRuJezoyCiDP1Ly406Rb4z8OLZYJC1IIsDdl0QgGyjyuYab6Yy82NJ
	80I91qvGfG6U9bU7OQ4RMWHLy6s5WmNK4KrPOpXepSVr7zEB428YWduKj7Wej8OJ3gQdLPlUweW
	RN9e/sdH8Yuc6Okk3Ivy/NNeTmwmH7rW2/wayG85RerxlvkNEGFtfciYZvJnYXN4XyHUffQXNlb
	TPI0D2dwg8Fwii35++yzuK87LptlaIavt6CvIbJ65eNAcC195QMGAhM0wvzc5JRMrgTu3wwFG4b
	KXR1yGpH4HpfyVqJ3/5Dhk1yLFgHHkjbBvu5C4VQIkuyQF61kU4lGG/ztLI59fVPj0WsKyg==
X-Google-Smtp-Source: AGHT+IF9dM2rIldZLZnID4vwmKumarCAuGUMYuEholINlwbv/TDctLyEWMXb6Vz/4VzFzzqqhWBosA==
X-Received: by 2002:a05:6102:418a:b0:599:8390:ca2 with SMTP id ada2fe7eead31-5ced2e12255mr484114137.9.1759155624152;
        Mon, 29 Sep 2025 07:20:24 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5ae302ee7f1sm3417497137.2.2025.09.29.07.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:20:23 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:20:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>
Cc: i.maximets@ovn.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 horms@kernel.org, 
 corbet@lwn.net, 
 saeedm@nvidia.com, 
 tariqt@nvidia.com, 
 mbloch@nvidia.com, 
 leon@kernel.org, 
 dsahern@kernel.org, 
 ncardwell@google.com, 
 ecree.xilinx@gmail.com, 
 Richard Gobert <richardbgobert@gmail.com>, 
 kuniyu@google.com, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 aleksander.lobakin@intel.com, 
 florian.fainelli@broadcom.com, 
 alexander.duyck@gmail.com, 
 linux-kernel@vger.kernel.org, 
 linux-net-drivers@amd.com, 
 netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <willemdebruijn.kernel.3a470e4b61d3@gmail.com>
In-Reply-To: <2da082ad-c30e-4f91-8055-43cf63a5abe4@ovn.org>
References: <20250916144841.4884-1-richardbgobert@gmail.com>
 <20250916144841.4884-5-richardbgobert@gmail.com>
 <c557acda-ad4e-4f07-a210-99c3de5960e2@redhat.com>
 <84aea541-7472-4b38-b58d-2e958bde4f98@gmail.com>
 <d88f374a-07ff-46ff-aa04-a205c2d85a4c@gmail.com>
 <dd89dc81-6c1b-4753-9682-9876c18acffc@redhat.com>
 <2da082ad-c30e-4f91-8055-43cf63a5abe4@ovn.org>
Subject: Re: [PATCH net-next v6 4/5] net: gro: remove unnecessary df checks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ilya Maximets wrote:
> On 9/25/25 12:15 PM, Paolo Abeni wrote:
> > Adding the OVS maintainers for awareness..
> > 
> > On 9/22/25 10:19 AM, Richard Gobert wrote:
> >> Richard Gobert wrote:
> >>> Paolo Abeni wrote:
> >>>> On 9/16/25 4:48 PM, Richard Gobert wrote:
> >>>>> Currently, packets with fixed IDs will be merged only if their
> >>>>> don't-fragment bit is set. This restriction is unnecessary since
> >>>>> packets without the don't-fragment bit will be forwarded as-is even
> >>>>> if they were merged together. The merged packets will be segmented
> >>>>> into their original forms before being forwarded, either by GSO or
> >>>>> by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
> >>>>> is set, in which case the IDs can become incrementing, which is also fine.
> >>>>>
> >>>>> Note that IP fragmentation is not an issue here, since packets are
> >>>>> segmented before being further fragmented. Fragmentation happens the
> >>>>> same way regardless of whether the packets were first merged together.
> >>>>
> >>>> I agree with Willem, that an explicit assertion somewhere (in
> >>>> ip_do_fragmentation?!?) could be useful.
> >>>>
> >>>
> >>> As I replied to Willem, I'll mention ip_finish_output_gso explicitly in the
> >>> commit message.
> >>>
> >>> Or did you mean I should add some type of WARN_ON assertion that ip_do_fragment isn't
> >>> called for GSO packets?
> >>>
> >>>> Also I'm not sure that "packets are segmented before being further
> >>>> fragmented" is always true for the OVS forwarding scenario.
> >>>>
> >>>
> >>> If this is really the case, it is a bug in OVS. Segmentation is required before
> >>> fragmentation as otherwise GRO isn't transparent and fragments will be forwarded
> >>> that contain data from multiple different packets. It's also probably less efficient,
> >>> if the segment size is smaller than the MTU. I think this should be addressed in a
> >>> separate patch series.
> >>>
> >>> I'll also mention OVS in the commit message.
> >>>
> >>
> >> I looked into it, and it seems that you are correct. Looks like fragmentation
> >> can occur without segmentation in the OVS forwarding case. As I said, this is
> >> a bug since generated fragments may contain data from multiple packets. Still,
> >> this can already happen for packets with incrementing IDs and nothing special
> >> in particular will happen for the packets discussed in this patch. This should
> >> be fixed in a separate patch series, as do all other cases where ip_do_fragment
> >> is called directly without segmenting the packets first.
> > 
> > TL;DR: apparently there is a bug in OVS segmentation/fragmentation code:
> > OVS can do fragmentation of GSO packets without segmenting them
> > beforehands, please see the threads under:
> > 
> > https://lore.kernel.org/netdev/20250916144841.4884-5-richardbgobert@gmail.com/
> > 
> > for the whole discussion.
> 
> Hmm.  Thanks for pointing that out.  It does seem like OVS will fragment
> GSO packets without segmenting them first in case MRU of that packet is
> larger than the MTU of the destination port.  In practice though, MRU of
> a GSO packet should not exceed path MTU in a general case.  I suppose it
> can still happen in some corner cases, e.g. if MTU suddenly changed, in
> which case the packet should probably be dropped instead of re-fragmenting.
> 
> I also looked through other parts of the kernel and it seems like GSO
> packets are not fragmented after being segmented in other places like
> the br-netfilter code.  Which suggests that MRU supposed to be smaller
> than MTU and so the fragmentation is not necessary, otherwise the packets
> will be dropped.
> 
> Does that sound correct or am I missing some cases here?

One of the discussed cases is where a packet is transformed from
IPv4 to IPv6, e.g., with a BPF program. Similar would be tunnel encap.
Or just forwarding between devices with different MTU.



