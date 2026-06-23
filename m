Return-Path: <netdev+bounces-301294-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F18dHsM9OmpT4gcAu9opvQ
	(envelope-from <netdev+bounces-301294-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:03:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B936B5100
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=E5q+yEEd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301294-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301294-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD6E301226A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE76A3C7E13;
	Tue, 23 Jun 2026 08:01:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0B73C7DEB
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 08:01:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782201673; cv=none; b=YxiTO8O2ODaZVawuqBN6cFMoV2WjNpOC6gZYdyZ2fUlGFDCoJ0cp393IHI5xn+HZvu5w+laeUxs2js2U0LI7rexcQWbcI1LH9mbw5Gcoif+CpWzZzUtZ9WAUY3ikL46tvczKjT9g3LqYsEjebyq45C1iaN8IOjQkFsJt6mSFcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782201673; c=relaxed/simple;
	bh=dWiw7xAXVl3BEWFURqU4U1zcYKrwaJqJO88flZd8yhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sndiL5h5ogBID2RjY5tWYYcpLL22j8lcosodBUIiLKkaxNoi47yEGPXfOewVk7EWuAKRUoCnNfDRU5rqFCD7y8AvX/xcwu0xj8ChceB6KtnpoAIF9Br3Y5gPKZ+OX3Q6eYCjl/lJCnaYWb/VSprKZsuAFnpC6pZaTJJQ6MENPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E5q+yEEd; arc=none smtp.client-ip=209.85.208.65
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-697de335c18so387256a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782201671; x=1782806471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0sFKF/thZYYlvAYL1rZr93jnB4PDyGa3rfNNqi/jw0=;
        b=E5q+yEEdZhCE3eBYhE5xKE0IwjtD4+qlV+lvmlGn2MQ/9v8KJmpFQ0IucE2bqxtDVG
         0jLzGiaOXVJDzOlsmbhy5v1gHgItV0M9EMkcGkM8QyKuakth1tfBcVM6L1HMrtJL6cPh
         CPuqQf5xas0gOnhwVYDN9hcoHUNl+USf7/TzZL2tUvdNfegYA+Co2mvdAYiachKYQDF7
         DKPp5L+mAG+gcmGozLiWyHZKnWPhUzRaIJY7NRGVFcEZUg5WTvYzJMSRjnkxLqHtzX5q
         dfoaeHYjFiz4dzf7BKwxrrTWR81SSYqbt9Q3JbDp2rZUqQifuW+277CgBTJZDS0/uSUT
         r53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782201671; x=1782806471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0sFKF/thZYYlvAYL1rZr93jnB4PDyGa3rfNNqi/jw0=;
        b=tOFTQgFm8qmEEtzq53bfpIBJD/kn44iw949PmzSHZBKh+WYGEQCKbzskKMOX7SinBI
         gJxTPhU/Xl8aUjWDuYPZY6l/LLFmZH8nxqmOVDFyhsNqjU5MHp0S42o4b6tD247tfDXh
         XWiGA5GkE5Pv1c7KI4vfa8gwe1Z5BkfN0nWzTaxPo9tYQbP+A9gjpyExzp68cwiG1kxG
         pmaTviYpMtmEZOjjZTNL+my1xz2nC2QOT6NFHvivX0wlK2WJSM6wQwheCiIeLAavOdNQ
         BhJsh2lQc35ADUVdasm8Ih+pi4cLDSzsiUIVrrrWNo13oasbEtGbzgmPosKpTCWFSOlr
         7TJw==
X-Forwarded-Encrypted: i=1; AFNElJ97CPYMvbCW+1fIgRwbsbqpgIAgvDv6N3dTpjVdf9HSSAuUXEGbsWcJPDMbl30vdXCdB9/lZas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WUaYwGEliFcQVZ4sRIBRbP2Vx48x76YCzx7n4icHHSKib+tR
	RX/fOzeLHrVzwF6z3vm/cQenlo/JCTb1dc1GYCcnwpOJBd+y46eGVDz0+0takS4wvlg=
X-Gm-Gg: AfdE7ck9Z9qThpgKcH6P0NevVqzCLSej9g5VOlNP2GNQQ3wnB196U2qVDRblH92oC4J
	eG0VG/DZK689rYgPxP0jM8BK68Cj2sJrUBTHinTipx+8V4aOLT+uhOBf+Fo8ROMLEYL5UE0JSga
	SKsaHWSGXlTMGhW3WMrOon013GkTEmUKD0dVUtGAMkR8cSCzCuhEBzk+L0UXVy6mmGnwGThuFDY
	wALsEiBO6SGzhj9xJjf9R9XzKcHpxH96KaXnBJKbPMSgPwlaDT0dO7cHuLeCYyFvejgLB3DG36t
	fqJvSo4UU/Q/VPKutINECUEFCEqAQnXvZIohJce3zZZxlm6U1432+YdlhmCVWlBHXt3Vtwd+AaO
	HEvtkRfxW+6BLTKeI1/UI145hqq22iwi31NV5degxBx5QgjSp1Bqw27odP6QJuNtLpUF/2VoRTw
	gl3jXxyOuDER/b9VEgb6eDHumwSOmWgjA/5mY=
X-Received: by 2002:a17:907:60cc:b0:c0d:5466:ce4c with SMTP id a640c23a62f3a-c0d5466d9dcmr659024566b.1.1782201669904;
        Tue, 23 Jun 2026 01:01:09 -0700 (PDT)
Received: from u94a (110-28-10-168.adsl.fetnet.net. [110.28.10.168])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9442ea144sm8148221a34.27.2026.06.23.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 01:01:07 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:00:51 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>, stable@vger.kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, mykolal@fb.com, tamird@kernel.org
Subject: Re: [PATCH stable 6.6.y v4 0/4] bpf: linked scalar precision fixes
Message-ID: <ajo7j-XkfwzB-mUA@u94a>
References: <20260621172735.409355-1-jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621172735.409355-1-jt26wzz@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301294-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:jt26wzz@gmail.com,m:stable@vger.kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:mykolal@fb.com,m:tamird@kernel.org,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.com:dkim,suse.com:email,suse.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9B936B5100

On Mon, Jun 22, 2026 at 01:27:31AM +0800, Zhenzhong Wu wrote:
> Hi,
> 
> This v4 targets 6.6.y and keeps the v3 backport strategy: use the full
> upstream linked-scalar precision-tracking series, instead of the earlier
> d028f87517d6/9e314f5d8682 not-equal refinement backport path.
[...]
> Relevant selftest results on 6.6.y with this v4 backport:
> 
>   test_verifier:
>     788 PASSED, 0 SKIPPED, 0 FAILED
> 
>   test_progs -t verifier_scalar_ids:
>     all 18 verifier_scalar_ids subtests passed

LGTM, thanks!

I can confirm that all flavors of test_progs in BPF selftests are still
passing on x86_64[1] with this patchset applied on top of stable 6.6.
Not sure if stable gather these tags/trailers, but fwiw

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://github.com/kernel-patches/linux-stable/actions/runs/28008870143/job/82897081824

