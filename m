Return-Path: <netdev+bounces-276238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vBM6Aq631WnX9AcAu9opvQ
	(envelope-from <netdev+bounces-276238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:04:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 735D83B62AC
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 04:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53BCF300D617
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 02:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AF235F8C5;
	Wed,  8 Apr 2026 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP85GgOP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/f2ube5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7C2E92B3
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 02:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613867; cv=pass; b=L9TaMVnPpqSpPc+GvIwcFT+76gXJ0shuJw6yW10SvTlCvgh4fOaFLusKxKL3TiPwEdGW4F2xKbnAuYYUWPwjNq7tnesc/ySIG7y7O5baqmgX77UV8lm/ZzroI4d7bpH3tohgK/+zrJ4AOOt+xdPznxUP1+h3ZifDj3owizz6ruU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613867; c=relaxed/simple;
	bh=C/nH5xGBHPXlvcMK8oAxKI1Ca7DE4QzZZWiUPli9i/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Edo2q5SY1fnq8bdHTpu1Wts+s9PIPdY0RHgk36JrglWynCz0oj+IQ+3v/FOU/C2QUKL2Z75z0mwXnzktmWNrMok+NXwUK5fCpKyDZE60M5il5sDvlXQjgSTm9/gxiuoeba5Mt4VIpSUzZGlDXoh9H3/9bmX3PzFxWXl09PRoZKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP85GgOP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/f2ube5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775613864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEnDILMDGbUUU+7uZ7TGCOrAievRQNNxQ9U5GPXCRb0=;
	b=iP85GgOPrcPjT9kYOLhtW9C+KEKENCjQYe9TYqAGnAwR4CrAs2YlJga05zC5Q9UwdRtCoR
	FaSkn8YVASMzvJ9PSPRPczas/taxJOL8u4Rb3FZAyX8+IEJ9YKW5LrMHLyPVI46g8MPg2K
	wU4YzHHzTyNzQR7dsH7hvYPtSmN3uzk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-pu7bE27RMxOYl-HRvZn2Pg-1; Tue, 07 Apr 2026 22:04:23 -0400
X-MC-Unique: pu7bE27RMxOYl-HRvZn2Pg-1
X-Mimecast-MFC-AGG-ID: pu7bE27RMxOYl-HRvZn2Pg_1775613862
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-66f1e24535eso2397624a12.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 19:04:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775613862; cv=none;
        d=google.com; s=arc-20240605;
        b=FV1diVDX3YOIys/aJxNDgtu9stODeOtM0Uck5EYSzuilJoVof3wCY1RlS761vzPNlr
         yEu6z6CE6LB1tVuvEbdxLdhZu6VZgo5fiZcIU7tX+0KVMzSdFlVFiNvMNof3Vi1UONXf
         5Im3vom/j1EDBmNh+l4Hty2LUgTiuqSm5bBpxVGGPcp+JzR8WJNWd+qUpTMkiBt1lviR
         bv8rzJlUEBLPy013dwjvQhOrSWms1nSkHEasr1/haIXyzcBAk25xyBlrtUWAShxLyJYu
         Hi073RWHPDzzYuyhBD6byitY6QG1/X+0L0caRM4hhl60mjQGPJ1vi+FcLmTZQCR4PJmJ
         o/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SEnDILMDGbUUU+7uZ7TGCOrAievRQNNxQ9U5GPXCRb0=;
        fh=ZrlJi6U+L49N0n//uCxAUKZu4rfotPuzTJfXdzQXfKQ=;
        b=Ri4oyc7l3lnR85HNEroJJrML7aKGMUdmuYE/ilsmZCRPW+XVIX92BZqdLv/0kMD7mM
         2qTwcy2ttaDyIyxjQMi+tCS3isYjBOlZB1iJjVj2mdNM3y/DBVFXf3XfRlqMVdIy3g8+
         r0b7NfQ/DcGOhsHWjaET4pRBotrI+sEyGqgWXcNcWRHsgI7Io5U17i+M5A2EYtxVdU/D
         cp+rcIi6EcZKxsmTtgLDKRRt1YmzESH7EXAicX3pMmhfQOM0jehs86hv4QKu/imtb+fq
         7p90TMTLPy5SM/BkXP0l0aBzESib0WJ5ZvqAdf2DiQdzvt8tHJunyfxVHmyDhUBLlVUu
         4AoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775613862; x=1776218662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEnDILMDGbUUU+7uZ7TGCOrAievRQNNxQ9U5GPXCRb0=;
        b=U/f2ube5iZKo1XRuVjTlN3IsNKz5P3SsMAscTrBJ8JrxqfyVHusNpqgSCLjdG/E4OO
         idum+6SIKEdF6WHvOqS/ALR7CUkTDfAf3Tk0ghkNGHpwyZ9fWonajSwALyFzKvPexonT
         1lNnNzIEXtUhLadjJY6I6pWFpONSAJlS79lBdOp/77lvNduhXUK+pztDUuVqZ1UOgNI4
         SnSA6KpykBVm+5CsynBaru7C4KWiAcVCGYkCuwGWmTx7ul0rObN42zf3l7GwCQeDcMRe
         nzU69xjGXVX7VAyfhzr3PlOSCt+AmB2LB10eK5htJsoARGydZ2+1LdTwyJFzwGwP0hob
         OKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775613862; x=1776218662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SEnDILMDGbUUU+7uZ7TGCOrAievRQNNxQ9U5GPXCRb0=;
        b=LsdRJyk/VQh3DyQXq8Vd8THRgF34jxZJU1eK7iFjbOVNJI1Z35TnkqAi7kWKhf1D/m
         XZjZgzRey6AjPOJahb1y+2zpdHxAK67HIdp1VJ4OSPMpSnn/1UvlN26ELGS51OQ7+q4n
         D/Ei7lvmuGcCbXaxj/LfweRPJ/XjXkQQpw6RBGxUhU6/itMCMsGjlFZwurJ6wpPoypdi
         1YtBTfCeyRALPV9eqwo/zh8axoMv2Vhy+rDWKaIzs838FgfrCcXeA2rWsHqIHVH0VQNQ
         UNLhaulzrUcr2W2of2LDgDxNKc7Pd8Un7gQHGvr2//j2BtWRh78FNyalqXNSk63QnEyZ
         H+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/AGgN+lwH8tyr5qBahpQVFkxO3TQxmOHDgXjbTpMu0lThINrCgbcwuHyxkDtuh0BV3B3uGyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaL3RkYzhEFNjDbigrwKqhYgGWUg6JctC4I/2hi4ZdIrl5qGUV
	V+tAg/AM/EzlCdQr5duYidUXs73JVTYdRrdFnDYVDbT2zZKXoeKOi9vYngUenuJucDooLVZbzkt
	e/7vozW8knckCI4TSAe1an0oiRB4M2WS4YHLOnKjM07JwKw9YAkL18WCatP56V61NHgFXrD46dF
	naKf8m+Ai/cjr1VkLrW4Tlz18XRmibh/S5
X-Gm-Gg: AeBDiesEG9okacHsBVySt1aAVOfad0TDbiR5kQruMfo9+VNnzyX/gSyb9zRMjvftd+I
	HoDJey9R0AqjjY6FFg45kC4zVC1HQ/kWZp2zO9sjRm12AGqUEdXu3ivwInkM66F51iu/hW0RdaN
	dp8jh34H7R+exUZN4zVjuyofakScncQUjUSWe6q43zMEvJsiAnFXiY6X4mweDMnInIYhpidt1v0
	xAW6tw=
X-Received: by 2002:a05:6402:21d3:b0:66d:d09e:8607 with SMTP id 4fb4d7f45d1cf-66e3f978c33mr6914678a12.25.1775613862002;
        Tue, 07 Apr 2026 19:04:22 -0700 (PDT)
X-Received: by 2002:a05:6402:21d3:b0:66d:d09e:8607 with SMTP id
 4fb4d7f45d1cf-66e3f978c33mr6914671a12.25.1775613861573; Tue, 07 Apr 2026
 19:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775527362.git.xudu@redhat.com> <b65f95793e03c1cb3ed3af4e1b2bee89fcf7e648.1775527362.git.xudu@redhat.com>
 <20260407080844.35368eaa@kernel.org>
In-Reply-To: <20260407080844.35368eaa@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Wed, 8 Apr 2026 10:04:09 +0800
X-Gm-Features: AQROBzDB-Jxdan5EmdzQR_M8yVv2BXt57Hgyxa7625vJBiUYisaDh8aNi4Xkjxo
Message-ID: <CAA92KxmXOpH=CUqEdVV2948XhU1oFh8PBYLUt=ktSsK3sOh40g@mail.gmail.com>
Subject: Re: [RFC net-next 2/4] selftests: drv-net: tso: add helpers for
 double tunneling GSO
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276238-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xudu@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 735D83B62AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 11:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  7 Apr 2026 10:45:09 +0800 Xu Du wrote:
> > As the YNL Python module cannot be invoked across different devices or
> > environments directly in its current form, the helper abstracts the
> > YNL CLI calls to ensure proper configuration of the tunneling device
> > features.
>
> Can you explain more? Why can't you use class RtnlFamily?
>

Hi Jakub,
I want to test the gro-hint parameter functionality of the GENEVE tunnel,
so I intend to use YNL for the testing. I am conducting the test between
two machines using SSH type. I want to add the gro-hint parameter on
both the local and remote nodes; however, I am unable to invoke class
RtnlFamily on the remote node via SSH.

--=20

Regards,

Xu


