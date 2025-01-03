Return-Path: <netdev+bounces-155038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C9A00C05
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BE618828EF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A32B1FAC23;
	Fri,  3 Jan 2025 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nNfH4Lh4"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8CF1F9EA4;
	Fri,  3 Jan 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735921521; cv=none; b=lILrYjjm2wVMeIq7g29fLXICiFPG2z1vbPfdz6AG3Vs7G+fT/EaQSxPOizvAjjQOamAt9R4Sff5eaCLVcsS5BzqyJnSnQn0JWNTXuUzbRVqjGJAkKakef/9EtNH1zk/MSHLzRGQ6+vu/y8fDohrUG/Y0HbCBRzO9cxa/331cIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735921521; c=relaxed/simple;
	bh=sBdH//KuCPagBTrv+itcpCBNhY6HCWRqK2hHTlHWIQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkDYLaaXEryfdUodOK+7Lfy5MUY6AEcS0AT42JTS/ixSp4999udgj4roMGFc9QALAA1zgaTSUw1jvA4dVDnpXWKPUcv+BYJTv4ovHiv2qg/37gOuXj13plrhD5NUYT+benZOtndVaJ8K1QWe4yd9lC+oMActggmMsDO3evloCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nNfH4Lh4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=unC2Fhn6EJ32Xsi2ODneZGcaNI6Y5JHf0QRbi/IbyPo=; b=nNfH4Lh4tOUqX+xZn1XjPeQHHF
	gFsOfzz8PlpDhe8RzH1in7ekPJfClWgJcCj52YWEv/WO6PNBF7tbqOBmftkQ3r4ECsjthmIsNsklL
	zb6MUEM8BF/DDwVkrTm1p7+QGspl2CRgzr414HmCNtSgZz6N3yjl/UgwZW6UvdIfmMvo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTkU4-0015M9-KI; Fri, 03 Jan 2025 17:25:12 +0100
Date: Fri, 3 Jan 2025 17:25:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next 05/13] net: enetc: add debugfs interface to dump
 MAC filter
Message-ID: <696fb436-40f6-4a9c-af0b-2851f8450bd1@lunn.ch>
References: <20250103060610.2233908-1-wei.fang@nxp.com>
 <20250103060610.2233908-6-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103060610.2233908-6-wei.fang@nxp.com>

On Fri, Jan 03, 2025 at 02:06:01PM +0800, Wei Fang wrote:
> ENETC's MAC filter consists of hash MAC filter and exact MAC filter. Hash
> MAC filter is a 64-entry hash table consisting of two 32-bit registers.
> Exact MAC filter is implemented by configuring MAC address filter table
> through command BD ring. The table is stored in ENETC's internal memory
> and needs to be read through command BD ring. In order to facilitate
> debugging, added a debugfs interface to get the relevant information
> about MAC filter.

How do other drivers do this?

You should only use debugfs if there is no standard way to accomplish
something. And if there is no standard way, you should be thinking is
this a common feature other drivers will need, and if so, add a
standard mechanism.

You will get pushback for using debugfs as a bumping ground without
adding some justification that debugfs is the only possible solution.

	 Andrew

