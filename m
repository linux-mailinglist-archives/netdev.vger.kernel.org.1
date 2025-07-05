Return-Path: <netdev+bounces-204318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B385EAFA126
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F301BC41AD
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3B9212B31;
	Sat,  5 Jul 2025 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCFrurRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4448134A8
	for <netdev@vger.kernel.org>; Sat,  5 Jul 2025 18:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751739550; cv=none; b=cC9ESmiVe6TsI0agrMwzJTh7R+db8YDOfZELyLLlyTmfEcFhwySQqVzoD8PoZxTYY19tbagjUywwx/eF+/2IHkH+vshq7tXmldeaMg69HiifuLAwhPJhOgInATSjGwA6UDiyqsVu1gajo4o6LOoG2QvNFpcm0eRavQ6JhW+WHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751739550; c=relaxed/simple;
	bh=/SmLkSLLzKeVDP7Cvme86a74M//CZrJoxpLpziodCD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chmafj2Lm7zgmVVIgtlwTQt30yStobtEFE3G7jweUMP32oNgKxIb4f+XUxBg0KojjwOBvqNRTcv2StoHI/X4JniFsh01Wz12mc7b7BRopb0mnrF7oF0H6efqA0Br0PvDrF+p7sNPRImIUe7xQZwKIKpM5zpwBv7zt1BEnq2zwVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCFrurRN; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-884f2b3bc2eso281906241.2
        for <netdev@vger.kernel.org>; Sat, 05 Jul 2025 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751739548; x=1752344348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/SmLkSLLzKeVDP7Cvme86a74M//CZrJoxpLpziodCD0=;
        b=QCFrurRNR1wgg7g91twlRx0k3dOm9VfvcHzFITJqaRkzYKtGrzjOFXI72jpniDnlrU
         vA4EqjNi2pMCMbcvC7/dOA12L64oIZc6nYEIcOfYCNi7rwiY2QV4vU7GZOmTDC9uJPcI
         M4tEr2Ntvwp/z9h8mFVXRDh0JUgI+d3rJ0fwlEc0ueVJ4JE+2kMpwzZz3QEA/bWDQal9
         9MGE2ofYp3CS4bMm6PjxLDI9KRf01D95qVkphTm/FuCSJCeyDCoNcqOTUZ/Hkj/so8fE
         uYnd+8KKgqppnzVjuZL3mypft8QKNb3lbiRV+l6bs4AupEMkYhAXPyazfuIrwWP5+pNI
         pVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751739548; x=1752344348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SmLkSLLzKeVDP7Cvme86a74M//CZrJoxpLpziodCD0=;
        b=dzeVlvcLDTRymScY40rT9InJpvvmR6yrkbbG/L+tcdUMV2RGza+cd7K72EOmIONHbH
         SExNblWZ3IQRdojPHSdIK1Lf5mrRLQwxpn5VA9nWVe/0eY2vs0UBPnA756GvQn3OiUPK
         /XLtgzYzGjeoQv+PoMdB6Oenh62gR+0sjqp4PgzAHYxL+dZwlaEpqasblzSd1DfX47jY
         7GYM9VCZaMyiu+wgkfMVkeGBQPzywS6QyPNWqoCjjkd+vvJelj/CMtxdKOgH0fOFR2s5
         IbFnmQCmnGUwZoix+I7Zwr+fNtlv7oJAYeBc2fGuyFQO4M2rz4bAmDLDEdazxR1mMPms
         CakQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9nqn0bCaBHNtr4dEa/jJHR9Lbv4bN0EtqO5Q8YXZBTv0D2eb/qzlOu4rYun/hWjDk51Kk8jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlp5X1QtXqzw6riPYH90HA8Yg3vM54giv+FguDYVELXdGieiu9
	EOiVNYpwHHYb+Q/k4DFtedH89ouyDQp6yUpUWNZX+sL0dM5SJAgLQCsrAM67LQwwflJuUl5TbGL
	Bf4sWxCO7Kk1J5U2CauXda9xXfUZOPZk=
X-Gm-Gg: ASbGncu8RodX3hViahtkVhEbenwEIDs9JawjGyCrgzktDO4D8fMnKZgZ5vCelfVqyxb
	hHayKSIcWSzFQbrne7Dvr36qd4C2wxiEwYRWgPIT9H3Baw/gsFXWe5gI65YhW36bIRiqNXFZhQQ
	vqwwJBslCg2qFgSQoIYtAg6ilZ3Gjw7kuc/v2yFQ3eOPo4nJ4X2VrpwAb0yWiM/CIu/yKoLOHu+
	vVA
X-Google-Smtp-Source: AGHT+IGW/3mDaE2WnD/gk0j6hfYQAdnUFBVj+aVjmMm6t3a2YQlud9TM4v1IrqO7qUy/zqfSjEsnAimUUc4EGgwe9rM=
X-Received: by 2002:a05:6102:2922:b0:4e7:f3d3:a283 with SMTP id
 ada2fe7eead31-4f2ee2bc326mr4682201137.25.1751739547671; Sat, 05 Jul 2025
 11:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627042352.921-1-markovicbudimir@gmail.com> <CAM_iQpVm66ErGcm+WriMSoudh8-XYt+GiEH48b0un3G9vpA=oA@mail.gmail.com>
In-Reply-To: <CAM_iQpVm66ErGcm+WriMSoudh8-XYt+GiEH48b0un3G9vpA=oA@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 5 Jul 2025 11:18:56 -0700
X-Gm-Features: Ac12FXzgQplEvvoB9Jv3iqKiCoNidf_icgXFLHtp0A_PnYWoWLP-esWItuVQUs0
Message-ID: <CAM_iQpXW2fSdQOjXDufv8DYxGA5fcPVEzB8qrphLHte9XeT8xA@mail.gmail.com>
Subject: Re: Use-after-free in hfsc_enqueue()
To: Budimir Markovic <markovicbudimir@gmail.com>
Cc: security@kernel.org, jhs@mojatatu.com, Mingi Cho <mincho@theori.io>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Budimir and Mingi,

I just re-tested this. This bug has been gone after Lion's fix:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=103406b38c600fec1fe375a77b27d87e314aea09

Thanks!

