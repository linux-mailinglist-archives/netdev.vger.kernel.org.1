Return-Path: <netdev+bounces-137331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A339A56F7
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 23:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6095B22248
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537F21990B7;
	Sun, 20 Oct 2024 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iF/Oo/pP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068DC1990AE
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729459535; cv=none; b=db9vqiH1sUB5TE+/iQLyspcxO9uvblBe6WnyJYhQbnoUksG+5XxAKAx9c6dJxI8jes2INd/VoxsS7a0284ZUHTJGqoAqJLp84WEDEzivJ/oH+YWHh6sjmLHPfFGFXtvhsdgEfdishwdBpttwJQddDJZl3G+i60tKwUjxroQATWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729459535; c=relaxed/simple;
	bh=XkJsm+YQn9dFOqvyQtmGu4r1jDNh0/lklKP+6iMRiwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+G2+De8JQb1fdgnZ2eme4caReNFkWLpio9Snult9b5/isIiwXwzHD0MEx8h5gwhpq6kknHKWwjMFdstkv2GYRYBSUW+H9MQl3n2ldQv1oD5wtGq9ZJcNM7y8WSyh19BPviHlqgSX/uKBFZUL871122wOVVI9E7FkDBXM6JQ1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iF/Oo/pP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f58c68c5so5513123e87.3
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729459530; x=1730064330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86Vxu3y5hRyjW/SN4fiNS5sxS0hzqrFNGJyjGIFIOpg=;
        b=iF/Oo/pPINWRmW3YTRR53g4GbjqVI7YEfw9BNgWG1Lz+Xk6wOjCvx+TAER9A1O7VgW
         QXLWRWq+uJZiAmBgRelR4SJuel7eKxhgOiSAJ8faWK9AVn45Yh7hKpdh792N/dX08EgW
         rKpAsdBFZcqwXoor/QFrnEXSjat56OkBAIL2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729459530; x=1730064330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86Vxu3y5hRyjW/SN4fiNS5sxS0hzqrFNGJyjGIFIOpg=;
        b=IB29o9qhfOXAxUnmiHnvK3zEwsYSjyZAnUpVvbqe2ZI9kN2L7uAGScOWNtCUA1MTnJ
         8RD5XQfN7r8NnRsUbPQA/qL4eUHdKXMKX/mfqXmTeN2n7uMhQuPIkIZudwEOI5xjIA3X
         xZrolG88Bc/MllyHEM5EEIkFtysoXX+x77YIrEObZlBSYZwzEnfqs4Z7KaVvy0V4EWHd
         Kq9yTAChF+iuYsznAuuccJwgSebKwuEMR9rVJOXOG9/IGMUgHAFu2tkl5//zDSEck9T5
         EBY/NSI+JTdj8f/uXzdaoJ112RfL+CDseVUJAwPRqpcK34TyFCjJPQjuvg0bhMkSE+wY
         DOig==
X-Forwarded-Encrypted: i=1; AJvYcCV0ymvh+cyoMoCtSPxDLikHuGFG731jud5nMpcbfszrMJNaZlDHoZ3v9xQipfv7G3jX1LC3Fgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgkzR50XxPVTOOEOcqZfQZkQE4bpIXQsbNoGsihHh1iVhRwsb
	y+HyiQHoXMFFT8vZ1LU5nXSvNcx7+ygWBY7nYadYcO8saZnYRbb/RJlkj5vRy+l4E3+YesGqG4Z
	lb5pshw==
X-Google-Smtp-Source: AGHT+IEkdA3wBPDsFwHXnQWqHDDZm1IihO/E6Z6c4xs20a5PfjtNOtQKotdFyy1Qw4cKjhMrmpF2xA==
X-Received: by 2002:a05:6512:3b20:b0:539:901c:e2e with SMTP id 2adb3069b0e04-53a154eb6famr7245853e87.58.1729459529906;
        Sun, 20 Oct 2024 14:25:29 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2243ecd0sm310788e87.249.2024.10.20.14.25.29
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:25:29 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso58049851fa.3
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 14:25:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZDCJ1raYj1X46SMKmflrvihaB2nfEfGs6Ir/flMl3qoj2Dm76En+d3FMB3rJPZRziU9zbK7s=@vger.kernel.org
X-Received: by 2002:a2e:8815:0:b0:2fb:3881:35d5 with SMTP id
 38308e7fff4ca-2fb831efa0dmr47530391fa.35.1729459528880; Sun, 20 Oct 2024
 14:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016204258.821965-1-luiz.dentz@gmail.com> <4e1977ca-6166-4891-965e-34a6f319035f@leemhuis.info>
 <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
In-Reply-To: <CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Oct 2024 14:25:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com>
Message-ID: <CAHk-=wh3rQ+w0NKw62PM37oe6yFVFxY1DrW-SDkvXqOBAGGmCA@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-10-16
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, davem@davemloft.net, kuba@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 09:45, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> I really would like to send the PR sooner but being on the path of
> hurricane milton made things more complicated, anyway I think the most
> important ones are the regression fixes:
>
>       Bluetooth: btusb: Fix not being able to reconnect after suspend
>       Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

I cherry-picked just those, but then I ended up looking at the rest
just to see if duplicating the commits was worth it.

And that just made me go "nope", and I undid my cherry-picks and
instead just pulled the whole thing.

The rest of the fixes looked too trivial to be worth me having created
a separate cherry-picked "just the most critical regression fixes"
bt-fixes branch.

IOW: I've pulled the bluetooth fixes branch directly, but sincerely
hope this won't become a pattern.

           Linus

