Return-Path: <netdev+bounces-83654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F989343B
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBA01F23BDD
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58488145B36;
	Sun, 31 Mar 2024 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PBZbgQcq"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCE145B34
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903323; cv=pass; b=TtsIOe81VFcruGxAMZxl+L+kDNIVSVVJsWdaxkVPoGdsPYJ8te97A9tIlpsG9VgHUValGuM8u0hLCzpvey0nWPSVjbzxNMJ4vEj2W4g4JEAD6Wq+M+Fxf7KW9CR4I9i9G1rf0N1qUVDHOnj1uspu7KeTymzhw5nRd4xzr7QMFM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903323; c=relaxed/simple;
	bh=p8JMrR3aXxDyceVxKGrjVePzewVWjN37i/MfiACxrRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFmkGFi/5jZoC4EIMK8V65g7wZ5VKvSmS14NotUhOcUkJHOvYAQ3EFa5K1Ol2+ZMsjEn65gI29NvtBvApMtsFsOyN4o9MYDHM9f+I6eFnOmdaFQQHbobasX9CoNTjoz51h+qXzQTLGuRrPm5Sg6cdAlW00T80vwdSfmnx1sZ/Fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=fail smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PBZbgQcq; arc=none smtp.client-ip=156.67.10.101; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=lunn.ch
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 14485207D1;
	Sun, 31 Mar 2024 18:42:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CF7fSzuql0Z6; Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8857320897;
	Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8857320897
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 7B47B80005E;
	Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:05 +0000
X-sender: <netdev+bounces-83534-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAFmUFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8644
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83534-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4D9CC20820
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711835831; cv=none; b=o3bmGg6pkxuKNLm23H/EqQl645mc3BI/3oNOnCmXXZeDTufy4S/7XoTQckaCTsQgQPfJ1oCkaO6nIW3MXaFEVFyHktLJfRbH2yk609gThZggBQh+G6ND84LMgOQYRvJsHTSzLdM/7WchqsReFhlSICSnm9tENjPKVSVZFcZUWmI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711835831; c=relaxed/simple;
	bh=p8JMrR3aXxDyceVxKGrjVePzewVWjN37i/MfiACxrRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccWt3HBLvS2OtGm3Ycn21Leg/8+JZXm2Z9Ar33psizw6Ywv3BgORO6Ckh90tqq6sWTFhv2V/gQpr631zW6reHM8kdXGh044T2C270gIj2TzxdFBYQ+TjGsrSta6WOIIbwiRgt+z9HVlYHX4ep4OLtsd+CphA2ThRAj3Ga1w3Cdc=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PBZbgQcq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IZ0VCe3iNf6wEVXOTCw6lmBDLZ7NjriGD/YDnR3wMN4=; b=PBZbgQcqz+Z/9+/z5NNgXvLHao
	y+Z95swHz8k9SInML7Cx6typz+jPac5PQ8x2QOVjZiHrhxDhb6tkgljD806DlPmYqcV54edGZmbCl
	y8BmaRaIJM2yB2pDVuq/vtwhzgL16ybpZWuM+0dzv0/X9Nml7k+SAMK9FfVrBl/aRKLQ=;
Date: Sat, 30 Mar 2024 22:57:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	simon.horman@corigine.com, anthony.l.nguyen@intel.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	idosch@nvidia.com, przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329092321.16843-1-wojciech.drewek@intel.com>
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 10:23:18AM +0100, Wojciech Drewek wrote:
> Some ethernet modules use nonstandard power levels [1]. Extend ethtool
> module implementation to support new attributes that will allow user
> to change maximum power. Rename structures and functions to be more
> generic. Introduce an example of the new API in ice driver.
> 
> Ethtool examples:
> $ ethtool --show-module enp1s0f0np0
> Module parameters for enp1s0f0np0:
> power-min-allowed: 1000 mW
> power-max-allowed: 3000 mW
> power-max-set: 1500 mW
> 
> $ ethtool --set-module enp1s0f0np0 power-max-set 4000

We have had a device tree property for a long time:

  maximum-power-milliwatt:
    minimum: 1000
    default: 1000
    description:
      Maximum module power consumption Specifies the maximum power consumption
      allowable by a module in the slot, in milli-Watts. Presently, modules can
      be up to 1W, 1.5W or 2W.

Could you flip the name around to be consistent with DT?

> minimum-power-allowed: 1000 mW
> maximum-power-allowed: 3000 mW
> maximum-power-set: 1500 mW

Also, what does minimum-power-allowed actually tell us? Do you imagine
it will ever be below 1W because of bad board design? Do you have a
bad board design which does not allow 1W?

Also, this is about the board, the SFP cage, not the actual SFP
module?  Maybe the word cage needs to be in these names?

Do we want to be able to enumerate what the module itself supports?
If so, we need to include module in the name, to identify the numbers
are about the module, not the cage.

    Andrew


