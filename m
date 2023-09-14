Return-Path: <netdev+bounces-33944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495ED7A0C46
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 20:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013611F244E7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 18:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64475219F4;
	Thu, 14 Sep 2023 18:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3032628E
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 18:08:41 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C6F1FDF;
	Thu, 14 Sep 2023 11:08:40 -0700 (PDT)
Received: from [2a02:8108:d00:dcc::d6ab]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qgqla-0002SE-QL; Thu, 14 Sep 2023 20:08:38 +0200
Message-ID: <ff2abfbe-a46b-414b-a757-8185495838b7@leemhuis.info>
Date: Thu, 14 Sep 2023 20:08:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix handling of
 HCI_QUIRK_STRICT_DUPLICATE_FILTER
Content-Language: en-US, de-DE
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 patchwork-bot+bluetooth@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, Stefan Agner <stefan@agner.ch>
References: <20230829205936.766544-1-luiz.dentz@gmail.com>
 <169343402479.21564.11565149320234658166.git-patchwork-notify@kernel.org>
 <de698d06-9784-43ed-9437-61d6edf9672b@leemhuis.info>
 <CABBYNZK2PPkLra8Au-fdN2nG2YLkfFRmPtEPQL0suLzBv=HHcA@mail.gmail.com>
 <574ca8dd-ee97-4c8b-a154-51faf83cabdf@leemhuis.info>
 <CABBYNZJ=5VH2+my7Gw1fMCaGgdOQfbWNtBGOc27_XQqCP7jD-A@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CABBYNZJ=5VH2+my7Gw1fMCaGgdOQfbWNtBGOc27_XQqCP7jD-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694714921;07dc0098;
X-HE-SMSGID: 1qgqla-0002SE-QL

On 14.09.23 19:51, Luiz Augusto von Dentz wrote:
> On Wed, Sep 13, 2023 at 10:13 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 12.09.23 21:09, Luiz Augusto von Dentz wrote:
>>> On Mon, Sep 11, 2023 at 6:40 AM Linux regression tracking (Thorsten
>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>> On 31.08.23 00:20, patchwork-bot+bluetooth@kernel.org wrote:
>>>>> This patch was applied to bluetooth/bluetooth-next.git (master)
>>>>> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>>>>> On Tue, 29 Aug 2023 13:59:36 -0700 you wrote:
>>>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>>>
>>>>>> When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning requires
>>>>>> periodic restarts of the scanning procedure as the controller would
>>>>>> consider device previously found as duplicated despite of RSSI changes,
>>>>>> but in order to set the scan timeout properly set le_scan_restart needs
>>>>>> to be synchronous so it shall not use hci_cmd_sync_queue which defers
>>>>>> the command processing to cmd_sync_work.
>>>>>> [...]
>>>>>
>>>>> Here is the summary with links:
>>>>>   - Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
>>>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/52bf4fd43f75
>>>>
>>>> That is (maybe among others?) a fix for a regression from 6.1, so why
>>>> was this merged into a "for-next" branch instead of a branch that
>>>> targets the current cycle?
> [...]
>> That answer doesn't answer the question afaics, as both 6.1 and 6.4 were
>> released in the past year -- the fix thus should not wait till the next
>> merge window, unless it's high risk or something. See this statement
>> from Linus:
>> https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/
> Thanks for the feedback, I will try to push fixes to net more often.

Great, many thx!

>>> but I could probably have it marked for stable just
>>> to make sure it would get backported to affected versions.
>> That would be great, too!
> Well now that it has already been merged via -next tree shall we still
> attempt to mark it as stable? Perhaps we need to check if it was not
> backported already based on the Fixes tag.

Changes only get backported once they hit mainline, which hasn't
happened yet. And to get them into the net branch (and from there to
mainline) a new commit is needed anyway, so you might as well add the
stable tag to it. Side note: And don't worry that identical commit is
already in -next, git handles that well afaik (but if you rebase
bluetooth-next for other reasons anyway you might as well remove it).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

