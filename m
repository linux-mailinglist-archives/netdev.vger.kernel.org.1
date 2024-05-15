Return-Path: <netdev+bounces-96480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2991D8C61A3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92CA281361
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D558AA5;
	Wed, 15 May 2024 07:22:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [91.198.224.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325924AEDD;
	Wed, 15 May 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757769; cv=none; b=KKPlggd2MPhjbI8EiP3I5cFb9AHAhRVbwXxEBd4lLk+5iNwbfBujhs1yTPWVjjjLC8vOCAfIFuit5eaYy/DkSC2rkLStJk+whjdt8APBhdDGU7noH2Xo6yJTOfyjDDeRta+6FEJSecj2pmOb/yA8XomNgEGCne+sqS3K9M6xfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757769; c=relaxed/simple;
	bh=MMJTxIse0XMR2yy8WVH7zqEil4nlE4hSMxlj11n2foc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ks7yy1+t4FiW1UsiVNPLcFV1GrUKN5bhsSFEBaDs8ST7nNAzVtl0tN+eVDngCjoIJ7mxdgyslAJVBNxSh6JPCv/stUUGbnxZ4JMnTDHMNl5HKT/Uo334sJ/torq3pj8ZSyJze5+n0qRm5z0w2p8O8RRYBgdiBTDUtSkcHreOWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=91.198.224.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s78hU-0025li-Fc; Wed, 15 May 2024 09:05:20 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s78hT-00B0ZK-5Q; Wed, 15 May 2024 09:05:19 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id 0A0ECCA5DDD;
	Wed, 15 May 2024 09:05:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id EE310CA6122;
	Wed, 15 May 2024 09:05:17 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id j1AwKLY4gM0P; Wed, 15 May 2024 09:05:17 +0200 (CEST)
Received: from [10.0.11.14] (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id D325FCA5DDD;
	Wed, 15 May 2024 09:05:17 +0200 (CEST)
Date: Wed, 15 May 2024 09:04:27 +0200 (CEST)
From: =?ISO-8859-15?Q?Thomas_Ge=DFler?= <gessler_t@brueckmann-gmbh.de>
To: Andrew Lunn <andrew@lunn.ch>
cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>, 
    Heiner Kallweit <hkallweit1@gmail.com>, 
    Russell King <linux@armlinux.org.uk>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>, 
    Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: Re: [PATCH 1/2] net: phy: dp83869: Add PHY ID for chip revision 3
In-Reply-To: <b2db4e61-8bc1-4076-a2b9-7b6a028461aa@lunn.ch>
Message-ID: <54725d-4c84-2a25-54bf-5a56aa17edc5@brueckmann-gmbh.de>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de> <b2db4e61-8bc1-4076-a2b9-7b6a028461aa@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1715756719-A76F8356-60AE8429/0/0

Hi Andrew,

On Tue, 14 May 2024, Andrew Lunn wrote:
> As the name suggests, it matches on the model. The revision is
> ignored. A mask is applied to ignore the lower nibble. So this change
> looks pointless.

Ah, I see. I did not realize that the match ignores the lower bits. I was
having trouble getting the driver to match when first experimenting with
the chip and thought this was part of the problem. As it turns out, it now
works without this patch.

Please disregard it.

Thomas

