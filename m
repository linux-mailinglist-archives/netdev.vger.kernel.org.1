Return-Path: <netdev+bounces-265624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABvUEGbxrmkWKQIAu9opvQ
	(envelope-from <netdev+bounces-265624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:12:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9896723C83E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 17:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E54C317F67B
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898903DBD4E;
	Mon,  9 Mar 2026 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5IO+rmf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366EC175A7B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072334; cv=none; b=Mt9YCJDilj3uOWqJ9kXXr2HSVhgNwu9WJe8mu2hX3+Z2x29hKPgKS3mk+Usmrj8EuX+4iG2S2P+2MsH9damE3dsFklTwbnK+CFO7IW3nsdJ36STx/Z67SjZQiK9A/dFEFHYhQkA53zMCw2BhsFReXlPhLZtE6I+CX883dVlIbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072334; c=relaxed/simple;
	bh=SB/TBgzrhIxkj9CSOrg1jg0zXDmvNvNGicwyUCiXUTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBoyXzbDY7Pojj5OvMKh3fV98pPsVF4O5g5RIHXT75GD54OGR2cfTGbDGHgEeSk4ejNhiF5U3NRWZf7l+WPX2j+Boz29vjxkgXey9YOevbxrTHTKnhW2stUixSVQ3shiZU+SaIlOEQPq/LixFK4xeIdpWRSvfANLgoQkh6EYF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5IO+rmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773072332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhDmXOBdBP7yOM0CVnMxDeuC96/LIXfEFhiV8CFZ+Cg=;
	b=H5IO+rmfHFvc70UImq+Cr/PWbkSWiMKrqa5vxMJV97TkXP2TRrCx43cHtqIMsB4kaSdFrN
	u8RKBPAL394H1epF77n3g/bHbVe/yY1zVvUzA+v/8ZI2JjWlnUreLVVI6Hobd+rqwDsKx+
	+xknEOSBpX+uofuhHFKxubCc5CabY4A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-t-bDMbxUO5KiyD4s7tQu4g-1; Mon,
 09 Mar 2026 12:05:26 -0400
X-MC-Unique: t-bDMbxUO5KiyD4s7tQu4g-1
X-Mimecast-MFC-AGG-ID: t-bDMbxUO5KiyD4s7tQu4g_1773072323
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2020A1800561;
	Mon,  9 Mar 2026 16:05:22 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C12530001A2;
	Mon,  9 Mar 2026 16:05:17 +0000 (UTC)
Date: Mon, 9 Mar 2026 17:05:15 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4] igb: Retrieve Tx timestamp
 from BH workqueue
Message-ID: <aa7vuz-fSkwCB3To@localhost>
References: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
 <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
 <87qzq1rq2k.fsf@jax.kurt.home>
 <aaf8xVPWQ0-y1BnX@localhost>
 <ecacc5fd-b3b0-4d66-83ab-4152e4ed22b8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecacc5fd-b3b0-4d66-83ab-4152e4ed22b8@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 9896723C83E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265624-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,molgen.mpg.de,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,lists.osuosl.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlichvar@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 01:37:54AM -0700, Jacob Keller wrote:
> On 3/4/2026 1:35 AM, Miroslav Lichvar wrote:
> > With the patch:
> > 150000   15000   5.11%   0.00%   0.00%  94.88%    +4426 +460642 +640884  83746
> > 157500   15750  11.54%   0.00%   0.26%  88.20%   +14434 +543656 +738355  30349
> > 165375   16384  15.61%   0.00%   0.31%  84.08%   +35822 +515304 +833859  25596
> > 173643   16384  19.58%   0.00%   0.37%  80.05%   +20762 +568962 +900100  28118
> > 182325   16384  23.46%   0.00%   0.42%  76.13%   +41829 +547974 +804170  27890
> > 191441   16384  27.23%   0.00%   0.46%  72.31%   +15182 +557920 +798212  28868
> > 201013   16384  30.51%   0.00%   0.49%  69.00%   +15980 +560764 +805576  29979
> > 211063   16384   0.06%   0.00%   0.00%  99.94%   +12668  +80487 +410555  62182
> > 221616   16384   2.94%   0.00%   0.05%  97.00%   +21587 +342769 +517566  23359
> > 232696   16384   6.94%   0.00%   0.10%  92.96%   +16581 +336068 +484574  18453
> > 244330   16384  11.45%   0.00%   0.14%  88.41%   +23608 +345023 +564130  19177
> > 
> 
> 
> With the fix, we have a higher lost percentage, which sounds bad to
> me..? And we have a higher response time (which also sounds bad??) and
> we have a much worse standard deviation across all the values from low
> to high rate.
> 
> I guess I just don't understand what these numbers mean and why its
> "better" with the patch. Perhaps its the naming? Or perhaps "xleave" is
> bad, and this is showing that with the patch we get less of that? But
> that looks like it gets consistently lower as the rate and number of
> clients goes up.

xleave is 100% when the server responds to all requests and all
responses are in the expected (interleaved) mode. That is the ideal
result.

The patch doesn't seem to change the absolute maximum rate of
responses, unlike with the previous versions, but at some lower rates
up to 30% responses are missing, apparently due to the kernel being
able to fetch HW timestamps from the NIC at a higher rate, i.e. the
driver is trading network traffic for HW timestamps.

> > At 211063 requests per second and higher the performance looks the
> > same. But at the lower rates there is a clear drop. The higher
> > mean response time (difference between server TX and RX timestamps)
> > indicates more of the provided TX timestamps are hardware timestamps
> > and the chrony server timestamp statistics confirm that.
> > 
> 
> 
> So you're saying a higher mean response time is.. better? What is it
> really measuring then? Oh. I see. it has a higher response time because
> it takes longer to get a Tx timestamp, but the provided timestamp is
> higher quality. While previously it was using software timestamps so it
> could reply faster (since it takes less time to get the software
> timestamp back out) but the quality is lower?
> 
> Ok. That makes a bit more sense...

A transmit HW timestamp is taken later than SW timestamp, so there
is a larger difference between the TX and RX timestamps. ntpperf can
also measure the accuracy of the TX timestamp directly, but it's a
more difficult test to set up as the HW clocks need be synchronized to
each other.

-- 
Miroslav Lichvar


