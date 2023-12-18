Return-Path: <netdev+bounces-58632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22834817A9E
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8699428110A
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A755A5D733;
	Mon, 18 Dec 2023 19:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fmfroHBM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1691653BF
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336437ae847so3690706f8f.2
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702926533; x=1703531333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VjLnKurb94JOJEc5/JiQM+XH6LAGsKmWg8/mQBR2hU=;
        b=fmfroHBM4X2l1OCJTFpgeb/lNf9lpOXjcqrojLpkFGaO5HPeoL9hecrW/2F0tuI0vX
         eQZHxNZ47HdMxo6QYN0xl44X8rCjtBIhKMDhn27LXdVvTWJzXchXkS+EyAlSF0gNo7ih
         waszJ2eZiNIg9/DRX940vuFaTtpIXB3It68jDUQoUW8N60xRuUA4RKoBil/Yzs2/2JVf
         JMWt3TPsA+M59d7s1X4eKhxIfELhWi/dT8Q/vcpHsSKN7XLoh7tqA3eaS8n0nCUyGX2T
         pBs49rE/Q7nLodIVYDwOtudcEP2bpXvMZxkENr0dPHrkEE4RBvsXTi/y9DMM2bgmZDU3
         10vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702926533; x=1703531333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VjLnKurb94JOJEc5/JiQM+XH6LAGsKmWg8/mQBR2hU=;
        b=moTm0mLXXqDuJE0hhrsWS0HceSE+gjr5FQsNE7Uuo62KEqeFzyDLS0tJgARTCKkVEh
         IN3AHBGO1sU0B/WW8skXijG5moB5Lsop0WDu8JNktpd0fUX5bc/ZE6eWcHtsp56xYsrw
         vQYMSPKc7nvYHEGm8ZbfaR97aF/jErKbcMf3A7U8YiphBE5aZgCJI0vbP3MgVWkXQCEU
         3NQWWOj5q/8qOpiM94XMrYSfb3Ve8vr4vALn07BFYoTXBMLVtyW7A+996U9DMF9br4i2
         SI8e3KFRSOonNOMMCP5gVWnL3KAQYAiVbljTqPfIeG86oheTTELVynxPg3qoTnMhLZly
         fp/A==
X-Gm-Message-State: AOJu0YwhwAZglGi7K3thY/hb9If36ZSfHrjGER/ul3GZYYegijTiB4KI
	yRBKPe1NkOq4n7R+43T1gfOAkbKZGvieN4/Xyr0IFw==
X-Google-Smtp-Source: AGHT+IHaFdfIEpO3fZUTL4Wf2Y8HPXZH1xwNOjyaIvh0OcsgRhDmrYh6xFp6oxBL15Pvv/pP34wDIwpN82+DbGf4Bh0=
X-Received: by 2002:a5d:488b:0:b0:333:2fd2:5d2e with SMTP id
 g11-20020a5d488b000000b003332fd25d2emr8604653wrq.96.1702926533113; Mon, 18
 Dec 2023 11:08:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217-i40e-comma-v1-1-85c075eff237@kernel.org>
 <CAKwvOd=ZKV6KsgX0UxBX4Y89YEgpry00jG6K6qSjodwY3DLAzA@mail.gmail.com> <20231218190055.GB2863043@dev-arch.thelio-3990X>
In-Reply-To: <20231218190055.GB2863043@dev-arch.thelio-3990X>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 18 Dec 2023 11:08:38 -0800
Message-ID: <CAKwvOd=LjM08FyiXu-Qn7JmtM0oBD7rf4qkr=oo3QKeP+njRUw@mail.gmail.com>
Subject: Re: [PATCH iwl-next] i40e: Avoid unnecessary use of comma operator
To: Nathan Chancellor <nathan@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 11:00=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Mon, Dec 18, 2023 at 08:32:28AM -0800, Nick Desaulniers wrote:
> > (Is -Wcomma enabled by -Wall?)
>
> No and last time that I looked into enabling it, there were a lot of
> instances in the kernel:
>
> https://lore.kernel.org/20230630192825.GA2745548@dev-arch.thelio-3990X/
>
> It is still probably worth pursuing at some point but that is a lot of
> instances to clean up (along with potentially having a decent amount of
> pushback depending on the changes necessary to eliminate all instances).

Filed this todo:
https://github.com/ClangBuiltLinux/linux/issues/1968
I'd be happy if Simon keeps poking at getting that warning enabled.
--=20
Thanks,
~Nick Desaulniers

