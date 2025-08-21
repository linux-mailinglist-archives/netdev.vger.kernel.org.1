Return-Path: <netdev+bounces-215532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA435B2F016
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54268189654F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32612741C9;
	Thu, 21 Aug 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7gAUN48"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1121FF28
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762629; cv=none; b=Zr8J+4NG/hMvSpXyNQMS+yF8mqGJ5VY31/4OMNir7MV4rh8+XQcrBYV5j3nNOYKwZiy5KyxWJdSb/00vJ9Njh2xkN8XCJ5fBKmCAuw7Tq1ZjuZrsdIDgr2VdoEmvGUFolxgYq5rLhlmMw0iULdTAGnn9hfxQHEm0wpsYLGm9NvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762629; c=relaxed/simple;
	bh=XqtPuuJFQ5CejlQ3nTuKysAVB4WXspXTDT03mguXjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crBRMPGKggcbSu1cLO8I6jfftNa008WeY46sy2arsDhevnpqkvDqZAVF/t5yAqmrk6I0XDtILbrQVgP/t484nUrLC0LHM1hzeAhVcoT0uhn2F3llY9fp0lftfPTgIQPBQUQjcG4YyPtRHDgN03U3rIDM8HkXxImnBZohx/yy2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7gAUN48; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755762626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dKiVVI7dxTB2KqSBmt6ytWWdgaP4+YJtf5CAboYFUAg=;
	b=D7gAUN48vpynWhYDLDTUeuw4CswWXjTWlQUERtvGZlP820bBb+jCcv7Fx2ROZzhqRYDEiV
	vbgRfvd1SBWt2nJH6242kkJrT0SyirEj2yKIfl/QIpNtZ12cmWl5hYSwPo1ZJeIv4hXTTK
	S2B+bs0lfIqIUCf7q8e2JwA5dtm+E/Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-NUtxdQwOPbCdUA9eDb1Jpg-1; Thu,
 21 Aug 2025 03:50:23 -0400
X-MC-Unique: NUtxdQwOPbCdUA9eDb1Jpg-1
X-Mimecast-MFC-AGG-ID: NUtxdQwOPbCdUA9eDb1Jpg_1755762621
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8CFC19560B6;
	Thu, 21 Aug 2025 07:50:20 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B029719560B2;
	Thu, 21 Aug 2025 07:50:16 +0000 (UTC)
Date: Thu, 21 Aug 2025 09:50:14 +0200
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
Message-ID: <aKbPtoZqfWqSOzLN@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
 <81c1a391-3193-41c6-8ab7-c50c58684a22@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c1a391-3193-41c6-8ab7-c50c58684a22@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Aug 20, 2025 at 01:29:31PM -0700, Jacob Keller wrote:
> On 8/20/2025 12:56 AM, Miroslav Lichvar wrote:
> > Without the patch:
> > NTP daemon TX timestamps   : 35835
> > NTP kernel TX timestamps   : 1410956
> > NTP hardware TX timestamps : 581575            
> > 
> > With the patch:
> > NTP daemon TX timestamps   : 476908
> > NTP kernel TX timestamps   : 646146
> > NTP hardware TX timestamps : 412095
> > 
> 
> When does the NTP daemon decide to go with timestamping within the
> daemon vs timestamping in the kernel? It seems odd that we don't achieve
> 100% kernel timestamps...

Yes, it is odd. The daemon uses the best timestamp it has when the
new request comes from the client asking for the TX timestamp of the
previous response. With 16384 clients and 200000 requests per second,
that's 12 milliseconds between two requests of a client. I tried
increasing the receive buffer size of the server UDP socket and also
increase the number of clients to make the server wait longer for the
SW TX timestamps, but that didn't help. It looks like they are lost.

Due to the way the server implements the interleaved mode, it's the
first two exchanges with a client always have the TX daemon timestamp,
so the "without the patch" result above has only 35835 - 2 * 16384 =
3067 missing SW or HW timestamps (1.5% of all responses), but "with
the patch" it is 476908 - 2 * 16384 = 444140 (28.9% of all responses). 

-- 
Miroslav Lichvar


