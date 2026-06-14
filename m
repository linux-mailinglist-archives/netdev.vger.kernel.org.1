Return-Path: <netdev+bounces-299232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d6qYERrMLmrX2wQAu9opvQ
	(envelope-from <netdev+bounces-299232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:43:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F56816A6
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 17:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=qb8C1uky;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299232-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299232-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91B93300565B
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04D39F168;
	Sun, 14 Jun 2026 15:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B662D6E58
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 15:43:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781451799; cv=none; b=hnsxYHlsoCBWYSWhIfvUpJsyL1fnb2dgFn/aYrTBiwGaIYlWLtEatg0O/oQbpc+JHZbzTduhJCgDwJLuyqCKda5jdH9c4GKgBLUTEz3G1IwYMzAiSv34tTumj+WK/8z2OM3js+G+5n6ad9QurMBnmWJ3bX8zFLLdKN0J7c51kNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781451799; c=relaxed/simple;
	bh=LpvCFn0dRRHtaD6KrFY6MXjrwwnjOgJVlQoJcZlcixU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WF/48nFXLwgsb/M4mrNiAUoIsibsffXXStsAaNN2d+QCfYQD0KICtAqBksPU4wFnUQ0w7Edbj30ViBx6peU0pwMbvmk2HVPPObZLi93vU8D8FahMSVcIzXss51/g6sOIDP5iUcLS+gY6RbK2JCLZsIFm+vltkUoUDRKZBzK4nus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=qb8C1uky; arc=none smtp.client-ip=74.125.224.49
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-660e9fe3c3aso1394092d50.2
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781451797; x=1782056597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXEDkWpJK73CdOzXOiT61XC7iCy343EpJa3GmdB0zQY=;
        b=qb8C1ukyX0OSWs3FZBD70G0DFL7RheMsGzHuKO2FSq0xEsILzOmABGEwR3ffmcbc44
         a55/ZibRhL09BbGLy40EeRCNc0YtcJPiTSM6gtlkG2fUWcOsa9fLmRAfGYOZPRvJKvyP
         ZzTE9RT14VXHy6790DtXu2430w80f359B0jrh7gWQWrnbfBhC5jYvIxun7ZAlDqw+IQP
         0jRys/vGih0M7aPSoe/5IeoDzZOp4u97hXUdajlGXz/DqXoAuoOWWFNzVXQx3dYZ38ZB
         at3E1jzc+zdWXaCwDx2C9EhU3UlKvASz4FjHViXJe8jLT+TaEXHxsVexok5y6YwV/L/f
         dsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781451797; x=1782056597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gXEDkWpJK73CdOzXOiT61XC7iCy343EpJa3GmdB0zQY=;
        b=GFyDbhbg/YcNJOGdKPO2yCVX4vl5+xU5r9Fs0Ko+SufmiNTMXlUdf0COg/wGud7KF1
         8pbZSjAuR9tGuAv8Ho0qaWFhQUnf/+k36lb9O/KAsz1kPPlz2RarCAr918CkNqhvECnp
         bAP7BPKa4hRdSfE46wEk4dVaj+ihqrsdkF1uH1FjE2QE6NCHH9f6PRTIcTcWVoL2r8/n
         GCugxtSPVbekNPddhi/24VlXghZqS1445c6gF+BzrvWO5oa1KQooczqWUoZ1DJLJ+FTR
         OIHrwur9avI8PHb2dpJnuHs8M+ryVEItYSa/o0YwCS6RrOxBOF0WSipFg4LnjBH16qGH
         CNTg==
X-Gm-Message-State: AOJu0Ywvw+K0gZgEbwnVG7BCoUtWXjlq5sLXNPXP9YbacN/e2wz0bOZc
	Qq02jAtlumQnAUTdcQrDWVbHcwOK+zLYj323zq6BDJCVDBXZYNi8EYR4GMCAhy1Y/WI=
X-Gm-Gg: Acq92OEMMoPm0WScgglFSlKxS79Eo/xST1XQgbgLovYIh56NxmYHaTJX64ECzzB/fjy
	DO+JMJmWpIL/oSQIRMZ8226Ux4007iynmW3aWutHSnDuNsVZKuT3CDTSIlDwf3ku0jr+IJpAXfd
	h9Oj0MEuwz+18pKXwLIeqKsWHLrRrZ5R/rhifvg8oGzit/MX4IETJ5yQv5s0ui5V3wo9xb6wmja
	Ky/wCCuNmVay/Ha2tMUdJgqHtLuKwDdNGca6Om0ZDaUT872dKgqJSRZ/HJqT9l4lLaqYqVZkfdL
	s3inO0YtqBQMuuznEY04thzCP2DpcUagMRXt1cJt3KuWvn3pG0/E6R9nLaX3F5R/6yoinUnya+s
	N/Dg1ig/altIWt7GImCb2SyQ6NkJP6ccGXswt8LxnbakQg3w8uq1IG0DWqo3j0A5B9Ifz/KjuP8
	4eHwMcBwLKhwu+6gf3GiW8el7wnfmfQO2SzpE3MnCybCjDBVpqb20JCkDaVYguAThw
X-Received: by 2002:a05:690e:1c08:b0:660:a41d:d17c with SMTP id 956f58d0204a3-66277f63581mr8972605d50.18.1781451796745;
        Sun, 14 Jun 2026 08:43:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66274e02e28sm3645739d50.13.2026.06.14.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 08:43:16 -0700 (PDT)
Date: Sun, 14 Jun 2026 08:43:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Hemendra M. Naik" <hemendranaik@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 linux-kernel@vger.kernel.org, vishy0777@gmail.com, tahiliani@nitk.edu.in
Subject: Re: [PATCH iproute2-next v2] tc: fq_pie: add support for printing
 per-flow PIE statistics
Message-ID: <20260614084312.2bbcff11@phoenix.local>
In-Reply-To: <20260614130729.10076-1-hemendranaik@gmail.com>
References: <20260614130729.10076-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299232-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hemendranaik@gmail.com,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:linux-kernel@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,mojatatu.com,gmail.com,nitk.edu.in];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,networkplumber-org.20251104.gappssmtp.com:dkim,nitk.edu.in:email,phoenix.local:mid,networkplumber.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D9F56816A6

On Sun, 14 Jun 2026 18:37:29 +0530
"Hemendra M. Naik" <hemendranaik@gmail.com> wrote:

> 'tc -s class show' against an fq_pie qdisc now prints:
> 
>  prob           drop probability for the flow
>  delay          per-flow queue sojourn time (microseconds)
>  deficit        remaining DRR byte credits (signed integer)
>  avg_dq_rate    dequeue rate estimate in bytes/second
>              	(dq_rate_estimator mode only)
> 
> avg_dq_rate is formatted using tc_print_rate(), which converts the
> kernel's bytes/second value to a human-readable bits/second string
> (e.g. '3906Kbit'), consistent with how other tc schedulers display
> rate fields. Apply the same fix to tc/q_pie.c, where avg_dq_rate was
> also printed as a raw integer without a unit.
> 
> Update the UAPI header to mirror tc_fq_pie_cl_stats from the kernel.
> Fix the 'delay' field comment in struct tc_pie_xstats from "in ms" to
> "in microseconds" to match the kernel's
> PSCHED_TICKS2NS / NSEC_PER_USEC conversion.
> 
> Add a 'tc -s class show' example to tc-fq_pie(8) with dq_rate_estimator
> enabled, showing all per-flow fields (prob, delay, deficit, avg_dq_rate)
> across multiple flows. Update tc-pie(8) avg_dq_rate example from a raw
> integer to a formatted bits/second string.
> 
> The corresponding kernel patch can be viewed here:
> https://lore.kernel.org/netdev/20260614125000.6058-1-hemendranaik@gmail.com/
> 
> Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
> Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
> Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>

Minor feedback from AI review was:
Subject: Re: [PATCH iproute2-next v2] tc: fq_pie: add support for printing per-flow PIE statistics

On Sun, 14 Jun 2026, Hemendra M. Naik wrote:
> diff --git a/tc/q_fq_pie.c b/tc/q_fq_pie.c
> @@ -283,25 +285,43 @@ static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
> +	if (st->type == TCA_FQ_PIE_XSTATS_CLASS) {
> +		print_float(PRINT_ANY, "prob", " prob %lg",
> +			    (double)st->class_stats.prob / (double)UINT64_MAX);
> +		print_uint(PRINT_JSON, "delay", NULL, st->class_stats.delay);
> +		print_string(PRINT_FP, NULL, " delay %s",
> +			     sprint_time(st->class_stats.delay, b1));
> +		print_int(PRINT_ANY, "deficit", " deficit %d",
> +			  st->class_stats.deficit);
> +
> +		if (st->class_stats.dq_rate_estimating) {
> +			tc_print_rate(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %s",
> +				      st->class_stats.avg_dq_rate);
> +		}
> +	}
>  	print_nl();

The print_nl() at line 334 appears to be misplaced. It's outside both
conditional blocks, which means it will always print a newline regardless
of the statistics type being displayed. This could cause formatting issues:

- For TCA_FQ_PIE_XSTATS_CLASS, you'll get a newline after the class stats
- For qdisc stats, you'll get an extra newline after the memory_used field

The original code had print_nl() after the qdisc statistics. With the new
class statistics block, you likely need print_nl() inside each conditional
block to maintain proper formatting for each type.

Consider restructuring like this:
	if (!st->type || st->type == TCA_FQ_PIE_XSTATS_QDISC) {
		/* qdisc stats */
		...
		print_uint(PRINT_ANY, "memory_used", " memory_used %u",
			   st->memory_usage);
		print_nl();
	}

	if (st->type == TCA_FQ_PIE_XSTATS_CLASS) {
		/* class stats */
		...
		print_nl();
	}

Otherwise the patch looks good:
- Good use of print_* helpers throughout
- Proper handling of JSON vs text output modes
- The tc_print_rate() usage is correct and consistent
- Documentation updates in man pages are helpful


