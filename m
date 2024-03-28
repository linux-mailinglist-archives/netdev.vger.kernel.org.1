Return-Path: <netdev+bounces-83059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA789094E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 20:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDFCB21644
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC63137C4D;
	Thu, 28 Mar 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RprfkRrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtPqO5pq"
X-Original-To: netdev@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A124142AA1;
	Thu, 28 Mar 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654496; cv=none; b=aMg2EMlWa8zKD+Frctw42ObCIp/yQTMmG4455kCoMBVIJTlPjR4EaPDdE98c1mCMuV2xyvVa3pfYpEsv2BdaSLMBQOGzgYFpunzeuOla0dRoQKvqb0ZcrSwBGMQDpJiOnJIBicjpg3GBjNEmJjkl7AuSgYwvRFxJ9kAs+E8wPiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654496; c=relaxed/simple;
	bh=fn90D6+lhR67Cb3LtrdExtrCKXPFb2f9sLVIpRQ5rwg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=BenJ4MazQRgeP9Xsb63NH3HBuIlAP5+dCCamBq6GZ+pNbv3GCpTtXZVYIQAv+N3G4Pk7AsQtAkydtKNNkKp8RVP1xoRU7Z8QtT2Pm3VP4iUtvdmbar2Zumt7UnZmd7uiI2xF2tVdJhFpjUPQSt7Wlnv/ThfYtNWwzGF9cnqQctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RprfkRrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AtPqO5pq; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8E0EF1380073;
	Thu, 28 Mar 2024 15:34:53 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 28 Mar 2024 15:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711654493; x=1711740893; bh=1wroJ6gxxD
	eLsMepRfJkcEGfQ+xzSMYnsCgYqPB17lg=; b=RprfkRrb4lqIie2zx95VsX0uSA
	tXwkUzQVzseArejgb0Q6q7S5h9svGYJnU53jnHsRy9tqgBqDtiF6dFxH27RRRt43
	jPpiNBtRTwMqTo5DIRgDRUf3wa0FJKcNAPFQE0vEelg2FjmcCubQsKuz+Nzc2e0g
	IDT/axyESPyX/cmZ2BzkRU+aB8e1NqF1/xskFOjYRxpkVXw3X+d33BXn2bLJoYPq
	p7ChI2r9jB89zQakTo9Y4/ucsCB8AnKVHqylPzmI76y9oLLNh2Eq3o3IwafWEtrB
	aFZBnQ+5Umhx9gTeaTld9LinH35/YgDR7BnA0ed2Gyp9XQ3Zg5qW8JTb7PnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711654493; x=1711740893; bh=1wroJ6gxxDeLsMepRfJkcEGfQ+xz
	SMYnsCgYqPB17lg=; b=AtPqO5pq3O71xO6KoCsopStmRibJz8M3+hmXJq5sFCe3
	Xlh9ZzmjugGZIENWlwEccYsEu0mNvSyTy1iYUGEr8AQDO32cFOycDyCZwElzUuZq
	uXOWaEfFCN698bH/Fc0+r2X/C4SwDYpdmY60Xpf40RCID7ga9ojGvojsxuVo2eeD
	R9xbwVqA6FthsOHJTCSH9s4I9PxdB9oUNJc8gwuICzErvHfookupC1vh2nzqs0h4
	HwThBwL2w/ljn8noyJXzYId4A/JigT9uqVTsMWpYFk7JoSqPfPct5XHnmJe9zRf0
	b6GjIHcVz6NtDbrxCbHCLt6Gj6SA2A0/lcS+R0II/g==
X-ME-Sender: <xms:XMYFZvXOjUEGtnpA8XzCxMC43uUDZSFlPUSxpiYOj_TooUWPx4Zrjw>
    <xme:XMYFZnlYI9my23lE7rICO0ngkE2vU6YgDghotGjd_7NikrG3dbDBBiJCW1y637Mxi
    qC73eHWm92gpIiN1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpeejueehgedtueetgefhheejjeeigffhieefjeehuddvueeg
    tdfhheevgfeggfektdenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsohhrvggrrhes
    fhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:XMYFZra5dar7f5APnXX6SzlwCPDUbMVtWUev97Y14pSvGW9Q_1Mkng>
    <xmx:XMYFZqUCpaU983LCXMujiM8VyMCRwC94XpA5B8UC60vlOVgb1hDw_g>
    <xmx:XMYFZpkiAooXC84y8E5rVCnVKubZo9Zgm_7AYNp7HD_LtTih72O_1g>
    <xmx:XMYFZnfN8MG3jzc1XVwjlUsEE2dC0zp16KyDmRqNhILN9E842ZpULw>
    <xmx:XcYFZpEDIvVHwGqtCqHR7VUu9aptWV4uJNyoXcuVhraZ-ZzKfsfDEw>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6D5391700093; Thu, 28 Mar 2024 15:34:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
In-Reply-To: <20240328124916.293173-3-pulehui@huaweicloud.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
Date: Thu, 28 Mar 2024 15:34:31 -0400
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yhs@fb.com>, "John Fastabend" <john.fastabend@gmail.com>,
 "KP Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@google.com>,
 "Hao Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>,
 "Mykola Lysenko" <mykolal@fb.com>, "Manu Bretelle" <chantr4@gmail.com>,
 "Pu Lehui" <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb instructions
Content-Type: text/plain

On Thu, Mar 28, 2024, at 8:49 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> This patch relaxes the restrictions on the Zbb instructions. The hardware
> is capable of recognizing the Zbb instructions independently, eliminating
> the need for reliance on kernel compile configurations.

This doesn't make sense to me.

RISCV_ISA_ZBB is defined as:

           Adds support to dynamically detect the presence of the ZBB
           extension (basic bit manipulation) and enable its usage.

In other words, RISCV_ISA_ZBB=n should disable everything that attempts
to detect Zbb at runtime. It is mostly relevant for code size reduction,
which is relevant for BPF since if RISCV_ISA_ZBB=n all rvzbb_enabled()
checks can be constant-folded.

If BPF needs to become an exception (why?), this should be mentioned in
Kconfig.

-s

> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
> index 5fc374ed98ea..bcf109b88df5 100644
> --- a/arch/riscv/net/bpf_jit.h
> +++ b/arch/riscv/net/bpf_jit.h
> @@ -20,7 +20,7 @@ static inline bool rvc_enabled(void)
> 
>  static inline bool rvzbb_enabled(void)
>  {
> -	return IS_ENABLED(CONFIG_RISCV_ISA_ZBB) && 
> riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
> +	return riscv_has_extension_likely(RISCV_ISA_EXT_ZBB);
>  }
> 
>  enum {
> -- 
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

