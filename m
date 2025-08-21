Return-Path: <netdev+bounces-215643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83464B2FC19
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA057AC661
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19412DF716;
	Thu, 21 Aug 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/VE7ZSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D542F619D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785682; cv=none; b=Rz0Ot5yq0Axk7wN7mnQXbgFqZjWc1o/QdsT9xo4DaKl4fE8MZ0u6L2kUlYsiRKnTKxjh9ma+GfFLFRQ2s8HyobMCzLjOSJw/abop1slZ8ESqzP9yebMuYZPBjTM6hdWOcjumbYvse5iVgWuv+VoUntcTo6q6da47/7gI4O1jS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785682; c=relaxed/simple;
	bh=wklH5RSkZi+lkKayoTSAl+6FUN6m8CIpX7+2bBp2jdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rG8yigP93qeHT0AK2Nx959oaDqvbc0/csg99q1kUf8xiG51M9QfX5qkKvZ+gCwizSmHfdBoh93GKAGgCqoUUeLYp7XTF4Lp0OWDWd0EkNnECe/pBG1Yae7AiJ55rEPDww/zoVE3Fq+fo6qolvafcFb+j5scFlCz5HPUH98felSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/VE7ZSJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e87031323aso117745785a.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755785680; x=1756390480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wklH5RSkZi+lkKayoTSAl+6FUN6m8CIpX7+2bBp2jdQ=;
        b=g/VE7ZSJ3jyS8eUn2uu9Pjn5QO3OG3EE5MDqU4RecNyBHzHcp+6pB08ZLvPsDiVq5M
         hRoI+C7/cwbMK6rJ17aZxP/47Rv0+HsQar5iYhU3JC0TMjvPdORe6O2Q03215tIzqsbv
         N/+Za3VIw/743ndF7M8g/jHXX6vebQP97eiF0+8WaK6oaQKVp4tpWKi+wuYwf8Ju19t6
         tgV8y85pWdpjgaVINDIVnNO1a5H18DITsf35Yiu8102FHWXDgZ2h1EA1z56t+KkT2Tu6
         yBl/kZLG16XuwKp9eAEGJTTMYZyiIcVJJ8E5s18vurCVPwHzmqgtaHKhL9CscFjApt4v
         IO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785680; x=1756390480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wklH5RSkZi+lkKayoTSAl+6FUN6m8CIpX7+2bBp2jdQ=;
        b=weF5jaIoKYRRAQKd7zLuEmHO2FkNNnALrcUMDq2k7NoK3NbktDOlKJ2tOsfPUbVdWz
         fkt6zMeoIlEB6RnRp2Qmlr8oq8PduDPpnrL84SbOjanEr6z3KIAHT1XWrbzoVnHSWg43
         kMSQrRJLKXk0UjN4UBkxDGr9o/JFDJeuqBw0t/JYFBETURPOGMzB8I6M1IZpU0RKwCna
         oHp8q3kStXr7j9pvG2Vx3HIR/OhMnxxHenSDg58xXsejtrJC1hJFhyovFCSw2IdhtbbE
         Kd7xTE3HsaIdvt/E6DOeNDAA9aBZPDRar4fvYEJtCMojXhzQqw4D3kiIfpKKDNOE71si
         +9zA==
X-Forwarded-Encrypted: i=1; AJvYcCXi2Wsol6NAGXtkBvTIjawBN9tgaWbMzvpuu/KtgDT1cQMXox1Sxa7jU0GhCUAti6UaJqHSzMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbDPPARThJyMwqjPJ6rKvRJTlt2mO8R4wfApweXORNvp95ykeW
	GAfKpKMprkQ91rWNFrKdeTz00Kayg+nB8JODOY7Z/+Gh7+x0h9wHfLAAlI7J9VSa5TFbH6TuxP3
	PbsoXq0ggZ7uE7egSa4VIGS7SwRwEC82CMViTXl/g
X-Gm-Gg: ASbGnctlOiJ3LnNWu1oNAO2QAFPWTGKs9kb2X8JZSr52Tpq93Qf6omNiI+pTnaB6jZX
	CdYYY2pMDugYMj7nsluVH4byE0yzal3PjcyYoIjUGWLQkB2BGIW6bcWhb90xnm6Lr0mAECH1qrP
	TKX6Ql0j5J9x8xEUcPnMPNF6UL0NHv+uaiWp8AvvbJiOKpFTvBwo3r6eWG4uTCy+EM2Or2mMHvz
	F3fYKDSYbd7nzU=
X-Google-Smtp-Source: AGHT+IFBQYEhzxEfUJuh7/Ufly+YtIuPzk9NaiFpHkLdtKRYJwwGcfimS1d9E4ez3jq7Lj0aNP6KUsVHvEkQMQ0vo4A=
X-Received: by 2002:ad4:5c64:0:b0:707:4c0c:5316 with SMTP id
 6a1803df08f44-70d89019cdfmr25864846d6.46.1755785679429; Thu, 21 Aug 2025
 07:14:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818195934.757936-1-edumazet@google.com> <DM4PR11MB6502871B0C99047AC76827BCD433A@DM4PR11MB6502.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB6502871B0C99047AC76827BCD433A@DM4PR11MB6502.namprd11.prod.outlook.com>
From: Brian Vazquez <brianvv@google.com>
Date: Thu, 21 Aug 2025 10:14:28 -0400
X-Gm-Features: Ac12FXy-PPKz-nGP1IhFwqpoEnXZCUiiP1Bd58UDI3ZNaihCVGmplacFmLavGOg
Message-ID: <CAMzD94SjV35aPV5tUxKNEfpAk36yjZMQJz63bSnMeshHc8BSBQ@mail.gmail.com>
Subject: Re: [PATCH net-next] idpf: do not linearize big TSO packets
To: "Hay, Joshua A" <joshua.a.hay@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>, 
	"Chittim, Madhu" <madhu.chittim@intel.com>, 
	"Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Brian Vazquez <brianvv@google.com>


On Wed, Aug 20, 2025 at 12:27=E2=80=AFAM Hay, Joshua A <joshua.a.hay@intel.=
com> wrote:
>
> > From: Eric Dumazet <edumazet@google.com>
> >
> > idpf has a limit on number of scatter-gather frags
> > that can be used per segment.
> >
> > Currently, idpf_tx_start() checks if the limit is hit
> > and forces a linearization of the whole packet.
> >
> > This requires high order allocations that can fail
> > under memory pressure. A full size BIG-TCP packet
> > would require order-7 alocation on x86_64 :/
> >
> > We can move the check earlier from idpf_features_check()
> > for TSO packets, to force GSO in this case, removing the
> > cost of a big copy.
> >
> > This means that a linearization will eventually happen
> > with sizes smaller than one MSS.
> >
> > __idpf_chk_linearize() is renamed to idpf_chk_tso_segment()
> > and moved to idpf_lib.c
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Cc: Jacob Keller <jacob.e.keller@intel.com>
> > Cc: Madhu Chittim <madhu.chittim@intel.com>
> > Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Cc: Joshua Hay <joshua.a.hay@intel.com>
> > Cc: Brian Vazquez <brianvv@google.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > ---
> Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>

