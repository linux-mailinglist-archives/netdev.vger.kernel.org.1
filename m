Return-Path: <netdev+bounces-204229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E3AF9A50
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82204A5207
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BEE20DD54;
	Fri,  4 Jul 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlbNSIXe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE72080C0
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652502; cv=none; b=VXrh86HOtBnUT5LtA0zoM3a2bI5hQu0H+xq1jHMMw3FCA1ytdaNFbghSLdY1xir0d/RQcY65md5b+PJRLVFFU5EpzijBKt1+88d7/MgaJ7FoJPY2pBqihnWLprSU4bVj3lfWUARONx3aQPx2QUpMMPTZV7IXM9SCR0MMhnMbPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652502; c=relaxed/simple;
	bh=zZOG+6kEYPWNmTSbahRP8Yg09LRZxuvbzgHqdu8qA1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ngl3xBFHZiTe66C2mZUACSFAjGEAWzGIOgCix1RPgDw2H5MwEdSbjbeYitXLSCKq8F/0ovgpV8GXQ7/fsDJs1hCMuzEwNBCw9dLtNBMcb3q/77IwAdoJsC3wShg8pAiNgiQ0UggYMBnkoYGUn8kkrtfuaVxeXH1fJSKPwzbDNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlbNSIXe; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b31c6c9959cso1225284a12.1
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 11:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751652500; x=1752257300; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RfRwO9ZuuX8vmXNtGlWGYF03IZb5qXeEdozJPnkCAQ=;
        b=qlbNSIXeggW6gkFJ+tpw8ypz8EFB+toeQYYvrjy25mBLgiusTYz6OVSRl1+HbDlCsx
         GcOpXjH7VC/VZQiw1vq2vzO+6TVCgHGY4pzc/cSluJpmd5fLsYfDqLcXMXiBpVxIdlMQ
         CDR6K7T7fxB54Wi0R8AEB/J/8mjbF5n2oFQhAns3PUFrIBODSbUu5DoFUch1JQCEO0tL
         qaqpO/DHOet4MKI3+aMzfDRAGF598tx2kbNbWYDArr/J2yFsa0+7Z00xLMkfYNjKj+/U
         MW+p4/wfy22TXDncYX/cv5HtNi9Bn2oC00enRW5njnJXYCpTR7lqLUJ6ffo+ifBo31lt
         ANnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652500; x=1752257300;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RfRwO9ZuuX8vmXNtGlWGYF03IZb5qXeEdozJPnkCAQ=;
        b=DbMv7naL1GMRh2Innx2BWpG71Adr/at8mDfupHg/f+gKeGuKS7kA1Pl+veqA3G9ca6
         qD3QgGRHx0gr9R+0W7KurZhqnTCPIoYFhmJcYFznZ4TW1M4hVPHNTG1tw3dAe06x3E9Q
         TBgN18zUJFGpwMtat8B6MOoWNKDeRkdi0FKr4jYZ2xSqdmWILZzHxevnepbxlQC72Y0u
         9ADPkd1NhKtUy6u+JRUI6IXL9QISJKVcbCHUARwxGAcW/uev+i2uWD2KnrM+Dh/VPwfE
         CsLMV4d6FSsxJ6mt4fh4gYfGEc5kxDj9hzdE3+/q/mCBN54wiMzHzx40IZRT1zYXuIdj
         qPNA==
X-Forwarded-Encrypted: i=1; AJvYcCUb4X2dkPXextpka+zkK8C3BAHoklDituMRht/DKf88jHuwnyA543M9J14bwPUIIYQp0WWmp+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU3gduyBq7pYXsGg7vAINlrUH53w7WhJ72e27H79l4t+YkjvGx
	4RGetFdZDJck+NweA+A1KIETAIbr/SQ/f26c+5wC8ILJJxT68ZhJwqVACCpYZgdwkPfto2dNu4g
	obEEqwSsga+ompHzGtC0byXDoA248EvoDsqmiuOtK
X-Gm-Gg: ASbGncvNE6OBX5Wz9TCeK8WJNZneSYIOFWZyaKvtlvk2nNsUtIevnQIiUnoeONeYUNp
	2DXcobNEJrVzr5Bs7Vj/aqYRohRhWA3Q547Sq/kLX761LWUU2D+oQOD3dgpxjpQ5Q/mn0aHsORy
	cjiWny5lkZZmvQTHRQG1zksD3O9IHOXGWX7jh3U8pc6DbN5RbLnmXHrwk+HSGMQpj0x8hB8D12M
	Q==
X-Google-Smtp-Source: AGHT+IF5gPzuVm/wp6gH8G5aVgrvTuxINflU0Wvrt9OQjylDdhaRjtr+zBERt/R7CmrrpnMu9R+f3+ixB+/Ii1d7bpE=
X-Received: by 2002:a17:90b:1fc3:b0:313:23ed:6ff with SMTP id
 98e67ed59e1d1-31aadcf4979mr3531611a91.1.1751652499978; Fri, 04 Jul 2025
 11:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703160154.560239-1-g.goller@proxmox.com> <20250704080101.1659504-1-kuniyu@google.com>
 <4f6ti2orkpa2c5upawpaj63jyhdx3uxeobaxjhd2tjnuzgucqz@odfw5wacuwjt>
In-Reply-To: <4f6ti2orkpa2c5upawpaj63jyhdx3uxeobaxjhd2tjnuzgucqz@odfw5wacuwjt>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Jul 2025 11:08:08 -0700
X-Gm-Features: Ac12FXwFoBf500m9nUVc_9wqMSgyrDzQU6Bg9-YJeQl99hoXRh7Oas8Dc5hmpLw
Message-ID: <CAAVpQUDxYarDv2OySLxazZqEqnu=XnSoZv9NVThdTc5Z5N7PNw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: Kuniyuki Iwashima <kuniyu@google.com>, corbet@lwn.net, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	nicolas.dichtel@6wind.com, pabeni@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 2:37=E2=80=AFAM Gabriel Goller <g.goller@proxmox.com=
> wrote:
[...]
> >> +
> >> +    tmp_ctl.extra1 =3D SYSCTL_ZERO;
> >> +    tmp_ctl.extra2 =3D SYSCTL_ONE;
> >
> >As you are copying *ctl, please specify this in addrconf_sysctl[].
>
> Umm how would I do that? Do you want me to add a comment explaining it?
> I need extra1 and extra2 to be the network device so that I can set
> NETCONFA_FORCE_FORWARDING but I also want to use proc_douintvec_minmax.

Ah, I simply missed the net/idev use, please ignore my comment here.

