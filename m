Return-Path: <netdev+bounces-225508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80632B94E63
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021F07B1685
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974292F2910;
	Tue, 23 Sep 2025 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9lErGtJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E974B2DEA79
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614533; cv=none; b=i7SbO2dUOU2nYxRpshHaZxcn1mr1WOM14CwIFZWqFLXWFWgvR4j5Asf6H341KRVF6W9MZ1HfZ/oFgu/J3hPuySkUBFeDP5SXaG+kDTBmMcgB81DbVvELk46UBw5DNsrj/PDUHNgLnlWlxLO7zgwct1nWceUWXT+cDbtKB5ldKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614533; c=relaxed/simple;
	bh=scPLBheLCFrb9aBaepkVLX57LEpK4csVqkaXTsIsrbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=up+97hhM+u8UgPyiuX9oqMbJqx9yzwQ6fC15o+ACGK9/LF5b9n3h+1BCjk6gZsXqElwqUmjVWtnTPKqXCikAAgsMGaY+QIFB/l/Af/nf31ILtAE98pcfJfIIPfzrbmv9njgyXofZwo0TJnXEjlvX3mJ53lmpAacjkN9t09iJlo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9lErGtJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758614530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TOkyzE0c1T3gu5dI+oIIOizv6pKHsRXJTQzDXcjJAJc=;
	b=C9lErGtJ9jYQoV0ET/UhXraL6iY9ftTfATlcjG/m5KOobURK7wyNXsSaFiQqw7J9a1MZqh
	kHRbxM3cEoJkmIJzaBIK7RRqFLNFU2FQuD1dKwp43wZQQe8602/XEwkGCo1VG/mt9+gNg4
	UdZHiUdpfl2VL0QPPHVYZ4Z6z0btVBg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-xVpVznRlPtaQEpkQYh-fBw-1; Tue,
 23 Sep 2025 04:02:06 -0400
X-MC-Unique: xVpVznRlPtaQEpkQYh-fBw-1
X-Mimecast-MFC-AGG-ID: xVpVznRlPtaQEpkQYh-fBw_1758614524
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A3C21955F45;
	Tue, 23 Sep 2025 08:02:04 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9A7D195608E;
	Tue, 23 Sep 2025 08:01:59 +0000 (UTC)
Date: Tue, 23 Sep 2025 10:01:57 +0200
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
Message-ID: <aNJT9a0FA0cM_oBa@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
 <87ikhodotj.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikhodotj.fsf@jax.kurt.home>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Sep 12, 2025 at 11:04:24AM +0200, Kurt Kanzenbach wrote:
> Sebastian found a machine with i350 and gave me access.
> 
> I did run the same test as you mentioned here. But, my numbers are
> completely different. Especially the number of hardware TX timestamps
> are significantly lower overall.
> 
> Without the patch:
> 
> ./ntpperf -i eno8303 -m X -d Y -s Z -I -r 200000 -t 10
> 
> NTP daemon RX timestamps   : 0
> NTP daemon TX timestamps   : 565057
> NTP kernel RX timestamps   : 100208
> NTP kernel TX timestamps   : 281215
> NTP hardware RX timestamps : 882823
> NTP hardware TX timestamps : 136759
> 
> With the patch:
> 
> NTP daemon RX timestamps   : 0
> NTP daemon TX timestamps   : 576561
> NTP kernel RX timestamps   : 99232
> NTP kernel TX timestamps   : 255634
> NTP hardware RX timestamps : 868392
> NTP hardware TX timestamps : 135429

ntpperf sending 200k requests per second for 10 seconds is 2 million,
but the sums of RX or TX timestamps in both your results show it
handled only about half of that. The CPU seems to be too slow for such
rate in either case.

I was testing it with an Intel E3-1220 v6 (4 cores, no hyperthreading)
and I set "-r 200000" to roughly match the maximum rate my machine can
handle before the patch. Can you please try adjusting the rate to
minimize the loss in the test without the patch first?

> What am I doing wrong? Here's my chrony config:

Your config looks good to me. Here is mine, but it is functionally
equivalent wrt this test:

hwtimestamp i350b
clientloglimit 1000000000
local
allow

> 
> |########## i350 NTP performance regression test ###########
> |local stratum 10
> |allow X
> |allow Y
> |allow Z
> |
> |hwtimestamp eno0
> | 
> |clientloglimit 134217728
> |log measurements statistics tracking
> |logdir /var/log/chrony

-- 
Miroslav Lichvar


