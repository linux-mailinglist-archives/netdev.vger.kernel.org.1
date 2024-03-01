Return-Path: <netdev+bounces-76452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A9486DC98
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BAC1C21964
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 07:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD169970;
	Fri,  1 Mar 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG2fSYIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A11E879
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279965; cv=none; b=hM4zcVDc5nu4YoW41tqDIYynk+RNOSr1xsfSmveLyu1k+g1uiYib171dBj+iTPnvNjwQC2LMxpfpFa+NxrPY2KbZWAIQ+VuDeuC5NqjAWx5JVTayHl8ivhNDwZUJn3qjZkvkQZRd1/UBTNLv7PBzbwUTjzX716mPm/JGS3ILYQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279965; c=relaxed/simple;
	bh=zr17gvSSYZaVH9ib6UrODiLALqn6xS5V58WYpS0qdvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzPjCRb2ZDZ5pAN8aO9C8icClupkl3xRWi6KOfWpb0kAjEWTkC7NLVMfBpn+KXde5KtMESJBc+leZVsXzarJ57kIlLqbPE/QfiM8bka02am54du5OqsbB6qi6dgf9XawO8ONzeNwUhjt2w8xaJcnYISW+GM7Ig/qHR3bI5riBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG2fSYIw; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so3883a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 23:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279962; x=1709884762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zr17gvSSYZaVH9ib6UrODiLALqn6xS5V58WYpS0qdvY=;
        b=pG2fSYIwRqvMpQ1poPIv6mMnFyBiBZoelnmcFA6cWpeFis+lYY1mZkiQWTLq7wREbY
         VcaDtl5OuqJUanzy5Pj9F2iyz5c0AF6EMpBmJM4TV2qUQpCCpeAykPLbrfhg8zXQD121
         5YpN8SnwN9SOb4bp5qwmB0jI8oVQghEDaqFNZhBSwy6VCrvWQBcYj9CY9y0e6oZ/0W56
         apCXWbXkVhInI8Wb7FH6rYI/CG74UJToBB1Oew7cyM9jUl24fxlhiBD2VEa7pljjppxA
         t8YOyi/qQQVyJj2QNz94ghuRM4XN/oSBdvYHMsO7EMxdmaLEg65+ZWbmaJ7flT9xuLwB
         PVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279962; x=1709884762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr17gvSSYZaVH9ib6UrODiLALqn6xS5V58WYpS0qdvY=;
        b=rMXpbeqhNdOL/w+uWsXa+ga/XFWNyEEyq0jknbJH4hzVjRxYwLKA6BpX+vcpRDDaF/
         jzZHWCmj4toy2ybAGROvctBkcWwiHngTGlI/hWH6bt9FRRbknoSUbDwSwLgAODcCO2J3
         2D0B6r71VoEQXOJ7WQcJXfnbZcMBZDKI068CdAnvrlODRufu/82WNC6NtWSK8vjTInC6
         CRxlk4jXU04372+Wcfff2Rnp/AqJZ55y4GlxmGfCkjrvdPQbv+vvcxBbCXCZT+s/KszI
         TMwOSem9ewpkI0CREvRF03SecD8c6KZk4K9LHuUAhwhrDLMAUO7UgmB99xIA4r2/dTT8
         dHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrLU7wO4eATUICU9rI6/Vbkpos8tIGxVcL1j9iRM4RV/SSc+W+sCwoev0uWK9sTBbwDh6g+1qrDG2fKaMvRsArvictNNdT
X-Gm-Message-State: AOJu0Yy4nAC4r7CWX8SOAF/mEaXdUnM+YC//E8PyOgAPT1fTiV0SfupX
	m/YQHy+SsJbKBWFv2+Ag6nkBiFbOzWXC/iPDsCATLWCAJGNzbNJ7W5tS1H4tVsmnko6bdFND9/6
	Dayo9RDuRmuKfhqb/L5ywtkF0ji0S/8dm8MYW
X-Google-Smtp-Source: AGHT+IEEtSCK29cB4p97aeoYbUpC06LMrOwaksjc/s10E3lC10NxKJ6xZCv2MJVmnqAp0S0aKLTElVjqSLOxSH4+Kag=
X-Received: by 2002:a05:6402:350e:b0:563:f48a:aa03 with SMTP id
 b14-20020a056402350e00b00563f48aaa03mr113930edd.2.1709279961492; Thu, 29 Feb
 2024 23:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301070255.3108375-1-kuba@kernel.org>
In-Reply-To: <20240301070255.3108375-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 08:59:08 +0100
Message-ID: <CANn89iLhOWFaW-iLw77LcgZ-Lzbput9XQt=GtsC_V9yV56_jwg@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: igc: remove unused embedded struct net_device
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com, 
	anthony.l.nguyen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 8:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> struct net_device poll_dev in struct igc_q_vector was added
> in one of the initial commits, but never used.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

