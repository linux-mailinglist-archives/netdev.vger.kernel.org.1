Return-Path: <netdev+bounces-137091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC19A4591
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 20:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732571C208D4
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A412040BE;
	Fri, 18 Oct 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="n86KVqm/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60E155312;
	Fri, 18 Oct 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275165; cv=none; b=Js5wFWxhU8zQJcqAoTgkm9/H32CZXcNxjkzqKVHLQ8N7UbaFofAObfw2jK2h0wspim7l1nsBjvmHgU37O3DIXmHgnL3J7zSIdSLEmkob93wo7EeNPzFMnhYBl1yfl5F7s9NnTFWGf6+U8QwOwwdm++mLMa6t9JeQ92kXuIfhOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275165; c=relaxed/simple;
	bh=obeeQvlPH4miFY5uitMnrU/37erhDmQ+5Tq05PJiFpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwF6GTDMKkxFQ9nkBLrGCUw9Wi4f+N7nKO+GeGCytsFL0SCPQMptoF0EzhTh5Ut+gXybbUTsnr/J8R0rc43nXJn11nrCVlc+K9pOUvC1Vs4jrkDgkN3ZKWJQ7U4FlWfDumNdNkF5nWhc8BJfVEkNEG17PZkY2Rfbmpb2jqd/m04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=n86KVqm/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O9sWnJNzzK8cz6mWjiYLnap+djwdnuCdC0aTaZNVwVY=; b=n86KVqm/rAxMZMHPXdcML51M+H
	fj0bl/qbB/ta6DNYewTfa3Hg6Snbc15BhSxnbe1jlu8ZHYWz6ioRipq4RTKAewDm4h5wcA+/jGjwl
	3UoaCk77jrGo9zsEc940d7fWYWp1GHhkUvY7TkmDF0s5+QGkPaJ+ex3dhNUhWvs9xgjE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1rSs-00AYZJ-6o; Fri, 18 Oct 2024 20:12:42 +0200
Date: Fri, 18 Oct 2024 20:12:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	johan@kernel.org
Subject: Re: [PATCH 1/2] [net,v3] net: wwan: t7xx: add
 PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Message-ID: <f1cf17d9-b4b8-4519-82ea-c44bbd52c2c5@lunn.ch>
References: <20241018075304.23658-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018075304.23658-1-wojackbb@gmail.com>


    Andrew

---
pw-bot: cr

