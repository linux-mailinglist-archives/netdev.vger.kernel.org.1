Return-Path: <netdev+bounces-276131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCQGNTtQ1WnA4gcAu9opvQ
	(envelope-from <netdev+bounces-276131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:43:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 795583B301C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 20:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0009304DE99
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3389334107A;
	Tue,  7 Apr 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUAaRPdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096333CE88
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775587273; cv=pass; b=kSwW6RGspwnMqDLtaMhXOhUEj2DWpg2rV4fx2A7LR83yu8JpCF0LhZJqHICWGALUvn+n0ZhEdv5We0NabdMa6rqReURR2gZD/JPHNTQqgBsutQhFuh81e85nzAsGwLXZNdztt/29VW21k+hOoc5talEGiK9rN7M4AECqhBPD4rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775587273; c=relaxed/simple;
	bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noVNSTZrsn09VEYWd7poN9eamDXtqqB7LnwiQU+33EYEo+mEFlLFbbs0NEyTQN+Qu8tWM8v8VSb6H6xCtC+ZrYoehP5x7DcEvCFW+mdwbaE3JKUjxpFwarJrejZczngWmb3f2UrzQ3fmKH5Smf8j6cqB9etb1CkxNvs2iOVNg0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUAaRPdB; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so1828a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 11:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775587270; cv=none;
        d=google.com; s=arc-20240605;
        b=kjq0JYftGqaoPRqgjnGR2P9C6x50uXEWhNY1jf3j7jkupHUcXkdPFzVeMULReZXrUL
         7WPbM9vBrgr5i+wUJWrIeNgPBDl5tMktBqXpxBZ7DqE7h3ajsrObBFs3MjgQTXd+qQR2
         trxBRElry6GGvnu4Pn7RnzcgCsp8QIrALcYqXHW+fYFT+lbvo0itqdpFbMhT5JVNTWXs
         48aVo4+9qv+aFCIHEnV/E0VPNrRpU20l9+YndOyPies2zoO32YUzhpRVMEMk62hMcQ97
         VrNkANP/TNhEV3ynOW1fUIOTZxoNmjAKvgRyIH9Z3+aqbt42Oi+1MQPeYQrF9thh49Ec
         eQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
        fh=KNi4nyVXRdJ27Li9DJGrFqVDKwtIijfN46eB3TnmhOo=;
        b=WSAY0W6+sbB6GWUcbvN+M66YpLbQI4bSGSb/T2gYy9zRJ+It1oTgApVWspv8KuxL/3
         ZpdY6oDMEUaFn0aQgikHtsHav0vLeJqjhN5dxh/iiVMiKbhAWTXdSd0mMGc3yBv7kb/U
         KkvsKIek77dveY+4RiAVqlREofg0Zog7ayNXQmQ2X0/sI3/I6ZPvbICiL1NhwIKiDlvw
         yaQfrtrIa7aML4nDiykmCibbb3Myot2SZ39KdKdfS8bgWXTAHkVyjeAFEZvYSv3rwyqV
         qMHzC4pBCKenQdRzNDcq4GkZ+JKbmfzKx2EuKxR9Ma3JWuKe/BmiaboVTB57sqiC5JVG
         lSeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775587270; x=1776192070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
        b=DUAaRPdBnrNLOhCS9+edF+j0ec+XQt3UzjdvTP3IF2wUtvnWewBDIfOG8A4asaM+gh
         Dp41Ia2yX8jvR1laMzMOzJE892sj0Si+EBIxA7qXW9mxytxolpmTAi7Yc7kuE9/kyQue
         GkUynP1fUve4u+LXuM0vIRnANGjEXgQKUOKqlLv1q+ei2VNbmDYA+vj6dz/b3S2y9cVZ
         5VCPpV4WzeVuK0R0iVsFKuDpV+LUgS8XU9jIjUQYdzIgAUneynnF8O2zqj0Ki0eDusAe
         eQR/gHaAWMNOSwT5ZB1YwCqDvn/njJ1a67122OHZfb+kQnrgN9vdaQyvy8oVcvgiqqST
         t9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775587270; x=1776192070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZCDfzIeZ9MXyD9zphyFKr1/BkcZ0XXimcy7WGnXtA8=;
        b=lmng1nQOBPVNfH746yxZq2Jx17m/RpPJOvWwgMMWpPy+Oui6Rnnsm1k+gQElgGK3Vt
         XDLf4RNrVDlCLa9Wmz7GnfJs9oWrEIl03ibKcu3j1kJ/ph8D5MSotujpkFgHvoCXQqF7
         EozKdrxC4bPE62tcfvLhIAD5/CtgoE6mfl9w+CB+BUHAUl8iMU3QJNIS3sSRfNZbn+SF
         V1gyjGn+xYpY5iRi1m57jQLOR/yW7GPI3lJYA1DgjzeLsa5j3iBgSIIWEqr+u+cufZOv
         0lKyfMbxIqdpfKSHd/8UIREYWBYZlPniXR4rVk5EO4uRKFD6hBByJxGts6vgkCwhxmvr
         mEUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh8nLqaWrv+y5X7/f2rIC2NikT0GZRZJ/da0HAvIz51Fg2o5tO6TqQqiosP+Qg7ntxExDLHCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXStzurCLOgaNKSI8lC2+SPZlSrAoH8JoFC+MH3FHk6gzQQNd
	Cqug1qJIizDyzwBSDBsScNZW/nz3PCz5ylp/XdVT+fMHPxSSlB/bVAf0vbVMW8qGWHBxKKIOkB4
	oj2VgCi+RbAY5leLbufPt8Ch9HXCp38u7lZ7dIoC5
X-Gm-Gg: AeBDiesRKFWgH0oolN3CFQSnBgFr6YoIfMpnW7Eadp9s+WwbS5WxPVXE8HKQ1ILXN8n
	y0W6MW0jtC1nYwKjo7nsdPErzeroVAj7e/4LWP0WcNvUFlK1lYzmRq8WM3NO1usgkR3lvBF7VHe
	YHXzux2ODBimpjASEmqAmDhYhpmjAopnlVQh8u5ZAncn7MwgiVXW7APSQQCdQsbcMQb1Js8pqIe
	2KiMAMkNnAkkBYRmx95MuPOYyHWoaHkRtM0R1gidon5KtIAQcMyLo0FG7+r0FyYybsDSIR/WJza
	t/OpQHs=
X-Received: by 2002:a05:6402:a0da:10b0:661:f987:357b with SMTP id
 4fb4d7f45d1cf-66e415a1e4bmr147625a12.14.1775587269433; Tue, 07 Apr 2026
 11:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk>
In-Reply-To: <20260407171151.2gf2idjbmph35ypb@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 11:40:57 -0700
X-Gm-Features: AQROBzCt9Ys4MdyKd8Tqk8kV948jbOd6itImLNrx4CMkmInZ0JBSW_3PRIdD-Y8
Message-ID: <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276131-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 795583B301C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 10:12=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Tue, Apr 07, 2026 at 09:46:07AM -0700, Jim Mattson wrote:
> > On Tue, Apr 7, 2026 at 9:40=E2=80=AFAM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Mon, Apr 06, 2026 at 07:23:25AM -0700, Jim Mattson wrote:
> > > > Yes, but the guest needs a way to determine whether the hypervisor
> > > > will do what's necessary to make the short sequence effective. And,=
 in
> > > > particular, no KVM hypervisor today is prepared to do that.
> > > >
> > > > When running under a hypervisor, without BHI_CTRL and without any
> > > > evidence to the contrary, the guest must assume that the longer
> > > > sequence is necessary. At the very least, we need a CPUID or MSR bi=
t
> > > > that says, "the short BHB clearing sequence is adequate for this
> > > > vCPU."
> > >
> > > After discussing this internally, the consensus is that the best path
> > > forward is to add virtual SPEC_CTRL support to KVM, which also aligns=
 with
> > > Intel's guidance. In the long term, virtual SPEC_CTRL can benefit fut=
ure
> > > mitigations as well. As with many other mitigations (e.g. microcode),=
 the
> > > guest would rely on the host to enforce the appropriate protections.
> >
> > I don't think it's reasonable for the guest to rely on a future
> > implementation to enforce the appropriate protections.
> >
> > This is already a problem today. If a guest sees that BHI_CTRL is
> > unavailable, it will deploy the short BHB clearing sequence and
> > declare that the vulnerability is mitigated. That isn't true if the
> > guest is running on Alder Lake or newer.
>
> In any case, there is a change required in the kernel either for the gues=
t
> or the host, they both are future implementations. Why not implement the
> one that is more future proof.

There will always be old hypervisors. True future-proofing requires
that the guest be able to distinguish an old hypervisor from a new
one.

My proposal is as follows:

1. The (advanced) hypervisor can advertise to the guest (via CPUID bit
or MSR bit) that the short BHB clearing sequence is adequate. This may
mean either that the VM will only be hosted on pre-Alder Lake hardware
or that the hypervisor will set BHI_DIS_S behind the back of the
guest. Presumably, this bit would not be reported if BHI_CTRL is
advertised to the guest.
2. If the guest sees this bit, then it can use the short sequence. If
it doesn't see this bit, it must use the long sequence.

