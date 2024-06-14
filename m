Return-Path: <netdev+bounces-103537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CAA9087C1
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39F01C215C8
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3B192B80;
	Fri, 14 Jun 2024 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEYuxDYT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAF192B7A
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358194; cv=none; b=m3ckV+wcSmtS+Tr2bB4b183M6/CnQvDvQU5vt78CjoVR3r3YmX0b9+okn5o7qiofEfJS3O5s+6v1fMcyTqW/7uUz5lYFUEnT3Qo4vp0e87UilBpp8a7EGcWIzcfNI1xUOKhnrtPD8duvQWZZ6z3RNh4Z0dzOQNygTIHU5/7XY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358194; c=relaxed/simple;
	bh=tLQgAiSqIKd8Fr/cSViZ1UALzCWG3iDxmInXrEl5pr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilJoUtqtwkL+a/BHFPK+Z9SueWjzMDwpP7fO/5WuCuK6pNt9Q/b8rGLKOwFAxK445nUjGFtiDwuE7aKavUUHxg5KBACH/5wATMyhG30stUEcSNhMaFiI4JWkuxUHtrwxE0fCK5BbZqPsbBXbTigT251NVJSxuYiZFGbVCPhGQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEYuxDYT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso12643a12.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718358191; x=1718962991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLQgAiSqIKd8Fr/cSViZ1UALzCWG3iDxmInXrEl5pr8=;
        b=mEYuxDYTGkcb+LpOwFZdoMmdKeAT0qXZBHdA7gW3HmyuQw1EW4yhXGppW+jtels5AK
         sUCMTpKZmYgc70c09qQmkMPbr9HtHfwxiMsSKHM2ha1Y6YnVC4lSadtgAL6U9e/k83Bh
         /nqRbDgxBns1FemuLtBm0ZeokLXTl4Rt8aBqjlNY0I+tOveot12vMaJySH0yPVYzJu1P
         EWI5nLqADRfWwNOXgAM8aLI23ymDpwzsoFj4EGhONJ9991YSPd4VR0WgUljDC/u1zCGF
         g8T6mtNo1PTP9b+ldD7DtE4CAjOV6vxqoQ6NSSgHkkxrXVrEgP6RShxSseXbXCoWC3CM
         n3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358191; x=1718962991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLQgAiSqIKd8Fr/cSViZ1UALzCWG3iDxmInXrEl5pr8=;
        b=ws8Afpkf4SpnDXN1einK5rKPBSyetecsDtWf59IFd9p4nPFpQMU8/JhrsB8y/ZiXiD
         Mgyo1N2eMuVOejMuSn5FylejUt5R6qPS8soW9nvq4k8Oek/7gyfu5oOcyCZzMTDveo08
         QTEd/p/YSiXrrCDLjNXHo0ZICm9DEB630nSx+P1YQBatarpnRKqPMVUmNM8T0OH0XZ/L
         Icc9Wa1pieWyl4E1a1bTFOEf5cAbHxDombF6+/0g3uTNeZOT1JSaFdU0Vllz6i0yO1aY
         FBPavvVzBNgNYz4CdSs2eKz5mxynaaqA2jOpaDFz0RL5/j5obZnLxA3eyr+louW+AWpe
         ZbiA==
X-Forwarded-Encrypted: i=1; AJvYcCVE2R5UVZFjcyqqDrsLweaYr12bghfa/UijBgQKJD6LVDxk9yiqD3w8e566CTSDrFTta7yeR+SzTJXBMazWYQ+AEFx3Dcx5
X-Gm-Message-State: AOJu0YxkDdCitrnF2ptgLbxwio4GEiZafRdltcIAdyvZIsyBZ2p1P8ei
	oHqtQCMdF/BCk31TT0gey1klbY5pmznNMeLmyV3pZ+s7wT1HCHuIFSRcCFWB37c/WuIuqdxnLxK
	K42JVYDVcuKh0DBSnejLbM0+lsTpWW+pjG9Jx
X-Google-Smtp-Source: AGHT+IFvDUJj2XIdgBgpDYCy46upILTWlHhD1AvsiHaBR7J8BVYYLQKdVBGYSCjJmIzXS9M7jGMzR7holN3E0CkL1bE=
X-Received: by 2002:a05:6402:4301:b0:57c:ae72:ff00 with SMTP id
 4fb4d7f45d1cf-57cc0a85d52mr107336a12.5.1718358190869; Fri, 14 Jun 2024
 02:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614092134.563082-1-thuth@redhat.com>
In-Reply-To: <20240614092134.563082-1-thuth@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 11:42:59 +0200
Message-ID: <CANn89iJafAvVot3_AgGGj8pwc6FTRMkZ2X3ZqsOV5J_XDSWPQg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Remove the "rhash_entries=" from kernel-parameters.txt
To: Thomas Huth <thuth@redhat.com>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:21=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> "rhash_entries" belonged to the routing cache that has been removed in
> commit 89aef8921bfb ("ipv4: Delete routing cache.").
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

