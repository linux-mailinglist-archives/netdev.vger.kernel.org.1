Return-Path: <netdev+bounces-257240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMDrCDW9hGnG4wMAu9opvQ
	(envelope-from <netdev+bounces-257240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:54:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2DF4D0B
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 16:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 640D03022943
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 15:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16134426EDE;
	Thu,  5 Feb 2026 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NsdhnNmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590C426D05
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306752; cv=none; b=T/4z8N6J/sTSo4iaHWlDGz6LiErYfVqLSDrMGMLpis598mvReXl4Vdxqd6lEG9Rr2aPAqQUUk5YoO2nEe7KG1okmJNobCXI4G8wA5of6n4r/FEd3UXJxwqY0VLLzmDfFQCCRqhCjNZwwFkDATYSOr2aBh9oNfMP7twxkbkAoJdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306752; c=relaxed/simple;
	bh=FNFL0/+E2aKnOvoNT9LImHUIIlRjvKZVxcmxb7yxYDI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Za4TWhpFe6hsNWxi3QOM8eOjavtnr6bQ2CSOCv/yK1EoOwOHxipq2YHUYiXExTvV6lfsJFmyUjh6anEterKoWv2FsOABw2wTnfHyw7wLJUNj5TyVtWRW9Y+iFxSANz9eDtebeIA4C3kv5G1cczRkSWYryf+zKfiiLGXCODH2c3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NsdhnNmZ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so11995625e9.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770306750; x=1770911550; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTu7qU8UN7vo13iwk65Itm5Hd0Cv+O0GXDEO+OULSSA=;
        b=NsdhnNmZZ+or54k3tuyagYkH2oSUJVSQZusPjtXF0o9co4Yavd9/67+CVje6lfG2GH
         Imm7ruzWxwyorDgaPrNf8XDPNEE5ga3JGo2ASBTBTjhKyJcfNnvRvwRtN5SuGLyuhabv
         S9o+pymxhEWJBc7Xkt7vYF+Nvd1YmnaIv3dEfm6XCXyFjvBRocdIRwxwJQdJOb4nAr76
         DJJ/6AdIYYeNxkfSL4nn2cwmbfJRP3SydAlttMcCVmbksCdxZ1/Pd5e1k/W9xcIghZRZ
         dKglZ5nT67KNqyF7e0tLcJn6w/3Eq6yiXiGxV7e777R8p8qgwuGOZvSil5zYcQLet7ar
         cCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306750; x=1770911550;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTu7qU8UN7vo13iwk65Itm5Hd0Cv+O0GXDEO+OULSSA=;
        b=u3//MpkPUll8XRBqjoM7Rfe7BWLpK17pNVuiwSpZhYSXsnGm3+QvFBoa5Bar7uOIRu
         EpyaMmU7CgbY9JGqZBha37XTmADZH85kLHYazUtaUUOw6AdQPg8z0Y1v+E6W7lc6kFI6
         CvL5ElnBfXuSEKxKejYv5W+bn6R4oNP7WiU3Qxrp1xtMolcgwUl5Zv8J1RgJtkQzZPkO
         /YWD4uBk2IEYJ+AZAiQsdBmAbPn82Y/ft1zMIdME9fnvTSUzba5ArsDC5jafWbB5rp2+
         +oBrmLe/gtkBqZm/JVMiuFJIqxp46Dyl1fN9HrbvRzhYUOaNQVZSL308aMdRwEyJ9HfI
         e5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3PSXSqNy1Eb1A9Y3WImohy5NZY8MBf4p+N4/7K8/frRuJnbPqcL+sSQMh/qrgp423dr2cXs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+mdC7m4O3w+w9OnRoc+7ZZfNS+BU64puFgkicdLr7GJjJKsg
	26qdVOD33N6p9EFEJKpHkHOJpV8bWkgbWeKKaoim2DJ5L6s+05Dddzkn0fC6Out0ejU=
X-Gm-Gg: AZuq6aJw5BDV+hiRQZkRjpIcJZ/hBdRi10pc8nrilzxAN46ykPFOHScu+PWITieRjfk
	vNYsDx4/6i2BTqar7atkIVq9nnl8zaRcwHIpSE5c9RUI1C7B7tvKoNHtQ96K0tcPpBxy6rmM5Sg
	0WrX9GU2a1al5g+bu08e13SKlgE22MYjKPTlh8Vfp5vh46CJS7ux3UrEPyrUuCpk3DoV+ck1XLe
	ow+BbNJG9rGClgZO3p7KYsfzRC8nIE/3cV9vpbqW6PxIXJErAQ7eKA3wbC/k9591yl5baOlCOeM
	xWz40nE5bmD/7md4ebw+p1f9BIUap9jSre4hS24K2PnHtjWQhnP2PqWNYPGkTRzgZOLa0Mg/vZ4
	tRs6DiQSLbrT36h6ONRRnYSVBym9hjyTSlo0XGTBtgesLxHmpOF71bFJDNXVgTagzu+z87flDeQ
	==
X-Received: by 2002:a05:600c:810b:b0:480:4a90:1af2 with SMTP id 5b1f17b1804b1-4830e979f7bmr95259165e9.35.1770306750051;
        Thu, 05 Feb 2026 07:52:30 -0800 (PST)
Received: from localhost ([2a09:bac5:327b:2541::3b6:79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436234781fbsm5263375f8f.15.2026.02.05.07.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 16:52:27 +0100
Message-Id: <DG75D8PWP35E.2MD9TYHOCQO9V@cloudflare.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <haoluo@google.com>, <jolsa@kernel.org>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
 <horms@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel-team@cloudflare.com>,
 <wferguson@cloudflare.com>, <martin.lau@kernel.org>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>, <bot+bpf-ci@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Allow bpf_tcp_sock() helper in XDP
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Martin KaFai Lau" <martin.lau@linux.dev>
X-Mailer: aerc 0.17.0
References: <20260204-afabre-bpf_tcp_sock-v1-1-a22b40c630c0@cloudflare.com>
 <167a8f4235973cd42372884aa66182a10fd17e50c70626b1fa0e659933e82b4e@mail.kernel.org> <917eadc0-9341-48d5-a795-8a7d5318886c@linux.dev>
In-Reply-To: <917eadc0-9341-48d5-a795-8a7d5318886c@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257240-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,google.com,davemloft.net,redhat.com,vger.kernel.org,cloudflare.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[afabre@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:mid,cloudflare.com:dkim]
X-Rspamd-Queue-Id: BCA2DF4D0B
X-Rspamd-Action: no action

On Wed Feb 4, 2026 at 11:27 PM CET, Martin KaFai Lau wrote:
>
>
> On 2/4/26 5:04 AM, bot+bpf-ci@kernel.org wrote:
> >>      But the TCP TIME-WAIT state needs special handling for this: pack=
ets
> >>      received for a TIME-WAIT socket can either belong to the current
> >>      incarnation of the connection, or a new incarnation. The only way=
 to
> >>      determine this is to compare the sequence numbers.
> >>
> >>      Add the bpf_tcp_sock() helper in XDP to allow the socket sequence
> >>      numbers to be read.
> >=20
> > Can this approach work for TIME-WAIT sockets? Looking at bpf_tcp_sock()=
 in
> > net/core/filter.c:
> >=20
> >      if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
> >          return (unsigned long)sk;
> >      return (unsigned long)NULL;
> >=20
> > And sk_fullsock() in include/net/sock.h:
> >=20
> >      static inline bool sk_fullsock(const struct sock *sk)
> >      {
> >          return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_R=
ECV);
> >      }
> >=20
> > TIME-WAIT sockets are explicitly excluded by sk_fullsock(), so bpf_tcp_=
sock()
> > returns NULL for them. The sequence numbers stored in TIME-WAIT sockets
> > (skc_tw_rcv_nxt and skc_tw_snd_nxt in sock_common) would not be accessi=
ble
> > through this helper.
> >=20
> > The change itself is useful for accessing tcp_sock fields from establis=
hed
> > connections in XDP, but the commit message implies this solves the TIME=
-WAIT
> > sequence number problem described, which doesn't appear to be the case.
>
> or use "tp =3D bpf_core_cast(sk, struct tcp_sock /* or tcp_timewait_sock=
=20
> */);". The bpf prog can also read all members of the kernel struct=20
> instead of a subset defined in bpf_tcp_sock.

Brilliant, that works! Thanks Martin.

>
> pw-bot: cr
>
> >=20
> >=20
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >=20
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/2167=
1977729
> >=20
> > AI-authorship-score: low
> > AI-authorship-explanation: The commit message style is consistent with =
human-written kernel patches, with natural technical language and standard =
formatting; the technical error is more likely human oversight than AI hall=
ucination.
> > issues-found: 1
> > issue-severity-score: low
> > issue-severity-explanation: The issue is a misleading commit message th=
at claims the change enables TIME-WAIT socket sequence number reading, but =
the bpf_tcp_sock() helper explicitly returns NULL for TIME-WAIT sockets.


