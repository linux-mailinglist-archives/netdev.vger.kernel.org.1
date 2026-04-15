Return-Path: <netdev+bounces-278645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBldCOgb32myOwAAu9opvQ
	(envelope-from <netdev+bounces-278645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:02:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F3E4004DA
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30148303662C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1A735F162;
	Wed, 15 Apr 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuFHBfzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2F2EFDAF
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229306; cv=pass; b=NdxFByP7CcUekoKczoBNBsXrsGDw9QTjhcL+Wfd/08hf7msBQphelrqBuVpSIbh04lNPfocuDmPBoqBufeAuhGxBQMT/AD/Pr2l5Fon8goHhdM0+n/B6QDWaTjiHvH86k9vH0Yu+jVykl8bvzoCym2uDa0F+u/FT12SftGq8Mtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229306; c=relaxed/simple;
	bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDHp11yFnsJYVbDrmGfgsoZXF//YYgPNnkiAtBGa3UjQ94nuQPUyieEza7sn/8sozvzHNTiQ9t8u9x4vREiEev73pcjzzgzxEtlgzCZtVis3ZI2rZk37tnn7FD1onbSJt8zwpv8EBE0i/307vUAG+8MCfTMVcLOzKAlrVVXmnRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MuFHBfzM; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128b9b7e3edso3833156c88.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 22:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776229304; cv=none;
        d=google.com; s=arc-20240605;
        b=cSycMMt0jpIUkroYDvJWXo0mi4v41dOdFo0r2rvtN0Vqi1iohKC4P++rrWCR/wg3tB
         yY0A/Ana6jywERX3zjJNhC/nDAssK3libW+M0dE9q+L6mfkP0Q4NhN63dRHQMkULgZvS
         oDAQjEfy3CFG5HBpYGiGu1heIOjos5NwZ2mTDQCKT9pBRzqBLeShjToKIPaF7QilyWqd
         nCZyGppoP+JqZQYpY6rVV3b8SKWTWOpB6WvM3Cjeo648pewbVtBm0HoafhKLDr3+AXNg
         ROjPl1Hl8eW8cUGVkR/rrIWMMFE9YhZmdEZxH5mfFFx2EQkndrvdCTYGO354wIHZYhlj
         a6gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
        fh=E1jCyC2pd3gxhKqDeeUEsepF4WjuHscpjyzxlL+ooRc=;
        b=Ipqq70l5lDDpkTDEzoCa2SI02aCwu4ryUPBGcJU9+GSojhOUXMEL02AIbo10W1l39T
         /3aAcN4Oy0Yi9ocF2Db2odkLj8TfA9QgOo8l4R8M1/YHM2W3YGf9eAST67BxQjt/hSrs
         IIvH1ABTJMrOao/VBAwFl1Ve4li6Uw/izpkveaCpshm0ngKD9MXsKobyvBXyY4UljuAP
         z6yfYJ/Ozn49IfAac4AW+oLrXgoZA3c//a3OWyv8oJkZ5D9VcG52BjSezfnEDqOU2YgR
         vX5MWaUn5gePzVe2444jzZ4RcwIC5aaQoUZBcWRuSUdRpngWQDVDlWd0Yg+3JoHWwOLe
         s0Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776229304; x=1776834104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
        b=MuFHBfzMtF6ES9S2JbmLmV9lxwnzw4thqZh1QNxMylBJ2vKW5dQKVHXsBYKRa5SQiX
         H0ePjRksjMRzPopYZTL2em7AQcOFh78cUw24WaQH3PI5xHiytKL6HPplWNouEDyAFwiX
         96kkrfKC5babTuD4IFpjIwOywrCDeTGFtltv5nFJSVTL48CGeP6k6wrtdXrkVdBg/j22
         IjqVktvQz+YH7dMPT6FBNN8xIKMW7KOKSMEO3C4JLAC5X68knqEDMy10WiYRrRJb9RnG
         /jIvgTOzc8slnQnCzKS7qVIMVcGFuwpIpuQ4Cr6TJj/Mm+553rrv6xRl9ZHcT8Z9LUEz
         vvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229304; x=1776834104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJUSotdmTzr909dQmu6Z/4Wm9WvdYY/zfwb72+1evp8=;
        b=aC4gKQ/lcBlhN9XmVdA48HkPUEt9PqFjoAHxLifzXLKmHjC7VigeY838FPNQRmxHIK
         Li39OEBGBEttPYCVyNf3gJVb0B+L7oFhHJ/S3dg5z8isbiAYUkvwXxCur1GBf7cit26U
         97R+6+u6ySE6Ew4zvotFimt4jgHiBmNhOTYCwVAhBzC7aa/mePmf2+hnTpFOxdktR1+m
         aYyXA53zlVGDv3qNtTxGg47AgXccZbjtUW25gvD94axkxVi6G0f/m5o7GXTVr+sI9byQ
         UjwD1/ehNGCkQ79vta8kHi18lUky4UrVRSEhZnBa1pAlY+voTNQK0YMVuYEUhWUv6HrI
         8nNg==
X-Forwarded-Encrypted: i=1; AFNElJ84PRTMKD5wQqQIr/zRU0f9LXCA9M0BUNGVyVfjMXlkDhxjSjmi3plhZdeS4S/y9f7m5JKX5mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXJDl0McMRTEEqMUOAG+nOg2D6UUJKHEQ5EwioOU8B7M60W+M
	Zk5nhtJTitYM2DodSa8792YEdixqenBWi1qqxgCendM6OrCQuynCTfX4Iyb79/OySAafFzjb9ya
	s0Vsxrs8zQ41QGiztlfRB7C0jKY5ipK+4XUG4PXym
X-Gm-Gg: AeBDievchtnIvDmli5scsJTzQcQrHRVB0wKTRe+0Ud59EsKZzjD4ahiRlRtVHI8shDd
	foyiZHKKpopa3PCNuYA5iaAhku+/6nMllSr+hAYs1kxNLTaCdPvEjHg97Ox5qBn6mvriM4HLH6Z
	rEab62u7ccz0f1GZUwgwhi0FQTtKr5Kh/EWDJWzp4mkEJj7EPZexF2GrJTg707IG3FvNi7HW9So
	xFWjNs9XRkc2IEaNHXxAWmgr5ftk0xmHS/bNI/kvLNfI08MefCxNOcg3GAC6b66kpYwxvUE26F6
	Me7j09mAIbB7polGVUaqAmCcoKQAQKnLX5Pyzy/7NTqIMXkcdawAGaZxx0unRAJ35GBj0ATaQBm
	ZrgkFndGmgM8rQyQW5/Vdykk/RqtYPAxW3L/f/RPOrETNMVgw454rxJXm+CyOKoXEKOk8k/7tgg
	==
X-Received: by 2002:a05:7022:389:b0:128:d24a:a5c1 with SMTP id
 a92af1059eb24-12c34eeac88mr11841217c88.28.1776229303335; Tue, 14 Apr 2026
 22:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
 <20260414-unix-proto-update-null-ptr-deref-v4-3-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-3-2af6fe97918e@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Apr 2026 22:01:31 -0700
X-Gm-Features: AQROBzAtbLi74sgP-HJJxeDMhYc_8XgwX0AD5wIVbleVSSv1wtKRsUz6FlLLeDo
Message-ID: <CAAVpQUAe2dhWaMnKPH=uvmGxVA_dd2gVyCL=Y55+eUJ3G6QOFg@mail.gmail.com>
Subject: Re: [PATCH bpf v4 3/5] selftests/bpf: Extend bpf_iter_unix to attempt deadlocking
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278645-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75F3E4004DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 7:13=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> Updating a sockmap from a unix iterator prog may lead to a deadlock.
> Piggyback on the original selftest.
>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

