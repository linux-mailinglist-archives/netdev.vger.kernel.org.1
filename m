Return-Path: <netdev+bounces-276087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMoxBLw11Wlv2wcAu9opvQ
	(envelope-from <netdev+bounces-276087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:50:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0F3B2090
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9A9C3021C2A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F83D090D;
	Tue,  7 Apr 2026 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1iwIll7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F433CFF60
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580383; cv=pass; b=u3Qzjo3EBiX8lIdPO9UyE212XST8FXGk5wykIb+7gTW021OSQCLM86eTU248mQp2ceQUrA9VnateMaQKy3hbKDtg+3CUjJwc2thqDVoghSJ6v224yxuMiORxlQp3KbRz9Yyv9o3GUMkTI4El9550SQCTJVC+Q9DAwxu7wW4FLH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580383; c=relaxed/simple;
	bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BANBRUfNj/rZ32reNSbEr8VB2Ju+VIqdP4Bw+gA+3v/PxiOed/S4E2t3yEIn5tr4oY0aCcrNbDixLm4WWO+v/fKigsu2KVEAXzZIClt9Pm2myzhiRoEaMo02FxVMu3OZz7syqZJagvRlB1vglTmvqrn41Alj1q5kMw0QUlbRkb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1iwIll7; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bb7118c96so224a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775580380; cv=none;
        d=google.com; s=arc-20240605;
        b=Y2nRNPHnsqmIkSTS4YTlNTgoSgguprKdAmICfh5WYwTjWh08NvJxqa6dTJ1jzCba4x
         prfdRTsN0v2I1pjlRAUK6U3+Z6/CAUTO4EoRJ9B2Ob76mYkAh3hdEp0JzqdgCVgaFqQa
         ujOuUfS8XPqCnvVuVCqsPnOELZt2o0Ha/xafZGWUa9AOqp68Np0BM317i/po+jMDG4N9
         whcuwJfNE+ynhgQrjJb9Lr9T2qGxogUVyW+Z11Y0BFXk2wxOsOvaTli/TH67yT1Pzdfs
         CoR5WfTsDYMIMwI4gsv5jT6dVMohnsPZfSgGaD2kyLZzxMKT1H6BG1e7flv0dnEnb0m/
         LQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
        fh=E/eS7guy1bWZnPpckcDt+rNouoErlg+bWdi3Gg98Bqs=;
        b=g+Opq4Y5pQcyMlBqwjZ3vqkMABvHO9zib+DmXmp5/1zlDOpSx45iMvw0kseiR4uTme
         apQRHccj3/RVCBUzfYz/KOwTe0GBpNSM9zJKKlrL8seKZoQwoAa8unq7G/kQpAZYPgls
         y462JU+VsMo53C2xDRW8rK8Ca+Sz+5uFqKaJFxW4V5de1GBosj7c9kzrn9u5GfJ5bIIb
         m/kfK3j5nEafpY6G/JWVNQ5xD7jfVfuHF93XZntusRZwMrTeVlMEG41dH5xkF0s3ArK/
         vsyQR0SaPzheVAGQFMYqNRKY6sc3C/BtpF4CdqOVok6ztr9yqh4WTrBTa5uIvpA5JMN5
         UcNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775580380; x=1776185180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
        b=k1iwIll7s7MWVnBwB6US1VssQV1y+kSgffte48gmfDi5eZeYqjvlrktIkZzFmn4vW1
         0POU5UEc79j/+z1pTIa04fFcsvezE+kq+DpUhlpWqMqB6LTAkRUhRufM0HVNtNi/qMLN
         ZV6YXLnGTxGgGUw6MwnGgcQLVoWJA7Hc4VyOpaY5nA4XIw0O8R4A6KgAnsgpBB0IcPTZ
         nbyc6z+qfNORRG2MIUH4MSKNWyFdcOFQ1wMQpRpq5LouT+5MONKcisR7ErOeRaoDzFCX
         5IaXTu5B+OrQBK8TsGfZPUKIozyrnK8HEp97ZrUs9AP5TXbYajcDf3t23Jfjmva+61qM
         zZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775580380; x=1776185180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7agD+s2GVFy+3GJ+9lu9MNOej8X0LlPEbU6wsUyTSxI=;
        b=OUP3+ytNmMZxmZiVeYq/h3yZdvixecHCXPVuoOAyfIslA4UsggvmXMLf/J0Br5lmvT
         SSzgkRlKWo/DeB4Lrmpc36cVtPe8bOrbp5joyeblcaIEwaUY/Dij68gQxBHDyAxyj/8N
         6Dl9qZrTQOuqcVDgJzXL+XoKmB/6H0MX6Fdbm1FUvD2o/rFznQ1YxQjUNK+u5BNTEX2K
         J08nORQ0NBfRRbwunhO8b1gW9NSEPb+Znmwxms8HxtuP7LWkLYFMf9nKRlY4HWpHuAiw
         iKPCIp6/vn8Ntq7MUS1A9my3/zNQ04FXhA6s9HJ+d4kAr9ZDZPD3uUXj1Rq6y/yfozq+
         Vuug==
X-Forwarded-Encrypted: i=1; AJvYcCXVfO7dy8N1lMqL6qj51qCGTNnw80h16RjWfkPliGhS2yY+BI/tJUBmY3ohk2z5UocbmTUKbZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cBQd6h96PNWBTwaCVyVq1Jvf6FSgD7yIRtpN+6TpAaXMEllz
	ef2vlsE38/eo04pg8XsFa+UpOO5UVI21RoHANFzToQpkhnKeJ9oQ6CQNOGgpeQLYccRFNdQD+vj
	NsjaiaZyFmmWFBbegcsL1ab7KZn6kB/tS/cYMGRiy
X-Gm-Gg: AeBDievZn1NwOYOeaXdh403jqH2MKi/eZFTwP5bEHfcEIHf6h1tbN7JgyOYG0eEbJFo
	hxJIce36OAyN6OvY9ae3eBsSR9mAKi8nc67k3kMfoBtCPL412zO7bVzNdZ/XXX/k6Lm2FeTnLbi
	Uqs+u+M+IrLyi9szu7xsn3U2vydbHc4ClbJmf0CXJg4mhCY4WhMn4TmZb6rRfvs9RF0HOYpnS6U
	tSaBnlOsB284MrL4e4Tq8hjT5WqdOoO8GOwwmBBfR4eS6o+o29NTXGKfcv1/KiFlsrU826bjK24
	IbyNJFQ=
X-Received: by 2002:a50:fa85:0:b0:66b:b4da:a8b0 with SMTP id
 4fb4d7f45d1cf-66e4136b3b3mr175238a12.8.1775580380060; Tue, 07 Apr 2026
 09:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403213445.xzb4rxbfbg5un7li@desk> <CALMp9eSXfJvR=PHtttbqm3q3nH436T1eH4YdpVqxQeP-cxEPsA@mail.gmail.com>
 <20260403231608.zopnhnypdclzqlx7@desk> <CALMp9eT2vJBdLPY2uBYrPgVrhS_aYmfGfdXe6MZXG_gyryLHVA@mail.gmail.com>
 <20260403233329.fb2ppifgwm3um6ny@desk> <CALMp9eTpsenqsWjzmpXLEubn9uNjgZgzgrMwtZ72HDuV_2xgfg@mail.gmail.com>
 <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk>
In-Reply-To: <20260407163943.y6tkh26z2rfktn3y@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 09:46:07 -0700
X-Gm-Features: AQROBzDrMOkL8K_5s_beeAF8mzcDjUMut0mXG4FWeqy0pjkeXMr6K1KiSjqSI94
Message-ID: <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276087-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 07C0F3B2090
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 9:40=E2=80=AFAM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Mon, Apr 06, 2026 at 07:23:25AM -0700, Jim Mattson wrote:
> > Yes, but the guest needs a way to determine whether the hypervisor
> > will do what's necessary to make the short sequence effective. And, in
> > particular, no KVM hypervisor today is prepared to do that.
> >
> > When running under a hypervisor, without BHI_CTRL and without any
> > evidence to the contrary, the guest must assume that the longer
> > sequence is necessary. At the very least, we need a CPUID or MSR bit
> > that says, "the short BHB clearing sequence is adequate for this
> > vCPU."
>
> After discussing this internally, the consensus is that the best path
> forward is to add virtual SPEC_CTRL support to KVM, which also aligns wit=
h
> Intel's guidance. In the long term, virtual SPEC_CTRL can benefit future
> mitigations as well. As with many other mitigations (e.g. microcode), the
> guest would rely on the host to enforce the appropriate protections.

I don't think it's reasonable for the guest to rely on a future
implementation to enforce the appropriate protections.

This is already a problem today. If a guest sees that BHI_CTRL is
unavailable, it will deploy the short BHB clearing sequence and
declare that the vulnerability is mitigated. That isn't true if the
guest is running on Alder Lake or newer.

