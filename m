Return-Path: <netdev+bounces-225510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48ECB94EDE
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21A21888A96
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D23195F4;
	Tue, 23 Sep 2025 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYN81oar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53BF274B55
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615022; cv=none; b=apaGFJ7enI6yL2ldkupLF50qGgvc5udlRJYU/+9cB1IxdGCHCh+V5wYkszH42sJYRMRUBi2h7TurXKp9eJzLb3Mv5B3r/pbMjKKeZ1I1kSAqGse4CiXtRwCXTQUfRlOqd2oxAIjdl4t5ws4lbPU0eHAgiC+slRP413lcbhHp8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615022; c=relaxed/simple;
	bh=gC/ISLcvgB5Jm98EWNWSo1XbAxqmIYCEt3c+pgRRgAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=stUWFwUbdEZq4+ajOWsEAEJzZQNNqPe2cki55kHI6/KDz4AUsJkzIZowQtlutLTMiR1zxNnbUxVSG5esmCdsfmwLo+6lw9zas3DcYreYXo77qBbch9W609qlU5wtzjvpG4aE41EDg1HON9BpomCZzTjgDpCcswSuULz3We98D/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYN81oar; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-74435335177so30681347b3.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758615019; x=1759219819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68cmCK+lQ0dZ83mmbfpjA/lSPPyrshuXx8pjCum4+fo=;
        b=HYN81oarcXYP2nKg5wRdgi9PVXQM+C7tdma/5dQ8RoKafL5+4shG6zM/m2+JLbtB0o
         Z8VvoOa9Az1i+Cqx25sEJxa9U4/SlEiZzrOiS/iKLuJeCHev7SfJPwz/Fepqv7rRuTbh
         OWwSaUcs6vEdszfVqLnpljv/LU/O/3vCROVeTxo3UKzbITyyNYEK8uOSVDgplrrRWr7F
         R1Amocs2zg2GwNSgAhUbRmZpb1FvhsJ7dFp7NAS616vdZp3iNn1minwmMdX+V8rbUnys
         lJrVSpVgekD49UJqsa1SLSN0UcXlATmFh1fKOxA9A4cGqKsTXEzxSdO4zPdmVVrqXdrY
         CIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615019; x=1759219819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68cmCK+lQ0dZ83mmbfpjA/lSPPyrshuXx8pjCum4+fo=;
        b=CP3Gn6uKuGmVawYn/+YJ3jn9czOCaEr6wUGhbFDNqq3YAHsI9T+XJLsFmPGes16EhC
         NRfNERyncMWtew+fLHBkndA7aFp01WetJkjY+/OtfqySU21S2CBsalXRoBHyyomJcWWw
         nSNpd/aYpeeaslLa2Z2zyF992wTdHzldXw6VsG82slZ8gfIjTeB2L1I01Ht/WJcSDonH
         iIJeDa108VTbTWSsllDLO2DNkqcPLuWSm33OepL3yue73uOA4DyOGmqxhpwtXpnvW8le
         fB/0CJAEuQkye56PNS8lmX6uiwQngL2eEbgtq4aZ2dvBGUJ3m0MrGCGoIY0pvf/pOXgj
         bU1A==
X-Forwarded-Encrypted: i=1; AJvYcCVlDfEivqKPrGSoa/p8B+tP2/64z9W5+bzLFeuuJKS/mH46/JuTIe8TtfMt/SkIowcKv7VHV/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTh6Elqu6S4MsUa+fdplOp4Q6LHnIFv8BIY9xdQ/90pQAmG+L
	Jn8WLZERwmAeknrN9OiDPmTqEQWbY5UN70+lw3vNHCDMMwOGGcMKIjAA0hlF2ffIu/tKCCiCR3n
	1q7a3EjbBgFPlsL7Ee4j1PKpYjHWH8Xw=
X-Gm-Gg: ASbGnctD8InA2jYpwNrmSAWPJAqsMt6+/xK040AOuLolFNrHwUA1U4mKZ2ra5Z9gC/o
	Ufvj3XcEA72I7KJkBxCSGVGWV9HEptZuSRKxqI9yUTdCM3VDo+voek15vdfmOQFCZZAv6gJbFq0
	EIxpeYz5IiSiGtNUfculmtp9vI9rVrdPCfd9rZ0mW2xfEK47nrS+EZY5Lywj4vSm3Loy/ChEfN/
	i9LGCgkKF4Il1v9phhNsh7i+gIySHv51iqZ2Cb/gxjHPOc=
X-Google-Smtp-Source: AGHT+IEy+xvUqkVBZTsI7rKfFC4qJQsZuCAek2QZZLHNwQb10WCpz153wUiVWQTA1TtHdluPaXcrJXcwNTk+20jLli0=
X-Received: by 2002:a05:690c:868e:20b0:71b:f46e:691 with SMTP id
 00721157ae682-7589155a662mr11239417b3.11.1758615018549; Tue, 23 Sep 2025
 01:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923060706.10232-1-dqfext@gmail.com> <aNJINihPJop9s7IR@stanley.mountain>
In-Reply-To: <aNJINihPJop9s7IR@stanley.mountain>
From: Qingfang Deng <dqfext@gmail.com>
Date: Tue, 23 Sep 2025 16:10:07 +0800
X-Gm-Features: AS18NWC_W7OBcymaO0pGhN8pbXiCoKSVhciGuUrFqWsXt6IDIMeoR1I3bHZLZf4
Message-ID: <CALW65jbwmP+Lms7x2w5BDjFdg_d2ainorAMTWmR_6NJmjV3JmA@mail.gmail.com>
Subject: Re: [PATCH net-next] 6pack: drop redundant locking and refcounting
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 3:11=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
> checkpatch says:
>
> WARNING: Reported-by: should be immediately followed by Closes: with a UR=
L to the report
>
> Which is relevant here because Google has apparently deleted their
> search button and is only displaying the AI button.  "The email address
> syzbot+5fd749c74105b0e1b302@syzkaller.appspotmail.com is an automated
> sender used by ..."  Thanks, AI!  I can still press enter to do a Google
> search but there are no results with syzbot ID.
>
> I can't find a search button on the syzbot website.
>
> Ah.  Let's check lore.  Hooray!  How did we ever survive before lore?
> https://lore.kernel.org/all/000000000000e8231f0601095c8e@google.com/
>
> Please add the Closes tag and resend.  Otherwise it looks good.  Thanks!

checkpatch also says:
WARNING: The commit message has 'syzkaller', perhaps it also needs a
'Fixes:' tag?

Should I add a Fixes tag, even though this is not a bug in the code?

>
> This code was copy and pasted from drivers/net/ppp/ppp_synctty.c btw so
> that's a similar thing if anyone wants to fix that.
>
> KTODO: remove sp_get/put() from ppp_synctty.c
>
> regards,
> dan carpenter
>
>

-- Qingfang

