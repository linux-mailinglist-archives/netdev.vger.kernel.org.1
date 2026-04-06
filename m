Return-Path: <netdev+bounces-275741-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J4iE6gj1GlxrgcAu9opvQ
	(envelope-from <netdev+bounces-275741-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE583A7807
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 23:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E8E63009806
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129A386C25;
	Mon,  6 Apr 2026 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uz5117rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4C30FC1F
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510434; cv=none; b=UgnNUu3C49mIn+jdwkiQBEjuwHAuwnKyScouhmqyWIay2TTeMo/Lnvp5tuQyJ96h6Aj053bgmQHPhbqfKREg4NGj9GArnI5eGBhQ5Ijfu3tmco0tInmj1NQoUtMQtRWKZfl/Rq0MjX9AKXSNntjYU3krvmYE7Zzl8PE0teNksKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510434; c=relaxed/simple;
	bh=tOzS5yBZD6qH+T9+3SQjvBHwIz/KRctL1NoeMqapak4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ERZjSQ+Xr/JWx95AxEFOh+uqBB64Qg7TFJwpQ/qapX2l3iJHytPm3NByKYg99ddlh6cbWEEtPYPCHcXjnSOCtIbsb64FxSFjwvlAjM5MQjejp1I+G1YA0zWVSKPOwtksRvYDybsecxDZETVmWKGAlsvzkIiXcwyBpFQwHzvHf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uz5117rk; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65006c99d38so4614314d50.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775510432; x=1776115232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bzs5SDxOWpPA9bqwDu45hXe3OO9/TGgNIA4jG1lKAk=;
        b=Uz5117rkle5R9ddnVfLtcC5v9UYSGxftsYq7b6UQWhQ8XofihNXl8Ocb9pSEvSJbd2
         t9wOYcwuHs0GYwzT60wt670kQj7x+t9+qTjAZxpDi/+fubVhrfCehFasGpPFOWjvXbwE
         FPjIIOPe9pdUpK4iXeUzHt2kGLNP+yVNaALnuZrQTMFK/WkadwVSK2jRSMny+AgH1sQj
         C7cjHi1X92L5+09hlKGGdswMGLSG5VWL5/DKRrO+iuK+Sqxv9Mnt4/t7EEM9zR8mTCv6
         rpQoggm33Qy2skMgDFb0oUcxO6snlllglv8jpQp9F+ODeGmWYcjfyTyz+KrsluDMP4jY
         KN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775510432; x=1776115232;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bzs5SDxOWpPA9bqwDu45hXe3OO9/TGgNIA4jG1lKAk=;
        b=GanxNLaov2Pwj8r9r8bgaP9UVOYYm/W56jxQ4ZUHmZz22mZSNLqpElS8vpu5C5nDje
         0MBhUYB5W8CJhKsGTevG0ixXE8SrcYzL4eBVcgQDNzeeCSfI7O1Oqb6Kcpm+jKtyQ97/
         JB+v13itccjqH3+n0RJNGTrIqwM3bKvURJgxfpZZpnc0ewiC9u0fEhXbHmP/Rb7Atgvl
         KlcSQohUqVS2sxAEdN0AIz8Zv44D8e9MLJbBIVhVxL67nIILl5XOJ8n3cfdVmCJn0DUK
         /4gZcm/CMbKcXL3a9eEyGRVO/cwBZA59P657qcmse2IAIXe2MtqKftesYltQSTl7DFmc
         UVww==
X-Gm-Message-State: AOJu0YwP4NBZcDYVSFPTWEUVb+mvhBJDwTJ1ZCX8Rr3D4BMvpM7CF97t
	vAOufPqFneqUQEi2VwN5mr8uVuSgizQwL19xMB6rfi8FYaRGCOHKYXeU
X-Gm-Gg: AeBDietpduvua31nv5ZGQMySVhMpeHi/7q0xzScGhIQm5ne55SMghFzp+N4dNCyatp0
	/r6r7TUNB0CIxtNXRb7+5/z2ToRtyALkt8XKhikd96jSlyy7+pIxOTdqYcexmmbHUXIZdCGK6LO
	+pRL0s6uCzQhjvFMLgZxqY6OwaQb3cbfSe4G13OXL00iPEHM/t44tFnC8U8dEK2Ik0i4i2UhGNG
	jtinm//la/pVZfqz4aBrxM/e49uu8RrqgDZf9z5Fx3Myg/kmkPGzgIicBH2He6eaLFQSOv+CaD/
	Wze+UP4GlozuAvyyZhulP8r3rjPxIqYk1kjqPg+TUaEGim68okVjJeoIHknaClX6eQwWgg9zqkS
	JFrMeoNHkB9gzkyIFQ30SsqbUUIZM/rBtCzJ6hsebBJ4AcCqL0i/CtzgMFI2JZ7wzO2nYjWqo+8
	Ng0hWahljR1lyjVYMdG3c5VpClN5S4cNjwsl926sPIuT/dwa3Cfc65LOjzLgHM7xDG2skp8DUFQ
	hmF
X-Received: by 2002:a05:690e:d88:b0:64c:c616:c349 with SMTP id 956f58d0204a3-65048754a1cmr13246650d50.31.1775510432437;
        Mon, 06 Apr 2026 14:20:32 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a86d1b1sm6582433d50.9.2026.04.06.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 14:20:31 -0700 (PDT)
Date: Mon, 06 Apr 2026 17:20:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 andrew+netdev@lunn.ch, 
 linux-kernel@vger.kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3156bd9082476@gmail.com>
In-Reply-To: <adPfTwbARPVFLys8@devvm20253.cco0.facebook.com>
References: <20260403233240.178948-1-joe@dama.to>
 <20260403233240.178948-3-joe@dama.to>
 <willemdebruijn.kernel.aa6e2a3e845d@gmail.com>
 <adPfTwbARPVFLys8@devvm20253.cco0.facebook.com>
Subject: Re: [net-next v2 2/3] selftests/net: Test PACKET_STATISTICS drops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275741-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[dama.to,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DE583A7807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Joe Damato wrote:
> On Sat, Apr 04, 2026 at 11:08:15AM -0400, Willem de Bruijn wrote:
> > Joe Damato wrote:
> 
> [...]
> 
> > > @@ -396,6 +424,11 @@ static void run_test(void)
> > >  
> > >  	total_len = do_tx();
> > >  
> > > +	if (cfg_drop) {
> > > +		check_packet_stats(fds);
> > > +		goto out;
> > > +	}
> > 
> > Sashiko pointed out
> 
> In the future, please link to the AI report.
> 
> > that there may be a race here between rx
> > processing in the softirq and check_packet_stats. Seems plausible.
> 
> Can you elaborate why this is true?
> 
> I could be wrong, but I scanned the code and __local_bh_enable_ip seems to run
> softirq synchronously in this case, so I think the code is correct.

You mean that after the return to user in sendmsg, the packets are
guaranteed to have been queued to the sd->input_pkt_queue, the napi
schedule was run by enqueue_to_backlog and napi was run on this
cpu as a result of reenabling BH. At the end of dev_queue_xmit? I
recall that there may be a common one on syscall return too, but the
details elude me right now.

Either way, makes sense. I had not fully appreciated that the 
softirq schedule is this deterministic.

