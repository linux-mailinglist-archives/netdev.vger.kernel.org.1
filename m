Return-Path: <netdev+bounces-273721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ml8KfUKzGnGNgYAu9opvQ
	(envelope-from <netdev+bounces-273721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:57:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 688CC36F863
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CFB0303D658
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487DA43E9C9;
	Tue, 31 Mar 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tUS2xhE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F243CECA
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979417; cv=none; b=VNAlYpww9adFGwhFjFqa83YmENz/GxImTsoH6UxFcO5LPePt8nkAEsd28UABqgvsenYH7To7HtHmcY25LqX4LbWp9M8tM4GIj33bJepKyrwN4J+o4hmWch6zA6974KC4slnzM2R5xtb5qzaid+wF3TUAOvgQaiED1qD7UXsWoGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979417; c=relaxed/simple;
	bh=VgUis9s6Qpjfluu+1DI7P/hWgNf6BSkMHZzWmBjouEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SnoFq9xmUm9lngp3UGpwZz6ZNgDDo86IdsH9E/hVxvSdP4QVjX5Kcz3I/MSL2RkxE4FpULeOBnYpbFo2B58fZqe/gdz1zfszGaskdRyUVW2kWrhgenopsu6Ax5GdIy40gEaZ36yY6zZv0a8F+2s1Gz4SjXAI0nourvQzxPxCIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tUS2xhE4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so66800b3a.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774979415; x=1775584215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBeMy8Rw/5TjXCLG+UKpazz3KysoPcTZt6O2J4Vg6kM=;
        b=tUS2xhE4G6sHOzS3dSEfRi88IwOQzU558/DD3p2JsuYOjcd776/U9PVI25VTBC4fo3
         kLiQ22ChBW3e3TMBI8j9/qoouqK5aPXkruqVz+OjvTT7MpLLSAwYLuQ2Qju+YGK5l8+5
         67WAJmGNsmcCeG6TeXyk+z/kS/9Wl7LB1cPH1MeaOROML/9ZlQ8PnfuDY1b1tV1sMgrM
         Low6kvgAPWNsKauJM7qqC47LD48YtE/lJ//V5RNoPhnU7ck3eecr7S0+EkCFo1NXu3oZ
         SqzjkM7hirh1nl9SG5CzmtGdAHOKkqSwZgQxiiklw7hgt3emG17C+Yj8JXb1GfLWs9fl
         d/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979415; x=1775584215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBeMy8Rw/5TjXCLG+UKpazz3KysoPcTZt6O2J4Vg6kM=;
        b=U5FaH5VHMKuaePHFsY4DpeBwg752+DkneZq86V+UoI4vjZ0VOueBD9Jmfgb41M8THU
         91ABRmfvtcRhL1LYkLOfYgQhn4hJ3mOzpi7R2NS/wKrCZEgdhWuiNAGboChPwuRlzbMz
         MpQTEeEMpWwQWT6dHMApSa41Oe9DqcWa3X/+h9P174WKifgfl+xJwS+pDOvzKFq2jFuw
         lmezkwTvQ1vOcFxgB8hcY67+iJXBmJ57+0RDRSfck+EaulZm1LjGQSnOOTn1pZU3a9+J
         /PoVJOzY+2jFQVeculW6damnUe+xuHOhctiePZgSY4MVkDqXsgq1TUzg+yhxsypNM+Du
         Lzgg==
X-Forwarded-Encrypted: i=1; AJvYcCWKH7DgzbKh+qgtfc4lIaJlWCie15jE5kqGL4xEiUDqd+t47ljd0DlxAjnrrvWQk+NFKcJfrDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJoocli1pBxoPkV6Dy4tR5JWoRbk2ShAcWLE2S3ebQY0Rqgbg
	i2h/VTXwExhYr0PGUL6u7BivDT1pKUIlnNxZx0/X3aq1EA/K6E8jD1arhdzGtFI2BOT5FOApIae
	JBADKKw==
X-Received: from pfbg26.prod.google.com ([2002:a05:6a00:ae1a:b0:829:7b74:e1a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e97:b0:829:7a62:6a
 with SMTP id d2e1a72fcca58-82ceaadcfc0mr197450b3a.22.1774979414552; Tue, 31
 Mar 2026 10:50:14 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:50:13 -0700
In-Reply-To: <20260324-vmscape-bhb-v8-4-68bb524b3ab9@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com> <20260324-vmscape-bhb-v8-4-68bb524b3ab9@linux.intel.com>
Message-ID: <acwJVUeW9KoLft4d@google.com>
Subject: Re: [PATCH v8 04/10] x86/vmscape: Rename x86_ibpb_exit_to_user to x86_predictor_flush_exit_to_user
From: Sean Christopherson <seanjc@google.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Laight <david.laight.linux@gmail.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273721-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,google.com,lwn.net,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 688CC36F863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026, Pawan Gupta wrote:
> With the upcoming changes x86_ibpb_exit_to_user will also be used when BHB
> clearing sequence is used. Rename it cover both the cases.
> 
> No functional change.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

