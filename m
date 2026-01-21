Return-Path: <netdev+bounces-251686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kACuDIQscGniWwAAu9opvQ
	(envelope-from <netdev+bounces-251686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:31:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAF94F1F8
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1760E7AF5F3
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2D21FF48;
	Wed, 21 Jan 2026 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h50dDHrN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407A20B212
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959097; cv=none; b=JAoq9NBlqoa4fTMOmQefFfQaNSwsXvR+U7WouEkaecJG4IF6pRN/IIEfGFw5wn8P0yeubhzLykD1CHFMrntw8o08ZsPYnEsXvt/hoX7Np4bu9VKkiEsVUidQgNdeykx8dKUVWVmpAkOwd9iJ9J6r/TZw7jVz7R9owiiVtA+KdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959097; c=relaxed/simple;
	bh=dEcCU3CGTGTpN7l/rN2LrkYLiTkUZ0f52QXFuNFvEZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYKFsvwcY8oi2G4OTkR9GR2JrbIaklmzcIgPDpz2znokJuTpnxkvQOFB7hY7eMY3s9lXKYvTcH7VOmuc0UoQosI5vk2HjgwWULo5yaTBhfRWfrdMCGEVPize7RvMUpF3/giJtgps2IprBihYy1+Dx7zexvywk99ew+alx5tEK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h50dDHrN; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7941578064bso5224537b3.2
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768959090; x=1769563890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8iE0KBKIYKbBU2Zh8l50G8fq2WUoVHBO7RlhN61jto=;
        b=h50dDHrNERTJ1JhLzkHKw+qQXwiVbuaQQR89ZbxOVAM/qTicqyHz+TmJptauGGBaPZ
         cCAggqeULVjUU76rRqpnBRdWR4QMjo80ll7nemToQy3qLO6DuUagQlrdWjU0NincmOUH
         CUGqSdo1bZJxWKGKatI5KDK0aYbiufIJWM0QBGiZ/n5L+e2/7u0EWBPvmGCebn2meFvw
         wIWs+f+K5uv71tfkmc64xZBGFvQJhpstftvXfcn6UFTvzAAnwBKCMkwthhdCdhz4Eo3A
         HGhRKe+s0yn1+B0sfkbjkDvmQ/7EIt+01z9dHbvQIEU6qrmkh2JjlHEwoGZ8ed/Ox6Ww
         784w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959090; x=1769563890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8iE0KBKIYKbBU2Zh8l50G8fq2WUoVHBO7RlhN61jto=;
        b=hwEZsjEJ7dXXY1+twUkAdlexrOAzz9BIwjzBA5+SPHhjkHR3GOaJzu89PvysQsx1pV
         BboRzAMWOKcq4IYGjTHBocAGmZOyshOLfNQiEjJEH7+2f5/h1I75eMqAO0LzNQAjypcV
         6Bkn8Gtlii6ljeh/bDM3R8+iE04TqddQv8t1pcsy0BUau92E+jBjBoL1djPewxzfZuem
         pAobRsRwwIr6NDcxgtgX/yplY3X47UgAUumoGmuQr0kqBzgYOkreh2tD31iGmKbx+QlQ
         SfItzIkQqbeD8pUkAIMT4NBd7g9jXrH45uHbBfxbgjTJ1RMBCteVIxk1YYB3KwW/+S+E
         RQpg==
X-Forwarded-Encrypted: i=1; AJvYcCXMKD6WKOoiiz3aYRQ2gji8GHG0Hnn1Jau40r+rd3f0DJHVjg8gux+gQX+WTyGD4zOLl+ELiA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5O2fIWYO7FYU1K/vhhHJtVdHAx+JuYE+4GHwVlD7mjwv6cgi
	VtGvfJcj3PlIXjmj0zOuQZt/l1pseT4XngmXGVC4ZfCiweWczMlhc0M1
X-Gm-Gg: AZuq6aI8T5xbfyVlnF2TwAmJG0AkFr6Afa2AfhpYePELWhoG8pWNF6i9DttB0esddeH
	Obaf8V7oOVrgFmP91sjazlOll/VazyjslUUYxkC8MzN4keDfzODiOjrxnOLBKFsv+LVtSB36xVz
	hTCNPS83+74kkxVzQ7CuAwF8Uf5uLcf+dgxvnAYvh0uQ+bg0KDBu5smX88NgyUKZ/faarAVkGSx
	ByM77gZpRkGVV4Qz3TQV8nwNw2t05YTasfIN0N429cppBtk/NXiMnFUlc5zYpZDcQwzYI/ZvdSV
	9gdsnMKykOqhlGL/zhqp+R2zvoWRT3uH7EUlpHS1VGGQU3SuS3+j9ZE1M77jZHIpS81Krg1sY/Q
	/YjO2C5j6wKxztSl+a+8HUx+7totXDMJNy3ZpZUYyjCOiZdeB6VvFV6Nvs3Eeq9A+VyuGR3ngww
	j9ZQs2nbcXE66No6aWLtgny0k8V1RHp7F1Tw==
X-Received: by 2002:a05:690c:6184:b0:78f:a535:93d4 with SMTP id 00721157ae682-793c52b1e63mr140115457b3.25.1768959089914;
        Tue, 20 Jan 2026 17:31:29 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66ee062sm59397217b3.15.2026.01.20.17.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 17:31:29 -0800 (PST)
Date: Tue, 20 Jan 2026 17:31:27 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: forwarding: cleanup veth peers created
 via NUM_NETIFS
Message-ID: <aXAsb+sCbyeD/xkL@devvm11784.nha0.facebook.com>
References: <20260120230905.328528-1-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120230905.328528-1-aleksey.oladko@virtuozzo.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-251686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,bridge_activity_notify.sh:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 1CAF94F1F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 11:09:05PM +0000, Aleksei Oladko wrote:
> Some net/forwarding kselftests set NUM_NETIFS, causing lib.sh to create
> the requested number of veth peer interfaces.
> 
> These interfaces are not removed when the tests finish, leaving stale
> veth devices in the system. This can cause subsequent tests to fail,
> for example min_max_mtu.sh.
> 
> Ensure that veth peers created via NUM_NETIFS are properly removed at
> the end of the tests to avoid interference between test runs.
> 
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index a9034f0bb58b..ae7699c0c7e5 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -597,6 +597,10 @@ vrf_cleanup()
>  	ip -6 rule del pref 32765
>  	ip -4 rule add pref 0 table local
>  	ip -4 rule del pref 32765
> +
> +	for ((i = 1; i <= NUM_NETIFS; i=$i+2)); do

I'd suggest 'i = i + 2' here instead of "i=$i+2", as it seems closer to the rest of lib.sh
style.

> +		ip link delete dev ${NETIFS[p$i]} 2>/dev/null || true
> +	done
>  }
>  
>  adf_vrf_prepare()
> -- 
> 2.43.0
> 

I see that some tests that set NUM_NETIFS do not seem to call
vrf_cleanup() (e.g. bridge_activity_notify.sh), so I think those tests
will still leak?

Maybe lib.sh needs a remove_netif() to go along with create_netif(), and
then tests can call it from their 'cleanup()' EXIT handlers? This avoids
the mismatch between vrf_prepare() not creating devices but
vrf_cleanup() removing them.

Thanks,
Bobby

