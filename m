Return-Path: <netdev+bounces-266298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCCSEJFosGloigIAu9opvQ
	(envelope-from <netdev+bounces-266298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:53:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1865256B4E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 696003091087
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F14F3AF658;
	Tue, 10 Mar 2026 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOY2KNWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625F3B8BA9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168737; cv=none; b=lRK8ZZa1M7WlEPL/7TQmTeVQgyNRDQN5rl+uYZmuf3k+F7XtUatJaKCtOoDzvbAHMVH2RRXQkpH3AUZIlI5bj3LumOAyTOR/0mv74reWAo0vhg0kFGagl+t3d/ICvNt+AqDhFQKvGNPXgsFV/8Mr094a0wnNCcgp3bTWgn+n9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168737; c=relaxed/simple;
	bh=cb5vktLgb8+u8LhhDYTc4ioGL2nlsTLIl/ZZClDfKsM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ulq7/LH74r89HU9qvIiIL6+SDvQH/QXTjCGiD0wk+NVAW/Z3Zf6jH0JzqmBbVK4wZ5k+9q4awjhDcw80/KRJ6hRuuLbXCv8plfPseV5GvH8RL0/QtLbR7Az+sqMXd320V/HLG3jThu3DDEE1TJ4gcOx7tc/mRupvm7fF+WHg9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOY2KNWv; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be27fa54feso11407517eec.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168734; x=1773773534; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cb5vktLgb8+u8LhhDYTc4ioGL2nlsTLIl/ZZClDfKsM=;
        b=DOY2KNWvcHQHytzw6Y4QAMtTweRRjfaQCmy3C3eTjzVShGj3EV5Qsv4UbzAgprPmM4
         RCd6i4n0/ViHK/FDxltfb0VBT7+nxhbuk2cdcpWZGNlNaFBnSN9vXdVUl4lgJZ2Ay1sN
         MbFalp+d4M6b5eT4fA1tmP0CVqW/aGeK36l6ZROv4kfcaWS4jS9uy5YLnTnhJLBYwSGz
         39tNFL4ZaKpOnWO2haSeW8m8vASnnvsqEbBDu6+XQKfg0lBTFztz6XgQVy0UKkbFSNnn
         wpFeQx3r2px1p5MI/o1fjyCQIgdawfpQUei20cYYQHHdHb6JMC7+70468GH0V1ILcLA7
         +rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168734; x=1773773534;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cb5vktLgb8+u8LhhDYTc4ioGL2nlsTLIl/ZZClDfKsM=;
        b=vqqrS0aSXWRwKn6zPq3fMDFhvafLRVfy5iZCmyv16Sa6M6jCf6xETi+LSYejo1nZuc
         U2hHQ7v24G9uzp8t4u5igOMtclwZD3FH1l/PEIJSQ5Sv7tvOcN4xqO8Wh8wkd2ERyM0O
         LFbHhtnJWmgTsDuKcA7RMuMyFj4JkXUjc8fLRBhrBhFemWWHGkkD0RqI9Xl9JglRgkS9
         VU7VUtr3sNobcIlrH2Hctyn8GxecQghTstwf1gn2OS/EVLxmcHK6M5f9Bze6sayatdBs
         btV5+sd6F93WHMFw75Q8yQ7sgD9Xr1ziu/aTsXJR/D0bU7vVCKKWzxwQCWWG7iSOQQgJ
         KEWA==
X-Forwarded-Encrypted: i=1; AJvYcCVdqcq48Zjq6Uvo89w4V+u2N/x/9JeJq5reLR1hlTHxJqFS2oMxYTYiQJiAZYfnnyvrZ/eaCT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHXgiSVpPgLJ4m6gT3gZIta3JFvSz7MVsnxDSzTqZ28xRKluuC
	WGsTunrGrNPxbad3Z9DJ40gO6shx/5YlYerqRQGwJRqUyAhUDJ49bUl6
X-Gm-Gg: ATEYQzw2Zw9B6oJRKWvaoOh3Q0nL9LCxNbVDYaVKZx8p7LCUcT1C42XLAzczIJn29ev
	GdIjB301G4yhJ8ldqH7VMqfuEcev9SqREThGCykm/br2WeQschjZqEe22iN4NFSpyKmfscmTq89
	GOOW3P5oJHEgZ0O+u+MgiQuV7vSBInqSd1xjU104aRk6wbOajTIRY8tnuhhD3iqv1SXyfwcFhqs
	IUz0xVbg8SgehOCWiwTAlLjYVhDMTHMhOtOUQ72oyVfLdjAojteYOVTY2hbA9XCyzHL/nT1sJ62
	H44YVioe1KGHqBmLZ6FNbLKN3WFOuAyrbxcjvRRr1IHqODBHMe+c/oH5Yd/rje1ASjWKIkkrfmE
	mq80BU9ImlTFrBW/EM6QzGm2L3s3MbU0wfEvgMknN1ZwBE0EoEoXDp771KIi/SNASyiND6qenSV
	H9YzR9xcQo0AZBmkbbtlJr3rP127yQjeoH825aamEqLItWrqqhIY854IcjGZTAgmTVhY0QgwNUc
	Rp5wv8Q
X-Received: by 2002:a05:7300:a985:b0:2be:10a6:647e with SMTP id 5a478bee46e88-2be4e055786mr6302882eec.19.1773168733632;
        Tue, 10 Mar 2026 11:52:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9dd5:5c94:8add:da1f? ([2620:10d:c090:500::1:641b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94823esm15789597eec.20.2026.03.10.11.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:52:13 -0700 (PDT)
Message-ID: <979c7539ac475b3c428f609066e947844b6dd8b0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types
 via SCALAR_VALUE for trampolines
From: Eduard Zingerman <eddyz87@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	davem@davemloft.net, edumazet@google.com,
 haoluo@google.com, horms@kernel.org, 	john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev,
 netdev@vger.kernel.org, 	pabeni@redhat.com, sdf@fomichev.me,
 shuah@kernel.org, song@kernel.org, 	yonghong.song@linux.dev
Date: Tue, 10 Mar 2026 11:52:10 -0700
In-Reply-To: <20260310121659.25801-1-slava.imameev@crowdstrike.com>
References: <c4f4e99f83a98179c3413dd7afe5e7e73a98e4d3.camel@gmail.com>
	 <20260310121659.25801-1-slava.imameev@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: A1865256B4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,gmail.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-10 at 23:16 +1100, Slava Imameev wrote:

[...]

> I verified whether PTR->FUNC, PTR->DATASEC, PTR->VAR can be passed to
> btf_ctx_access() in the current mainline.
>=20
> I added helpers that inject PTR->FUNC, PTR->DATASEC, PTR->VAR as pre or
> post calls to btf_check_meta(). In all cases, the BPF program load
> failed with errors "arg0 type FUNC / DATASEC / VAR is not a struct",
> which indicates that btf_check_meta() can indeed be called with
> PTR->FUNC, PTR->DATASEC, PTR->VAR.
>=20
> If the condition for pointer check is changed to
> `if (!btf_type_is_struct_ptr(btf, t))`, these BPF programs will load
> successfully with arguments set to scalar().
>=20
> Do we accept this change in behavior?

Kernel validates BTF before loading, see kernel/bpf/btf.c:btf_resolve().
Validation is applied to kernel, module and program-level BTF.
Does BTF containing PTR->DATASEC and PTR->VAR pass validation?
If it does, validation should be updated to reject such cases.
For PTR->FUNC, which one is legit PTR->FUNC or PTR->FUNC_PROTO?
The legit one should be allowed and invalid should be rejected
at validation phase.

You can craft invalid BTF as in the following selftest:
tools/testing/selftests/bpf/prog_tests/btf.c.

[...]

