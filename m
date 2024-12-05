Return-Path: <netdev+bounces-149326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456FA9E5259
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979BA1640D4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F91D5AB9;
	Thu,  5 Dec 2024 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DEMz7EMD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CF19007E
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394769; cv=none; b=sd9ebb1ov4/pOPaUUcC19Xm/g+m+18bLbV+PmY9DhA9rfNLHjglbfCtRl8gswFbR6D1AWCkBCZ3ptnQPBHFS2ApoKdiUhlpCU8Kuy5fPzHhLEhbT1WSVBNVGd9G/ESbdYKGQvIH7EX9N5sk6g6ycEb/7iZN80RTkXUrxQzKOaJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394769; c=relaxed/simple;
	bh=6HXvG45Hm2D9fZF+QkrLxx70E0nDTnn2Xg6zS5lv34o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPc0MIj+5Q6pE4O1WFA4WJftBKP7oLy53EZphcB/C8bo1ry9HJ9DczJmnVGNqdY7ewDEVNON2K1Z+poS0ZRs+PeqkEIS6JY2a3ldQ91SkAFdUPNWfa1jw1e/dRQHTwoDf3Ke6blQKSP4T6YvIbI6PWVanfnUg7cBKlIP1QkDflg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DEMz7EMD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa55171d73cso355821466b.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 02:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733394765; x=1733999565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6254BSEchNSxDD6z0s1P5zHDiBBHSGfn7mtMA8hj/I0=;
        b=DEMz7EMDWcng0vE1CaUa8uX2OHQTM9/A/YtD9/7bE2B2BLQm9dmYZSqFeHH/P/umpk
         PFKy2OgH3DOtdwDEM39103QxKxiYOZPk1FrP+E9mbCtX4MyScIwstmytnTrlVmteFShE
         eW9DanfXEgKH2N4LPuuJVN+4v13R0FPHCKpLgndUTffjSb9AQwJAocHsPa9Zq7YmYRQO
         3as9WyAD4yCdWzdYxZ03NA07v3u5Zo2ApJjJfjfIOjdpQI446rlSUQEWrXic1HNW5yTi
         12maK8dBtutqWo3t59CskmP0YN4rCqATdpSOTCABcU61FgXp1fwMGY5/CDClUc+CbIm9
         FHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394765; x=1733999565;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6254BSEchNSxDD6z0s1P5zHDiBBHSGfn7mtMA8hj/I0=;
        b=rfm98TFHUcPw44HSC3n3DcLktAmlOT6VdAYCb4VN5V8UY+Z/JSkwXdzpNxaloNX8hv
         hU9Hvm7e/uc/zpFve/b3uwJzWwoP9yt6lqofVCfg4oXRLyayuMMGmpXXQwE39Er6niFO
         Y0f0483sm4I08w+dtS2BoCjk70kXkR9Cs2ZAaLVURBIRGQ2+0QjrJEFvHwSzGfZLKg+l
         Nxsp3sNgfwm9GPvBJi0nc8JK77jV6I2hZBwN5qVYMvfuYBpS9wEBKw26BPO+VkRFhb26
         lEV2z3dNDOS7VLlwaZ+LNnBq8K2aeaHHtXqqeMiQU9Bcnat77kp6GLMC9WdMPw9mpfY/
         lLIw==
X-Gm-Message-State: AOJu0YxJtUKnPAPvLIfDwLwlH5n8PIr14hrFT6G81/zavqyF45gBreba
	JXwjPZ/awc4/2FHgcPddZLETiBDhBMkGzWeaD3wBFB+Z5AR9IGx6F7oCpW5Ef+u/syt5zypNuK/
	i
X-Gm-Gg: ASbGncuihf1j73QCFt1mOy9SWdzaMu6F9xudqAz96PiX8KhSEz7ytAG005KpfbN3OtO
	18n/N6Mi9ei+8BFNtNJ0nc84PgpHe+1pqhdIBG43ulgOAwfZkAt15aFJ4uBTJ5GvZk7g90Ru7YJ
	5YfQQ0xxaGqXaH4yvlvi2tVxI05fHWc09AmzCHNaYu3uvXtSsDwJCBK4SBXefcpC1HQS4kI1MCs
	QCGgQ3rBu0Fh0Bwr/BfIPVGuqAplFgy2HFdj8OT0CXnwxfuWFcVBbKvWtAJUpAuPYquU7t7jNzq
	Hwy/4qrXPjip
X-Google-Smtp-Source: AGHT+IGqXGgjq1viA+Ko95j9nf8/Z5FYvGx+gNGiTdXEKmEmL+dVtR7qeWsz4gPUaY4Jl7LzSWijDw==
X-Received: by 2002:a17:907:7759:b0:a99:5f45:cb69 with SMTP id a640c23a62f3a-aa6202f3295mr279549266b.4.1733394765188;
        Thu, 05 Dec 2024 02:32:45 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:57d3:efd0:a801:687e? ([2001:67c:2fbc:1:57d3:efd0:a801:687e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa62601b3f9sm71324366b.110.2024.12.05.02.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 02:32:44 -0800 (PST)
Message-ID: <364f199c-8d8d-4228-bdd7-13ab81d10e39@openvpn.net>
Date: Thu, 5 Dec 2024 11:33:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 12/22] ovpn: implement multi-peer support
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com, Andrew Lunn <andrew@lunn.ch>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-12-239ff733bf97@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <20241202-b4-ovpn-v12-12-239ff733bf97@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/12/2024 16:07, Antonio Quartulli wrote:
[...]
> +
> +/**
> + * ovpn_peer_unhash - remove peer reference from all hashtables
> + * @peer: the peer to remove
> + * @reason: the delete reason to attach to the peer
> + */
> +static void ovpn_peer_unhash(struct ovpn_peer *peer,
> +			     enum ovpn_del_peer_reason reason)
> +{
> +	lockdep_assert_held(&peer->ovpn->lock);
> +
> +	hlist_del_init_rcu(&peer->hash_entry_id);
> +
> +	hlist_nulls_del_init_rcu(&peer->hash_entry_addr4);
> +	hlist_nulls_del_init_rcu(&peer->hash_entry_addr6);
> +	hlist_nulls_del_init_rcu(&peer->hash_entry_transp_addr);
> +
> +	ovpn_peer_put(peer);

This put() should be dropped as we now call it in ovpn_peer_remove().
Will be fixed in v13.


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


