Return-Path: <netdev+bounces-270430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PxuBl7/wGmiPQQAu9opvQ
	(envelope-from <netdev+bounces-270430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:52:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B70432EE7C4
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 484D9300BBBD
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAAB37F8B1;
	Mon, 23 Mar 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="IBjQ9zI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4A37E308
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255949; cv=none; b=gJNBoJIVN26CHEabH2UNxR1vnYnnUKg2bjfwB8E2a0eO5uCYej9YgnU0vL/abqDxcoxhjeWA9eMPPw56uZSU4KHWf3LMFWTyof+/axN8y4CMsh7l4Bpb4TjaAjelMcwv6W4s5KuK76bHAjIPLcFyGkbFXEIpD3O3keSLmts+P9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255949; c=relaxed/simple;
	bh=9v1HMebiUFD7NqApnl09itbULrmS3JgtmdGF7k1A8x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II3ArO90i0zplJa4J8o4rB1msJpuaG/Da8jurqI/CBAY/PUqq3sZkh/nit+0AIDufcX7X4vYrkKOmxir05mpfBIOKoXKMmH77n8LsDrZny/gsn1ZqzHulf1zIWtRbfnlcrPFmjQh4gGmWhnMsJ+/L1lsLPGWQ46WraiN4PGG3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=IBjQ9zI8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c6fc2910so2871650f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774255945; x=1774860745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GqKpzbuA/S+8i7zqfBIIbpWVnTVfMXFfrKGWqBVGMaM=;
        b=IBjQ9zI8aqOg2v/jDeBp5lZnoAPYyxhgq7JlYdBewy9SiDw+Vh61g6gwbWpPpSRr3h
         aJRqGU6GRkQWp8w4lomlL/XYYBUx8k4mSw2QEUUUvZHadi1IcZB2qTGuM25HMQsmS/MN
         zmUUMdt1ArEBL6m2NYDgByDo5ECeFb4UO/c1ZTdWrJspld8VqEZSd72CL7ag1Dn/+o0l
         9FEYHYERKqmXbtFYmo6+phnsuOd9seo/dEfOA6jiDR97wulcSEu5zxBox/+rJo62IqaN
         3PxvjBRqgMW6jw/rCYt6/D9ZPoCXUOpyruUzopfNmhBzI0mgbMbuFczjXei67FEyCoVt
         1c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774255945; x=1774860745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqKpzbuA/S+8i7zqfBIIbpWVnTVfMXFfrKGWqBVGMaM=;
        b=DQ1RlisOBKt9S9RgCO2GjzFIiVjMTcGaRXQqkBpzNLJLN2jUPvJcrjb3yST0hvJuuu
         BnHdaNseYwJnyEOwlo608xbg15rVaWBWmn9r7ToNYYRJFYUZOypoKtvrG7FsV6AM7pvY
         GNalJGF93AMBCvuhITu6HdSzM2RxjZdomUOkQS+K26o6b0zkpy0K3Wy7ASfe+S3vsa6U
         3OYt9LoKsZazZyTNgtNampwIDPwEduen78vLkQvATjum+4MqJPRj3aQFoUZ4RB5XALgF
         hobn4HD4A3qtylI9xBABC4G3g+9VhMgC0aHhAgerQlONCK4HPQFS87Hrf4EkVbhS2KZv
         0Ubw==
X-Forwarded-Encrypted: i=1; AJvYcCX6fTmWzimxBAbSaWRgo+sKyuaLpoVh4vPbf7R++zE/LBVZghre7T0Lb2UPmPwxHcZX8Q/M2cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFq1J72AqfparkldPNWYfOfAk6W/AGFVJsitUYf0UueoVTOJZ
	A6whPpPzaSpfjWKuLrKULGqlp2onA9exQPCgshMc0fEF7qE/OixlXAjRHeqLIZ0+YuI=
X-Gm-Gg: ATEYQzy3dkQhWc1lrMHYOftd+rtvZKEY4ck9AtQ3GlgWF2SvemZCXuFBu/ngOWiYEUT
	Z3+NevRbDnVZyqSlTXVcZ3/JUvv0PdbDOV6X7SbOI2wsbf5Rz3rpYMqDUxwPK0McldWOS8XU5B8
	ZrmAaTrFMAbJPo8fmO5mNIx+ieKdB2e0p/4jy4fpY3+GkQpiGS1dcVriJhzgITbgJocxoWyyrac
	UvHNobYpnHxxRm2avKiS0/ewspnqMfn49FC+dpGZb4H43SXMFkNruDByoifXYmpVdVPvaChpJNd
	CXxbiip8qKxGJGknJxQEGUxAX5Erm1PpAFg425VYWmtWTPlksJbu5b6G5KzElQprgyVS+MJo1zC
	JJPwIvq0dEG0y5q4HJcP5LGGXMv95DrN/SlHPjWAz7jsmeodBPE9dOw291qyZkMliImXKi3KU5G
	O59el2fJkeyFXjM/eTnPFMQpqm3uRaVv4uUnB72/OZbww8Mg==
X-Received: by 2002:a05:6000:2302:b0:43b:4312:2ca6 with SMTP id ffacd0b85a97d-43b64242f2cmr18936468f8f.2.1774255945122;
        Mon, 23 Mar 2026 01:52:25 -0700 (PDT)
Received: from localhost (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43b6471a27csm29774775f8f.36.2026.03.23.01.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:52:24 -0700 (PDT)
Date: Mon, 23 Mar 2026 10:52:23 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: sunichi <sunyiqixm@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
	gnault@redhat.com, leitao@debian.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mpls: fix missing NULL check in
 mpls_valid_fib_dump_req
Message-ID: <acD_RwWEHSO0HGrg@debil>
References: <20260323071515.1945612-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323071515.1945612-1-sunyiqixm@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[blackwall.org];
	TAGGED_FROM(0.00)[bounces-270430-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B70432EE7C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 03:15:15PM +0800, sunichi wrote:
> The attribute tb[RTA_OIF] is dereferenced without verifying if it is NULL.
> If this attribute is missing in the user netlink message, it will cause a
> NULL pointer dereference and kernel panic.
> 
> Add the necessary check before using the pointer to prevent the crash.
> 
> Signed-off-by: sunichi <sunyiqixm@gmail.com>
> ---
>  net/mpls/af_mpls.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index d5417688f69e..28bbea30aae3 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2174,6 +2174,8 @@ static int mpls_valid_fib_dump_req(struct net *net, const struct nlmsghdr *nlh,
>  		int ifindex;
>  
>  		if (i == RTA_OIF) {
> +			if (!tb[i])
> +				return -EINVAL;
>  			ifindex = nla_get_u32(tb[i]);
>  			filter->dev = dev_get_by_index_rcu(net, ifindex);
>  			if (!filter->dev)
> -- 
> 2.34.1
> 

Why necessary ? Did you actually test and see any problem?

RTA_OIF is parsed as NLA_U32 according to rtm_mpls_policy and
nla_for_each_attr walks over all attributes in the msg which
means it is set and we must have at least that many bytes
available for the attribute. So how can it be NULL?

