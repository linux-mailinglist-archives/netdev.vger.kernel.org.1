Return-Path: <netdev+bounces-153390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F8B9F7D39
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24AA188E6BE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7BA221DA0;
	Thu, 19 Dec 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="UbwQPASZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5F17C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618891; cv=none; b=UTNicyYdphAVJ11ZN0f98gAi1XxwIi3qJHCOmUslGwHdHWKyfNNp1okVxJb36drteqFgLXDTv+k1sjWA/BxYgBPUd29nX24IBfcDUnJxtjSjpGzPAJHIGgCv22GRFTfsA1fISjO3TRjdexgr1admU2R+AmqdO6gQsamdIkwVyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618891; c=relaxed/simple;
	bh=E+481M/oR52b/MWdH5NKpOGqsDNULk8hxrlXLwrF5J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQNPo6ir2Klh8snEET2xyVT/6EsXgTEdQX5fvxBOCNryDx9rhFFhk8HJHwfYEcHJtiBvqeU2raEYJjnjdwl1FdJpdCFKrmUeERAfJXU5/nUUaf7j/zEzboCzbwRIHaVleFTHmNgaC/sCOfUj276KvwGkmg14WjI5ERmOeQTbyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=UbwQPASZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-303489e8775so8953391fa.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734618887; x=1735223687; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zH+c8IAFfIfykEu+9xjV8K+ij5kHQNlPdWp0PzgL9iQ=;
        b=UbwQPASZYIbgI69tkGq/IrB/WJVY0hGKXODvgeBKL4vHq5PupV8To36dEdXEUmgN0+
         R3udXN5kbfJlGnbpAN+8dtphfY+xQnqgIFDlKwt1X3MfrDmaVhlS4Lx5y0oRJAdawYLM
         Wchi/2RyH2SoS1ATLtjjArONjfFHcMmY0+e4P6/NP1NbV6aQdMoA0XzuRB5YFO2S65P5
         t2GuRpJAQpp3NrL7/kjRUmyROCzRKQtcSwzmQkk7ITWSNbFU7OpPzi89BWla20/LxzUe
         OSVRX5HucPwC1MxXTfcHNF7Rd3NmfzwPBei7PLxFjFxUNDEP/svO4g2kq1TT1Y4zyQTT
         Hgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734618887; x=1735223687;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zH+c8IAFfIfykEu+9xjV8K+ij5kHQNlPdWp0PzgL9iQ=;
        b=Fyj790vOytuIsaPPh8/cVg3NQX377engAAJo7OVHSsFKCY3JXbuaN+YxqxyTxIk7vX
         xuovtP6hzYnqjg2z4hQ4Z1X6rcHGCSCdgK32ctoX3rfJfo10DJIbno+5Qq/RgxkuffAw
         iHWEoMFB13VzlfKNK38682KE6tRItl9OdDSMYFyQFTm5vL935HxcGOIladCX1j6u+zst
         uCpQHfizuIIWhxx4ozTZNJdZa68pyQa4xVJ2/XrGgY8v63jNtqlbde7XocF9Ki8H4V+G
         lrSVue2hjC3ucPuUXGKUquIT1uUBS3h7g3DPbooDE9N3cBPY7znBp6qDvSNxUFcj5JP5
         9DPw==
X-Forwarded-Encrypted: i=1; AJvYcCXhSXCLO5NaY3lsP71watzcbarDpBOGW3U3lSqBr5G4KrCSgJmnwki0EwCuqEIvyRc6Tay+Bpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdA64CTyfMmhTY1EdqABJdXravExiAvfvyaDWKh0CYdf48xXq3
	9l+GnVKPK41QNoZPRlsOCaRBKbXbAkV0szgSbQ3ZQRyymMiL8TqSkEYYAxkkOFA=
X-Gm-Gg: ASbGncsVnZWXRAlV0qumXM6Y1BL4AQXoIl8Dp9kYP/TwvZVtCUw5TIsk4go36ke9zGI
	En4zmSj8KG9KUz3soBTgCGF3EKsMSpXTxRiXKTMIZZwKpUrLRP9s8uk7wNdFcJgVwN8NLLkX+8G
	uvF1MxA8kBZg+4OiHaNqIhiqbot5Lm5CVtNWIqmeBwP7Y+ovSn8SFuuXqftW1cnAgZQBMDxmP39
	FIa7LlYVvtnk3IkpDA0F3wuICU7b/58NJKH3BPFgeLoHCzYeE2Bh56OsPvQXgcHVKi2p+O3SlQq
	iZgZ4NgNcok=
X-Google-Smtp-Source: AGHT+IFCH1zlvGOPrpwBPJX4CI9lf+fGKUh3Nct9BSaJJwWEVDgUMM7T/trJF7rf06XykErQutkrCA==
X-Received: by 2002:a05:6512:159d:b0:540:353a:5b1f with SMTP id 2adb3069b0e04-541e0f334a8mr2591187e87.0.1734618886665;
        Thu, 19 Dec 2024 06:34:46 -0800 (PST)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223821557sm185647e87.197.2024.12.19.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:34:44 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy
 to user ports on 6393X
In-Reply-To: <20241219140541.qmzzheu5ruhjjc63@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219140541.qmzzheu5ruhjjc63@skbuf>
Date: Thu, 19 Dec 2024 15:34:43 +0100
Message-ID: <875xnf91x8.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, dec 19, 2024 at 16:05, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Dec 19, 2024 at 01:30:43PM +0100, Tobias Waldekranz wrote:
>> For packets with a DA in the IEEE reserved L2 group range, originating
>> from a CPU, forward it as normal, rather than classifying it as
>> management.
>
> Doesn't this break STP? Must be able to inject into ports with an STP
> state other than FORWARDING. I expect that you need a DSA_CMD_FROM_CPU
> tag for that, can't do it with DSA_CMD_FORWARD.

You need a FROM_CPU to force a packet out through a blocking port,
yes. But I don't see how this could apply to STP.

If STP is enabled on the bridge, we will never allow BPDUs to be
forwarded. Locally originating STP BPDUs are always injected directly on
the lower interface, so OFM is never set on those.

If STP is disabled on the bridge, then we will forward incoming BPDUs
(br_handle_frame()). In that case OFM could be set if the BPDU came in
on a foreign port. But since STP is disabled, no port will be blocked in
this case, so it would not matter.

>> Example use-case:
>> 
>>      bridge (group_fwd_mask 0x4000)
>>      / |  \
>>  swp1 swp2 tap0
>>    \   /
>> (mv88e6xxx)
>> 
>> We've created a bridge with a non-zero group_fwd_mask (allowing LLDP
>> in this example) containing a set of ports managed by mv88e6xxx and
>> some foreign interface (e.g. an L2 VPN tunnel).
>> 
>> Since an LLDP packet coming in to the bridge from the other side of
>> tap0 is eligable for tx forward offloading, a FORWARD frame destined
>> for swp1 and swp2 would be send to the conduit interface.
>> 
>> Before this change, due to rsvd2cpu being enabled on the CPU port, the
>> switch would try to trap it back to the CPU. Given that the CPU is
>> trusted, instead assume that it indeed meant for the packet to be
>> forwarded like any other.
>
> It looks like an oversight in the switchdev tx_fwd_offload scheme. Can't
> we teach nbp_switchdev_frame_mark_tx_fwd_offload() to make an exception
> for is_link_local_ether_addr() packets, and not set skb->offload_fwd_mark?

That sounds like a better option if it is acceptible to the broader
community. I thought that this might be a quirk of mv88e6xxx's rsvd2cpu
bits. But if more devices behave in the same way, then it would be
better to just exempt this whole class from offloading.

Do you know how any other ASICs behave from this perspective?

