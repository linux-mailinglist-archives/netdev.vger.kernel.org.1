Return-Path: <netdev+bounces-303071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YLPXLVmXQ2o/cwoAu9opvQ
	(envelope-from <netdev+bounces-303071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:15:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE7D6E2B3B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:15:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=X4BeYHAO;
	dkim=pass header.d=redhat.com header.s=google header.b="IW16Uj/m";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303071-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303071-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0A33055C02
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844183EB10A;
	Tue, 30 Jun 2026 10:11:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45C201004
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:11:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814289; cv=none; b=ld/NSVNaR327JkWghJrdEhDoykQ4vSJwoxshFXPySTtwdEq45+vNHWY9MwemVrYhKzk6uMlzSdrOhB82NkPN5R2Y6fDAxNEZ+voMt/sXL3pw2m/gGanZAOM28kA1ZnG6ycuaiOqSuh3Jd53jOwTTo1bYxCOOlMuLy7Q2QPl9Sus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814289; c=relaxed/simple;
	bh=S7AI+YFxLu2eH+drottiu3LDKyfzmbZsb6AyqgvPOSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx8H9SboWfOMnM1Rz2+5x7Iq8Hs4jEVCU1zIoe00j2zatHMZxYDcEjl7oyKEg9GFlG1HyIqNSyJpYVem1Ms+ZhBJ7cDQC0KKmxzKt3CSnlVTff81QOEAN+bwBNk4R7LsN5p8f6/Am4ZAC+f8xpOsztCYfCkGtiuzo4wIjGf3u5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4BeYHAO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IW16Uj/m; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782814287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAnQNF/BG2hzcnpQlhZdj2/19/pQbi7MYSIKu9RdeiU=;
	b=X4BeYHAOcGmecbETh3FcjK4VBd/kA5+gl2qdyzESbdnlaKEtF2zD4YBfnMDOJyS2dfcqI5
	K3+vwqwXqEjE+x4UgXYERcWFimAjhKHHgeSysQSC0BAGoCaCEDTq1kx+m+DW4BIadG6p0l
	rxBcjbD4ma/IBWNYd/btDbmnCnGqi58=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Bjnt-I1JOaKfPdyVB_spRw-1; Tue, 30 Jun 2026 06:11:25 -0400
X-MC-Unique: Bjnt-I1JOaKfPdyVB_spRw-1
X-Mimecast-MFC-AGG-ID: Bjnt-I1JOaKfPdyVB_spRw_1782814284
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473bc66c837so1548239f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782814284; x=1783419084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAnQNF/BG2hzcnpQlhZdj2/19/pQbi7MYSIKu9RdeiU=;
        b=IW16Uj/mgrPaWGXQz+65l4gIZRF6EwG1EIpJd6BXfxI/FfoGes+lv4y4NfHYgH9LF1
         AiidRFtKqzxMLz1NuhxSldcOhRYBurXAtaY2Rax3MrfHvWrxvp06kB78lX4jGuyxlCQ4
         lZ1EBOm2xD5IDndlgTISSpqfs5ZRayBNIUBrpqpldLZMLJY8DzhKTac5z9jssHS0TF4w
         /h/3sfUkrh+pmXfvnhhXVClU3oQMKeqCji9Lv1byP9AVMpklbFrtvQ4lBg45KB9nI/JH
         5T0x9mbmAtKlSrvuwyUexnprcF8gfh/2JC7/YZKTHBdvACJoh1WKSDlm/7Sxv969Coum
         sF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814284; x=1783419084;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAnQNF/BG2hzcnpQlhZdj2/19/pQbi7MYSIKu9RdeiU=;
        b=EcrnehyRM5rrH8zckHxeDge6naavvSHWZ3iKo0UP0VUhrkXf9qCWTyBtE/Pp0KbgH5
         b8eoUxapM+ePGoK4o6VIpCMqNw0gEALZLZ+t/icpm09ONYAUKwhgBoHNAeUwQq65eE8o
         3fEQknKR30TaEw83y3aCCNjgH5d4j7FCwf538GEwqRUfK7LA+gUTwNsRMAvqEyEBCOBX
         yC5KZCFOV360noOlCfi7SV4QHUtx3lb81OrTtrUjntmYOgpokHkHp+iV1ZP3pgycn56Z
         c7O+z7EKKiAX0Xq4MgVXGOTfbp5wDOSi9lH2E0gzHCPW1x0CExKoRv2TqIApJzIuOqrr
         0zUA==
X-Gm-Message-State: AOJu0YztueT4MtmEtiE/rApa+EDioyP9AjMgDy3PIDMmruYSWdJWjrzP
	JvsqBh6I4+KzfeLA8vlCe6KyYshdnIvB2SdsqEnz7xoJ4ncqlyvgQUvklB8X5R7+hPqSEm6wgg3
	gqIMlnSLgSMxC2Kz1QvNPWQF8/St7GiBh2xMs3M8z5tM0o5C7fd596nMtUQ==
X-Gm-Gg: AfdE7cllO+sX6TMPe2FpEK0JeJES/gtkMdhu66nivwLAO74FzVsV6Pm/cpTmv2tyRzk
	tHS1aQDOQumYuo1L4F4YstJsw7Z7UJDjy0DUkQBrDQsKOZpeEc3iBvIbSEddshtvR0oOa0uHaTh
	ytzI6JaWvC0H8NGs2rH1Z+DcfGwcnd2f8IycCw18Had6fojGiqIahl0TXbd1V87xFDkAj85w4Gw
	ZAxZINkw7nnyEdgrAvYTP3XQpgNZWJZFJGFS05dkehcPW+K0o/Ot/UhwI3Dc2dGuzp3xjOX5jyo
	Wgdp/EgDiXtI4buREu1aB/s7DKNQZ0s+XhVGmQXMa74cdBlnHpwgAE1YFVe/8SW26K+hpajxODF
	uBdRZ++nUKI3PplkcRvjcjEbs/tlyGTWoI5VKPCRqtOCxm2RlP3hCGsJoGjB/9F+OvgUvV7Jx5+
	fKWjXxc3GzNA==
X-Received: by 2002:a05:6000:25e3:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-47551737cf2mr3519506f8f.14.1782814284140;
        Tue, 30 Jun 2026 03:11:24 -0700 (PDT)
X-Received: by 2002:a05:6000:25e3:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-47551737cf2mr3519449f8f.14.1782814283688;
        Tue, 30 Jun 2026 03:11:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d194b0sm6739249f8f.1.2026.06.30.03.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 03:11:22 -0700 (PDT)
Message-ID: <2a1c4eb4-a4ba-4fc7-9bda-6a7a8d0be2f1@redhat.com>
Date: Tue, 30 Jun 2026 12:11:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: make busywait timeout clock portable
To: Nirmoy Das <nirmoyd@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org
References: <20260626144902.3214350-1-nirmoyd@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260626144902.3214350-1-nirmoyd@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303071-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nirmoyd@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0BE7D6E2B3B

On 6/26/26 4:49 PM, Nirmoy Das wrote:
> loopy_wait() expects millisecond timestamps. However, Ubuntu Resolute
> can use uutils date, where `date -u +%s%3N` returns seconds plus full
> nanoseconds instead of a 3-digit millisecond field. This makes
> busywait expire too early and can make vlan_bridge_binding.sh read a
> stale operstate.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Cc: stable@vger.kernel.org # 6.8+
> Link: https://github.com/uutils/coreutils/issues/11658
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> ---
>  tools/testing/selftests/net/lib.sh | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index b40694573f4c7..fcaec058be6d0 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -70,12 +70,27 @@ ksft_exit_status_merge()
>  		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
>  }
>  
> +timestamp_ms()
> +{
> +	local now=$(date -u +%s:%N)

shellcheck says:

 ^-^ SC2155 (warning): Declare and assign separately to avoid masking
return values.

/P


