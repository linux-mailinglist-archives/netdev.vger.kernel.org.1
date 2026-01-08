Return-Path: <netdev+bounces-248253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F856D05D38
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 940053033DCA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15565329C49;
	Thu,  8 Jan 2026 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GGnQM7at"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C561DF97C
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767900335; cv=none; b=cWedQ59P7eKvTSWUqe/scPEo68tWreYfucRXsqBTXLT3hiJt8b0ghSWVjKO8mg6vqp/EPeIzHSaB3fWwgdeaL6QlQkleGhFwPa+fPyZZ1HjneiZnzVB0ADViH4Jfn0NQ2DhmRKdh/NddWVSE0mEW+ZTJVV45rmEy4mgLOs9TLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767900335; c=relaxed/simple;
	bh=r+1w+POd1tlFwFEgmo1vq0cuD81Ug+oghAqLtE3Jbto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dcoxym9boiQxtZJmDJLL3/0/3JklIUzQ/ph0F/vBqLxZf826SjU6EQPIKcDTmhRNHPOSkxpw1g5DFvsbzJpvrmFmNZqvuzyajYzB32rtdVpSKT4DH43CGdzqu6ibHchBM5o25O9pm5e80/U6VGWl3sVPMItb/oiFs+BoIPdgJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GGnQM7at; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7355f6ef12so652329366b.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 11:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767900331; x=1768505131; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=746qCB+qsv1N48iXPnnkLq1LwaQWCnnTiTmvS4/f3bc=;
        b=GGnQM7atzJM1NTVg4tSzwRG6BsD0X4p0u92T/OSqeO5sqo95mCgTJwru0Xqs3RAxB8
         PImsFOv9NES4K8oAYZAJ3SbHpUyktI0lKJa8fXNtbcRQEAq3of2dhta9IYPxEqgFBy+z
         z32nnmaXywVUeBMCHjbhWJ/0Rc0aLTuYchXSVz3drwdyn3JNXiS4XI1VGylxNRv/jaXi
         CzHrZ+3KNymE6The6K9a61ouzdUKWgGBRqPPpai9lRXDGSTroNkxJ2q/UmrwNDkJRwkN
         sBy4TuHc7Xrhzy4PN+rjtTobKA/Gqd8l+MAJMT7oOyPRE6IZt0rItWWmK2A2zEAlJ45x
         BxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767900331; x=1768505131;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=746qCB+qsv1N48iXPnnkLq1LwaQWCnnTiTmvS4/f3bc=;
        b=Lui3uzinlMEvBga1G9TdvTHTuM17sPFEHzDAwWoRlY5B0ZZCb+PuY0oUwv8VAjHuST
         0Y73C9/j/kGy9Dik4ybfhNQ70oEET94INVvmTPDtLBmDwMRIUGn1k360sitJ4RL4Zm8d
         iRURn6DfmotY/OiaEiDE7u6ebTsDmFVHlxZUljuV5KjoAQwth7z4i2BRofQrgO4olZjj
         cZWREE18fiqDAvr59/xKs5Th8ceSMePwvX7tIITaevoTeo5zgactENAYzgWeUIRuMi5K
         tLhMw55JOe4B9yiSVoglmoolF4dDmnV/liG6zpwrGhx673Od/elVkgsUA20AR9SmO9yW
         G/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCU56bonCauZYMh8xVbJH1jDYDamDVR+DWLTpqtpkMl45gTlYUDJKXNkXrYv2JUj607kD32t17s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAyR88ahnJofOlpjdP7MmCAX8MCr7T1QXRBhA9+JZNo2C4gzKM
	aPVqnqOD+zRzRiyzK460baE596THQLgHI2ObyimTKXtOtf1eAaPQ1Ad1ptDNw/FLG586mfuxzVz
	SvHQs
X-Gm-Gg: AY/fxX5+Ja4XsSprGTW94WkByk9H7FtlT/KjHJo53kMZCYOjEZw02mV+5iGFZ83/wCH
	w8BC5UsF5V7t0S9gzylfgK/08VwUcK4j/zjfBvdns8Dnnwvrcf+YUmX4/kasjjHZ1DrQbtMAX2O
	LPERihZA+rch66dW0JoCQUFliUIruBC3jb025LGL1fkUDmYFZUa3vlRBozpTJCAhZlmPxhf3dtz
	c5g7RozF2OB6OBKUDJ7uzcK3w4vqLoD6/+gUIZVytn97AuyQqEQkALUnw87TnvbRVRjKEUJxnYE
	d/MJxawvbhR+xEQ85/JmzRhT3O0VlRbRzVp8hNuiEo3GwYoBVIzG/knsYgcmmz8hGaydcIRL5sn
	AFPbQSX5dpGiSyNF7eT8A5NR4tsKINkywumrVXPgpITt4Cp6xtB5cy5hq0r5b4eHf1B3ewI9dXG
	UUphs=
X-Google-Smtp-Source: AGHT+IG21CGZrGIYfgU9yJ1WjlKI1Rpu63FNAj1MJXQzhmTefzkafr7p2vnJ67lmy1ZGkiGGr/DJIg==
X-Received: by 2002:a17:907:7f8e:b0:b73:4fbb:37a8 with SMTP id a640c23a62f3a-b8445191fabmr695690066b.12.1767900331511;
        Thu, 08 Jan 2026 11:25:31 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a517cf1sm873704966b.59.2026.01.08.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:25:31 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 00/17] Decouple skb metadata tracking from
 MAC header offset
In-Reply-To: <20260108074741.00bd532f@kernel.org> (Jakub Kicinski's message of
	"Thu, 8 Jan 2026 07:47:41 -0800")
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
	<20260108074741.00bd532f@kernel.org>
Date: Thu, 08 Jan 2026 20:25:30 +0100
Message-ID: <87ecnzj49h.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 08, 2026 at 07:47 AM -08, Jakub Kicinski wrote:
> On Wed, 07 Jan 2026 15:28:00 +0100 Jakub Sitnicki wrote:
>> This series continues the effort to provide reliable access to xdp/skb
>> metadata from BPF context on the receive path. We have recently talked
>> about it at Plumbers [1].
>> 
>> Currently skb metadata location is tied to the MAC header offset:
>> 
>>   [headroom][metadata][MAC hdr][L3 pkt]
>>                       ^
>>                       skb_metadata_end = head + mac_header
>> 
>> This design breaks on L2 decapsulation (VLAN, GRE, etc.) when the MAC
>> offset is reset. The naive fix is to memmove metadata on every decap path,
>> but we can avoid this cost by tracking metadata position independently.
>> 
>> Introduce a dedicated meta_end field in skb_shared_info that records where
>> metadata ends relative to skb->head:
>> 
>>   [headroom][metadata][gap][MAC hdr][L3 pkt]
>>                      ^
>>                      skb_metadata_end = head + meta_end
>>                      
>> This allows BPF dynptr access (bpf_dynptr_from_skb_meta()) to work without
>> memmove. For skb->data_meta pointer access, which expects metadata
>> immediately before skb->data, make the verifier inject realignment code in
>> TC BPF prologue.
>
> I don't understand what semantics for the buffer layout you're trying
> to establish, we now have "headroom" and "gap"?
>
> 	[headroom][metadata][gap][packet]
>
> You're not solving the encap side either, skb_push() will still happily
> encroach on the metadata. Feel like duct tape, we can't fundamentally
> update the layout of the skb without updating all the helpers.
> metadata works perfectly fine for its intended use case - passing info
> about the frame from XDP offload to XDP and then to TC.

<joke>
Man, that makes me think I'm a terrible speaker.
Or you just missed my talk :-)
</joke>

You're right that metadata passing between XDP and TC works well in the
simple case when both BPF progs are attached to the same device.

However, the metadata doesn't get cleared when skb undergoes L2
decapsulation. So if you attach the TC prog to the tunnel device, things
break. (VLAN being the exception since we handle it specially in
skb_reorder_vlan_header).

Here's a simple example using veth + GRE tunnel:

# ip netns add tx
# ip link add rx type veth peer name tx netns tx
# ip link set dev rx up
# ip -n tx link set dev tx up
# ip addr add 10.0.0.1/24 dev rx
# ip -n tx addr add 10.0.0.2/24 dev tx
# ip tun add decap mode gre local 10.0.0.1 remote 10.0.0.2
# ip -n tx tun add encap mode gre local 10.0.0.2 remote 10.0.0.1
# ip link set dev decap up
# ip -n tx link set dev encap up
# ip addr add 192.0.2.1/24 dev decap
# ip -n tx addr add 192.0.2.2/24 dev encap
# cat progs.bpf.c
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("xdp")
int set_tag(struct xdp_md *ctx)
{
        __u8 *data;
        __u32 *tag;

        if (bpf_xdp_adjust_meta(ctx, -sizeof(*tag)))
                return XDP_DROP;

        data = (typeof(data))(unsigned long)ctx->data;
        tag = (typeof(tag))(unsigned long)ctx->data_meta;

        if (tag + 1 > data)
                return XDP_DROP;

        *tag = 42;
        return XDP_PASS;
}

SEC("tcx/ingress")
int get_tag(struct __sk_buff *ctx)
{
        __u8 *data = (typeof(data))(unsigned long)ctx->data;
        __u32 *tag = (typeof(tag))(unsigned long)ctx->data_meta;

        if (tag + 1 > data)
                return TCX_DROP;

        bpf_printk("%u\n", *tag);
        return TCX_PASS;
}

const char _license[] SEC("license") = "GPL";
# bpftool prog loadall progs.bpf.o /sys/fs/bpf
# bpftool net attach xdp pinned /sys/fs/bpf/set_tag dev rx
# bpftool net attach tcx_ingress pinned /sys/fs/bpf/get_tag dev rx
# ip netns exec tx ping -c1 192.0.2.1
PING 192.0.2.1 (192.0.2.1) 56(84) bytes of data.
64 bytes from 192.0.2.1: icmp_seq=1 ttl=64 time=0.074 ms

--- 192.0.2.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.074/0.074/0.074/0.000 ms
# bpftool prog tracelog
     ksoftirqd/3-35      [003] ..s1.   592.051827: bpf_trace_printk: 42

            ping-251     [003] ..s2.   614.979169: bpf_trace_printk: 42

          <idle>-0       [003] ..s2.   620.212369: bpf_trace_printk: 42

^C# bpftool net attach tcx_ingress pinned /sys/fs/bpf/get_tag dev decap
# ip netns exec tx ping -c1 192.0.2.1
PING 192.0.2.1 (192.0.2.1) 56(84) bytes of data.
64 bytes from 192.0.2.1: icmp_seq=1 ttl=64 time=0.043 ms

--- 192.0.2.1 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.043/0.043/0.043/0.000 ms
# bpftool prog tracelog
            ping-263     [003] ..s2.   681.823981: bpf_trace_printk: 524288

^C#

When reading metadata from TC attached to the GRE device, we get garbage
(524288 = 0x0008_0000, which is actually the GRE header).

This happens because after GRE decapsulation, skb_metadata_end points to
the inner MAC header location:
 
  [headroom][metadata][outer MAC][outer IP][GRE][inner MAC][...]
                                                ^
                                                skb_metadata_end =
                                                head + mac_header
 
So we effectively already have a [headroom][metadata][gap][packet]
layout today, with the access being broken.


Regarding skb_push() and encapsulation - you're absolutely right that
this needs to be addressed. I mention it briefly in the cover letter,
but I should have been clearer about the plan:

This series focuses on fixing the decap/skb_pull path first. The
encap/skb_push side is on the roadmap [1], and patch 10 updates
skb_postpush_data_move() helper to be plugged after skb_push() in
preparation for handling metadata movement on push.

I'm just tackling stuff one by one, though I'm happy to prepare an RFC
that covers both sides, if you'd prefer to see the complete picture
upfront before making the call. Let me know what works best for you.

If it is the overall approach that feels wrong, I'm definitely open to
discussing alternatives.

Thanks,
-jkbs

[1] Tenative roadmap presented at LPC:

* [x] Add bpf_dynptr_from_skb_meta()
* [x] Make TC bpf_skb_*() helpers preserve metadata (bug fix)
* [-] Make L2 decap preserve metadata (bug fix)  [work in progress]
* [ ] Allow-list bpf_dynptr_from_skb_meta() for other BPF prog types
* [ ] uAPI read access to metadata 
-=-=- Milestone: Metadata on RX path -=-=-
* [ ] [FWD path] Make L2 encap preserve metadata (bug fix)
* [ ] [TX path] uAPI write access to metadata
* [ ] [TX path] Alloc metadata from other BPF prog types

