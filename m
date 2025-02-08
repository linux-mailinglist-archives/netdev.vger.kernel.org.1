Return-Path: <netdev+bounces-164292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822AA2D418
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 06:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622C2188DAFC
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 05:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E16145FE8;
	Sat,  8 Feb 2025 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evyon6P0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B317BA6
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 05:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738992625; cv=none; b=YN1EtDbAZIqnEWdJlgxkJywj31dbNlDN6rY6jrrOt9ROs98HsgfWtmAbHQ0bgWvOawQZVOJmcnwCYxeJDkgDgplgamAN2Y1YIihQu8DNDC4HjaQT8Ey+3ucMftSGaIln0iTOST82P7d4vqKFpZ0ITc5hIqIp3zLP9J3e6w1aONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738992625; c=relaxed/simple;
	bh=NC85KjVMYOVuSqG5axFXqMkfTdKBF6xXBV7PVMDv+gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrTUfT4Otiq81o9K1shfzm21iYSCokl2Qr7C/F9E88yWIraIAOPvYGR5zZSdqU6DD9+jeUIlBtHFoUXObY2UU1Etshe9uNp3KP+VxCsc72wMvJdaja9XKtMyEzniMZBjykjJVbz7cdBrugjWd6mAC/sVotWKKq0ouGD8zpKCMSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evyon6P0; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so12854225ab.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 21:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738992623; x=1739597423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC85KjVMYOVuSqG5axFXqMkfTdKBF6xXBV7PVMDv+gY=;
        b=evyon6P0TewPPdD4FvFXR1kvQpFTdTZFuKeJZwsCKQSj2QNSZ6nHeASYEvURu712WI
         DNXiZVW80WsSaB9ntiBGa1/X4KDRqU5eaDKvWW7GxzRN+QGOvapbzxW0M+REuopRA1vQ
         ppmed6eE2INkS5sl+vWY7RwxIvKF1OKPD72HRAzMBVJcQpvfjxK2hgVfga3zThjTAPiJ
         lwVCekdLeIZQcOCFwkgIxobjI/kmGWl0+QJRHBNKG4qebtfbJvihUUOTl5sFkAUvourL
         oX2qWN8GVyB/pQJoPU5Yn6EZNHC4ESg/Abs7own4/Q8a2OOiuhX90Dx6NDMhNonAWYmn
         CzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738992623; x=1739597423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC85KjVMYOVuSqG5axFXqMkfTdKBF6xXBV7PVMDv+gY=;
        b=WAisa7q1JHuIkJpe+ka+XjxjX49NBlYSc56eXytwqXizH5QA+W4CVO+yXkNmFJShXt
         MLCqw/N/HbifBO5gu3ZMswgbFP1cvTfbq/ZhroAMVNqSfNFabX7xu1C5ABmUTVhTa9PF
         4N9peb9T5XMi2AkzvAz6gS8nEBoVFtH+HEW4BouqC2bowAHrQ3xOUXeeis1Tw3utI7Rh
         wIclz4cliKXiGzkdmJcZY3C07FqX3Bx64Yp5UPKJqqXPApIRmYKg8vyCXXKSg298xCa8
         6swiLKobmthqvyrp2LjrTJm5IDk+c9PEVwvDpHSnROENzV1eXmaN724KYKgflx5QW9jV
         5LKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVExujucQwpP+L5lzKQLkiBhVjQu6G420eRKNEAgGOVsgNejDWrN9kmgPT7YzLjt2YL+FQofw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUMAlyvggRY06wH0aUqbE//9yVvfKfW4PVFeCfnn382OcHiHC
	7zxKexWqzxqXBTHwyK3WH2tWMtD62vNWzBfTrGLtCUsjy5MHHdVtSgw1USPHhwTfgazVyenSeuM
	mKe0R/c+wwHSh+4acEWNc1zSH3tc=
X-Gm-Gg: ASbGnctSq4fMCzYVjPuOZ7eEElQg4GS+H14K5jpfVd2yNjwfgXCxxrY4xLsXJ9UJDdE
	3r3GREPHEC/sdkKBnc8UYQ961Pkag6+Cez/yX7btEwNxapBu4AwJ4u5Q662C+DrQpmDbFO2E=
X-Google-Smtp-Source: AGHT+IHLZujj/11Fia9/zWvx/J02ciM376bQu714iIW357kw6lySzC1lApb5Czcvf2q62/vNgvU67j5HXQWWL1R1l9E=
X-Received: by 2002:a05:6e02:348c:b0:3d0:f2ca:65aa with SMTP id
 e9e14a558f8ab-3d13e1ad5c5mr49174815ab.4.1738992623424; Fri, 07 Feb 2025
 21:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-2-edumazet@google.com>
In-Reply-To: <20250207152830.2527578-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Feb 2025 13:29:46 +0800
X-Gm-Features: AWEUYZnSHBozsuybSPFBtVIeitwqHMESfFSuOC-BElFiUD0mvccbCG3VNfXQu1c
Message-ID: <CAL+tcoAf528b9LKUtP_SKYLsFOANGZYpwnPQNGb8k+uRs+qxWA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] tcp: remove tcp_reset_xmit_timer() @max_when argument
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Jason Xing <kernelxing@tencent.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:29=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> All callers use TCP_RTO_MAX, we can factorize this constant,
> becoming a variable soon.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

