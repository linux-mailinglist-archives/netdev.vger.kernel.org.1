Return-Path: <netdev+bounces-307557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u/fDMwN+Vmpj7QAAu9opvQ
	(envelope-from <netdev+bounces-307557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:20:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7FF757CB7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 20:20:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ycp1XjOQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307557-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307557-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03CB13032768
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 18:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F3A3CFF62;
	Tue, 14 Jul 2026 18:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95831ED8B
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 18:19:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053183; cv=none; b=OhsBp6kCkw2KCZqoouGXyyAcn51RWQveOjs8zaroTGBuxc1o5sdHfDi1CYWJOqh8b+19E/OeVmBntyp9DacDPPia2Gd6fIA4nRTppxIRqmnRbMRxAR7uVeRpovDrgTnEvSx5ZdbWusAKKMhesSaRWruzPLkxwvnwHhw+jew4Nr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053183; c=relaxed/simple;
	bh=C1sFBtxE69ioRh1QGckxAsEgc8urMOayeNMSZKFqcyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWhVRa5vUvCSxJ+CiexjX9mF/16DmMEJU+PLz8Sg1uzqZOoCfP279Ylh9LnfUXQ9jS9X4c0MOB/PDCXgPNmlXcKRmAHMZwVrXmeLEErPJpfuHf6HIBLXlAzTWfcFt+3y7u6Gz2gxNCxqcbvnR/J+T/9BfDCEoTTFLVe56AT1wws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycp1XjOQ; arc=none smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8484f229529so1056352b3a.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053181; x=1784657981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aZW9BZhR1bEUCTQBEiW6Qsx2NvsQORDmw5UKJ5XbZAA=;
        b=Ycp1XjOQ1hBCjFMRXhM3wQA/gGT5rC1cW5pOfdgoktPOnn/aNVJBYn/HagGmLtwpTj
         zqStZyFbTbBuPj8MXhmFMXSCJdvWu8GPwMsPcxa8Ex1tFyVPuwgG1waE6XlKSvr4pc8u
         n7tWW0LdAEnII7n9y7v5RaQeHNDv2dplMBN5cWMMMTpojrTmiABzt+2O53iAGHazjMVR
         35L1IC9BrSFJHbwcsVYhVWb8J3eGpEkw+eaSVvRUTc7cWQXi69RCzLXCe6+kOgLB/PhA
         +QRyRwP/E4GQp7XVo95ZYqD1K7BgNLcnJ2SQN+Ku6i5Fvizuwhx2N5Su86rddfvpjYcb
         BUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053181; x=1784657981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aZW9BZhR1bEUCTQBEiW6Qsx2NvsQORDmw5UKJ5XbZAA=;
        b=EO/02bqaj3SJpgXxcf5ZsSWhwOad/d/lFrj9VIBIMaezOCxsyJiy1TKWahxYwsVRnI
         7EGvz2o5fu7MDFoxMThndN+BcxyRC2nuzxwFllBiLiYqAFimvJkVdcAA3Uo4tyIazJmZ
         41MnHmU2ObKVl0pTSw72WXXIm5vzN8N0gty4Xg5qdeYCx+jRTi72aPXUJR+Vb6Yq3nq3
         XHLB94jvAyf0rxEXZMF/L/IemgmCWHkurYn0mZ50146b9n3azY4ZoNoJzRh1aDfTJAX9
         27DlIS9QX6BsVkEqzFovz1uyITnEZCrcUkrAkBfIi/jAfBa/e2UZDS0AtNHdGUVX5kpY
         RP/Q==
X-Forwarded-Encrypted: i=1; AHgh+RqV/+vhg1etRIyDTn7KzEhWPkjvU38875V2qjsg3/UMH11k8uAVtWAC/Rj4su8JTyBbf3I5DoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5dYBy+Hrzk4b7pPIRyE+xs6Z8LHie9uYiqM5PNmpottdS1UGu
	0WvWIplf0W2hDz3idkawilZc+r5+WX8t8wc2au++7GBb2HjOH/XYZEJ1
X-Gm-Gg: AfdE7clbapUNoujAmNy1aL1Uj3gNs72Cd6YsW/aHsGe8jZyj2XZVM+C/ujaJNwPbhFy
	wV+h08s6+6dx2+aBP6GLt/3jYkbDnP4mOzTK9TJQmWPVVxk6sUov2UHxnQbqRd1tTUAWzT5m5sm
	J1hhxor6/+ssBFX1HiTqx5glGJeSGKH8RIrMNAZGKHhvFRISpdVPo13dF74l6uKhqZYX4cISe6e
	kQw45z4eYvWwfzk/vFOcikFxXaXaisy0NSjJGdBOtu10N+RmwffX9RYwC8mB7HHb05yCsNaKqts
	bTWcshIsVNNdZd4hQUYrdjCKmSwn/4uevB/DDzjYF9WXDcRCAw7Ik3RQkNFcGtG9LCIWdzDgha8
	1CcgE4Goub5Lq1V00s/A0lnwoVG5msji0N8CY2ng85WQR8RztgmCJzZ4IO8b/cWePCLp8OR+1ZH
	VnsDpVdFjs4UFK7GyNLJAh
X-Received: by 2002:a05:6a00:228e:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-848896c39e2mr12654855b3a.9.1784053181128;
        Tue, 14 Jul 2026 11:19:41 -0700 (PDT)
Received: from john-p8 ([98.97.42.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7da667sm1855269b3a.41.2026.07.14.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:19:40 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:19:38 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Nnamdi Onyeyiri <nnamdio@gmail.com>, sashiko-reviews@lists.linux.dev, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, jakub@cloudflare.com, 
	edumazet@google.com, ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
Message-ID: <alZ9ZUWbUbVJuBmZ@john-p8>
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
 <20260709185526.E4DAB1F000E9@smtp.kernel.org>
 <alFRK66z45eDNZA7@localhost.localdomain>
 <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307557-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:nnamdio@gmail.com,m:sashiko-reviews@lists.linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:jakub@cloudflare.com,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,vger.kernel.org,cloudflare.com,google.com,davemloft.net,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,john-p8:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A7FF757CB7

On Mon, Jul 13, 2026 at 12:14:07PM +0800, Jiayuan Chen wrote:
>
>On 7/11/26 4:17 AM, Nnamdi Onyeyiri wrote:
>>Hi,
>>
>>The updated patch below addresses the issues raised by sashiko-bot.  The closed
>>socket and signal handling code was added to tcp_bpf_recvmsg(), and the fix was
>>updated to work for sockets with SO_RCVTIMEO set.
>>
>>Please let me know if any more changes are required, or if the patch would need
>>to be submitted some other way, I'm happy to adjust as necessary.
>>
>>Thanks!
>
>
>Thanks for the report.
>
>
>What's your use case here? With a verdict prog attached, we'd normally
>
>expect the data to be redirected in kernel rather than read back via
>
> recvmsg(). Are you using SK_PASS? If so, please state that in the
>
>commit message instead of the email body.

For our use case we never do redirect or packet operations (push, pop)
we merely use it as a mechanism to read data and possibly drop data
if it violates some policy.

