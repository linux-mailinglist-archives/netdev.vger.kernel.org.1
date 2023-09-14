Return-Path: <netdev+bounces-33726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7079F9EE
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 07:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A495F28172A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 05:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16892250E9;
	Thu, 14 Sep 2023 05:13:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898C62C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 05:13:35 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39161AF;
	Wed, 13 Sep 2023 22:13:35 -0700 (PDT)
Received: from [2a02:8108:d00:dcc::d6ab]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qgefV-00052v-AW; Thu, 14 Sep 2023 07:13:33 +0200
Message-ID: <574ca8dd-ee97-4c8b-a154-51faf83cabdf@leemhuis.info>
Date: Thu, 14 Sep 2023 07:13:32 +0200
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
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: patchwork-bot+bluetooth@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, Stefan Agner <stefan@agner.ch>
References: <20230829205936.766544-1-luiz.dentz@gmail.com>
 <169343402479.21564.11565149320234658166.git-patchwork-notify@kernel.org>
 <de698d06-9784-43ed-9437-61d6edf9672b@leemhuis.info>
 <CABBYNZK2PPkLra8Au-fdN2nG2YLkfFRmPtEPQL0suLzBv=HHcA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CABBYNZK2PPkLra8Au-fdN2nG2YLkfFRmPtEPQL0suLzBv=HHcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694668415;5ef1b7ec;
X-HE-SMSGID: 1qgefV-00052v-AW

On 12.09.23 21:09, Luiz Augusto von Dentz wrote:
> On Mon, Sep 11, 2023 at 6:40 AM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>> On 31.08.23 00:20, patchwork-bot+bluetooth@kernel.org wrote:
>>> This patch was applied to bluetooth/bluetooth-next.git (master)
>>> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>>> On Tue, 29 Aug 2023 13:59:36 -0700 you wrote:
>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>> When HCI_QUIRK_STRICT_DUPLICATE_FILTER is set LE scanning requires
>>>> periodic restarts of the scanning procedure as the controller would
>>>> consider device previously found as duplicated despite of RSSI changes,
>>>> but in order to set the scan timeout properly set le_scan_restart needs
>>>> to be synchronous so it shall not use hci_cmd_sync_queue which defers
>>>> the command processing to cmd_sync_work.
>>>>
>>>> [...]
>>>
>>> Here is the summary with links:
>>>   - Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER
>>>     https://git.kernel.org/bluetooth/bluetooth-next/c/52bf4fd43f75
>>
>> That is (maybe among others?) a fix for a regression from 6.1, so why
>> was this merged into a "for-next" branch instead of a branch that
>> targets the current cycle?
> 
> We were late for including it to 6.5, that said the regression was
> introduced in 6.4,

6.4? From the fixes tag it sounded like it was 6.1. Whatever, doesn't
make a difference, because:

That answer doesn't answer the question afaics, as both 6.1 and 6.4 were
released in the past year -- the fix thus should not wait till the next
merge window, unless it's high risk or something. See this statement
from Linus:
https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/

> but I could probably have it marked for stable just
> to make sure it would get backported to affected versions.

That would be great, too!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

