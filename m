Return-Path: <netdev+bounces-211307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A9EB17D10
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 09:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5619C58352B
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 07:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6604A1A255C;
	Fri,  1 Aug 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kms3koXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F6F6DCE1
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754031634; cv=none; b=HlSZ0Jo+zq9fYlJqVvQ0rMLBpAntbUKr8cCUuFcjHtp16katpHnTI8fQy/p/KiTm6wEAOKwbWmKEZvTm0N5v3rLXWr0/BTQ+33fO91Mf4+VK+nJtw8Q52yqQv4CcLlgtUfwGhq/8DLLN1LtSh1Voth2aCJLc7M+Doq6MkyIo94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754031634; c=relaxed/simple;
	bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zl8BOPOIL7t6cvgx4FHs4Rv6kqi9Btc2IYWsMlI3VbT4AtN38nux2CDLMOl6kTm53SGk6E1WzT+G2kXjgx75oMdCy0YU0P83JfVFlRECCVF/1vqFQW4/WhC/YfIf+6pS+fiK/6FfvAUBobkAlvOHHmB2fE/MluXQbUmazKHHlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kms3koXp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so709510f8f.1
        for <netdev@vger.kernel.org>; Fri, 01 Aug 2025 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754031631; x=1754636431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
        b=Kms3koXpvqhwr78UjSZurzI/4Qba/l7wa/LoZatXgG58B381rD7frdRu3rXKpkyO3S
         701QdGwW1hwfMVu9fQJigm8BUgDlxV+ITq6QmWifAcvAJlFgU2tRfVV9vyr+42D6Zilt
         xxpPmLrhGiU0617mdfn+VRoLnRUVJtjGPY7Xf8iIzD8KKGOlFTr0Uj5ywSG9hiWRyytR
         DZE3C3a2DChwmFPqFJRQYlak9u8h8lr7Oz0CYIT6NrDPne8Va6uf1c8978H+OxThiVBc
         ACdAtBfillTFJJfiXyBuv3FPDdlHQSNgngSs43dADLbVpwUf0aejWs6Ugr9gBXaDUKRX
         rYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754031631; x=1754636431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOdACm39398ZkN2lU2UZXEP/gEQUsiO20iyEfrmnlog=;
        b=JlfvIXeHgkoRw4Mvah1hFLoUrHE3W2zz41NiC2L3eCSD6mP2XmKDBCEwaSG30AGOOJ
         yWHUqmCI0mliV6yC8jnqNJVCRzoMn9RJlV7RVPpBwOaYExGx1GD8TNgpWey7v6N7Hobk
         Vz8ZdNqlXJJIYRNg2wKsjw1Y8E6b/hGoxbYB1bjPRYa0EPL18/EKKHl35WCYqBrmRuka
         WLGVYNHDObpJEBanK8EYNC7HMjxuoLsNUZ9A2vdEeVuFG0cS3moo1lYTc71nHeemhofs
         hBseqT8JQIKPf5nDs4Q2qC5QDa4OYwxF458BMdp7VdTVBd9/iOYUHb7wczNF+sW3lfS1
         YTzA==
X-Forwarded-Encrypted: i=1; AJvYcCXGjSzIbT4D2NNbyb3Kdocnziz1wgAbyUQjvtigr4vBoEsZI8mV+yCmoVFMcGQnOvL2SftfDGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBNGWCHVDB8UaCLj/JKtshc+AtNusfvRA+mtuSW7p3aM2KoHOV
	hVzuhXNaT+Di7V567RkqKmMH8mZJwGO3yhtg3IfKbBBwjA1SJxy5TmJueDLecQEqlUY=
X-Gm-Gg: ASbGncukCfpTCCHOdopnm5PPO8ygUrpMj+O2cLvNVNF6pm95Kiqx2RFpnhVGIObXcjY
	Or6k1Rm7rPrgBHh+k8zf2XvSclr4L58MuDZ2AfY0h0tgrnF/LiKWRer8GgL15gtEX/NQmYLaNvq
	GDGXG2n2t4hS2EbsC5yHFIva2kXuYqfzrBOqCAxkTB6gjZMqnQvmm6h98HsLYksTEBgaozVarJa
	yDTMNpEnxKUN8KxsuPeKXXZ0US7GpKcmGDkj3WJxlmbesc1gWx1khPy4d02fL5inl1zCi3+PdzJ
	C6KEXc8MN3FUpdm2AkphBC30V4IvLUJ756XZNScaGL7Su1UdQip/Chx4e3kIY30cA92OVHoPXGz
	YFo3Nyf+Sx5uYO9tsB/TogwbQajmD4H3Dw5gyGZUSdg==
X-Google-Smtp-Source: AGHT+IGpo7vCBRl1+3LNZgziFjvZCIsV7Fz+AW0zycTpGAfpOewwiyDA2ffkkvBUhcmMNKx/L1CjEA==
X-Received: by 2002:a05:6000:4212:b0:3b5:dc07:50a4 with SMTP id ffacd0b85a97d-3b794fbeb87mr9254839f8f.2.1754031630614;
        Fri, 01 Aug 2025 00:00:30 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ae8esm4762632f8f.61.2025.08.01.00.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:00:29 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:00:27 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <ekte46qtwawpvdijdmoqhl2pcwtfhxgl6ubxjkgkiitrtfnvpu@5n7kwkj4fs2t>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <fq3wlkkedbv6ijj7pgc7haopgafoovd7qem7myccqg2ot43kzk@dui4war55ufk>
 <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x3o5euvcxbwgpnyi"
Content-Disposition: inline
In-Reply-To: <CAAVpQUAFAsmPPF0gRMqDNWJmktegk6w=s1TPS9hGJpHQzXT-sg@mail.gmail.com>


--x3o5euvcxbwgpnyi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
MIME-Version: 1.0

On Thu, Jul 31, 2025 at 04:51:43PM -0700, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> Doesn't that end up implementing another tcp_mem[] which now
> enforce limits on uncontrolled cgroups (memory.max == max) ?
> Or it will simply end up with the system-wide OOM killer ?

I meant to rely on use the exisiting mem_cgroup_charge_skmem(), i.e.
there'd be always memory.max < max (ensured by the configuring agent).
But you're right the OOM _may_ be global if the limit is too loose.

Actually, as I think about it, another configuration option would be to
reorganize the memcg tree and put all non-isolated memcgs under one
ancestor and set its memory.max limit (so that it's shared among them
like the global limit).

HTH,
Michal

--x3o5euvcxbwgpnyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaIxl9AAKCRB+PQLnlNv4
CJZtAQDyxJKYOwR+G5PupdcFpWcem+e2vcVjekmcUSnAefb9SwEAmlcDbWaK+JWZ
zsvVOKp5n3NQmuq9ouqRPxwf+gbdlAs=
=J+oe
-----END PGP SIGNATURE-----

--x3o5euvcxbwgpnyi--

