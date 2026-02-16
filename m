Return-Path: <netdev+bounces-258816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eQL3I+9nkmkltwEAu9opvQ
	(envelope-from <netdev+bounces-258816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:42:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC931407A3
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96D44300CE48
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D6A2475CE;
	Mon, 16 Feb 2026 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CknASVuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61F19FA93
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 00:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771202540; cv=pass; b=I+0J9SxZZIVHzVLcO4CxgbaK14cC47hp3R075eRJLJaN2h6iIgJlQmcJGqsRka7REpZKbvj9T931mXQ2ezyzUh3+JO4x6cKOBS0aBuC5iQU6q/U/dKyqS37MB+BO3P/nqeESqUj4hJHSAuHmnkZKrp5j/B9LsuqYEuStmY8VCXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771202540; c=relaxed/simple;
	bh=WhNo2r6N6M1Eu9j86jU48A6jKnJw+sGT36QQpXnq6SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D7x72Pfpqns9gDm0qlu/skrOVdLLyQ2hr3roUiWjypn2sSeAsP7SQ1ZnGVnCxrtn3PFhc4NFDhHZkzvIkLlbE5aaSoRm0+08dTtYvmZAXcIc4RTtNoU59f18GtaFgzyjW/db8VLd7Bkkt6YbBrrDq+jVnazE1qd+dUj+q7rwz5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CknASVuP; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a95e592fso2090891c88.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 16:42:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771202539; cv=none;
        d=google.com; s=arc-20240605;
        b=FkQ065KObmB6//wF/B22drijlb5kZ2xWujAtb7OYSND/Fq2N/vNiEF+J/Vfiy0RmOa
         4ouSp0F4vOgaAY7ZyWdOHja9y1EYUmH11+P6HJUwgZ5ExhcsotqvCy/o2GKKke0i920D
         U8lpJQcBnZKisFfuzflaaw4pilOvd7Zvsmr2uyld2uu6I85pK9yeKT1+fv6/W8AuVY3H
         LlsUeKAzVrvDTJy4PHkEIBafnEF4EVtAn6CElizc0uvgKtdimwstnkTq5STr6h0NHZw/
         1+uCCe7FuODHQ4pYFbxmtXsk8FTo65AeABXsDe8cNNauQkCIEunATnyCupr5eRvFahaV
         OemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhNo2r6N6M1Eu9j86jU48A6jKnJw+sGT36QQpXnq6SA=;
        fh=eJOoqzbj4SvqWRDXZQCqEMyFnKomGhIVZ5BRCGkKh5w=;
        b=WeaJAW4m5cB8LYLZi5RU5lYjAvtYIVTP+k8qK3QuKku86Kpe5UDXT7tacKWlll+eLu
         7jpcc/eA6vDowZdVgGoFBdezop5CexY9TDs51GEaUQjHs9BaJ4D2Nq5v4vJ2onJ4+K/S
         qZLcSUdg+GrOmzthU8Dkhp0cwOosXHR2NxhG4aMcIlEthmMYoKpfOXWM5sWzTpbRuqQC
         cM6MKt31HQKVa1yNJLfp1b3kAv4TEAbBDUm5/UF403yNPXcJPegFomEULLlBSpOvpqYj
         I9ysWqhObROpJE4lEVmKxj34jXVYtPzBbtPQ1+qkQ7egn6tafleRXc+c525hENxQDxaE
         s90g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771202539; x=1771807339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhNo2r6N6M1Eu9j86jU48A6jKnJw+sGT36QQpXnq6SA=;
        b=CknASVuPoy8BrHiwGOmsTyAjOCMwruGBsbF4akJJoGktJMgtlVA08v3hX7zhB9+H/w
         QvwDfmY5PYZr1CEVGazObwlrwORnnDls0KgjzjbSM0xc/zlH7RIdosKkUTtC43/t/0Bn
         Mg8RKyzADGJjzyJb3tKjuRcHXWodUzLQN34svms0IhFy7KiuSiKgrohiqEFkCdapP6Sl
         XI8cJlzrYmT9gHaECaODLcBp1i3a/r8j0HTELQks5zrLzHwVJ2B2Opa2gQ71jUPu9Svf
         HCp2lD0Wuiq6uiBTgjGGU1LjmXsR9HGe/eE0iOCeFrkqy1sOcxecGcbrA5rB6XRfz2EO
         RFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771202539; x=1771807339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhNo2r6N6M1Eu9j86jU48A6jKnJw+sGT36QQpXnq6SA=;
        b=s9DGxAFDGAPjpveMO7EgLk+EqnouqjMhhFTX9S1cijW5l36sV9Yspf34ek+u4Rif0N
         brgmObmLg8Li2dID0oUzx9eN1uoBAOjeXp3kSzv4/1PRKocpIy0HDhAlyJpwNkxwFAgG
         PeHKyVSyfjTu7Hnqv5z/+nIg8+PaQMZZLp4qTqqxQAYs6lsbaxXedxvO3ESKYmPF8JXG
         MeU3zZPCnYjXmK7bOSiSWnQJfxE9/9TYnDVxtCibMmmC2gTy9knP2MLeUFpW97VBe5dT
         w0JZxUOCM+0dZh4HXCiAeM/kxXNUsppX9a3yfmCV/pCdEmIiWSlOGk9eNrfu/ETfnS0k
         c5Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVqMMpgw7WiFTZQrSPqQt5TlDAi80Pe8kfB/iZBgk3b5XFzZu1WeF6p/BxZMILuJTypHSi2I3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXDQRLnU8lcplS2QPAwEyfkv5jAUS6arXorHie/cK1nRgTbO0X
	6POrgV6pgiQXJfmYE2SWNYtfCiolspfUKxVHrUKl6oR94GwL5N6m6yfx7T59spdxZDgSvccMsMZ
	pZvh5jJ5Qr+0ujjA5/2BJBPlgYwEyIiLbEt16WhUl
X-Gm-Gg: AZuq6aL5aeohRFIzm/nN7J8uX2OjKvIWJOXbR7qlcX7J+nFWus1F5yFa3nXOy6HvBgQ
	fSYY0ypdlwd/waWSYdkDA25EoVfDMaC+3nuzlvBi6L9P2VZQ3K24JGbACdffJYe6FK1zim4i+1T
	nPfPpbcxxbbW6Qb7Jdq4tdNk6sIKXVjlfJrJ0JC9pHn9TSe5dmmqpOHcRQQg/M2pk5F1DtgwmvY
	gU8LqG9UtBlLW1KihfadSkAVJKo9U8qd6Aw6aU5qvmumgFbBXt9qgPxG18PmJ+6kZ8EBMewBWdS
	OJfITlpjTt4L4ah/PdUxiDunuS9SkUCQW+rs6MtjksJiv5SbjcghfB8YImOTETmwuzts/g==
X-Received: by 2002:a05:7022:49f:b0:11a:29e5:12e5 with SMTP id
 a92af1059eb24-1273ae33110mr3890386c88.30.1771202538440; Sun, 15 Feb 2026
 16:42:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com> <20260215143821.2330791-2-edumazet@google.com>
In-Reply-To: <20260215143821.2330791-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 16:42:07 -0800
X-Gm-Features: AaiRm50O1sNUm7sbYQOQqbZNGKrY8dQJSF50Ov5KTtOoPlfuMOicd-7_imY5rFo
Message-ID: <CAAVpQUCZ9nm1XFSmfQVb_zXFX5zDskDNz11a+2uf3NoojaZM1Q@mail.gmail.com>
Subject: Re: [PATCH net 1/5] icmp: prevent possible overflow in icmp_global_allow()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258816-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DEC931407A3
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Following expression can can overflow
> if sysctl_icmp_msgs_per_sec is big enough.
>
> sysctl_icmp_msgs_per_sec * delta / HZ;
>
> Fixes: 4cdf507d5452 ("icmp: add a global rate limitation")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

