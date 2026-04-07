Return-Path: <netdev+bounces-276069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIiWGo0s1Wli1wcAu9opvQ
	(envelope-from <netdev+bounces-276069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 133E43B1895
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 18:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE5FA305DB15
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53303D524E;
	Tue,  7 Apr 2026 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jc7LPtC2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA13D75DE
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577861; cv=pass; b=jP3UkY202P0SXaBuMZyrBLDUZStTPJb0HhOKO7PKLjrBF6GzS2j98UNMTzC/4SUA0rc5XRniY0fJAQaD3jLTqzirc8WomJ6AQUKOoV8ZcHc110CKljXig2IedfXsINZWhS/1vihjr15xM/Xx4Vbho7F+NX1V5PpS6Ak8lFFTq4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577861; c=relaxed/simple;
	bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P20tl+6u7CM4vTGfSkSIyIiSqEN1afByjUQ0AD6oG/SuQB7qHY2UHdBRLhrCKEnb9dmokwdfVUNGSCzJ8ATZzJMvlMsrpXJzsN8cIo1v8Yc79IGkym33KllbdkA/XKPMqlFNp8xzYHlINUgqbKpeoTyLuGNjGO5lLv6+DTj9vEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jc7LPtC2; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c04152730so823166366b.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 09:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775577853; cv=none;
        d=google.com; s=arc-20240605;
        b=l0lu4wIX2I4M4tN5ZisYPfed/0nAhinhgn86BVz1fLadKXr27tkq4c0NR5YqAPRpGe
         JakC7xFva+StQTQT1ulYoIwvX+7+ClHxaOe3QMxqOyHOAgmuMaKS3DFmK8sy855w0EoZ
         Nt6x/00eG5Pjme8yyMIrh8c4lW5PIcIf/Lg9Z08mlN3jir4AnGAyKOT9cYuDSGm4ggsY
         t5ZcVO3o+3vnVOfb+LCg4Q47xkoXfyz3GYNknAjBEkk7skuTcyiblBN7763BDezZmq/C
         4ThUqXm8vSGfZQprbSb9Njv27DKzRjdxK5P+6DNcvm/0Q57Qs90yl7VvWWYUDdBQ8W8C
         05lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
        fh=RSx0pfZ9ZLas3LSyOpCnfzlMe/aIdBoHTo55oXh7/sY=;
        b=Roh3pFw1Kl8IOBLjcXbfz5ifxMu8Xcnla9/Ytr/oyHDyK6wpkJQd1XRJzQ9FZn0kXF
         AYwCBQbZy6Amhg2DzRYthYQZWV0kyqcgXu/Jcouir+YmAHiGC68fUpNqJ19lxMXFgSfU
         Rc1zDkVmoynS8vtAcj1x8qyYlZ7xD77T6pm7xfYJbLE49WXW8rDYiR5HMOmb2acVzitN
         Ix3b2vp1Fj7TiHWTEpThWeDRt1lyj0+5TDXuf/agN/iD7SU6+0UBON4zaLkD2ujn5FYM
         9ib55BW9+BwNZvz12WrVtof245YTV3eKPqmTw1psnW90aMp9rXINU2d7iXCTF1YnlaJr
         8CSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775577853; x=1776182653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
        b=jc7LPtC24qwdF92hG3E1yoyIbi6ETGZAQoBz9abpWpIG+oBDPZlqk8bKxFi6SQR+RC
         u+5U5B6rWU+yD24FkZXiFyA+xtGfLSSWlqf1NxQV33C5R6+3u9xjBe4agGpOi6qVLet1
         WhIKXfH+DdepWUeeVD617fgTFD40kb7XLzm2DdXSHbtdGCteusNFYp5fzyB9DizCLF7J
         yMB+rCe3+10L/jtFIBTvN1s92TXg0Vc+ydnGq0FhoSWuY+eCQ8YMkTdGBDKvFefY8Zzs
         fiqkVtmOdf5Dceat2ofz1iS+bNm+Ss+m03QNc1CyemjfUJ1yZ+GM9Z7Aoi1Ejk8k3lWu
         w4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775577853; x=1776182653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NSsE1e/PZi1yLaZLU1hnoYz7iY5RSS8H6bXaDmUQzYw=;
        b=DLjZEL27NgyXAIUAS5MmRWXQOBAn37Q5fw2GcyOjpMX1wrNzREJoynY2b/zLf/Wgfd
         jTpy423vE38iE0BiJl0CiHdhMEkkufCOFHyYZvXBK6q8DhmVNyS0jd7h3TAFGh7vsNdP
         y+KQRWGmgbQUwkAyaiuv9n4Bh7sU1vgsFg+mWrzFEKKsbiH/Txu7ypzOLOaE1ZqVn1Ko
         1pfRTAWdWkv4l6qi9ZgVTT/W29TM69OOVylzj1769U18yd4uvnuw6Ang7UDvUNbxQanQ
         MLbOAsjoIx3FmDguAv7PZifIom4YVaCjueFhzkjWvW0ejM19vFVjUb4+/bQHvmWCyri3
         qb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/QeHZn07pYa0rJ2Vag4DaZX19HgWJ6iIv6xlmnHYMqzHWcj+BxNVCvpl1iydmnMseFKG8mFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKwaxchH+Yru/WSl2sZtz7BVY1C/6eV7pXPxDR4+M0zc+ng/oi
	otIUQW50l1urd7l2+Evndu0LvK3o9b+8382OVlsG1vMwW/5H3H6hVPNpRF0cNgBEy1q7gA3qE8L
	aRrxJndSdaSQva8U+XwlqWktTXCaBho9xnaaUmIjk
X-Gm-Gg: AeBDievOQY2aAgkWwQg9qZezGx6KdWgRB+hAqR4/0w9032bsUpTtHc0IXpjPxpv7AUY
	bLpNnu4L2yH/5Or8xGItsoeqlPcPeVPbpC9nFg96BekzFPZFNx9sGPWeavWowQuDTV3TKSFcbCh
	4FhWU5ekFSoAWwV4mRfpC4TbhDSV7LugggAtnfmBXzt6Mwbo8uDTr9B2jwWV4EsiPL+Gxo3QBdl
	+vF/hag9ghnBXTuKGFr+mVRtS165RPUkbyOlsjMfLiQ1dGuvBGOYv6Mbpqhh5g+wA9md1LqmwGl
	7pNicrKsVADUwmUHD4AWbPSj28IkNXapAgiKj9w=
X-Received: by 2002:a17:907:1b0e:b0:b96:f329:e66 with SMTP id
 a640c23a62f3a-b9c67a26fc7mr844404066b.51.1775577852342; Tue, 07 Apr 2026
 09:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311054043.1231316-1-kuniyu@google.com> <20260407155827.GA1993342@google.com>
In-Reply-To: <20260407155827.GA1993342@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 7 Apr 2026 09:03:51 -0700
X-Gm-Features: AQROBzA6sVi7ELrBaUXh4gd4681a_tixA6QGGkVr5CTQNSBqTlyyqpNo3H3caw0
Message-ID: <CAAVpQUBnbRSUq7NDj0iEXsyKKbCUsn830iCNMvTpYTa8kNG1Zg@mail.gmail.com>
Subject: Re: [PATCH v3 net] af_unix: Give up GC if MSG_PEEK intervened.
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, netdev@vger.kernel.org, 
	Igor Ushakov <sysroot314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-276069-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 133E43B1895
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 8:58=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> INTENTIONAL TOP POST
>
> I note that this was not sent to Stable, but it should be included please=
.

It's included in 6.19.y, just a matter of time.
https://lore.kernel.org/stable/20260323134508.596880934@linuxfoundation.org=
/

