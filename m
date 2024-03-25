Return-Path: <netdev+bounces-81665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910CD88AAEF
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC731F2FCE4
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE01411E6;
	Mon, 25 Mar 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FTG/8txX"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB5F13E893;
	Mon, 25 Mar 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381664; cv=none; b=SVYgpd97y0SyLmKc4B7EI2DqZRng/RwyUE9Hl4iekMEMXFon5MyciKytMUjrjYSJBpibOAWk6f0srnjbKOOyww9CCQ9iG7K75l1ul6CIHIYf9XhX27CsWV9bd0GXhNUHV+LIaQSMarn3I122mlADMPcqa/N71ACfzSWNeVWUTfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381664; c=relaxed/simple;
	bh=AIuss2JLtgk1TNScK2t3uChndlqi+Vu43UzDADtbd+g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WLmFjDF03W6vhVbNDvo+fsPmaWEfQRuKdEnj9rBH3/gZEox5MESaLiGVMIJooK9KMvbk9/4o3K0ESb3Xp+0HhtfHFjGYTcx27pt13eIPp3OjL3ReChQppjro/ULpf0UaxRupTL5bt5dqbjOgZMz21oQlFWLXCVFuI87Dull+meM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FTG/8txX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5xg4/pPVHXXzu2T59YoVrsb3TXnzTyf/Igx1XL7mxh8=; b=FTG/8txXi/BKZTH95SBg1Go9R9
	0Etxrr5CgcWEbn0v/iUC+KgFact0nvd93tThv325SzA18B9LcEScNGKxv7hSj2+b+jtPym4VW5tbR
	WWmULjDlsUQM5VyZklZ9bgeLaZJpDWEl/OvPOF2wY8d16WXloO1+pBIXnqncr5phkpcBbJOHqTYjz
	s8r8Tgnr2lXjEV9eL67BOFnyiCuDhHGX2KgsHKylWrqsHIWBJr6EAm/hQfmLpMMiBiPXFH4wmaG7V
	VvhrNJZOA/LHq1RVZBaqj7aDCYIYlnoFQDfUHRYYgqdPXLwhJTm4RZk78RCvzmcKdPuyPBYSwh1W8
	yDuNelOw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1romXd-0002kr-Bf; Mon, 25 Mar 2024 16:47:17 +0100
Received: from [178.197.248.30] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1romXc-006fgf-0c;
	Mon, 25 Mar 2024 16:47:16 +0100
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Guillaume Nault <gnault@redhat.com>
Cc: patchwork-bot+netdevbpf@kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com,
 Stanislav Fomichev <sdf@google.com>, Willem de Bruijn <willemb@google.com>
References: <20240322122407.1329861-1-edumazet@google.com>
 <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
 <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <69bb87ad-bd0a-7cdc-7e01-e8a403c6689f@iogearbox.net>
Date: Mon, 25 Mar 2024 16:47:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27225/Mon Mar 25 09:30:27 2024)

On 3/25/24 2:33 PM, Eric Dumazet wrote:
> On Sat, Mar 23, 2024 at 4:02 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Fri, Mar 22, 2024 at 7:10 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>
>>> Hello:
>>>
>>> This patch was applied to bpf/bpf.git (master)
>>> by Daniel Borkmann <daniel@iogearbox.net>:
>>>
>>> On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
>>>> Some drivers ndo_start_xmit() expect a minimal size, as shown
>>>> by various syzbot reports [1].
>>>>
>>>> Willem added in commit 217e6fa24ce2 ("net: introduce device min_header_len")
>>>> the missing attribute that can be used by upper layers.
>>>>
>>>> We need to use it in __bpf_redirect_common().
>>
>> This patch broke empty_skb test:
>> $ test_progs -t empty_skb
>>
>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>> [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
>> [redirect_ingress]: actual -34 != expected 0
>> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_egress] 0 nsec
>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
>> [redirect_egress]: actual -34 != expected 1
>>
>> And looking at the test I think it's not a test issue.
>> This check
>> if (unlikely(skb->len < dev->min_header_len))
>> is rejecting more than it should.
>>
>> So I reverted this patch for now.
> 
> OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even if I
> move my sanity test in __bpf_tx_skb(),
> the bpf test program still fails, I am suspecting the test needs to be adjusted.

Let me take a look, I do think so too that we'd need to adjust the test.
I'll see to have a patch for the latter so that we can reapply the fix
as-is along with it given it's correct.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8afd2c3e8e7871ddc9231b76d
> 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
> net_device *dev, struct sk_buff *skb)
>                  return -ENETDOWN;
>          }
> 
> +       if (unlikely(skb->len < dev->min_header_len)) {
> +               pr_err_once("__bpf_tx_skb skb->len=%u <
> dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
> dev->min_header_len);
> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
> +               kfree_skb(skb);
> +               return -ERANGE;
> +       } // Note: this is before we change skb->dev
>          skb->dev = dev;
>          skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
>          skb_clear_tstamp(skb);
> 
> 
> -->
> 
> 
> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
> [redirect_egress]: actual -34 != expected 1
> 
> [   58.382051] __bpf_tx_skb skb->len=1 < dev(veth0)->min_header_len(14)
> [   58.382778] skb len=1 headroom=78 headlen=1 tailroom=113
>                 mac=(64,14) net=(78,-1) trans=-1
>                 shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>                 csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
>                 hash(0x0 sw=0 l4=0) proto=0x7f00 pkttype=0 iif=0
> 
> Note that veth driver is one of the few 'Ethernet' drivers that make
> sure to get at least 14 bytes in the skb at ndo_start_xmit()
> after commit 726e2c5929de841fdcef4e2bf995680688ae1b87 ("veth: Ensure
> eth header is in skb's linear part")
> 
> BTW this last patch (changing veth) should have been done generically
> from act_mirred
> 
> (We do not want to patch ~400 ethernet drivers in the tree)
> 


