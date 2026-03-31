Return-Path: <netdev+bounces-273534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFqMIDaPy2kuIwYAu9opvQ
	(envelope-from <netdev+bounces-273534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:09:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82654366BEF
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 11:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BFD53028275
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B9F3E95A0;
	Tue, 31 Mar 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGtKGT2r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EB3D8903
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947404; cv=pass; b=I3M4rc76POrUKBJcoW8Sdzp6MHQkTVZlywy/dvKby0BIiwokMiwLQBygxePHvH6QYm/buWNC0+EI4hc4z/6R/NQdxQMc66cJzHtLKGAR90FslYmKyS1G3aeN8JVqTXcArJMhXe4SJ68ZDSib6zXxqBE6XW7q3buXsdi3JAoUrEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947404; c=relaxed/simple;
	bh=8Rd6dD12J+k4M0RPgh3c+Z/bVpfV1NbJVTnDkgOMtLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrpQJMuxQvVRj1v1WDz4R/1lqvNDKCMAjbjcmXCo1JuDwq3dsBx2myf8E6cxKzoEkSsStRY0oc2sFkndyFEuMxZwbmBu8zMjX3OuFXe3mtuqubutk+qkLvstVeTgcUjXzmioUc+flu9ayixgi9dcD2/ne9TjQitYVNr13nVJOdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGtKGT2r; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506aa685d62so29834361cf.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 01:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774947402; cv=none;
        d=google.com; s=arc-20240605;
        b=VhnDpCKoC0zM83Gp2nw8RJBlKPvPUSNzDkz4j1jhAEGLWQsK8rHogcKVmfAXrXccNb
         qUgANZaV6di0e1nYjmycZ5E6WJWB/QSV0eqWIssot/mC5HfqKTvsZILT22Rxecd8BVo5
         9G2OQHvE9EcPt9sf7Ljj6KL8BDLXMbzY4ycS1Jrhl2MKCxVGF191ITvuNigsD3A/rgWv
         ptLeh99W1LYzJqOSmBm/EhrUuiwiaN271yCtYGY2tu4cETKWncrdiXDL5ZBzk6Aj3llC
         tyDigjYgzOMhpIp+GPtJOOnKEdlCc6UxmGwuGTjZmhUXj8rp1sEtoWCbhlFCcXZmP8v6
         y9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Rd6dD12J+k4M0RPgh3c+Z/bVpfV1NbJVTnDkgOMtLc=;
        fh=wkachiSAxiohpfcixc4KRtACo6ZJocrgyEazzciSYPY=;
        b=cIm2MX1oXy9eQj0xUMs1V1J6QCASp2FjqiEcSM+lAWm56sEXMNOP2tv6oNHaD6PbGZ
         uQSNQIiKfcH5fxr6Ou0UxKgO/bMwmIc4jAV7JW/MMivZHKJ2eHznDFxq6CDmVY5mn6jI
         50dsEb3VqU3mVXczz54906qt+oS1eyHZjbxHw12jmLd8C2X6LiOjXtD70siLNg7dJcDy
         +527fEV9X5zM2sbyp4iacNe7ueWbZ6tHmEOn4DaGCapkt4lcHIkNH1e2k4YxXTtWxSgF
         RtdALokURdap5Nne3Fs6t17/ue4tjRtozmc7mevsYZq/odxHb1qBC+e7ISgFR9hN6K8X
         I2fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774947402; x=1775552202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Rd6dD12J+k4M0RPgh3c+Z/bVpfV1NbJVTnDkgOMtLc=;
        b=jGtKGT2rYSz0d54caJfbDoxlwBfnQPZ5CJuHdAJZWIX8Ec7nra7RyaaVSsO7sSynk6
         e2MaGQx4XYDPPGkjS+Q0Od6Qc6F3MBGAFSaT8f3UCcHCEoeGZ4FbesElF+Pr1mUrQYZ4
         bof7kGj5wHCEu+rh5HIGxkuXWKCYiSmo+KiZgULXrSc84CNbyk7WAZ1m6C65aTeigXk1
         fZR08YTIy+Xc5PoYtmMP6FEX7z6OR9rsakRkLwdt8F5N9BWUBncNzkEoh+/sELML2z9Y
         3eo6ucCnr73I+7HWktyBhBz5e8eP1JjtNM2JONwvEcVK2kw53Kcpt7fVL1Fw9qZHDpTf
         YP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774947402; x=1775552202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Rd6dD12J+k4M0RPgh3c+Z/bVpfV1NbJVTnDkgOMtLc=;
        b=lWazxMKa0DA4O9wqBQYvaG7cUDY7+PQUwbtTiutp/AclV/Gj+bsTQZ7JR1jweiQRBN
         7TBwHVQrLA2y7nICHIEy8oPoh7nX8CHRPjfiRI7A+T/RBgt0EVWuJMpSzjRkNPXTyPMc
         BmfRaOIavUUBrBUaVSQmBF1vwOxDvKjwN9xsXUDuO/d5G1a0y3jKdNbg/4cVrhOSomjT
         /YBtmkV4j+mIQhkNwoT/2mM9dn4YjHJAl9QUcrHdsmVVPLYRyfsgYhpC2TYgmDcuHmI5
         Bk12/+aTc40iRuJNHxtqOALC5xRKuUoN2biAs5eL2+eONG09moN9L0Lhw7MviJZkvu0g
         YYtA==
X-Forwarded-Encrypted: i=1; AJvYcCWrlRD6BfkFJyK9YXYc4MwIzkXl9MJQ1y57hfWcvEgoN0tYVg/ORwjKRlMJx453Jw+OBIweSVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH33/T7xupYClHAKf/aFsPslqmvmtL5FotHIztgmz3n/hpJMM1
	cCEa2WkthUo1XkuHB+NIjQPb4IPFyaIw1MQkDmf2AIh6t93IvAyk3lTB4wXPw4rQaxwBM8Dyccu
	OyUUfsnCe/5yG+CHts+MqKbEoZf6qaZHRNo8wqoea
X-Gm-Gg: ATEYQzyLrVrzYS1qsKn0dY1ZR7A7qCIa8fGm2P7hYTgKHix7vVT8iuSYgfKJKWGbRWO
	hVfHPYxgLmwpqW5uVfseH9hbRiCmcbOYMwmH0RjRQaO3QN65c/ln4QXHHCZZzTX0ppmnZmb/MWf
	qN0rrINnSF36Q/6Ad3mBS58GrrG9UPOqX5OvOk1VPXKI0BaZXFcpaimMySRfHYkhas2EflV6CDv
	MSr1tN8bRdxoHy+uqdz3TcJpMTvU+ohRQoNuMzirS/VvLp99IXmRVq3GNB6k+8k+qZsmQO/xT4y
	VPD5uA==
X-Received: by 2002:ac8:5f0c:0:b0:50b:1adf:89c4 with SMTP id
 d75a77b69052e-50ba391e5abmr200632611cf.46.1774947401658; Tue, 31 Mar 2026
 01:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774855883.git.zcliangcn@gmail.com> <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
In-Reply-To: <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Mar 2026 01:56:30 -0700
X-Gm-Features: AQROBzC1VwPhds6KUcUJYr2e4pOAOAu4WSM0cOgN26T1vLQGT08ERd_YmoRmcIM
Message-ID: <CANn89i+-W1j9iE6+DhJTAkcWF2tC1SdREDDx9pDWtNzCFLWMfg@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until RCU teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: security@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, afaerber@suse.de, 
	mani@kernel.org, yoshfuji@linux-ipv6.org, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn, 
	enjou1224z@gmail.com, zcliangcn@gmail.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273534-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,suse.de,linux-ipv6.org,gmail.com,lzu.edu.cn,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 82654366BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 1:52=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhengchuan Liang <zcliangcn@gmail.com>
>
> `ip6fl_seq_show()` walks the global flowlabel hash under the seq-file
> RCU read-side lock and prints `fl->opt->opt_nflen` when an option block
> is present.
>
> Exclusive flowlabels currently free `fl->opt` as soon as `fl->users`
> drops to zero in `fl_release()`. However, the surrounding
> `struct ip6_flowlabel` remains visible in the global hash table until
> later garbage collection removes it and `fl_free_rcu()` finally tears it
> down.
>
> A concurrent `/proc/net/ip6_flowlabel` reader can therefore race that
> early `kfree()` and dereference freed option state, triggering a crash
> in `ip6fl_seq_show()`.
>
> Fix this by keeping `fl->opt` alive until `fl_free_rcu()`. That matches
> the lifetime already required for the enclosing flowlabel while readers
> can still reach it under RCU.
>
> Fixes: d3aedd5ebd4b ("ipv6 flowlabel: Convert hash list to RCU.")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Quite a long and confusing list of tags, and a long CC list ...

Please trim this next time you submit a networking patch.

Reviewed-by: Eric Dumazet <edumazet@google.com>

