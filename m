Return-Path: <netdev+bounces-215170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CE0B2D547
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB18B1BC7128
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620892D6E6D;
	Wed, 20 Aug 2025 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHyTXFDi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7A2D838E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 07:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676606; cv=none; b=ReEcg2ZUZzgS6FqzlKPU1AlsVeXCL7ZgHI2AgWq3AhgaVkAGlnz0MWBTMXrbqm+VaF79LINrASZfkyp6o9qPW/LfIYgfu+jWEcDvCuxzx57lFJEF4wrDTs3WiAvfuHDlyTkLTdcaqqOyjuL5vZvbFEU/SxhHhlOlwVawnqHo3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676606; c=relaxed/simple;
	bh=GQMNAmNy/zVgHmi+zLjcxRm9t9x4LA0akP4L99OAMNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiOnsEjHKylC35e2+9g2Qa6novJFEtxrLAfri+NdiRHmTllnC9ChqcaEO8ZWuBZfFfzo2rFY9FOgIY52VGCRNJqWKenxvNndrOB+c524OCgGO4NsFVeeu3T3nWx0h9KP6Y+2e14a6Azt+p1NrE9saDdfTNf2lIpNtVJHtJ4kI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHyTXFDi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755676603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JL4/RTCr1wG7n9TqI8dawujOVLp09ZQA/NyuJYZQpDE=;
	b=LHyTXFDi+jCwZTVTnyE9jGhYw2fpsC3WNI+bcdfmvTtqAT0d71/27bISlTFRXtlqpV9hZO
	eZw3/qVoX/gKflUvJj3kBEqa01x2Bs5+C+ztc9ajrgJ4NmzkCmpOTidxViC82pMLNAyZDe
	OBNcNLpYDGMGz06evPtZdEOtsOuRvV0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-K1saE8n2OFWAFNbzeLg5UA-1; Wed,
 20 Aug 2025 03:56:37 -0400
X-MC-Unique: K1saE8n2OFWAFNbzeLg5UA-1
X-Mimecast-MFC-AGG-ID: K1saE8n2OFWAFNbzeLg5UA_1755676595
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2018319775A6;
	Wed, 20 Aug 2025 07:56:35 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A64519560B0;
	Wed, 20 Aug 2025 07:56:30 +0000 (UTC)
Date: Wed, 20 Aug 2025 09:56:28 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
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
Message-ID: <aKV_rEjYD_BDgG1A@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Aug 19, 2025 at 04:31:49PM -0700, Jacob Keller wrote:
> I'm having trouble interpreting what exactly this data shows, as its
> quite a lot of data and numbers. I guess that it is showing when it
> switches over to software timestamps.. It would be nice if ntpperf
> showed number of events which were software vs hardware timestamping, as
> thats likely the culprit. igb hardare only has a single outstanding Tx
> timestamp at a time.

The server doesn't have a way to tell the client (ntpperf) which
timestamps are HW or SW, we can only guess from the measured offset as
HW timestamps should be more accurate, but on the server side the
number of SW and HW TX timestamps provided to the client can be
monitored with the "chronyc serverstats" command. The server requests
both SW and HW TX timestamps and uses the better one it gets from the
kernel, if it can actually get one before it receives the next
request from the same client (ntpperf simulates up to 16384 concurrent
clients).

When I run ntpperf at a fixed rate of 140000 requests per second
for 10 seconds (-r 140000 -t 10), I get the following numbers.

Without the patch:
NTP daemon TX timestamps   : 28056
NTP kernel TX timestamps   : 1012864
NTP hardware TX timestamps : 387239

With the patch:
NTP daemon TX timestamps   : 28047
NTP kernel TX timestamps   : 707674
NTP hardware TX timestamps : 692326

The number of HW timestamps is significantly higher with the patch, so
that looks good.

But when I increase the rate to 200000, I get this:

Without the patch:
NTP daemon TX timestamps   : 35835
NTP kernel TX timestamps   : 1410956
NTP hardware TX timestamps : 581575            

With the patch:
NTP daemon TX timestamps   : 476908
NTP kernel TX timestamps   : 646146
NTP hardware TX timestamps : 412095

With the patch, the server is now dropping requests and can provide
a smaller number of HW timestamps and also a smaller number of SW
timestamps, i.e. less work is done overall.

Could the explanation be that a single CPU core now needs to do more
work, while it was better distributed before?

-- 
Miroslav Lichvar


