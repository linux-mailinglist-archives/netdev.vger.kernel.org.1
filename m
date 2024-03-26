Return-Path: <netdev+bounces-82217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B2688CB65
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD465B21DDC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117391F61C;
	Tue, 26 Mar 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Gg6amDcc"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C41B59A;
	Tue, 26 Mar 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475871; cv=none; b=NlSVDrONXT5cTmei9Vf03ki7cbCP05hTL/+4NJ4xU53du0EigqTgv9XKcfVb3TQn4ie42YTr4p7fmx4l0vptka7urrQby3S5SYBSNMHtZlo9fhCephSQTRgsT6L7kR+hUsuRd1xhLuYS63btEMFPupPpYMTyq36JvVEy4B5+DsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475871; c=relaxed/simple;
	bh=2XOEb8/tEGx++LByd0zya3Tq5HnGdCS+i+VjlzjOYUs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sSFCl/o3KCFb63Z+Nv+f2Xoc55kCHRFLf59voe+CGpx2hEcOHHquo4N0PMDy60U5pCOx8687+ayDDFOt9EFB7T91i8PzZJnaDcbA/nMehit+nAjYp3aHKZZDUlZmbAdfkFfE86stWFVqrZeckOUnrbP4R5pxwncPQUeUqQeXl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Gg6amDcc; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2hTyqCB9lzhqAv9GI9VJ4HtBOaQLlQuApz9UaAKRU6w=; b=Gg6amDccm7+BEKosol8dR4Y6pg
	f5bPvOAk5EkvaUAQWPqcsbXZOz9VSmXhhjIhkbX6PCrMz9nrkKpvxOCZFYHxOyU/zCIY8c2wZASeE
	akayb7K2T1kOAjVe8vfh6SRJRXnt5xkfIblXIZUYaY4YONApvYgSLn8g2VZpNQKAtolI2QxYqvFJP
	LRSXaCvEqzTa6sPV3/AQjJet68o+b3dE1IN8A8OJTj9XQlOkdW50h6imy1cpO89vAoHTrWnfzEpHh
	S3cflHIxaIEFw1iwSMBKBncBK31zYtQgRoNhdVWvzDb8nUl9wVt5fYcxI3SYVB5S8VbwQiwlNJKxY
	syNtqpEA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rpB3C-000NAi-T1; Tue, 26 Mar 2024 18:57:30 +0100
Received: from [178.197.248.30] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rpB3B-000KMt-2n;
	Tue, 26 Mar 2024 18:57:30 +0100
Subject: Re: [PATCH net] bpf: Don't redirect too small packets
To: Eric Dumazet <edumazet@google.com>
Cc: Stanislav Fomichev <sdf@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Guillaume Nault <gnault@redhat.com>, patchwork-bot+netdevbpf@kernel.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko
 <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 syzbot+9e27778c0edc62cb97d8@syzkaller.appspotmail.com,
 Willem de Bruijn <willemb@google.com>
References: <20240322122407.1329861-1-edumazet@google.com>
 <171111663201.19374.16295682760005551863.git-patchwork-notify@kernel.org>
 <CAADnVQJy+0=6ZuAz-7dwOPK3sN2QrPiAcxhtojh8p65j0TRNhg@mail.gmail.com>
 <CANn89iLSOeFGNogYMHbeLRC5kOwwArMz3d5_2hZmBn6fibyUhw@mail.gmail.com>
 <CAADnVQ+OhsBetPT0avuNVsEwru13UtMjX1U_6_u6xROXBBn-Yg@mail.gmail.com>
 <ZgGmQu09Z9xN7eOD@google.com>
 <d9531955-06ad-ccdd-d3d0-4779400090ba@iogearbox.net>
 <CANn89iJFOR5ucef0bH=BTKrLOAGsUtF8tM=cYNDTg+=gHDntvw@mail.gmail.com>
 <CANn89iKZ0126qzvpm0bPP7O+M95hcGWKp_HPg+M7vgdDHr0u0A@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3050c54d-3b3c-53b0-6004-fa11caca27b6@iogearbox.net>
Date: Tue, 26 Mar 2024 18:57:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iKZ0126qzvpm0bPP7O+M95hcGWKp_HPg+M7vgdDHr0u0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27226/Tue Mar 26 09:37:28 2024)

On 3/26/24 2:38 PM, Eric Dumazet wrote:
> On Tue, Mar 26, 2024 at 2:37 PM Eric Dumazet <edumazet@google.com> wrote:
>> On Tue, Mar 26, 2024 at 1:46 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>> On 3/25/24 5:28 PM, Stanislav Fomichev wrote:
>>>> On 03/25, Alexei Starovoitov wrote:
>>>>> On Mon, Mar 25, 2024 at 6:33 AM Eric Dumazet <edumazet@google.com> wrote:
>>>>>> On Sat, Mar 23, 2024 at 4:02 AM Alexei Starovoitov
>>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>> On Fri, Mar 22, 2024 at 7:10 AM <patchwork-bot+netdevbpf@kernel.org> wrote:
>>>>>>>>
>>>>>>>> Hello:
>>>>>>>>
>>>>>>>> This patch was applied to bpf/bpf.git (master)
>>>>>>>> by Daniel Borkmann <daniel@iogearbox.net>:
>>>>>>>>
>>>>>>>> On Fri, 22 Mar 2024 12:24:07 +0000 you wrote:
>>>>>>>>> Some drivers ndo_start_xmit() expect a minimal size, as shown
>>>>>>>>> by various syzbot reports [1].
>>>>>>>>>
>>>>>>>>> Willem added in commit 217e6fa24ce2 ("net: introduce device min_header_len")
>>>>>>>>> the missing attribute that can be used by upper layers.
>>>>>>>>>
>>>>>>>>> We need to use it in __bpf_redirect_common().
>>>>>>>
>>>>>>> This patch broke empty_skb test:
>>>>>>> $ test_progs -t empty_skb
>>>>>>>
>>>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>>>>>>> [redirect_ingress] unexpected ret: veth ETH_HLEN+1 packet ingress
>>>>>>> [redirect_ingress]: actual -34 != expected 0
>>>>>>> test_empty_skb:PASS:err: veth ETH_HLEN+1 packet ingress [redirect_egress] 0 nsec
>>>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>>>>>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
>>>>>>> [redirect_egress]: actual -34 != expected 1
>>>>>>>
>>>>>>> And looking at the test I think it's not a test issue.
>>>>>>> This check
>>>>>>> if (unlikely(skb->len < dev->min_header_len))
>>>>>>> is rejecting more than it should.
>>>>>>>
>>>>>>> So I reverted this patch for now.
>>>>>>
>>>>>> OK, it seems I missed __bpf_rx_skb() vs __bpf_tx_skb(), but even if I
>>>>>> move my sanity test in __bpf_tx_skb(),
>>>>>> the bpf test program still fails, I am suspecting the test needs to be adjusted.
>>>>>>
>>>>>> diff --git a/net/core/filter.c b/net/core/filter.c
>>>>>> index 745697c08acb3a74721d26ee93389efa81e973a0..e9c0e2087a08f1d8afd2c3e8e7871ddc9231b76d
>>>>>> 100644
>>>>>> --- a/net/core/filter.c
>>>>>> +++ b/net/core/filter.c
>>>>>> @@ -2128,6 +2128,12 @@ static inline int __bpf_tx_skb(struct
>>>>>> net_device *dev, struct sk_buff *skb)
>>>>>>                   return -ENETDOWN;
>>>>>>           }
>>>>>>
>>>>>> +       if (unlikely(skb->len < dev->min_header_len)) {
>>>>>> +               pr_err_once("__bpf_tx_skb skb->len=%u <
>>>>>> dev(%s)->min_header_len(%u)\n", skb->len, dev->name,
>>>>>> dev->min_header_len);
>>>>>> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
>>>>>> +               kfree_skb(skb);
>>>>>> +               return -ERANGE;
>>>>>> +       } // Note: this is before we change skb->dev
>>>>>>           skb->dev = dev;
>>>>>>           skb_set_redirected_noclear(skb, skb_at_tc_ingress(skb));
>>>>>>           skb_clear_tstamp(skb);
>>>>>>
>>>>>>
>>>>>> -->
>>>>>>
>>>>>>
>>>>>> test_empty_skb:FAIL:ret: veth ETH_HLEN+1 packet ingress
>>>>>> [redirect_egress] unexpected ret: veth ETH_HLEN+1 packet ingress
>>>>>> [redirect_egress]: actual -34 != expected 1
>>>>>>
>>>>>> [   58.382051] __bpf_tx_skb skb->len=1 < dev(veth0)->min_header_len(14)
>>>>>> [   58.382778] skb len=1 headroom=78 headlen=1 tailroom=113
>>>>>>                  mac=(64,14) net=(78,-1) trans=-1
>>>>>>                  shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>>>>>>                  csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
>>>>>>                  hash(0x0 sw=0 l4=0) proto=0x7f00 pkttype=0 iif=0
>>>>>
>>>>> Hmm. Something is off.
>>>>> That test creates 15 byte skb.
>>>>> It's not obvious to me how it got reduced to 1.
>>>>> Something stripped L2 header and the prog is trying to redirect
>>>>> such skb into veth that expects skb with L2 ?
>>>>>
>>>>> Stan,
>>>>> please take a look.
>>>>> Since you wrote that test.
>>>>
>>>> Sure. Daniel wants to take a look on a separate thread, so we can sync
>>>> up. Tentatively, seems like the failure is in the lwt path that does
>>>> indeed drop the l2.
>>>
>>> If we'd change the test into the below, the tc and empty_skb tests pass.
>>> run_lwt_bpf() calls into skb_do_redirect() which has L2 stripped, and thus
>>> skb->len is 1 in this test. We do use skb_mac_header_len() also in other
>>> tc BPF helpers, so perhaps s/skb->len/skb_mac_header_len(skb)/ is the best
>>> way forward..
>>>
>>> static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
>>>                                    u32 flags)
>>> {
>>>           /* Verify that a link layer header is carried */
>>>           if (unlikely(skb->mac_header >= skb->network_header || skb->len == 0)) {
>>>                   kfree_skb(skb);
>>>                   return -ERANGE;
>>>           }
>>>
>>>           if (unlikely(skb_mac_header_len(skb) < dev->min_header_len)) {
>>
>> Unfortunately this will not prevent frames with skb->len == 1 to reach
>> an Ethernet driver ndo_start_xmit()
>>
>> At ndo_start_xmit(), we do not look where the MAC header supposedly
>> starts in the skb, we only use skb->data
>>
>> I have a syzbot repro using team driver, so I added the following part in team :
>>
>> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
>> index 0a44bbdcfb7b9f30a0c27b700246501c5eba322f..75e5ef585a8f05b35cfddbae0bfc377864e6e38c
>> 100644
>> --- a/drivers/net/team/team.c
>> +++ b/drivers/net/team/team.c
>> @@ -1714,6 +1714,11 @@ static netdev_tx_t team_xmit(struct sk_buff
>> *skb, struct net_device *dev)
>>          bool tx_success;
>>          unsigned int len = skb->len;
>>
>> +       if (len < 14) {
>> +               pr_err_once("team_xmit(len=%u)\n", len);
>> +               DO_ONCE_LITE(skb_dump, KERN_ERR, skb, false);
>> +               WARN_ON_ONCE(1);
>> +       }
>>          tx_success = team_queue_override_transmit(team, skb);
>>          if (!tx_success)
>>                  tx_success = team->ops.transmit(team, skb);
>>
>>
>> And I get (with your suggestion instead of skb->len)
> 
> Missing part in my copy/paste :
> 
> [   41.123829] team_xmit(len=1)
> [   41.124335] skb len=1 headroom=78 headlen=1 tailroom=113
> 
>> mac=(78,0) net=(78,-1) trans=-1

Interesting.

Could you also dump dev->type and/or dev->min_header_len? I suspect
this case may not be ARPHRD_ETHER in team.

Above says mac=(78,0), so mac len is 0 and the check against the
dev->min_header_len should have dropped it if it went that branch.

I wonder, is team driver missing sth like :

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 0a44bbdcfb7b..6256f0d2f565 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2124,6 +2124,7 @@ static void team_setup_by_port(struct net_device *dev,
         dev->type = port_dev->type;
         dev->hard_header_len = port_dev->hard_header_len;
         dev->needed_headroom = port_dev->needed_headroom;
+       dev->min_header_len = port_dev->min_header_len;
         dev->addr_len = port_dev->addr_len;
         dev->mtu = port_dev->mtu;
         memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);

>> shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
>> csum(0x0 ip_summed=0 complete_sw=0 valid=0 level=0)
>> hash(0x0 sw=0 l4=0) proto=0x88a8 pkttype=3 iif=0
>> [   41.126553] dev name=team0 feat=0x0000e0064fddfbe9
>> [   41.127132] skb linear:   00000000: 55
>> [   41.128487] ------------[ cut here ]------------
>> [   41.128551] WARNING: CPU: 2 PID: 1880 at
>> drivers/net/team/team.c:1720 team_xmit (drivers/net/team/team.c:1720
>> (discriminator 1))
>> [   41.129072] Modules linked in: macsec macvtap macvlan hsr wireguard
>> curve25519_x86_64 libcurve25519_generic libchacha20poly1305
>> chacha_x86_64 libchacha poly1305_x86_64 batman_adv dummy bridge sr_mod
>> cdrom evdev pcspkr i2c_piix4 9pnet_virtio 9p netfs 9pnet
>> [   41.129613] CPU: 2 PID: 1880 Comm: b330650301 Not tainted 6.8.0-virtme #238
>> [   41.129664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   41.129780] RIP: 0010:team_xmit (drivers/net/team/team.c:1720
>> (discriminator 1))
>> [ 41.129847] Code: 41 54 53 44 8b 7f 70 48 89 fb 41 83 ff 0d 77 1c 80
>> 3d a0 24 8d 01 00 0f 84 0d 01 00 00 80 3d 92 24 8d 01 00 0f 84 e3 00
>> 00 00 <0f> 0b 41 80 be 21 0b 00 00 00 0f 84 9d 00 00 00 0f b7 43 7c 66
>> 85
>> All code
>> ========
>>     0: 41 54                push   %r12
>>     2: 53                    push   %rbx
>>     3: 44 8b 7f 70          mov    0x70(%rdi),%r15d
>>     7: 48 89 fb              mov    %rdi,%rbx
>>     a: 41 83 ff 0d          cmp    $0xd,%r15d
>>     e: 77 1c                ja     0x2c
>>    10: 80 3d a0 24 8d 01 00 cmpb   $0x0,0x18d24a0(%rip)        # 0x18d24b7
>>    17: 0f 84 0d 01 00 00    je     0x12a
>>    1d: 80 3d 92 24 8d 01 00 cmpb   $0x0,0x18d2492(%rip)        # 0x18d24b6
>>    24: 0f 84 e3 00 00 00    je     0x10d
>>    2a:* 0f 0b                ud2 <-- trapping instruction
>>    2c: 41 80 be 21 0b 00 00 cmpb   $0x0,0xb21(%r14)
>>    33: 00
>>    34: 0f 84 9d 00 00 00    je     0xd7
>>    3a: 0f b7 43 7c          movzwl 0x7c(%rbx),%eax
>>    3e: 66                    data16
>>    3f: 85                    .byte 0x85
>>
>> Code starting with the faulting instruction
>> ===========================================
>>     0: 0f 0b                ud2
>>     2: 41 80 be 21 0b 00 00 cmpb   $0x0,0xb21(%r14)
>>     9: 00
>>     a: 0f 84 9d 00 00 00    je     0xad
>>    10: 0f b7 43 7c          movzwl 0x7c(%rbx),%eax
>>    14: 66                    data16
>>    15: 85                    .byte 0x85
>> [   41.129902] RSP: 0018:ffffa4210433b938 EFLAGS: 00000246
>> [   41.129945] RAX: 0000000000000000 RBX: ffffa4210858a300 RCX: 0000000000000000
>> [   41.129961] RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: 0000000000000001
>> [   41.129975] RBP: ffffa4210433b960 R08: 0000000000000000 R09: ffffa4210433b630
>> [   41.129989] R10: 0000000000000001 R11: ffffffff8407d340 R12: 0000000000000000
>> [   41.130004] R13: ffffa4210ecee000 R14: ffffa4210ece4000 R15: 0000000000000001
>> [   41.130074] FS:  00007f91d9549740(0000) GS:ffffa42fffa80000(0000)
>> knlGS:0000000000000000
>> [   41.130095] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   41.130140] CR2: 00007f8953077fb0 CR3: 0000000104f42000 CR4: 00000000000006f0
>> [   41.130229] Call Trace:
>> [   41.130331]  <TASK>
>> [   41.130530] ? show_regs (arch/x86/kernel/dumpstack.c:479)
>> [   41.130598] ? __warn (kernel/panic.c:694)
>> [   41.130611] ? team_xmit (drivers/net/team/team.c:1720 (discriminator 1))
>> [   41.130625] ? report_bug (lib/bug.c:180 lib/bug.c:219)
>> [   41.130640] ? handle_bug (arch/x86/kernel/traps.c:239)
>> [   41.130653] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1))
>> [   41.130665] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
>> [   41.130700] ? team_xmit (drivers/net/team/team.c:1720 (discriminator 1))
>> [   41.130714] ? team_xmit (drivers/net/team/team.c:1719 (discriminator 6))
>> [   41.130734] dev_hard_start_xmit (./include/linux/netdevice.h:4903
>> ./include/linux/netdevice.h:4917 net/core/dev.c:3531
>> net/core/dev.c:3547)
>> [   41.130768] __dev_queue_xmit (./include/linux/netdevice.h:3287
>> (discriminator 25) net/core/dev.c:4336 (discriminator 25))
>> [   41.130780] ? kmalloc_reserve (net/core/skbuff.c:580 (discriminator 4))
>> [   41.130796] ? pskb_expand_head (net/core/skbuff.c:2292)
>> [   41.130815] __bpf_redirect (./include/linux/netdevice.h:3287
>> (discriminator 25) net/core/filter.c:2143 (discriminator 25)
>> net/core/filter.c:2172 (discriminator 25) net/core/filter.c:2196
>> (discriminator 25))
>> [   41.130825] bpf_clone_redirect (net/core/filter.c:2467
>> (discriminator 1) net/core/filter.c:2439 (discriminator 1))
>> [   41.130841] bpf_prog_9845f5eee09e82c6+0x61/0x66
>> [   41.130948] ? bpf_ksym_find (./include/linux/rbtree_latch.h:113
>> ./include/linux/rbtree_latch.h:208 kernel/bpf/core.c:734)
>> [   41.130963] ? is_bpf_text_address
>> (./arch/x86/include/asm/preempt.h:84 (discriminator 13)
>> ./include/linux/rcupdate.h:97 (discriminator 13)
>> ./include/linux/rcupdate.h:813 (discriminator 13)
>> kernel/bpf/core.c:769 (discriminator 13))
>> [   41.130976] ? kernel_text_address (kernel/extable.c:125
>> (discriminator 1) kernel/extable.c:94 (discriminator 1))
>> [   41.130989] ? __kernel_text_address (kernel/extable.c:79 (discriminator 1))
>> [   41.131002] ? unwind_get_return_address
>> (arch/x86/kernel/unwind_frame.c:19 (discriminator 1))
>> [   41.131014] ? __pfx_stack_trace_consume_entry (kernel/stacktrace.c:83)
>> [   41.131028] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
>> [   41.131044] ? stack_depot_save_flags (lib/stackdepot.c:675)
>> [   41.131062] ? ktime_get (kernel/time/timekeeping.c:292
>> kernel/time/timekeeping.c:388 kernel/time/timekeeping.c:848)
>> [   41.131076] bpf_test_run (./include/linux/bpf.h:1234
>> ./include/linux/filter.h:657 ./include/linux/filter.h:664
>> net/bpf/test_run.c:425)
>> [   41.131087] ? security_sk_alloc (security/security.c:4662 (discriminator 13))


