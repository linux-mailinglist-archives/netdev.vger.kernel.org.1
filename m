Return-Path: <netdev+bounces-289082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qODyJDweC2q8DgUAu9opvQ
	(envelope-from <netdev+bounces-289082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:12:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE53B56E710
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3312330343E9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78DA3793DE;
	Mon, 18 May 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pX2ThYEd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881694315F
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112619; cv=none; b=Sy7yQWMnO33w6jKTzFY31kLqC4yyNpCgk1HNPLBA+EBJeZs4Av8n4Ump6uyW5t+lwIYDWg67RBlLMWw/VEb5kKEOCtvtwBm6kY+s3JSXYJa5SFluWV3we8dKbzbioyh/IM1lrkzut8WjPaD8X9Q7iGBYeakGbuBMUyWAmzA+x3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112619; c=relaxed/simple;
	bh=/W9pD0HKew0iA/EeshWUTfYiNJ1bfIbcDrX808DQYo4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=UMLOZzuSfZqUhMkZZoL8BSOjPckjp6VvLsIlgXeRMwp0FV9DOzWnA3p27700BQJJQ72dpHVm4UTHtyULb4BiCN+V9bx7CdwS/XGBmfHv63yPTz4WEwyplqqNxW+uNGhVaaE3HjfuFpS1DoIcxOBmSB5mrUjcaUa+vO2k7m92yeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pX2ThYEd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso31643365e9.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112617; x=1779717417; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJrhjTPuMfvEFTG0qlotlJlzRB+WiMenwkw8JGsUgUg=;
        b=pX2ThYEdfnjx+HkP8UHQXbXtLiuOll75uvg/WNiTKG2iP6G7oy7SPYZEcyPItEHn57
         l39yi2yqCGJszSmV1oQnep5uuEE3G50kYN4rsUx8idLBYI+UAauFPLRhGH0WJvax26Qo
         3wJApu8VGbpreLND+S/CeiJZFF53P1XeQy5ezSnpQYhpxNppeLfEAPEPRfSiEAUbNuCw
         2lEUpHcV4ii7lbyT5h+aSknMrcAyKH/yOkabceiWyCrGIZKk1MOpkvRZpelh5Ph8PjoI
         BS8/ezwRH5pSxYRAkNnb+sr2uibFBcTJxhwNQZV3KAZmmyysPQxIIIvATYVSM0wm7F/W
         6Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112617; x=1779717417;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VJrhjTPuMfvEFTG0qlotlJlzRB+WiMenwkw8JGsUgUg=;
        b=TPWU6rYYNuEw42hlltEovFrURna8WWIYy1rncdQryS4T7QGgtrvor/0OIqoNaRYsRk
         47Yl4mg+STRsQm30WYAZ6OKGn9LoNBgvdIaM+a8Kj+2GU1pYc0xmy8uug7rGz88WZmyo
         oJYqFtdR2OYorF/f/iqa/1tKul6UGNaUgpuw4iJFfGoMj/q8GrqZU9Y9ODxBI8GEGuL4
         4bwJqc+lHUv+ydhHDC6thQa3g3vy45CJYglMvnXV9TIk50x4nsSZ+ltCT0Bpcu0rebAA
         XMmmA6TKyd4FYTXy82V2j6n/Re1bqt9K182qITP0OOpzolNXRASRzBbFpyfsT+T/CQEV
         hQlw==
X-Gm-Message-State: AOJu0YzyKwRpzmtZzGo0CguLeoxM4LhjLymuoaV0yRmNWBAyun8pf7gc
	9axk1aERYDuczVn1x7I7b6BXS0aVf17FLALqBZl3PONP9de8ImxiJu9v
X-Gm-Gg: Acq92OFbGfpdBDq5XC3WTuoCsod3vA9JX7vOtAu0tQKU4dI7BDRN/7XL9fDJ8G8tbdD
	BoWF9SNsVrqB3a1ZDqAF56q73UIavd8mbqwOPa/0qS9BkHjBV8drAiL4kY4KOVl872EEj19FDx9
	TV48keo9SZIa8jpcHVSEfEX0CBOMODnFTVZ3rPQaQVdw3QZfEi64K0LVsFS0GFHSpwAfUfJGfWN
	jV/Rk19SdVYCNb5/WLHMJM57eBfLAe8lX11HYJp3Utj69CIrX/Tc7rPvAslS9qn0kjSyrraNToy
	2D17IIGpygqMHLOgkqNjHHXpZk3RaETki40+c3qrVNk/xcaqq0j4pkqmbooPQAHc/oKwFdnxDpM
	z2Q8QtNA6t8QaEuiGgepe82s16iXAVdVggPhkD/DrWCUBwAK8+zKQA8xBAMNp3pGiHKsLfM5Hl9
	LPHOkk0oFmlnwmu0vUvEBFWXZBHg==
X-Received: by 2002:a05:600c:4e53:b0:490:1640:8269 with SMTP id 5b1f17b1804b1-490164089c7mr32009145e9.18.1779112616709;
        Mon, 18 May 2026 06:56:56 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a666fsm36160534f8f.36.2026.05.18.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:56:56 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  Jakub Kicinski <kuba@kernel.org>,  "David S .
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Aaron Conole
 <aconole@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] netlink: specs: add OVS packet family specification
In-Reply-To: <20260517083358.2088599-2-houminxi@gmail.com>
Date: Mon, 18 May 2026 14:52:10 +0100
Message-ID: <m2jyt0vn91.fsf@gmail.com>
References: <20260517083358.2088599-1-houminxi@gmail.com>
	<20260517083358.2088599-2-houminxi@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BE53B56E710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Minxi Hou <houminxi@gmail.com> writes:

> +operations:
> +  fixed-header: ovs-header
> +  name-prefix: ovs-packet-cmd-
> +  list:
> +    -
> +      name: miss
> +      doc: Notify userspace of a flow table miss for a received packet.
> +      value: 1
> +      attribute-set: packet
> +      event:
> +        attributes:

Instead of repeating the same attributes, this attribute list could be
declared with an anchor name such as &event-attrs which could be
referenced in the action event. E.g.

           attributes: &event-attrs

> +          - packet
> +          - key
> +          - userdata
> +          - actions
> +          - egress-tun-key
> +          - mru
> +          - len
> +          - hash
> +    -
> +      name: action
> +      doc: Notify userspace as requested by an OVS_ACTION_ATTR_USERSPACE action.
> +      value: 2
> +      attribute-set: packet
> +      event:
> +        attributes:

           attributes: *event-attrs

> +          - packet
> +          - key
> +          - userdata
> +          - actions
> +          - egress-tun-key
> +          - mru
> +          - len
> +          - hash

Otherwise looks good to me, thanks.

