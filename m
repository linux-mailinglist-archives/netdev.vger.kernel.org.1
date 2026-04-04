Return-Path: <netdev+bounces-275395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JSUhLWUs0WnlGAcAu9opvQ
	(envelope-from <netdev+bounces-275395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:21:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0539B936
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B66300B077
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D2B2C1595;
	Sat,  4 Apr 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGanoOHp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A55129E0E5
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316064; cv=none; b=Zbo25GXXYeON7nsN0asv6J/jqT4FPesLPwnC7WxV0ClpxeGbdP7IcOvRcpYHSXpubZQVW6CpQEvL/wNo5SvNTnVukmTC7Dg19L4IAxLJuk6uBS+HMDlVwN+4WaiNBccVUnpNMLtmkIJiYWvPID3D1q2hjsM7h57pdSLNduedHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316064; c=relaxed/simple;
	bh=bwi3fwqRL2gMkBWbXUNgaSztWecB9cnkr2OnSeMSIqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqlenGHuW7rTgVv8kuxT1o0TpYPfd5nc5YxLCVNo3tRHWSNAXjO/Ja2dGd8U9cF+OfxN1zQyi4pnldZNmsox7Jtu+VMvROPxmIto1zYymEReZ3vDBbUt+2rvzmK4TfL1ZNkExbHGCXg5E1ltdRJ9G4hJJ9Yz3InX6iJbHuzMY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGanoOHp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-483487335c2so27267055e9.2
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775316061; x=1775920861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ya15IHYt9XPwJn5C1FMw2sI/phhivTNLETw1ZpFU9KY=;
        b=OGanoOHp1Zebwnc8FiqdpONklWtKx06Rr45qyxbCocloiS8fxa8iA2zxTmNm/Qu7Wf
         VN8M6Pr7OfHLyuyvXYEZ4EZ68bhyGem1zY6KrDcE7g7S6r26KeAiwEZo9b06n9Jtp6Rv
         BxxulVNC0YiKuI4s99+yQfYr2J7LNeSXHag3RDmeZlTJzrmp3L/ZfskOtQKnOr0mUmjP
         mk3iras8E6HQWO5Yj4VkGJcvDk8Qc3Bm1dACNRiz6mw/BXRt07cv/hkWsv0Fo+XMUyaf
         7u954wAEsv9AOISAchZoazK0ZpZI7/a939lfNU4++L4MkxWVyI7PFJ5OiaxNu7q+Mo8f
         s19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316061; x=1775920861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ya15IHYt9XPwJn5C1FMw2sI/phhivTNLETw1ZpFU9KY=;
        b=TLEuflxTVJl2tvr3iRzwAWGZDJaAzaqwo5SNsu6r2FDLW6lKNaT10DiqJmgnddcwDx
         fc1UtHSI1RSRtZftO2BvAQVTLx0p7zuF2WI60k8aXsdPgP+l0Q0DpNp0ITzsFeWzxPKS
         NwMvp1tk0CECm6RiIuGW5Jr5Bmx8gpVFdr8hFfDoqps9Scmlmwj7cjInfHPKJjtrWk8U
         rL8WttXMOmX1k1DwgZFGrxVCWvOoSbw4VYEecFZjxN6yMyFevzeIHr+wkQkNFPMTsy9B
         DlsXNJTG0S1vLiT9dCduEmcjwrQNZjsMUW8lwMN47r9I1NUJtTag/OwCmkhLrtlD3vo7
         5oxA==
X-Forwarded-Encrypted: i=1; AJvYcCUXP2Iz+2Sw6kP/tUb9PjP0lqIMk0Wm7HBwvu3KXoO/J5BVQCu7poUqmD/7ojAz3UjEFIlIy1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWK6QEHATXiotDiOJyo2ZdGM+dvmVi1ZlNUOaBQPYRPn9Wa8P+
	CiVNKaH9IKcsY4jPUwnYlUg4tEolzFDplIlbc2t362clQk9ubacyh/uF
X-Gm-Gg: AeBDiet5vr/573sB2isdICJtJBxQ471qqjbTCALxuwMuuBQO5pmEqrsqCTuqP9rc96Y
	iFPFF4LBjpQKmik0JlhaMVsPfOIocdxj1x7+T4m1oY201a2kstu8f0LscJnjhGtd+n8lJThKy/Z
	LbnKfxcKw9XpamxMy2dIBfQpxad+1LtP4Y4o62OMEiHR24PtxuuIvFUa8UNoz+M7Z7+atgJA/Xd
	hTKqDPaWJfnMl8fK2AKMUD054M7dLXmHkk70BjtdROwj6mZhdh8LZjMbJJ2AMsOGYM6b7Nq/7sc
	ca/gxL0jxNt2h1Thv7SnTeHHx4RXPN33ZJq0xB70WMLMd13jd9nvZV39VziVo2YdZ0ZRqnAJYh0
	NULaHS951Ny4iuhaLmtbQ0rvBmjwt2PiI4LQArwBLF4BpQ3xgh3i/9qNdgfLeCA2U31b9hdBkxR
	rx0tib5cBvvteIaUCc7A2LsZBAHQ3PwQ==
X-Received: by 2002:a05:600c:4650:b0:488:9e54:94c8 with SMTP id 5b1f17b1804b1-4889e5496acmr44565465e9.31.1775316061052;
        Sat, 04 Apr 2026 08:21:01 -0700 (PDT)
Received: from pumpkin ([31.55.121.85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm25182762f8f.31.2026.04.04.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:21:00 -0700 (PDT)
Date: Sat, 4 Apr 2026 16:20:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, Jon Kohler <jon@nutanix.com>, Nikolay Borisov
 <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, Sean
 Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 00/10] VMSCAPE optimization for BHI variant
Message-ID: <20260404162059.34ca90df@pumpkin>
In-Reply-To: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
References: <20260402-vmscape-bhb-v9-0-94d16bc29774@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275395-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[kernel.org,nutanix.com,suse.com,zytor.com,amd.com,google.com,alien8.de,linux.intel.com,infradead.org,iogearbox.net,davemloft.net,redhat.com,linux.dev,gmail.com,fomichev.me,lwn.net,vger.kernel.org,intel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: CFE0539B936
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 17:30:32 -0700
Pawan Gupta <pawan.kumar.gupta@linux.intel.com> wrote:

> v9:
> - Use global variables for BHB loop counters instead of ALTERNATIVE-based
>   approach. (Dave & others)
> - Use 32-bit registers (%eax/%ecx) for loop counters, loaded via movzbl
>   from 8-bit globals. 8-bit registers (e.g. %ah in the inner loop) caused
>   performance regression on certain CPUs due to partial-register stalls. (David Laight)
> - Let BPF save/restore %rax/%rcx as in the original implementation, since
>   it is the only caller that needs these registers preserved across the
>   BHB clearing sequence.

That is as dangerous as hell...
Does BPF even save %rcx - I'm sure I checked that a long time ago
and found it didn't.
(I'm mostly AFK over Easter and can't check.)
A least there should be a blood great big comment that BPF calls this code
and only saves specific registers.
But given the number of mispredicted branches and other pipeline stalls
in this code a couple of register saves to stack are unlikely to make
any difference.

	David


