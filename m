Return-Path: <netdev+bounces-193430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9384AC3F33
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55E87AC2D4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E71F8730;
	Mon, 26 May 2025 12:17:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF53D994
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748261855; cv=none; b=Pp7uuOAekoo0MgdDp8y7nxP748+WGZYUDccQk2ljwe6kgxR8A+pJsMApwyjM3Z3tkoaEqxkxJa6W1LxK6tc2wdMiSaJjDGsLnkdYyKfYbDP9gSWaK6vtXvzTbS5St3C+ITZutKyCS3g3BLAz0jIABGRwSRPqao95viERjE9TCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748261855; c=relaxed/simple;
	bh=30EB8PWkuAbuXmOhQ74yumddi+TkKxXHSGLRWq5H678=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa0A4K7jQ+dmZKjnhKukjNXNiSQZ+4VT8kuryYD5LcgU10Y6ZdIi+1CGV7ncWGE+1W+j2PGSd5hrwHijuXkCirI3IXnbT0yjukfHVsZ+isLAfm3Y/WQjT+Kht9RzIgEcWRsMtim2AIEr2BVsDaOt/p51YjRaQK8RuQCsBa5SGQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CA46620754;
	Mon, 26 May 2025 14:17:30 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t1J7zaCIcGUo; Mon, 26 May 2025 14:17:30 +0200 (CEST)
Received: from EXCH-04.secunet.de (unknown [10.32.0.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 45488204D9;
	Mon, 26 May 2025 14:17:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 45488204D9
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-04.secunet.de
 (10.32.0.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 26 May
 2025 14:17:29 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 14:17:29 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id DDBF53182B4C; Mon, 26 May 2025 14:17:28 +0200 (CEST)
Date: Mon, 26 May 2025 14:17:28 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>, "Antony
 Antony" <antony.antony@secunet.com>, Tobias Brunner <tobias@strongswan.org>
Subject: Re: [PATCH ipsec 2/2] xfrm: state: use a consistent pcpu_id in
 xfrm_state_find
Message-ID: <aDRb2MLYjHb4GbaO@gauss3.secunet.de>
References: <cover.1748001837.git.sd@queasysnail.net>
 <6d0dd032450372755c629a68e6999c3b317c0188.1748001837.git.sd@queasysnail.net>
 <aDQJ+kt5c0trlfo5@gauss3.secunet.de>
 <aDRzMLL1vMXOIgHf@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aDRzMLL1vMXOIgHf@strlen.de>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Mon, May 26, 2025 at 03:57:04PM +0200, Florian Westphal wrote:
> Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > > -	pcpu_id = get_cpu();
> > > -	put_cpu();
> > > +	pcpu_id = raw_smp_processor_id();
> > 
> > This codepath can be taken from the forwarding path with preemtion
> > disabled. raw_smp_processor_id will trigger a warning in that case,
> 
> Are you sure? smp_processor_id() emits a warning when called from
> preemptible context, raw_smp_processor_id() should not do that.
> 
> We use raw_smp_processor_id from various netfilter modules as well
> and I never saw preemption warnings.

You are right, I just saw smp_processor_id. Sorry for the noise!

