Return-Path: <netdev+bounces-251782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLaAOw97cGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:06:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450F52955
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCF394E05E8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A498449EA8;
	Wed, 21 Jan 2026 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sg3ZoV6i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC63191C3
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979150; cv=none; b=Q7VhbKhAlBBNRqdGj38maU9tDByVs355ZVu1g5TuWOGrDEh6g6Da7N5sHUNcJzF/F+L8bQzWLo36mKI0zeE2WtDGozMh7X0NRw5Q2YYWjuHEkD7j/gFsP2Kx7QskiidHG/5/djCGb1K/ClhUkGsvRjbmC5mrPqH3301Cwta/eKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979150; c=relaxed/simple;
	bh=BjEonW32c5YOMq0hqq7Xvkwknsp7bLBK5sRV2QqHoDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkYoKoljdFY7fhDssLha2oer0znB+HknofquBtpgFBGxp+FvJI+XVuHaKQGWcKmRjFdU2Ty3V19vCJ2DjNNxOrI+5rSWtxhmjAEJS7RX18ia9xn75+nnC7Pv1L7/htTAjuoYPUuydAUrmSKEZNZqanOVMcwo6Beu9SprBncFCEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sg3ZoV6i; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c52e25e636so886621585a.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768979142; x=1769583942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dr4ikofTW2/lOylz+wqvxKyTxo3lmrOIQRlztmAAggk=;
        b=Sg3ZoV6i+QQDzpXN/MrPnJcu2guPa+FeJKfqSO6udsChhE0tg7y+aNPLKrQbPThaLx
         1wR/io0+f5DbQ03LEtP4HmOqL2t3bxf4vs4AxKci/5Yj77Xrwat5W6UODvfO8b2Sd+DB
         IzXEJM1WncFJM09rkMNSqA1CMyJGD5zL/uPf+kLxnsQVhZ3mvT6MFCRbd822qI8sxszp
         FHcKVay/sKk1GSsPbu3Wu7BbcDHBOs6dWq0cCC3MGA1XtEFmYnel8NMNDwTx2YaVh7xA
         rITHGwB6tDUZssLAtRoBzpN5uWfvKxEE1QxcY0KQO43f6JyP//oBDuv1N4RI8PCRKXxZ
         h0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768979142; x=1769583942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr4ikofTW2/lOylz+wqvxKyTxo3lmrOIQRlztmAAggk=;
        b=i1ahV2M7RxLzuT7ejNFUpatiWXyc1kGUqeCoxAwQb/GNNZe5hu3ERFahx6W8ULTbmc
         Tz40zHB/7/n1ypRLnYtuJ9mXjtJlsRzCy2AC3bzWaRS5yZrsxfPzwCaK38tEu4qJvXh5
         7ggCcoZysq8HezwTdgsxNi3yFoz4aUlXxtStcTvcW6AcacjWURvUWBcyy0ueeFl3vQpM
         EWooLrPhZKO0pcNot0aWzFJMXiAcIWVb/OXkPnqE+Ql3jrsh9WT5ww9ES0DAa2VdVk3j
         gKf5xB98NubMTNytDc98Km7akO9W6IvzQZmNWE+pBC0fe+Vw7LH6Be2CN8QFROOPI9wt
         1Qpg==
X-Forwarded-Encrypted: i=1; AJvYcCV3yumWd0YHv9aeMUlqvOyLoEM2IEd0e9rc9uPKxCR6d5mw56iq1+MBPWrkZLhnbn8YtyIsNRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFA2zfSqo4/yiQWqxrA8CLH5RZmaMtUn5y88ILhzC1N2re06E
	Lqel6S8FwiqhLzIYbIZrEBM1zubYEwtl7jUIiA/1qPob35R7awixUTG+1NnECQ==
X-Gm-Gg: AZuq6aL69SIK08KiSrf4Jj+oyWx7uS4fndXsQqPpBav80i8RA1FM2w7LBxErfQ1eQtO
	VQQp+QIW+ly8ZYIwzDlrpPk/LUmUjNufhZdUDFtF0xbd0WKTpU1ZbyWjua8z/kLdzs7kGzQJCij
	QSlkZ1cqIXAPK9ijFeq8paL3cJMclNFFepbtWkxF7/nbBjPII6biWJRhS8CbcuX/Gqiw0G2OR/A
	MzoF05o2Zk2GZDUov/T8l/had17JFAGPpC19HR4g9Y7KIMsXoPCoRYo05P7c2n22SZS8wpffisR
	OhWI+892BzXAKTJqqI256lrO0VOwnsy2nkduPI3Ey8AYtQYtpd3wVZ5wa+ZxCA+OK7yggAZnRZK
	pL3Z2MDmTUnQQC2SSFk6eAhO53cSjAauYnc4TvgytGnS8UYwFaUUSVuTFSYk25XeNk4LsYWHJF6
	m/s56W1LMx0yWSXk6GedKoKQ2VPjj5YF8zGbc=
X-Received: by 2002:a05:690c:ec4:b0:788:1086:8843 with SMTP id 00721157ae682-793c66b7cd1mr130884437b3.2.1768972588159;
        Tue, 20 Jan 2026 21:16:28 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c6888b83sm60922327b3.48.2026.01.20.21.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 21:16:27 -0800 (PST)
Date: Tue, 20 Jan 2026 21:16:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: sgarzare@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mst@redhat.com, horms@kernel.org, bobbyeshleman@meta.com,
	corbet@lwn.net, xuanzhuo@linux.alibaba.com, haiyangz@microsoft.com,
	jasowang@redhat.com, linux-hyperv@vger.kernel.org,
	pabeni@redhat.com, kys@microsoft.com, vishnu.dasa@broadcom.com,
	longli@microsoft.com, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	stefanha@redhat.com, berrange@redhat.com, decui@microsoft.com,
	bryan-bt.tan@broadcom.com, eperezma@redhat.com, wei.liu@kernel.org,
	davem@davemloft.net, shuah@kernel.org,
	bcm-kernel-feedback-list@broadcom.com, edumazet@google.com,
	virtualization@lists.linux.dev, sargun@sargun.me
Subject: Re: [net-next,v15,06/12] selftests/vsock: prepare vm management
 helpers for namespaces
Message-ID: <aXBhKlAxxAkvr4/u@devvm11784.nha0.facebook.com>
References: <20260116-vsock-vmtest-v15-6-bbfd1a668548@meta.com>
 <20260121025420.1999992-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121025420.1999992-2-kuba@kernel.org>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251782-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:url,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 6450F52955
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 06:54:21PM -0800, Jakub Kicinski wrote:
> In case you need to respin..
> 
> This is an AI-generated review of your patch.
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> selftests/vsock: prepare vm management helpers for namespaces
> 
> This commit adds namespace support to VM management helpers and wrapper
> functions, requiring callers to explicitly pass "init_ns" for the init
> namespace. The commit message states "No functional changes for existing
> tests. All have been updated to pass 'init_ns' explicitly."
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index c2bdc293b94c..1d03acb62347 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -135,7 +135,18 @@ del_namespaces() {
> >  }
> >
> >  vm_ssh() {
> > -	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> > +	local ns_exec
> > +
> > +	if [[ "${1}" == init_ns ]]; then
> > +		ns_exec=""
> > +	else
> > +		ns_exec="ip netns exec ${1}"
> > +	fi
> > +
> > +	shift
> > +
> > +	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
> > +
> >  	return $?
> >  }
> 
> The vm_ssh() function now expects a namespace as its first argument, but
> run_shared_vm_test() still calls vm_ssh without this parameter:
> 
>     vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
>     vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
>     vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
>     vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> 
> When called as "vm_ssh -- dmesg", the "--" is interpreted as the namespace
> argument. Since "--" does not equal "init_ns", the function sets
> ns_exec="ip netns exec --" which is invalid. The shift then consumes "--"
> and the command becomes "ip netns exec -- ssh ... dmesg" which will fail.
> 
> Interestingly, the v9 version of this patch on lore correctly updated these
> calls to pass "init_ns", but this change appears to have been lost between
> v9 and v15. The fix for this regression is present later in the series in
> commit 3ae984505e00 ("selftests/vsock: add vm_dmesg_{warn,oops}_count()
> helpers").
> 
> [ ... ]

Got it, thank you.

Best,
Bobby

