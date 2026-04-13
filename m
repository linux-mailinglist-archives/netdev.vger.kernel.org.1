Return-Path: <netdev+bounces-278066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIRhKjPj3GnBXwkAu9opvQ
	(envelope-from <netdev+bounces-278066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:36:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F33EC084
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 14:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B422430098B1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727539281F;
	Mon, 13 Apr 2026 12:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McPOd93B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0363C3BE3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083760; cv=none; b=nV+f2JhJ+inFAbX7ocAoO4iz+2DTfXIkymilA5OytgcOP8UzH++y0OsZMLJjvhHZd/Pd9PZpUwA8d8pCI+PxulRlpyN2ehYTysZulfyIg40L3cAwjqZnmyKRvLjTJCImdtk5LZ375kYPx3LkBk8QR2kgbHbDfr6oa01ZOsXeqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083760; c=relaxed/simple;
	bh=wSf6VAnTCTO1T0uZGOePk0LYzgJ24D1ML1VNTX2a2OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjXgOJFKr/PY3GUJq56C63GAW0bWWYwmQUSkT4K4L1noXYF/w7zb8v48sXIBH4m4xRbd6WYlI2zVQY4LHiWZlqeJpBMeaGrCsH87sC5CSFRjKYXY/+F4/Z8ge0wYRGO5kyHKTma0XlfFj0lFbDALkz6n7eH8Kp8Te2yrE9w/5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McPOd93B; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d96243c91fso1434227eec.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776083758; x=1776688558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNu4mYE1I6cyCFIALOH7cir6PiU714YUZNoVaspB8QI=;
        b=McPOd93BPHFRGOvFsndutKRXzAv57SlDwW8CBhB2nXRUEg7S5jiwAVD1pphbXhwOZl
         Nc8aQxXgiarxmx7ma3vJzGYoHcyNowoxeRhsGiFtf/YRN8F0SgIomlZ/v04XEyQ00ACp
         dWHadN7+k4qjgqJWXQ/uCUnlSLlNL6GP6PepGh47GS8LExqSDsmYTQBT3pqSDjAPdAX1
         FPnWLK4QXlke2OPJK5KF04tO+Rf3b3t9WFYuOUuAiFwBFFAu1P+hg+UT6gd16blMjgfo
         /aKkW6MnmO/HkpqVcmftw8WERL4l21DsmpaTj+UQclX5InOaiOGm4dHgbcBmoRE+Skw5
         D2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083758; x=1776688558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNu4mYE1I6cyCFIALOH7cir6PiU714YUZNoVaspB8QI=;
        b=AQIxjZ48kcv37KZEUU1D5rovjGEZOXZlwa3/SQaXQ6VHp6ldJhxp+hi5mMYMJEvpTO
         +/uQXo2DBeB5WrMbII7XxECHYF89QLM48pbWfrLN4LQJM59d9SNQmZfkWqLKo6sahp/7
         y6oT8z7dG/lEh4Iv+LyKd8vQdShEt10nZAVXX+KzbQCbWsnMG2xFkp2Bzq+Cp77BcEKz
         lvv5DXs7RNZwG6xVVTYqFTxzAEKISiiKphDRESfxtm1z0WD4YJgB8OdPNIyVtRnX56lF
         WMo9RMSbQyK1DxNb6WJdp+hrilxUT1FJZJilSlIGEss84gDtmhTQ7Kz73QedGYCUSlP9
         qiMw==
X-Gm-Message-State: AOJu0Yz+nHJfs13GZidBQERms8ycJ+7N2y1pDgFdSpynHDMRbVbtjTGS
	IXgtIm/CeuQwkxctQYfy1L8zCRfdRdw+V/YCMB+wqMQnybR9V8Rj3YXrfvgjvQ==
X-Gm-Gg: AeBDies+BB76ZR4w0gSGcAyi4TH5/Oo+G6nmyjlGP7pwHTS/KhM2EMrQUM9T5JHdOl+
	U4qbL7vFTJQcDG2sIbPQCdzsw6rtLc/kQEA63YsfiZu5kcwNAV1oHiGQAXIh88VU5qJEbSsWd5m
	ZSfIY/aCcmFe+xWcUxdzhTjwBQtrI2pRsTdC4BxGaG7mMJm9aktAoOKfhz78E6Pwi7aY77OpHa9
	hU89NgcOvC8wQtzFfT9mPFJvFNiXz19bVaUOHIqqVuAJKWumSw/5CxHjHUI5O0bnsK4bKdMoya8
	u1xDcb7QjMk+Ko1vwBDQaYi+mvCutakb/6Mvq3fsLR707+SjfxUz5CTOXTJP1/km4LIaCRigYRn
	lYWUEhnZgHcsrsiv58XZ0HuG/q/fjxHYuqmpoqlFf9mUEQJkTrrKSUV1iqte1yEyfOLiDekQ0ng
	FhR8u8NPrFt8P8d+s/MVTWmTOrXbYbk3FIr2A5SA==
X-Received: by 2002:a05:7300:3247:b0:2c7:2c0b:f33b with SMTP id 5a478bee46e88-2d5899a3bafmr7369419eec.20.1776083757600;
        Mon, 13 Apr 2026 05:35:57 -0700 (PDT)
Received: from t14s.localdomain ([177.37.143.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d851e5bb3csm7691505eec.1.2026.04.13.05.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:35:57 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 4A4C613FAC00; Mon, 13 Apr 2026 09:35:54 -0300 (-03)
Date: Mon, 13 Apr 2026 09:35:54 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Yi Chen <yiche@redhat.com>
Subject: Re: [PATCH net 1/2] netfilter: skip recording stale or retransmitted
 INIT
Message-ID: <adzjKiDngz_DiJqD@t14s.localdomain>
References: <cover.1775847557.git.lucien.xin@gmail.com>
 <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278066-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marceloleitner@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,t14s.localdomain:mid]
X-Rspamd-Queue-Id: 4B4F33EC084
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:59:16PM -0400, Xin Long wrote:
> An INIT whose init_tag matches the peer's vtag does not provide new state
> information. It indicates either:
> 
> - a stale INIT (after INIT-ACK has already been seen on the same side), or
> - a retransmitted INIT (after INIT has already been recorded on the same
>   side).
> 
> In both cases, the INIT must not update ct->proto.sctp.init[] state, since
> it does not advance the handshake tracking and may otherwise corrupt
> INIT/INIT-ACK validation logic.
> 
> Allow INIT processing only when the conntrack entry is newly created
> (SCTP_CONNTRACK_NONE), or when the init_tag differs from the stored peer
> vtag.
> 
> Note it skips the check for the ct with old_state SCTP_CONNTRACK_NONE in
> nf_conntrack_sctp_packet(), as it is just created in sctp_new() where it
> set ct->proto.sctp.vtag[IP_CT_DIR_REPLY] = ih->init_tag.
> 
> Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

