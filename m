Return-Path: <netdev+bounces-51864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56F7FC809
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 22:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FB5B20BF4
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4C44C79;
	Tue, 28 Nov 2023 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4DCC
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 13:35:37 -0800 (PST)
Received: from [192.168.0.183] (ip5f5af0c0.dynamic.kabel-deutschland.de [95.90.240.192])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1790761E5FE01;
	Tue, 28 Nov 2023 22:34:54 +0100 (CET)
Message-ID: <695f07b2-cc49-4637-a783-38b0f7457c1b@molgen.mpg.de>
Date: Tue, 28 Nov 2023 22:34:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] The difference between linux kernel driver and
 FreeBSD's with Intel X533
To: =?UTF-8?Q?Skyler_M=C3=A4ntysaari?= <sm+lists@skym.fi>
References: <ee7f6320-0742-65d4-7411-400d55daebf8@skym.fi>
 <994cebfe-c97a-4e11-8dad-b3c589e9f094@intel.com>
 <c526d946-2779-434b-b8ec-423a48f71e36@skym.fi>
 <6e48c3ba-8d17-41db-ca8d-0a7881d122c9@intel.com>
 <4330a47e-aa31-4248-9d9d-95c54f74cdd9@app.fastmail.com>
 <10804893-d035-4ac9-86f0-161257922be7@app.fastmail.com>
 <03c9e8a4-5adc-4293-a720-fe4342ed723b@app.fastmail.com>
 <20231128021958.GA93203@dev-dsk-ipman-2a-ee5dfd20.us-west-2.amazon.com>
Content-Language: en-US
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, Jordan Crouse <jorcrous@amazon.com>,
 Jeff Daly <jeffd@silicom-usa.com>, regressions@lists.linux.dev
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231128021958.GA93203@dev-dsk-ipman-2a-ee5dfd20.us-west-2.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +<jeffd@silicom-usa.com>, +regressions@lists.linux.dev]

#regzbot ^introduced: 565736048bd5f9888990569993c6b6bfdf6dcb6d

Dear Ivan,


Am 28.11.23 um 03:20 schrieb Ivan Pang:
> On Wed, Oct 18, 2023 at 09:50:35PM +0300, Skyler Mäntysaari wrote:
>> On Tue, Oct 10, 2023, at 03:39, Skyler Mäntysaari wrote:
>>> On Tue, Oct 10, 2023, at 02:50, Skyler Mäntysaari wrote:
>>>> On Mon, Oct 9, 2023, at 18:33, Jesse Brandeburg wrote:
>>>>> On 10/4/2023 10:08 AM, Skyler Mäntysaari wrote:
>>>>>>>> Hi there,
>>>>>>>>
>>>>>>>> It seems that for reasons unknown to me, my Intel X533 based 10G SFP+
>>>>>>>> doesn't want to work with kernel 6.1.55 in VyOS 1.4 nor Debian 12 but
>>>>>>>> it does in OPNsense which is based on FreeBSD 13.2.
>>>>>>>>
>>>>>>>> How would I go about debugging this properly? Both sides see light,
>>>>>>>> but no link unless I'm using FreeBSD.
>>>>>> https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253/11?u=samip537

>>>>> Response from Intel team:
>>>>>
>>>>> In the ethtool -m output pasted I see TX and RX optical power is fine.
>>>>> Could you request fault status on both sides? Just want to check if link
>>>>> is down because we are at local-fault or link partner is at local-fault.
>>>>>
>>>>> rmmod ixgbe
>>>>> modprobe ixgbe
>>>>> ethtool -S eth0 | grep fault
>>>>>
>>>>> Since it is 10G, if our side TX is ON (power level says it is) then we
>>>>> should expect link partner RX to be locked so cannot be at Local Fault.
>>>>>
>>>>> Skyler, please gather that ethtool -S data for us.

>>>> As the other side of the link is an Juniper, I'm not quite sure how I
>>>> would gather the same data from it as it doesn't have ethtool?
>>>>
>>>> I have also somewhat given up hope on it working on VyOS and instead I
>>>> am using OPNsense for the moment but I still have VyOS installed as
>>>> well.

>>> I did verify that the grep doesn't yield any results on the VyOS box
>>> and all of the data returned has an value of 0. Paste of which is here:
>>> https://p.kapsi.fi/?4a82cedb4f4801ec#DcEgFMFK7cH13EqypsY4ZaHS5taeA1zXevmmTSVW3P9x
>>>
>>> I really think something weird is going on with the driver in Linux as
>>> otherwise the same exact config on Juniper wouldn't work there either.
>>> The VyOS box also says that it's unable to modify autoneg settings, or
>>> speed/duplex of the interface.

>> It has been  verified that the driver in kernel version 5.4.255
>> seems to work aka 1.3 VyOS.  Post from another user in the same
>> thread about it:
>> https://forum.vyos.io/t/10g-sfp-trouble-with-linking-intel-x553/12253/46
>> 
>> I have also verified that the out-of-tree ixgbe driver does work,
>> but in-kernel doesn't in kernel 6.1.58.
>> 
>> Please share these findings with the correct Intel team so that
>> this could be fixed.

> I came across this very similar issue when upgrading our networking gear
> from kernel 5.15 to 6.1. Our 10G link fails with the in-tree 6.1 ixgbe
> driver but works with the out-of-tree 5.x versions. I found that my link
> issues were related to this commit:
> 
> ixgbe: Manual AN-37 for troublesome link partners for X550 SFI
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.63&id=565736048bd5f9888990569993c6b6bfdf6dcb6d
> 
> Specifically, our 10G link works when both sides of the fiber are
> running the in-tree 6.1 ixgbe driver with this autonegotiation change.
> Our link also works when both sides are running the 5.x ixgbe drivers
> without this commit. It fails, however, when only one side has this
> commit. Our current setup compiles the in-tree 6.1 ixgbe driver with
> this commit reverted, for compatibility with our varying hardware.
> 
> I would appreciate it if anyone can cross-check my claim with their
> hardware as well. Also, would anyone be able to help explain what some
> of those registers and reg_val being written are doing?

Thank you for mentioning the culprit. That commit is present since 
v6.1-rc1. I am adding the regression folks.


Kind regards,

Paul

