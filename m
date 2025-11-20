Return-Path: <netdev+bounces-240383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55342C74117
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B42FA4E6FED
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06940337BAA;
	Thu, 20 Nov 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S7aqdZIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029732D0D5
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643507; cv=none; b=qvhgsiwdtXAVsoMSE3hCw+MX1lI+b69dI5f1owGAl5eGV2IA2GVcEEXq2jy6nWMaliE1x/UGMp/eDEUxf4Qc1wcwAnVu+Zxuhp/Hc/oBdGhBbDW/KqJjfAwKTqkiWpFbsUEzKcmVuoW2mivF1BvU0kp3qiuCJhxwC0cPJQFJcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643507; c=relaxed/simple;
	bh=yrrGT9RTCWN6v25Jy1PljEJyV2gwJA+0BkSczHJvwqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jy9uJz49Pud4WXsNoM4YkUdXwfdMEPL0QdqEe39Enxnxtp8FrfJrGMKAVE+ujMCVcW8XGCnQfRzlTB+Aa83hdYO0rvZq/maodJsMtl8+DOv5+eNGaBPmPEHs4lwR593LyU6mg7oyv5WlQqH7ElkBZUoxn/jsLmBopXFwh3rNuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S7aqdZIp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b735b7326e5so348937266b.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1763643505; x=1764248305; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWt1WezTZ5DpLX3MB7doQs98ekhplq8AtMdx/O/O2yc=;
        b=S7aqdZIpeni1IEmbAnYHWLn6J0Yx8fLyUQLq2Ef1J/WrTksSv4BxKoCb2jI/FILfsc
         wyaUpjWBz/BvwJf4kYQD+NiacTMcuF09mbR03g0xKuuaaEcWUZY0ezk7DscGdzobZBO6
         IejvOvDsDPo+JaQVnqpns0r6JcuL9O4F+ZfF+ihHVAdz8YI6A1CahTv31/CKHY/LU9yC
         Ov/M4kmm+073daycX90GqfpCkJQ+/Rqz6Nk1cqbwvLkKyIQamctisqo/ubcf2I2VwrkS
         B6PboTQVBrKutFNcyknsISoH0nwmw1SMBJHDkNKOFWc7T+QzZ4j5bkqBE+4pRTwWedRc
         Odvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763643505; x=1764248305;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWt1WezTZ5DpLX3MB7doQs98ekhplq8AtMdx/O/O2yc=;
        b=MTA2YMt4ZVeuvwl2jR2RaWjCMX6dhXlsoAtV8TyAjjMzj5ighNnX/eQdsFNmxgKH9t
         GpysNfOKoAgG+sdzmA6oMmW/Cscvrxsu0UXDkkYITn5KBhJDXG1msLduKeqzwR1gFDtW
         q3xtJVWEHcFpCfOtb5o1w+j0OvZbaL7aBOGmOnqFb2VqGqVXmYav1Q0rysQJA3hAUVPw
         RKEBHx0QOPbENukVpwhXsKCVqyIPjQpo/V3YTsdfEZKQXcBYpKbXHa+9Ihz+bnN+P5sa
         9bFT5CI9iw0MJ+fSBH0bQoYdR+WQPcBfBi6Fl9TLTQqG2VYgiqK8pBxB77fEZUnyqEBd
         v1bg==
X-Forwarded-Encrypted: i=1; AJvYcCWfflY9PXdCwyWvKBqRq+AtOqtHoW3gW4IkoLfZIN7s25j7F4anGYIs9TB0jrUpO+IWVRGImCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDz03g67q5XJmvRAXKRUxiWsCrKxRoh3N4T7VDZlSwHCu81GfO
	i0epQWQsSXCcpcs0QXGUlqTAEV7MoA5mfmra16NIcTHc8lrF24fKtsGii8OEdb3VobU=
X-Gm-Gg: ASbGncvytETGanHi5fFBCjQFWNkKi+s4Fw7Mbsm8KXidKv13E8hs6HMzZ1IBTuzuyHd
	b7fT+HRD2aCN7z+I6rerns/GL3NX+dcCZwTJEjNl7QpTtJRPLya7rVMZbTa+dP3w6E2la/UQinO
	/98QFdj6Z4AVEACTX8C2fkHEdc9LxFj2qK3dyKQ5d+r168ud8XpiDttW3xMniDTDUhhDjgtkqBg
	Yblmm1B0oCGGuGLM8x2/zen4oD1J/fjrrlA9FWkEslAfqz+FR3cQHZlajK8hDoVjGCvmMOttGia
	/rKgxHY7K3aYbXnldGZLNXlYvTgf1uXlbPdLA2C0pGFwomBaUdNWGvQ+HMr2+y9m64a77/4qV1D
	CHwrGgrVllzf3qEa0JC6hVfBODb+RXjJYAzYsi7G4NPidSz/u5U07NVc8nCynvfUR/cEBSte43+
	39NkY=
X-Google-Smtp-Source: AGHT+IGx1D4Lf3+ONX9DYRjufCOc1Fw/EfSu7B0mNDhtvWXtJYLURbexh3sFGvbZtkfpHNbDzHlRQg==
X-Received: by 2002:a17:907:9487:b0:b04:48b5:6ea5 with SMTP id a640c23a62f3a-b765720a6e1mr306820066b.17.1763643504589;
        Thu, 20 Nov 2025 04:58:24 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e51sm201000466b.42.2025.11.20.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:58:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  "John Fastabend" <john.fastabend@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Simon Horman" <horms@kernel.org>,  "Neal Cardwell"
 <ncardwell@google.com>,  "Kuniyuki Iwashima" <kuniyu@google.com>,  "David
 Ahern" <dsahern@kernel.org>,  "Alexei Starovoitov" <ast@kernel.org>,
  "Daniel Borkmann" <daniel@iogearbox.net>,  "Andrii Nakryiko"
 <andrii@kernel.org>,  "Martin KaFai Lau" <martin.lau@linux.dev>,  "Eduard
 Zingerman" <eddyz87@gmail.com>,  "Song Liu" <song@kernel.org>,  "Yonghong
 Song" <yonghong.song@linux.dev>,  "KP Singh" <kpsingh@kernel.org>,
  "Stanislav Fomichev" <sdf@fomichev.me>,  "Hao Luo" <haoluo@google.com>,
  "Jiri Olsa" <jolsa@kernel.org>,  "Shuah Khan" <shuah@kernel.org>,
  "Michal Luczaj" <mhal@rbox.co>,  "Stefano Garzarella"
 <sgarzare@redhat.com>,  "Cong Wang" <cong.wang@bytedance.com>,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev> (Jiayuan
	Chen's message of "Thu, 20 Nov 2025 02:49:43 +0000")
References: <20251117110736.293040-1-jiayuan.chen@linux.dev>
	<20251117110736.293040-2-jiayuan.chen@linux.dev>
	<87zf8h6bpd.fsf@cloudflare.com>
	<5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev>
Date: Thu, 20 Nov 2025 13:58:23 +0100
Message-ID: <87tsyo6ets.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 20, 2025 at 02:49 AM GMT, Jiayuan Chen wrote:
> November 20, 2025 at 03:53, "Jakub Sitnicki" <jakub@cloudflare.com mailto:jakub@cloudflare.com?to=%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.com%3E > wrote:
>
> [...]
>> >  +/* The BPF program sets BPF_F_INGRESS on sk_msg to indicate data needs to be
>> >  + * redirected to the ingress queue of a specified socket. Since BPF_F_INGRESS is
>> >  + * defined in UAPI so that we can't extend this enum for our internal flags. We
>> >  + * define some internal flags here while inheriting BPF_F_INGRESS.
>> >  + */
>> >  +enum {
>> >  + SK_MSG_F_INGRESS = BPF_F_INGRESS, /* (1ULL << 0) */
>> >  + /* internal flag */
>> >  + SK_MSG_F_INGRESS_SELF = (1ULL << 1)
>> >  +};
>> >  +
>> > 
>> I'm wondering if we need additional state to track this.
>> Can we track sk_msg's construted from skb's that were not redirected by
>> setting `sk_msg.sk = sk` to indicate that the source socket is us in
>> sk_psock_skb_ingress_self()?
>
> Functionally, that would work. However, in that case, we would have to hold
> a reference to sk until the sk_msg is read, which would delay the release of
> sk. One concern is that if there is a bug in the read-side application, sk
> might never be released.

We don't need to grab a reference to sk if we're talking about setting
it only in sk_psock_skb_ingress_self(). psock already holds a ref for
psock->sk, and we purge psock->ingress_msg queue when destroying the
psock before releasing the sock ref in sk_psock_destroy().

While there's nothing wrong with an internal flaag, I'm trying to see if
we make things somewhat consistent so as a result sk_msg state is easier
to reason about.

My thinking here is that we already set sk_msg.sk to source socket in
sk_psock_msg_verdict() on sendmsg() path, so we know that this is the
purpose of that field. We could mimic this on recvmsg() path.

