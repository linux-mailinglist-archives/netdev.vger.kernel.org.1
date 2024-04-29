Return-Path: <netdev+bounces-92038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BE18B50DD
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 07:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774F41F2200C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 05:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0EDDF59;
	Mon, 29 Apr 2024 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Y//LCcHR"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19DCDDD8
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370316; cv=none; b=WC45/MIXOyOhjXev8A2peTVYPTA65/f6e7UQNUAfCS8u8lRswUjwC1AbVlcM/oiREMZ5Ub1FquK02sz8bSbmASQcttioFlXGITrmMWdu6tY89wbBgtaI6oiVNciOkfVwcDbZZ3tLPB7ZmHbLG1V9+f8yNDMK3bh7/eX/0g2HPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370316; c=relaxed/simple;
	bh=U/cPSXPeXfpIRb3yhnbx+YjCExHp88crLiw8GhYFabk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Os83NgKQ3ke+6HdySOnt6TSYdzq/lI+tic6X4hgQ+TXKSEbM1cL06Ncigi0DWVYiXmk1XfzlPBP/CU4EEMrLVQaZBoUPdMs8yrZLBsW06TV4nk9SWxWrK9y029kWbV3eh2DXSk7649edbfpI5ppGwvRDcObnuCtMzq67uoIw3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Y//LCcHR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 54DA7206DF;
	Mon, 29 Apr 2024 07:51:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ME9Mh2XuXT2b; Mon, 29 Apr 2024 07:51:05 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 18D62201CC;
	Mon, 29 Apr 2024 07:51:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 18D62201CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714369865;
	bh=ioJ7R0k4lpalT0wiDOkIhYPKYYHTb/N4WPwi94J6VUY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Y//LCcHRFwxz1R2wA0etT3DYXWMMCeZONv2RZ2K21/gAD+VsyP2fpoXNPoRi7cwBf
	 o3yWkWjxrcvvNzkG3SJV/qj0cWYxROrW0sfHJFAnvuT2GiuR9u/gx/AEnjs/QfkbtD
	 +5IqgbFh4uT3wNPdBuW5gP3S02lpH3zAsSnDHkXbpngnOHhq/pGZqi+pElt1vH/FS1
	 mT4kOjOjFKjra/xJds9eWqTkIcfhe9PkwC/CNCtdwU2Vh57wa63XrP9yMCv9Ykx1NH
	 UPnoDJHoCA8y3tr4Hcasff4IYVup5PZ1mlBQ6bz+lIeczGTYsKOM1OphgJceAM3Qqd
	 qAiy4A+WDErYw==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 0959B80004A;
	Mon, 29 Apr 2024 07:51:05 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Apr 2024 07:51:04 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Apr
 2024 07:51:04 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id B6E1731801BB; Mon, 29 Apr 2024 07:51:03 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:51:03 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Davey <paul.davey@alliedtelesis.co.nz>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: Preserve vlan tags for transport mode
 software GRO
Message-ID: <Zi81R0Zw0aEw5tSb@gauss3.secunet.de>
References: <20240423060100.2680602-1-paul.davey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240423060100.2680602-1-paul.davey@alliedtelesis.co.nz>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Apr 23, 2024 at 06:00:24PM +1200, Paul Davey wrote:
> The software GRO path for esp transport mode uses skb_mac_header_rebuild
> prior to re-injecting the packet via the xfrm_napi_dev.  This only
> copies skb->mac_len bytes of header which may not be sufficient if the
> packet contains 802.1Q tags or other VLAN tags.  Worse copying only the
> initial header will leave a packet marked as being VLAN tagged but
> without the corresponding tag leading to mangling when it is later
> untagged.
> 
> The VLAN tags are important when receiving the decrypted esp transport
> mode packet after GRO processing to ensure it is received on the correct
> interface.
> 
> Therefore record the full mac header length in xfrm*_transport_input for
> later use in corresponding xfrm*_transport_finish to copy the entire mac
> header when rebuilding the mac header for GRO.  The skb->data pointer is
> left pointing skb->mac_header bytes after the start of the mac header as
> is expected by the network stack and network and transport header
> offsets reset to this location.
> 
> Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>

Applied, thanks a lot!

