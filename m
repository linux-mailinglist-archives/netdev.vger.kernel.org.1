Return-Path: <netdev+bounces-306548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FFWnFgXtUGpK8gIAu9opvQ
	(envelope-from <netdev+bounces-306548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:00:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D473B001
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:00:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=BRgw1odI;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306548-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306548-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18AA2305C989
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7809842847B;
	Fri, 10 Jul 2026 12:57:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9F542B311
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 12:57:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783688228; cv=none; b=ZhVgctzvffuSVWiaSIZ8yWipepmMXgLLf/OsdgcqdHdwnp3zreH64/rXE8TvOpssD2Xva8PYBkFT+RWsOS6MpLPqEi/rF04b0SwgM4Ee1EDeB4J2mdQfJ/AcfWPFTjpLeqpHS0CCNiuQi5IW6sY5CYmUNp3HeAS377iPT+6ViV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783688228; c=relaxed/simple;
	bh=WRMC93RjMLHhBK4Qdxn8+ZwZdI5iOhTVnr6GBLi07ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/b08hWyHHU/EcZj4N+twRFQ4D/6/AaMI2h+LAhOZikQ8Y5sw7MxE5Hg9ULAUDZ9Zmgl8yAz7aKGEIbYUlsf5P1H2eXEq5hHDhjm5QpTR8zZdVKTkucrRDE9sy66j1LQiaYpfhMbs9hj5mrthMIivIB+8gS1JUZNsM2n0dAX7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BRgw1odI; arc=none smtp.client-ip=95.215.58.170
Message-ID: <c66e433b-654d-4c14-ad73-e3a93314d8d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783688225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwgX3ese9TTzLzbTOBdpDICtiejDWhzq53b1cASyBMw=;
	b=BRgw1odIdZWy1k6mKZpAetJ30MY4JA1nPE4vOF/nmHVt/GVAHXN5Mk0wms2VowY1EPQGlL
	JNv9ThVl85RZZTy4qFupHj5jYZZc+GU5j5W8Ws4tIdEPDL7OfVAs5/1SCPG9WVKnTcUdrI
	tr3NIGtc5syUyJ4YLenuRreR9BfVl0g=
Date: Fri, 10 Jul 2026 13:56:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/4] dpll: zl3073x: add channel ToD and phase
 step operations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260708170527.916035-1-ivecera@redhat.com>
 <20260708170527.916035-2-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260708170527.916035-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ivecera@redhat.com,m:netdev@vger.kernel.org,m:Chris.duQuesnay@microchip.com,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:richardcochran@gmail.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B71D473B001

On 08/07/2026 18:05, Ivan Vecera wrote:
> Add low-level DPLL channel operations for ToD read/write/adjust,
> delta frequency offset write and output phase step. ToD operations
> use a wait-before-write pattern to avoid blocking after each
> operation. tod_adjust additionally waits for completion since callers
> may follow with phase step operations.
> 
> The tod_ready_wait helper selects the poll timeout based on the
> current ToD command - write operations use a longer timeout (1000 ms)
> than reads (30 ms).
> 
> The ToD read captures system timestamps (ptp_system_timestamp) around
> the HW command and completion poll to support cross-timestamping.
> 
> Add output step-time mask invariant to zl3073x_chan and
> zl3073x_chan_is_out_stepped() helper to check if an output
> participates in step-time operations.
> 

[...]

> +/**
> + * zl3073x_chan_tod_read - read ToD registers after issuing a command
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @next_hz: if true, read predicted ToD at next 1 Hz; otherwise read current
> + * @ts: timespec to store the result
> + * @sts: optional system timestamp pair for cross-timestamping
> + *
> + * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
> +			  bool next_hz, struct timespec64 *ts,
> +			  struct ptp_system_timestamp *sts)
> +{
> +	u32 nsec;
> +	u64 sec;
> +	u8 cmd;
> +	int rc;
> +
> +	if (next_hz)
> +		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ;
> +	else
> +		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT;
> +
> +	/* Wait for any previous ToD operation to complete */
> +	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
> +	if (rc)
> +		return rc;
> +
> +	ptp_read_system_prets(sts);
> +	rc = zl3073x_chan_tod_ctrl(zldev, ch, cmd);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
> +	if (rc)
> +		return rc;
> +	ptp_read_system_postts(sts);

AFAIU, this code means that the ToD value was somewhere between tod_ctrl
command and tod_ready read value 0 of the register. How does it work
with "predicted ToD at next 1 Hz"?

> +
> +	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_TOD_SEC(ch), &sec);
> +	if (rc)
> +		return rc;
> +
> +	/* HW nanoseconds are always in [0, NSEC_PER_SEC) range */
> +	rc = zl3073x_read_u32(zldev, ZL_REG_DPLL_TOD_NS(ch), &nsec);
> +	if (rc)
> +		return rc;
> +
> +	ts->tv_sec = sec;
> +	ts->tv_nsec = nsec;
> +
> +	return 0;
> +}
[...]

