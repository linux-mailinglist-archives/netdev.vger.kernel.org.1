Return-Path: <netdev+bounces-82038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B91188C280
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BB41F650DF
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B95C61F;
	Tue, 26 Mar 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ABrFPU4N"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEC14A8E;
	Tue, 26 Mar 2024 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457199; cv=none; b=Jcvl0MJQ+AZ74AQ3QNRQNoH4bTRonzXfbOcb9O1FWIjztGg1Kr9hrZyDhYbiOCprl6WmZjHQxNOrsdVIezumqKSVKBE/P5rEm6qLsCvpbFt+vBSAe/IAMsrVB03Kct92SYJeeXN3AW87WxplVVz8l8FAKLB5GR1yaHO971Y1h2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457199; c=relaxed/simple;
	bh=hwuqNlIoW1eh62U/CrrcM41dXmP127sWmudFYXwn90M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l9chtatjAjC2vPRp8T7XuEsX+i2KLXpX7iZNX8VTzx5k9Ayd4Q5634VVD1kUCyxdb+jKttuLZ/ndl9GgkozK5jM0wpz6sVpRMBOo1JrokafSUKA5JA2eKKRd6aTS+5zuN9MmRdkHWaID3fL8ZMDlPr0LKkmX/Cc9QtY12vvzVWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ABrFPU4N; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iu293LeB3d/Uyn4wXl7wKNldzLqRgRxlP7R7VQm4BP0=; b=ABrFPU4N1noUANzlT1WG0JrQ32
	ccTCsBC+aiiv3RLfsz6MKV6FpGGfdyBhqUygSTGYdMzN4p3RoZ6dWV+YUBY7JM2h5u410ag8C31t5
	SU7lCNQmC1jmbA0hS66DWadTtx0/Z0mfNOljO+9yyQu5s7UqOi2t6jCJWTpzagGqot80Aqy65Hhla
	U0CuEoOCc4QYMNymBgy3fkJENYfWXa3vuYXxMCO9JGyw4xD2LE0NH0jdgvP8HWKcozvQczp2FWqGo
	nPPByNgh6O85dVpB0V9t4mDLEQi666rj7vE9+ykEI/ymSQK9Z6vvTgAwwh6bUppf5KvHg8Unu6Ubi
	QapwUcsA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rp6C9-000B3b-1x; Tue, 26 Mar 2024 13:46:25 +0100
Received: from [178.197.248.30] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rp6C8-0002dz-2g; Tue, 26 Mar 2024 13:46:24 +0100
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Stanislav Fomichev <sdf@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Guillaume Nault <gnault@redhat.com>,
 patchwork-bot+netdevbpf@kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>,
 Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com,
 Willem de Bruijn <willemb@google.com>
References: <20240322122407.1329861-1-edumazet@google.com>
 <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
 <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
 <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
 <ZgGmQu09Z9xN7eOD@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d9531955-06ad-ccdd-d3d0-4779400090ba@iogearbox.net>
Date: Tue, 26 Mar 2024 13:46:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgGmQu09Z9xN7eOD@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27226/Tue Mar 26 09:37:28 2024)

On 3/25/24 5:28 PM, Stanislav Fomichev wrote:
> On 03/25, Alexei Starovoitov wrote:
>> On Mon, Mar 25, 2024 at 6:33 AM Eric Dumazet <edumazet@google.com> wrote:
>>>
>>> On Sat, Mar 23, 2024 at 4:02 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Fri, Mar 22, 2024 at 7:10 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>>>
>>>>> Hello:
>>>>>
>>>>> This patch was applied to bpf/bpf.git (master)
>>>>> by Daniel Borkmann <daniel@iogearbox.net>:
>>>>>
>>>>> On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
>>>>>> Some drivers ndo_start_xmit() expect a minimal size, as shown
>>>>>> by various syzbot reports [1].
>>>>>>
>>>>>> Willem added in commit 217e6fa24ce2 ("net: introduce device min_header_len")
>>>>>> the missing attribute that can be used by upper layers.
>>>>>>
>>>>>> We need to use it in __bpf_redirect_common().
>>>>
>>>> This patch broke empty_skb test:
>>>> $ test_progs -t empty_skb
>>>>
>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>>>> [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
>>>> [redirect_ingress]: actual -34 != expected 0
>>>> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_egress] 0 nsec
>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
>>>> [redirect_egress]: actual -34 != expected 1
>>>>
>>>> And looking at the test I think it's not a test issue.
>>>> This check
>>>> if (unlikely(skb->len < dev->min_header_len))
>>>> is rejecting more than it should.
>>>>
>>>> So I reverted this patch for now.
>>>
>>> OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even if I
>>> move my sanity test in __bpf_tx_skb(),
>>> the bpf test program still fails, I am suspecting the test needs to be adjusted.
>>>
>>>
>>>
>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>> index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8afd2c3e8e7871ddc9231b76d
>>> 100644
>>> --- a/net/core/filter.c
>>> +++ b/net/core/filter.c
>>> @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
>>> net_device *dev, struct sk_buff *skb)
>>>                  return -ENETDOWN;
>>>          }
>>>
>>> +       if (unlikely(skb->len < dev->min_header_len)) {
>>> +               pr_err_once("__bpf_tx_skb skb->len=%u <
>>> dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
>>> dev->min_header_len);
>>> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
>>> +               kfree_skb(skb);
>>> +               return -ERANGE;
>>> +       } // Note: this is before we change skb->dev
>>>          skb->dev = dev;
>>>          skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
>>>          skb_clear_tstamp(skb);
>>>
>>>
>>> -->
>>>
>>>
>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
>>> [redirect_egress]: actual -34 != expected 1
>>>
>>> [   58.382051] __bpf_tx_skb skb->len=1 < dev(veth0)->min_header_len(14)
>>> [   58.382778] skb len=1 headroom=78 headlen=1 tailroom=113
>>>                 mac=(64,14) net=(78,-1) trans=-1
>>>                 shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>>>                 csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
>>>                 hash(0x0 sw=0 l4=0) proto=0x7f00 pkttype=0 iif=0
>>
>> Hmm. Something is off.
>> That test creates 15 byte skb.
>> It's not obvious to me how it got reduced to 1.
>> Something stripped L2 header and the prog is trying to redirect
>> such skb into veth that expects skb with L2 ?
>>
>> Stan,
>> please take a look.
>> Since you wrote that test.
> 
> Sure. Daniel wants to take a look on a separate thread, so we can sync
> up. Tentatively, seems like the failure is in the lwt path that does
> indeed drop the l2.

If we'd change the test into the below, the tc and empty_skb tests pass.
run_lwt_bpf() calls into skb_do_redirect() which has L2 stripped, and thus
skb->len is 1 in this test. We do use skb_mac_header_len() also in other
tc BPF helpers, so perhaps s/skb->len/skb_mac_header_len(skb)/ is the best
way forward..

static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
                                  u32 flags)
{
         /* Verify that a link layer header is carried */
         if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0)) {
                 kfree_skb(skb);
                 return -ERANGE;
         }

         if (unlikely(skb_mac_header_len(skb) < dev->min_header_len)) {
                 kfree_skb(skb);
                 return -ERANGE;
         }

         bpf_push_mac_rcsum(skb);
         return flags & BPF_F_INGRESS ?
                __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);
}

Thanks,
Daniel

