Return-Path: <netdev+bounces-216415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DBCB33848
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC12174767
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC9029993A;
	Mon, 25 Aug 2025 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5KRz0zF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509BF28B3EB
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108442; cv=none; b=fO6buGRnbOG2WGCkLlieWQlyLek+dk6q+sOCrRO4ADvo091pp9BjwhypmqCav2KErCoayuk0ZKl1vZkcbyWYdrYsUrT+cQFE9WIP1C3RsxtJGtY5WZumr4ZFgTkXjz6ZG+Pg2ksLZYH+FrQZxikDPKVpo9evWcLSQ9DaF6dJMkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108442; c=relaxed/simple;
	bh=fJELBPGfr6DDdhGHLk15qKUnTRmXxrJKh2/NYGTN9vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac2Nm4aj5Gj/DGy16xRTnH6DEJXZHdiDbosnm/JQmxPqZPopLR/ISi19OoHgXBpCyRH3Ium/8AEjK0yeI/zJ8yVJh7D5SpS0IAwl2Lr26urV43ki/wEp0GGsik8ej96pd4i0BW8QT3TMpOB+teEf4OjjLhYQQhBTX8XKnbuioNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5KRz0zF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756108439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HSbEb9TE9a0hDvp7QsHnLnkasX81TE79idDzsvFWLk=;
	b=K5KRz0zFZMoCubx5eW9wVvJqOBwWtvLE0S72gkqYUVbx97Bu5rs4fqPzv3iW5nUIEKlcZ2
	GH+8oINfYpnh/K/U+sAyUWe54NyzvkGffgGnQ2FFNWRyBzZaghPZVejqDUAOmO2UJIUvEZ
	weFqUAuYflf7ujvk3n4MPoX+82IyGeI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-X2vwgUQBPU2mq6GV33TESg-1; Mon,
 25 Aug 2025 03:53:55 -0400
X-MC-Unique: X2vwgUQBPU2mq6GV33TESg-1
X-Mimecast-MFC-AGG-ID: X2vwgUQBPU2mq6GV33TESg_1756108432
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEB51180035B;
	Mon, 25 Aug 2025 07:53:51 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE621180044F;
	Mon, 25 Aug 2025 07:53:46 +0000 (UTC)
Date: Mon, 25 Aug 2025 09:53:44 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
Message-ID: <aKwWiGkbDyEOS9-z@localhost>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
 <87ldna7axr.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldna7axr.fsf@jax.kurt.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Aug 23, 2025 at 09:29:36AM +0200, Kurt Kanzenbach wrote:
> Also I couldn't really see a performance degradation with ntpperf.

I was testing with an I350, not I210. Could that make a difference?

> In my
> tests the IRQ variant reached an equal or higher rate. But sometimes I
> get 'Could not send requests at rate X'. No idea what that means.

That's ntpperf giving up as the HW is too slow to send requests at
that rate (with a single process calling sendmmsg() in a loop). You
can add the -l option to force ntpperf to continue, but the printed
rate values will no longer be accurate, you would need to measure it
by some other way, e.g. by monitoring the interface packet counters.

-- 
Miroslav Lichvar


