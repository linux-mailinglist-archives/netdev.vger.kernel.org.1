Return-Path: <netdev+bounces-303435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PcKXMZ5zRGoRvAoAu9opvQ
	(envelope-from <netdev+bounces-303435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB9D6E920C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 03:55:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=s84JHP5B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303435-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303435-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D83413012763
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 01:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F313612F4;
	Wed,  1 Jul 2026 01:55:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A5312803
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 01:55:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870909; cv=none; b=Ze5ocZhGc6jPCJhNH/L2X69XomY/FvvoTv5xrvjADSGEs0+9UjBHuz4HEPQD/lo/YfmoIxVwe8+j6/mQHvxiMD9/Mt0mXTEeMaKg6cl2CnJHFxwLLmbEl7WrxwhOeNLkDES8ZD28u/vt4Af8ehTC2pfwxQbHhOebOJCNmHHJPWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870909; c=relaxed/simple;
	bh=mHEBBP/KXteyO6IVeGK/C2idhxEocIMuY5ZMjxuEpKM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCaTIrmLwDk48mTxEYG+okpquJ8Fycibh1Bg/8oKEYaftEoQ1flx1kyf5MA9PJpw+DyJ+smgKS9zMakygyurEayh9e/P3s1hN3XdCCfsBvp6g1OH6wRWV33iG6VExYy5X/hC8vDId+hsv1cFFi+pYrnLOc6xsgnuoEPM7hf/zCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=s84JHP5B; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30bc871ecdfso204992eec.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782870907; x=1783475707; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QO3aOW4H/4F5gl6xB/4I/6DGAJwcp3oGlNdm7Xpql6U=;
        b=s84JHP5B6wjXoevQD0bH7uG8tarxdh4P/nt/sYuU+ais6DXSG7V4wjE8BDpLAGqpPl
         nfvneG6CP/O23zJps5IrlwyObNGmduGoGb6ImnTf+y6e4NZNFffFzlG+AxXfeg588cWO
         qOqmbPQyopL/WBp/bw6IJ6z03YLm+XPbhOoLcRUN4cFuwCdJcf3SUaULsL/DUH/j9JBg
         mQDDL2acHiQcSB1HnKDM3xy7S1qSfdYTYYD/oYO1pgk3YPLryPKBDbWB7eYAmwotbbct
         gN13MpTlBML7zsetE36DjmmWyI+Lg4RmJE2z5RlWzhMCCZW5Z0F6ObIXm3Uj1TE9NMsc
         gVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782870907; x=1783475707;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QO3aOW4H/4F5gl6xB/4I/6DGAJwcp3oGlNdm7Xpql6U=;
        b=lOzucRAp8zvRKi05n1OZxZw22NprFPclpMD9cv6EoPAeRN5h2AbkR/40JTr+172WmU
         DU08uHEKAZuCnZkXlmDujbkpGBv2tf4ju2+bWaAe6yXW4hPVRZpLyBe4HfOsNILnLsCi
         8ap8XPxAQYKnrGbSRwY/6JZ7oJpWFq4sYkmg2aPSvhOTETLtLgdtc1bS5IVSpvav8rBl
         9g8xjzM3hme74MktN03NxFdwrEakelWbi8wmaGQcPUxDSCu22HMNY+Wcof/g1HAYLQQZ
         RK7E4Dot0iGOVS9qiRn7toiXcjTx91BzLMQ60+W4M3kagAUHVjHuwP6psdB/hMu9m05n
         C9hQ==
X-Forwarded-Encrypted: i=1; AHgh+RoftBYAiptgT0SdwsyD9jjFPQa9t/hW2SmfexHvdxdanoH6mbtlWG1F9BesLS4IztWx+Y1XKBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQ3mq2huF7G0QI6rUEieWnmuHAHoH4+Nvp3TZpf9IwZx8y3SF
	1ogFBsBW7ycEwSh71vT2tq26PhXbyI3lTw4Ptxs/lZkLwNcZ9aBPg/qKgXZfSNcY2BE=
X-Gm-Gg: AfdE7cls/bjyV9ZSWyW1I6EOyi9Mb44Uvq4tu0xowuREhTUl50/t3B8yOe25eBtWv3O
	5nRSgGq5UpLPWNML+kFXMeVG3PRQzsMCqx2Pl9GJy2brkTBjIIhp9HXDt2TQ6egDoiJQcSgpvdd
	ck6zqMehS8Eupi/UdZX97mkeTuPArGVarlf+w4raH/5ysHqLWI3e8268dYnEy5Gk6Dy1PcYyido
	vWYK7Vuk1dUfqIOFeQMNGMxFJ0e58U5dAm2vGvR6FErKiL4ZoIZYJMiovS0wdbQyekOI2gyizy6
	eCyTuVLhqhspUdVQ8kyaIKj5WZws3zuDvnZRnsZidIqtDcqgCDotcQEkdNj4cPFnx9/DVG/UL7b
	N4UK58VM1u9C0cy6oMM88UE923n8db4/6h+6BEma6k54qq7dmg872tOtFIYCyCieliB3SLEUFMe
	w2L46yQyvC2ndDzxXGc+rB5J+E5zpwsJeBzh8vvoVyiV/E8wtcmvH2WQ==
X-Received: by 2002:a05:693c:41d3:20b0:30e:e6d0:e306 with SMTP id 5a478bee46e88-30ee6d0eb34mr2759962eec.5.1782870906815;
        Tue, 30 Jun 2026 18:55:06 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3170ee7sm12527351eec.14.2026.06.30.18.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 18:55:06 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:55:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: kuniyu@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] ss: stop displaying dccp sockets
Message-ID: <20260630185503.41541ebf@phoenix.local>
In-Reply-To: <20260630114121.26430-1-laoar.shao@gmail.com>
References: <20260630114121.26430-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303435-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:laoar.shao@gmail.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:laoarshao@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,phoenix.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFB9D6E920C

On Tue, 30 Jun 2026 19:41:21 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> DCCP support was retired in kernel commit 2a63dd0edf38 ("net: Retire
> DCCP socket."). However, ss still attempts to query DCCP sockets via
> netlink, which triggers repeated SELinux warnings in dmesg:
> 
>   SELinux: unrecognized netlink message: protocol=4 nlmsg_type=19 \
>     sclass=netlink_tcpdiag_socket pid=188945 comm=ss
> 
> Stop sending DCCPDIAG_GETSOCK netlink messages to suppress these
> warnings and align ss with the kernel change.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> ---

Please just completely purge dccp. Remove all vestiages from usage and man page.
Leave no ghosts behind. We purged decnet in the past. 

