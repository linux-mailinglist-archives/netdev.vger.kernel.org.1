Return-Path: <netdev+bounces-110605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F392D6F8
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 18:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B432B2E35F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 16:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAE0198E91;
	Wed, 10 Jul 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSkFg4V5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9F198E79
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629422; cv=none; b=IHx2oY+2nDzTqWDrKM2LiMlh0XLBy63tJGatciw7sz1lSALHByqqPBmqVBLtkhVbHxZTRm3dNqbXoVZTnUzneGSre8Fyo+CptyjCFYCzaktjBB+Dld7syS4Elx9+HRn+67PG4jbPDaJ8Cnyx2YdVJTr0Rj1PTUF4xpcDmfQa0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629422; c=relaxed/simple;
	bh=+9WXWxoYOKWamD+vE5uwNUduTJzyXrMb8PWgNp0n1rI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=banJNbojIotz+iHi2lm90wvhB1FORA22Ahzml0VFb8AEsgUbO0EXjpp6slnjlDDdiZu9NQo7TyH0l5XGD7E65qbJHbpxWwn/xqU95lZ7Nj27jLhWxBZyBjCBPaSYOV81Q1i5MgdVAvwERh1OJDnly+GachxwhQODIhGPx7JfFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSkFg4V5; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03a63ec15eso6074860276.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720629420; x=1721234220; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdEk/xS42cer+nsNbr3GxVg6aR55CredoMdTWrvWjPQ=;
        b=BSkFg4V5bFLsMqmzBCoWeyfGKxM4GEjv10v0uDp7Xpz0Htq7tTZMJSqJwFKL0nOaEU
         z6hAlWW9F5YivMz50UtlcQLQ4Lxmhv+Kk83Y2528Aazpp/JdYaVPQJpcYSb8r2Wvo4wM
         rMO1vWqhxGHFeRRvoNXj7QiSCMlBYFVClfx1szf0QwAkxhB1tTLTvEeN9svb6/PIHgEK
         +eM7TfZk9bY4qoS9ZYqeN3N7VX/yUpO1MAAvDtb2JzLaNdCW2BcFBPmMbB7C6lIq3Qb2
         pQiK3KzAfJUhsV1Aqk2cO5ZNwFmBVRIFQx0GjwTC9p3pWLsUKy35kHf+qEs9UN4VyK+a
         hS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629420; x=1721234220;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdEk/xS42cer+nsNbr3GxVg6aR55CredoMdTWrvWjPQ=;
        b=QeOd7O+j7loey0TPn56aHVYUV26sb38bjxoMvIt7vueeUU+7KncTOZEyUk6UrkHjtp
         pQl+W63Lkh+aeR7v/JeAyNzayL6ceFJpEPa64icEX988esCaTMShqIYyBXrCnzMJwjGU
         M91FSCi37SCSm+T3RsA9RNA/yobuT24WDAHIQXktJS8oC7bWBFYz6keJgMCbnGx8L//i
         EDFTY+iZ7sfgszQxQwv0Zthk2tlcv64fDMPSk/vFip1+uLH0vglB6Oq7js41HB8wXVpu
         Dkog9a47/KYs1vLHASYtX4rlErCSxMaMfIWfhrZv602YwnoT3OebS7s1r4Dj39AhAdyQ
         zR+A==
X-Forwarded-Encrypted: i=1; AJvYcCVcT7TcBc4n/ZE2EZmHd4/ixBfu0/RAotUc6/jaOTlYVXDOJpcFyZN4v8oAhrM6G4JvJwIM5azpZRBOnsFOJXmXLtOfzINX
X-Gm-Message-State: AOJu0Yzi6rPdnsV9H8kqwThIg+kZ9dqYAHXmizUQ1ajQ/v6kH+589GeT
	DCghHsHNpr5TbrOxnMipWBI3OXe6SwTiw6i2IkCAivdzNUDlpAVg+zOKBkHO6Q==
X-Google-Smtp-Source: AGHT+IHmlzxMBt1I02mYgCVVFfyZwoIJo3cnM1aEwxkR/fsMcy2EzuwB+V0Pzq8JtvZgB7eiWJDgSg==
X-Received: by 2002:a25:6808:0:b0:df7:8dca:1ef2 with SMTP id 3f1490d57ef6-e041b0788b3mr7334664276.34.1720629419734;
        Wed, 10 Jul 2024 09:36:59 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e041a99e948sm655418276.63.2024.07.10.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:36:59 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:36:48 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Hugh Dickins <hughd@google.com>, Sagi Grimberg <sagi@grimberg.me>, 
    Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
    Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] net: fix rc7's __skb_datagram_iter()
In-Reply-To: <934ac0b8491ec56dd35b9f0ab7422daa1926c4df.camel@redhat.com>
Message-ID: <1c72ac52-9830-c2f9-5a14-d1487da8fabf@google.com>
References: <58ad4867-6178-54bd-7e49-e35875d012f9@google.com> <ae4e55df-6fe6-4cab-ac44-3ed10a63bfbe@grimberg.me> <fef352e8-b89a-da51-f8ce-04bc39ee6481@google.com> <51b9cb9c-cf7d-47b3-ab08-c9efbdb1b883@grimberg.me> <66e53f14-bfca-6b1a-d9db-9b1c0786d07a@google.com>
 <934ac0b8491ec56dd35b9f0ab7422daa1926c4df.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jul 2024, Paolo Abeni wrote:
> On Wed, 2024-07-10 at 08:36 -0700, Hugh Dickins wrote:
> > X would not start in my old 32-bit partition (and the "n"-handling looks
> > just as wrong on 64-bit, but for whatever reason did not show up there):
> > "n" must be accumulated over all pages before it's added to "offset" and
> > compared with "copy", immediately after the skb_frag_foreach_page() loop.
> > 
> > Fixes: d2d30a376d9c ("net: allow skb_datagram_iter to be called from any context")
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > ---
> > v3: added reviewed-by Sagi, try sending direct to Linus
> 
> V2 is already applied to the 'net' tree and will be included in our
> next 'net' PR, coming tomorrow.
> 
> It looks like the netdev bot decided it needed an holiday (or was
> fooled by the threaded submission for v2), so no notification landed on
> the ML.
> 
> @Hugh: next time please check the current tree status or patchwork
> before submitting a new revision. And please avoid submitting the new
> version in reply to a previous one, it makes things difficult for our
> CI.

Ah, great, thanks. Yes, I'd heard only silence (and was worried because,
although I only saw the effect of this on 32-bit, suspect it could cause
lots of obscure trouble more generally).

Hugh

