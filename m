Return-Path: <netdev+bounces-97613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3A38CC5B7
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A811C20909
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692F1422DC;
	Wed, 22 May 2024 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lbnWxyF2"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B457D071;
	Wed, 22 May 2024 17:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399610; cv=none; b=aqTtbg2KZVPE8Uueg0fuOyahzddNqMpKtglre52/mpRxViO9QufZKkH0BAPchzQsIMfqWhVGg5dhaHY4EsL6v2puDrzN7crJMQBOwtogcYHl89xmlXOJKk3qlOWRIJ1mbvrjnagoC6l474d8Xl4aWYkiHsgku1HDf/BmceO2/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399610; c=relaxed/simple;
	bh=rvyON9Eez4+bgszygh1Bb1QcvHtLRDv9uBENZwvOqgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HvuITG6YRcU1FX9yt3/PCgs1pnJwCTFalA9vy9unmW2pvjPU017MJPiWb3+fG6qWIlhiqQoRYbMuTZfqHbLDTSfPxIdx61NswSMpfAvt/V6zx1kdv9Em/bRhajoHmfECDLnlfKePb8W3mD6yiKgbNO5U2dYwk2naenum8xyLxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lbnWxyF2; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MHdgZ2058268;
	Wed, 22 May 2024 12:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716399583;
	bh=96umGE7Q8x9vdEdBBDF/Aa24QRAMgPy3dYLj6BJie8k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lbnWxyF2XCnoOX2VMR21xaTV+WQlRqXc/+PCmgxkXrFUkHlyUtAJfF5OrLaPD67J5
	 h4u5U7qoxy7u9LjpgIUxZtzcTN7ZR19a1eHDhfv3e7HpnWER/dJDV0ahkhykCG26CQ
	 rvtKjnvwJGPpfelmmrHdOBvyrC94axaVqDm/HUxw=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MHdgTM024507
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 12:39:42 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 12:39:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 12:39:42 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MHdaJM018757;
	Wed, 22 May 2024 12:39:37 -0500
Message-ID: <c2fe8d96-677a-4779-b46b-1c50698ef6a0@ti.com>
Date: Wed, 22 May 2024 23:09:36 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
To: Nishanth Menon <nm@ti.com>, Conor Dooley <conor@kernel.org>,
        Rob Herring
	<robh@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn
	<andrew@lunn.ch>
CC: <vigneshr@ti.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kip Broadhurst <kbroadhurst@ti.com>,
        <w.egorov@phytec.de>, <u-kumar1@ti.com>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
 <20240517-fastball-stable-9332cae850ea@spud>
 <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
 <20240520-discard-fanatic-f8e686a4faad@spud>
 <20240520201807.GA1410789-robh@kernel.org>
 <e257de5f54d361da692820f72048ed06a8673380.camel@redhat.com>
 <20240522-vanquish-twirl-4f767578ee8d@spud>
 <20240522134001.tjgvzglufwmi3k75@imitate>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240522134001.tjgvzglufwmi3k75@imitate>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks all for review

On 5/22/2024 7:10 PM, Nishanth Menon wrote:
> On 11:25-20240522, Conor Dooley wrote:
>> On Wed, May 22, 2024 at 10:04:39AM +0200, Paolo Abeni wrote:
>>> On Mon, 2024-05-20 at 15:18 -0500, Rob Herring wrote:
>>>> On Mon, May 20, 2024 at 06:17:52PM +0100, Conor Dooley wrote:
>>>>> On Sat, May 18, 2024 at 02:18:55PM +0530, Kumar, Udit wrote:
>>>>>> Hi Conor
>>>>>>
>>>>>> On 5/17/2024 8:11 PM, Conor Dooley wrote:
>>>>>>> On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
>>>>>>>> On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
>>>>>>>>> Modify license to include dual licensing as GPL-2.0-only OR MIT
>>>>>>>>> license for TI specific phy header files. This allows for Linux
>>>>>>>>> kernel files to be used in other Operating System ecosystems
>>>>>>>>> such as Zephyr or FreeBSD.
>>>>>>>> What's wrong with BSD-2-Clause, why not use that?
>>>>>>> I cut myself off, I meant to say:
>>>>>>> What's wrong with BSD-2-Clause, the standard dual license for
>>>>>>> bindings, why not use that?
>>>>>> want to be inline with License of top level DTS, which is including this
>>>>>> header file
>>>>> Unless there's a specific reason to use MIT (like your legal won't even
>>>>> allow you to use BSD-2-Clause) then please just use the normal license
>>>>> for bindings here.
>>>> Aligning with the DTS files is enough reason for me as that's where
>>>> these files are used. If you need to pick a permissive license for both,
>>>> then yes, use BSD-2-Clause. Better yet, ask your lawyer.
>>> Conor would you agree with Rob? - my take is that he is ok with this
>>> patch.
>> I don't think whether or not I agree matters, Rob said it's fine so it's
>> fine.
> Just to close the loop here: Udit pointed me to this thread and having
> gone through this already[1] with internal TI teams, the feedback we
> have gotten from our licensing team (including legal) is to go with
> GPL2 or MIT. BSD (2 and 3 clauses) were considered, but due to varied
> reasons, dropped.
>
> That said, Udit, since you are touching this, please update in the next
> revision:
> Copyright:   (C) 2015-2024 Texas Instruments, Inc.
>   to
> Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/


will post v2 with these changes after merge window is open.

Along with that in v2 will copy other contributors as well, who are 
including these files.


> [1] https://serenity.dal.design.ti.com/lore/linux-patch-review/20240109231804.3879513-1-nm@ti.com/
>

