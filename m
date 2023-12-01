Return-Path: <netdev+bounces-52927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 394BE800C77
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19522813CF
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DF33A295;
	Fri,  1 Dec 2023 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sa3WRT3J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C75D48
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 05:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701438404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZOsoVNTrlsyDIj04ZnPkYY4FYY9jzgQ1kRjegPcrJ4=;
	b=Sa3WRT3JBZLz14Sbr05jHknYxInAhAc4ooc2hlXeXXFfIxFCJOlolyYy8/h4YAthBSjrKt
	xU8LBmapDFApZ4jjJxatNOHE7yHeKelSIAMXh+vU9mlU8OXJdLj2nCEbWx5T8nZwI+5nei
	rDXDHgBzRCXk2m6PuHlFC9ZVxotkzfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-JxDopkrqPtS-12mHFloEHw-1; Fri, 01 Dec 2023 08:46:40 -0500
X-MC-Unique: JxDopkrqPtS-12mHFloEHw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8D7C811E7B;
	Fri,  1 Dec 2023 13:46:39 +0000 (UTC)
Received: from [10.45.225.216] (unknown [10.45.225.216])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA6F12166B26;
	Fri,  1 Dec 2023 13:46:37 +0000 (UTC)
Message-ID: <27946430-66d0-4a09-b275-ead122a082ce@redhat.com>
Date: Fri, 1 Dec 2023 14:46:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash during
 macvlan offloading setup
Content-Language: en-US
To: "Brelinski, Tony" <tony.brelinski@intel.com>,
 Simon Horman <horms@kernel.org>
Cc: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>,
 "Drewek, Wojciech" <wojciech.drewek@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
 open list <linux-kernel@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20231124164233.86691-1-ivecera@redhat.com>
 <20231129163618.GD43811@kernel.org>
 <DM6PR11MB4218C83B7A07BB833D298D388282A@DM6PR11MB4218.namprd11.prod.outlook.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <DM6PR11MB4218C83B7A07BB833D298D388282A@DM6PR11MB4218.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6



On 30. 11. 23 20:24, Brelinski, Tony wrote:
>> -----Original Message-----
>> From: Intel-wired-lan<intel-wired-lan-bounces@osuosl.org>  On Behalf Of
>> Simon Horman
>> Sent: Wednesday, November 29, 2023 8:36 AM
>> To: ivecera<ivecera@redhat.com>
>> Cc: Harshitha Ramamurthy<harshitha.ramamurthy@intel.com>; Drewek,
>> Wojciech<wojciech.drewek@intel.com>;netdev@vger.kernel.org;
>> Brandeburg, Jesse<jesse.brandeburg@intel.com>; open list <linux-
>> kernel@vger.kernel.org>; Eric Dumazet <edumazet@google.com>; Nguyen,
>> Anthony L<anthony.l.nguyen@intel.com>; Jeff Kirsher
>> <jeffrey.t.kirsher@intel.com>; moderated list:INTEL ETHERNET DRIVERS <intel-
>> wired-lan@lists.osuosl.org>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub
>> Kicinski<kuba@kernel.org>; Paolo Abeni<pabeni@redhat.com>; David S.
>> Miller<davem@davemloft.net>
>> Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix kernel crash during
>> macvlan offloading setup
>>
>> On Fri, Nov 24, 2023 at 05:42:33PM +0100, Ivan Vecera wrote:
>>> Function i40e_fwd_add() computes num of created channels and num of
>>> queues per channel according value of pf->num_lan_msix.
>>>
>>> This is wrong because the channels are used for subordinated net
>>> devices that reuse existing queues from parent net device and number
>>> of existing queue pairs (pf->num_queue_pairs) should be used instead.
>>>
>>> E.g.:
>>> Let's have (pf->num_lan_msix == 32)... Then we reduce number of
>>> combined queues by ethtool to 8 (so pf->num_queue_pairs == 8).
>>> i40e_fwd_add() called by macvlan then computes number of macvlans
>>> channels to be 16 and queues per channel 1 and calls
>>> i40e_setup_macvlans(). This computes new number of queue pairs for PF
>>> as:
>>>
>>> num_qps = vsi->num_queue_pairs - (macvlan_cnt * qcnt);
>>>
>>> This is evaluated in this case as:
>>> num_qps = (8 - 16 * 1) = (u16)-8 = 0xFFF8
>>>
>>> ...and this number is stored vsi->next_base_queue that is used during
>>> channel creation. This leads to kernel crash.
>>>
>>> Fix this bug by computing the number of offloaded macvlan devices and
>>> no. their queues according the current number of queues instead of
>>> maximal one.
>>>
>>> Reproducer:
>>> 1) Enable l2-fwd-offload
>>> 2) Reduce number of queues
>>> 3) Create macvlan device
>>> 4) Make it up
>>>
>>> Result:
>>> [root@cnb-03 ~]# ethtool -K enp2s0f0np0 l2-fwd-offload on
>>> [root@cnb-03 ~]# ethtool -l enp2s0f0np0 | grep Combined
>>> Combined:       32
>>> Combined:       32
>>> [root@cnb-03 ~]# ethtool -L enp2s0f0np0 combined 8
>>> [root@cnb-03 ~]# ip link add link enp2s0f0np0 mac0 type macvlan mode
>>> bridge
>>> [root@cnb-03 ~]# ip link set mac0 up
>>> ...
>>> [ 1225.686698] i40e 0000:02:00.0: User requested queue count/HW max
>>> RSS count:  8/32 [ 1242.399103] BUG: kernel NULL pointer dereference,
>>> address: 0000000000000118 [ 1242.406064] #PF: supervisor write access
>>> in kernel mode [ 1242.411288] #PF: error_code(0x0002) - not-present
>>> page [ 1242.416417] PGD 0 P4D 0 [ 1242.418950] Oops: 0002 [#1]
>> PREEMPT
>>> SMP NOPTI [ 1242.423308] CPU: 26 PID: 2253 Comm: ip Kdump: loaded
>> Not
>>> tainted 6.7.0-rc1+ #20 [ 1242.430607] Hardware name: Abacus electric,
>>> s.r.o. -servis@abacus.cz  Super Server/H12SSW-iN, BIOS 2.4 04/13/2022
>>> [ 1242.440850] RIP:
>>> 0010:i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e] [
>>> 1242.448165] Code: 48 89 b3 80 00 00 00 48 89 bb 88 00 00 00 74 3c 31
>>> c9 0f b7 53 16 49 8b b4 24 f0 0c 00 00 01 ca 83 c1 01 0f b7 d2 48 8b
>>> 34 d6 <48> 89 9e 18 01 00 00 49 8b b4 24 e8 0c 00 00 48 8b 14 d6 48 89
>>> 9a [ 1242.466902] RSP: 0018:ffffa4d52cd2f610 EFLAGS: 00010202 [
>>> 1242.472121] RAX: 0000000000000000 RBX: ffff9390a4ba2e40 RCX:
>>> 0000000000000001 [ 1242.479244] RDX: 000000000000fff8 RSI:
>>> 0000000000000000 RDI: ffffffffffffffff [ 1242.486370] RBP:
>>> ffffa4d52cd2f650 R08: 0000000000000020 R09: 0000000000000000 [
>>> 1242.493494] R10: 0000000000000000 R11: 0000000100000001 R12:
>>> ffff9390b861a000 [ 1242.500626] R13: 00000000000000a0 R14:
>>> 0000000000000010 R15: ffff9390b861a000 [ 1242.507751] FS:
>> 00007efda536b740(0000) GS:ffff939f4ec80000(0000)
>> knlGS:0000000000000000 [ 1242.515826] CS:  0010 DS: 0000 ES: 0000
>> CR0: 0000000080050033 [ 1242.521564] CR2: 0000000000000118 CR3:
>> 000000010bd48002 CR4: 0000000000770ef0 [ 1242.528699] PKRU:
>> 55555554 [ 1242.531400] Call Trace:
>>> [ 1242.533846]  <TASK>
>>> [ 1242.535943]  ? __die+0x20/0x70
>>> [ 1242.539004]  ? page_fault_oops+0x76/0x170 [ 1242.543018]  ?
>>> exc_page_fault+0x65/0x150 [ 1242.546942]  ?
>>> asm_exc_page_fault+0x22/0x30 [ 1242.551131]  ?
>>> i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e] [
>>> 1242.557847]  i40e_setup_channel.part.0+0x5f/0x130 [i40e] [
>>> 1242.563167]  i40e_setup_macvlans.constprop.0+0x256/0x420 [i40e] [
>>> 1242.569099]  i40e_fwd_add+0xbf/0x270 [i40e] [ 1242.573300]
>>> macvlan_open+0x16f/0x200 [macvlan] [ 1242.577831]
>>> __dev_open+0xe7/0x1b0 [ 1242.581236]
>> __dev_change_flags+0x1db/0x250
>>> ...
>>>
>>> Fixes: 1d8d80b4e4ff ("i40e: Add macvlan support on i40e")
>>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>> Thanks Ivan,
>>
>> I agree with the analysis and that the problem was introduced by the cited
>> patch.
>>
>> Reviewed-by: Simon Horman<horms@kernel.org>
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> The issue this patch is supposed to fix is resolved by this patch, but now there is a new crash seen with this patch.  Crash output below:
> 
> Crash logs:
> 
> [  315.844666] i40e 0000:86:00.0: Query for DCB configuration failed, err -EIO aq_err I40E_AQ_RC_EINVAL
> [  315.844678] i40e 0000:86:00.0: DCB init failed -5, disabled
> [  315.873394] i40e 0000:86:00.0: User requested queue count/HW max RSS count:  1/64
> [  315.900682] i40e 0000:86:00.0 eth4: Not enough queues to support macvlans

I'm able to reproduce now... I have found that the macvlan offloading is 
broken in several ways. I'm working to address theses issues.

Thanks,
Ivan


