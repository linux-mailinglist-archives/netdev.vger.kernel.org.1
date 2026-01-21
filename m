Return-Path: <netdev+bounces-251851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFEMEbe9cGkRZgAAu9opvQ
	(envelope-from <netdev+bounces-251851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:51:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DAB5647F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F37980576
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39236212B;
	Wed, 21 Jan 2026 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QY9dVczl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KghPdHaC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4E3C197D
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 11:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994878; cv=none; b=UYlTniFogKe0WHiaNTz0jO6WOPAnWSv/z+ZwL2BWGDl1SDGFQjcpJ427EGenYQHOsqimx7IeqCF4JBI2yv3WhLcMGNXXDTlKGqz1CH6q3h25egf5U2rP0fci0Wq2MY+0iWtUxyUmco7KmMEKTytBlev14ZQNX9esTenMkWp6DXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994878; c=relaxed/simple;
	bh=4KfWufa2INSxgqNBbnPhLGP3cj58D1iMDqc0wUM0iAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=X7o4VOG1OpsSOUoELtZ4Tc4kdvNCRU4UGqbu2WgI6fxwj7qc+aJHK1suru0h1nDGuQIJQ6BNT9f/TI75EXwuF0nRtDdqoGInnMoyl+PkuxCSZqTn3C540vy9VH5bjsYh5Wg9H+INl1bKsPL9dAgh7HJgAhd8FovAyz5DU+FJxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QY9dVczl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KghPdHaC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768994874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+Lsa1zX6oecf/kqn+LU9amQMEGnzL8MSV7B30zYs6M=;
	b=QY9dVczl1Ju1+A1OqowT5DSbPlwHzbgPrESNENzCopBLZrcwPLWDaI9R2JzyjW/jpXhBpe
	0wNCe3pDaQyI0DmdH+GyTLTOFnMjdshDN92iBR8DAs3wvgLSjlfRp9E6RZBT32D02tQurT
	Ubbj1IAMnh37XcnbXVkjcLahRDS3vG4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-I1fGOW8mOymS0YWddS5lkQ-1; Wed, 21 Jan 2026 06:27:53 -0500
X-MC-Unique: I1fGOW8mOymS0YWddS5lkQ-1
X-Mimecast-MFC-AGG-ID: I1fGOW8mOymS0YWddS5lkQ_1768994872
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4803b4e3b9eso22552395e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768994872; x=1769599672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E+Lsa1zX6oecf/kqn+LU9amQMEGnzL8MSV7B30zYs6M=;
        b=KghPdHaCDRNp8q9itPtf2PILLyCpBg5tI5QZx/ZayitewkReF1whlZZpxeikVtSpY/
         y5G2+KKm0aEAgag8u+vr2HICOK0sgYvCsKTbTRZpaAVBN+fzZZrKKX73JFqZspXyknEN
         vMt7HctIMA8cqC6xXAuJVPBQUxBaUlDAiUHhWI5uv+obQWfoLXkWJzGMrTN0Zc89uhEI
         vumXKOyewoOgr03xfp/R2nreJpfyW6sYW2UDhtOkYE9HIQWCrWDG2yrO7yOQ6u07QmDn
         8ztlhfTxm50ylbZyAXJsE4twbP2L+WXmLyLHGYEArevo72IM8+YTF8rwTB/VfjF/zwdH
         cQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768994872; x=1769599672;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+Lsa1zX6oecf/kqn+LU9amQMEGnzL8MSV7B30zYs6M=;
        b=D9RRqKMtWTblIZe014LxcgCHIswdwG1KQ60FiN2WYsz93LOHOKdSCe1gV8VohXqVbW
         tQTCTPwJ5tZ+DKIUmzye8IX92YHkVId1gu2XxHTl1MPm3fz3wqX8V1S0DpDQbyjTyHOW
         ZxrOSpSHACXZpLVhas4iiriVI3LNfP98Yo9owecDsI6+jnpPPIOV/dtGStXs57gd6xfP
         6fjYQYMH6Temhvdig24LhJXAvIUCvhVOtpjwhLVU8lQawO/Y1PU8qIdodALhdH0DwOfS
         L0ZGktu4NQh4L7+9B8kH/klR+GU/QvOPPFa/YeSgJA38j5QHFYPr7Dsj2I8eygE68FTG
         WgQg==
X-Gm-Message-State: AOJu0YyT+zKIG+8Y75yvUI2xUV/TX3lEy1H0LYsoBAKfkwzhk5owwYaw
	nEWdccN7h1/GjZmMP89YFb7VjLps83u1ji1Msv5oks7UXrKKKHEsO9bsvmuvHEe1Yt5m+YI/ai6
	s1FFoXxAZgkjdpQlq1rZaJeWouyQXE5Om4FrGJqUhf5rcsDfRty8lI7nJgX8Kr09rZg==
X-Gm-Gg: AZuq6aKG7AHZLTINmmAWCklSS4LwRyYyDfJ0xY6yJYuDAa5p2Zyt1R9qyWx2rMqgi5k
	BKGFXjjRhUE3FKdTEoXmgfAQI2dlVg7WgLWpf6q6CDsQHTz95Tjgm/r1mVBDy8HB6OdcGa4O8tN
	+L1sUMgatxCNNwCQPJP4YDkKsWe9QZ5thgmHYn7T4rRLmJV1LbbtzyofNGtekApvldqxyzPm77z
	ybidN5LZtOSEcGzA/HWUSRcDGmtKrVizXJ20Q2Da+VNWioKE1IniKUaSTZQrvEfx6c2U/NYY7sU
	VHZ01fSGEAqsdRimVjwUipdWBUG84Ty0AH+dWr4a2qQn/svhFA8I5+MxM+d/tWjtv7KxdlKGtrC
	IaTJTjdHlt0ha
X-Received: by 2002:a05:600c:811a:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-4801eac0cfcmr198911505e9.13.1768994871988;
        Wed, 21 Jan 2026 03:27:51 -0800 (PST)
X-Received: by 2002:a05:600c:811a:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-4801eac0cfcmr198911205e9.13.1768994871616;
        Wed, 21 Jan 2026 03:27:51 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424a148bsm21295595e9.2.2026.01.21.03.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 03:27:51 -0800 (PST)
Message-ID: <925987de-2685-442b-a185-6ba1230dc6fb@redhat.com>
Date: Wed, 21 Jan 2026 12:27:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug report: CoDel patch
To: =?UTF-8?B?S2FyZWwgxZhlxZlpY2hh?= <karel@u-n.cz>,
 xiyou.wangcong@gmail.com, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <CAN0zt4Mi4NDdUua5HXDexyyvD9naan6CnQV1yB_QT41=aY8LEw@mail.gmail.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAN0zt4Mi4NDdUua5HXDexyyvD9naan6CnQV1yB_QT41=aY8LEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251851-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[u-n.cz,gmail.com,mojatatu.com,resnulli.us];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,netfilter.org:url]
X-Rspamd-Queue-Id: A5DAB5647F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/21/26 12:12 PM, Karel Řeřicha wrote:
> please see
> 
> https://bugzilla.netfilter.org/show_bug.cgi?id=1825
> 
> Apologies for contacting you directly, but it has been a week and
> nobody noticed it. Maybe the wrong place to report?

Indeed the netfilter bugzilla instance is not the best place to report
sched issue. Adding the netdev ML and more people.

/P


