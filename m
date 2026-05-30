Return-Path: <netdev+bounces-293298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FwpCl9aGmqa3wgAu9opvQ
	(envelope-from <netdev+bounces-293298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 05:32:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BF860B2CA
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 05:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2724B3020A90
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 03:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7130C60E;
	Sat, 30 May 2026 03:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtlKGQZT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8D175A6B
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111962; cv=pass; b=PqwYhsieJEplRmcjiGb4nAHY5cbBPWD0rZlRj/ql98VYzMc4z4SvUzP1KGfHiVjHXrUyRWR77r/akUmtLNBYnYU6Lq3M5HgLj49cpPmJEcN4gCvMyNllnUrPNK7dJaCR2o+7BYbZVki9Mqi7A/4BTy6eUNqsvHjuOBfpWcbZspk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111962; c=relaxed/simple;
	bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwZu95jyKwcPoEbINEYcyZD3ACHNjzZ/WPkZOomJJ/dikuGdDt3fcmM9z/hOBO5GANqhR7LV/qY9Kkft9KNha/6Qf4zT8n3cij43ENKX9s2bUg4yBaRWGVNgsRRb0dvpexc/GI8xzNTNZR7gjgzcklvvoBLAI1CR5OYg8AjPtY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtlKGQZT; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa610cbd9bso453620e87.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780111959; cv=none;
        d=google.com; s=arc-20240605;
        b=RlYsi5kmmoY88Iml+yrXNHiPE2YJUuSjzEdXWFLk0yg3ADyxMs7Jzw7piIO4pFsx9Z
         7xwtoDPksx3WZG9W45L8f0NajZCHLSX071Yzk+CuRP8fU/9du7bfc0HSLdqYFb3yV+0a
         BDBzrtOslkPedQ5fab04JBDvH3XnIx6Ni7C8J2mlAEtt3Yhhx4fO0MgQLEMvPEm164yD
         +LSyYAIEKUIBa3JRhe2oOsSkvOdZ/uq9IryXTg5X5Xv2ODXqJbeBFMRZWdc31TIYwXgf
         bZuvK/n7aVCIEuvkJCerNRaRxIvEq4wr1i6kECHWRhGNXZCDqGuyMMTMvcLcAiuK1nFE
         rLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
        fh=957vq+RTjOJe6+Ut2Yf6y1ipc72K0M1uU+yWIx4mSgQ=;
        b=D3dYTtqIMTdf1U8ZvX5haKc+096Z50tLpp9fDTh8Tlde55EEKtzIW+K75UBrKP5bNo
         +gMnYsTh9HG0o0IeiyFaVRcINv6w/hAOJIi4B3oBvxKilRFxY1kS3Xb+pBvE5BiSAxZk
         mQWm59sJtEsQYXSmqaXlF89+zO0bd5cGPuC+dFYRws4tXI7ioe7W9NtVD83lFhwPWyNh
         oeeeHvpaS8NLvxoNvgHpidqt/NznFqt8lDy68U1AGcVLpZeC7qZ6dmovA0aYy7R7oJP0
         +OjQuhUGujHYqdL9p2t1fwiM2JrBjEBIBKFXwF7dbjee9LIl7hr+dgpzKcfUnQiJKBYr
         jLPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111959; x=1780716759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
        b=EtlKGQZTeq7aqArxCKv9IPWik5xDmB1gJvBHHunjXW93AbnqW4wsJnLWYvEfKMz/oB
         WBCbGvPLFEvGw7VmtkO3u7RRU/GqkVsDmlmZAaPkkUj5krVyocf5y65jijFDQx/3K38m
         Xf+mODMYyuIM29F44B6uJYb2J3NIPfmw3TZY1xpVT85BEsw+5ReVjplloKvu684YKHKk
         17NkU9TWnNN/ptiWZ11pIFhDsGj9M7jQDvaVvXShNKNULL1uInwcWV4pMMSjzvprdsPo
         ysd5mCJU71BwnveN7cSxkocjgTApbpwkG1kI/OZldDaaYkR1Ol17NgnsRZbiQ5lMdDLG
         wIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111959; x=1780716759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSotmnBrRHOsWFKJgpkfGKmNyAEWWJhiDhj8ZAX1lio=;
        b=TB+q8o3D6//3zM7y05ZMDPnW/ek40Z8goGx0Vir59HuHww3QuPWY4u2cWHB6tqgbEE
         NsUZ88qCOvBhj343+iuRtYyrPcxa18oTNSp3pKU+uDzZhdP/XjAX1I0pgcFhQ91ySsPK
         jIKQD17FGqooVyx13stCPDyjHBeyZrFAt5F6wUQXu1OsVtz1ECJYPiY7EMoONQp3mYns
         Q4wMTB+xBVaua72woUx3RC+pmSX+1GQ45UCVjStSP+Jb9T3QjJ1NwFOM4GYsKocAY/Kk
         6QAH0fPMD4GrWhtJGz/rh7q6KYYcQkRvBPWm6o08IS4hhv602z+jKDR0LIMZi45V79aI
         cZ0A==
X-Forwarded-Encrypted: i=1; AFNElJ/gomsdoy2E6ttiRYSTZC+sikacEfOV0Spdj6uLV+x568PuevqG4QI44tE4hbIIc9P5hYg5pwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXRrOxUiPJCa4aayiKS3t/5TVwMm+NkXTxbf1QEHkyoYJZwJy
	7Q+cBWU0MRUAJ3nKHHOpBpFdR1MmvD/90uw/G4lP1DJgbDBIUWn9bSmVldUHrcfYlrVBaNnXxGX
	hQjbqF4ikyUCh7aJxpUXZEsPZsKuWj10=
X-Gm-Gg: Acq92OG4/DDWS5ccyoBxExfvj5CZtcXa6dOr8a7umwXJ0utpQJU7fb4fuLnHP1xA155
	z3xyN3b5TxqJuj1Fo689FaMrgXddYwBLULvpzuJEVzM6vwIXK6va9+dXi5utbA9oO0RDcYoKPVJ
	hZAK0PpfZGX2VK/RHTZ2Rgf9KwblhqupL887JgSIiT5EuBZ2E8+ti0GyQxK7QC5PiYDNAhIFOgm
	oWnbL9IZWpg6ewxYAENjBaUnFr4OHtdajZY4wwHf4CnXWM2aJQQznEm4sVuhA4CBGW3yvaxjanz
	oB/Bbn7NQnPKiKHi17fGqfFa60P5ZZeP8v5WM4mYYbjJsvyQhw==
X-Received: by 2002:a05:6512:3e17:b0:5a8:8818:819c with SMTP id
 2adb3069b0e04-5aa6144d682mr435863e87.16.1780111958749; Fri, 29 May 2026
 20:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529203909.1222164-1-martin.lau@linux.dev>
 <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com> <202653023041.2jVo.martin.lau@linux.dev>
In-Reply-To: <202653023041.2jVo.martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 30 May 2026 11:32:01 +0800
X-Gm-Features: AVHnY4I3EKSj9TML9XJ-lUKmnSrKBnNIYvvEILz1RBOfIuKh_OScbPnlbV0gJ-g
Message-ID: <CAL+tcoAXEkscyQc01rVYjp+OX0AwSZZgpBmtsQF4PmEepXqtyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org, 
	Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293298-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 76BF860B2CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 10:57=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On Sat, May 30, 2026 at 09:35:47AM +0800, Jason Xing wrote:
> > Maybe it's not an appropriate timing to ask this, but considering the
> > further development I really want to know if you'll continue with the
> > latest series around struct_ops? Or you will delegate someone to take
> > over your work?
>
> It had already been discussed in another thread [1] that you were involve=
d
> and cc'd. In short, Amery will respin it.
>
> [1] https://patchwork.kernel.org/project/netdevbpf/patch/20260523083001.2=
911931-4-kuniyu@google.com/#26971716

Ah, I didn't realize that at that point... Thanks.

Thanks,
Jason

