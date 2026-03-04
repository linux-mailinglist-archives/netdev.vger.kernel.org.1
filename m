Return-Path: <netdev+bounces-263693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EZjDYr9p2mlnAAAu9opvQ
	(envelope-from <netdev+bounces-263693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:38:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1FD1FDBC4
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5DBC30C18AC
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E839A055;
	Wed,  4 Mar 2026 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0qCgqPT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520103976AA
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616917; cv=none; b=Y+xIMd/pVYH+SoJfPItTt1flWsDXWiiW9fZ2Ob4A8ZHst1Ww/0oX3EfENLF9srPXxS/HfjyyrFlzJeZCCSEqenEKLAjnFdcvI3dGgOY0VJK6+p1ChbLjJH9FLm/Ku/2EHoZP3FPO94TV8Y+GbEmK5ROppStohdX805760IvPfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616917; c=relaxed/simple;
	bh=5RS0gn7dSXiGAjM4SRWXpV0iYGFBtPRZUYd8/q3EgJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4YPih2vWfoRyrfS9Oezr9IqFM7EGriifWKCpxQUFOoG9Ypauii3Fo4KFUuDfEFRvLjGaQ/gfd2AlDIiwrJzNiqnOduGtvInrIsxdsBnNt75ocobXFYDa2RnuZbWgJSkpDy0iEOk9hwqnaoI+hf56DiYisigS8+Y37sTgDU26Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0qCgqPT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772616915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34x8dW+VODfI2RuFdRgreGOgi0nhsq6qAyMMwtOtc+0=;
	b=h0qCgqPTCOi2+0o/KqxHpqqHdupGP2TcsUepU59JRACmBKhwRBdmJWjn/B6g7vLyE2HLw4
	jy615FP1Kl4Ws6ZVxUkxDcLD9s+8ImfAwXm5W/fhoS2iHeIAYAq/RNtJ0YgL9QYd3n2t0d
	08nAi2xXcjiY8mfDEcYXGkyo4oA2LlU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-Px0G-HPoO3GdBTa0AchyCA-1; Wed,
 04 Mar 2026 04:35:11 -0500
X-MC-Unique: Px0G-HPoO3GdBTa0AchyCA-1
X-Mimecast-MFC-AGG-ID: Px0G-HPoO3GdBTa0AchyCA_1772616909
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 567131800365;
	Wed,  4 Mar 2026 09:35:08 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5086D180075F;
	Wed,  4 Mar 2026 09:35:03 +0000 (UTC)
Date: Wed, 4 Mar 2026 10:35:01 +0100
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
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
	Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v4] igb: Retrieve Tx timestamp from BH workqueue
Message-ID: <aaf8xVPWQ0-y1BnX@localhost>
References: <20260303-igb_irq_ts-v4-1-cbae7f127061@linutronix.de>
 <9805389e-9ea4-4e7a-a122-65f733ead33c@molgen.mpg.de>
 <87qzq1rq2k.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzq1rq2k.fsf@jax.kurt.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 9E1FD1FDBC4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263693-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[molgen.mpg.de,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,linux.dev,lists.osuosl.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mlichvar@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 02:38:11PM +0100, Kurt Kanzenbach wrote:
> > It would be great, if you shared the numbers. Did Miroslav already test 
> > this?
> 
> Great question. I did test with ptp4l and synchronization looks fine <
> below 10ns back to back as expected. I did not test with ntpperf,
> because I was never able to reproduce the NTP regression to the same
> extent as Miroslav reported. Therefore, Miroslav is on Cc in case he
> wants to test it. Let's see.

I ran the same test with I350 as before and there still seems to be a
regression, but interestingly it's quite different to the previous versions of
the patch. It's like there is a load-sensitive on/off switch.

Without the patch:

               |          responses            |        response time (ns)
rate   clients |  lost invalid   basic  xleave |    min    mean     max stddev
150000   15000   0.00%   0.00%   0.00% 100.00%    +4188  +36475 +193328  16179
157500   15750   0.02%   0.00%   0.02%  99.96%    +6373  +42969 +683894  22682
165375   16384   0.03%   0.00%   0.00%  99.97%    +7911  +43960 +692471  24454
173643   16384   0.06%   0.00%   0.00%  99.94%    +8323  +45627 +707240  28452
182325   16384   0.06%   0.00%   0.00%  99.94%    +8404  +47292 +722524  26936
191441   16384   0.00%   0.00%   0.00% 100.00%    +8930  +51738 +223727  14272
201013   16384   0.05%   0.00%   0.00%  99.95%    +9634  +53696 +776445  23783
211063   16384   0.00%   0.00%   0.00% 100.00%   +14393  +54558 +329546  20473
221616   16384   2.59%   0.00%   0.05%  97.36%   +23924 +321205 +518192  21838
232696   16384   7.00%   0.00%   0.10%  92.90%   +33396 +337709 +575661  21017
244330   16384  10.82%   0.00%   0.15%  89.03%   +34188 +340248 +556237  20880

With the patch:
150000   15000   5.11%   0.00%   0.00%  94.88%    +4426 +460642 +640884  83746
157500   15750  11.54%   0.00%   0.26%  88.20%   +14434 +543656 +738355  30349
165375   16384  15.61%   0.00%   0.31%  84.08%   +35822 +515304 +833859  25596
173643   16384  19.58%   0.00%   0.37%  80.05%   +20762 +568962 +900100  28118
182325   16384  23.46%   0.00%   0.42%  76.13%   +41829 +547974 +804170  27890
191441   16384  27.23%   0.00%   0.46%  72.31%   +15182 +557920 +798212  28868
201013   16384  30.51%   0.00%   0.49%  69.00%   +15980 +560764 +805576  29979
211063   16384   0.06%   0.00%   0.00%  99.94%   +12668  +80487 +410555  62182
221616   16384   2.94%   0.00%   0.05%  97.00%   +21587 +342769 +517566  23359
232696   16384   6.94%   0.00%   0.10%  92.96%   +16581 +336068 +484574  18453
244330   16384  11.45%   0.00%   0.14%  88.41%   +23608 +345023 +564130  19177

At 211063 requests per second and higher the performance looks the
same. But at the lower rates there is a clear drop. The higher
mean response time (difference between server TX and RX timestamps)
indicates more of the provided TX timestamps are hardware timestamps
and the chrony server timestamp statistics confirm that.

So, my interpretation is that like with the earlier version of the
patch it's trading performance for timestamp quality at lower rates,
but unlike the earlier version it's not losing performance at the
higher rates. That seems acceptable to me. Admins of busy servers
might need to decide if they should keep HW timestamping enabled. In
theory, chrony could have an option to do that automatically.

Thanks,

-- 
Miroslav Lichvar


