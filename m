Return-Path: <netdev+bounces-96484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558138C6208
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A771C20D10
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530C24654B;
	Wed, 15 May 2024 07:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxout37.expurgate.net (mxout37.expurgate.net [91.198.224.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32044C62E;
	Wed, 15 May 2024 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.224.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759315; cv=none; b=YKUxrsJV1i2UZwFHxjYthfETHIeEeqC0KhyeG4jmBV/FXoBfcsy1iSO52EsmpYfT3lO+0rVnJVRZ4SPJwwOo4vK7cswafueFGf6imORPvwxA6t1/JvKS74XycjG5sjNyBsvbwBYtZoI9cvPSWd29dhHC5wLBqp/YdPz4KH7OHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759315; c=relaxed/simple;
	bh=lk26N4jKRUWcHu1/UUXp3jyYWqZbSU2BqJ0uH7uywBA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pPpr7NBzYC9ZFIxzXxHglcppfhkbhF2jUqIfV7kMJTulm8RPKywGVW1pSOp9F2I4qk+eerzgez13RfVqx+UJIN1N6i8z0sYlBthgyGG2DuJ7okY6AzKiP3rC4DlWVIOxNsP3GVEDA3iT7h/QOdxWG9v/pso29f1ujfVHcnltp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de; spf=pass smtp.mailfrom=brueckmann-gmbh.de; arc=none smtp.client-ip=91.198.224.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brueckmann-gmbh.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brueckmann-gmbh.de
Received: from [127.0.0.1] (helo=localhost)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s79N3-00Baxp-9X; Wed, 15 May 2024 09:48:17 +0200
Received: from [217.239.223.202] (helo=zimbra.brueckmann-gmbh.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <gessler_t@brueckmann-gmbh.de>)
	id 1s79N1-00CyYM-W1; Wed, 15 May 2024 09:48:16 +0200
Received: from zimbra.brueckmann-gmbh.de (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPS id D66A2CAB439;
	Wed, 15 May 2024 09:48:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTP id C76B9CAB7F9;
	Wed, 15 May 2024 09:48:14 +0200 (CEST)
Received: from zimbra.brueckmann-gmbh.de ([127.0.0.1])
 by localhost (zimbra.brueckmann-gmbh.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Bfc9uI7PETd3; Wed, 15 May 2024 09:48:14 +0200 (CEST)
Received: from [10.0.11.14] (unknown [10.0.11.14])
	by zimbra.brueckmann-gmbh.de (Postfix) with ESMTPSA id A94F2CAB439;
	Wed, 15 May 2024 09:48:14 +0200 (CEST)
Date: Wed, 15 May 2024 09:47:19 +0200 (CEST)
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
Subject: Re: [PATCH 2/2] net: phy: dp83869: Fix RGMII-SGMII and 1000BASE-X
In-Reply-To: <16f79b3f-0b33-4196-858a-b1469ed1200b@lunn.ch>
Message-ID: <97128846-75d5-705a-5f-9bb9dc85f842@brueckmann-gmbh.de>
References: <20240514122728.1490156-1-thomas.gessler@brueckmann-gmbh.de> <20240514122728.1490156-2-thomas.gessler@brueckmann-gmbh.de> <16f79b3f-0b33-4196-858a-b1469ed1200b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1715759296-234C943F-80ECF54B/0/0

On Tue, 14 May 2024, Andrew Lunn wrote:
> Please go through all these defines and see what match to existing
> ones.

Will do.

I defined them to make explicit that they are the correct bits for
registers with non-standard offsets that exist in addition to the usual
BMCR, BMSR, etc. (which are used only for other PHY modes). But since the
bits are identical, I guess this rather leads to duplication.

Thomas

