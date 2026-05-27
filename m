Return-Path: <netdev+bounces-292278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA9yKV3nFmruvgcAu9opvQ
	(envelope-from <netdev+bounces-292278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:45:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE95E45FA
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C17533004DF9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D713E402B87;
	Wed, 27 May 2026 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RmW/nc2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20366274B23
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885915; cv=none; b=t8JfNMyeui1NJtYaqSaTRl7Rbv3z39HCfjuX48Y9pbW2VhhZ5MZPiDOpY/DQ2bMUyN4vCPP9BxHkxe1WbuMg5PpW7riy/5cy2rVH3IuOvYF22JCy84CIvQJxlRbFlsGmoUrwfIpKdFZYxtJttXSFHBhCwBmC1ym7aTXuKnVjO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885915; c=relaxed/simple;
	bh=E0ww/mImxMCqFK0RHHzY1YTcIE+COH1OBBGQh9QJxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ji1FGiNgJBG8QrZBq7ByFp+u06wjuD7z5PYQCWbbgdVCzAkdlsERERBJBasQDaAYb2ml7D5lD6rAAJK37o5+vo1VzHgm+6GpMAJlza91cYHcqDP9309yv8+nykt9aaxKBjy2tdRMS5Hvyv9dlqzAKLABBSMkcuB7F3+McZQzziE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RmW/nc2g; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49048e043e5so40890245e9.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779885910; x=1780490710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHBdThNTqAYB3DjIYilEBtmdQBkxIEzumsc+G4ZjJ1o=;
        b=RmW/nc2gYaDLVa7jJ07j+/SHt7oNDQTm1OMUkx3u/jJkRyrIEVwGQx49JNi5fj/Thn
         oKrjetcVQ5yU/8ZzjbvvaQZdv65iJJOzt5ZtIkytazxl9rcT+2CZyChbUdg5m9nsDLev
         yRaIefUGxQzeBvxP8M2aZlqGTXn9I1aFYl5/EhQT3EPK0AYJ5lbSVvgqaiqhYtwZF83R
         dRERMVPwRF4T3dFlSJz639LtboU5z5i8/SqtlAy6BTJUs0O5KDIdBPItYb+kdvM2OSqX
         54sm3mw6Bt48Ocliq3EolqiHYWBjbrqrUmWzeA8DZ8abetdjVdmPAs+SwDOXrgXikuuk
         IwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885910; x=1780490710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vHBdThNTqAYB3DjIYilEBtmdQBkxIEzumsc+G4ZjJ1o=;
        b=n0/NOQ5zoXVadZfJrg4O76+qMbyzkzpwElV77g/5gs1/uDL02KGjBGe2xSkX1CaQrh
         ofxqn4iB2aawdEBp4XE/t8bPM6oq9YZLB2ej/8MYZv2lSjcgghiali6iYfMqF2Yk7w8B
         zod7XR85ghjWk91mHXYXp2ltj+cy+0ZwzGbEg5J0pXKS/9S0qqIxAcrufhWhANjRmod0
         SVv+wCN28CRnpNV149Xv5R+PmCPzi5XfVfqfbmfzn3lqZ+ipJqIn6fPaLN3VbLghgLj4
         sY+kvZreWvVZYzYfhJhOhuThw1JHLUUP+iO9qRxhUL1Yx1p/UvjwWKmq676PgXcsnOxW
         9EXg==
X-Forwarded-Encrypted: i=1; AFNElJ9WoZZ45wSBF0ptXyceh7chuzLKFpIxmpYZLkc20pU/9IxnEXurw7ylX86lk/cv/J7b3/+ECAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hqWSKUHivTE3kAjsMSpin4FQq8lsJmYDdbVhEPYbH9Ai4O3P
	/F+jj457wCnp4WAS8TDxBMOyQiLvmu+3tSftWP/VZmpFsEU+80/atxmuAYQqO5+IXu90+hjO/rw
	ik8ueyr3ue6WdcWHEpy0UDQRy0RGDtsASefEGr7k9JsyNFnrrEfg=
X-Gm-Gg: Acq92OEZS686MiRA+EwFeKHdq/b7JzbUWBvISZEYmxZ7YfNPsjM3rRWQSRR/GRCyHMn
	m/JuIeuC1cggebsSAWUGn9ejuK403HF+Y6hp5bPqUylQNmGQWDbDMVnVRdBpOKggFEaFZkTf46c
	1Vlozc5qUJoxgeTbALJbl6hoI8ZSJFBLxvItuEhAC1o2Xsn/B0L/5aQmc/wBl5GUl5I4tqjphKn
	sgQhp4orvdRQrzejtqtMmDne4IBrtniw9qjmHbJ03IqGm74+An6rNbbnGZq4sIK8XP9J6BBpTi0
	WPjdh4PVh2Zbl5rZEXUU0nOUy5euQ20taARz27PisyADysI6NtPEMlD9C3a/OYcEY8jqMI6n22b
	wCiLzuBZVVPXoWQGexBe0jboCToNnrUK3Kk8j71XnARVNcbvu+cZyFbcnmejIimn9MAaELJzcbK
	9cx1r1GmMcyKqWG+DtFt6VTZmCoQ70cC1lhWeixPDTwFzFguBtjLtQtdSz
X-Received: by 2002:a05:600c:81c5:b0:48a:75b9:b0bc with SMTP id 5b1f17b1804b1-490428e6ab6mr350408395e9.29.1779885910130;
        Wed, 27 May 2026 05:45:10 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:694:3a59:aa58:3b16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0cd5sm488685565e9.10.2026.05.27.05.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:45:09 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>,
	Qing Ming <a0yami@mailbox.org>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovpn: avoid putting unrelated P2P peer on socket release
Date: Wed, 27 May 2026 14:42:57 +0200
Message-ID: <177988534230.2817822.16171924585936776633.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523081543.94507-1-a0yami@mailbox.org>
References: <20260523081543.94507-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292278-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 77AE95E45FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 23 May 2026 16:15:43 +0800, Qing Ming wrote:
> ovpn_peer_release_p2p() is called when an OVPN UDP socket is being
> destroyed. It checks the currently published P2P peer and releases it only
> if that peer still uses the socket being destroyed.
> 
> A peer replacement can publish a new peer before the old UDP socket is
> destroyed. When the old socket destruction path runs afterwards,
> ovpn_peer_release_p2p() observes the new peer through ovpn->peer. Since the
> new peer uses a different socket, the function takes the socket mismatch
> branch.
> 
> [...]

Applied, thanks!

[1/1] ovpn: avoid putting unrelated P2P peer on socket release
      commit: 532692e621e44252c99a3322c0604889f0af7dee

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>

