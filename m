Return-Path: <netdev+bounces-215159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DBB2D456
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726D83B1139
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D72D0C8A;
	Wed, 20 Aug 2025 06:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVZX+l1y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DC2C11C4
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755672863; cv=none; b=O4OgmD8wKOXLZmy0MUqaEmX9A4Hz5dpLcGZtwH9ZzO7p5HE1WdxqmQy5rxw9w5kFPhIU+9BECq2Q+NK+qt1+tBZim6yT5Oesu5UItFVMkwWg559sQ/yGBIBvRQMd8LAriP24uqFvcP+g+07n4yDjXrLY9IC59GOJHRnr7fyRa5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755672863; c=relaxed/simple;
	bh=C7FGJEn9utV4DVIxMBnuhS0fIHB/EBeIFop+TFsP6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoCrK2EbM9jEzjIdMGzPz0ECgr9kx8sPtAb/bxChjE7sTKIUcXIIk395ROAZyac49fSEx0cRVwGoCprG/t5bnsZ+JaigmZBnB6krAqBgnZ2RrHUWd54MDG2jl9K31xo3Vyufx6x5IBhleR31+Al5LfJH9k43efYxtHgklf3d2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVZX+l1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755672860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yovFcx2lS/jztUpVbcF86Ft2OX16ePIPJO/lfVq9oj8=;
	b=OVZX+l1y4Yn+5W5zRhdVvDfjoyr2RHv8R7gG1xfI3VtBmhnVUZ7Zclcb4cpXZhhdGyT4tW
	FgftEk7UsD9GjHmEUc5Q4GE199L6ARwjBUV/LLACxv4hTE/TkcyPYjCdBKj6rlqzXJIwNH
	bL2wuoxrpPZQuLElitMQBl3bFTj/u3Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-UBGOA6hBNt6Wf8X1tSnt6w-1; Wed,
 20 Aug 2025 02:54:15 -0400
X-MC-Unique: UBGOA6hBNt6Wf8X1tSnt6w-1
X-Mimecast-MFC-AGG-ID: UBGOA6hBNt6Wf8X1tSnt6w_1755672853
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFDCF1955D69;
	Wed, 20 Aug 2025 06:54:12 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04DE1180028B;
	Wed, 20 Aug 2025 06:54:08 +0000 (UTC)
Date: Wed, 20 Aug 2025 08:54:06 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
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
Message-ID: <aKVxDjocY3uQr342@localhost>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <87ms7vs6vk.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ms7vs6vk.fsf@jax.kurt.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Aug 19, 2025 at 04:50:23PM +0200, Kurt Kanzenbach wrote:
> Installed ntpperf on one machine and chrony (v4.6) on the second. In the
> chrony config there is 'hwtimestamp enp1s0'. I did run the first example
> in ntpperf's README with the following results. 'rate' seems to be
> higher with my patch applied. Anyway, your ntpperf output looks
> completely different. What parameters are you using? I just want to
> reproduce your results first.
> 
> root@cml1:~/ntpperf# ./ntpperf -i enp1s0 -m 6c:b3:11:52:39:15 -d 192.168.123.1 -s 172.18.0.0/16 -B -H

Interleaved mode needs to be selected by the -I option (instead of -B)
in order for the server to enable SW+HW TX timestamps for the
responses it sends back to the client.

My ntpperf command line also had "-x 1.05" to increase the rate in
smaller steps and "-o 0.000000500" to print the offset between the
server TX and client RX timestamp instead of the offset between
server's TX and RX timestamp (response time), but that requires the
NIC PHCs to be synchronized to each other over a different network
link and the -o value to be calibrated for the delays in timestamping
and cable. It's not important for this issue, no need to bother with
that.

> * ntpperf with igb patch applied

> 129721   12972   0.00%   0.00% 100.00%   0.00%    +7934  +49386 +229427  17600
> 194581   16384   0.00%   0.00% 100.00%   0.00%   +10760  +54961 +248325  18860
> 291871   16384   0.00%   0.00% 100.00%   0.00%   +13207  +57193 +248870  16908
> 437806   16384  25.42%   0.00%  74.58%   0.00%  +211479 +275061 +703480  20529
> 
> * ntpperf without igb patch applied

> 129721   12972   0.00%   0.00% 100.00%   0.00%    +2670  +14699 +242395   6692
> 194581   16384   0.00%   0.00% 100.00%   0.00%    +2520  +19712 +329254   9571
> 291871   16384   1.37%   0.00%  98.63%   0.00%    +2818  +77396 +15480693 182286
> 437806   16384  24.69%   0.00%  75.31%   0.00%  +108662 +246855 +2306431  38520

Those results look the same within few percent, as I'd expect with
the basic NTP mode (-B option), which doesn't enable server's TX
timestamping. Normally, I see larger differences in subsequent runs in
the same configuration.

-- 
Miroslav Lichvar


