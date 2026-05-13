Return-Path: <netdev+bounces-287666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFaGBTSkBGogMQIAu9opvQ
	(envelope-from <netdev+bounces-287666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:17:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A03536EAD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FD8D3131047
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ECC47D95C;
	Wed, 13 May 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE9QBlWp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229F943C074
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686404; cv=none; b=rDB+wRm0sGUU7pWtX6AE3nqebKUtUpHm5a0VAqrR6opbANYUOWZhs20D8NQo39ufROTA4W3N45Gz9StrFtwnzJ5SbTFfHqW/JB1bAfFlrjsg7we2ZDPZL3sZYT+ixz5ykkH790Bw/b6G7+SOJgbT5cGpZy2dLbCsyqgfpmaKltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686404; c=relaxed/simple;
	bh=ptCC6ECWoq8NwvEdGxDOHxyoOAmU11HMhIDNaeufYn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq2OghVQ2/wX1dhL3AwSHw3mcdV+AyFvlAPVePDvtnrp8DvT1W4S7s/THpLC7CCCuK4dQY/VXQbfUeQcNa38GXuk9G248vyltQQEJFF35vZsbrsC/FElyQOJ19E+B/H63ANSsozXaysFq518pXktFVcDxwQeX5Yo2HjvkZ5+CyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE9QBlWp; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso2851625a12.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686395; x=1779291195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9pfvZX6NILfeGSOJxHfBjON7lRfDPEPyL1FGEyg6nE=;
        b=iE9QBlWp5OQLkejtWY/11Lz8YrrdM/OYTTKVvnKseUkr/lI6vH/bgkErOF6Hq1KZFP
         lDcmgu9s93arsru9+rFQbIulGzqd335bcMAIUoy76udbWQaCSrtd4RDfhb1hZIXJFFut
         UwyOxdJE3i8oG4GMMGqnuFqmMLSycCkuub2/zfTAzWuaQ0/nuGHxlI1s1nYMdaCIcR2p
         xWydnJJmVWwEzDJRtfmh8MUAvYyU5vSAle3sraXh9xxxRvxj3Z0we77JR1hdjmZfv6do
         BOlaxxvVrvcM5wQPC0VN1fcORyTAK7p/A4ejyWQJrpD8tfhO08w5cQJhPdjf0NQRJ+1y
         dWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686395; x=1779291195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9pfvZX6NILfeGSOJxHfBjON7lRfDPEPyL1FGEyg6nE=;
        b=EUP51p+a4nE4IfpO8J4g4yDPTitEdoGdw+r8QfIvB8sX+auyq9/Srq14+p7yyQmR1p
         lYlzsqy6/4OnslF8BJZlAf0hvOSBJ+kYeRfgNXS8vHdGKsJF0wFWnCJ3DKll22dY2d3o
         iAipHEDqp/JnxK9nd4c3jVOH1f3b3caiC/vK9VrvbPYj7swxN/nnG1+o+/jpwagQdT3/
         iYO4FOm9gTPu3v7qrK+vd+j9+PGpaE/qW6ApKMD72HbhMieCEjfnnX4vifXN2Nnc2TGo
         rTlX5SvNSqRpage3PjiD35RBtRtUC2+Rgrnj4uYjbRTdT3JQiZ3YHglP97Nhd9xP6NOJ
         PjOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9eQa3MaC6qfJHmZcTTLv+ZMHJ9oUWKJ3iwTlkT38Ok9mugBlxbmdPM6vddnZBqWq7deZTnhzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/uDecGrOpUWnfvuV4QNTwwgkyygEXpclKmj7vbfYT5bJw2k8Z
	zb6XvxAYAB58xeECKyJrVqolXQ4tQ9F8Za/GxyTOEIBch0443l9Rablc
X-Gm-Gg: Acq92OGctRKn+sHOtDaDowfgaeJFiIV0inzg/zm+FfL4grGa0PAbPTosSSyAni6SInw
	POR2Lxao59IIvaRT0KY2RmBbvS7kexbtnabbXTed0XPJGj57PM2YAdfh+CXNq23eCLXUlgaqVef
	cIehafETopLAZ/HRHBaSvCxTNet6di7vX5aShikAQk77+3j4LVSzJSXJ0Jr5tvCkZDXHztYKVc+
	CIq6dnNmWtpPKCnknHXQC0bpbUdc6F7ZfcguCfbz64oDWaM6zCp2HlX7gM1thHSRZtvWoinMd6e
	Yki0/cDjo/QbM6xrxVMie/Q5CDlSWyAW94uV9jBiekWmilk2GmMXOsk9gDX3RBNGsXtBhqcqhJU
	QYDlyu5dZVOuc3aRjA5Av0J4zcduPGTy36qqOqvU8x21j+PAY++t3u8oyp1kTYO+mOrfFq3GscE
	briq8VEK2OHQXOXY9m
X-Received: by 2002:a05:6a21:6d8f:b0:398:6bb5:54c4 with SMTP id adf61e73a8af0-3af7ee34f61mr4503273637.5.1778686394884;
        Wed, 13 May 2026 08:33:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:55::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82675fb236sm15718164a12.0.2026.05.13.08.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:33:14 -0700 (PDT)
Date: Wed, 13 May 2026 08:33:13 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 5/6] rxrpc: convert to getsockopt_iter
Message-ID: <agSZsZGe_MpQzY0L@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-5-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-5-fe7f0e756fac@debian.org>
X-Rspamd-Queue-Id: B2A03536EAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287666-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,intel.com,fomichev.me,iogearbox.net,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/13, Breno Leitao wrote:
> Convert RxRPC socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

