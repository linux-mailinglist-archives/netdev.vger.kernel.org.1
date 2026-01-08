Return-Path: <netdev+bounces-247956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2EED00E49
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 04:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 721C43002846
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 03:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE9E27B4E8;
	Thu,  8 Jan 2026 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5SR+E4q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O1JdmZxF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CA253B42
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 03:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767843662; cv=none; b=N4Te4+W0PJ5lL4bwv4bPrZjQwbFTdQ8pHLc7sv2Teo41gCdbaVK1If10gwwcaTez+VTo/MMc7CW6YsKnHa+QfQwEwlVsrNhY3fEKxI1vdM63d5fCc979SIaBmgVytaPxNFPa4L0oRPp/SDRuj0q74PzLIIuZzkQ3sB9bkm0rFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767843662; c=relaxed/simple;
	bh=VkCSubSt5xnjldSC7X3KoWYDh+xOvzCSf5/mkTI/WA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhQ87tlheM1BlBu0g7Xt2XaCCF4JI50xLWCrkPBPmelbRXLcHLDCS5tWulo6doPiazFXu7Pwpx6BAVKOOOQCOnssIX0T5mqZd8Ztp8iT+phNRjfB+k+JLC6c5CahsWhqW3PQ55gbYOhyPuRaqBGH7ort/rmVIaj0YUR4yIOwlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b5SR+E4q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O1JdmZxF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767843659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkCSubSt5xnjldSC7X3KoWYDh+xOvzCSf5/mkTI/WA8=;
	b=b5SR+E4qoIqNlInac/aFtFgkKJdvZNj1CB+pPGaDW4w8GwhDhgG5OMF5A+F7+BuHu3frPT
	FzIBChne2YhmZeznPnpZw4WQ4AvsDpLcXRUFYFwb9APaNznciNQNMNZ12JSrFU3tTt4ywM
	VJl/e6/oSCpzokmJVLdHnrP81DH3IlE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-XiRduofGPYuHj4BbBBKubw-1; Wed, 07 Jan 2026 22:40:58 -0500
X-MC-Unique: XiRduofGPYuHj4BbBBKubw-1
X-Mimecast-MFC-AGG-ID: XiRduofGPYuHj4BbBBKubw_1767843657
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ed2so2784109a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 19:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767843657; x=1768448457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkCSubSt5xnjldSC7X3KoWYDh+xOvzCSf5/mkTI/WA8=;
        b=O1JdmZxFjfPWZC7Sfnct3aXbX93cFKVvFIlJssZ8OPiiMevYNJ114HTSuKsY2qQPwb
         Ft2TogvqzgiEfMR6nfzkYKcm19aDmA3eFiH0h4GmJk61HAmk2w7N5fLB9W0cv1OENIAd
         oke1B6DRLS4PHnLzUbSgicmJ6EghpiTrk/hrE+iVlyuj6h3+OmT87gWmvtqSN6JATKuJ
         6zRifLasX0rYwVttWVRYfOzXRLNbjaIS1EwPN8U1OBUBQNYox1PSNcWwKbITfu30y7NM
         zAswt8PqskjfwnIoPvXDn+7TL8JV6WTxGX4Emslh9II4dumhcqFf4inG0mLxgmQ17CyD
         dxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767843657; x=1768448457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VkCSubSt5xnjldSC7X3KoWYDh+xOvzCSf5/mkTI/WA8=;
        b=m7OmjYBzRIoBZumf4Z4Dc4CUSEEiUlxpFqJmDI8JLCf4sSCep4OM7T13dYh2SO3rXv
         39HkH44GRdBT6tl/AumwbVP3OpSFBJqb4SkgI8y1o1zdflemAJ8na1I1tUXF/Lk+rrSE
         MiJcc654TfraFnrwEViuyjFApWZhgHDYhsdR6RjlGN2WYv8pVI5IlKG/z3uvQHoLe4l/
         Im8xwR9Z3Db8p+mmlkExmE8b/Ym9fR2FmfhY8oTBo2EXjELtsCmD/eCEdrSsmwgVU60X
         EsWOpzuDq9RGxZezFAi44E0jr/cp50bTngqlDbpryO1BNj6nLnZfa1TyTDqKjtap+fnP
         TYWA==
X-Forwarded-Encrypted: i=1; AJvYcCWY0JWxCwzmpEh8ImC5HnnLaGIcUgjGCWSfLphnT+kapIhz7cfHDZ4yg7ROCJ5sKlHEXeYWids=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRY3P9ZefVMtx80Flw7i+HRjyX3fKwpYOcdilRkUJMeJuU1bSo
	VWHW+MLoNOLLxV72fULD0hBs/wfETBY6uAsVgS5e09NQyTRmSD4d6zVFnzWZy2/eu9VqeNt16fK
	f7J2V75zF3yVkPnoUB8+xh43J2rJa+nYlCvdu9KiMG+cv1Q/FMU85sMQ3PkCgX6pjY/9E7eZer8
	RYZTSg+ykn1LNeyCCadfrBdxLqtEzFWg8X
X-Gm-Gg: AY/fxX6RcRLZjora7KJXcBuZ/Z6Ad2F8U53P7k29tyBl4omb4MwWNlUU3MK9mmjeiCv
	QHjIQR4tkaaNIuI8Su11dDs1y3wuuw3yd3W0gVUz5cNyGRCeYlJvTI5FAvYfpWLTHWTGk2Uaer/
	XydUHyLWsQHohT1XvcyzAt7yhLjqzF2LuPdXUQEM+6v52XcIvmMvTZUiW3rSOXlkA=
X-Received: by 2002:a17:90a:ec8b:b0:34a:a1dd:1f2a with SMTP id 98e67ed59e1d1-34f68c020c8mr4599009a91.20.1767843657571;
        Wed, 07 Jan 2026 19:40:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRT/gHviVKg3BmAeVmqnf6QovlGyDQiLOP3X7YJzYa/y5gFMdrkkTDAfiNZ+bZ74TXfET7NZIrA4LL/VqNrJg=
X-Received: by 2002:a17:90a:ec8b:b0:34a:a1dd:1f2a with SMTP id
 98e67ed59e1d1-34f68c020c8mr4598982a91.20.1767843657139; Wed, 07 Jan 2026
 19:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-6-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-6-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 11:40:43 +0800
X-Gm-Features: AQt7F2oQUWxfwmKfkPMH58sXdUHRR1BABNg8c-gOhAXPWs9rnLQwCP9cTooUbiA
Message-ID: <CACGkMEs-V7g6fP418K3SmD-oayT0mGOnzPt-ynkNAjiSVfHppw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 5/9] tun/tap: add unconsume function for
 returning entries to ptr_ring
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Add {tun,tap}_ring_unconsume() wrappers to allow external modules
> (e.g. vhost-net) to return previously consumed entries back to the
> ptr_ring.

It would be better to explain why we need such a return.

> The functions delegate to ptr_ring_unconsume() and take a
> destroy callback for entries that cannot be returned to the ring.
>

Thanks


