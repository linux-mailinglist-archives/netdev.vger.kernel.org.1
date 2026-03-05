Return-Path: <netdev+bounces-264127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAbxIebiqGnzyAAAu9opvQ
	(envelope-from <netdev+bounces-264127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:56:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B420A0DD
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4B9F3011C4C
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F038C241103;
	Thu,  5 Mar 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnWaeW7f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F061EA7F4
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675770; cv=none; b=mHNZ5zmN3l8osUUF/Q1HLDhTT+x3y0KMppHvCQUwsIHGuIgAAnF57eCy4u+pQB/aSOQJ37L8yRQ5L+qTSAOyLXdC/olaEj7Hv6ktC90qqU2J7hvZJdm+yFuIZsMsNb2WZBBBfN8+NseBISyGRNS8gvk02BoV7pd0VN+UP79A4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675770; c=relaxed/simple;
	bh=IXGyvNUbtHNwWlO779yACClXsPwAOkeZHizYbHOl/5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYqjhXKmj7fqFZ3ZAmPoXAj1/IHW3OTWonlru4WcBrdVS5VJk+DBzEuXGWfoDY2r606b2t3UzOAOjji8dkObNFji3VxnYhlsVs6WlNrav70rrPolHsj7dSlPGXZkrQ52ju8B7vV2wreKcap9G+a9mIqSOIv4Db4lSPLs4zM9L7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnWaeW7f; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso3349429a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 17:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772675769; x=1773280569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+qfkgX7v8ytZV4SKpMC2pGAv+ee613FIPLowmgLLAh8=;
        b=cnWaeW7f1Q4ZpEv39mswZnkvAeoPDeYRl5fDf/TKmXmBpviXO54ki9PS9QTZwOMJu9
         2rOZLAW95zhnwrWfICONt/2kqcVPEoFv0YW37pa9mqvdXFMj2IG9jZLxJFqKF3wq0yEs
         bhnLcgEKo60TrPbpArmIfpUO+Mi8hlahhZED1mROUiTGULv9BFvRDLYAWPl7EP8ve6D9
         c9+UnqDwsv8q/j0RKVBK6NyrQNF774SEKz790FYnd+Sq513QqWS791rxhMtMuw+bnwwh
         u/PUo94kHKP4RhS3nQucFuD8q1/TBA8ooyiPkXZYT1yEY5DigGx/7g5d0N+asd+FUgrd
         L1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772675769; x=1773280569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qfkgX7v8ytZV4SKpMC2pGAv+ee613FIPLowmgLLAh8=;
        b=tjgp/PTVWPLJKz15/a+Dj6vOSMdC3qkfRFlYG2L3iKHPL6HkDhE72smXs6fbI5Htb1
         DEd4tTy0xzt57N1bqJihhphIKWT7hYe/SxbYrE3DEyvwS3jStET1vKAcudWUos4PtEQE
         cQU+7MwKuOs781i84b9ye0HaSLTj61H/QGVP2t253bHjXHklnJgbiYbEl+kA+mZrjPhF
         ViJGpmknwiSHXxhjPMaczv4BpmiHAiB5H5s4MLWGViLoBM4mIVMfPpnuKMh+ZWSESMQA
         A/sy14wdUPUNXQs8bWd24z6xLWrky6HF2xBEOCkJuTCLfd6tbMZerB+6YUKpSeCj22JZ
         24OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXg9ZQjeVU6XNbtblFTtHbzxEDGniDYVil5ieEmroIENGT9gyQa2gHymcyDvKpnnf+u8/RzxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHtuFlOH7kfRFFJyF6VNJcreqxClk1UjkOd858FAz62WKwqZDr
	20cw9Xo664Q1ClVoat3tsR/1boJFYkvXW8rKk7KDS4Keyp311aoSzGjn
X-Gm-Gg: ATEYQzzmuHCO6YFMWHKplb4tbnXX8dO3Yf2vvo/8KO63ehzKfrCk5azADOcsraXoHDp
	M2ysXQmA3UVdN/Vuv+jZmACs6GNkCtfAmePfYGlLQlXIwVBZlIJHnBr8tbU13RT8jvHL7IyA6H/
	tDFCH3vcXEzoNdZMatl0oVgmL31a7NhuVhiao7l7wQ6mYOiUU/LYeseCHLPVPURRd6LjBswiJEm
	iHHuRiVupf40B5ts3pU4fPA3dlERGzPVsNi5IpTg4t51GAlb3G8Y5ohEQF/pe5iuyCbxQrCjO+s
	5rioFag+7z59IgR6ujUsWak3r/bB7w6MBPO+hnbsmhcRDzWom39/bBV3+lXmduLOMcy0+/n6gLO
	dwQODMHfHDKWTzsqaU4Kmgh/gSh4UERQrlObWp9ZsSshDe6DE+TSURSb43AkVR5EHWAPw8AUFEl
	w7kX0iuIAMPWy93qNkh8TQvq+jRhY=
X-Received: by 2002:a17:90b:2e45:b0:341:c964:126c with SMTP id 98e67ed59e1d1-359a6a9faa4mr3568604a91.34.1772675768978;
        Wed, 04 Mar 2026 17:56:08 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d6f0eesm199072a91.15.2026.03.04.17.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:56:07 -0800 (PST)
Date: Thu, 5 Mar 2026 01:56:02 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, Brendan Jackman <jackmanb@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCHv3] selftests: Use ktap helpers for runner.sh
Message-ID: <aajisr9n2pInS7jm@fedora>
References: <20260225010833.11301-1-liuhangbin@gmail.com>
 <DGO2DAIFY07Y.367VMZA7XGT4U@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGO2DAIFY07Y.367VMZA7XGT4U@google.com>
X-Rspamd-Queue-Id: F34B420A0DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264127-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Shuah,

Is there anything else I need to do to move this patch forward?

Thanks
Hangbin
On Wed, Feb 25, 2026 at 01:06:47PM +0000, Brendan Jackman wrote:
> On Wed Feb 25, 2026 at 1:08 AM UTC, Hangbin Liu wrote:
> > Instead of manually writing ktap messages, we should use the formal
> > ktap helpers in runner.sh. Brendan did some work in d9e6269e3303
> > ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> > run_kselftest.sh exit with the correct return value. However, the output
> > does not include the total results, such as how many tests passed or failed.
> >
> > Let’s convert all manually printed messages in runner.sh to use the
> > formal ktap helpers. Here are what I changed:
> >
> >   1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
> >      is the only caller of run_many().
> >   2. In run_kselftest.sh, call run_many() in main process to count the
> >      pass/fail numbers.
> >   3. In run_kselftest.sh, do not generate kselftest_failures_file. Just
> >      use ktap_print_totals to report the result.
> >   4. In runner.sh run_one(), get the return value and use ktap helpers for
> >      all pass/fail reporting. This allows counting pass/fail numbers in the
> >      main process.
> >   5. In runner.sh run_in_netns(), also return the correct rc, so we can
> >      count results during wait.
> >
> > After the change, the printed result looks like:
> >
> >   not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
> >   # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> >
> >   ]# echo $?
> >   1
> >
> > Tested-by: Brendan Jackman <jackmanb@google.com>
> 
> Thanks,
> 
> Reviewed-by: Brendan Jackman <jackmanb@google.com>

