Return-Path: <netdev+bounces-225514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB9B94FBA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DF43B9032
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B91114;
	Tue, 23 Sep 2025 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaZrtAJt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A122154F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615954; cv=none; b=jyB1ND5LddA71XRPoHpZ3VKV0X5IXULgblIr8vJu42V3ApNNOSp3dmkisRWy8nmtmx/Z3zGCBBsqYL7g4XGQwp9s+yIvbfetSLd4sLw7NAUS+mA4GgLRfQX1utkFKNqiXlqeP9bR+0yBEk1yUDqrYtCWohyeCa5klUcKdhbwHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615954; c=relaxed/simple;
	bh=/cTpqyn2MfrI1XMsNoTH1BQj+YmlDyueZBen++h5+lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbJqiO4UZ9je69JxL2zcETHvbLVtPI6/pkYY9m6VlY+++yasFCd5D1Yc9F+pxCUNYb+0R0VimKe2/eXyIXIugJQjuvdONTPK/6QJZfiz/AceIJFR1MllrXqtt478b/iSafVTLJfz5bT5FhjxF+1KjiCiqndoFlO9iBuDMVkJOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aaZrtAJt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758615952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CJeBRmjfgan3gR/ATwH++/RYnsTgQ6yPqZhiRFuAQs=;
	b=aaZrtAJtACfdTb14qthnXxJe0mHLZFqEmtypErI/rxbfq/fX6v8ueIH908eyNnX+/haCUO
	tZ85vG28PdI3aX/+Glw0PSj0UqprDRexblIf+HS/Clt0UfAUcGp07GFqszIi3ay7zCwNUk
	WmFnVjyOS5zZuJKLKK4xNHr/B7o2Xu0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-qdsA3oX5PZ2yxjEY-3Iung-1; Tue,
 23 Sep 2025 04:25:48 -0400
X-MC-Unique: qdsA3oX5PZ2yxjEY-3Iung-1
X-Mimecast-MFC-AGG-ID: qdsA3oX5PZ2yxjEY-3Iung_1758615946
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA3A918005B6;
	Tue, 23 Sep 2025 08:25:43 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B436C1955F21;
	Tue, 23 Sep 2025 08:25:39 +0000 (UTC)
Date: Tue, 23 Sep 2025 10:25:37 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
Message-ID: <aNJZgRkY66BCu9Aj@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
 <87ikhodotj.fsf@jax.kurt.home>
 <20250913212212.3nwetWbI@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250913212212.3nwetWbI@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Sep 13, 2025 at 11:22:12PM +0200, Sebastian Andrzej Siewior wrote:
> If I do
> | ntpperf -i X … -I -r 1000 -t 2
> 
> then there is no loss and on other side I see
> 
> | NTP packets received       : 2201
> | NTP timestamps held        : 2101
> | NTP daemon TX timestamps   : 200
> | NTP kernel TX timestamps   : 901
> | NTP hardware TX timestamps : 1100
> | tx_hwstamp:2101
> 
> Here the tx_hwstamp counter colorates with "NTP timestamps held". Does
> it this make any sense? I don't see this matching with the "larger" runs
> where ntpperf reports loss.

The serverstats counters are for timestamps that were served to the
client, which is different from timestamps it got from the kernel.

Some HW timestamps are not used because chronyd is not tracking the
PHC yet. That takes at least one second in default configuration (it
can be reduced by the minpoll option of hwtimestamp). If there was no
other NTP activity on that interface before the test was started, in
the first second of the test (i.e. 50% of -t 2, or 10% of -t 10)
chronyd will be serving kernel TX timestamps, even though it is
receiving HW timestamps from the kernel. To minimize that effect, you
can run a client chronyd instance in background polling the server
once per second (minpoll 0 maxpoll 0) and wait for a few seconds
before starting ntpperf after the server chronyd instance was
restarted.

There is a 2-packet delay in the interleaved mode for each client
(ntpperf has a warmup phase to avoid counting basic responses). With
-r 1000 ntpperf simulates 100 clients. So, for the 2201 requests
chronyd received, the first 200 (2 * 100 clients) responses had a
daemon TX timestamp, 901 responses had a kernel TX timestamp before
the PHC tracking initialized in the first second, and the remaining
1100 responses had a HW TX timestamp.

The "NTP timestamps held" matching tx_hwstamp is a coincidence. It
is not related to the number of HW timestamps received from the kernel
or served to the client. Until chronyd starts dropping timestamps to
not exceed clientloglimit, it's just counting requests in interleaved
mode, i.e. the number of requests minus the first request from each
client: 2201 - 1 * 100 = 2101.

-- 
Miroslav Lichvar


