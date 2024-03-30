Return-Path: <netdev+bounces-83595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD238932B0
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDEF8B20FF0
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00577145FE4;
	Sun, 31 Mar 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WAQ3uGBN"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55440145B37
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902319; cv=pass; b=FBiuHIEBNK05fn/ifGubtcQSW7sau/5BO/cXaVGOAT7R+0KU7W56nKTkNNeqnboYtrejzaQFiWjcMK9OvzMweDNxQJo+qmEsHG/aW9NIsNK+rkpBOZ3IFWU3VOFUWcH8WIpJodvoGJrCDt5VCHHBzXTyFIZyxN+Aoo28pcTvb8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902319; c=relaxed/simple;
	bh=htnwxaRYLoNkryWLJaBVSFOfS9tn6Oh5EBSghNzeRHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxAq3evw4IaX46/QbGFidG7O6nYfBc5UEidU0fxgsI4HfqzHWhZAe/5Vv6rBcH/eNjSnfCJ5nNSGwUg71qxuwB3hGzJ7mSaWYk7+VXHPn8EniN2iBjp1yhrF7PeiqWN62UCvAP0o+DJ6kaxfNUOdMRqPn+ORFRgQKLGBl4iU8ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=fail smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WAQ3uGBN; arc=none smtp.client-ip=156.67.10.101; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=lunn.ch
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DD7C12083B;
	Sun, 31 Mar 2024 18:25:15 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cDdg-8pz7M1V; Sun, 31 Mar 2024 18:25:15 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9391C207C6;
	Sun, 31 Mar 2024 18:25:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 9391C207C6
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 868BF80004E;
	Sun, 31 Mar 2024 18:25:14 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:25:14 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:55 +0000
X-sender: <netdev+bounces-83535-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAkKRAQuxQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAkAAAApIoAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12060
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83535-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 9123E2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WAQ3uGBN"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711836856; cv=none; b=ET1Z3thUny7dCCkpC8lbUebGMy5Plrtw6hvPlf/UJkksxBeLbmw1ghzEaCGB4mURAd074f3qtBzUYMarYvRF614ab6MmcXulApsm2/AWHxcSS4meNk4xemu+sLA9LGeMAe5fjb5xaN1coMfmUABfnU7im3jdIJCj5hwISMynSTc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711836856; c=relaxed/simple;
	bh=htnwxaRYLoNkryWLJaBVSFOfS9tn6Oh5EBSghNzeRHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2reOn0VT70EDOh7dna04qpxZe84BLB7BiD9y/VeQ6ly9aFwPhVqy1eWaKESospD71beZBL20aEdIGypfjBPmMd5m04+WfJtonrC+U0P6N7eG8FeuxbCnVBE+GEUIlHWjCKZxDJEUKQTsJzVHLIsEGpD4f9dPMvsSvg7l/ZEbCs=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WAQ3uGBN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E3M9C94KlYgWkxVnJ7peUnv4RFU6IKeHU/i44aG+ovM=; b=WAQ3uGBNwM5q1A2jNEp8fqa4y4
	JAPFdkTelMrUfMAR1POls1sGXQYtQhs18rv/qsFXdzweD1Q+mSVouU8wxfgek9U/hyINTk4SSk4Kx
	yGhGJ2J93d1KR7+sE78wwu9AikmLOwitEiZB3TRceJ7vybO9GqK7qDxwvkkMuc+q6+TM=;
Date: Sat, 30 Mar 2024 23:14:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	simon.horman@corigine.com, anthony.l.nguyen@intel.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	idosch@nvidia.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 2/3] ethtool: Introduce max power support
Message-ID: <07572365-1c9f-4948-ad2f-4d56c6d4e4ab@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <20240329092321.16843-3-wojciech.drewek@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329092321.16843-3-wojciech.drewek@intel.com>
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 10:23:20AM +0100, Wojciech Drewek wrote:
> Some modules use nonstandard power levels. Adjust ethtool
> module implementation to support new attributes that will allow user
> to change maximum power.
> 
> Add three new get attributes:
> ETHTOOL_A_MODULE_MAX_POWER_SET (used for set as well) - currently set
>   maximum power in the cage
> ETHTOOL_A_MODULE_MIN_POWER_ALLOWED - minimum power allowed in the
>   cage reported by device
> ETHTOOL_A_MODULE_MAX_POWER_ALLOWED - maximum power allowed in the
>   cage reported by device

I'm confused. The cage has two power pins, if you look at the table
here:

https://www.embrionix.com/resource/how-to-design-with-video-SFP

There is VccT and VccR. I would expect there is a power regulator
supplying these pins. By default, you can draw 1W from that
regulator. The board however might be designed to support more power,
so those regulators could supply more power. And the board has also
been designed to dump the heat if more power is consumed.

So, ETHTOOL_A_MODULE_MIN_POWER_ALLOWED is about the minimum power that
regulator can supply? Does that make any sense?

ETHTOOL_A_MODULE_MAX_POWER_ALLOWED is about the maximum power the
regulator can supply and the cooling system can dump heat?

Then what does ETHTOOL_A_MODULE_MAX_POWER_SET mean? power in the cage?
The cage is passive. It does not consume power. It is the module which
does. Is this telling the module it can consume up to this amount of
power?

	Andrew


