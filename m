Return-Path: <netdev+bounces-260764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJmRBTN6nmkOVgQAu9opvQ
	(envelope-from <netdev+bounces-260764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFADD19194B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 05:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AABEA303C508
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A12BF3D7;
	Wed, 25 Feb 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OBcsrOhc"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E2EAC7;
	Wed, 25 Feb 2026 04:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771993645; cv=none; b=pNCYxbquWGKJinS0C/mszbg/LV3al9cqamih1ZePzRSOX72DGP2jaAATi4hEi/Ql/wbFXa/qEkvVVi6R0LuMU8RiLyBdDWJl3cilZVtLXBpkx2MdLYQ4G+PeFWX3AyHqREPRjRzLO2HnvieM3vni6kRNJuDAmszAe93NmfE6J4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771993645; c=relaxed/simple;
	bh=samdCYikUUZlpJmm235kMC/hKn4iVY8qrYnSS+sYMyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IT+pv7eBsyxYYMFPcIFUQmaCEP9ltZoThexZAkPRI6jdEd9S60xQXfiEaxjZ8RV7UvDGKpaOhA6LdaHz3ocv+S8E4iitAC5I8hCRnxu8KPrS5rw/riINJkz6pMy1Kchl+xI1gV+fyDx8EGs2oGPoYCc13B5DdK6CeTdcOq6Gea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OBcsrOhc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771993636;
	bh=samdCYikUUZlpJmm235kMC/hKn4iVY8qrYnSS+sYMyk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OBcsrOhcYnYwq6FJz45aMLg7RoYdLOw3y0/B4ZstCoX6bcN7zyCe7p58ZYWthTe4I
	 KypipXwUKuGoG6f5ZUWitfiuEd5nIF7uB0c8wsnBvbJBttJ27BWASspOwhw78xxajH
	 GcsI8HUP0DWqJkK2vjLmf68feBjRFCaPtPQhVRaO8pR/ca/2Vls6Chn7wPtnmLvFQU
	 ha3gsQ5urqnZFvXqqHJUmZaVFuyjGmlfk/UBKl7lL1GdgrZfGjIc9XL+GzQtrVLcQe
	 n5MsATP+06Ro1JpBfWWvb4IHrX4NVzjRR/HcQEPUDsd+/bi7xbeAiiWOX4SMKZ54LE
	 XrrsrkMGKSQSQ==
Received: from [192.168.14.220] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 34EEC6024E;
	Wed, 25 Feb 2026 12:27:13 +0800 (AWST)
Message-ID: <f0369598f840015027dda5f94a263db174c03d4b.camel@codeconstruct.com.au>
Subject: Re: [PATCH 22/62] mctp i3c: Fix locking in error paths
From: Matt Johnston <matt@codeconstruct.com.au>
To: Bart Van Assche <bart.vanassche@linux.dev>, Peter Zijlstra
	 <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>, 
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, Christoph
 Hellwig <hch@lst.de>, Steven Rostedt <rostedt@goodmis.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Kees Cook <kees@kernel.org>, Jann Horn
 <jannh@google.com>, Bart Van Assche <bvanassche@acm.org>, Leo Yang
 <Leo-Yang@quantatw.com>, Paolo Abeni <pabeni@redhat.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>,  netdev@vger.kernel.org
Date: Wed, 25 Feb 2026 12:27:12 +0800
In-Reply-To: <20260223220102.2158611-23-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
	 <20260223220102.2158611-23-bart.vanassche@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260764-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFADD19194B
X-Rspamd-Action: no action

Hi Bart,

On Mon, 2026-02-23 at 14:00 -0800, Bart Van Assche wrote:
> From: Bart Van Assche <bvanassche@acm.org>
>=20
> Only unlock mi->lock if it has been locked. This bug has been detected by
> the Clang thread-safety analyzer.

Thanks for the fix.

Acked-by: Matt Johnston <matt@codeconstruct.com.au>

Cheers,
Matt


