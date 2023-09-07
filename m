Return-Path: <netdev+bounces-32400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3594D7973EF
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186611C20B3D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63CA12B6A;
	Thu,  7 Sep 2023 15:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA28125D2
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:33:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 753D3171C;
	Thu,  7 Sep 2023 08:32:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5BFB153B;
	Thu,  7 Sep 2023 02:35:57 -0700 (PDT)
Received: from [10.57.30.76] (unknown [10.57.30.76])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40DAB3F64C;
	Thu,  7 Sep 2023 02:35:18 -0700 (PDT)
Message-ID: <59465cbb-48b4-c32b-8a7a-c9b51556d5e1@arm.com>
Date: Thu, 7 Sep 2023 10:35:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [syzbot] [arm?] [netfilter?] KASAN: slab-out-of-bounds Read in
 do_csum
Content-Language: en-GB
To: Will Deacon <will@kernel.org>
Cc: syzbot <syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com>,
 catalin.marinas@arm.com, fw@strlen.de, kadlec@netfilter.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 pablo@netfilter.org, syzkaller-bugs@googlegroups.com
References: <000000000000e0e94c0603f8d213@google.com>
 <20230905143711.GB3322@willie-the-truck>
 <0dea99d9-3334-3fd3-3776-074ecace0259@arm.com>
 <20230907092511.GB5731@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230907092511.GB5731@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-07 10:25, Will Deacon wrote:
> On Tue, Sep 05, 2023 at 04:02:19PM +0100, Robin Murphy wrote:
>> On 05/09/2023 3:37 pm, Will Deacon wrote:
>>> On Mon, Aug 28, 2023 at 03:04:44AM -0700, syzbot wrote:
>>>> HEAD commit:    908f31f2a05b Merge branch 'for-next/core', remote-tracking..
>>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=155e0463280000
>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c1058fe68f4b7b2c
>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=4a9f9820bd8d302e22f7
>>>> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>>>> userspace arch: arm64
>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bc548d280000
>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135bba3b280000
>>>>
>>>> Downloadable assets:
>>>> disk image: https://storage.googleapis.com/syzbot-assets/87d095820229/disk-908f31f2.raw.xz
>>>> vmlinux: https://storage.googleapis.com/syzbot-assets/a1bf67af9675/vmlinux-908f31f2.xz
>>>> kernel image: https://storage.googleapis.com/syzbot-assets/7784a88b37e8/Image-908f31f2.gz.xz
>>>>
>>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>>> Reported-by: syzbot+4a9f9820bd8d302e22f7@syzkaller.appspotmail.com
>>>>
>>>> netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
>>>> netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
>>>> ==================================================================
>>>> BUG: KASAN: slab-out-of-bounds in do_csum+0x44/0x254 arch/arm64/lib/csum.c:39
>>>> Read of size 4294966928 at addr ffff0000d7ac0170 by task syz-executor412/5975
>>
>> Yup, that looks suspiciously "-368"-shaped...
>>
>>> Judging by the UBSAN errors:
>>>
>>> | shift exponent 3008 is too large for 64-bit type 'u64' (aka 'unsigned long long')
>>>
>>> We're probably being passed a negative 'len' argument. It looks like the
>>> generic version in lib/checksum.c rejects that early, so maybe we should
>>> do the same in the arch code?
>>
>> Hmm, indeed I can offer no explanation as to why I put "if (len == 0)" there
>> rather than "if (len <= 0)" like literally every other C implementation* :/
> 
> I've made that change:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/fixes&id=8bd795fedb8450ecbef18eeadbd23ed8fc7630f5

If you want it,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> 
> Cheers,
> 
> Will

