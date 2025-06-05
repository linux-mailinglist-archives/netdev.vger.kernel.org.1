Return-Path: <netdev+bounces-195177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10949ACEB82
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 10:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CA7189B6CD
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A801F8BC6;
	Thu,  5 Jun 2025 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="jrbzXv5W"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F328E3F
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111112; cv=none; b=qWOQq0p3v6cTDGhDVND/jfyHgWEkY25jeSIJIiMneMU5O0eLMNaS2zLk4AxymR2opOFchzlMsNChCI87++Xg5PdPGOkp9lhHImNyKgBTp5PxRNhIe/laW0j7O4GMGeQkuODQc0ENWCj27YTrOg8/U0KdJoh6T6XGm+XGFnU9gAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111112; c=relaxed/simple;
	bh=78JCphuk+R7shgQkIWyGqGWkvV8zs+FchnZaPOgmOK4=;
	h=From:To:Cc:Subject:Date:References:Content-Type:Message-Id:
	 Mime-Version:In-Reply-To; b=szzhQua4JzOspD9F2FiQpJ8P6jEd2Gv6+prA5F+E3wxTnDc+c9RmzRBC0+uVzbYBYzv6bnT59K+oytnUGYNDYuqG4OQRMkmbvsUJDgSusOErh/Eufi+70ZeRJO1vx1Kg1qBcAmkEYYOp5XdMO/ryqejlY10ylzIkItCXnYOVobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=jrbzXv5W; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1749108324; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ktIb3tP/z00zCGnIqjIWhlS/dPRg7zKtsTdFprpwfeg=;
 b=jrbzXv5Ws2F7DxEcaL8jAPACDizyhVq3jhGfykYfjRsIdPY5fXEQ83KWiBjxlf+dHJs6vY
 vOSF1hyZQ5eWTMtJ2r+hAR6w1i+aHSBm3se0Yea28JL29kTPDbybYvk5ftJsVbr6F5QKu6
 IVh4n2ZturQPlaYZWZ51ukwNIbOuIuN9qkaxym/ofF4DxXU1uSsis/zRjTauECUNZFI5yU
 O6gvONKvfGjjQkJ1CX4KSS4Xg0JOA3BkVDX+L5I4k4Qyb6L8+eS+CDkOhof9hA4hzxgKpQ
 vubP5MtQoyhycrNRiMO9Z7gHJhpCoH4jU1l5Oh849cQ+6UQhQ/aYZZtmDhLhTQ==
From: "Xin Tian" <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+268414662+6ce35c+vger.kernel.org+tianx@yunsilicon.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v11 14/14] xsc: add ndo_get_stats64
Date: Thu, 5 Jun 2025 15:25:21 +0800
Received: from [127.0.0.1] ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 05 Jun 2025 15:25:21 +0800
References: <20250423103923.2513425-1-tianx@yunsilicon.com> <20250423104000.2513425-15-tianx@yunsilicon.com> <20250424184840.064657da@kernel.org>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Message-Id: <3fd3b7fc-b698-4cf3-9d43-4751bfb40646@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Original-From: Xin Tian <tianx@yunsilicon.com>
In-Reply-To: <20250424184840.064657da@kernel.org>

=E5=9C=A8 2025/4/25 9:48, Jakub Kicinski =E5=86=99=E9=81=93:
> On Wed, 23 Apr 2025 18:40:01 +0800 Xin Tian wrote:
>> @@ -242,11 +243,13 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff =
*skb,
>>   		mss       =3D skb_shinfo(skb)->gso_size;
>>   		ihs       =3D xsc_tx_get_gso_ihs(sq, skb);
>>   		num_bytes =3D skb->len;
>> +		stats->packets +=3D skb_shinfo(skb)->gso_segs;
>>   	} else {
>>   		opcode    =3D XSC_OPCODE_RAW;
>>   		mss       =3D 0;
>>   		ihs       =3D 0;
>>   		num_bytes =3D skb->len;
>> +		stats->packets++;
>>   	}
>>  =20
>>   	/*linear data in skb*/
>> @@ -284,10 +287,12 @@ static uint32_t xsc_eth_xmit_frame(struct sk_buff =
*skb,
>>  =20
>>   	xsc_txwqe_complete(sq, skb, opcode, ds_cnt, num_wqebbs, num_bytes,
>>   			   num_dma, wi);
>> +	stats->bytes     +=3D num_bytes;
> For TSO packets this doesn't look right. You should count the length
> after TSO, IOW the number of bytes that will reach the wire.
>
> Also you should use helpers from include/linux/u64_stats_sync.h
> to make sure there are no races when accessing the statistics

Hi, Jakub

Apologies for the delayed reply.

Regarding TSO packets:
Thanks for pointing that out. I will include the missing segment header=20
length.

Regarding u64_stats_sync.h helpers:
Since our driver =E2=80=8B=E2=80=8Bexclusively runs on 64-bit platforms=E2=
=80=8B=E2=80=8B (ARM64 or x86_64)
where u64 accesses are atomic, is it still necessary to use these helpers?

Thanks,
Xin

