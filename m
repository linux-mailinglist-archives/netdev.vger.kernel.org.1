Return-Path: <netdev+bounces-303321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oe2vJT4JRGo6ngoAu9opvQ
	(envelope-from <netdev+bounces-303321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DC6E72A3
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:21:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jxNeq4v8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303321-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303321-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AC5E3065A3F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204247A0B4;
	Tue, 30 Jun 2026 18:21:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B646AF3D
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843670; cv=none; b=de2bbt3G9sMPvKGqbzn0JkZRIopzbV/QX6bbthG//xJDMHTHrbi3gYCfyufvQjEPaf4/5KuMS1FNL/96fEmZQEX9m8S0KoZEY9WX14xoiZRRC4toLeA0RFcrsZKwRCT2l9alVTdbvqcvH1TFLKJ0F4JvPz6Xdtd/b2Y/XeoENhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843670; c=relaxed/simple;
	bh=LG6NzYs5Iqdc+uyXM3LEjlhw3/x7FgRsHNRGsVg08ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmud5TxblAdwoJ0SGzIcPBRFhq5VueIyvgDoXiF5rA+uCNB1KRYns8hWMbqE65XMfK3aOjNYAS97jonblJEGugKxxmWlxyFzqZBEmrGiQUv/T8lmumAvZBlYp7wV/iM9tzdZi5RA8pU7DKrBCzFoSKjhgxeazYjsJuBlRP5+e0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxNeq4v8; arc=none smtp.client-ip=209.85.216.68
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so582725a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843669; x=1783448469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+W2G2Vb2hslBefBgUbN0qp/RlNIGAjXyAoAJisoHDfI=;
        b=jxNeq4v8M05GUutye3tLMAT2mKNVHhb0ahGSa+7mCaNpf0OHaCfzx196rLodHqTWJA
         XmJrZW3GUiUSt2dSMLHVjTH+dv8Im3VY3Ggv2oaUQngAewd/6VJgCBONd7bctiHGjDSI
         fuJDed6/zA852B/qwiVwYfRmbOCs3EZrea5b6HWvT9C/CtxuyGicR88OgxhTcb9W0KNE
         gtAiHkRi/EGeEURz0jNhk1+QDtRuItZ9VerihZigmAxYzbC0W9qeVuAZ2QEnabCYLiak
         AvWhD/bOH9Ck59mR8E9tPPtJ5ebYTGOsfQZurCEIw5fHikvgqO0sjyvu8Iv+ifpDJ3sI
         RigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843669; x=1783448469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W2G2Vb2hslBefBgUbN0qp/RlNIGAjXyAoAJisoHDfI=;
        b=k/9MN0c5uFDWvIezCFxRX+iDuMi+ZwGjU3p+S6SSMxoLmfqBEg8dDNr/3bEpGycxAB
         5z8bYzbbhOKzFl7BdeiKQXKOKhwhflhraLCbCJvNJ2h/sjKQVhLJMrGOvYoDPrPbZ3cr
         9CGw2mrUEalsTcBfrTK4W32W6iKYC+ugZRU6t064TLCJGY3HiiHLvmDrnCZpX7nslWx6
         e0l2IyYb8nY0NMFvjs1Iuwq7l89jxbbBfCun8cREu4RWqjNWxX3iMWDrLoyeZd3FmtH8
         Hkt3I9hKAnr4q84yi+r1/Caut18N3eUVdyJ6W+NSY6TSjAv1dJ5p4JuETAZl/qadYCqN
         wqJw==
X-Forwarded-Encrypted: i=1; AHgh+RqYB7sxc+XbvPCNgS6c7oZVoENvqv5kaN8SLnztSFYD0X7/kFro/BCPrC2uRJxQGSmpL1f/gYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38OBSl4zegjWMm1H+koVID6s0UwVQHOXaDlL9a0PlbTCAztr4
	Nh1DLAOm6bPSU5k5k0qKWq6fLD7CIRxyNUlQZAfNVcxIMGzyQ/UXEggs
X-Gm-Gg: AfdE7ck3WTV+mk7PQhkKnWL8w+C9WAoqRofFclvOHZAbN145xfURslTBHfAtwhc76+q
	AjGSZxlNhbNPkrrynthNt1N0G9ZdMoi6lzU4BvmHzX8LuBMmeHkICsQ5QGlBAwewb3eLxaseeXS
	NedKtOGPwnA0AWnVKa81JvNhtTsyPI1ARiPTGDkaVZSjdFpXiCjHKnkdLrYpTOV1AkAYQOAZ1j1
	IGtUbLP/WbKlfQORNhT88Id8IgfJGB2M3ZmjVcG1+qotEXI8I3PQJF5lrwNPwA+cCCe57mj0JHA
	dzfSigmXowheGIh3i8ke4MH4OLcTEGRmm31nMkRESSmjQ2jSPbJTbb+YotujDoxWAEcfifUZk41
	ZKV3JCWgvbrVDYsA9dM5jsZbrY9w2Sc7bf1VLsj9dtJ7TjYjislrs+gz2N9eATcH/9/5tjQMyp7
	jmKphV93N5A8H4o/BG
X-Received: by 2002:a17:90b:2d85:b0:36d:b12b:f57d with SMTP id 98e67ed59e1d1-380695869c3mr2140132a91.12.1782843668649;
        Tue, 30 Jun 2026 11:21:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809644a387sm331786a91.13.2026.06.30.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:08 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:20:53 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/4] selftests: net: getsockopt_iter: add raw
 ICMP_FILTER coverage
Message-ID: <akQI_XA0GrLhcBxS@devvm7509.cco0.facebook.com>
References: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
 <20260630-getsockopt_phase2-v2-4-193335f3d4d1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630-getsockopt_phase2-v2-4-193335f3d4d1@debian.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303321-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fomichev.me:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 547DC6E72A3

On 06/30, Breno Leitao wrote:
> Exercise the raw getsockopt path now backed by sockopt_t. ICMP_FILTER
> returns a fixed-size struct and, unlike the int/u64 options already
> covered, clamps the length down to the user buffer on a short read
> instead of failing, so check that semantic explicitly along with the
> exact and oversized cases, the -EOPNOTSUPP path on a non-ICMP raw
> socket, and an unknown optname.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

