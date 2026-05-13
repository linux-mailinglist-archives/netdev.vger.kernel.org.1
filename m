Return-Path: <netdev+bounces-287667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM0yA8SfBGqbMAIAu9opvQ
	(envelope-from <netdev+bounces-287667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:59:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526D536A3C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A0683059DAD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051A23D28C;
	Wed, 13 May 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imrjxX0c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAC48C40C
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686488; cv=none; b=JZrITwpMZCAChK51z12CRjwcRsserPvUgsf1NRMvUtKLc3VErkayXV7COIKy9vTHtwitL3+GCAk2b3kKaTXnDwk101Je7j2z95d5oMrhF8gR1ZFsR2FvvrkAizXhPXwh0Bz3zMKwMwsnmiOX4FEW4w23W+AZE1bjR/8FJ/9LD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686488; c=relaxed/simple;
	bh=juof8ClPWBcdbohM1aei0MyS3Zb/FxQ4cYPoANkh300=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLZHhRnztV3Ihg0LYEKJrUAjnscCYkBoF4g5F2eaXleIiGLLMRmSmWJd9yaWlTAJ9K010Sa3ZiugS5XMw/Tl6MBrA/bRXWnNtKkGgvcCtq8iui3vVR5CxYJLUsARkJ6tFX/0EZmkVYgJ0+ys6vMvcoFopnm0zd7IxsoNd0zVjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imrjxX0c; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2bc7b311e77so18586895ad.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686484; x=1779291284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sULJalq8qpR0SDmRCBfWcTtKyEat46ygMheSeQ0h0XQ=;
        b=imrjxX0cTYlanQZ7gYA+Az1GipburGcWY5CXtIP1+67BLO5IjcuAa1fpin18csCpjJ
         qtAyaEdDRyXPHx/RA1dzqn6vMBYIszLUSqADA1w6Sw9cxYWX/O0r2EImBOvOGXMisUWc
         qCYzR4Zl3IOojPVGPvUEURhZV9DkDmno5YyicrfDs3e8nmSo01vEnbd0UT7WKEzdukk/
         KWxZvMx2YIxKk478kCwXztvMHoUO+JlxcvBo8g+BvbPD+qcTa99C4CdHWeuHrirwWbsX
         eT0USPt04nZ6be1jKwRqUyWSW/HbPsYxw3vowi0IS6Xj8yIvZsnaft2PET1bWwIxkpLf
         sJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686484; x=1779291284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sULJalq8qpR0SDmRCBfWcTtKyEat46ygMheSeQ0h0XQ=;
        b=HRSd048jPaEbwzQB4UNwRBltA2UonvkXJz3gqhLR9CsqlfTIlI45qhnDo1n226IRAu
         re16pZTAh58I4vDwOSCDIDHvGVdHgHHO94muu6gzhX+ItObqGkXYaKqgGuSA6RPSKavO
         oRaO6UOrn9qsL+Iipf9XhQoKXSqtkLX0Qw4FDU0K/QQY2/+XxsR21TLYt1OR911Ivu1N
         XhXoJy41rCHR/J6sz0/N+EhdP8FpyRUt6uSQ+h1JkqutNVzkVJiru3Gjd8dX4QmWuIiv
         3vEbLtKBrpF91xQzZL2PbJeSQuZ/Rf5A8JjsyJ4IG/wBt9YF0kHzi/gDCVt+Z+FICHAb
         2h/g==
X-Forwarded-Encrypted: i=1; AFNElJ8WMsGH96BeXRtvcd6pCZmgPoEoNgMgfkGwHPoP7D1rxusvSKEEx+Shm16Mh5lxRQcbip+8+Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVli0F8ovT52rc8dUtojTTKSNnYx1bcCUEyZTtwSWRUBrpmEPd
	KZoIPKzJWdVaDeGST+BheMbvPBVBy65zvKiReIV/zQaQFkEyFyYVI4QW
X-Gm-Gg: Acq92OFDzRlWR/WQUGKXLVn3ZVTYYrX0S3SQGXiMEge2Bnr2e5Kew3fcMQrVnNsmKjE
	sd6bD6MmmBFdvxCBOyYwcNs8ZDkk9AMhBxZ8YJVRTOSPTBV4gN5Y4ctYeYuo0o24BQ5xzNYCUep
	M5znpz8y1N1Ds4Klq870UhodVLyWKdetMfduoGcyrs18h718snDfytBr4pWleTDZB10+RO4JRW1
	0j4LEIk+krBf1YI33EuQacbUoFpaHGR276xqFwL2KkX4pSG+wgfQvpW11AGaI7XUDlCJA2suqmA
	Ql+1izEFNJtGV6XzaWpwALk7PlIoZ2dcl4itxKyFCSYTiq0ncJb/crGAdYIhE49GF1bCd/aLp4R
	33tBp0Bf8GA86AX4PZtHN7ZJPKxACHfp60C9VO2h/ojTukv/JdpfSRvgB11dVHjX8FGN54+1oFW
	ewm5wM1j085fB4Fp98
X-Received: by 2002:a17:903:1aef:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2bd526ce2dfmr298035ad.1.1778686484215;
        Wed, 13 May 2026 08:34:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebea72sm174932375ad.77.2026.05.13.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:34:43 -0700 (PDT)
Date: Wed, 13 May 2026 08:34:43 -0700
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
Subject: Re: [PATCH net-next 6/6] tipc: convert to getsockopt_iter
Message-ID: <agSaDOAx1HBSDoCQ@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-6-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-6-fe7f0e756fac@debian.org>
X-Rspamd-Queue-Id: 0526D536A3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287667-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:email,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/13, Breno Leitao wrote:
> Convert TIPC sockets (msg, packet, stream proto_ops) to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
> - Use sopt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> The sockopt_t parameter is named sopt to avoid collision with the
> existing optname parameter named opt.
> 
> Note: Dropped the unnecessary parentheses to make checkpatch happier.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

