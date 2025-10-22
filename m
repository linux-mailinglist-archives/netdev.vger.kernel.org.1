Return-Path: <netdev+bounces-231501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5176BBF9AA2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9ED718C7457
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843511FDA89;
	Wed, 22 Oct 2025 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D30rzg4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B719B207A22
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098400; cv=none; b=O7SO+PrTPpAO0wwddz9wedNsTYtEzylSjdTVhT7LCTuuKvFYvW7lbASeQFxhFc6NT3at08CHRuFMwKTI6S0/JpCn3OhPjaooCma39w597L3i8S94QS/uY/1/CL72PkHemUgQOLoPo4uOdmTZ3m4DAJgioFyyWjzp7yv0BKjCTnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098400; c=relaxed/simple;
	bh=5NZ/uwCLt0VNO4WYqUWC0qw+IZkeYyGK4xWzqulWnlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK+oEaVI12tJVJaC66N/2trau+dnP/9PkhD24u28MBdFKPOjDsOHjjZZHtUwUIxHxPmMVVxGMqfAUXEpxB9NqhGYVpQ0jR0LRB4vx6H9qJO+T/roVtPhD2UiV9jHwvOr4f4eA3+WjM0yl8f61YRihwRrpS4vOegymDv0IOFJ37o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D30rzg4B; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-651ccdf5d0eso2305875eaf.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761098398; x=1761703198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itlcylOjUlFQ7e7v7Jwjp9QD7ltoHFOTPV1Tx8JmjOw=;
        b=D30rzg4BpFfminR+1UhuPXjfI00IfZclm1HRmvWLsT6Eqmai2pTMtCjnwTO4zaH7Et
         xQ+RilVriMi+3dzYjk8uooYclT/VLzoYMW+WFUhJNR5f/HHej5SPH65C1pUm5GzAByDY
         FQYlwNDnv0uz7WdwT7zvZY5oSkoamAXl2dE95Af5gTYgKyFD/onOz/GnLKQvPsY7eJwB
         UnOBesONA8CamMiBlXVHh73Os0q1D9LxkfJvX1OxjhPt37EUZCYRbwKaDS/Gru6ecZ8B
         tmLyRTBpxSHNAc8jN3H0aAgctA3lDq5yzktN3Y631s5zsU+nMtIVN2M3/V7YgT4IBApv
         E7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098398; x=1761703198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itlcylOjUlFQ7e7v7Jwjp9QD7ltoHFOTPV1Tx8JmjOw=;
        b=XyL7m8I8YnAxqs+EkzcnlIkVH45neQlAOwv/YdE/PkDnBB4tUQNSCEfFD3W7Y+0TGl
         +o50svazxAzXTb+xK5fDzf2vDQWnCRm1Qf4/hMyIOUsGvI25cnG3oV1fg3gCruybFaxv
         BewKJfRRl+ISnGlNFVIazEYn0IZSCeoKj6XN3EGTOZKlNzFcBE3lJriOnX+B9bxwT1ya
         n/KHetOZzi+wkVkqcGU6TvZRSpS0owC9EdBcHEpRzV5fFmUh9R63Z0EPuYeHI0Hf0AGq
         W75UixzqPjhASK1M2Ene4a3+5pKrLlpkmTbLkLMKJmtp3JAlho9TFFlpmSiFxe0jh7gy
         ux4A==
X-Gm-Message-State: AOJu0YysHMELinfSIRVEthE9ERiOMylEshw4IgiwGdOX92UtRD8Eb47R
	flJDpmuZfzaeM8KzOA7jKXgIQyKtsHD3E/9YDF1N5B+m32b8zGyaOm7/P3TrIvz5HgnR0h8cqaX
	lY40pqA+sE8ugly7mlWct1P83kKVaH3jki5IyrVs8FA==
X-Gm-Gg: ASbGnctwUVTZ+dU+W1pdIERANveuX8ISoM0QGClHUu7j46Treyy6qBORCDtvD3fc1en
	WPfmLuNj3oYjnD+Hap2vIpQmqA0lYSqkdBKoJZlQ0/ad6Dtf/R0XNQ70SvHdfGzmF0td4uXAwyx
	fdcMfxLcNoFYbkrRHM1EYUpOcIPJRyQ2UDlr79UhtaFGuWltvleVIUc+xPJhOQxgyyj6k55+vT1
	H77b2sZ4mZxBB+qOBwZ2q2/GNyNk4aSYVGe8Aub1en3DNq9kGm0jZgRdWK1XWrVpR0Oiqcd
X-Google-Smtp-Source: AGHT+IH7Iyyc+EK5zuywXylMwtZFeGfz8UnjWGkA10hggDWsNxG6gjx9eS2GaSvdDm3FaAky0lEoxpeVC3neBHW3R38=
X-Received: by 2002:a4a:e913:0:b0:651:d041:d167 with SMTP id
 006d021491bc7-651d041d26amr6455630eaf.1.1761098397649; Tue, 21 Oct 2025
 18:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021135913.5253-1-alessandro.d@gmail.com> <CAL+tcoDqq6iCbFEgezXf69a0inV+cR3S5AVEPi0o18O-eJNHXA@mail.gmail.com>
In-Reply-To: <CAL+tcoDqq6iCbFEgezXf69a0inV+cR3S5AVEPi0o18O-eJNHXA@mail.gmail.com>
From: Alessandro Decina <alessandro.d@gmail.com>
Date: Wed, 22 Oct 2025 08:59:46 +0700
X-Gm-Features: AS18NWAgRIgPU1OYzFmjZrbavI2Y1-V2cWC6PblacvnxZ-hxBg9m50s6oHQ2npQ
Message-ID: <CANp2VBUo_8dXjjFLmgyP=Wtz65-F_BQ05Bfrz3xB7cs0iW_CyQ@mail.gmail.com>
Subject: Re: [PATCH net] i40e: xsk: advance next_to_clean on status descriptors
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:16=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Hi Alessandro,

Hi Jason, thanks for the quick review!

> On Tue, Oct 21, 2025 at 9:59=E2=80=AFPM Alessandro Decina
> <alessandro.d@gmail.com> wrote:
> >
> > Whenever a status descriptor is received, i40e processes and skips over
> > it, correctly updating next_to_process but forgetting to update
> > next_to_clean. In the next iteration this accidentally causes the
> > creation of an invalid multi-buffer xdp_buff where the first fragment
> > is the status descriptor.
>
> Upon a quick review, if the packet is not a normal packet,
> next_to_clean should be advanced by one anyway, right? If so, we can
> only use something like "next_to_clean++". According to what you gave
> us as above, only if that condition is satisfied, the next_to_clean
> will be synced to next_to_process. In other cases, the next_to_clean
> will not be updated. But the packet read by using next_to_clean is one
> status descriptor, should we skip it one way or another?
>
> One more question from my side is that since the first packet should
> not be a status packet, after your patch gets applied, in the while
> loop, 'first' still points to the original position that is
> next_to_clean from the rx ring. After calling 'continue', another loop
> starts, 'first' is not updated and then will be passed to the receive
> function, which might cause the unexpected behavior as you said? So
> can this patch prevent such an issue from happening in this case?
>
> I'm not sure if I'm missing something.

No, these are good questions!

It really depends on whether a status descriptor can be received in the
middle of multi-buffer packet. Based on the existing code, I assumed it
can. Therefore, consider this case:

[valid_1st_packet][status_descriptor][valid_2nd_packet]

In this case you want to skip status_descriptor but keep the existing
logic that leads to:

    first =3D next_to_clean =3D valid_1st_packet

so then you can go and add valid_2nd_packet as a fragment to the first.

Ciao,
Alessandro

