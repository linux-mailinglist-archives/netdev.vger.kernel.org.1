Return-Path: <netdev+bounces-226651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A058BA38E1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B053BE0B0
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EA92E974D;
	Fri, 26 Sep 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ddhV/jJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E952E093E
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887898; cv=none; b=eYGzCujieqt/tUuM+uZOku754eRGzqS3KsKvKhEm9+q8Ra4k0MIRxOiek/WiIFVfSyMcrsyDw0LDGsSHuH7XAlpZKlDwcUt7039okPZMK3ohsLPebFut8/cyHm15MxytTGPTUH/GYk9iqfIXRyMskoN3yBGdx/+ORVN+pcLccpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887898; c=relaxed/simple;
	bh=xIhQOuVBHhRrhPOJUNG0MQ+SgG8wSIu/wFNQKygjXgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N51LrQFhhjacY29jyaAbuhEM6iLptKNnhWPpVJQM3cOVH91vPY4lmqbOqxQlYFfk7e/DR9HfZL7XTPgLN53x3FwMhPodMBO+r3YhtY60z+UGsb2iuOyZzu37f7xTFHpFSa/ai2CWapbHc72uKK5r3vuu7n4FqzYSwiYtjTtgXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ddhV/jJm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso4376150a12.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758887895; x=1759492695; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NhLI8ivMsRQl48fjRfQzFPxYaKc+TpjybY+SoQT+bt8=;
        b=ddhV/jJmPEeCVd4tYodRg4ZLGJySfQIIMR4QkPymrCjaw79xS/b4wUjThSTuQcCFxG
         HLd8I2RLrMaWYPxLNAl+qOB13ZKlfCTUl+KKhilMyDq0gWne4xxtnk61lBqK5hdb9LjW
         NpqSxJxORdlbSiRCZ2gzr9ZknaXB1KeLEDuyc37RoBBXg2o1wYjIqoj3AsyQ8jFxt6c1
         wRSeVECyWac6heFhdpa49267QlD0Szrh6BcrR0Rcmw6XsGSoEEOcLR//kj1+4AQ9MeBE
         vnhtQOZrH3mSQT64xRW7FPqVpU0MujhVqAFykpBf4E2HA/204IreKS1vf55EtRg1/4id
         9Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887895; x=1759492695;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhLI8ivMsRQl48fjRfQzFPxYaKc+TpjybY+SoQT+bt8=;
        b=EHTfegh28OzqrwrSxxvBYDozfXG1bzYfyCCOvpW/KBt1zkCi0sa7GMrof+pdYTZwAP
         W7ebBjtIdkByKSKOAUy+bqgwkML2VmTkLk4ZenV81ulB0Rq4mv52AcKtE2l+/Y4xayb3
         K0zMfYMOxPRa4pliB2KcrO7PG3JKjl6alYJoxSpD6h3Z+WQaY+5JUGqavrL58GVSesx2
         RSrcsGJolWNZ4ax+6vtu2sN965bbG0uJ2kfaQiUDyjo7IGv1K7Fuy9TsfNA9meBE0pM+
         zVPEJ3NeSoqTzT14QQicmZM72KR0ZCk5xivUnbLYA/scnhnzPAeDRRx7/jShj8SR4bqr
         2ORw==
X-Forwarded-Encrypted: i=1; AJvYcCWC1OTlx9eJI70ZIQoYZhToX204wagv5Li3aB/dvdcCDm9kJjqU6OmL6zbyCyWMyREJDAqP8a0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+TAbv6MykRhrwTUMxycXP2uIc/uuVA2WTDBb1QqYru7yQIn1
	iZxH5+vYbFkNOZIf7MIG8DL1H9tfDBmE8FLzHfQ1+zd8NrSztKlmkngmKlgTWb1v8KU=
X-Gm-Gg: ASbGnctGZXwuvttie0S3RdLwz2HC+Ag636WEGJNYVNq4c+fVykyqoQ7yfDNZheqwK55
	PG8ZyEAmfm4Eiz1E18gW5Bqrjcrzrjb0iLlXaNvFMygIwijDm/Ls2LPrXjWySkxIPQoQM0LFybw
	akh6wUhd1MwYOdzZC70oVT9MV7IB6vUC/dS6MU7SMS0R+ASJMlrhF3+DJmMfalVdzdsc3zwgJKy
	o/Xs0Y1pD3ost6FBahAZwXr2aoRltquDxl1YHMW+GXy85h3H4r30Qx6abehn8eeZ6VyBXrHUgEc
	76vKJ+Gz/F4eCOC0ap44Ih1lfLYw2Wr7N547gcf/FDqQYXAG0vmwghhHg+J5m6ELS6pb+5BOb4g
	t+NAxempttZ9e0PslR0UFGBgasrTr4S7wtbnR
X-Google-Smtp-Source: AGHT+IE0bLaqZdtQDLm/EmSUUSAQEnVG+IpP4KDEPB31YjhAVBRnkD0HRDZydO+g+SV5KeYq1VqP2g==
X-Received: by 2002:a05:6402:68f:b0:632:930c:ed60 with SMTP id 4fb4d7f45d1cf-6349fa95a69mr4361644a12.30.1758887895005;
        Fri, 26 Sep 2025 04:58:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:a2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af53basm2838609a12.41.2025.09.26.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:58:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,  Donald Hunter
 <donald.hunter@gmail.com>,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  John Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  intel-wired-lan@lists.osuosl.org,  linux-kselftest@vger.kernel.org,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW
 RX checsum in eBPF programs
In-Reply-To: <fdb8a364-a12d-4c1f-9591-9dac3e27b321@kernel.org> (Jesper
	Dangaard Brouer's message of "Fri, 26 Sep 2025 13:45:29 +0200")
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	<87bjmy508n.fsf@cloudflare.com> <aNUb2rB8QAJj-aUX@lore-desk>
	<87tt0q3ik9.fsf@cloudflare.com>
	<fdb8a364-a12d-4c1f-9591-9dac3e27b321@kernel.org>
Date: Fri, 26 Sep 2025 13:58:13 +0200
Message-ID: <87ldm12zoq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 26, 2025 at 01:45 PM +02, Jesper Dangaard Brouer wrote:
> On 25/09/2025 12.58, Jakub Sitnicki wrote:
>> On Thu, Sep 25, 2025 at 12:39 PM +02, Lorenzo Bianconi wrote:
>>>> On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
>>>>> Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
>>>>> RX cheksum results in the eBPF program binded to the NIC.
>>>>> Implement xmo_rx_checksum callback for veth and ice drivers.
>>>>
>>>> What are going to do with HW RX checksum once XDP prog can access it?
>>>
>>> I guess there are multiple use-cases for bpf_xdp_metadata_rx_checksum()
>>> kfunc. The first the I have in mind is when packets are received by an af_xdp
>>> application. In this case I think we currently do not have any way to check if
>>> the packet checksum is correct, right?
>>> I think Jesper has other use-cases in mind, I will let him comment
>>> here.
>> Can you share more details on what the AF_XDP application would that
>> info?
>
> Today the AF_XDP application need to verify the packet checksum, as it
> gets raw xdp_frame packets directly from hardware (no layer in-between
> checked this).  Getting the RX-checksum validation from hardware info
> will be very useful for AF_XDP, as it can avoid doing this in software.
>
>
>> Regarding the use cases that Jesper is trying to unlock, as things stand
>> we don't have a way, or an agreement on how to inject/propagate even the
>> already existing NIC hints back into the network stack.
>> 
>
> This patchset have its own merits and shouldn't be connected with my
> use-case of (optionally) including hardware offloads in the xdp_frame.
> Sure, I obviously also want this RX-checksum added, but this patchset is
> useful on it's own.
>
>> Hence my question - why do we want to expose another NIC hint to XDP
>> that we can't consume in any useful way yet?
>> 
>
> Well here *are* useful ways to use this RX-checksum info on its own.
> See my explanation of the DDoS use-case here[1] in other email.
>
> Cloudflare actually also have a concrete use-case for needing this.
> Our XDP based Unimog[2] load-balancer (and DDoS) encapsulate all
> packets when they are XDP_TX forwarded. The encap receiving NIC lacking
> inner-packet checksum validation make us loose this hardware offload.
> This would allow us to save some checksum validation or even just DDOS drop
> based on hardware checksum validation prior to encap (as in [1]).

Thanks for filling in the blanks, Jesper. That's the context that I was
missing.

Lorenzo, this motivaton seems worth including in the cover letter.

