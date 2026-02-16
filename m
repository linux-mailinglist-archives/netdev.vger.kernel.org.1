Return-Path: <netdev+bounces-258819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAHKK0tskmmMtwEAu9opvQ
	(envelope-from <netdev+bounces-258819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:00:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 459A914084C
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 800FB30041CB
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865CE2701B6;
	Mon, 16 Feb 2026 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zFhcAP5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8725F798
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203657; cv=pass; b=fcw2xYeC3/+4rcZTuUKLAWNlLULwgteK2OcnTVHO8u1NcXA+AwJDM5+d98z2EXeG1EdaR9HuPdSDb3V4UsCqpJt3WhQAo9ZCbskPsHi+dtsMb3893qeo+paSkkyAmGvBIL6G5TSgi9yx7rI3ajg7x1rJLdH/Uj+BhuSkmL53sEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203657; c=relaxed/simple;
	bh=WsLtCjOKF9JJbBpnIwQH+833sCw9B5/VQgjIpW9yEXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw0IDzO11HgQ+UnM+pGtyfUvwyJTH8t8BcIaGq/NN2E13VqWPJqEoCTT9ldNDBF5/PDhQSH0O9tD5O2d93fY9cFitvNirmlkXMj+v5cJ/ilejEQ2Ihok13tNoabJa+wZlO0fyC2q2QGke6H1PKmQKgZoKjzaf9cExTffhoebAms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zFhcAP5T; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1248d27f293so6273225c88.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 17:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203655; cv=none;
        d=google.com; s=arc-20240605;
        b=b0/j/nPAaaC3yBYOZAdgAFhUfIROYrcEZuFZ+ZQ+atXdHUmL8D/azwFlB2K36kocj2
         5raFT3/BPCWMxxju01e9FtecorntdilZCsY7fBmk7WxsMJe3QEWwGvT3K96SnPBqRQTk
         /W9JNz676jJGlecyIWsUfGpvvKNc4WXeXODoKHWUYjghfWxy6N082Bpi6VUGWzx7WHkr
         NW2CPasDX9wLR6aNI7Mjs9bWLeofaUV6q0C0dg2BZxB4GKAhFSSiGPv9xh03ib5GIVFP
         e8z2uuU0LO3QoW8uF3a4O8e6ZBNprj7EfJ/ElJ9DxFFMZ/MWNEAE3zNGP+/+UTBqZ9rY
         37ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WsLtCjOKF9JJbBpnIwQH+833sCw9B5/VQgjIpW9yEXk=;
        fh=mJRlSByH122A/3M0a3h8EQKmhGZRORnW4daFYHs9WrE=;
        b=dncEVcTZb2zR8MEBpFrmCUYh/9sRY2p7d8R3KxhGQdip4xzn7ucvI+lo21TVe4u9ni
         jiUVwMjjO1apQD0XvcPUZYStzqxr1VKhaeQ/2e9NC/bKtQVr7tbSyYO+bTSxAY8/Mvtn
         5KRQFpZe8T8VAdYykuOTbiIA+AdQh59zGu04FFm04t93jQIkLbeKjGp/OYcnIQJ22wIf
         2xY7hdBR6VrgijF4bqI5TD7EizbrS4LmAPZ5j0+henyEn7tkIcDvhG9Y0YMQW9l6ilaS
         bwfUf/VT2QcmdT8/5ym1QO/Vz4V0AGVvqizxNHoLdxrcMXRB4eqz3xxXC2cly7ib70tn
         ZL8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771203655; x=1771808455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsLtCjOKF9JJbBpnIwQH+833sCw9B5/VQgjIpW9yEXk=;
        b=zFhcAP5TkTuNnDjUQ1cYfOmvjfioGNfPGUmfsQGBF291Eu+6pdbya4SesA51FUK03g
         K/lGGFgm5nWvf+tMlkUVTCiXRiaFXv9n3cXS5sKOCqngHdSlW2UCLr3ka6ncXIJUGUc5
         y4iYDWUtjyyCyMyNuXFefSBtNlxCE/khiXZpeGpPm1lYnPPq3umWD8wM8HFkuwDq7gE0
         0YxmcG7m1nS+SY9RbSTyFoeVXCOIAv5csmVsdN6P/6G6bpx1MWU+ZvHHt+rTC5/oZhGd
         bUXf7akb3GF4VbDUQv07YDvoKqNhiE2P/LXRNuVZU8w6r4vWkhKeg39Uai8j2zMEIzGU
         3N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203655; x=1771808455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WsLtCjOKF9JJbBpnIwQH+833sCw9B5/VQgjIpW9yEXk=;
        b=QHgrgmMG6AqIcHukFQ8iDt5GxLgAmhY9GOXad+InLtjVg3Ek2Qv7COnlVOk/44oMeG
         27eRvUz2JqsMucuvSEBIwVhaTPNLfKLtFozG6wGCA1CbDnQm0Sp+UUVjYHdSmhLbAB5E
         knioM3LsJgx9dK4OwEb5agjgV1CaIsJV3Gr2Dm5nut8Q5nJo3Y5FqkGU1Bkr6oUZ10D+
         KMglAwCuDm1gdiHpaAd7j6p6Lf35MOnY43Nhje12OKDbN+WqObUWbFc5rbIYhX8dOPZm
         5BV82t6aSDPkbVKzw9KHJXsXDZLqUvx4xxjtLQcGpFB8nqFU/jAiq3hF+m4Dg1EKySmq
         Ub7A==
X-Forwarded-Encrypted: i=1; AJvYcCVLJmUCPcjyfVUSwP3+Vf0v2izM5GGcLEozsq94xOv3x+yuBFffpkxb4Iiu0knzIVsxkxOVUVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Bh5sajOgoAdvgwTQMPWVZbOmAHb+68TwmLEk+S8PWithT9T7
	v896KLmioWLinrMoCBE/kxxzRctOi1mVIR0ondV4/GtsXxGOKs5Lq/FM4np7Pz8BRBP5HiyZhsB
	gM4ZZ/e8NwxkUDLCxPm4RtvQMQzFthEWKpe9RlWJH
X-Gm-Gg: AZuq6aLnUFXObd4WEnSdERBBfJ4UlOeQA0iM8tl6lEgU7sqZJBRaPl7BDmE9Nph+pmT
	1j1la53C7uw7vO1xINHovziFKnHM5Vd4e9xmwEBkoV8p2bN6yS1c0W7+PQOXIN5YSkOmrpXY8mJ
	oMMZ+4uPP+QU87bl0jdnE8tkQ/D0CPyr7l5vqHcF+Mm2mfa2DJbRh/Az7BSBKIBDKZzljCIWy5Y
	Xt2dGAqoY4dNl3UOLU2fSTbUuxSpsjr0cdhO0FZvzAw5NSxCDquOMKjOTz59zik+vNKP1G3Q3lQ
	d+j5jPGowNysSpxTcc/kx4GmdJ7036I1oDCFPcQYspj+wxdNFzFBavR4pm42wEKMln+xsQ==
X-Received: by 2002:a05:7022:90e:b0:119:e56b:c73e with SMTP id
 a92af1059eb24-1273adf2a47mr5417665c88.3.1771203654917; Sun, 15 Feb 2026
 17:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com> <20260215143821.2330791-5-edumazet@google.com>
In-Reply-To: <20260215143821.2330791-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 17:00:43 -0800
X-Gm-Features: AaiRm52vmLuQ8SzzeHUfVoucwMZ9jVlESMhgm6TQSKZiqHZKAXImiDeEgn_hRl0
Message-ID: <CAAVpQUC=yAsWFwt89c+_JTbThhwO0h-DqSC2jbYQUHmBC=a=4w@mail.gmail.com>
Subject: Re: [PATCH net 4/5] ipv4: icmp: icmpv4_xrlim_allow() optimization if
 net.ipv4.icmp_ratelimit is zero
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258819-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 459A914084C
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> If net.ipv4.icmp_ratelimit is zero, we do not have to call
> inet_getpeer_v4() and inet_peer_xrlim_allow().
>
> Both can be very expensive under DDOS.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

