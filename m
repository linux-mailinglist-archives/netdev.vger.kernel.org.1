Return-Path: <netdev+bounces-271709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKAAINg6xGnkxQQAu9opvQ
	(envelope-from <netdev+bounces-271709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:43:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7AE32B687
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C77EC302A7C9
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F134CFAD;
	Wed, 25 Mar 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8Zm4OEg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AC35DA6D
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467714; cv=none; b=hPXNA+CIscQpJxol6fuJvnF1j0jrNt88Jz+6YzxMVP5fWsni7uSw86h0KNReaS0Mmf7zSoRZxdZErmrUMmeRFgspHhfu9Qcu/plffOVT5DQ+so1yyfDUNdiuSSDjvnvmAaLylx3I+Y82JvCE4Nqpt1bcdTDCjBQVgMYG1JLB7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467714; c=relaxed/simple;
	bh=d+nfjMfEVHf7jtz1MIQh+squ9QrgehK0qZ/mTLc/EZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tueWMPpC660+DuH3/K3tPBgXs/eSJJdT+rjXfHTy36V1usiBDFlVLLH0buqQw09KrawgqxMOMVqfpskBSVxFp9N59kQ/wSziYbicnfBlDDT/XwQeq7BegvBu4TxzzDy8a7FWptMaNvr/srAzT5IapSNzuEANgj5qWgDPeUBXwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8Zm4OEg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso1834165e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774467711; x=1775072511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5agou4BHmM67c6SSsDwlj7qtFxZ2/CyU4qlcqH2Z8DI=;
        b=D8Zm4OEgE7zuhMoO+TLA6zFkoCvrIu6Zulcl82z1eiQnUVxOyFpLzEDJ237N96a63L
         q+ghLzhGjUVdtJnfPtk7wsAP1ykwBAmNJlRKmggQNUTHhMPdcqaYhrP7YYTLu7QwPU7E
         GaN3y5XNr27D8BOGXzhOvOU8idIz+YpoSyZfo7jO4SjvekAgsJzLKIjJWXMm0/q4xdtC
         R6M7fMSu/bc3U1VVmsE0QnTRmki7frlt9B+QlFeLeRPkftJTygbzwIyQ0sCjLn/MWkI9
         LIcPpOgUvglVrXHmspUF2S0XPWXnf0yu54sjnr0l2jWGbRVq3qgGH7hrpA16cU+ymnpf
         r9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467711; x=1775072511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5agou4BHmM67c6SSsDwlj7qtFxZ2/CyU4qlcqH2Z8DI=;
        b=sYUsjLjS5+WgklTO+kY/VgE9O1XfFGfZC78xLU5kub6OuwTCAYUpgKmzu2kYd+ofOs
         UX7gaohOjTXE91I0+MQrEpHl3HTUlWOnfM3jdt3pq3RrC3hwGYf+ADFkOSEWVFmtkyur
         zNNXxHNJ/LolpMyF2Kie7W1b+nV58+SByTcwesEbPs6msReqtMfepWwOgAwvG1WoKBuO
         pLY6ziFMnrQFS6IMA4SUsKDlAoCDprNp1Sft/KRhe/EbG7K1cImnr4mOS+mBUNpZDoXD
         p/Lr6cYfTXhYAKkIq9CqZyE740cXGPP+DUW8IhE4NCJzH2Wao5ijDrY6xFOerm+8qaik
         g3fw==
X-Forwarded-Encrypted: i=1; AJvYcCVns4GKLxAaVpc9QW94D42yr1Iy9I4mqalK1cNDvI/daV6mxsp9KBjlzhMRT1uvPsvvVlvbGUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PUpX102oSVPG9cOzmObaLHs0o9mCjXxJACpGFIhocncFK83p
	zxxlGxEfAfWGlrwGoq8scYQDNI7kK3oJweFWr+LisdyWuMOjm1dhwtIc
X-Gm-Gg: ATEYQzzCvquvCyimdsOpGj21pXS95qdMT+5AXAxTjYok6OwFy0J2nBMnUSPsSwRm2/+
	G/nvLiHt9JPFTdkuynIW0v9Fbc9TW2mglIrm2d6miaAavsw04Aimw2UUGBPEdFtrRAB48/osHBn
	ZREVjbzKM4PH/Czb8xf1cmZpyElptTIkWVM5fQEpphK8Ux4RoGk0YyVH2YROlOSda1B5cPY6RGe
	Hol/lFzIEHciItTb7p3Q5UyeQO0wLDKiL3gi0I1QWngER9xdwrr66AEewNgyhL7thJfYdfHZPdL
	rbxhFN+QRg11Csa1o0YcmfPKFhVaEq3FL8KvNcQZQ7ks2QBg5DE5kaicXW7se91D9wrX0l9ex5L
	gZEodcYJL2xonBsenQnSwO+HEvpMIT+G9wUhg998KLtWyj/oW4P8W6Ldw29QBOgfk8ZTwsMFOmD
	FCKTPih2B137EEg4oK251n3AP5SB+vfXNPKrf/6lMpNIY4P7BCa8wAXHViUwYLJaA6
X-Received: by 2002:a05:600c:1c22:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4871604c8e1mr76733195e9.21.1774467710858;
        Wed, 25 Mar 2026 12:41:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fbb58a0sm688705e9.23.2026.03.25.12.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:41:50 -0700 (PDT)
Date: Wed, 25 Mar 2026 19:41:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jim Mattson <jmattson@google.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, Jon
 Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Peter
 Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andy
 Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, David Ahern <dsahern@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit
 Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260325194146.29c91953@pumpkin>
In-Reply-To: <CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<CALMp9eTZRucL+CUSp1yUPG0aSTpyQ=po1EmurZhX9+R+vxgbPA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271709-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,suse.com:email]
X-Rspamd-Queue-Id: EA7AE32B687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 10:50:58 -0700
Jim Mattson <jmattson@google.com> wrote:

> On Tue, Mar 24, 2026 at 11:19=E2=80=AFAM Pawan Gupta
> <pawan.kumar.gupta@linux.intel.com> wrote:
> >
> > As a mitigation for BHI, clear_bhb_loop() executes branches that overwr=
ites
> > the Branch History Buffer (BHB). On Alder Lake and newer parts this
> > sequence is not sufficient because it doesn't clear enough entries. This
> > was not an issue because these CPUs have a hardware control (BHI_DIS_S)
> > that mitigates BHI in kernel.
> >
> > BHI variant of VMSCAPE requires isolating branch history between guests=
 and
> > userspace. Note that there is no equivalent hardware control for usersp=
ace.
> > To effectively isolate branch history on newer CPUs, clear_bhb_loop()
> > should execute sufficient number of branches to clear a larger BHB.
> >
> > Dynamically set the loop count of clear_bhb_loop() such that it is
> > effective on newer CPUs too. Use the hardware control enumeration
> > X86_FEATURE_BHI_CTRL to select the appropriate loop count.
> >
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > ---
> >  arch/x86/entry/entry_64.S   | 21 ++++++++++++++++-----
> >  arch/x86/net/bpf_jit_comp.c |  7 -------
> >  2 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 3a180a36ca0e..8128e00ca73f 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1535,8 +1535,17 @@ SYM_CODE_END(rewind_stack_and_make_dead)
> >  SYM_FUNC_START(clear_bhb_loop)
> >         ANNOTATE_NOENDBR
> >         push    %rbp
> > +       /* BPF caller may require %rax to be preserved */

Since you need a new version change that to 'all registers preserved'.

> > +       push    %rax =20
>=20
> Shouldn't the "push %rax" come after "mov %rsp, %rbp"?

Or delete the stack frame :-)
It is only there for the stack trace-back code.

	David


>=20
> >         mov     %rsp, %rbp
> > -       movl    $5, %ecx =20


