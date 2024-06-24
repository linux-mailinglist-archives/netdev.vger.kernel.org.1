Return-Path: <netdev+bounces-106069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9169148A7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DE3B24D4A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3013A416;
	Mon, 24 Jun 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WhwvcREo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D675C13A402
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228574; cv=none; b=aDG9hVJMQFxoXECUKmoJzohBn183MUE9LsrU4R2hokIEcVhXTrcvSEoffB6qj8QjlfKxZndkXbf9X65yWDaHZVI/B35quGdkO7SdaHN/221huF1SGxvSCd8Fz2aG356HIxmMzCGRSpOcJJWM1NX8TAncRwVU1pOK+cOjPVFIJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228574; c=relaxed/simple;
	bh=jxpbnPGQmpKnTg70ZCbmTfX7HS14+cPQrrOTV45wxzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R3EVKdPkBKu9ffvnbxZRHcXwMnIa1BsocYTAkuMJ1neaDlpY/ZLyD4OQ5gBld5uLO6BEYGZWERT/lbrRe3/pNiZORO9oVxpgX13zPCjU4bLRL43pXHGSZdghDr7hVWNVg6OIiKOjRA9uTj146bbrWqOm8Q5HcGL8J/a0r9Dmmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WhwvcREo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so4319916a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 04:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719228571; x=1719833371; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PdYZwMeOa23letgBoSjR/fklaEKAWJJvDb1Rt7otSBo=;
        b=WhwvcREo02OettmOjJsFTjefR/yomhQdcY9E7nUbIi9io+IgjdZLjhdFz2Ia37MgqO
         aVFz6YWFpuSkS6SFoe0oLudksUIylJ0NbdbYKLyoC/TFF/wb76oPp+2nvogGIkDpVFTV
         GBIgJBQpOOWVUlRhnqdBCodhZOdCGwDv2wZsJpsItjU4uRen8SM0UbwCG4zMQAKPoyR5
         qypgxwWUfrUYy19t8lbD887u4ZRQp72Wl2DsTX8DxNWbz55oZH7LYvl9l4nNh3ibDpN8
         a59wr7Ne1JSi19dNnA/hlyntYj9QZK606Ng3EnScBtzRLf0TCHiI9qy3rjaUKaHLlQbz
         Cibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228571; x=1719833371;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdYZwMeOa23letgBoSjR/fklaEKAWJJvDb1Rt7otSBo=;
        b=Be67wimK9eUseak8NGbCVZq1PJAOtyGGnWrqWfvQrDFGF7fldpkuPAxsxZa3Y67BHD
         M9Jlq5qVRZ9sdWITpKeearXTM2gJ46aJtBxInWsmX6uHHPAKt1AJTNs3xsxP+oGRI+lU
         /xgiplTFXgukCAbmfzwezY2R3d0HVUablzeksJYMYBf97QOJXEvJHNJJJxhWzOArlQjj
         krnUAu1hhcYTuK1XH/nNBMuv0IIO9yZpc2zggaLfLNdlBS0+BWqn0ZVC9HA6n8an7hK5
         u39xLEepj8ysg1sBn2c18NCldfinsaK28autF6isvPJxEqOb+GI99Q4mokIO/gWBarvu
         mGRA==
X-Gm-Message-State: AOJu0Ywe8t28e33s7IWwvzTC3D/UhiR9DX+AQ0YFKRwMZL2DQfBl9xcU
	bYYQ1ITOWlbyQpuNvc/xekYHv4rgchjJwZZyMzX2g35g1D1FJyiW7cKui/CsVxc=
X-Google-Smtp-Source: AGHT+IFEIWE36nX0XnRYC76EoVZRGsPo+pjJSNM1MKV/+chfb0hUwz+EtxpiTmZw5iqOLWqI9hpsFQ==
X-Received: by 2002:a50:8d16:0:b0:57d:61a:7f20 with SMTP id 4fb4d7f45d1cf-57d45780581mr3679975a12.3.1719228571173;
        Mon, 24 Jun 2024 04:29:31 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d509sm4710854a12.43.2024.06.24.04.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:29:30 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Willem de Bruijn <willemb@google.com>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net 0/2] Lift UDP_SEGMENT restriction for egress via
 device w/o csum offload
In-Reply-To: <6677da5b3c52e_334d34294dd@willemb.c.googlers.com.notmuch>
	(Willem de Bruijn's message of "Sun, 23 Jun 2024 04:18:35 -0400")
References: <20240622-linux-udpgso-v1-0-d2344157ab2a@cloudflare.com>
	<6677da5b3c52e_334d34294dd@willemb.c.googlers.com.notmuch>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 24 Jun 2024 13:29:28 +0200
Message-ID: <87r0cmwpd3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 23, 2024 at 04:18 AM -04, Willem de Bruijn wrote:
> Jakub Sitnicki wrote:
>> This is a follow-up to an earlier question [1] if we can make UDP GSO work with
>> any egress device, even those with no checksum offload capability. That's the
>> default setup for TUN/TAP.
>> 
>> I leave it to the maintainers to decide if it qualifies as a fix. We plan to
>> backport it to our v6.6 either way, hence the submission to -net.
>> 
>> [1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/
>
> Agreed with the change to allow UDP_SEGMENT to work regardless of
> device capabilities.

Thanks for the stamp.

> In my opinion this is a new feature with sufficient risk of unintended
> side effects to be net-next material.

OK, I will resubmit for net-next.

> Maybe worth recording in patch 1 the reason for the original check:
> that UDP_SEGMENT with software checksumming in the GSO stack may be
> a regression vs copy_and_checksum in the send syscall.

Will expand the description.

