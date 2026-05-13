Return-Path: <netdev+bounces-287661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNtsBMGdBGr3LwIAu9opvQ
	(envelope-from <netdev+bounces-287661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C64B25367BF
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38E473169DBD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D85C496910;
	Wed, 13 May 2026 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTmdj9gS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89D46AECC
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686174; cv=none; b=druE2uNO8h4Vgq1HKOzjWzEGNATyFbvgQM4Z0ctmp+krn7fXbhtITykpsTkM2DkaeFZmDMTcWy/u6rOkrQ3xvdzu+r+Qb1O+06Iif8NCSwv2ki7tjBComeo/Kzk3Vd+gclk/XxXpPJdvrCIgyCwcIQKVFq/xcBrIW+VTizKrTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686174; c=relaxed/simple;
	bh=M1hEq7CvxLU6On8D8G12Fmu9StcYyNPtR454jTWVVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5H68wcB3KRIjjB4L/cmZUzDyBv6DPqLFR9uZwGhd7J0JJKASeBkTFNiCHf5MkSLpGJRra8pEtoQTWGx1rmptDLOeLOK4bVAXUO5Ax1/Rgi2uI6iaDW9OckatatCQnnNfR27CpD+aWSAr94JfR0/iaOOpYvCGj2v6aorqvsj3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTmdj9gS; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b941cd869cso44162435ad.1
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686171; x=1779290971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVg3X9kh4YDCRW/k5ke7n61nVYb/5/0InQTRe/5tw20=;
        b=ZTmdj9gSsZaBZY1YOfdpt3eODsKmrC/NOTOs4vTqCrI88TrchikfNBMBVmbvrVBbGR
         8ciyNnPtXhvLPGTBKAi3h3teHwEpEIhzP2ttmfos6w5J634Bc3isf5wpiDNJ/KdeZEYu
         GWsABXBgJUYsd+tE2ivAi2X2pcm166Ektny0jnkPFm38aoio0lg33Z/NdH/WfeJewPNd
         /2bN5ZpTIjD9TpyBEWGGBdC/Zz8niaYdjofJ7Rwrnsb7ZIJjSCaGeEXWQ/fdiioDmfSh
         dmDqV3sHmovTENOWdJELbrgdYij1bsA1beHf5HsxxVGzfQuOktdYLYcnWFJLtFnCn+Z/
         iPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686171; x=1779290971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVg3X9kh4YDCRW/k5ke7n61nVYb/5/0InQTRe/5tw20=;
        b=Lf29kdTx5/ysaGvmSd/hs9ydvAIS4LQq5J6bplmYtI0HDrm4ZriGrnn2OjVFDaWCCM
         PDlJaReGgailqJFuvvkWdZL1k6j+juVWKvSTlWFMYhk4uQ9skjDSTKXnEtzKNd6+S77S
         FN/ZTtC0DDFItvMRKsJ91VHjPuRomgQ8VVyUwzYhEUmk8N1G/Q1if936H4krmsq7qZy7
         ZTWBqFK4RzoCMUJAvm9TQw8rCBWmtZnzEGoe/Np72Zp+pZLhARBdw2Ko2dX5N9PsEF2D
         jFYc8LZpxrjbLWSTleW7CssGtTo7BnhdwjyNTrd8QtRvwQ6AitHQTOvby7tXOWJ11jeJ
         PmAg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ay9Bqk7N5j0piWmNZPDBn3jI6MYBUjyXm+IXmkvgj5HdeFOnIvSx1D4s4xHfOPXYQ7qUKxbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mvgrthQHJ7JJ0IYooLtzXyv9lpd5B4boz6mQDIzv8LBS9W3v
	LEEid5Yh70mpWFGQb8uskDO5nRKdl7cZj9V8lr38FMPGkbkdqdBk42sU
X-Gm-Gg: Acq92OG6T7W4ZRPANXkI8kPX42DZcPHQonHUEX/YoLztpsm97+CqGsXs0qr3i6Wr6Xe
	WZcGOUfFGNYvi5H3NxXsdeWwnHEDfbxuafFjHrtjXIOwgXTjwAiijf/lk6SYcZz/Q4FQVONhxg4
	/CJR04fj2/YoBORXd6G6P0d74a286coYrzUwl/YwE4hgkL78s5RVXYeWs5jOHmmqGo5yG9IOUmf
	zdXLYvaSylqcoEpbHxQvog5eOckBgwg/XbBqyGvTZXzFFfjOjdXJZcSqvzQSqDiSbOFaYIw9CDQ
	6Hlfg/NmXkMhQ7jhwlHJArJPqbDKy1mltwgjtlo5Fn2hut5+S8oH9bnReoYrve3QSslwdNqO0rn
	IDjb+vJC3F3gkOmTN5VHvJeLzsJIQp+bRInhb1IlamKeZf5FAuxtillkvLZg/48GCAU/XT5lpEr
	XsUDhXrmmhbLtPUSBy
X-Received: by 2002:a17:903:388d:b0:2ba:1c8e:256a with SMTP id d9443c01a7336-2bd30222968mr34932515ad.33.1778686170670;
        Wed, 13 May 2026 08:29:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebe0e8sm182921245ad.76.2026.05.13.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:29:30 -0700 (PDT)
Date: Wed, 13 May 2026 08:29:29 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 1/6] atm: convert to getsockopt_iter
Message-ID: <agSYw5V5Z6Jbtjb1@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
X-Rspamd-Queue-Id: C64B25367BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287661-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,intel.com,fomichev.me,iogearbox.net,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/13, Breno Leitao wrote:
> Convert the ATM SVC and PVC sockets, along with the shared
> vcc_getsockopt() helper, to use the new getsockopt_iter callback with
> sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

