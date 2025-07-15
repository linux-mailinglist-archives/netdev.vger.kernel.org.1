Return-Path: <netdev+bounces-207172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6D8B06193
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D751C80AEA
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 14:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD71B0F23;
	Tue, 15 Jul 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ua58ie1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2E3597E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590205; cv=none; b=ZhGAUcjZ5at0exyFws4zQIG+efAHkPeMqFyR7V2fVIqlVvu4EeJuzkmAnEet/KXXZoWb4fCyCdlqOhVTsyyUnzn/+lhudu/YM1yw9j+6YU7sp6ada+Dqj/NMoQwMBWzhRgASHpfTfsQyjn2MWAx4HarMG0EPP2MPkiSNqMSVbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590205; c=relaxed/simple;
	bh=u6sSy0TSkxEsfond+p1KSfVUZdzKLia3yrSWcV5nXYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVMrwNTucXpeIm3d2VviS8wM/7rGKQaiziJ+FxjhGsyjoRMWrVOBDkhgCOZxB2oGI6ulreuRabIXevjwZRWMHk9FvdeOIL399el6cLCNHx4ah1PFy6BB6vIBxkQsJmBWB7eL+ZIzhBGNwMcMipihrX7kANM9BkSAALy4PPkIMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ua58ie1o; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad572ba1347so780243366b.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1752590202; x=1753195002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aSygb+Ni9IM6dUNfOfJIb7tPNneyYZ9UKFN31vpoQIM=;
        b=Ua58ie1oPNy715HSKXA6v1iYeZGaLIAUsMbs1nt/U5PnD5p00ZVMPh6xlBVSs/u8rE
         NSjBijo74fflDRENhGd0K8PK0tmUnk0S0KAeflupN65aSsJ47EJH+aAHJ2+hS2h6UnBE
         cikNYq2M2F5JyMgw3veVULUlPPxuRlHvnTbWbEIyf3HL9v+oXWfiGHYB9fmUJa3Eu3dF
         qPRHg7+XtbnTMU3YSbMZMUyUKS5Upx+Nm6g5d4FyUF7OhJay/hVvgDoYcc2xa2kT3g6Z
         dEL/FnA6lcxEXHBEZSKWK0CjaAROUlVzJ7wYJYi7fI72enxCFnOYJ56tkZIXdwIT4qU1
         ThKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590202; x=1753195002;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSygb+Ni9IM6dUNfOfJIb7tPNneyYZ9UKFN31vpoQIM=;
        b=gULmh3F675Y1VFgd5uwZ5w+2NnNU11v2BwV2Rtvc+mROYn9igFYT2LO4ka2+bVQ+/1
         WUV8lXqRP/91C2DKRYbMJ76xv8i6ivlso3646QprIaOZ9EINLzWKDcGlrRkMKT/fq0Jm
         Z9d573vyCoDoEoCLWH2xCw4jXHOLvs9Uy/12fEdk2WQjxGNH3usW2OXVeJwUjjNUQiLZ
         VGy8R5dsgy7vySd8hStF8a1Y112hbqp7zjgm7MVNc34Lz8Pb+d7IfgOiLmtvfTpkQudC
         Ya9gFQZrProgNAxi+Nk8kr5mgS7Euy8vX/O2CS6MlQ8YHjgiVSR7nxy3/6ItKkud+VvS
         ikdA==
X-Forwarded-Encrypted: i=1; AJvYcCV53pDKGfG8FXHvq4VZ1Cw4hygSvwQDvuQRnWtOUPDPJ7cknkzgP7WWZhA5nzGc4mpnuo1eGOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWEUohu+RSEmH+cBao9ZmYZq1R9933LJyM2ibzfH2fqxEDRZg
	7PdKjm5EnOI0lmY99KA9QFVS9RY4YYjfi2bRLRFFOFLeQj/e4f7jXD2Dh5n3TVEwZkhRLdL8sCO
	3W+ML6E90yHOlnFh8C1yW/15W/JvqK31Xbx8Wz1ckUcyLSiiMqVg=
X-Gm-Gg: ASbGncs+OgSVwp28Nl45bk4QPtHtt6czgWaVyKrBJ5eweZbZSDs9qmK14b7l0K5Yqeh
	DGT46Z488A7q+RhT4g6WfZVpgWkg5UcVfpSua9EyHIeCb+/cUIUSj8iG+5XPblvshogyRCrOUHE
	SnZAfNrIiXPAYFIzdfWz2Q0oU0poTMlP9K4vB0qQZY+szga+rQ5fCVHmkgtqjVVAIKvhdQbmLFD
	ntXLuV0Zzsbors1++GHvkFVE10psaEBKdG690sgaSTH5NrvQmIpq79Zs7zHWJH8LtlrWTh1YNJr
	VsE/vx6Puku1eCpNKGYDVN+DZaOE3b8+tG6eo+CPE8scpQyjZzAjMnFrGp8aO9GzEJ69goCUMS2
	6zxk2jjv2rKrUDzMtx6VsDC+naHF0GGMw2usGb2+92UpXzTqoDqCDzKlN0w==
X-Google-Smtp-Source: AGHT+IEDd8RakqbZvJx8ep3u1Rv4vOEEfDZoBRmyRMJpM1OoSSstgqKg0Glvc+NMjDRqfB88zTmr8Q==
X-Received: by 2002:a17:907:7b8c:b0:ae3:60fb:1b3b with SMTP id a640c23a62f3a-ae6fcb65a5cmr1840846766b.58.1752590201695;
        Tue, 15 Jul 2025 07:36:41 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:c351:6ad1:c4bb:877? ([2001:67c:2fbc:1:c351:6ad1:c4bb:877])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82e5309sm1021233166b.173.2025.07.15.07.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 07:36:41 -0700 (PDT)
Message-ID: <d063c580-9e52-4f2b-ada2-7ca097cb9b85@openvpn.net>
Date: Tue, 15 Jul 2025 16:36:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
To: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ralf Lici <ralf@mandelbit.com>
References: <20250703114513.18071-1-antonio@openvpn.net>
 <20250703114513.18071-3-antonio@openvpn.net> <aGaApy-muPmgfGtR@krikkit>
 <20250707144828.75f33945@kernel.org> <aGzw2RqUP-yMaVFh@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aGzw2RqUP-yMaVFh@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/07/2025 12:20, Sabrina Dubroca wrote:
[...]
> In ovpn we should also reject attributes from GET and DEL that aren't
> currently used to match the peer we want to get/delete (ie everything
> except PEER_ID), while still being able to parse all possible peer
> attributes from the kernel's reply (only for GET). So I guess we'd
> want a different variant of the nested attribute "peer" for the
> request and reply here:
> 
>      -
>        name: peer-get
>        attribute-set: ovpn
>        flags: [admin-perm]
>        doc: Retrieve data about existing remote peers (or a specific one)
>        do:
>          pre: ovpn-nl-pre-doit
>          post: ovpn-nl-post-doit
>          request:
>            attributes:
>              - ifindex
>              - peer
>          reply:
>            attributes:
>              - peer
>        dump:
>          request:
>            attributes:
>              - ifindex
>          reply:
>            attributes:
>              - peer
> 
> 

As Jakub predicted, I am hitting a problem with PEER_GET: the 
attribute-set is one for the entire op, therefore I can't specify two 
different sets for request and reply.

I presume I need to leave PEER_GET on the main 'ovpn' set and then 
opencode the restriction of having only the ID in the request.

Similarly goes for KEY_GET.

Sabrina, Jakub, does it make sense to you?


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


