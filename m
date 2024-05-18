Return-Path: <netdev+bounces-97062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CAC8C900C
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5C961C20E7F
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4679101DE;
	Sat, 18 May 2024 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YBTt22nx"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B81101C5;
	Sat, 18 May 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716022163; cv=none; b=Kaey154bstIZdWbrSgRXtiPSGcevoEABnv2m+i+ut1T/XgxbQU6sB0+4TxthewSES8HxHQypoYXew6MgbJ2J0oYm8CI090wRxx2aF01itcGh6yNStyXfhJ0m6IC4niwWynvGLM/pkMp6k3ctCsSKYoozPiL7TQifjhOsf5Xjgxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716022163; c=relaxed/simple;
	bh=IjIvSDsBIS7GEwEEgejfx1W7LzjfEQqGgg6tgJLkiEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fR0b0/6BK9B5E4MdHiNGS8AgVErOxsTueVIGRIcKOBM9PksxS/8hth7DQpo40+a6DMVBHJhJBEDFo8Dzcf7/pdj8NlvLfBvu94tGc6nwPzExiw//L4sU4NUuCwhBN6tw4Mkr7TcG3Tq6Z31mh0UHe/ZA62hwtfFJd2cLnKEZrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YBTt22nx; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44I8n2f0019546;
	Sat, 18 May 2024 03:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716022143;
	bh=RiVGj+qep057xak5y+IC3HmFOlnTGitw34djuHIjJkk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YBTt22nxQfVts6M0idawB4no+WP/s9q00yanaiL4pC3OvPLuhWsacn8X+8gbJDjtT
	 Y99d3QfK7VG35zsqCr5wTpfOCiJXc1UNVPvb0fCRWx98/cTj0Ka7WNUpC7ZZjmiPdg
	 DLt66Hf7QFjgW7/Bfhcck575caGLHTnw+1RfRYX0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44I8n2km054452
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 03:49:02 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 03:49:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 03:49:02 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44I8muuj129612;
	Sat, 18 May 2024 03:48:57 -0500
Message-ID: <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
Date: Sat, 18 May 2024 14:18:55 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
To: Conor Dooley <conor@kernel.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kip Broadhurst <kbroadhurst@ti.com>,
        <w.egorov@phytec.de>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
 <20240517-fastball-stable-9332cae850ea@spud>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240517-fastball-stable-9332cae850ea@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Conor

On 5/17/2024 8:11 PM, Conor Dooley wrote:
> On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
>> On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
>>> Modify license to include dual licensing as GPL-2.0-only OR MIT
>>> license for TI specific phy header files. This allows for Linux
>>> kernel files to be used in other Operating System ecosystems
>>> such as Zephyr or FreeBSD.
>> What's wrong with BSD-2-Clause, why not use that?
> I cut myself off, I meant to say:
> What's wrong with BSD-2-Clause, the standard dual license for
> bindings, why not use that?

want to be inline with License of top level DTS, which is including this 
header file

eg

https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/ti/k3-j722s-evm.dts#L1 



