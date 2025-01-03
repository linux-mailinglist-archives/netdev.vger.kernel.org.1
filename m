Return-Path: <netdev+bounces-154930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA9A00638
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FA21655F5
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA481CEAC2;
	Fri,  3 Jan 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gd4TG893"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AA1CF5CE
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735894006; cv=none; b=X0Xq1QOMzX+mQVkkYmKW6F+DjqVah3CwiC0SvHKhDzqDyAVIW/4KEtml22QIjqvZHFCNcr1Ys1DjXHhxHqLoI0TuWZlKK9z7Ksp3hWb+5BfwhW/PGhKYYgRSX9e8gEfC/BHglsCQDXljuEgn0jkBqF4N6pkUIUHfxXMY8r39j14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735894006; c=relaxed/simple;
	bh=wAIoLAaPwOYJhKZ3LNgFEfr3P8Rygv3yT+TxtpPxb54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+PeCFYKZQeJCeJr+zkHbhOaM2Kp0cI9ik+iadnb3u+RntWWZmfAnr84/dr7/w/04p1WqB5IM/Fyk+t5FT1Z+SCd7ZN5DamAKi6tdaBT3PJlAmiRw0OAiCupBo97//xwiNlWJnOGSZ1ol0eg0cGvQYfJvPq4r3s7YAyNVeZ0a/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gd4TG893; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so24118297a12.0
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735894002; x=1736498802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAIoLAaPwOYJhKZ3LNgFEfr3P8Rygv3yT+TxtpPxb54=;
        b=Gd4TG893r/XTgGEKASBi2IoFFmBf1talER+kSgwvwRrWxGlHURnrjX38M+8citZQ7A
         iYyiYwL2JeiJQi31yvgwEjxgFX9LeaWsoKdn+R6TdRhy1aKaOY8wEmaRIAfPORAiwf1E
         uDtKUDNlMFXy+CnOV5gCr9nuJ86cJPYpeOthahLnTLeTL7MK9qfcT2VP1zkJatxKuBnP
         k7TjjuXFH/X0GtooA6EaJP2AoUNfyAH5a3eyouISDi3XtGclDEwNHiNa7VrbjwdTgM+k
         9FLeGpLbkBHAQpYyqyBCczVGAz4yWyxP7joF65K3OJ23qA1eu6CPWGTERjxGpSJBqBBo
         P0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735894002; x=1736498802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAIoLAaPwOYJhKZ3LNgFEfr3P8Rygv3yT+TxtpPxb54=;
        b=OBlwV02FjEv42l279/MLDQr0jcVPAvLM7lqjntcORuUfxb1veXESsjnXRbJyGDoECn
         fy3FcTGlJaIUSfncevo7jwEIdCEI9qG/ZLImFKeC3sByZlkXT3flvqBCsYQKiMibQ9Dr
         7nUir/Mp8+zGDFklL1Sa83d5dSGjIgKd8TrNOoVwcCeADYFfeYya12/WlS0BZSTyllvS
         wMIN1+nolYvtOmuHRnq45Bdbx9Dn9yaXR8+bTOiEr/DcpEKiI0X9hFupm5qrAffMBerY
         DaqzlwARrbrPPYu8VC134E68RanGxZL+bCxIsovRp5wVN0l1Ysnc5CxSfrhSJ9IZbs/U
         Mz4w==
X-Gm-Message-State: AOJu0YwX+0l3T8h10C5QnCEQ2hQv6Q17gF5459Z6q6MTDpIxkM1b1z1o
	uqZMy5Cjysi5OeQlbT7nN8NkRHzIzZEpncu1PZf+sDOJdT46O+Ksh6PP+/RzJt4fReKdW0MpRdS
	LcL8oA8P/AkijcfVzcQN/uCI4s/mpwCfXTXx1iM/ckYgqmM8GbQ==
X-Gm-Gg: ASbGncvmglFgruZTuTdYB1A5CHRan1P2wsMx7JpBgcpZP4Y0VKzgvyPhkUZCGYIH27F
	biFaPFvCNoSTP4CtPm3zBBe1wbMN2u7CzVI7Le8c=
X-Google-Smtp-Source: AGHT+IH20iXprnDlPBN/JWJkLpD8TwPTjL2HD9u6EezVSQTf+Sr4upnbShSK5nMkeNStIwlpfRK7Tku/27eCM/9PIz4=
X-Received: by 2002:a05:6402:1ed1:b0:5d0:d208:4cad with SMTP id
 4fb4d7f45d1cf-5d81e522ff5mr39309199a12.2.1735894002342; Fri, 03 Jan 2025
 00:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iKkrZySKRidPLFa=KsM6h6OeO2rgW6t5WNY9OWfJazu8g@mail.gmail.com>
 <20250103012303.746521-1-antonio.pastor@gmail.com>
In-Reply-To: <20250103012303.746521-1-antonio.pastor@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Jan 2025 09:46:31 +0100
Message-ID: <CANn89iLee8pOaeyEVZWW3O1vzQqp__F4G8jeGZsqbmPTK6qgPQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: 802: LLC+SNAP OID:PID lookup on start of skb data
To: Antonio Pastor <antonio.pastor@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 2:23=E2=80=AFAM Antonio Pastor <antonio.pastor@gmail=
.com> wrote:
>
> 802.2+LLC+SNAP frames received by napi_complete_done() with GRO and DSA
> have skb->transport_header set two bytes short, or pointing 2 bytes
> before network_header & skb->data. This was an issue as snap_rcv()
> expected offset to point to SNAP header (OID:PID), causing packet to
> be dropped.
>
> A fix at llc_fixup_skb() (a024e377efed) resets transport_header for any
> LLC consumers that may care about it, and stops SNAP packets from being
> dropped, but doesn't fix the problem which is that LLC and SNAP should
> not use transport_header offset.
>
> Ths patch eliminates the use of transport_header offset for SNAP lookup
> of OID:PID so that SNAP does not rely on the offset at all.
> The offset is reset after pull for any SNAP packet consumers that may
> (but shouldn't) use it.
>
> Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

