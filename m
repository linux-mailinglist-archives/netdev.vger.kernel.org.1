Return-Path: <netdev+bounces-276204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEbvEgqT1Wnc7gcAu9opvQ
	(envelope-from <netdev+bounces-276204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:28:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C20293B576F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17AB3023DCC
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 23:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F8738CFFB;
	Tue,  7 Apr 2026 23:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4DGUQhl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A73876C5
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604480; cv=pass; b=jOP5g41cvyd+oAGdzcQKoMb1KXVE2uFFzEhWzfvVupBdd55IcpRJ3Gx8dbnRLWXhD/fO959TbNHUE+g8/5iny0kMANgDic5rhcI3hlwOMA+POZvMiva/0ivx027USBIBneQcYmuyj84jjzy3asVrXkcKDa+B17bcRPo84c2Yz5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604480; c=relaxed/simple;
	bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yw7g4vVozGKsZo2HwstNdfebeyS1e+Y9ad5pD9JVmiik5mXhk5Nsk93omY2y1jUixDl+01/VVsBPZMO9JtN1CmaZLIsESBeMHkJWzkGN3YHmrZMFjqe9HQxuPShgEuNnT5KaZOWCuag2DtW2OyiZkPRSeHBsB/lL1knQyycV9pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o4DGUQhl; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so2572a12.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 16:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775604477; cv=none;
        d=google.com; s=arc-20240605;
        b=QXNNsEe/d44MeLIYtgS+XssWaUzeUb36u5cW9/Wd4Tt4INKCh7OXsWDfAK9sTbFhZ9
         4ws2N6ICSixLbhfgcDj4ZXk0MYcDwRySNZhBB28TKjXW1Lkrpa08aL7rWFy/VthlgYkR
         IqEL0VKolFYgH858Q45sAp3/hwlw2BqaA++mfSpRZfaTxkQ2mPsupEBcZ27jkSQ8upb7
         aRDMHdLpRrCw3oDRxKELbqAmS4+grJasRmlBYdT3hCr3snLlbRZ9Mrh20EyGtOUv8h+r
         BQRCWPP4WMuiDUsG7LiWhHLNWn4CfpR6feYbXKOQv5ssEo/nh1IZTjzr2R2t1sGNtk9T
         sREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
        fh=UHbyF+KSSoFbznEdygMELaRf1WUom6bUttbS8cEVt9o=;
        b=hLS06KNjPoGqvmTapC6UamAE3xEXdXYF+rdFKsd+OeKB06hHIPBWfPISuQz+J8Ywu0
         JAt3cBcjbtFvWf1ZSF7XQNnCPRhQiONkqpgRbq6VRV0b3Wlnzjht6YJEwetcAiqg51dX
         rYE52ApWKoAljTG1S3k0u4ys4GATk1sSTmPD6QdbrwM0H7pQsmZiwV6Ain8Wy5Fs1xuS
         GNwlON4tbfWg0cRawjRe3zqw5eGSMq6knNwCHx7i3BzdJa7rdmMKRgX0WARIca9/ePKE
         C4lx2+7xevOP1sB6CyO73WZhYPqAY+aUhmBBD5/1uNqjvmxt8sv4BKpAzno/+XEPoqfV
         1Ibg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775604477; x=1776209277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
        b=o4DGUQhl324AQHf3NZyWq698l82y3qvXGiEoliiKvgS7bvqcahckh60klXj1Uc0F1V
         x1SIiZRBfhI+WzVmwmn3C4g+XblT6oq4ljrBEvTjC7FGJ2L69LZgvP1/vRkisoqQLtas
         Sf5ZgP5OFSxrACKZi2tli0kYjmj3EweP9buEhG+9jzYAE3ErF5YzqJw/umbxCnzab1ZC
         TB8O1GOtR0QZRWmcmE0C+/FYW2n6lgeDZB15cry3QZZ6z3nw9d1aLElE0qCPwY36MyEM
         du16YI6Tm2nzVaDjlftrtJM0zGybJkwFW+01vPN8lZOuOXkhHmUA5qrzgEmg4Dme4EkS
         CWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604477; x=1776209277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbnetPts9zzI5j/EfgcrPgVFzL9OQ52ypHZ1fkR/qyc=;
        b=A0mQE5nzlQrXh7LYcptQCbgscqb2FvdrlvrzPmQcGEGko84lQT5HYQkn7icSFcqsMi
         yeK+5BYZlKDafklQwo/EdPBoTGpBow54tUqtvUhsZ1fo1ZTSg6/LvDeBMPM539TusVks
         tgDMonWl8J16teCDrcZ09b/wUC6aJnCubKtS1QFZVcK91VYI6ljHJIyowho8cYzVAR/2
         UxQGpfIRdexWXyjkHPoUIvKSIg9hlSgMyQ/8pZvHShgekP0kLBEdqGzJ42A1nt1Ef3Rj
         oKnoA5dgNtqtPjt3qgW8cXdOfEp9LmzvwYvMA9YYtb/mnbUYZ+8g762xTftBz+ipTiB6
         Tw8g==
X-Forwarded-Encrypted: i=1; AJvYcCVE87gCdk4PT0O9wxPoqCGi8MHMfCL3t4mfDJZkt6eWd9OV9IHDdEbCYZ38+yMIGe0o3WG2kak=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi7kRxx/8+as73/MyYNGaWC62ghKZB5vtewBxY9QQmYdeyQtLS
	Uvku1Rr711iino2541W+CkRRX7tKGVW20eRzWHUXIfcsR2i5WDeeTm071UUxXlC5V2F78UZS2qv
	Hot6ZXEC+9/IyKGQwzk+JuCDcQ9qhyyXQxZRuJUZh
X-Gm-Gg: AeBDieuiXrT6vtO4TyB5iRQJMStNKezG0J78PDQfTPyy45oPmHRoLK7cSroTWTkk5UX
	91l6aWDNDvK0k7egKbu/NH+uzKPmumlz40CnZWBpeMcdK63XMr1FbwRvHDJPeLWMmSHcwhcXXh/
	qfq7EDf3gt75Y1nNHflxdDKYgqbPuBaOfubRnuQVXBVILPWVmpRJljB5DP+33z3c6ldjXHWCuiu
	iPdECd8CZb4Czmgpozm/4tIAHfpwTbRs4SoXbM2uzKjeThjJBVxeWlazZu1bN9Pd7MuKZwn4syy
	tvrISH0=
X-Received: by 2002:a05:6402:5192:b0:66b:b6d8:c0f7 with SMTP id
 4fb4d7f45d1cf-66f9e8a747amr11450a12.0.1775604476364; Tue, 07 Apr 2026
 16:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk> <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk>
In-Reply-To: <20260407222738.lrartp6evfp7yhti@desk>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 16:27:43 -0700
X-Gm-Features: AQROBzBBo6GfpOq19SORVT29fsvEw6HsoB1rD-rISQykjQ6bs3K88dpb-buaNTY
Message-ID: <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-276204-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C20293B576F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 3:27=E2=80=AFPM Pawan Gupta
<pawan.kumar.gupta@linux.intel.com> wrote:
>
> On Tue, Apr 07, 2026 at 01:53:24PM -0700, Jim Mattson wrote:
> > On Tue, Apr 7, 2026 at 12:11=E2=80=AFPM Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com> wrote:
> > >
> > > On Tue, Apr 07, 2026 at 11:40:57AM -0700, Jim Mattson wrote:
> > > > My proposal is as follows:
> > > >
> > > > 1. The (advanced) hypervisor can advertise to the guest (via CPUID =
bit
> > > > or MSR bit) that the short BHB clearing sequence is adequate. This =
may
> > > > mean either that the VM will only be hosted on pre-Alder Lake hardw=
are
> > > > or that the hypervisor will set BHI_DIS_S behind the back of the
> > > > guest. Presumably, this bit would not be reported if BHI_CTRL is
> > > > advertised to the guest.
> > > > 2. If the guest sees this bit, then it can use the short sequence. =
If
> > > > it doesn't see this bit, it must use the long sequence.
> > >
> > > Thats a good middle ground. Let me check with folks internally what t=
hey
> > > think about defining a new software-only bit.
> > >
> > > Third case, for a guest that doesn't want BHI_DIS_S, userspace should=
 be
> > > allowed to override setting BHI_DIS_S. Then this proposed bit can ind=
icate
> > > that long sequence is required.
> >
> > That case can be handled by the paravirtual mitigation MSRs, right?
>
> Yes. But, that was the part that received the most pushback.

What is your proposed BHI_DIS_S override mechanism, then?

