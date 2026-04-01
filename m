Return-Path: <netdev+bounces-273802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDEGKlFvzGnJSwYAu9opvQ
	(envelope-from <netdev+bounces-273802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:05:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 207A6373582
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6CE43023306
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B6E239E76;
	Wed,  1 Apr 2026 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNZJEJjb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE11E5018
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775005517; cv=none; b=AtEvDtvbrlNoXKBdE5HjbU3P6BywfmpPsp7A8Ajqx4FfSxX4+TZRZjG1EgOxPPvqTuteG/JjC5DI7UUWzsTLjyYwCcbe8uu3QWr71ln7YUf8N1H8IBP+szh8Yu2vZxMhyFwnkYNNMmsfyfwi56ZH6mhz5ce3L9RI5ZS1p9TZit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775005517; c=relaxed/simple;
	bh=CPNTE8tzCVGAOF9o8mcrIX6f6heRWkwKn0jZAUVBrzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfhxAbyWGfBWPkHzwthJySJ8I1sV9z4/SLs6xxQbY623QPfdetK3J8UUZyZrA0nYGnNxvVIguD3LwBFsKgkAxNU9tfLScCsC705zn3rey7eH/PtCFYgkNnu2jXfv0RnQc45f+WrxaP2Ny2sy4O2VdtEy/yrNbmffUl3UvbB6EiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNZJEJjb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso4194210a91.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775005515; x=1775610315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7z1thZP8yYGMiKbnDNmtSPLqeR+cQiCFdf1/ng8Yk70=;
        b=pNZJEJjbrH3rGiXc+ByNjP0fJerKZbdQqmacId6VzwU0f50yW8jOmDzXecE0oLiRtG
         KDQsmTC7futfk3D9FmWUp4is0/zKIHlg17lL4oJHYkPms976XUYb25sibjzPH94HHtDu
         mplQqB4hTA1d7Xol9x3NZCAlMqLD6xpzZPMT/d8ss1qZsQn1nnlv60qVhSWD3/X+kUmo
         DRBUiCnZSQ2hj75Nu98lTMwVfvGMg95f+QRpX8mKy8vEqk5S58yaIjgSotQXtofrNTGW
         FUfWbonLy2U5aT6WK8T5TyfNqboxINsMsRyJYmKA+HDVAy7JT1ZN6tf9pzeNas+KpI6z
         0v6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775005515; x=1775610315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z1thZP8yYGMiKbnDNmtSPLqeR+cQiCFdf1/ng8Yk70=;
        b=mK0bTUMowhTPR5TF3OM914NW91vzOfdF6Z8bCaWrwCjRPaOkXI+JNHgwTiS/OrqelC
         OtEfJKdMNsF+iDpo84KPDDk0l6Omv+XPzKjIDa4exDjgO9GCYNLSMp+NycdsgIjpuGc+
         ZBBjA6J/2rpQ2nN3oPSlmyzvAd7HOHqCzblxRQhHrm5mfCXamlcV0JRbyfa9m8eQwlx7
         kDlu6tPKzM+MRV9KhHeRl0f6ilAAqH+p6qQxI46I89HxuJCRqSJHBaSLo36nzB5cMtlb
         wuPAl3Fftk2bNLpxKKQsnDjDyasHvROZZAFedZ+alKFlvOnAGka1W2IAKHk7lzlezOcc
         +SFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFZYJiLccqtRPT9IbGNqNiycvihBQNmOKsQ7VkZmBlTnPKxXR7oldsjuKLXBzSeg5hwyzCldE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3eBPyV6eSIbOYJvz/M/X4I+lvEPJR4JBxnCinfZvlhg68FsT
	F48xHJQyhiPsZUNZSXH3BKbXyTaFVYZeDYs/BW28AM4OhkprRJQD8VF1
X-Gm-Gg: ATEYQzzJPbR8rfykIM+FA2yDMh8vqkWXapXjpQgus41d/rOv7GelQ1t6/29AShbE7lO
	RaEmVUJNTV6omJNRoB8BoBxCk6/nm5ZW87a5M9nOyx+ZvVejwbh4/vHY6Y74KSMG+p2m5jfRL9J
	p4vvT7j2/DXnadPejFjd6iBIT1MVqokevQSQsOeweK1hdIObhk62f7Pb7t2vqAfBiat6/v3nRYK
	A1rtQpLWKILgKvOy9MZ/IKYtmDL/KxYD4rCbVdazUrnBcE0ENX4cN7/8Cw5AfxasGR5EthywWpc
	Uu1Ut7FaLTS7jNiMGDWZHS6fiFkYtGYYuZTF6ckpv8nstsLmMbQuub1J4Riw5hAXeLj7s6DhYrY
	pPxl/5CxIQnHgaFh9MEw+MgHH0hfZTLmqe7+i1Vv+mCmOIqI50Ezil/u4dpPeln5xfYtpX/hGXw
	tH/RhuYzcIouF3p1EginUBzZK3suE=
X-Received: by 2002:a17:90b:57c6:b0:35d:a542:2dcb with SMTP id 98e67ed59e1d1-35dc6fae2ecmr1289781a91.16.1775005514806;
        Tue, 31 Mar 2026 18:05:14 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e4ba7sm2824076a91.4.2026.03.31.18.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:05:13 -0700 (PDT)
Date: Wed, 1 Apr 2026 01:05:04 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Brendan Jackman <jackmanb@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCHv3] selftests: Use ktap helpers for runner.sh
Message-ID: <acxvQJsySH0NBmB1@fedora>
References: <20260225010833.11301-1-liuhangbin@gmail.com>
 <014b54f0-c4a6-40f2-afd0-0ea3e2f796e4@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <014b54f0-c4a6-40f2-afd0-0ea3e2f796e4@linuxfoundation.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273802-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,run_kselftest.sh:url,runner.sh:url]
X-Rspamd-Queue-Id: 207A6373582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:51:48PM -0600, Shuah Khan wrote:
> On 2/24/26 18:08, Hangbin Liu wrote:
> > Instead of manually writing ktap messages, we should use the formal
> > ktap helpers in runner.sh. Brendan did some work in d9e6269e3303
> > ("selftests/run_kselftest.sh: exit with error if tests fail") to make
> > run_kselftest.sh exit with the correct return value. However, the output
> > does not include the total results, such as how many tests passed or failed.
> > 
> > Let’s convert all manually printed messages in runner.sh to use the
> > formal ktap helpers. Here are what I changed:
> > 
> >    1. Move TAP header from runner.sh to run_kselftest.sh, since run_kselftest.sh
> >       is the only caller of run_many().
> >    2. In run_kselftest.sh, call run_many() in main process to count the
> >       pass/fail numbers.
> >    3. In run_kselftest.sh, do not generate kselftest_failures_file. Just
> >       use ktap_print_totals to report the result.
> >    4. In runner.sh run_one(), get the return value and use ktap helpers for
> >       all pass/fail reporting. This allows counting pass/fail numbers in the
> >       main process.
> >    5. In runner.sh run_in_netns(), also return the correct rc, so we can
> >       count results during wait.
> > 
> > After the change, the printed result looks like:
> > 
> >    not ok 4 4 selftests: clone3: clone3_cap_checkpoint_restore # exit=1
> >    # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> > 
> >    ]# echo $?
> >    1
> > 
> > Tested-by: Brendan Jackman <jackmanb@google.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> > 
> 
> Applied to linux-kselftest next for Linux 7.1-rc1
> 
> I had to fix commit description and long lines in change log.
> In the future make sure to run checkpatch to catch errors
> related to commit descriptions.

Thanks, I will take care of this.

Hangbin
> 
> thanks,
> -- Shuah

