Return-Path: <netdev+bounces-81404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33E887C57
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 11:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9077F1F214E7
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E5B1759E;
	Sun, 24 Mar 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enStB04y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3E33F9;
	Sun, 24 Mar 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711277302; cv=none; b=gdPUYnD8rTUfWhuk+cu23t3p0u1qADx8C0cfVKHCT0pe1cZ3Bgw9chq4bWwVxGnRkd4SYt+goGqnLgZep40XAWN4qKfET6ZW56VjHkJXAB/zJMW6RglYfKLOPXFnDi0ld0MTYDS0gMBdsR8wQN6c6rwok72LnHTgt/sMd+QAy0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711277302; c=relaxed/simple;
	bh=v7QorXHTy8eSgnn8vNcv3KmQZBNZocGHbaM1CnLhWGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbum8MWnB1jum9guJPmmQz3BnV/ph0iyy1FTi/GHHZL3LwCUtv/MvyhzrKqhulwGX2jL04mepABROdDDyxIFbzVxCW/pCo3q9e4TSu3ONUSEli8rgXB5WuLOtN07scU3OYErVI76yC6oUHYL/jD91KG2Ya8XM4exj0cTZlW6YLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enStB04y; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dd045349d42so2933954276.2;
        Sun, 24 Mar 2024 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711277300; x=1711882100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7QorXHTy8eSgnn8vNcv3KmQZBNZocGHbaM1CnLhWGw=;
        b=enStB04yvcuzejw/Ith278YcA/j/bpdaWlI6mBwzLc/thtmdpssSIN4pHAT20ovZdg
         nkEZoGzuvZm/0AYt194LuFgwSRetqfQiI6CzkTdq3+Jq8n7HRh1KK9sEnmtZ2Qy2W50p
         AHJ3auRMlnnz8wrjIvD7Di0BYs6Jbg+nmbzO44OdC+ZgDb1rsFooZaFGNbVuapURMVxj
         L8y77aoI/Wli0WuzN1zg0mttvmOReRT1JjjB9emyLkBT0inDAcxvRQOGpDnJrybAIUnQ
         FvFNxAxaEvwjIR/o1mYByNmYEIoH4HiYCCFLWxYGUVz4ZkBxQkrUm8mNPXiAJfexTBCn
         lkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711277300; x=1711882100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7QorXHTy8eSgnn8vNcv3KmQZBNZocGHbaM1CnLhWGw=;
        b=Rv/4zKr6+uPMp+urXzRnbh6ExHRXhHIIQWORzIxW4rMMyAvNit2wOesEA4iLJKxhMl
         aC/Aa7atP2Ys9In86ruft3IBnadxIda03k4wyTSnJjBv7kEG/SnhUx3xKd/g3QFuGfX/
         2o2kLAo5GSc/RtolZcrt4WhuayKlsnnA5b4AK/NwZhFzqbDu5FFpGkfdImBL0ltOkKyn
         NSw3b2oSvdD/G6xSkSGXCDtc9t5qJiSBpIwJk0eYqw4tlvM0yriO9lOZ+fJTcoewdpWp
         daCgOldTNyDW3vFzP+hkfDI5SWJPZZGNN8Fu2WeblwgZ8jIKDtgv8bJzoS9gTXiVmKkc
         oyMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeoB8tpNhHjbNVyMoJcyRgYjQBh+tish9xYjXC7NAeE46bMVQPpH+pUXUkvUIW/fLzZgNuPise6KsHSkfUxbop6F6GW0RTeCGSAtlR3vfwUlajJT2NHQQfuPBAw7mIf7mD
X-Gm-Message-State: AOJu0YyznUjVplz2PlJgVuXxml+NhOVo0a7txNOIQ5BtbLRMhFNIr5pw
	JUr/WBxEZdMMbk7/S8U5GeLXwYaxyG9yW0/tufv/VnVK6B5ThMYy6I2XyUYyjSxC3SPcHPskRLm
	Ahvp657aP7mCe7unsoBal69vm2T8=
X-Google-Smtp-Source: AGHT+IF5yv/TglCYht0GlEF3g1XXh2NNxCAUT6E0SrECu43ZqSZ/Uc4PZ00ezMcI3cm7SJ0+6UrTwLP/iBanEvXshDo=
X-Received: by 2002:a5b:8c8:0:b0:dcc:56b6:6606 with SMTP id
 w8-20020a5b08c8000000b00dcc56b66606mr2659553ybq.40.1711277300256; Sun, 24 Mar
 2024 03:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323081140.41558-1-bharathsm@microsoft.com> <20240323162956.GB403975@kernel.org>
In-Reply-To: <20240323162956.GB403975@kernel.org>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Sun, 24 Mar 2024 16:18:09 +0530
Message-ID: <CAGypqWxS=0RjYHgjovyS=us2YCpOedT4Mt3pLkkhVmK8UsVbmg@mail.gmail.com>
Subject: Re: [PATCH] dns_resolver: correct sysfs path name in dns resolver documentation
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	kuba@kernel.org, linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	corbet@lwn.net, pabeni@redhat.com, Bharath SM <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 10:00=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sat, Mar 23, 2024 at 01:41:40PM +0530, Bharath SM wrote:
> > Fix an incorrect sysfs path in dns resolver documentation
> >
> > Signed-off-by: Bharath SM <bharathsm@microsoft.com>
>
> Hi,
>
> There is another instance of "dnsresolver" in the same file.
> Should it also be changed?
>

Thanks for suggestion,
sent updated patch with subject "[PATCH v2] dns_resolver: correct
module name in dns resolver documentation"

