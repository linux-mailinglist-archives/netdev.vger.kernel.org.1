Return-Path: <netdev+bounces-203704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1262AF6CB1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07523189C833
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F62980D4;
	Thu,  3 Jul 2025 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DvLkrTuS"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAF295523
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530906; cv=none; b=IQoMp0d+wAvElAee7Qfy8C4PQr289LS3fby44ATu9o5Naikr2IvNBHrk9yDzFFY+GMffo0xYm19SSbDRCMe7oU5Hb9hQwp09jlKqEd8tMqkTb1i0uD24xNrcmS3PowkZ+/D+89x0IdP2clXYNMBsvhoPOPnxHfRscf6bdN350x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530906; c=relaxed/simple;
	bh=1bElIBmN3iWan0YgTkOqyuFnolYa2dAeCgYWt35hNSI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+AATLS3EaHN7KY/vmQTpA9lwY5RECa5v+2EZdgYJojqDZhI92xOHG2nNsjaJaOyGFWWzU9E4U3H/G7bEbXiHrpazkpCOP/VoWCibHWtFmlledJz64QgoVnyBkmAhJy5S4nAy/4CQWjnpbvkV8D59Nl1sKmrueVL3COhOfX1X0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DvLkrTuS; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 867A6206E9;
	Thu,  3 Jul 2025 10:21:42 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 57ac2kSAoTua; Thu,  3 Jul 2025 10:21:41 +0200 (CEST)
Received: from EXCH-04.secunet.de (unknown [10.32.0.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6FDFB2083F;
	Thu,  3 Jul 2025 10:21:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6FDFB2083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1751530901;
	bh=i4hAHz9U2+7f+66Cs+6Vql0PRVKCmFu8px+VW2s1rhQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=DvLkrTuSPHMGKitiIX7zB1LG5kHIeFqQ+0CN1clycWAU/fmy+dcCyLNXDUBhg4//R
	 N9A1yqnrjXHNMhFfPUhxZiUEAk81mdmJAmXnESPWkpjunYoD+JYKTK7OjRhQ2mvG6j
	 qZFIfMPBIf8Wb4bA2zX7EpGCAV3doezWu+lzS2qmYClVyAshnct2gROytLMqyNMjhH
	 V8oO77NSkG8GB58K9xhK/O/VX3S3IvHNO9lDTdzKIn32asYGbqmmYXCkkPtqtE/c8d
	 9XTciPPZy6fbMTwiegrsnrNmilQB3kocDFEw+ZUng563ez3JkqamQ+rWgZlTdGgX28
	 On6H3fKQrNH6w==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-04.secunet.de
 (10.32.0.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 3 Jul
 2025 10:21:40 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 10:21:40 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id E72E13184502; Thu,  3 Jul 2025 10:21:39 +0200 (CEST)
Date: Thu, 3 Jul 2025 10:21:39 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Fernando Fernandez Mancera <fmancera@suse.de>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec] xfrm: ipcomp: adjust transport header after
 decompressing
Message-ID: <aGY9k1EsH7tqRO9N@gauss3.secunet.de>
References: <20250624131115.59201-1-fmancera@suse.de>
 <aFtb6bNxShhfDuzi@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aFtb6bNxShhfDuzi@gondor.apana.org.au>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Wed, Jun 25, 2025 at 10:16:09AM +0800, Herbert Xu wrote:
> On Tue, Jun 24, 2025 at 03:11:15PM +0200, Fernando Fernandez Mancera wrote:
> > The skb transport header pointer needs to be adjusted by network header
> > pointer plus the size of the ipcomp header.
> > 
> > This shows up when running traffic over ipcomp using transport mode.
> > After being reinjected, packets are dropped because the header isn't
> > adjusted properly and some checks can be triggered. E.g the skb is
> > mistakenly considered as IP fragmented packet and later dropped.
> > 
> > kworker/30:1-mm     443 [030]   102.055250:     skb:kfree_skb:skbaddr=0xffff8f104aa3ce00 rx_sk=(
> >         ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
> >         ffffffff8419f1f4 sk_skb_reason_drop+0x94 ([kernel.kallsyms])
> >         ffffffff84281420 ip_defrag+0x4b0 ([kernel.kallsyms])
> >         ffffffff8428006e ip_local_deliver+0x4e ([kernel.kallsyms])
> >         ffffffff8432afb1 xfrm_trans_reinject+0xe1 ([kernel.kallsyms])
> >         ffffffff83758230 process_one_work+0x190 ([kernel.kallsyms])
> >         ffffffff83758f37 worker_thread+0x2d7 ([kernel.kallsyms])
> >         ffffffff83761cc9 kthread+0xf9 ([kernel.kallsyms])
> >         ffffffff836c3437 ret_from_fork+0x197 ([kernel.kallsyms])
> >         ffffffff836718da ret_from_fork_asm+0x1a ([kernel.kallsyms])
> > 
> > Fixes: eb2953d26971 ("xfrm: ipcomp: Use crypto_acomp interface")
> > Link: https://bugzilla.suse.com/1244532
> > Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > ---
> >  net/xfrm/xfrm_ipcomp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied, thanks everyone!

