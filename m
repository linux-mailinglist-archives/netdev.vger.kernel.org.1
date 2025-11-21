Return-Path: <netdev+bounces-240745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93423C78EA9
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AA124E9CFC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53183081C6;
	Fri, 21 Nov 2025 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5x9E16Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9A2F1FE7
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763726141; cv=none; b=hCLoC82NNnpAE2sTeQNz/c/8J4xjPUMiPTte42h8MEKAe8sIq84BXMTPpX9AaH4vxeKPAcI7nUifUOvi3Zq4JgqRpHGmlkjU0hjSWAgVU21TaEwre3QIfwR0EGPn8EdRymsoEfI6OXY9kjWR/UbcGEZE09p+aPuYr3sLJihHKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763726141; c=relaxed/simple;
	bh=BCuwsxN4wT9xb1KQ+7jRZodv0F6+z6Q1IawNA3LunJE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Gyh2pKo5DdxOJPhve6xPNM0tRrO50R1b5iUnT3ROMF4t3cJ4cqE0+Hy/uAUVR5eoY3tJ5ajZHshNgOn8Nn9fFQwrI8QFhYszSpkz9mEfu5xaF7s152jzy/XoNcJ66zYMuxEGx7COgIYhL8dBamGN0ORNhwx0yAcjDtgYFU1WasE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5x9E16Q; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b379cd896so1143672f8f.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763726138; x=1764330938; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDriZHKoYlumz0kyJ+iuC42fqsgc1CZpksWMuirWE2A=;
        b=C5x9E16QbtpONLsKhXOr6T8ipoQ80MpBXXpx6SMwI0xySTR56AbMiv0ktergURdKJW
         u3VsjlsCIaTERQQx6+s2XYDzyWZHXpWzsKBjLNhqihZqHu6xvtFNgA5ZcTjzNZjxE56b
         Z8zAeMx4m+WKDGQLnwCfmTyF3qIEVkT0dPEfyi/2E/eFOdx7L4nbkQmJQhf2knTuxNlO
         jtWdVLMmyoIQN85xE/vBtl5BxvcMWATfwKP8CCeYPiVhxTcd5WL6oIvc3RNrymyMlfTT
         K16BzTGGZm3T3NNqkLPAV1wLZu3v3a3eZHcAlaLmICpWrNo6PkaU353gvNIyGbOmEaU3
         k/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763726138; x=1764330938;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oDriZHKoYlumz0kyJ+iuC42fqsgc1CZpksWMuirWE2A=;
        b=iTkA27fvycD9zzSJRR31oisbJg7UECDnqZ3C54zxR1nPUhRzkRl1opVjsGF7EzgFYs
         QpfloXNIjShv7ay6twlJiX1OXGcaA5A5U8bOxVNefJ99B+aAlH9mddUJ7Agmqg7kaSQc
         taUXXXKqodXRDOKxSXbgQD3lKFztB8oG+Kfa2kLX2pwYNRDLfO/uel/Ljv56NJ1I5pzF
         J1eXaf6gpYyzlIOvFeOAQwd1yNKGd0U9fMp3IZHOHS6W10VPrGxJ3QZoAGlaPN9Dia/j
         IR8qBQC2EfddPZD9s4+9ZBJJepjXOnjVi4EYZy9Bh4HGklyjmgpdK+ImceNNMc/ndyFb
         48zA==
X-Forwarded-Encrypted: i=1; AJvYcCXxlufwMVYXclL9NSxfjfiKzi0GZRQiZPJGfTB1YhL6HJq0Qi2JH7Pz8a1nxP/JcHAUlARp6AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjAGVk5wYXHQkF/MQJ1jmL8mQNYXw/T0jAyUjzmNbSUFaeEbZ0
	zsYL7sf3UqWcttlK71dHf2/oqVfm49PaMbmPv0aF9Z3ISPrmSnSvSytT
X-Gm-Gg: ASbGncszWJGbn9gtzbOGiHqI835hLTL8+3yOMZdkaJu6bT5D0jVFF69Qn5ORPKrpJOw
	75diK0lENKFXHHykRKVPl62L46onPJEkChxN2NC7gcIcZZk5+cmpKtJuceTtn+NHf1vbkhfPmb7
	VMeTi+ZeY5a++paT6Uk7SwHU1ZaHYFBp3DQ7rz5rab6KjMMiOPQPCMglbX3KNwM+2vFXSQgi8uW
	OSFypZVubYCU3ju4SKbFh51XDaUubqMR80v4TogBIcbpnhgx870hcDLVFcspzDfR6WcE9RKh+GP
	H/R2HlYQq89sZIthhiuhTplNnTUJUyCwKomUkRAQU1CKovmVZfxozpzjTL8fASLbyuggXULjpcT
	GXhmDVzS4D4HLybtoxqJRB8wwjqMobzWK+5dBZQfsqXXhM702DDAJJfzAHPibOESyP9Tjr8jDxT
	zcGQoIezoceE6QwefMk0KHzItHdMf3qpRTOQ==
X-Google-Smtp-Source: AGHT+IH0a0jaDfCVovpxy3z9csXD4B+JfYy/Q8r+BidsjxSKcegW0mK4p8CA8FZ7pwMUWQkuiKA/BQ==
X-Received: by 2002:a05:6000:2507:b0:42b:52c4:6631 with SMTP id ffacd0b85a97d-42cc19f5797mr2076239f8f.0.1763726138266;
        Fri, 21 Nov 2025 03:55:38 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f819:b939:9ed6:5114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8e54sm10802902f8f.40.2025.11.21.03.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:55:37 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>,  Jozsef Kadlecsik <kadlec@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,
  netfilter-devel@vger.kernel.org,  coreteam@netfilter.org
Subject: Re: [PATCH v5 4/6] doc/netlink: nftables: Add sub-messages
In-Reply-To: <20251120151754.1111675-5-one-d-wide@protonmail.com>
Date: Fri, 21 Nov 2025 11:40:55 +0000
Message-ID: <m2ecpr4nqw.fsf@gmail.com>
References: <20251120151754.1111675-1-one-d-wide@protonmail.com>
	<20251120151754.1111675-5-one-d-wide@protonmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> New sub-messsages:
> - match
> - range
> - numgen
> - log
>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
> ---
>  Documentation/netlink/specs/nftables.yaml | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
> index 01f44da90..3cad6f857 100644
> --- a/Documentation/netlink/specs/nftables.yaml
> +++ b/Documentation/netlink/specs/nftables.yaml
> @@ -1471,6 +1471,21 @@ sub-messages:
>        -
>          value: tproxy
>          attribute-set: expr-tproxy-attrs
> +      -
> +        value: match
> +        attribute-set: compat-match-attrs

Prefer to keep the sub-message list sorted please.

> +      -
> +        value: range
> +        attribute-set: range-attrs
> +      -
> +        value: numgen
> +        attribute-set: numgen-attrs
> +      -
> +        value: log
> +        attribute-set: log-attrs
> +        # There're more sub-messages to go:
> +        #   grep -A10 nft_expr_type
> +        # and look for .name\s*=\s*"..."
>    -
>      name: obj-data
>      formats:

