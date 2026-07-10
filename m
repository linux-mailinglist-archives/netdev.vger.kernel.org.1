Return-Path: <netdev+bounces-306395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dz0TM4I5UGoivQIAu9opvQ
	(envelope-from <netdev+bounces-306395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:14:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B220736539
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:14:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lkhYUTgI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306395-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306395-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CC973048DC8
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39144175A72;
	Fri, 10 Jul 2026 00:13:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D5D26AC3
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 00:13:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642423; cv=none; b=qJwLevk+zzDCo0HVVv7Y0paLRan0kJxb2lpW8PfKH4AHKP4MxzLTu+OsbCBfit4qLJlfzToy7/wHoraa/4fOYrnyk6oj7OS3adaPQREzw7pvDoJwP816M+g5n2SQq8bpNwtjXy89oaJzpRNFsIfjSDb8i9CCcOLK9iO4+alf9o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642423; c=relaxed/simple;
	bh=4th0MfbBWLVOtM/cgbbWVwBzlPcMrWjTSb7fkio8tKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln9P0oUI4G01bdbUvFfUCcyPKRuTnanGb5q96jrRaY64CKsGlG5FFZ54c45tBdHvC1PD/pIXZry5CCNV8cIIx6BmfDepdy9ifN/cX6GLzGuv2Tlgc0FnDuJOZIJc8xDkM87HHoI3UUh4HYJukSFE0uSvo2nsJVkLJ0LcJeM7FdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkhYUTgI; arc=none smtp.client-ip=74.125.228.0
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-c888c19b85dso64725a12.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642421; x=1784247221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWBteTvaFd6DcZzmKtdqbpXJSrq03LaitnrbfsJjp7E=;
        b=lkhYUTgIBmOvN7IhDjd3fTW909gPXbjANqTlqWOF5ykPMMw/vaHtc27PhUc8Q4/jtI
         Z4OJhLDZZnjPIMY1sjP/MxufR0kHVL94mrv8/2ZzPPdAC2NVLc4Gej9TQPSpeLodrKxa
         sM0yZCfQq9vX6hawsznB6PrySr6tz0jyTWRFoDPRu6TLAxUI6bAkbMzUWCoUw6Bow20C
         EWJ2efMu3s+E6wcHwN1Y8wHod8buFJN2NbrUOn7YCnyvg6BZ2yUy2BiTWTq+E7JdDH1/
         VOQcMVFxZE5lsvDdqPeb6IwP3YxXdWR3Ind7FWtBJoroyr50aDcNOygsqrt4ZMf9v4Vs
         1Nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642421; x=1784247221;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWBteTvaFd6DcZzmKtdqbpXJSrq03LaitnrbfsJjp7E=;
        b=iTk00z40vpfV/CnjJl4/VI2Y7D8mwHohZDRMorGrFxKgPo8UCY8tI/WR1YXRgCsK/r
         yavPS49wnXgC71H99MkiyS0rCFncvejO5tJvYnCCuYhWD9wICWca6bV70nk7DUFKhD2x
         K6sf42VkojBqdv4r/NRM5ltQVkLZYOH3rAMqTWYFUZRdi94GSZd66rvkkxajKDvx19Pj
         A8wqle9lldQz9nx8yzMonWPA2TMoUGtX6kWtwoWM28RjEmlF33vp0PVmV9X2xo0TXw1E
         BhzU7jt8o1D5GPHiRnS4vtov2l+xMD08YyL8r5XvOio7w57ObKwXpSc7/GcuC7cj3fwz
         iD+Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro0z0N/xzAmEZrGGToj6H0G4RheJ0lfJhD3r4r2XSrwz1C5f089nCd1PZRzmuZhsiMHKJwPGk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/52Jab5ospoaycsYDSW8YqXhvgfyMHdLCh/poJMB5Eesxgc+
	3Zz7bYxBgO2vtPinseg6YZDKMftLAH2E5jBNIwRrBoPf8gllmbFvrVTD
X-Gm-Gg: AfdE7clXUOD+iDnHEkDDn4YjNh5NAbpRuPGDNqRQnOkr8cfhZLO+xgKH48M+qOaO32v
	gfQpzyetMBMCY9uC6U2Y1ARLg6wM+ifDMcB5+0chlILBI2IES+v2fFrTItdTTV4xL2zM0Fbxig0
	HRUHrytZwk+30qousKbpwRu3OcW/ijPsaGtt6jd4Ph2vts+1XVsdcoxmM7yU2I8rZ2O6X20cf/q
	Pl4Et4i0c7amvzoMmRiOqCZaCTT56AMZWuuN5tOW9O+7L+K6Xogj4HxGTRCGxjT3ZAjeZCtE5Yr
	wul/amc9SaYffEBczWcgjgpom++kqyA99W/Hh+O27f5Z/VI3qS3+RUeCJ+RbnMI9FaYyIqnr3+h
	h6Cd+94Ad/6/7hpqNGDYXwFYg91JZM6JyNruq91QTpExx12pK574ApRkvpuepi2na+iEUM+7Xj0
	3OKWQz
X-Received: by 2002:a05:6a00:23c9:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-84842ebbe41mr9174033b3a.4.1783642421290;
        Thu, 09 Jul 2026 17:13:41 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8485413c264sm2278278b3a.61.2026.07.09.17.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:40 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:12:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 3/5] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb IPv6 tests
Message-ID: <alA4-eMg_Fw4a7cV@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-4-mahe.tardy@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306395-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:martin.lau@linux.dev,m:yonghong.song@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:horms@kernel.org,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,jrife.io,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jrife.io:email,devvm7509.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B220736539

On 07/09, Mahe Tardy wrote:
> This test extends the existing cgroup_skb tests with IPv6 support.
> 
> Note that we need to set IPV6_RECVERR on the socket for IPv6 in
> connect_to_fd_nonblock otherwise the error will be ignored even if we
> are in the middle of the TCP handshake. See in
> net/ipv6/datagram.c:ipv6_icmp_error for more details.
> 
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

