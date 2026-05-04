Return-Path: <netdev+bounces-283967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Hv5G13U+Gm41AIAu9opvQ
	(envelope-from <netdev+bounces-283967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:16:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B24C1D06
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 345E6303CA49
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB143E3D9D;
	Mon,  4 May 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DI14WPC2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386BF3E3C70
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914882; cv=none; b=K+6G3a7KYOoMc5QL/NMzFFFUfWVHURfLBqbPEAOwFgl/bYBHbhvtBNm/UhzjtMV3B9Q9H23me4hSBHqwk0+RTRja6Vndh30aVtIUAofIq6rdIiXdYGIMljJ1pjxLwhmXzYqoWXM/yxErU7i/ACFX3FGw4J3tDsCU1qo3Slbxn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914882; c=relaxed/simple;
	bh=gGhv5aBvag8GkJJw8oK+HvN5ptj86XyPHMattSfFigo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oog+00XJEhvjrFRL3/i/pMdaE3leEjBKGHjvw3wcf2RLmyY8Mr7/66kWrDBLUgj8lQMlXtQ8oO+OuaO3pAI96GpOenAbE3SMzeS9oXx6Nx83p6G6Fqf0Bry2EQ83TblOvUsS0YDJzgQipNMs0b9p0xLzGChkgVKbx60gd6CuRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DI14WPC2; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64d5a7926cfso4148139d50.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914880; x=1778519680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=DI14WPC2wnkewoRYZry85ZxY+ipIWLtEYITEHtf283ICw1sHSz3p/TiAqWEXJDd59F
         /BhFrabnLgIRwRsEmPg4w6tF60HHxKOpXn82PQ+ss1hJSzIvXqpzBdFm5OU6Uz1l2YQi
         QAXnA9fub1TVdUMGE+oEisUTVDJ0xN4l4FNWAZjTypSEXEv1NjUZltedFZZdmkq9slzm
         tZhIPCmy/sT2X942gaoVGepvErELv7KhVzXD7/B1SrE/85pIbGaN8NVlZB9ws2IEKQxj
         OJhLxh1b+1gT/KcdiSfNv++109GpFnseMArG4WZMiZSAL5129FaCx7QQLJ2oyCnUt03/
         zvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914880; x=1778519680;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar9A5QrYRWGb5NIZabW3eNiZEMmSWnS35Z/zWd2ipnM=;
        b=nFzs7fagOzGYwXs3cp2qtSflTzdDRNh/Sh7n5cofFaQsk0uXfBINDdWdtKZc1tnYG+
         dN/C6BDUDe/AMxXIojnIsJAz9CSazgt2QeFYCzYG9HqT83xuA0YJoKjSjyl4RTVYi8or
         PYu7vMNTXtM9RXQm6ZkeRWOpA9C5e9bB5jNv6etKRztfsCJEcSEvPIUYUmJwtvTVeaXQ
         QCYagVU5I1YOqQT7G8E/FMZNBJADB2idsdr8Ebyq12KJtAtGHGh1RLGPxwhVjsGQcULz
         gyskv16l3B+La7A6nFOnUrF13XmkWPm1C8kn1mBwWXMEAY0k9mOoXaEjB+A3hvqpw9iL
         rBAw==
X-Forwarded-Encrypted: i=1; AFNElJ8ovVKHmlWb2+Xkhnj1omX3QFVdQgLwvXig2b7OoXusWXGmfi2perPKYIYDyxUpf+WZjxEJuyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl26xsAnpw6NrIj8RuAWKTIAPSv1denlCdLUMsi8Rq3xuncezI
	6qW1D8dFOsX3YS9q+GwQx7vuMydXI4beBQ54HtHSSy0whDgN/P6HK+ztKMfNZQ==
X-Gm-Gg: AeBDieuAP//H8s4ZwrSJLu33gZ/rXyI09dUUM7xLEkzE41yDs+ixKg+OvNatt3cR+23
	IubPzhc5MZD0l4LwO4W2C8dZxr+cHV5wxlnZfTMy6uKAXOmoJxQywl2QYzZfXLnwkDTVmVnO1Kd
	PPczzu95zQAemthpi4m1ULrOryQDDxT8WkP5kgT9iqKF9r7lGXkU39mFRqjMaBS6TSkHkN9hMMA
	htewYRlP+1Y9TDPgHfMlaaOJbsNpOf/yX++k4RFuSnzE5Qm145hRv7Me0GRD6EnA8FLFm72xz8G
	z/+E8P8/x96+EGpLv27PsRuArPHxqq29WsPRrNiszY7VoNXgaEJhi8ZpAMmg3V6ObXtF2b6/f/J
	g0NW/C+jflEaYYsDG7TdeTWVRQKpCgNzfx5vt6p3K3HRNOVcE0oV+bHze3aw0zecpe8Z7CfDABw
	/IGJGu4Wx8yHBCg+7oMZ646KsW0l8MKXajuf55CyGRjUVTfiT1LDdj9dD5UME/9Un4anuMUqdEW
	yI17mXk9IY1Blrnf6PLK5IHMw==
X-Received: by 2002:a05:690e:d41:b0:651:b13e:f9ef with SMTP id 956f58d0204a3-65c3d9a2bb6mr9826363d50.14.1777914880194;
        Mon, 04 May 2026 10:14:40 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1bb5adsm5751702d50.7.2026.05.04.10.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:14:39 -0700 (PDT)
Date: Mon, 04 May 2026 13:14:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3bdd02f2dd7c@gmail.com>
In-Reply-To: <20260504101759.3319427-3-nhudson@akamai.com>
References: <20260504101759.3319427-1-nhudson@akamai.com>
 <20260504101759.3319427-3-nhudson@akamai.com>
Subject: Re: [PATCH v6 2/6] bpf: refactor masks for ADJ_ROOM flags and encap
 validation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C43B24C1D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283967-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email]

Nick Hudson wrote:
> Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
> validation logic and introduce:
> 
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Refactor existing validation checks in bpf_skb_net_shrink()
> and bpf_skb_adjust_room() to use the new masks (no behavior change).
> 
> This is in preparation for supporting the new decap flags.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

