Return-Path: <netdev+bounces-298265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V0F7LOb5Kmpn0QMAu9opvQ
	(envelope-from <netdev+bounces-298265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4955D674523
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:09:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=queasysnail.net header.s=fm2 header.b="w tY05MC";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=ej0fXKWl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298265-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298265-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E032932630D4
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA347A0B7;
	Thu, 11 Jun 2026 17:55:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF2E495519;
	Thu, 11 Jun 2026 17:55:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200509; cv=none; b=OpZ+l6sQcrmhu+ZSqU9yrRGOvbcNExw8crreSzQ60rjAdkj6NS1GFK+F5/QspVNA/nMSQa9dW6+4ZKvtAnZelqX4AGESjIqoS1zuF8GYwbZZjX/plGtdkO5XbzXeKlckf3uGRTddjBZyysxwNYtp3uOn1boih1kXSKTQx/bqu7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200509; c=relaxed/simple;
	bh=cPIe7wNGfYJBpQv7Nx1WxLsUuivH06BEc6DUM0fs1uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioSHoCWd0yerXLJlwTujKXM+FFnSAdwg4BCaoap/0u8M/Vv9sWlpr+Fks6OvpdxUi6RUR/H6fpQRuyiPN5FjP8U9vb9bCsvdMj+58u9JVG27CR5dcy/QginlQhaTYbJzyKl+CD6LBQ9tLqWh34uTrf7cc+Yd8hNiOHmFpWp8dTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wtY05MCn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ej0fXKWl; arc=none smtp.client-ip=103.168.172.159
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 321E714000DE;
	Thu, 11 Jun 2026 13:55:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 11 Jun 2026 13:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1781200506; x=
	1781286906; bh=DpDGwYTiEmlVfuPcgxAW8xBcBbXtperaiJP2RjA+kAs=; b=w
	tY05MCnBVVFz4OHn4SQl+8VHQHeRZGaQeAXgjm3djqS/ZxbhlH+HdTD/Lb72zrA7
	jg1wwl245M5WpZVVq/qgM4aOte5A7XLFMWZlUceY0bJFoRUDDaKRxwc9HQISnbN6
	bI1bjvVWv80dsjCf6PUrkQJcwQqsj1NTGfQymY5Nc+wQHCFA6MBdF0ugU8rwhBUA
	iWaVDvVGrJoGkFs3xg4eXrkfI+ecKlIKXPnBnZc1mAy5SKP2V8VJYldXTklMenwh
	6Id2juOtQ+WdTzwP4eU8FEQBKCJex13cy3qrr27lvPNHYf4JLISpVKmQKWLjyBdV
	y7sh7MKk/nAEeFCTst8Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781200506; x=1781286906; bh=DpDGwYTiEmlVfuPcgxAW8xBcBbXtperaiJP
	2RjA+kAs=; b=ej0fXKWlpxe2w29QdmVro99U5e6lZJf6wlPk/RPhyKTboRyGhag
	TPiHJbdyJXuWIFNun+F0FWiMU/5GyjGGPiaEuDcgZioVBElWVwWT6nd4D8HELDGf
	H2H2wqM2NU/QfpL4JsRY8jhMbSSxHjbeB7/jhrWl8vJNq/thieaEVpbPaWXdZUAN
	D1u+IwG+GgqOEnTL/13TbAowdSVLsMw2Vt5h03dd1z/H24EswWkdls/P1fJExypF
	avN/klM4ZRcS/OJ2qEpCGUeLqXykxbWL0NIjo+TswbV1fIxBJTTf+OnrUrNxhhM9
	IajOjeZy2JidsmCLNo8UCcbk/bBbM9ACwUw==
X-ME-Sender: <xms:evYqal5LlrIFzR944YV3uavjl8sgmyLYJUxdw9ZU8JyIg_q5fNuToA>
    <xme:evYqarBcWzv2FfCBkNq9rAfmSk-miFLp9QU_YjEjGvpNHz1jExwEa-zeJT8b-kox9
    KTAZAViwH-p9gt5fajXLk4L_HfIlr6KWhnAh0n-BuytXxrtC7NSPA>
X-ME-Received: <xmr:evYqar-kBTfN14rxKamyyk09_54A4amD3TEKBg9woXLGj7MMeYVBMm0tUL_VQZCrG3vFuuX33K_eeNyGKdchftI>
X-ME-Proxy-Cause: dmFkZTEZNBy54vgAFiR0CArURaTeZox1edOnLO2IBwBO/bGhrb+b+ifUKoNSe0IoToDONM
    OsO9bPI0v3EXXByQMBBW4H2NW93pFXT+2VM3jrDBVmjO4imS0M2JdFcjn7FWGEMU8DNEH+
    ZjG4YI5mgtUq2PK/aoeEb1WNMn+z6ItI/UMWQ9BI0ILzBBeuq0QOFo6G/TauVMq/XpiLW5
    zLiRkMXMfVH/Lo89VaGlJB5Rd905cHteyfpwTTPQ5e4v8mSrITO8UthR63bIYt7llWTcPu
    xiqfx3fQJ63lKAEmvS+7qRTVeieN7dOAw0EuHUPBexmRBmdde6ovZnoof/YKTf6+x6q9p1
    cnwiuXYMi5T1v/fOVxgYG26z1Mn0aMPX1HspUST1EkGM1S212lNVJc8yhxrGo6vg8zlwX1
    eMzfarovW2fOCtWprUG7ODw7bOcPTVDzWL1MX/dnQrWuTlsaPzj1HVhS6TJ+yqwczFvoH4
    7fzEgwR2sYPmig62V48OXJXPneQo3O1lkZbiIT7TLjSd5HtMoGef9YGgGNihRm2kVKFbsk
    DVssucBC0Sr6q/w0tTnuOe99nMyGhZw/C7quXKO4v8gbRjGhJ+OzLj+BjQPsjHkoukcUNr
    TOmT4qPvv4bOEQJetz63F7bEQR5LGyzk7LVbWujBNYNLbg5Z8SMRuNHSnaIg
X-ME-Proxy: <xmx:evYqauE96VMrZpBvncxbdVXbWVQuG6kG4I477GASZwI29tmouleniw>
    <xmx:evYqalSgQ-7qgQ4YUQJN_f15wu9jDeG04_L5PmeHVFbkU0bh5_9rsA>
    <xmx:evYqalRbtD9qw5eaZPVXfnM30sagK9zA1F_7enDJrilRihkeftx5Uw>
    <xmx:evYqao1lMswN6oxBi6Ndyx4rKJIZ7umSYSYUWkb8eMRFNPH-2_Q8lw>
    <xmx:evYqav50_dEkKmnUM67Z9eJGJdFIJF_Nnuiw91Sm9mT2AjPolSLh57LH>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 13:55:05 -0400 (EDT)
Date: Thu, 11 Jun 2026 19:55:03 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	corbet@lwn.net, linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	john.fastabend@gmail.com, skhan@linuxfoundation.org
Subject: Re: [PATCH net-next 2/3] docs: net: tls-offload: document
 tls_dev_del, tls_dev_resync, and rekey
Message-ID: <air2dydoeoNexwfu@krikkit>
References: <20260609201224.1191391-1-kuba@kernel.org>
 <20260609201224.1191391-3-kuba@kernel.org>
 <ainR5GAK8LaHJYMP@krikkit>
 <20260611101817.18964bd9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611101817.18964bd9@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298265-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[krikkit:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:dkim,queasysnail.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4955D674523

2026-06-11, 10:18:17 -0700, Jakub Kicinski wrote:
> On Wed, 10 Jun 2026 23:06:44 +0200 Sabrina Dubroca wrote:
> > > +The third TLS device callback is :c:member:`tls_dev_resync`, called by the core
> > > +to synchronize the TCP stream with the record boundaries:
> > > +
> > > +.. code-block:: c
> > > +
> > > +	int (*tls_dev_resync)(struct net_device *netdev,
> > > +			      struct sock *sk, u32 seq, u8 *rcd_sn,
> > > +			      enum tls_offload_ctx_dir direction);
> > > +
> > > +See the `Resync handling`_ section for details.  
> > 
> > Hmm, this callback is not mentioned at all in the "Resync handling"
> > section. I think it'd be good to add at least a quick note there about
> > how/when it's invoked, and what the arguments mean (at least the two
> > types of sequence numbers, since the rest is identical to the other
> > driver CBs).
> 
> Something like this, you mean?

Yeah, exactly.

-- 
Sabrina

