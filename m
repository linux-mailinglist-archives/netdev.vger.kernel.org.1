Return-Path: <netdev+bounces-113080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBA793C995
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A941C21C90
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ADD7172F;
	Thu, 25 Jul 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YTYFMZ3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F02B9C9
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939705; cv=none; b=LnKMAdacbl4wh8M2tfsEDPyVy0T430VL+mwHypp8qpNfVG2nau2QGoMNbY8+kLaTYT4wEPSxoI1PcuRMUXoBLhMP7zSeUbpMOXj5u/FHPNP4xwzSu81EFd+AzlYr7z0Yhu7NUQ+3mlzi1jvsiyrbBM5a+ZLyIr76JlylZHydcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939705; c=relaxed/simple;
	bh=+hcuACSrDnXuyK+3nXy13Q6NsIAr/YWO+OR5khRNjm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSXVNGS64oAq4gEVBkeHp0j0ykOUIS8mD8ZuoKJJ3NWG13uFqJP5aVk4DAmR4874Q4kaugRXBdFtTPmSauuaqEE+psh1RPsv5N43ePtBR1/1s1VD4E3hwz2JXIOZ6OYRKmprlzsAk4MacI/hc2sbwRmdTp0+z5hxBby5pM+jM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YTYFMZ3c; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efd530a4eso862230e87.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721939702; x=1722544502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTSgE8O7VMPCTD7fk8+6qaxrJiw/VS+rTSm4VMUyc2M=;
        b=YTYFMZ3c3gf56lfxm869KK+1IESMInS+OqGssJpHdDdLTeQ8xqPHG9J+zmu/GhYT0g
         Fv8vQesdQHkSO7b2ndGAvltDJyZMi05WiVWZ+fnSmEDnRUs8Rd6ah353W77R1IHf6Xg0
         dwvDCZc04nfEQkHHYbpe0QtbknW8nSKIx/A/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721939702; x=1722544502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTSgE8O7VMPCTD7fk8+6qaxrJiw/VS+rTSm4VMUyc2M=;
        b=sV9lvE1YoSSMOjOLAT7h4NXdFFDjnbGiMd/OjhHpa9Myl1uGJUY/sYnrMNqlHOp8Ap
         qyW/17JTpvI7hKZD6SGa9otH8H8UJTWE3Afd//uPjYvRQ6//6f2Cry/Bjg4vBf7lIgKy
         vgA6u4QvTQq3s+c36wqkXqEZOK5Wpa8vmZyTLLuq07IFaStVI/CnvXGzpWDK/O80OsZA
         UZ6zyYQvxoM8jXmatGQ1g2H/y0H3GvzSkBFO1hrzq3+9QCg6AemAL1t4ilQtbQToyObj
         VFwooJQKEUZLwhTkNehxVWMirQ7PVY7TxSLUrYDZdwidDhphx93Ui/DWVdhcyiuvNSx2
         /7vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkyz0r83yAE+Q68Pxt2q/xAsVD6ydDkA9FOV3Mg9yy7K3skA/CB6v8wF5vKeznnLOp5IFFREvqg102d3xYtV4mATLe5C3H
X-Gm-Message-State: AOJu0YxzSFE/1Bjtqce4vIjE8f9OPTW5g60bkhNlxwG8ebd/oSa966g+
	De/Qm5SeF7CuLWkC3oLtYJw2nRU5j3aF/KEFWD/AoAv27qWaUd5Yhn1L8J5xVMa4ZfRNwqt+A6g
	56SE=
X-Google-Smtp-Source: AGHT+IHv7HqCRzb/boLkpwRCP6+DZTbnVYZXuT0zW1BEkQtxahS8kqOAuDSejRyW9niX/rsaoTlYNw==
X-Received: by 2002:a05:6512:304b:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-52fd60f4f14mr1930448e87.47.1721939702178;
        Thu, 25 Jul 2024 13:35:02 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc3f1bsm311790e87.1.2024.07.25.13.35.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:35:01 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso7015381fa.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:35:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVREu5HDNHPugkCzBuaX4/Jom5OfNxX6i8LM/oeeS/Pj8Hyriw5H8oxZDHbigXprIcg4I3gPQph7Q7kV6UkAGsZSTzyUwgC
X-Received: by 2002:a2e:91c9:0:b0:2ef:2c20:e061 with SMTP id
 38308e7fff4ca-2f03db8e45amr23043301fa.22.1721939700903; Thu, 25 Jul 2024
 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725153035.808889-1-kuba@kernel.org>
In-Reply-To: <20240725153035.808889-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:34:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeA5O8i629FHxHmrk=5WtD41cA67paUNBxMH1ooFBgFA@mail.gmail.com>
Message-ID: <CAHk-=wjeA5O8i629FHxHmrk=5WtD41cA67paUNBxMH1ooFBgFA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.11-rc1
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 08:30, Jakub Kicinski <kuba@kernel.org> wrote:
>
> A lot of networking people were at a conference last week, busy
> catching COVID, so relatively short PR.

.. and here I was blaming people being on vacation. How very insensitive of me,

              Linus

