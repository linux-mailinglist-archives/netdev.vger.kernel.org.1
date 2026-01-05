Return-Path: <netdev+bounces-247172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF57CF539B
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 19:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FC3B3019183
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 18:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B7325716;
	Mon,  5 Jan 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1twbJKf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB86303CB0
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637388; cv=none; b=hNSnk7rHQ3TAxAT6uM7p/RqVfQ+584xg7cQ9v6BLrqdNA9048BVSufk6OnVIyvxuI0s/vvmjsQZGb1Eu51Zjdpejw/D/gQsmkkcY0+1hE1kwZtGhLh6SnXkFejP7aPnbext8BCGhdPRGackfJSexSIkOKUyAhvOLC8CFl1b3uhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637388; c=relaxed/simple;
	bh=k9OtXFkIqje/AIKDr9FzDdAQGPBa0Z+JbsPnAT8CraI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pLscWrIp7AkISw/tnt99a/1NOmQL5aLdzpwy9We97mvkYktYkBv/D5DFxQofvSiT3LkPdsIS2p3i5xtg9IqVaoyEjbOJKc7R6RxnvpRGllT0EGjghNzIebJsIcp0SPK+LqIRa05ajbo8J3zXk1aqjO3Hfn7WnglLoOpQK4UzogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1twbJKf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c3e921afad1so94272a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767637387; x=1768242187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ms3aLacsOOIkp2oK0SNeT2U5HEsWh1y7ZpyB6UCuuEk=;
        b=T1twbJKfvBv2BAF0etic1S1JEuu1Yn8uJQ+L6ozvOuwk+mkbY7jFjJnjCNBnSNrdsq
         3/Yt8VnnIpMbo94NA2zSLgiC5zFdop+bHz7f7T3MR5k5S5tYN6CWf4LARU/UcgnJWH8p
         VIH+v1ozDPeLd7K/bNcjf7W8e8nEptqzf6BTZw4LlU+360VeJSvP1oJpuyXBMF/aUszr
         vRyVQFsD2BHahthTAjG1F5eDasiw8Jq5TmCrflSAo4mS0PmiNqknkgEd/UAatGTX+T+g
         JMrt0BsztaGLX3RV03DGEG7aTAknX00CHHwTSEeCTmuWOmrLc7ZdAV0Fr4kejcnNy9mJ
         GKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767637387; x=1768242187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms3aLacsOOIkp2oK0SNeT2U5HEsWh1y7ZpyB6UCuuEk=;
        b=BXuziIkGAe6tSqZJqOBQ54m1o3gE5NBZvBkmduXbVS6lumAzuwiX5mUrUQWkJxR42v
         dp30U451hKOt6hWpPRXUPAerNdMK1ugxZ/ob4EmrpFQ76+jTup1sRLBqUKcd/dQiHfRy
         ggISh50uhTXbPzE41uhcCy0ChdgWqqjkLJhqjCdNJFK/J1onFHCtpKv6iWZpCICU09Sl
         wtYBkxc4lnlEGInC2XX6VHx7JLWwzKAHVRjf++7FXtBInWsHwv5Vs4/+qrMyGajcrv/o
         /8Mt+pqiSm8CShWN9W7LJVeUIfR8bYY2zdiO6i3Z3uAvbm4S+eeX6SXJ0O5mTDtMp1Fh
         9K1A==
X-Gm-Message-State: AOJu0YzciVCcKogfXmGHe8aOT0Mz7Y/DEXG8EhOWNvU5GsvmUAEr/x0E
	7lW56L0rkfQtJeeAI0qDfmhYq1z0EdyE3g3HMVaEnpFv7avSBFLBa5Qk
X-Gm-Gg: AY/fxX7R0yRFd8sAc3Bhl3TakhBoGVkXOwFBiystsTQQT43D4SEKO4l8bfNA2ex4z3d
	/cnBwV/JnG1nCjalXKXWu1V37HSWPMPm2LJ634mkeo1w4f6SmNCK+kzR+FktxQe3vhfomWzTWFv
	5cMi3jEgTv8o9y2PU5ho7sjVK0p6/JkyYwIWXF0Pd6HffUcw/s1zMIGWz+fdKfzxIRm3rVpwoa1
	2gxjmcahNM81IEUDt/LGOTrl6nsexlKP1fGPZ5bAioMRetpmJV8ESz8mw6SeANaBLF6qfcNuBxz
	TII3rYEfllYow5qi6tRVggsgipqyVAdcZYAMqwdvqKapCejwmzeo+3YvLLXy4EW91yO6HtdIf6x
	8lPisZ6Gqrz2eGQgH1Qjuk+nAyimfoUG1PgTeWsWlejGClYpCPQZFrZpNTXjhdSsutLY2UvGWrz
	LUuhq0ttESUHTRy0KV2O9WweJAX6gzm/1bkJL9
X-Google-Smtp-Source: AGHT+IGW7v0ICSXKYWEYUupKVRuUMgwDWFva4yxYPTG4kQGunsdTuh7n7fddYgADWUlpPt0RKxb9Aw==
X-Received: by 2002:a05:7300:cd97:b0:2ae:5b71:d233 with SMTP id 5a478bee46e88-2b16f87bb54mr234020eec.19.1767637386466;
        Mon, 05 Jan 2026 10:23:06 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b16f02b24asm690718eec.0.2026.01.05.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:23:06 -0800 (PST)
Message-ID: <17247510f876045d49deabba99f8b668633715a2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/16] bpf, verifier: Remove side effects
 from may_access_direct_pkt_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev	
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh	
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, 	kernel-team@cloudflare.com
Date: Mon, 05 Jan 2026 10:23:03 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-11-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-11-a21e679b5afa@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 13:14 +0100, Jakub Sitnicki wrote:
> The may_access_direct_pkt_data() helper sets env->seen_direct_write as a
> side effect, which creates awkward calling patterns:
>=20
> - check_special_kfunc() has a comment warning readers about the side effe=
ct
> - specialize_kfunc() must save and restore the flag around the call
>=20
> Make the helper a pure function by moving the seen_direct_write flag
> setting to call sites that need it.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9394b0de2ef0..52d76a848f65 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6151,13 +6151,9 @@ static bool may_access_direct_pkt_data(struct bpf_=
verifier_env *env,
>  		if (meta)
>  			return meta->pkt_access;
> =20
> -		env->seen_direct_write =3D true;

Note to reviewers:
the call to may_access_direct_pkt_data() in check_func_arg() always
has a non-NULL 'meta', so it is correct to skip setting
'env->seen_direct_write' there, behavior does not change.

>  		return true;
> =20
>  	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> -		if (t =3D=3D BPF_WRITE)
> -			env->seen_direct_write =3D true;
> -
>  		return true;
> =20
>  	default:

[...]

