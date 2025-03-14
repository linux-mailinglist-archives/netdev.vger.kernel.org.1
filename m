Return-Path: <netdev+bounces-174908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74BBA61394
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DA8172573
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE34200B85;
	Fri, 14 Mar 2025 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HwPHzlyy"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C71FF5EB
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962248; cv=none; b=W1JLT6UO0egSt9wqMrYWUSTVO3ZVsmwurH4ArFFV5bbiBTw9rZMl/rz5fz9l/3vbTgu/MhkqTtNdmX3LZPtikVMaG4+d/HT2eMa/pRzaVRzxyQeYBn6vQN2FaB4PZNdAKBH9muQdBDn/ET3jxkRjIj9vNzANEEbKhwPCN7HUZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962248; c=relaxed/simple;
	bh=Q3DOOXjlvFMYAwi8u+snyG1oszeLSGTBs+sWEO6gRCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qguEIqz+xOjH9fFxLBosyMs9+L3q5w+3G1fTDcuzJ6qLLkRvHBcre+6PNpew66DWHOkAjTmnGUNffbYy7CROeMgmUC9XzxG6TgmJ8eOG8fbXIECr+3AZfDzxfGSuIpIxlt5QnMtcRr0pe/9DgbLy5ej4RmRsqRkqoQ2PRshRnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HwPHzlyy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=j5isqsMtW/hXHf2dr+3jztlypZT/U6d06OBizH7fLbs=; b=HwPHzlyy/aV0LyPbrbZt+cofo7
	KNtQvPjDxvhxTCyJrr4RYOCQncJPTtD+nm4JIEQvmWSG3OrMWlIHZEC12P5TJDHSVBWf+gMZtxXWu
	9MGb6NXiSK067+Ql4ux0NK2Y5lsBcfboCdjs2ZX/9HbzLE5bgIZMGt9jzE/J2BnD7fIcdt1+0Na5S
	CaiqRp6Gq63fcHYTNtQr2KX8DnBC3sXrHi9jXJspkmaQEsJxGWnsqKi5H5gxNQxwP7X7dRA3vc6TR
	SdefgAM2uSJOxWIS5LlebN9YQVPz/M0ZT37ia/je4q+lANTpkGClvLJfsry0dl1vcYbNFa8axmEgC
	BsP34hew==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt5xA-00000000rAS-1m5j;
	Fri, 14 Mar 2025 14:24:00 +0000
Date: Fri, 14 Mar 2025 14:23:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, pierre@stackhpc.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
Message-ID: <Z9Q7_wVfk-UXRYGl@casper.infradead.org>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <c2d160cd-b128-47ea-be0c-9775aa6ea0cc@stanley.mountain>
 <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122bc3a2-2150-4661-8d08-2082e0e7a9d7@intel.com>

On Fri, Mar 14, 2025 at 01:52:58PM +0100, Przemek Kitszel wrote:
> What about changing init flags instead, and add a new one for this
> purpose?, say:
> XA_FLAGS_ALLOC_RET0

No.  Dan's suggestion is better.  Actually, I'd go further and
make xa_alloc_cyclic() always do that.  People who want the wrapping
information get to call __xa_alloc_cyclic themselves.

