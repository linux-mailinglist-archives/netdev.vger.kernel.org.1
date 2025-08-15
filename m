Return-Path: <netdev+bounces-214131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64AB28543
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13FE7B66042
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEF317705;
	Fri, 15 Aug 2025 17:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T6FTfDSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089A3176F0
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279569; cv=none; b=Hvp0TzL7CavHwarBHBlEAhGH/SisebMMm2YbpgSTtNu5Ef33Zih3WzQKlUBV9WcS8e9rikd5To7ukWBflZv1RRExMXBK4wfjJzoJr8v3c7KIyK09cNMa5FtRlyF7/ILGNuMjkda+3FZYjV6P0tWl3CAyigfYnuh4OOFQaRYlSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279569; c=relaxed/simple;
	bh=DzG0LZlHGH3bOOtZ8yuLvRlkiHDfO2BsTKY54JW4yq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL6MmEGPKz/VErEWyZ8i9BWZ6fPhVMvkBVQWyh2ZbvHTj41dWuVT+JCP4zGBG0c7mbv3c+HfjyahVIhk6s1QjqaaJYBSSWpZmri81iuDc4VnQS2yE2qZKiEmhAP6WDyxhqeDO9B8aGlqkugIJ2meO9rcwuCdBZ//WKQnLzMBC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T6FTfDSl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3bb2fb3a436so641069f8f.1
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 10:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755279565; x=1755884365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DzG0LZlHGH3bOOtZ8yuLvRlkiHDfO2BsTKY54JW4yq4=;
        b=T6FTfDSlR+sOXdWAS645UsXPOrH9Kpi1Ozs/WLNPLV4/6iYaZ6WL3/CjGFOBOQjjLo
         YNEY5iwfh80Ns8f3wIZZjQwL0TnXmxGBQdiXekq2YhQDMtJAcARHmiqm/eKZVX2wxTdY
         SmO/ZJkM9euA77qjd2c+VFcI0B4xOf2dH1gi2apbrRC809pFWzuDyNQuep29mTPFezNQ
         sGeScg8eKYVoVU9MrvN5VjMrPJK8OT3rEMX+Vcj9ECWqqSOjwhFAn2L+29ydbRMcNhw0
         J7t1dNEYpwQ5etQZUhpr0vob46x+s639ixmrQZNKNWHL9Cd6w9rXVIMaSeHE4AU/79DY
         NshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279565; x=1755884365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzG0LZlHGH3bOOtZ8yuLvRlkiHDfO2BsTKY54JW4yq4=;
        b=mobAenQUePJbhl5Y8tfBw23mRa8pDoTLanBi6BRJxdJbj3IWGojRETXbpCJfWCcBvQ
         1aXYknM8nEqCElEvnv33LO4IzyFBshoPRHAs10MUP0y4ra/q5X2UyWnXW4u0Rc/EIsdG
         sXfMEMZxiYBEd93bph1yoFrmThJImTOj9Jyl9+yoeV3bOMminUHUaiO7NAfI7vq9SUQd
         +OmYI1v4rc2aOSai8bOCZ2+QAC8vIDMix/32/1BwT47CDwvFuuE8aQdVcGZwf8pPWw/e
         D1y6ttBWoh8Kt0IsIIRbIdQPs/qrNXZoYjCGngYyIPofbfK5wTlfRc7JyBMbrMaMn6Yo
         bnKA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0Q83kfJ/xCYdAhRfuve47K3Him7DO0RAZ1Gy8ylf6DIDye9XYDKtfFYZZgaVq5gotYbl7mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmNeMFhTBq4yJiXLAZfjSyJ3cRgYfaO+1EPhBv2W1keoXS21V
	sNL1SM14vf7CNjGaq+Am52oUb+Bs8H1/Nx2zzklJ6I4O2qj+3F6bXN67Sj+TRIIpMvk=
X-Gm-Gg: ASbGnctsKbWXQh5ktxvub8yYDexfVLSq/YFt8sy3sYl1bhDhiRvnK7am6ztqN3vaK69
	OTP6K3ffzcOXOyPzUOX5X6bINjlLROhGkSUz9p+SqW19fkpRtM8sy4gnW4Vmv/n4fN2AYBuJyXs
	zcae2v8fPn+VYU6+YFdL89nTY5KLUMI6GgugdAqEoGUfTJRULdqGW9iuUU62bsxM5KLz0VAtPPw
	/m+oZnDa+T1K98Z0xGgxCdc+gXcXuMTq9T5FP2bS4EtIXW6i+YTDyiPsZEBn7qEp9IKJ8tc/OT4
	NMjag4Q40hy6YHfEfUASy/hOGukm75oiUrai51oTPjlYfiFOcWNwSadpwLcwEKXcmsKDu6vn17s
	lgDFs4RsxtDSCJ2lp4ev6H7wD2gDL09JI+P3bQdWR7A==
X-Google-Smtp-Source: AGHT+IEQtqoj7OJMpPUFnt1ji9bSa+u38yG5PGpHc7mF3c26ryzthKx7wFt40yjy8HfsIxTJ4Rr5hA==
X-Received: by 2002:a05:6000:2289:b0:3b8:d0bb:7541 with SMTP id ffacd0b85a97d-3bb68fdd5efmr2396919f8f.40.1755279565547;
        Fri, 15 Aug 2025 10:39:25 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323311233cdsm4872522a91.21.2025.08.15.10.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:39:24 -0700 (PDT)
Date: Fri, 15 Aug 2025 19:39:06 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
Message-ID: <gmiwpzpgcnnzg2jjhonfcchkbv7zrzgbawvgfgfwrjmvvihqdc@gaq7bbe4ktwc>
References: <20250814200912.1040628-1-kuniyu@google.com>
 <20250814200912.1040628-2-kuniyu@google.com>
 <cs5uvm72eyzqljcxtmienkmmth54pqqjmlyya5vf3twncbp7u5@jfnktl43r5se>
 <CAAVpQUDyy9f7=LNZc2ka2RiOhR3_eOhEb+Nih37HnF0_cdrJqA@mail.gmail.com>
 <r3czpatkdegf7aoo3ezvrvzuqkixsb557okybueig4fcuknku3@jkgzexpt7dnq>
 <CAAVpQUAx9SyA96b_UYofbhM2TPgAGSqq_=-g6ERqmbCZP04-PA@mail.gmail.com>
 <kr6cv3njfdjzc2wcrixudszd2szzcso7ikpm6d5xsxe7rfppjs@5bvfwpelgj6f>
 <CAAVpQUCMcm8sKbNqW9o6Ov1MtC67Z--NTv9me1xcYgCkbJxK5g@mail.gmail.com>
 <CAAVpQUBO8TXjjtt++kF0R-qs-Utn-eY5o321NyAALEYTfq0xGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y4wp3wkqhrel3mvn"
Content-Disposition: inline
In-Reply-To: <CAAVpQUBO8TXjjtt++kF0R-qs-Utn-eY5o321NyAALEYTfq0xGw@mail.gmail.com>


--y4wp3wkqhrel3mvn
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 net-next 01/10] mptcp: Fix up subflow's memcg when
 CONFIG_SOCK_CGROUP_DATA=n.
MIME-Version: 1.0

On Fri, Aug 15, 2025 at 10:24:12AM -0700, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> and we need to manually copy the memcg anyway..

(Is that in a later patch?)

But fair enough :-/


Michal

--y4wp3wkqhrel3mvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ9wuAAKCRB+PQLnlNv4
CH4YAQC8zojrNNQgYpmFJQUBnZHfg4T+IF01Rw6OCepycZuaVgD8Cfgdr1bVXJly
2vehjqtlGG8wN1oo3l6EVENniEd0yAo=
=/lQI
-----END PGP SIGNATURE-----

--y4wp3wkqhrel3mvn--

