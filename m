Return-Path: <netdev+bounces-71464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 277478536B8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA5CB21387
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 17:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9015F48C;
	Tue, 13 Feb 2024 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpjl8DEX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216B58124
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 17:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843672; cv=none; b=nIr+kHBDwXDgePq65RtWafFCdm9kfYMZlj6oNA3GNS5wOEWVuJ9Hix5GoUpC88SQCKqqpiHH/6ggNkv8RhLpQZrqnPZkIV7aXyjer94vB/IpXzW6raLyXbzYVeVaVqpkmibvj9xmboXmTz7678vhH1buvod/iomwSxnr49BF6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843672; c=relaxed/simple;
	bh=pQ1KRnINw7veZ3wbByYuPXOLLc3oME/9wkrckldYbF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H56GRvkhVVM7XSI0drADzw79V/9Cw1bv8D9Gv7UGk+hvjOqpcCSpdw2zGvKIYPNCNMUW8v/ZO6OYrm23vAcc/ZpL9rKnaEq/crmJKxTOsBnz38CAuv0D4WYfyqRSvLfF+oJSmqTFPLGsjm48y9Gz6hDP5NiHmNfdloO7yHpjTUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpjl8DEX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-562178003a1so220873a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707843669; x=1708448469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD2T25D0nHZUAR9Hm0o8LEDvcLAN/jW+sICcV1cAt6Y=;
        b=Gpjl8DEXNm3r2DOPopaOS1r2p6lOq5iUx1c179kOvo+O6pGq65iBlY60gaqwHvmr/c
         WHn2Y94F2dL5apmtDPhiCxqALw9UImTk7jDY3Hyu706P5hRgLdIzNqHm/Mn4NrIH+Kft
         jIuAbiuW+cYTWiM5MmtFZyg9Mw1XyrngUsF0ui1nVXVE1JxjxcdNRyZGpa1ui4vffshe
         jIwxNXe8xLOs9oYtGKRF5+ll3YU/BiyUfb6yJx6GQEBzYBi1/xwkCWtrSwYIw1jvUsnC
         N9bXNtp9O5jL6Q2gmLCdh2XPu9pjhtPoEVvSaZ3d0gIO4OZ4pvvMc3iE7SiYbfdXhLai
         J0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843669; x=1708448469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD2T25D0nHZUAR9Hm0o8LEDvcLAN/jW+sICcV1cAt6Y=;
        b=b5TF2ZW05AMFUCvNPD5V/+oTYCFwV2HsjVNX/3T+C6tqCnbAXjX8kdSqdpgpCqUjQJ
         M+drEv+M7xMGENAF5EP1DWWt8gExu6P2LJPbVk1oau+0taX3BsglxPkERcm9y7adPn7T
         GdK7yLbJj9/ehUq+9+UC9lIzkiA4x+gT83ic49JV7tUlQzGo15BH1dk4B9r/eC9Ptth8
         Hi5BgK1NwhFRINQvk8tYJkKYdOeMIglh+3x624ibQYqAeIF3j+bpvVBE3hq8r0/jaBZ0
         nZGMRZbvLXlm4FKNa1SclsnysohJNxiHjMGbrchnapcZQgwec+pKpnf75Ef0Q+kxoBWt
         NkDg==
X-Forwarded-Encrypted: i=1; AJvYcCXiUDHwS3WjLgUKcadD+Ynn9FObSgFA0kPBDpkf7yIycGES3dNY/gjgtHLDCirGj3xPTx9AbywFfdIHPDW/Z1/r5PypH7rx
X-Gm-Message-State: AOJu0YzlOzlM1JAUwzs7Vd+mxlUgGQk3yPVP3JCKSVpXO0EmCn4rEBXI
	2MkYWmkugschtjN+rppvat4N7xTBOsQtW7VpDmnO0FC2AUw/3Om9TALZJ2BgFVR2hvYlT6Qil58
	KzWA6w2OSa0HBcUU1S2LGot578s0=
X-Google-Smtp-Source: AGHT+IGSOxVIvNPQUHL7HuZ22qyEQT6Qe99rc+Pj7UCyz+CjArw4CJ7+OCPP7TlTJG/1dMBgFXEiAvI6gFLa8cJCTsw=
X-Received: by 2002:aa7:c154:0:b0:562:e26:90ae with SMTP id
 r20-20020aa7c154000000b005620e2690aemr164871edp.6.1707843668912; Tue, 13 Feb
 2024 09:01:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213140508.10878-1-kerneljasonxing@gmail.com>
 <20240213140508.10878-2-kerneljasonxing@gmail.com> <3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org>
In-Reply-To: <3a495358-4c47-4a9f-b116-5f9c8b44e5ab@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Feb 2024 01:00:31 +0800
Message-ID: <CAL+tcoB0RPSg8-xTGWN2bsLRtkENSa2ak0mUD1Q2ASg0R1Vu6w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] tcp: introduce another three dropreasons
 in receive path
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:49=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 2/13/24 7:05 AM, Jason Xing wrote:
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
> > index 065caba42b0b..19ba900eae0e 100644
> > --- a/include/net/dropreason-core.h
> > +++ b/include/net/dropreason-core.h
> > @@ -31,6 +31,7 @@
> >       FN(TCP_AOFAILURE)               \
> >       FN(SOCKET_BACKLOG)              \
> >       FN(TCP_FLAGS)                   \
> > +     FN(TCP_ABORTONDATA)                     \
>
> for readability, how about TCP_ABORT_ON_DATA (yes, I know the MIB entry
> is LINUX_MIB_TCPABORTONDATA; we can improve readability with new changes)=
.

Thanks for the review. Will do it :)

>
>

