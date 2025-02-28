Return-Path: <netdev+bounces-170820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A41A4A0FC
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A1D3AEDC3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C91C1F0C;
	Fri, 28 Feb 2025 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ludKupI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A681C1F00
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765300; cv=none; b=cQqnH/JhzmU91Qs5EN/eA3C6XLL8f4+uf7Wvk3Y9vFRIZYpsg08ymBvhgMCjOKCcTaEs8r4uNpLi2uWkVAvhZbRvCQhPRlZby98Tunkrk6OM+PZd0iBZLWBGwMOPZ70qkQKITPWPQcCcdsr0oSIOoik7dAVXOX80iOXljfWgPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765300; c=relaxed/simple;
	bh=qIScX6G1RamoApJoGxvhjX9qSLaNfMeqnBIhg09ZUm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ui5NmBBYqfO551HcWUlbh5TSECgt0jUG3yrp3knzI1fY5C0wkFw5btSkSty7bPjbPdJxpNG6vt7IrUWXVfQMihRGnyeihRo4O8v9BFKAqgQEgpIrCE4HxjhnuIjN6PuyhPp6aaP65FPTLeYvrcZwu6nP41Ru0bwA4la/lqQbOHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ludKupI0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2212222d4cdso5145ad.0
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740765298; x=1741370098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIScX6G1RamoApJoGxvhjX9qSLaNfMeqnBIhg09ZUm8=;
        b=ludKupI0Hrz3eJdi/NFn8tBtF6EvXCgnlcMh7cfVLPag9bIIOWe8UuuaARjH4cHk0p
         jS5bL8M2K4vROl/XOoy3rRMl0GcqJumP7Q5TvCJwHscVwrqQaWhwBVm8bJIBN5XSYOJj
         XMa8QB1cvAklysSf4Nw7q3aYqztoxPCDuH+MlA7rXo+pxMwZH2fRNhQHfVQPDuwkF5dN
         DkBnARoHw0/JxN0t3PXS5zzwLuixjGsL6r5J3QxSXhtJchywXmNOP0Mu4ofIBzycSuEb
         BvrgV7XFd2AlrAHe3kB08biEmZEcKnyM5i7LxDedrsxR1C9IzhbUxJVFetq7xkjBtRgx
         bGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765298; x=1741370098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIScX6G1RamoApJoGxvhjX9qSLaNfMeqnBIhg09ZUm8=;
        b=TGtjkPePNZn+sGLy38V5VcmEo4dvYvvKYnm0RCNkCcRBUU0YHSrcYhqpakkEY/LSip
         V2V3pSqpB393xr/AqPOVgwGtlzMWtyLdnK18JnEC5n7cuQefXvcaabsSxBcMFUasnoRP
         dop4HOzM9PfqAVygKzj5MUM6LzFv8Swm2IcOjhJNBNIZKIh9v6my6Ar/LfAqmrllrnlr
         FPuqX0YkpIeC0CJjQCgx00UWoyhsOuWXVhbbSERK5RpF+KkzPg69Czdwd6L8mhQ4EXOa
         SMGsDdzuDOKvmT/aMjhS7K5ffshXbCj5cXkOAoxDokNIUld51iibgId7xTzDQ9wwYXCp
         qAkw==
X-Forwarded-Encrypted: i=1; AJvYcCUm3NQswtOBlo1Vf1YRvkzcwQbBpmEXuDSR5fJnxSMWEGTrsueRwgix7xskPJrmug0igQiOevo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfUCGB/PxgXsFpW0dMAIQaeJam4PmBKf/Z018tfCB3/lOkpMkj
	AVN5qxtW7m3mMx0bWRJz0KgdSAOsD2Uwf0gUbwf8W895WmdXIxMHaKIluGkVsNxhfGBtFs72M5d
	wFx5eKZ5Ebakq+oxkmWHkDVvGn+fg0XxBEkvb
X-Gm-Gg: ASbGncuNBQ+EBCm2WdbjQT3BpKjg5doqFWQoMjdGOA6DpihDfmNp0cucfzNoDKJxfmP
	UlifzdEEc0qBVBjs4G1+83/alKW/RuFdL2uBCnidbCpN4V0D6+1XPRDVFx1VlYiLeBuxR1QZ6IF
	Tv1COgr9QPBhy1tWnar+i7DC32BReNd2F3yIUoiw==
X-Google-Smtp-Source: AGHT+IEQOJWoiHBLlY+OBSp+FfF2e6Vvh2SlU9XLXoOwfdT2K/cTBUorvtZo+79hZ09+O0XxYsR/0ZRUmHyHP1hbkN8=
X-Received: by 2002:a17:902:ced0:b0:223:4b4f:160c with SMTP id
 d9443c01a7336-2236cfd6f1cmr2562925ad.27.1740765296313; Fri, 28 Feb 2025
 09:54:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227131314.2317200-1-milena.olech@intel.com> <20250227131314.2317200-5-milena.olech@intel.com>
In-Reply-To: <20250227131314.2317200-5-milena.olech@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 28 Feb 2025 09:54:40 -0800
X-Gm-Features: AQ5f1JrjozivfMV_vs3SVqKxqI7bRsLayto22ccQ2rTXKesMaXJ_aBDF_IkzwUY
Message-ID: <CAHS8izMzi5G_tQW2h7RR2vvyPLwRV7vx-DQuPMnRypKCmh+x-w@mail.gmail.com>
Subject: Re: [PATCH v8 iwl-next 04/10] idpf: negotiate PTP capabilities and
 get PTP clock
To: Milena Olech <milena.olech@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:18=E2=80=AFAM Milena Olech <milena.olech@intel.co=
m> wrote:
>
> PTP capabilities are negotiated using virtchnl command. Add get
> capabilities function, direct access to read the PTP clock time and
> direct access to read the cross timestamp - system time and PTP clock
> time. Set initial PTP capabilities exposed to the stack.
>
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Tested-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>

Tested-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

