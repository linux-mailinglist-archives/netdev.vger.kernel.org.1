Return-Path: <netdev+bounces-276697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFyELCms1mmZHAgAu9opvQ
	(envelope-from <netdev+bounces-276697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:27:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CAF3C3052
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 21:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7443300AC9E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 19:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236D63446CA;
	Wed,  8 Apr 2026 19:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTv2/zVa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1162652B0
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775676454; cv=pass; b=RiqIrNCC7V+ySUh91r2z4iG/BktnolZb3di6gR7h1dGK1V5OMGjopnfpjoFQ31Pbj4OXoJ9/6iyBfINwkxlBgR2GeqLAQasNkGNd6QxBVbQQqfdIbG4517XQPnDiGx4X/UNz41Brk5SLMezTJpnhGErws85Zmlt2hi2Rcu61dwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775676454; c=relaxed/simple;
	bh=diYKqQRVMO/pxXNYxnIZ17UIzdpLevcSl+66mh1kS7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivqs9HQpFLsI46vyyrh8NcarZyY7wcPDswTibq5iZLftfChU7jHkrWxovBb+QJ2ecgeHJ3qhblVgFNpjRC12l+v6eofvv0dHtKn7zKlPa7uu8yoW3BTnM3cgQ0KwGTQc7N1MKnD5E06aSNF4wk2IKGK2E7nSKWJrrIVTS5FqDhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTv2/zVa; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7986e0553bdso1162457b3.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 12:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775676452; cv=none;
        d=google.com; s=arc-20240605;
        b=Lnk778mC1CVewMXLIN5sdPmn1gD2Y+FWzeqgMBFhi6pCw7V7J2ePwugYFUcg/2hiHS
         DrfEaqsmDIdS1DdBqeqFxGoGZObijDsuUUX4ckeNHeR7EMSM828J7ns9pMfF3+0yoFUP
         F8jyDW7KhM16O9ARQGNdpRPj74bZltY8ipK3I5qiT9WpmCb1hmZGZDAQb7/ZuGlHlQjK
         yvmcOB0Z+cNPcGKYw68OGBTTLPHCMJEJvf/f3zBxf2Q5xS3cEQbL+GJRQy8VxuUdzZct
         fEqnlBnzdHMQOK9xbSK2rAa7rSjTaQ4iMKjhrfPwbecXr4Dl04YawR8w06PkwbkcRi7q
         A76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=diYKqQRVMO/pxXNYxnIZ17UIzdpLevcSl+66mh1kS7w=;
        fh=NB7QCoAJIIvfpL513a0Hqr7FingF5+qQm3+DL0P/ZMM=;
        b=WwEaI/mHCnG/4uM2/wR8lTsQOB9kmDvZa/2YGxYjzwMt0OS08iiYUh4xgfXQ291e8U
         nEHrg7VKGzgPKqiI3UVamdg5rYD/uo7/vPbv+XkxaWEJVfP0i+EVEN35HEanCv+zoe0t
         HR4rqNkLyhamQf0NYIvBhc5PNFwztuV0Wgo1CYn90GwfYooEDZTtBQHK1L2Yd1W12Ozb
         xiDSYK/c4yxmPq3vJknk4rDp4oW+REkpPN1Wpq/5w/J98IAIczKOAkbmZQaq94quZQvI
         AeZAfXCbFiXOIOlE0pal4e5P8Qu+GK7g0mAQYZcg0Qj5o42RIyR+2jSiJipaOqTZaHwx
         eWrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775676452; x=1776281252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diYKqQRVMO/pxXNYxnIZ17UIzdpLevcSl+66mh1kS7w=;
        b=VTv2/zVaOF8TjUhmBaiNvYY7JB8iPQPvHFocFLK49CG7pO4IsEZlraP8GFy6ThyYnO
         UYcdrmi9CaPyKlqzykC8pljKOoSFaPd1oJp9D8eWraAkQ5ucNFMvALSVOI2O0nCGhBzI
         5vYBCRC485j9J31uUFCzTSzCUhim11xdJdjMmxYvsT4u6HHUTVTYsbd8c6eH7MACxdco
         J+NeF+apsNiZdy8yETVt0aqWawFzDjotQuHg2naT7o1aolIviZj7bKVYbzqQhh9hKRlD
         F+j2jWq5E1B/WtD+KzQLv/FnMyRDXAW2RO1bUtKSA/KGZBGl0X1EmcVuIYFpm8+9qo4h
         NytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775676452; x=1776281252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=diYKqQRVMO/pxXNYxnIZ17UIzdpLevcSl+66mh1kS7w=;
        b=q5LB5QAgFlvxGjWOjjti+EqNBadIEBj02Ssvm0SvzVAzlooXXEVLU7Xpk5AoarpK6q
         OaTpgkhKdmCNxqd+niX4aw+z5T1Gkno69siAkCfBskShcHob0/GTK3R1g2/1rtIGljWV
         e0b1gxG3WO4E1irwXXB5Ee+zLheUftH2r9zDZprVAlGsawgWfR28U8/UKLSwURIBW1Nk
         p9OTUDERJIIB4ayxhC68avWiXObQVunHwTk+IKIwrHwJJs/klvjm0nBN9X2HTbmDSUHL
         lyHfP1n02fiTcGHLreTgOiSDfuzu9nX+Pw8Jn811cydk5d4DfBTKZK/LoBfZKXVnOu7P
         AwKg==
X-Forwarded-Encrypted: i=1; AJvYcCUAHAq4xufOEGdbjEOhCmmoX44D5Gnr+LoG13gZO/m+1Eo9q92x+VLtPp9npQK5Bo2PdRuYMs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqno4dyicXe94Pkf6LvFCQifWN5qu5BTXZ8I18v9q7b7xtgdps
	8tHW4U0lncGmYTdOtUnSSNy+8a3NzSYvsGsRxFkP8W02E96Dq82igorqdie4lWFcDmpn1bZ0edJ
	Pa906sMwaUSaFy+Y8PqPiUFqKwC15slq4vvBgp0lo
X-Gm-Gg: AeBDiesqdWf8fT/pgNI9IicqX9BPJXpMf1mB4BlVaC1ucfrl3JKYN2nL1xctSHvTrrq
	vvXiWushnTCXkyd4HItsGtW0h7ksCiybjkeGu2LX1htYB6zPNyGJuhknTmeSbAO7ITUdvER16+N
	bZE9UP3Jne6Rq+kYB8IA4S6QVjHlYPf2L4KaPq2SPAQ7TW82eRKE00l/9ZSdrkquZxZzwzb3EW6
	fFBjcqfcPNR9z7kCt3orS2nbNHwKrvlCVy8siRobNBFP7ry6sdmwEmck1cK5ZTrhn5/PwqiwOig
	T+DASYg=
X-Received: by 2002:a05:690c:38a:b0:79a:d32f:e4e5 with SMTP id
 00721157ae682-7a4d5d5c544mr236509607b3.45.1775676451370; Wed, 08 Apr 2026
 12:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408001438.129165-1-kuba@kernel.org>
In-Reply-To: <20260408001438.129165-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Apr 2026 12:27:19 -0700
X-Gm-Features: AQROBzC-31eTya1OGbaBhlsGtvDTRV4IQliyr8YFym9aUCdG16L4H9t1zLUmY9A
Message-ID: <CANn89iKsc6-4=dQJUKu=-tC9P=B4LM2vVhxfg1Kf9aO0DUpaCg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: update window_clamp when SO_RCVBUF is set
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ncardwell@google.com, 
	kuniyu@google.com, willemb@google.com, dsahern@kernel.org, 
	quic_subashab@quicinc.com, quic_stranche@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276697-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 59CAF3C3052
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Commit under Fixes moved recomputing the window clamp to
> tcp_measure_rcv_mss() (when scaling_ratio changes).
> I suspect it missed the fact that we don't recompute the clamp
> when rcvbuf is set. Until scaling_ratio changes we are
> stuck with the old window clamp which may be based on
> the small initial buffer. scaling_ratio may never change.
>
> Inspired by Eric's recent commit d1361840f8c5 ("tcp: fix
> SO_RCVLOWAT and RCVBUF autotuning") plumb the user action
> thru to TCP and have it update the clamp.
>
> A smaller fix would be to just have tcp_rcvbuf_grow()
> adjust the clamp even if SOCK_RCVBUF_LOCK is set.
> But IIUC this is what we were trying to get away from
> in the first place.
>
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumaze@google.com>

