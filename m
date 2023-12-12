Return-Path: <netdev+bounces-56228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C76880E372
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 05:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C981F1F21EF9
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE3BD510;
	Tue, 12 Dec 2023 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nvi2wL0U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF0EA6
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:45:51 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce40061e99so786270b3a.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 20:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702356350; x=1702961150; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzW6ne78hOyVBwyJBdluG6G3urLMiolMojmNa+NoQdE=;
        b=nvi2wL0UDtdu/2NKSAK/bwR+VvCcNRx1At5zauChmbK+kRz9r7BfRsui0RevWbRXof
         vAkVpvFE5vEY4XrqHHJixGRTXb/wIeL4EAmx33BuL9yEtxkeilV4mAFsUWEThrQMyFgG
         dvIbU6wLaqzdfTjgT5tQvcyG/S7HfYY+sxnzFAyVQvmGhErcgj+WgUnrozW2ILcBflH2
         ONJAtOHewDcP88+AAOfr+/bZ/A9KwKBDvOTQdTxiKouLzgexy0nyHJCS3QE6Daua/dQu
         cPEbioRPi1dTBx7rPxUVoqhxYuRwXDFXDZCUEqf6rgxKF7gqjs05DX+1yAXfrQsXbs92
         cmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702356350; x=1702961150;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzW6ne78hOyVBwyJBdluG6G3urLMiolMojmNa+NoQdE=;
        b=NfYtNkX+7m2V8PbkOmic3th+FTIEYlsges3D/mGnhKmQowN0WrnDwcjngk/bM9ovC8
         YKlaga4pUBh5gSVZtWxG/cjDoeaxyalN9wit1dUGp0rtrESJeupZzruOz2FjTohcOqUF
         kixoVYqbxbRI3AwEg+gNjeEWTUG64pkijdlvfdHWklWa20h8nOM81cZPy5FUcU6VKhJq
         /x7Rrpp6sCQYA1o0haRW3om5IqTBs/WnYniziLX3qBIkvdCv8DC++eV2n80tppkiW7Jl
         BwhwFZiwGiWDMR2y9ey63Eo/+gKc0gMYz8eotA2vMxHWPbpwR/d8sPds7bGNpH1ocgQ/
         FLNg==
X-Gm-Message-State: AOJu0Yz3a99YGdWfn8u1RDgccWcLRfTvUQuIJFstMlzZdZ4B3/8BlPH6
	ZfDEqOJ91VLyqxMLR8T8u0cmnbf5Hnjx26XfgcYdPg==
X-Google-Smtp-Source: AGHT+IFeVarIjV/fmLCRlJK7v2wGXjcnIKXEDjNmlMbIoWER8XgjJrTP3GxTfPQuISj35Gsn/z0Skw==
X-Received: by 2002:a05:6a00:4b4a:b0:6ce:720e:23e with SMTP id kr10-20020a056a004b4a00b006ce720e023emr11977411pfb.1.1702356350458;
        Mon, 11 Dec 2023 20:45:50 -0800 (PST)
Received: from smtpclient.apple ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l2-20020a6542c2000000b005c621e0de25sm6176085pgp.71.2023.12.11.20.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 20:45:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jens Axboe <axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RESEND] io_uring/af_unix: disable sending io_uring over sockets
Date: Mon, 11 Dec 2023 21:45:38 -0700
Message-Id: <105F23B4-F0B6-41E3-A795-F1B8E754A160@kernel.dk>
References: <20231211183953.58c80c5c@kernel.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 patchwork-bot+netdevbpf@kernel.org, io-uring@vger.kernel.org,
 jannh@google.com, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
In-Reply-To: <20231211183953.58c80c5c@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: iPhone Mail (21B101)

On Dec 11, 2023, at 7:39=E2=80=AFPM, Jakub Kicinski <kuba@kernel.org> wrote:=

>=20
> =EF=BB=BFOn Sun, 10 Dec 2023 01:18:00 +0000 Pavel Begunkov wrote:
>>> Here is the summary with links:
>>>   - [RESEND] io_uring/af_unix: disable sending io_uring over sockets
>>>     https://git.kernel.org/netdev/net/c/69db702c8387 =20
>>=20
>> It has already been taken by Jens into the io_uring tree, and a pr
>> with it was merged by Linus. I think it should be dropped from
>> the net tree?
>=20
> Ugh, I think if I revert it now it can only hurt.
> Git will figure out that the change is identical, and won't complain
> at the merge (unless we change it again on top, IIUC).

Yeah, git will handle it just fine, it=E2=80=99ll just be an empty duplicate=
. Annoying, but not the end of the world.=20

> If I may, however, in the most polite way possible put forward
> the suggestion to send a notification to the list when patch is
> applied, it helps avoid such confusion... I do hate most automated
> emails myself, but an "applied" notification is good.

I did do that, I always do. But looks like b4 replies to the first email rat=
her than the one that had netdev cc=E2=80=99ed, which may be why this happen=
ed in the first place.=20

=E2=80=94=20
Jens Axboe


