Return-Path: <netdev+bounces-215620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB70DB2F958
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52253AE204
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8130E2F6566;
	Thu, 21 Aug 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlfMMSGp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C336CDE1
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781157; cv=none; b=Fn73UgR5lmQwBUID9p04U1Atwf1+I3qRr/gmtgPdsEEcmE4KCya3eqN0PzEYWZvCb0PU+ACRbM+GmhTAJLqeHXyvwTntxCnLdwjvUwGki7M1N0wNZRt1ExA0Q9U3vMJnSB92LXlpo7/SlG4wA+YgXteQv6ZFTyYkx0R+zvDpAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781157; c=relaxed/simple;
	bh=F2Bith6zFdgxqmvBsmu13gmysoJjnKwr9BPyILpjQyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3aAkqc3PguGSmZdyUMT3A24FWEflnzIP0DBuCw4IwZywb4bs38cdvRWjawAFAoxquuaj/XVunNul0qQP0i6nb5ppWauViCHJVTE50sbDO3QnqMYYPe87MhazM4qjaD6KxDa10b9NhViFFei9i43LxkPrbOTzAb4ogHBr0SfgKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlfMMSGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755781154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MQ3vPPYOTLjunRW6rE1DAH1TekWqqlSxWTf5OGZsdo=;
	b=AlfMMSGpJqVLTB2lAd/2Tf0bPBv06wEnmmCN1m0KmRfsgCcVx5PI+9MnYJ4dPIb6enCHTc
	r4BUto5OR+ttBdXeO2q6+ghYf5rNdby5Iy1gURC6ffH2SPiLzddmJWt8lVS8+ABYZkgy6E
	dtUn7AZhgSkb+s4VaT30ETxmeCfmSXo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-vkC7hbS4MquUfZc2ZtNobg-1; Thu,
 21 Aug 2025 08:59:10 -0400
X-MC-Unique: vkC7hbS4MquUfZc2ZtNobg-1
X-Mimecast-MFC-AGG-ID: vkC7hbS4MquUfZc2ZtNobg_1755781148
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7546E195608B;
	Thu, 21 Aug 2025 12:59:08 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B081180028F;
	Thu, 21 Aug 2025 12:59:04 +0000 (UTC)
Date: Thu, 21 Aug 2025 14:59:01 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
Message-ID: <aKcYFbzbbfPXlrlN@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
 <81c1a391-3193-41c6-8ab7-c50c58684a22@intel.com>
 <87ldncoqez.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldncoqez.fsf@jax.kurt.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Aug 21, 2025 at 01:38:44PM +0200, Kurt Kanzenbach wrote:
> On Wed Aug 20 2025, Jacob Keller wrote:
> > On 8/20/2025 12:56 AM, Miroslav Lichvar wrote:
> >> But when I increase the rate to 200000, I get this:
> >> 
> >> Without the patch:
> >> NTP daemon TX timestamps   : 35835
> >> NTP kernel TX timestamps   : 1410956
> >> NTP hardware TX timestamps : 581575            
> >> 
> >> With the patch:
> >> NTP daemon TX timestamps   : 476908
> >> NTP kernel TX timestamps   : 646146
> >> NTP hardware TX timestamps : 412095

> Miroslav, can you test the following patch? Does this help?

It seems better than with the original patch, but not as good as
before, at least in the tests I'm doing. The maximum packet rate the
server can handle is now only about 5% worse (instead of 40%), but the
the number of missing timestamps on the server still seems high.

With the new patch at 200000 requests per second:
NTP daemon TX timestamps   : 192404
NTP kernel TX timestamps   : 1318971
NTP hardware TX timestamps : 418805

I didn't try to adjust the aux worker priority.

-- 
Miroslav Lichvar


