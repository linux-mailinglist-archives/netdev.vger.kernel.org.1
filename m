Return-Path: <netdev+bounces-276158-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIslAjBv1WmN6QcAu9opvQ
	(envelope-from <netdev+bounces-276158-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:55:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BB63B4B8B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED4023032781
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 20:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A05F37B02E;
	Tue,  7 Apr 2026 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4y/I/8V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCA435DA6D
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775595225; cv=pass; b=VSc662cZR1RZRUm8cQkFa0RnyIocfGrXmQoqOoEVjwcjWEbOY1PDckQWkGU36kRFv/SybRn5PqzgCwev1JlU6ynQqDfiT+tbb8GbtFTNJHmeI1SgTNjL6CngZpkLunX0/k8nYbPWlVrUsn9ml8p73NzMTHg7DctojqsHK7zcXA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775595225; c=relaxed/simple;
	bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anLwogunTd4tpcAoEHr83wFDgfGYcVBbe4O5qA7oPZS40BurMOJB/GZ8SIC2GPzvHRxOdvdk+RGAfOdjHvDY4GDM37XSynE0klTCgAgCHtelJrR1CtGqgcYauojXbLivzNZ+S53FaESpsnn17OkcBJU+tFk+486kfKbqwdcCaE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4y/I/8V; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so1319a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 13:53:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775595222; cv=none;
        d=google.com; s=arc-20240605;
        b=eo59myuVXg61iFfk26HIJRe+HxIbuc+UqwJuU8vfXEKeE5rJrruEZxE9OS4r1vg3QP
         nEMA1oYAgRY9e4q9lZ22nVq2hglVv1OOXcTOSkjL+nLRjzcuS2duorrs/056LfBpDLLq
         sz+o+4peeQR7S43tsVxvdnvmbmskKEIktJl0KCrKTJrs0cnlULN+GPjhf+vS+CLfmTaa
         cc5rTqOCmhuStSXBWSh0UftBYzEDxcJrMQOOljgIJD7/OhzQLGI/U3vjFpyD5rhAn3o0
         qEWZ6d1G1XBNS93Wh9Ae77IE/zVB994DApWKxbSx4WwBjKQN8VxAl03+bR1TJr3SBZRs
         BTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
        fh=0NuT2TxH7zEz47NW0acTY/th3fgN7rx0PpcgLaK5hzE=;
        b=ltxJTG31G8TXP2yFeo/+ZLhCjjsjTqcCmDdbIeAqGbBDgqqZVrv7OHn6oG4xtc3SCZ
         wSPAYACbPHdCjEE1nCKAYWx7kImBZKFftyxaTtwFcgUCr607yhk5R2AIhS6WdeQtWPKx
         0N5XcYegXXWrZ7FM9J05wMLj6+q25DTkv5gUvJNx0Fg4tcwvjuSfwl6Pi+Gwa806RO9L
         HW66uh430TQxDmMDhL98sG7YkpAZMp0zqay9LcTnkNBCD5Ux3j876rYY7vxlT1BCnMHL
         VF50xmU2n9crSSGXHeMUtWY8U/5JlGj7tW1i2EyWY2e/+oQc1ceoPE2TBpg7gOWPdMud
         yW4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775595222; x=1776200022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
        b=k4y/I/8V5zgfQhXndP3mWx4YnmDYDu6ou/59VoGIYXXs2IBQ+h8CshdHAniJdJPXMN
         1w8q3lbA9SqF5FPPJFiAapFx5N+8JVxH1DET1hrLHy/B4rkJZqADEOClFmhk+vb6MWGm
         2+3k1enRL9AxIMsZsREEWQbUkeY4gzAVKz6p/aUlF0nUpZ0UNvnG+f56ak+9X8Ku5Z2i
         xEs69JLh9QMHFbg3VIWRzNRZlhQMtABwv+bbj3aSQWvE7Zjaaa9adHy7VKqhiKNYlgBo
         eE98y7Wr1O3tMHDhNHSk2XdvSdXrGfX/pDeUSo6u6gzWe60JN9fraaBwNYmUnrm1+Ilt
         lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775595222; x=1776200022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hAYL3ZhdW2F5eHwp+Hfkeql6tYPYXzmgecrqyASwpsk=;
        b=byK8dc8IhTs68Hg/i8cQ32A97yxHqLdwzky15pN2yzBS5cG/ar6+qSvOf0vJpxwBpf
         Q2Ecyf7GZ0f3RDHcx94kRTu47GrZQz9wf7Qt+taOsez5YA2SWzu1LR4iDH41Fzn3Q+KC
         Xr34i1J9wyn2Bano1DGsJ4nbUvw954jpAnGTdfHmQ8+1vq7/RtxrLUNpuAj4UAoEcR5J
         QKVJPWN59OlNoAv9GBv0C5J+OM796mYEl4eEvO4Cafs2HoSDLR/YgfLrfU4lKBEfeI/j
         3LROQQ/mPCEgsS/HuPtrAu1Oo3lRt9VIWYL3aO+dgTw5ZATTikder4lTD+1OKt5GLQxf
         dfXw==
X-Forwarded-Encrypted: i=1; AJvYcCV0hShIUYm663CaDj4CpCM/K3jii8320LEYhkQBxjT/EKUvMNt+Dm+SXH+P9l5tEvAj7Evb26E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb1vw17JCK2BfgCzJaFWOOv4SZMwDvN+06/zcKqMIdPN6MJPuB
	QdCzC7ccLwh7phQBUVfeEcBXxcYqAyXbOYwjJi5uqAF7XFO/0lHfeJFT5XAk+YNsS8gx1Ja4wjQ
	slLK/dCAeYCZYeimpyoI1dKf/Xtjws5ypr7qc6KTA
X-Gm-Gg: AeBDieuk6AeIGhE4IWeZ5fU+eyyxeTG2cDo3KHBJ9yvKOfngE+M/BCHpWjqafeL8IZ9
	JnKWI1LU58zYydxYDPSyfLWbDF1arn90iAHS0pieuzrpiowNnrk/6E2o0wqKW6C4TtGjrjiOZ0g
	IVZ96u3FV/mJqcieLT3eem2ei/OEBX5qh9NcFKrU7LL097INy1Rb03ZNAtf6H6sQPFXFfyKxF0S
	U2rYDlCcKCZkWgkHcdzEfAnf7slGNG0vAnj4MSKPyctmGaSoeWfczbrYu6794AhpHMKpZMxhKiv
	4LABLmM=
X-Received: by 2002:a05:6402:5192:b0:66b:b6d8:c0f7 with SMTP id
 4fb4d7f45d1cf-66f9e8a747amr784a12.0.1775595221201; Tue, 07 Apr 2026 13:53:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk>
In-Reply-To: <20260407191128.b2hr2ttkdpyunhrr@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 13:53:24 -0700
X-Gm-Features: AQROBzDTwGQS7R5PAsEU3h53Sr6ks4a8QPBLHblMF9o5FM5amaSGtHZz6ABr9Kk
Message-ID: <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276158-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,gmail.com,redhat.com,linux.dev,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmattson@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D8BB63B4B8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 12:11=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Tue, Apr 07, 2026 at 11:40:57AM -0700, Jim Mattson wrote:
> > My proposal is as follows:
> >
> > 1. The (advanced) hypervisor can advertise to the guest (via CPUID bit
> > or MSR bit) that the short BHB clearing sequence is adequate. This may
> > mean either that the VM will only be hosted on pre-Alder Lake hardware
> > or that the hypervisor will set BHI_DIS_S behind the back of the
> > guest. Presumably, this bit would not be reported if BHI_CTRL is
> > advertised to the guest.
> > 2. If the guest sees this bit, then it can use the short sequence. If
> > it doesn't see this bit, it must use the long sequence.
>
> Thats a good middle ground. Let me check with folks internally what they
> think about defining a new software-only bit.
>
> Third case, for a guest that doesn't want BHI_DIS_S, userspace should be
> allowed to override setting BHI_DIS_S. Then this proposed bit can indicat=
e
> that long sequence is required.

That case can be handled by the paravirtual mitigation MSRs, right?

