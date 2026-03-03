Return-Path: <netdev+bounces-263389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGxjDyA7p2mofwAAu9opvQ
	(envelope-from <netdev+bounces-263389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:48:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFD61F6563
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 20:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DA2F3091975
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4010C37C93F;
	Tue,  3 Mar 2026 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2q98RnC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286238425D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567237; cv=pass; b=GRbnRGq6yr/1y2zPBACahuYV0C30vsStfxw5et2KVPWpau7uhgd1F9ANgsg7r0/A4x46GAY7oZJi0WsLDKZ6+66XomjYKvkpTXm5FzSinNMisJnw9uLSBXbGFipsS37Aj9Az2DzJY14SD8FTE9TBl/sszYqjI0hN0LizDkVGODg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567237; c=relaxed/simple;
	bh=Jn4BkoGG/ISnyVKV1IlLJJ3GEoq5Y5Kup478jP43ero=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrcRPwXKLDqqqxAqfRp+VPgSq4rezcWbuLXMvEXhQgqyk7CoGa6HBuIVq0AnNHSmTw5EQJaSE/qAqnYYgRd/o6PnOD60K5sZVgzuYx1HoLCLJVqTR0BB6dBdskHbSHw5k3zFD6aB2HCH4a9QtvyMQ9HSwVkw3O5KnxlKxyUqTmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2q98RnC; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12758ce1e8dso2800283c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 11:47:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772567234; cv=none;
        d=google.com; s=arc-20240605;
        b=GODk3Kz9wIM6cwggbcAIv7cjstFGYyHv3K2uUCQwxIra64HoKdaAR+u+0DAx5y+ORn
         lSc+hO0gcTodEbRv4BBFNF7qP41a5kTRvjVYMvn+sx4dWQCpxwDJTVmtVg3z46MPmL84
         vXwXF9WZ9W1005fs2t/yULVNLriiWpFM5qUyoA6HyLW2BYIvPAJ2hS+AVu9bN/5Bz7tN
         4TivcN3xW/XsGFh56rJDbxxhKm3iNE3c5OIIlwoNz9XTN8520ljqn3fbuDzMjiQ5bsec
         KS8my1J3R7HWLYy3GNJUCbMXWRJPobe73pEaFmLwOt3XP+nb8/VFcz/mdHHztmij2WvC
         KC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jn4BkoGG/ISnyVKV1IlLJJ3GEoq5Y5Kup478jP43ero=;
        fh=pVsGZ5CZ27HkcCO8dgxpEiJT1Qq7QzNcYYz60bGrG3w=;
        b=C1fyfnHSiMozy4cC7rb71HdYyNpqF5k9Kt5X0MvLf7ziSW/+Bv9euQxD8S11W8g2hG
         sxq9J7VYr2h0APpoVSNByesSkt1SM1ubM6Bg0Hlu9FmbZCapRObAHa9SlwNK5OOoz7X0
         1Ce0Q64yex78D/oFY7P/c5uIhQGg2de5H58ZdR7vKopWCW9I04gdFNxixPWytDeWoRLG
         Th317GZCsmYMAzqjn2acbJwh/aqGEm+GwgGjgFLfRiroteP3wIStjS0NEC6IraL+Wxow
         Fo4eLVm3MccjiLEfN/+p9U/CEGwqUoakS51X1O7f1NjC71lgx9Lt9V9mEmiI4zYOgDDH
         lk1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772567234; x=1773172034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jn4BkoGG/ISnyVKV1IlLJJ3GEoq5Y5Kup478jP43ero=;
        b=d2q98RnCE2hQ7ux9t/sguK7i+jFwY0QTEe8owy7+9qf0Q8JkCKbMkyJCSg4IFM7Xm9
         U5iSjXOLwSqo68N2LBIWyT0JXiHa9X+6qLK8f4GrrrSzgflk+j9ROUea1fIJ1R8mjB3M
         0KmnpxOxt+Hk6DP+t9uG8dnGqPCnLDJChN+X5/RWcXQCroHtQJkmjhVpTxOgUvQg41Pi
         Mv8M6iFiwlffl8VYpBfLtxFdwUTOiZg2/11Aa2uktTXSvcUQO4P0d6XAAKGaKzsCWHY/
         TFQFgdiiLugez1YHk+vS9r3BNlRAfYKgqSXFDyp2ky5ombMzOUs55t4aOF6UVX+kzwJF
         wXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567234; x=1773172034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jn4BkoGG/ISnyVKV1IlLJJ3GEoq5Y5Kup478jP43ero=;
        b=Qn2U81Hcy9nXzqD3IidOD3q5S7mjBrWCvOPNj4F4HLqiX/YGvcTkPVBRU85v/LKFgU
         neLOxoqY4rDGBOqqhZudZbXXE38FPLKOHmXLI0LSkEA2r/OejGVKLquZJ6UYuwZLUvM0
         c+ZNRKF/66GRV2vKDsB/9CBK16PlvENh9QaWKoKwKGS04Wrmd6V0AhF9OYeCAhWZhSMj
         sVP5gZK2i88BbtmAMlvYS7yzOc2QzgnqwGOlq/bfhfVb56O9AE0vOKbdBScA7tz8AEgM
         /DtDIaAzwWqY9seNZV14bJuDhUW2tmX1pb3ZFDGiphbBdlPH5sXsEdCZRbSLALWjvkuK
         u9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWZD0L10uzGBf7HJUwCa/8OCBlJegWP3OV7nYpVT5WBZoNFk1PsRDUYK9dSMhe1EyQ+ZI5ezNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDp8Un1rJ1bntAdf8BZrcWCXc0A90OB7a33Rs7oDsrUuFePUJ
	GzcFmP2J8nPNJisYUCTvLFTwdTLw6BP4iWHoVw3BC4uXspCtc/AR5IWiXBrNK4bRIX9oUje16Du
	i7OmTZLNuIRShVu989lrEGH0qTPn3xEkts0PQc2i3aCbfrgNy/dVHEYYG
X-Gm-Gg: ATEYQzxwpxoniamtr/d8C8lF0PEPp4lLOPTWaF//omAtgI/jquBtFVz5rqoB06DzV9T
	8+wQcmaqBDNbqHYd7LhmWRSPB0U63OA4p/r6je5GSDMQUFzYlFEUvfH4Q67HwZ9fzxZXuLY+RTC
	6+4zKYG7epX8kBFMOnmnvu1AQ1ejuuEZYpASrv3IqrOkzoFwYcvUHhUpxeiBNIdfDNLLyZ70qtW
	lSNjFAXmrT8PmW6O2lHOH1Hjsxl4utDEAaobO7zIF4seB2v5igvjEll0VxMSWP3cUXipmRuFv10
	kWVF+SQ2Wvjy0vOPYFYrcQC6JeLOyVWoQOkr1Oiv/f9cL6uTekoB6MEJ2RreHyRj521i6Q==
X-Received: by 2002:a05:7022:6ba3:b0:123:2d38:929a with SMTP id
 a92af1059eb24-1278fd70f96mr7160291c88.38.1772567233017; Tue, 03 Mar 2026
 11:47:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com> <20260302181432.1836150-2-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 11:47:02 -0800
X-Gm-Features: AaiRm50xuDpVXOAEcM8bARn5_4q1IPKqX0GOixX-QmvvSDgubim02rrmPRDL868
Message-ID: <CAAVpQUCUkeA2z+VFy__xqwwGqOUsid+s61kcmJpUMQSemWBz1Q@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/7] net: add rps_tag_ptr type and helpers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AFFD61F6563
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263389-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Add a new rps_tag_ptr type to encode a pointer and a size
> to a power-of-two table.
>
> Three helpers are added converting an rps_tag_ptr to:
>
> 1) A log of the size.
>
> 2) A mask : (size - 1).
>
> 3) A pointer to the array.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

