Return-Path: <netdev+bounces-222838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1CB566E6
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 07:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FD216583B
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 05:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F61F9F51;
	Sun, 14 Sep 2025 05:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCxPtbhS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8464946A
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757826384; cv=none; b=tAtxEtWfUNpjy4jtuEqOGSBzzUaDllRiXBpiA2vWiWgGw2T5qT+TpP8f8/0xEjZU63QzFB5IGFeRJqLpAIFqUIC+qk9l9Zj2wuTFtnMu6huzO8f96UCwbK83Yq0R5oCPQRcG0GuVRvv7mF76Ia3B4c/0r8Dl9azlhbx1KtrHR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757826384; c=relaxed/simple;
	bh=8+WbWl3BvAG2x0l0+5AijXZxiItzrzuxVfBOzBotW/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4bwlr8cz4pVOSok7h/D1O/GF9Kirxezs0/rsBBmSmQXP1jVi47hRM2c0rEPBfQiyjeIYE/dO4hJPi1Ww2JjikSij7CeZPuQRgJeItJBbtXd3+9foRB7gJLXds9TjGuN5wt5DGrA+E1Qw/QL2e/VuJ9iCE27gDl+3bVFYdLQGvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCxPtbhS; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8d86fbc8578so493454241.1
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 22:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757826382; x=1758431182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+WbWl3BvAG2x0l0+5AijXZxiItzrzuxVfBOzBotW/M=;
        b=WCxPtbhSxnocOQu1tNBnPxPHqU0BuuAe+KywO7cP3lBq4EugvQTn0Lh9m+/Ea3Cywb
         fdcCSx4OF+p0mc8nUDsyCTvJDV30wMNh2xVnQigXeMjYrb3ArswfJeTYdSYJ6jpY91ID
         J/ir8kagBn6+WueXoZoR4hLwTCrt7CMCFTB1F51VlSKReNXzT6M8Fk4gkh5vjuCA3YFz
         VRZ5OfU+miL5SjEy0mSLfyGi9FqSbewAxRPcvVqbYdcUpUYKyEUUO0xqvz/cEcft8yk4
         +hmGrlwLDbFoPmsoaZOwV/0xWNNAhp9OQdxhC8F/FJpT8MPpI4XPTPCF9LvjWLSJJv12
         8EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757826382; x=1758431182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+WbWl3BvAG2x0l0+5AijXZxiItzrzuxVfBOzBotW/M=;
        b=a146iTB0uuRcchfmhdl1fQj17AYJ2rOlhhbHEm2vv3Yc95kJg2kFF6mzCmt1CYmnU4
         MbtOngxI+YysR6Dy+cx2/iFEaeYO6XIdnoUuGEVZohzmYcvmjrlkoNp4RTXRdnHCarZ9
         hZsGkvFbnxIGtF9ziyCXAjMI6/r1J5ylYk7UUm6ppW1YGaOWj+2ybpUeZo2XWtoSztKA
         +YSq9dxff/vDY2DrHRnFEuTXFcHoFVguSX2WNBD3hvlX2N1QpDyHytUiP6NusaTmC+Fm
         3kZiQ5s+AwPVFFOlTaIF4vN6hcMbRzpPgF1uSTB4Set/hZsihZN30gR1QdQ4SI9JQthO
         7hZg==
X-Forwarded-Encrypted: i=1; AJvYcCWORFjDeEtsRXYep+9FWyyBa7IIxWj9a+H7PW2U3NLhAyfmhDevmhGJBiElOas36hRdEyt9rS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmZ/KJ3gHzPNk3KSgJPfdMHp9K8QRLed7O0Vkm76RpXO2ei2gj
	xFO3WXEKU35OYAz0actIQ3H6Jjl8KoK7iURSJCAMccMYCAkHWLxk2vLn98g0jVt1OBjlDLiooO6
	jLDkHefSxYer/EbMJW3yiJ+whhgI3bp9oUg==
X-Gm-Gg: ASbGncuCGTN3JN7PcpJ89rsJ5Nsl7tp3+xh3bInJ/+IPCBsZmINxm5PRoTG9uC6bh61
	Fw6FRSeEAvh0gHN+vbG0NbHkdKSxXQGluLgTp4RK9Opr6n2JzuIMMCoJjaHEoHP8ra/8cPr0Aso
	7q17grJKY8twq9PyUqDMkWo5sr17BGwOyNRjwigzbYVxAhsNBd/iVcj5gKlMpBCZrud9EtD1xMV
	sxb7uwWw6Ps/DD64Wt29Mk2g7eLD/CXLW+eKOLmvWPlfyRcsLQ=
X-Google-Smtp-Source: AGHT+IE8YYBqwwBZEwkK/M/uCJGPG1RPpsib7eWdCQA3dwsunimB/nC0DT8nad8SyAO7seHbuV15DmPAtaOmKoMckes=
X-Received: by 2002:a05:6102:50a6:b0:519:534a:6c49 with SMTP id
 ada2fe7eead31-5560e9cd32fmr3394478137.35.1757826381684; Sat, 13 Sep 2025
 22:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912154616.67489-1-victor@mojatatu.com>
In-Reply-To: <20250912154616.67489-1-victor@mojatatu.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 13 Sep 2025 22:06:10 -0700
X-Gm-Features: AS18NWA__9bnumX1S5Bw9KQeziHKo-1fU7y_hqeE-kbn2gzGldoRCD8Jyg3WH60
Message-ID: <CAM_iQpXKPKN3JwdvdqLUbqmKeT+xnjnnQ4Gz33D0myTHAM4scQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/tc-testing: Adapt tc police action
 tests for Gb rounding changes
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, jay.vosburgh@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 8:46=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> For the tc police action, iproute2 rounds up mtu and burst sizes to a
> higher order representation. For example, if the user specifies the defau=
lt
> mtu for a police action instance (4294967295 bytes), iproute2 will output
> it as 4096Mb when this action instance is dumped. After Jay's changes [1]=
,
> iproute2 will round up to Gb, so 4096Mb becomes 4Gb. With that in mind,
> fix police's tc test output so that it works both with the current
> iproute2 version and Jay's.
>
> [1] https://lore.kernel.org/netdev/20250907014216.2691844-1-jay.vosburgh@=
canonical.com/
>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Reviewed-by: Cong Wang <cwang@multikernel.io>

Thanks!

