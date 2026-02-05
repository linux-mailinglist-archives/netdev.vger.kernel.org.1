Return-Path: <netdev+bounces-257044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EZFN6xThGkx2gMAu9opvQ
	(envelope-from <netdev+bounces-257044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:24:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6E4EFDB7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08EB53019478
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69B362135;
	Thu,  5 Feb 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfS3vu51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EE35C182
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279845; cv=pass; b=fI8LjYO/uFvLMTcH2F7UaoopqFGa7KdG7HYDmZiVAC7dqOO3eOAc2weNILmAZaAaf5qC7sRl4x72FmsnfXymqer+4vctfG85Tf4IA9FwnRmpUJpJZvgXdB4G7JzV14UNTDN71rdPlsvT5SlalYKwKnHrS5ozLlCmhIvSbqUptNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279845; c=relaxed/simple;
	bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXaK0g0P/jDHNsRW8gI0ViHbD6LPtbiCkajasUaEySwHs+r/U+PtaNaYclFCefK1SkRYZxdT87GRtQCVKrDAYGlCtonkru9Gbl6oZkG08I0rkfNWicNdIthT9Bh49qFo9ze2y6OV9i+LsPsoTgakndPUk/lMrRkyoz5+avdXB0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfS3vu51; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88ffcb14e11so10095676d6.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 00:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770279844; cv=none;
        d=google.com; s=arc-20240605;
        b=YbVb+KSdut8JEsdZREzull0kjtwTdthNAIIdYDk2PQtCt1TjjYFDprAd806lJB+YlX
         swu3fdWz0efo8dcHqmDzE/j70IZAyzQXMiNnTNBLAQvLbQcJv6c4ah2a0Xxekh31G9su
         BbnZoEsHi0P3KvL7CHxPoR3QixRlliov0j28qbnJuDzNFFhY+RxOvWJtQdMzQl0jPKpw
         /VqfbYuI3viefxcb/qOEZ7G00NoHkN6P3MZ9ttoO74rA8aegVSZj9RfDCxzBIooanB5z
         yPtOrU/jnag2zvGlWnRfacmHB7wpB1TS6aJtFAmGnzNzXmXo6Ur/e/VFnJzUvS2+t07m
         RYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        fh=qrk653256pMCtnl2j5MfwP65gwSTVXq7z5dWqsqqf8A=;
        b=YWk3MWx3vbpeWT9OrH4ofGSEn260XY+qWJ1neaMkt9g9I0T1xv4Z7iFDTn7JeLGRUz
         1rl03cFw3T1wVpCemwGwV73cgVqPL+n9TROBtiayXYgqp3sls1vGLPVXGL22FIGz9ajl
         3GmXsAz0b5FqYFxM1HKjW4+Jk07B+8PFoF0xcYqxGrVt0lsCH1TnDIC/azSc+TFMPOIv
         8Ufj/HpaWhEA7B84/MEUOhWhfGgH99f+mUpraNyu2Jx4vVBhXnhadFucuzuwjZ/pYul0
         ozCC2cVPzP4WTCGu2O3jMim8z52GZmbd1BwecQPPBK8/KNSxN9k/z7wFjNx4BRpbdPom
         i2Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770279844; x=1770884644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        b=kfS3vu51fW2wed09gbRGs5gmsjV0kZ/+69FnEXKeFlgRwraur+QkPD/f89jEyt8T+I
         YeN0sCBXopttTJWC0VUp6B81ItdQd96eSjDLsCkWnsccVYf4qmsodCzIAfB7/0hAZreT
         hsfwhpmdYr3kE5Gmc8A4GbJlkNGkVtxJ0yXgvOwqZKsaNSzEIu1e/R+BrL12ukW4iCM0
         ysa+Utqh4NYgBFOUAFE1bfGPhl5OY2EfCt2LmvuvtiZP+EY+s3hDMEdH+NfqeMRJOoq2
         vt8SpbDIImmE+XVRpF7QyS09cCeE/JYGng+5pFdZS5nN7AfhSFhld/tEx5F+Z8IBSWg/
         NNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279844; x=1770884644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        b=v3W6Nx5Yi3waAZewf02uFgCGb/uF8cWYwQfR7c5fmKH2jTiLCxkDnLmrV5yZ0dqWHi
         sq14RZZtJfVUJXRI1q9KZdhy8KPFYS3FM6vG4UfW5YzPKO3KUfNHapM+Jm+vwx+dfVoN
         ffwKNegx0NbhXUjAw3gnMm1b/9O+l2LDpeYzXt2R08rU49loLkur0I3RTTmPXoazy69c
         ldMJA/rrCAnF7KihZ8rJWdIQ/0LA/2rVVMSuBH3ldFwa5CnAYWd1vqtmpWuiU9G4/XX/
         jU4InzptSFeYquZRAoShnJ7WluK2UMtjakGLAV2cFjaigPVRgNc8dyXHvXOooVIk3us1
         qclg==
X-Gm-Message-State: AOJu0YypGIMpoBrGzgS4afFgLndgXNYHV+okbwXcz1zD1+XB+aOd+A07
	d+uO1/OeKbAlT+ToYD+RV4gzAU49kpaODyKH2XqO09SMG1Gd7PH3sAUYi9Z8nW8GpRX/YIcfKFR
	YBrrZIrwkPKBWZPjBT8cwj8AhY0HnMbU=
X-Gm-Gg: AZuq6aIcIXt3NdExmqnQIryhPHLlsHCxf5wK8Az3TfqoZMD5v+l62mDi2rK1E+wvL5Z
	mr662sbjhn3XTgWCYhWqhbF1eZ4K/hNTkoH5X27vF75giH4YxnqbDyzk5xY7Qk/6ijDJFjqLL40
	sKpQxh5YMs4u2a3eYQc+CqfIEYsQSjFBSqdmyyIG5Qu7Ak1L8OPp2y0BMCX8Pmh8u8o0+565S3d
	Cbsw7oLbOTHeDP9/cxk2cRX1lQSuMOF3Zz+DM/oq4RBTnRxa9L6FQNrXaVEXxIg9ou5RD3cLDCx
	Aj2NaeLNM5n36oxL4wP735MV0IWoo4dSyPWmJAerruNCGecrksA6JuY5slL8R25avr4=
X-Received: by 2002:ad4:5743:0:b0:888:883d:ee7c with SMTP id
 6a1803df08f44-895221c64cemr74556836d6.58.1770279844313; Thu, 05 Feb 2026
 00:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205075445.43347-1-enelsonmoore@gmail.com> <b7a1e57d6bfde3ea5c9204323341a74325a63ab8.camel@sipsolutions.net>
In-Reply-To: <b7a1e57d6bfde3ea5c9204323341a74325a63ab8.camel@sipsolutions.net>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 00:23:53 -0800
X-Gm-Features: AZwV_QjDshPtNQhbiRoSQ7v_pb5laGun2CBxH2EoHYYJ--lOze85oiN7TE9ObVQ
Message-ID: <CADkSEUiQAZidhX-CJAiTCm3c8PQNM-uenc7ExGg7d2KUVTXyBg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>, Alice Michael <alice.michael@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257044-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D6E4EFDB7
X-Rspamd-Action: no action

Hi, Johannes,

On Thu, Feb 5, 2026 at 12:13=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> Right, good solution. How did you figure out that ipw2200 uses OTHER?
> I'd thought about this but was afraid it'd also just use ETHERNET.
I used linux-hardware.org, which is a database of user-contributed
hardware probes. It didn't have any entries for this particular device
ID (which implies the devices affected are rare in the wild and might
explain why no one noticed this before), but I looked at other ipw2200
and i40e IDs - it shows the class code if you click on the individual
probe ID.

> (FWIW, I've found the database internally, but not who maintains it nor
> any historic information in it ... still digging I guess, if only to
> avoid this happening again in the future)
Thanks for looking into this. Have a nice day.

Ethan

