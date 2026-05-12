Return-Path: <netdev+bounces-287127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCSbKG4lA2oF1AEAu9opvQ
	(envelope-from <netdev+bounces-287127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:04:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DE0520A3D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF2EF307DD29
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73D03998BA;
	Tue, 12 May 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M34P+bsd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9737DABD;
	Tue, 12 May 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778590545; cv=none; b=GzYGHKAKmcmzkTlLCMchiSNXeOStmK2h7pyqgl9XS4epFsPunjYPilTEoiSkvTfyqDfm8vwGQCrvrauifFuvCb9PQwX4Y7uOYTAHVQYuZCYAFL+G/CkXQiiIG0KyyKSdxcywUA+SwfuyJ6MQ1xrqivJ7DgJMmOZqJS8VPlsYldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778590545; c=relaxed/simple;
	bh=ZvwjfapDGQuaKnbU2z81fKasUux7FpZEIpj17ocGyPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NQKfionHSAOmMwBy4oa4DCttXowZlUptGYUCUHqgrDGqTlYLmk2n6G53sZqohlPqvPCcSVjSjYwOSCGJ+8DzjTdTLTq1IGL1Yh2X3e5bO7JTQvQ3nLjOgky9S4nYYTVjT5basejDLsvQxe87RMRjcjm3CPQhncslF1f2kqmo37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M34P+bsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FC3C2BCB0;
	Tue, 12 May 2026 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778590545;
	bh=ZvwjfapDGQuaKnbU2z81fKasUux7FpZEIpj17ocGyPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M34P+bsdqO/3fLNPyq4i4tSWPYBBmwuVLGuDwQzoqYDIl0Hz+PlmxYgt/yJPtulP8
	 TXkRHI85kZj3w8QGTQC2sxyB4kz6csqBUw7RJrvnTIKg8aPd32XNcd1N8jie70cGT4
	 36x//6OlD9EH5VxMZGprCqorOhfb0RNM8VdA9oT+DjpFZ0Kp8nHWhoLuevsBbesv09
	 CaRAgyrX0KwxVtxI3C+WwWeytbt/zTAhtWfsP1XvICuCEjeTxlwqbbejgkpcMBJ9TB
	 ZTUREkmRAcH87UB3IlA1Ug9fjiuLl+t5L4x2pVndmB3obGs9X8nFCyWHL7P4sByxIi
	 BLi0WccAc6gBg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, lorenzo@kernel.org,
 hawk@kernel.org, toke@redhat.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH RFC net-next 0/4] xdp: reuse generic skb XDP handling
 for veth
In-Reply-To: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
References: <20260509084858.773921-1-maciej.fijalkowski@intel.com>
Date: Tue, 12 May 2026 14:55:42 +0200
Message-ID: <87ecjgkcs1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 50DE0520A3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287127-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,all.your.base.are.belong.to.us:mid]
X-Rspamd-Action: no action

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

(veth XDP makes me dizzy...)

> In particular, let's discuss:
>
>   - whether MEM_TYPE_PAGE_POOL_OR_SHARED is an acceptable way to describe
>     skb-backed generic XDP memory that may be page_pool-backed after COW
>     or ordinary page-shared memory otherwise;

Let's start with naming! I'd prefer making it more explicit:

    MEM_TYPE_GENERIC_SKB?
    MEM_TYPE_SKB_XDP?
    ...?


Bj=C3=B6rn

