Return-Path: <netdev+bounces-83604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A198932DD
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6341C21E33
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0C1487D5;
	Sun, 31 Mar 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0pT12sl"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04D148313
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902389; cv=fail; b=Nabz5CObdSbX+pti/Qr7CzoyXFGcq1be2c0Ef+nOf73xkrGXAN/ggMv0aTI911HcojkAsM3ZBD2xwm3sIsEIMi9Jadn13hsS5xh+ysmA+3PhlOwSDs/KwNqIM1dCItldTzNapaXK+edEBqU/fC3ZAsp1Mlqb7SjYNc9R/Uw6wEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902389; c=relaxed/simple;
	bh=433Lz/Y3OL0GQmpw2bh29J8eaSo3lDFYM4WPs7r2AHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAYiGrmWxOAMDQMO3VBj8/hCSnHZ8/GCuAl/7jeT7y1uUvaeqnY78po4m06JwguKvQo+MMjrLSw7HesaguynwA/VNBxnMyPQ8DX2Am3bO19oxtnDY0jMIU+MYo41MHbDo0bQ3Fuxe1uOPsu5kcyvKyX/9KmYICO6h7l1zGHd/XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0pT12sl; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3CF2E208B5;
	Sun, 31 Mar 2024 18:26:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hSYTSPy6OfO0; Sun, 31 Mar 2024 18:26:24 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BC10C2084C;
	Sun, 31 Mar 2024 18:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BC10C2084C
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id AFBDB80004A;
	Sun, 31 Mar 2024 18:26:24 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:34 +0000
X-sender: <netdev+bounces-83476-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoACJPp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAwAAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 9596
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83476-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7A8BE20883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750565; cv=none; b=pbCPTsLcVWyGAGY1F+FGFHESEMB7jZkSNc4VY5Jj4bsM/MvDfdgXv1TToeeZrfDTUIXW6qXwoXC3JFktv1qRvZmGPVXhJAnrpUB+pSkLLNgflhRLkU0oKJgtHJQqPNQLjsJ3CLEMEbDMRkfkivs0GqreaS5/Jl7q/EnKMuY0Bh4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750565; c=relaxed/simple;
	bh=433Lz/Y3OL0GQmpw2bh29J8eaSo3lDFYM4WPs7r2AHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+9IJzHKm45lSQzI5sQDQ3ESRohOGHktP1IoC3/2MZDYbG7/ZnGA54+NjzaZkVyj+92VdfZJAmsa7lCe6zNXXtqPIbBvVgZrJctatYhNc3yh8wwJB9RRLEf+BbB3t3MdLRjAw85MkkO2wZCEFFzZao2jz+HoVuA6ZfMJjyi6Z/g=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0pT12sl; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750565;
	bh=433Lz/Y3OL0GQmpw2bh29J8eaSo3lDFYM4WPs7r2AHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0pT12slbEikvN3kyB87rQiIImPF/oVqRQPnogyTOrpr92SJK1j9FSQj+w3/pZCP4
	 U845PaNqG0eXU58dSpySkBqyCipND6psVqJ7ahMozKcWyxSBkQdsAtZ7CmaFNJNe77
	 1zkVSVRPsJefmfh8p3m6sh82nMCRWL5CSE6D14GTW4jXGAJNk7NdueVoe1fSBG/tyi
	 vPinNQ+7/uKgJMHUupYlPB+JgU1DurTsHYatBO2gTKECco1hfuiw2s1GlARyYRNqYQ
	 voMTXmfnHpyQYB35iN+lTQJVKLNcebxHadiEe4oDDZBvtVIPR+5oGton2vpLWhoMhD
	 mHMppPCV34aUw==
Date: Fri, 29 Mar 2024 15:16:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 simon.horman@corigine.com, anthony.l.nguyen@intel.com, edumazet@google.com,
 pabeni@redhat.com, idosch@nvidia.com, przemyslaw.kitszel@intel.com,
 marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <20240329151603.77981289@kernel.org>
In-Reply-To: <20240329092321.16843-1-wojciech.drewek@intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 10:23:18 +0100 Wojciech Drewek wrote:
> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
> module implementation to support new attributes that will allow user
> to change maximum power. Rename structures and functions to be more
> generic. Introduce an example of the new API in ice driver.

I'm no SFP expert but seems reasonable.

Would be good to insert more references to the SFP / CMIS specs
which describe the standard registers.

Also the series is suffering from lack of docs and spec, please
update both:

  Documentation/networking/ethtool-netlink.rst
  Documentation/netlink/specs/ethtool.yaml


