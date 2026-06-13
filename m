Return-Path: <netdev+bounces-298872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nG9NFqOvLGrzVQQAu9opvQ
	(envelope-from <netdev+bounces-298872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:17:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6BC67D6E7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:17:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=K4kSgTxo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298872-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298872-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 228F63046E86
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA835E95E;
	Sat, 13 Jun 2026 01:17:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A402378D93
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:17:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781313439; cv=pass; b=MBJkUMpiLLzP4NM5g7iMU6Xjdk1tngf6sEbTNq2iXzQFGQv3L4f4wVWemdFAiotw57H/Ecf1rq/53dYw8MB6k+irhcfEGtjr9iDI8M0Z+HCChHT3pHO4QNFN0cBkHy48HJdmd3pZX5CMtpDS6FSJ5ZG+nWkwFHHIOOeAiXVOxrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781313439; c=relaxed/simple;
	bh=Wvflkcn3jB5/doJiVnfIbcerKvWTcSlWg3fdngog73o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNabzotMwbqq8HhL9CZt+XY1rvf1O7dEuGKJ5SRwFD+dj19jwYGAaUFdl4vXswkp8j3Yjj6cYtbEF8aBELaWE0SzsVgSVDXrOmPBzOH+3q1t6GSCPNdwl0HfDbiqcLnBXarRJ8We0AYKUscYSri5rpt6Qkhk6rXVdTLG6kCvZic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K4kSgTxo; arc=pass smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bef8b97655eso431507866b.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781313426; cv=none;
        d=google.com; s=arc-20240605;
        b=OQag1BaVmqsJ+WVh8WWN666iTNI5SMTw7VRiDGNUUkcTZAg/YQWzfjSzce+XdsjCXW
         3jsx1ZouRiuEe5RvTZUN59dtiQNgdDuw45zjTGtXPlAGIX+WZcAQg9jUVYkiX8zzGGoC
         CtHwuMfPzt/elejHM2GFmU37KsrADIBy7F7Rkfn2q+3ngaYOv+fJItKCbtQy1fg7HZl1
         poSm5mq/A1UzIbqxkII/Q3krQ2p9wYZxQhkniaVDW0cZJncWDo8pqEsSM25D2sZ7YLHJ
         6HpW16q+9JUL6JKT2goD25PMkAfGothtNYu83wiuq5M0otNDPuVnnOk8kwoePxceOMYc
         BasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wvflkcn3jB5/doJiVnfIbcerKvWTcSlWg3fdngog73o=;
        fh=ztL+ZT+AjbyjsmIrH1VIX7lNxtf+vp2Q/3321EQDXkA=;
        b=hFnBQYLcf3SEWx7bMMDtJHtGhKglbzLksEtR83yXIpxGe6gUanVxfpyEwMiMLV3cZS
         cM5qdcn7+6vVtr+PSRXydkeuL/M+5F+Ex4pB9zGKbhnsxOWBqzW2ZbSLC+SAXW2sJ8gQ
         BKr6W2dv9PskDhrJrpPkrAIbgfbivdkjQZ5hxmirCPj+fjxB+Xc6vdUJ711vAHaIsZi0
         3Q+A6Hu6r9iK+jkTLoyhfEUdl7XA31pfktVFCfTxxh0ML2NW7AqJ01eKryES3taJYB2d
         yqYDDmKEz4onAXwind8no3gB/GjzjesjcTbS2tgf2gJDh+B7lohBoXEAbeysaIZ21sIJ
         Fwxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781313426; x=1781918226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wvflkcn3jB5/doJiVnfIbcerKvWTcSlWg3fdngog73o=;
        b=K4kSgTxoQTwzqm9LBvj+LHhMb6hi15qvjThRRy5F4scP2Neq3jIgfGAp6oYIv9nJIc
         x345tVX2X5achsijMDhc2+J8QTOdtpXS5hZNPpn2hJL2FwXNIiWoQwXXAr+bFT9Y+OqG
         SCGFLYi0CQb1Q/ipHjXnjd0bR2N6KeY29rP28EPep0jiuoZ05xuZSDyaInTVTCxS2PEx
         P8b4MZlZnsRwI/n+B1sQn0Z3G4u2F1Is5YA/kvQtIZfBBozYORnQqCS0zqkJRw8ioFKa
         T4ZVQPGv534w0p0SDeWBTQrTppv88WeHTK8aQpXSEfASPz2bYiVoyKk/Zu0fNjCEU0j5
         F44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781313426; x=1781918226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wvflkcn3jB5/doJiVnfIbcerKvWTcSlWg3fdngog73o=;
        b=g5Yto1pDaDHhx/Qg2DqWqeIyWMHlUg8hxh38N6m5d0bN6497FYVPDHJaiDtyP2KO/Q
         wuwb0R6lTptdxxLRqzDhCzNtdSdK0TPQKpzvki5Tdav66v6n27nB5ENZFfsulxOmtS+A
         Zz3FUPP9elJb/ar3UrCjiOBS7GuGGn0QV/ViMX8bBxE+A8y8LiVrYgI2T+3PDyeHaXhE
         dqZqMWwReGAViEHT4WBAdH+EdwJG+4/qCWQ2p6tDKFiPovOb11as08FxJ5J39xbUGJVN
         9ZT43gjgjxn3nKFtYeT2FIjdJu3O2ZJ3xaGXtnj/K7rN/tgwg13GpdZXc39JTcgSLRlQ
         1Buw==
X-Forwarded-Encrypted: i=1; AFNElJ8WVXqbbTSKMO9777gCy0q/VIBdspPMqDiCOWZW8qGAmuqF6wrT2oePYstIGkqJUSbzcROz3pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUVCqdIv/BPW4Cq4n9dwHTTE2iC0L2fILyIXdmmL4HRInEfku9
	Q4uj1xpWpqXma3c3Jrco7XXGDg3OOgq6858UQp/j8RAH0HBZP79E1TXFacbYbcEf21GaTVRH+fL
	YGJDRgp9dDi3RGZZK1YI8xWC0PiJD69OA/3jHi90A
X-Gm-Gg: Acq92OGLeUdkNZj0wqJCncIqItsqEoX1CtA3hsS4OGCv/wDyjJQFoiLS+tBq92Pnh8Z
	yOCDVIljVm8z1Cialk90j2LqUfc27sVX9tXOqA9/IC/K9zjKq53sIJKzVnb0VrewWh1HkUEnM1N
	fBTE+w9ksTkxWLFJTwCINBSzxYYDhRviTMub69scs+KEVtjEeZRG6EZz2XMw0anwArtMlLI46rP
	EPZNkO9etw9CeN4xcvTzyK4wsDoUuCGpI1hpSIMzWawqm2QieCXzZON68SQfSJPaM0xtp3d23X/
	uJ+gzkKgdM3RaAQYYxV4U0e4nbweEAbaUi9QAFvhDXi/CKTzR9RKt5MZdhiPojoq/UioxvtvJNs
	f6Q7uyNYLQ7YtzSY/DxIxC4CF2vM9ktc2eFQ0YYAI6I2AxIB1OZIk
X-Received: by 2002:a17:907:2d0b:b0:bec:1632:eceb with SMTP id
 a640c23a62f3a-bfde4c0137amr235351066b.19.1781313425712; Fri, 12 Jun 2026
 18:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612162517.83394-1-edumazet@google.com>
In-Reply-To: <20260612162517.83394-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 18:16:48 -0700
X-Gm-Features: AVVi8CfhxtMbFbcaEpiZWZ3Asqw4nOx85NBsDw1etOFnaSRZqrdm6oqJ-1oyNj0
Message-ID: <CAAVpQUAFVqQYo2pETE0qfRP+y-ohUeng9hTBJRKu8eA_pFrV_Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: clamp default adverting MSS to avoid
 GSO_BY_FRAGS (0xFFFF)
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:ncardwell@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298872-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,ebdb22d461c904fc3cb2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F6BC67D6E7

On Fri, Jun 12, 2026 at 9:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When MTU is large, ip6_default_advmss() can return IPV6_MAXPLEN (65535).
> This is interpreted by TCP as mss_clamp, allowing the MSS to reach 65535.
>
> However, 0xFFFF is also used as a magic value GSO_BY_FRAGS in the kernel.
> If a TCP packet with gso_size=3D0xFFFF is passed to skb_segment(), it wil=
l
> be mistakenly treated as GSO_BY_FRAGS, leading to a NULL pointer
> dereference because local TCP packets do not use frag_list.
>
> Fix this by returning min(IPV6_MAXPLEN, GSO_BY_FRAGS - 1) (65534) from
> ip6_default_advmss() when MTU is large.
>
> Also update the stale comment in ip6_default_advmss() which suggested
> that IPV6_MAXPLEN is returned to mean "any MSS".
>
> Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
> Reported-by: syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a2c3193.8812e0fc.3c3fa4.0001.GAE@=
google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Interesting !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

