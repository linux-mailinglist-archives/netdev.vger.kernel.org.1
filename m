Return-Path: <netdev+bounces-275502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBfqFZr20mmzcgcAu9opvQ
	(envelope-from <netdev+bounces-275502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:56:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D11F3A06F8
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42A2D300A59A
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 23:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A7C38423D;
	Sun,  5 Apr 2026 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="U9LzxMCU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB2438236D
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433271; cv=none; b=Z99ftUGboap9lGkWviIrZKdpeQFjHqyVik3RY2Qd3eZqSmoxx5+9dxrz5BgpKY8DPpl4RUHvzDspTnd33cyFfUUt5bNpFLl2Jx5ewfOye305fn086WIdqdRya4vB1guXr4u8UD46jZm1jM6xnatnP8OcC9IVU9AYUXoVeqEc8Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433271; c=relaxed/simple;
	bh=nnE0n3Olzcs3ikXxyvwZtpvMfL9A+g+9v/5VhawH40A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=W6XR8iycbQLB66JkWb+du00Z2dNPDt1FiomFeRHxtwPsnqHCFYAhTNbe9MA+HnbkFOANsmJ2UmO4fMZos+vypNbUpEaV6T9+Mc1kyvqT+/5I8u9YpJbKJlcmnDVAm3P2LqkWaSgbB70BRlE55KSupkPcEkntf9ifs3uZqtXevHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=U9LzxMCU; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c76e702e01aso249025a12.3
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775433269; x=1776038069; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw6TUPdhywhOpcOC9GSGOxp4/imbBV1U3y0bPk5X3cQ=;
        b=U9LzxMCUK5K16ZcZB7U0D/DbvcJEUt1UxaY93bJCFmc3iRVYJ+FerNMjAxWiw7DRSU
         ixfH2HkFIPPFgqcwUVoIeVO6TaJBq/kBmiV6EyZ5HitJ5aGRX9E9JZ1HaqBxgvT/ivU9
         S2gcXAB2C5zoHL0JB34zljHilBxfR7jLGBuK9Ujb6av7289FABXjAK/A3CW0p2WLHrP5
         9xvwsQaYOs59XYlcWAxuHEu4h85CdpblfYVRAk+6LDiZBzmpI0FrWEdG1IVOGVAYL2l2
         gOeeTUt1nsIkp4sJPOfjVMyjqGlbV/I0cj55M3muht3lhR+/8OnF792NfoiFFPW00Bqw
         Yh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775433269; x=1776038069;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qw6TUPdhywhOpcOC9GSGOxp4/imbBV1U3y0bPk5X3cQ=;
        b=LcmcaD40aWjyysPziJSHsU7vov2eXuN3vU819QswLu6+npG2RFZ7HO5EKeQkLsLS6i
         nGWvwTGTpWX1QrIvY/jm8a6Np4wQu4prGO6Yetm9QYyNgtnJxellNuoV9yeQw/QBHyIt
         Gl5Mz4yBhjEs4gJAJ4JMY/uJFu4OrRToHWwr0Ciq0QJFDWktoxJaOiY9KJZ0wFlHRAxS
         TXHZnKPY/NBBbNYC9Ggrp4Eiba3Zk1PYWx8Rfl/jNPwZHvk73KPJwYyKZPWULJQVHfb3
         sV3+PZzEGBQ3RBIKwXFCWPw2gBcRSbYKBgZk8Jlb9X9vJDKJQpCmPojOis/7nAaKq3Y4
         0Ftw==
X-Forwarded-Encrypted: i=1; AJvYcCXM6DV7RxWDBo5CvZLu1uEb4Xnq8B/sN4oWnEL78Z3b47QKkMxyajwQoM+2iXCAZIZ39xl1xsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3jESJU8of9iOwlzQAamDPcYEyAt0lynM4Cvv85xPmPQzgCwT
	USjAw4tRizXVJVUuKPaEXYE0+18Vvq0ilIpkOGus/jSJT0G9qym0fmspqHZHHZiZS00=
X-Gm-Gg: AeBDieuRLtjc583Jowmmc8XrbkZifdMcP9ETcSYUfsW0uDO3+OR/ZymUrSFYUX8kfhn
	iZ2c9D+3SZL6+ssZY0i+V3kxXFJJuEMwCxDnII2n9w/giklMajLSB2k5qLyLkBZSfNSipN6GPqs
	HqX+LP1VE4/Ye2XHDUd73jk6Gsz/qmMU7LLaHACA9X7/+vo7bj1nI9NsqdMRszeaXjiXPQ5embt
	np/k5mC1frbteAG+vMgv3mmSCyIi6CBwKQ/7OLdT6Tgy4Hv9ChIKpG+GUrA0AlVLkENEVH1IKUY
	ATSqzyUH5n2wXy7EcVwrqH9tFjdxjZRxDCewRR8sJm4jbMojyrwcGDS4FVNGr+w5QOaRX7soOZX
	L/kNDNPDl/EU4ksemrfbd6lDUb/aL0o3BXUB69g5hJcjwVpEOy/weDaSraLmXOUJm77zvokKdJa
	sbhP8ABp4=
X-Received: by 2002:a05:6a20:7f8d:b0:39b:f026:6f79 with SMTP id adf61e73a8af0-39f2f0f86e1mr9364005637.21.1775433268959;
        Sun, 05 Apr 2026 16:54:28 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6561fe9sm10324516a12.15.2026.04.05.16.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 16:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 19:54:27 -0400
Message-Id: <DHLMKFBINRKW.BS0BEK9AMU86@etsalapatis.com>
Cc: "Quan Sun" <2022090917019@std.uestc.edu.cn>, "Yinhao Hu"
 <dddddd@hust.edu.cn>, "Kaiyan Mei" <M202472210@hust.edu.cn>, "Dongliang Mu"
 <dzm91@hust.edu.cn>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in sock_ops
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
 <DHLMGWNKBI4K.3LM87NOU4XB3O@etsalapatis.com>
In-Reply-To: <DHLMGWNKBI4K.3LM87NOU4XB3O@etsalapatis.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[std.uestc.edu.cn,hust.edu.cn,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hust.edu.cn:email,uestc.edu.cn:email,etsalapatis-com.20251104.gappssmtp.com:dkim,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,etsalapatis.com:mid]
X-Rspamd-Queue-Id: 5D11F3A06F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun Apr 5, 2026 at 7:49 PM EDT, Emil Tsalapatis wrote:
> On Sat Apr 4, 2026 at 10:09 AM EDT, Jiayuan Chen wrote:
>> When a BPF sock_ops program reads ctx->sk with dst_reg =3D=3D src_reg
>> (e.g., r1 =3D *(u64 *)(r1 + offsetof(sk))), the SOCK_OPS_GET_SK() macro
>> fails to zero the destination register in the is_fullsock =3D=3D 0 path.
>>
>> The macro saves/restores a temporary register and checks is_fullsock.
>> When is_fullsock =3D=3D 0 (e.g., TCP_NEW_SYN_RECV state with a request_s=
ock),
>> it should set dst_reg =3D 0 (NULL) so the verifier's PTR_TO_SOCKET_OR_NU=
LL
>> type is correct at runtime. Instead, dst_reg retains the original ctx
>> pointer, which passes subsequent NULL checks and can be used as a bogus
>> socket pointer, leading to stack-out-of-bounds access in helpers like
>> bpf_skc_to_tcp6_sock().
>>
>> Fix by:
>>  - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>>    added instruction.
>>  - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>>    restore in the !fullsock path, placed after the restore because
>>    dst_reg =3D=3D src_reg means we need src_reg intact to read ctx->temp=
.
>>
>> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when d=
st_reg =3D src_reg")
>> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
>> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
>> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
>> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
>> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787=
@std.uestc.edu.cn/T/#u
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> This patch only seems to fix the problem when dst_reg =3D=3D src_reg.
> Why is this not an issue when is_fullsock =3D=3D 0, but dst_reg !=3D src_=
reg?
> In that case the dst_reg is unmodified by the whole macro but is still
> marked as PTR_TO_SOCKET_OR_NULL. Isn't that a problem? Can you add
> a test case for is_fullsock =3D=3D 0 but dst_reg !=3D src_reg in patch 2?

Sorry for the double post, but also check sashiko.dev:
SOSK_OPTS_GET_FIELD seems to have the same issue as the
SOCK_OPTS_GET_SK. Can you add the same fix to it?

>
>> ---
>> Apologies for the Easter timing!
>> ---
>>  net/core/filter.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 78b548158fb05..8fee00e6adef4 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -10618,10 +10618,11 @@ static u32 sock_ops_convert_ctx_access(enum bp=
f_access_type type,
>>  				      si->dst_reg, si->src_reg,		      \
>>  				      offsetof(struct bpf_sock_ops_kern, sk));\
>>  		if (si->dst_reg =3D=3D si->src_reg)	{			      \
>> -			*insn++ =3D BPF_JMP_A(1);				      \
>> +			*insn++ =3D BPF_JMP_A(2);				      \
>>  			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>>  				      offsetof(struct bpf_sock_ops_kern,      \
>>  				      temp));				      \
>> +			*insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);	      \
>>  		}							      \
>>  	} while (0)
>> =20


