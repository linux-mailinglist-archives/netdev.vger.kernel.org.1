Return-Path: <netdev+bounces-135748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F72D99F0EB
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52B528318C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712D51CBA1B;
	Tue, 15 Oct 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6yYxi0C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6C1CB9F0
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005671; cv=none; b=hk/6/zn/asP9o/V9PbdZcl9yhERbiivhBkYY1pQqCVrQC6zKAHW75au2JQaI7ybsSgvlkGuox9FmvW0qYHLUVM1uYsaKXv1Ryow9eUrfyV3srVs83xKlqBv/SRKpKPimzB61GOCYEJgbQkiu9WtEGoKuKDbkhiqYzBldb5dp6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005671; c=relaxed/simple;
	bh=DcpXe0rDKDGHa0cbcPjBzn88kBgoLehqrzdUH0t8x0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtGPEbrrA7hKeLw/W8hv9sHk8sgySOhFS+5HMhV+q0USTrs/O/XCu9fhrfjTZW2tHSv3yCMgE/i5L6iJsPvJefbdmc8/mq/u3uYz7SupwP9Qx1oluoW0H7i0aNFreqGKyQ5HC65Ktn+u3IH1iEnz2buDg+t00fBLR+8W5KdLcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6yYxi0C; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a993a6348e0so425837466b.1
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729005668; x=1729610468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYhhbcR1Takf0YpFPAeVQ89eAuhMKlhCQIC4Y6jSJvc=;
        b=k6yYxi0CvMyldIANmJw2ixRta0efPFprEKpNqFI/f036dDn4PCTLMTOLMmjFdzRFp+
         UGi1tAemzMFF4Ke2zjqSsW9k9OqBC3jkpI1CXVcp2Ipr6FeW1pLO1qg0EmmigURMYunh
         GRVhEvlfCUfUn/qMBGoDyUOxLtKlfplh8HDNAlmeHe8He2Cy+1mewHJ2YhngX8NM0TJK
         XRvu9z4c4G0G+a49IHqwqUuUr5GPzfNDopw2wOGCDCUFt4F7VACswwJ5XuVu7xB90xCV
         IT69ZSnGhB8s042vRp/i1jDVRrHgfAiQ4UxgqGZpT+e27zEm5TS/EfOIHr1YBAyWBViZ
         1W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729005668; x=1729610468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYhhbcR1Takf0YpFPAeVQ89eAuhMKlhCQIC4Y6jSJvc=;
        b=W7naYyqyOm+FTxUxnnR/n3+gxaU4bdzzFQxM/IT0gUBco8sGUbiUBeLjLeeFanZuyV
         U7BSA56mdOwSE2SzSqss63WPgpy1mVWGDnjxrMAYRLmm4B4ok39eKKi5O17N36n99u2u
         ngma7PfGQzgnAM91CTqhute21WpS575lyAJHBoCeSeBTlRKFxK82U2ORsBLbLUl1V4Ls
         v3foyH+e7m6G/tr+KwMInACR0skBZX4x0047fbJVn5XeTtTDPsc/XS8W40belQC37zgI
         PY0yu4EGqcHnW6GdaCVPLbXNzlynKPkzZ6n2fQWN2bOLqI7dyrPnrMFuZrgT1NF4d0M9
         kGaA==
X-Forwarded-Encrypted: i=1; AJvYcCXqJqMc7/5ulAuYn/2acWRG/TdrCNKgtlEp64BZo7AGUyN2EoLj9XWxfO8bOEgh+usSyXaKzY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjqhxHFXRWG/6Q4tPwRzfS50C6cZuc/za5KRVGq3BMX4TkU+z
	e0GfKlQtF9IGWJeKzJgHfMQfVKrZJs+6zq7rQRlAcMeayw/SfeOHLONPVLUBXiaff2zs8V8mouf
	CpriA0nbLmBi/bSnT1LoH1AS4FCXlGnfqDFK9
X-Google-Smtp-Source: AGHT+IE8RQoQAaRaQqCr05P7KuLClpFxNUSz6wreyijStOyA7RkSKYlSxaijdkZn8mr1tJmV5CqKn/25SIPok5RfhqQ=
X-Received: by 2002:a05:6402:40c8:b0:5c9:34b4:69a8 with SMTP id
 4fb4d7f45d1cf-5c95ac09860mr17739267a12.6.1729005667756; Tue, 15 Oct 2024
 08:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015151045.2353801-1-arnd@kernel.org>
In-Reply-To: <20241015151045.2353801-1-arnd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 17:20:53 +0200
Message-ID: <CANn89iJCU7trenNNozL3quNDVZHuqDizF02N+uFbmE9kunuVeQ@mail.gmail.com>
Subject: Re: [PATCH] rtnetlink: wire up rtnl_net_debug_exit
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Arnd Bergmann <arnd@arndb.de>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:10=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The function is never called, but causes a build warning:
>
> net/core/rtnl_net_debug.c:125:20: error: 'rtnl_net_debug_exit' defined bu=
t not used [-Werror=3Dunused-function]
>   125 | static void __exit rtnl_net_debug_exit(void)
>       |                    ^~~~~~~~~~~~~~~~~~~
> WARNING: modpost: vmlinux: section mismatch in reference: rtnl_net_debug_=
exit+0x1c (section: .exit.text) -> rtnl_net_debug_net_ops (section: .init.d=
ata)
>
> Use this as the exitcall as was clearly intended and remove the __net_ini=
tdata
> annotation on rtnl_net_debug_net_ops to ensure the structure remains ther=
e.
>
> Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder for ne=
tdev notifier.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This was fixed with :

commit bb9df28e6fcda6a96860e7b77f3912ef50e06793
Author: Kuniyuki Iwashima <kuniyu@amazon.com>
Date:   Thu Oct 10 10:24:33 2024 -0700

    rtnl_net_debug: Remove rtnl_net_debug_exit().

    kernel test robot reported section mismatch in rtnl_net_debug_exit().

      WARNING: modpost: vmlinux: section mismatch in reference:
rtnl_net_debug_exit+0x20 (section: .exit.text) ->
rtnl_net_debug_net_ops (section: .init.data)

    rtnl_net_debug_exit() uses rtnl_net_debug_net_ops() that is annotated
    as __net_initdata, but this file is always built-in.

    Let's remove rtnl_net_debug_exit().

    Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder
for netdev notifier.")
    Reported-by: kernel test robot <lkp@intel.com>
    Closes: https://lore.kernel.org/oe-kbuild-all/202410101854.i0vQCaDz-lkp=
@intel.com/
    Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
    Link: https://patch.msgid.link/20241010172433.67694-1-kuniyu@amazon.com
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
index e90a32242e22b6d1d4d4a7888b19a9d8137f8fc4..f406045cbd0e60653af480270bc=
45928f9e92839
100644
--- a/net/core/rtnl_net_debug.c
+++ b/net/core/rtnl_net_debug.c
@@ -122,10 +122,4 @@ static int __init rtnl_net_debug_init(void)
        return ret;
 }

-static void __exit rtnl_net_debug_exit(void)
-{
-       unregister_netdevice_notifier(&rtnl_net_debug_block);
-       unregister_pernet_device(&rtnl_net_debug_net_ops);
-}
-
 subsys_initcall(rtnl_net_debug_init);

