Return-Path: <netdev+bounces-217302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BE3B38427
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A1945E3E70
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C053935336D;
	Wed, 27 Aug 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW3Nm5bd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1F347C3
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303040; cv=none; b=tu64F7KoMI6ZLZDlakQnXB8/69uZfXo3PzfaMMlA2N1h7BjO2VcDz/sTGSRCRxp4Pggd/iAKcgFdOtS08lpwWC8fT00YcBq+miirHmtCP1f+HDG5admeHsX7J+ziy7nZbXz9MsmBYTfa2RYDHqk/GM+SSOvgg73dDhRYMAFQNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303040; c=relaxed/simple;
	bh=BqgZJxx+QonWw78Co1P5PiUeYPc60JbLj+sBSfPQM8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLbntwW5QZzogBVnTFk1Y+wE/S7qOFX26Jei6r0DN4NsCxjBQ+2K20gupE5+rvpMNZ9QNoHWSF1e3PkHJ7F5IzV8qi4txDzCR0TKJTyExrCDTf/O0RlIWdVfsvczACtyr+8HCnhFDE9WCgu//fGnZH5NGmJZ7gceDMdeKBu0P8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JW3Nm5bd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756303037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lARuK9/oHAO5hZ8DSoFp95Tj5e5SnDh8mVdcAdZjl6k=;
	b=JW3Nm5bdtFdEIeXNO5t9tq3Spyfr/lzyn4D63lO+pgOTrhKjlMpNHSp/7XxN8YTfNPnjcL
	hM5SZ/T1fP3Pka+IdagOpT6bDUGBjbYkBCemGb+THnysnyT4fID04JdSJvFbcncwRdMpeu
	PbHiGL85u04dCKaB2lKn+SXenEs3taA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-0T7Pay7yObSdBY8dPXStcg-1; Wed,
 27 Aug 2025 09:57:13 -0400
X-MC-Unique: 0T7Pay7yObSdBY8dPXStcg-1
X-Mimecast-MFC-AGG-ID: 0T7Pay7yObSdBY8dPXStcg_1756303031
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8FD4219541A0;
	Wed, 27 Aug 2025 13:57:09 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6017180044F;
	Wed, 27 Aug 2025 13:57:03 +0000 (UTC)
Date: Wed, 27 Aug 2025 15:57:01 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
Message-ID: <aK8OrXDsZclpSQzF@localhost>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
 <87ldna7axr.fsf@jax.kurt.home>
 <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
 <20250826125912.q0OhVCZJ@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826125912.q0OhVCZJ@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Aug 26, 2025 at 02:59:12PM +0200, Sebastian Andrzej Siewior wrote:
> The benchmark is about > 1k packets/ second while in reality you have
> less than 20 packets a second.

I don't want to argue about which use case is more important, but it's
normal for NTP servers to receive requests at much higher rates than
that. In some countries, public servers get hundreds of thousands of
packets per second. A server in a local network may have clients
polling 128 times per second each.

Anyway, if anyone is still interested in finding out the cause of
the regression, there is a thing I forgot to mention for the
reproducer using ntpperf. chronyd needs to be configured with a larger
clientloglimit (e.g. clientloglimit 100000000), otherwise it won't be
able to respond to the large number of clients in interleaved mode
with a HW TX timestamp. The chronyc serverstats report would show
that. It should look like the outputs I posted here before.

-- 
Miroslav Lichvar


