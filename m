Return-Path: <netdev+bounces-253567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON9rLKWyd2l2kQEAu9opvQ
	(envelope-from <netdev+bounces-253567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:29:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC18C190
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71F32302F435
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5160431B10D;
	Mon, 26 Jan 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQMfWedO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F84F881
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769452173; cv=none; b=i7ZSqUBjthckBWkTyedFlYq61s0XpaabIf/urOD1kU3AsIoZLE7/6o+IN+gyvyjuGqNCnQl0H4+S1z1bEMwITGjdphZ8Isrd22KURnEDACSFqGaQltGgpWgjxaAPYUNbyQzpOGydkE5i4SvNRnHKG/OmYt7HcVd0bwh9DYe2ilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769452173; c=relaxed/simple;
	bh=3H3+yn8WXYu5Gs0lLeCxy5v4rvhbQbhkVfLej3xS36Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7wiwr3fitYa7sueGqCxtN7pfzErJ/5e/BGFcaNEePWMNBz5qCPaO3uHagBzgOQ5Y5CL4S4PiVV3jdwrMfluppc6ZPJ66OvjiOX0BwvBmfOz3X1pfnXgJ6ee3m6VQZBlH2OS1tWa0msBJtA2XEP/qPMPiEQw5xVd93ZDuOQ+WaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQMfWedO; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so27567975e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769452170; x=1770056970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te9h7VpASzTfI4+mQk0zlN73jH3YtGSUKimSiLG8R+E=;
        b=FQMfWedOM1WLoftv/xQyAXq1x9wzT+R5iUm+vt3VNYeDeK+C7eKnQ64/dR4GvabztB
         8Flg4IR4MXQozvxtUQWYYF2OTwsPca6e03MoDdtkoDcrTiSVTWQdcVCwf993Kp28Hnqo
         SjwCB2+8bv90SMZFjwg9PARBI+nLBxf2SEO0KbGETiib0+moI0Q2tvRgiAw0xwln+K9O
         E2HHIdy8JviT1oHVSNNlTiUJTlJGBHbhCnoi8uZ/XZdmachojiIWo4WVkBTUgENj+Fko
         CtZOVwnG+4BHF+oOOmgDov5iDF6IFz/JrPMfPNLkMr6bgsBceC2HAECEc8mYFR6AoKbb
         tUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769452170; x=1770056970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Te9h7VpASzTfI4+mQk0zlN73jH3YtGSUKimSiLG8R+E=;
        b=xONhI96mihd3rWeqydwco5+kYFJrXV72jCuDazIc6F8bVynW64ubkhbQq2FYuvYyA6
         eN0P6GDab6E8uEFzjEaaob1+/iy7ys4V5DtbBmQF+Fz5eqKJtQ7a6bli28HXNHAhM7fY
         DX5y28624USEX8Lf4sZRUCFgDOZH8c0LE+IHoxPss4G/q4DnSbkz1X/E7apoLn64PeY3
         TxSuGjE0gDJaM/glxd188wk8P3TUz8QVUkqo22ssp5hbMaVsVF9uW4QlMLmq+mMILpwe
         Av9hKub1BJXLGFy4zdBhZIQkE6dDsRcXP513izboMQwJkdtQdfKrha/y7AXyFnJ2JtqY
         k/Aw==
X-Gm-Message-State: AOJu0YwalhVv40e85ZnFyR1dgQDcewuS0UB6w3UzhTwroTeL64M1s8cq
	G2GAD8fHdg0f9h5gcbchZram4jZvHtdHUaGonDZ8I1EjOzjvcECfv/cM
X-Gm-Gg: AZuq6aLHfmfDsld88xfklb26/8O0ClpmI5lJFnotOk4bT02cZFzJrd+lrYq4r4Q+el4
	LfXkOSFHbjVi57Css12CaY7lJ/liYposZVpzhxRpAFRO4TdL3i24Dl0TK6Jz7uFb+aFXlBwOJqx
	SiEU4IUN+xOJE644No0o03MPlpRajk5xucMYz6PVZKEZMrKoRwzS7SXqu++Ifn94mI0lb63kxfe
	8IE4jIGz0ddNELcSuj7dPjiAEQNn9dq6Bim2uO+aM9H4slxEm0TzKMlQL6XaaDYjOeIuUmzUwbv
	dOvRT3YKoqjRjWYYjYE4I6YjCGBbcMDN5BgyUsrX049GhXhgxiwJAxpguVHYomCixwcGS8Q05cg
	M1hKDaAbi17qGD2R1ba5bPWQ7EtE4aQeITBpdQmYgCj7kPzsXMVmWzesdN4Iv93CFhExIAqa3J6
	3XCfeeIXqAZKnk10AHv7sqhEsW2FnLkjlTAA8otNsetBrJfJwgsF71
X-Received: by 2002:a05:600c:1d02:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4805cf66b45mr87903825e9.26.1769452169869;
        Mon, 26 Jan 2026 10:29:29 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066be7404sm7185725e9.1.2026.01.26.10.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 10:29:29 -0800 (PST)
Date: Mon, 26 Jan 2026 18:29:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: openvswitch: fix load tearing with
 u64_stats
Message-ID: <20260126182928.39ab1d58@pumpkin>
In-Reply-To: <20260123162159.2877941-5-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
	<20260123162159.2877941-5-mmyangfl@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253567-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55AC18C190
X-Rspamd-Action: no action

On Sat, 24 Jan 2026 00:21:36 +0800
David Yang <mmyangfl@gmail.com> wrote:

> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. struct copying should not be considered
> tear-free. Use u64_stats_reads() instead.

Except that the compiler doesn't ever generate 'tearing accesses' for
aligned 64bit accesses on any 64bit architecture.
Similarly memcpy() won't generate problematic accesses.

The problem is purely theoretical - the C language lets the compiler
split accesses, but it doesn't.

	David

> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  net/openvswitch/datapath.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index d5b6e2002bc1..8ba94df7f942 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -770,7 +770,8 @@ static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
>  
>  		do {
>  			start = u64_stats_fetch_begin(&percpu_stats->syncp);
> -			local_stats = *percpu_stats;
> +			u64_stats_reads(&local_stats, percpu_stats,
> +					sizeof(local_stats));
>  		} while (u64_stats_fetch_retry(&percpu_stats->syncp, start));
>  
>  		stats->n_hit += local_stats.n_hit;


