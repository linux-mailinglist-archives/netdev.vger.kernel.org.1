Return-Path: <netdev+bounces-77046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3538686FF0B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671631C20B2A
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997322615;
	Mon,  4 Mar 2024 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKlktNCa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE375219FF
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548186; cv=none; b=rK5XdbA4kA3VN3YJRR9C8P1hW5wORCwRT9rhRMr31aojq+qd7pDRxtRYMooAqzoy4RRkcMO56dbVCmefUOv2PBeTNXcrrVitDRjSZ+S55hR0ZjO10ruLkfi5LDhrRXblZmwmq1HyMChHV5GSZbTffO5Llvhm2ttEwHbdtcmleHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548186; c=relaxed/simple;
	bh=sQgWgTuhNCglHTvkTInRhmSAlre8oET9TLGHoXYppSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pi2FySGRWXMIlUJJP9+yf43q/ZJPmfGb/EK1o7peYO87scPuvIdma6cJuEZ+Pom19nwECWLifDGOFHmFacAU86ce42kwQqiBsirGOpV2947Z448qMXzu+QewA8qWXboqAWCXkaZ0p0a60w+3JH9lNbeAAPK+hsDvctzd5HnY2o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKlktNCa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709548183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZCaZuzK2lDcHPxO94zXU9VZUa4uvWdMXGopwe685ZeQ=;
	b=XKlktNCaAOaTEJy9OGQJxc5yQOI4RDdB5bnQrdPGAjhJEy3eHXtwXXWiRNVwuWjIQHvXXj
	5IFRAjt2r4Z1E5OKFl0BT3CkP2Qcg1Z2hbFV90gNuUio2IPHXUPch5ZJ2gbd4jPLMppzSJ
	3Yl1bZuEvH/EQR4+XG4kIxDB5wQodo8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-r2VeoOVJMDeJSfOfItn-HA-1; Mon, 04 Mar 2024 05:29:41 -0500
X-MC-Unique: r2VeoOVJMDeJSfOfItn-HA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d8b2a57fdso419337f8f.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 02:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548180; x=1710152980;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCaZuzK2lDcHPxO94zXU9VZUa4uvWdMXGopwe685ZeQ=;
        b=fmo/4cyUVPj3gSfYH0lIjsNgeaphT4Eiaa6JNozLle+0Bhc2bo88rd2Hb7dUxG9RYF
         9x5roaQwJeczRxpz2dmdSpMCvL+nGkIif9V7y32RD7eb+PEOKLebMabiBgzumaQWLi9G
         qvYj9OREed3cnBO0n/NQh3wiFCLUIPE4GD6tUtse8St/mPGp86z6YDUa1zvt+hZuS/WS
         2Ihy9CNpR6fB/dc8k4/7FegJf60t07gf46yd4gsRQVux9K9pJjeFm6ss1oq9fCE/Ae2y
         gbOrSjj9OzbyM85iD9mI33Wu/KVYA7kK8kt4IUZQ+tcU5LIyZc8sc0D4Us/YoOwOIO+Q
         ciTg==
X-Forwarded-Encrypted: i=1; AJvYcCXz/nSK4mRRT6a9sB0MgKQVFP3EcPpRoJr0dK0XIC+/N+HNyjolwoPvOWXxVkwv8hk9W5EvmqxUgPdooU0NK3rPlSP2t80D
X-Gm-Message-State: AOJu0YzMcRDY+dn+dtjjFNdjOKuMTE6jg2G3maRqWVk0Xm93X+3HLcnJ
	3XtTTBEXIKKFUcUuA5a8gWMxNeCV374HHTty85euVoPitkPUmTMIk5RNx1LdSe54RV1gF7YVexA
	95Oiwwot2nSyIBepuxVXJ5nCcT3rqEz9x9UiY1LZkkpnWxA9YcwVzBQ==
X-Received: by 2002:adf:d047:0:b0:33d:a6e8:4f7d with SMTP id v7-20020adfd047000000b0033da6e84f7dmr5849826wrh.3.1709548180497;
        Mon, 04 Mar 2024 02:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbgWBLYLL+eAzmKboSiYB1A+Yq/SpryguPv4WjeHZxlYusVC3dxcClleWNXj8KcGVXmxa6JA==
X-Received: by 2002:adf:d047:0:b0:33d:a6e8:4f7d with SMTP id v7-20020adfd047000000b0033da6e84f7dmr5849810wrh.3.1709548180171;
        Mon, 04 Mar 2024 02:29:40 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id bo16-20020a056000069000b0033e422d0963sm1232813wrb.41.2024.03.04.02.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:29:39 -0800 (PST)
Message-ID: <2b694ab0d4453df4a19898a01c35ce878e383ce7.camel@redhat.com>
Subject: Re: [PATCH net-next 2/4] net: gro: change skb_gro_network_header()
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Richard Gobert <richardbgobert@gmail.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Mon, 04 Mar 2024 11:29:38 +0100
In-Reply-To: <CANn89i+19QU3AX=9u+x51P0xxPt6sNj-GHUh85NF0gsBChEgvg@mail.gmail.com>
References: <20240301193740.3436871-1-edumazet@google.com>
	 <20240301193740.3436871-3-edumazet@google.com>
	 <f8711f5c4d6dfae9d7f4bf64fdde15feaee56494.camel@redhat.com>
	 <CANn89i+19QU3AX=9u+x51P0xxPt6sNj-GHUh85NF0gsBChEgvg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-04 at 10:06 +0100, Eric Dumazet wrote:
> On Mon, Mar 4, 2024 at 9:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
> >=20
> > On Fri, 2024-03-01 at 19:37 +0000, Eric Dumazet wrote:
> > > Change skb_gro_network_header() to accept a const sk_buff
> > > and to no longer check if frag0 is NULL or not.
> > >=20
> > > This allows to remove skb_gro_frag0_invalidate()
> > > which is seen in profiles when header-split is enabled.
> >=20
> > I have a few questions to help me understanding this patchset better:
> >=20
> > skb_gro_frag0_invalidate() shows in profiles (for non napi_frags_skb
> > callers?) because it's called multiple times for each aggregate packet,
> > right? I guessed writing the same cacheline multiple times per-se
> > should not be too much expansive.
>=20
> Apparently some (not very recent) intel cpus have issues (at least
> with clang generated code) with
> immediate reloads after a write.

Ah! I *think* I have observed the same even with gcc (accessing some CB
fields just after the initial zeroing popped-up in perf report.=20

> I also saw some strange artifacts on ARM64 cpus, but it is hard to say,
> I found perf to be not very precise on them.
>=20
> >=20
> > perf here did not allow me to easily observed the mentioned cost,
> > because the function is inlined in many different places, I'm wondering
> > how you noticed?
>=20
> It is more about the whole patchset really, this gave me about 4%
> improvement on saturated cpu
> (RFS enabled, Intel(R) Xeon(R) Gold 6268L CPU @ 2.80GHz)
>=20
> One TCP flow : (1500 MTU)
>=20
> New profile (6,233,000 pkts per second )
>     19.76%  [kernel]       [k] gq_rx_napi_handler
>     11.19%  [kernel]       [k] dev_gro_receive
>      8.05%  [kernel]       [k] ipv6_gro_receive
>      7.98%  [kernel]       [k] tcp_gro_receive
>      7.25%  [kernel]       [k] skb_gro_receive
>      5.47%  [kernel]       [k] gq_rx_prep_buffers
>      4.39%  [kernel]       [k] skb_release_data
>      3.91%  [kernel]       [k] tcp6_gro_receive
>      3.55%  [kernel]       [k] csum_ipv6_magic
>      3.06%  [kernel]       [k] napi_gro_frags
>      2.76%  [kernel]       [k] napi_reuse_skb
>=20
> Old profile (5,950,000 pkts per second)
>     17.92%  [kernel]       [k] gq_rx_napi_handler
>     10.22%  [kernel]       [k] dev_gro_receive
>      8.60%  [kernel]       [k] tcp_gro_receive
>      8.09%  [kernel]       [k] ipv6_gro_receive
>      8.06%  [kernel]       [k] skb_gro_receive
>      6.74%  [kernel]       [k] gq_rx_prep_buffers
>      4.82%  [kernel]       [k] skb_release_data
>      3.82%  [kernel]       [k] tcp6_gro_receive
>      3.76%  [kernel]       [k] csum_ipv6_magic
>      2.97%  [kernel]       [k] napi_gro_frags
>      2.57%  [kernel]       [k] napi_reuse_skb

Thanks for the detailed info! I'll try to benchmark this on non
napi_gro_frags enabled driver, but don't hold your breath meanwhile!

Cheers,

Paolo


