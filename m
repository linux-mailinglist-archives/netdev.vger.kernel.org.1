Return-Path: <netdev+bounces-76468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDD486DD51
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C8E8B269A5
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD0D67C74;
	Fri,  1 Mar 2024 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4xz7W+z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD131A85
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709282645; cv=none; b=g3VkfGh8py6CK8je8CV/+w7EmU1YrcS99kI/boAmO+tbsywyfYP41UKKHULG4BBzMdPWhsUSUqs3yS+lUKpLvep8+UHVCKMTqJ11sKrfML0E5Ox4gz/IZ1oR/EpNCLu3Obiv0iKAtFA3ky7wk8os9NfxkVeYOvo7NdBmwxyIY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709282645; c=relaxed/simple;
	bh=UNaBzekIAgER5sUtYX60EtkrlepdBDkeThbZPYPfvAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snNCxy8h6o6DD18v/4JwH6z8Pqtg6srcZoEppKPMdn+t8liRrfGvlwstetx/eRiMWagfdbdnqcTUHV6t4tBtFOc8EYDGlPecMfHSK5xvhw06gOEZJMD3EvC5+baoT9G1fkTuk73x4PZ2muYZuzJRVYJHu7Rxp7RgrNeqxPkSG4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4xz7W+z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso4878a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 00:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709282642; x=1709887442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNaBzekIAgER5sUtYX60EtkrlepdBDkeThbZPYPfvAU=;
        b=Y4xz7W+z9m43Fs5eSq1zXPq7wLXkfUXU6pzQVpGkdS83bDTUmSuP6TXDGw+Vqq1w8u
         C5dxo3ZP62SmbAeLOkrPEYUTrGGOgw+52E+DQfodQpJLviUgvTX3ysdxU9LXQmjlA9gJ
         HVuDZU95Gz+yLXvXhbYfnffOn/sjOe50WeAwgFev7hGLiiyaBKnR0hCdPatZoeeRuN14
         FzMAPc/ER3XOmUpgNfnTjGFHu1oXaE2MDMcjaNp7P59CL3ZNBDZN/V45PfKrU6wgJtrL
         /kuuy0liJBJgJUBmzfBBzXoSvIq1FGaeo6sKAgeyr8EaPkN9QqWw2A4e4/O0VgNQS6Va
         0NpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709282642; x=1709887442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNaBzekIAgER5sUtYX60EtkrlepdBDkeThbZPYPfvAU=;
        b=LgTlm2OErKxSDdUctsA1IzAMNCvMspZ6rCX7UodYhLGACijcYveIDoRTZIoO9cUfBK
         q7EowsjECDDY66XAh1zqxm17aJy9gqwcvE+xeNqCjGIjqn5U7VURgVAsxH9lbck8eShL
         PK4d1REheTonKJn7KHUuQpcipLlc+39jE+SnPzEQfHfXM68XUFqRgIlpCmVgBP6P5eFU
         Pnz41r9xxEUlD9jh966v/oonHYXVJatz9weoG0v0YUb/LW/+dnwr+8MqGIBQmF9ZCM25
         6+uorn0ZTatrq4BrfQ5dggT4phx2PQVCaN4D6eUxvzNcEKFwoxDh4ms7fzY+cVDMArNf
         PVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsb3+b0iXIOK08y2gIqxwCve2DqI8TsGMRa9jg9HY4YPAMIY61Lw3i2mANvKkfY8IapodZvijdQz/oy4UfRS/52tyG1uCL
X-Gm-Message-State: AOJu0YyIt31IJS345M2wJGjEqcCU5ZOJb4RyP60sPT49Q9RTQwojqzVZ
	2Ccg7cOMuRrysgoKXWhVsvZT3dleNtoK1nF58YB6a3znQ6iIhEIzhEPTgxdjYRSpKjupGNtb9QP
	NNCMmmssZyfnAqjSICbUuHleoCZ37lctDzUmz
X-Google-Smtp-Source: AGHT+IGegC4nkrhdsd10GdY9z5sqrvWwH1VYQwCrhTBLNU8DARCRBh3Vde9zuD521V0s06glitzWvPbGUV4AZFv7mxI=
X-Received: by 2002:a50:cb8c:0:b0:566:306:22b7 with SMTP id
 k12-20020a50cb8c000000b00566030622b7mr63034edi.1.1709282641750; Fri, 01 Mar
 2024 00:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301011331.2945115-1-kuba@kernel.org>
In-Reply-To: <20240301011331.2945115-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:43:47 +0100
Message-ID: <CANn89iJ98MPwmk845Z15LLwashiMSmvGaHtW0M5J6oAsr10ZpQ@mail.gmail.com>
Subject: Re: [PATCH net] page_pool: fix netlink dump stop/resume
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> If message fills up we need to stop writing. 'break' will
> only get us out of the iteration over pools of a single
> netdev, we need to also stop walking netdevs.
>
> This results in either infinite dump, or missing pools,
> depending on whether message full happens on the last
> netdev (infinite dump) or non-last (missing pools).
>
> Fixes: 950ab53b77ab ("net: page_pool: implement GET in the netlink API")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

