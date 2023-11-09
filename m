Return-Path: <netdev+bounces-46875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A017C7E6E20
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F38280FDB
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BB9208BE;
	Thu,  9 Nov 2023 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbX/gior"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA101208B7
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 16:01:53 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57EF26A0;
	Thu,  9 Nov 2023 08:01:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32d9effe314so601929f8f.3;
        Thu, 09 Nov 2023 08:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699545711; x=1700150511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSx7z5v7XTjfY6/QhDDRIxNlklKpSZP0x3V/EKSMDNY=;
        b=hbX/giorFMWHh8WZrP4ce6pg+gNOVJlmQc56JWbb6CIXOqpzAwC4nazGvd4RZXO6Li
         u9mSRR4mWxmHPKNcty7eQbD0DjO3e8zpJk0N8X/ajPaG9kT1No7vWdaF6JuXWiV163QR
         k8lp2vkSlD6usNKU1BzJUtoXf0bYy6lvu7ghxiwHZp2oNGUf7aAflQbP0EIW1bM6eaPA
         p4X1ng9q6ISenlt0kQmQb6QyoTxcPmFfgOxVNj5vbBybmVOLVCVjNBgpfXDiqKQQUABP
         cIQpl0I6o7NP2kR1wltX30RimF+Rkmihn+hGdyoyYe3EdA4FJh9bDsMNb6LNBtqIbdrw
         PGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699545711; x=1700150511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSx7z5v7XTjfY6/QhDDRIxNlklKpSZP0x3V/EKSMDNY=;
        b=G2TQdwF5PsPNPcTPUGuLV+YqCul2yTPUeeeZG75W1z1DzTL8WFYa2uN0vLcbEVq2Vf
         FIabPm8xNN9E/YQPnkNSXUHAYJKwLu9oBOn57b5LZenAnl21FoGISu1JGKwcRz6VKxF6
         /FrfjaKqtYWmRGoO891FKW1fdZ6KtvcWPig3GJKNOGz1qDP3q0wsQyy7n79+HVSybnHl
         5o22caYwcS3vxhKkHhMxsdoxvcllrJ063uHH+qYgPJgg7/kAsIXec7zQQU/+BKyd54dO
         WR7wYu+FUwZROj/v2dw0dgO7sOXjx6iDyI13DfhK7aOEI/wv+8nSlOkrDjkgt09QoLNZ
         arSA==
X-Gm-Message-State: AOJu0YzSKZlo1Rk59/kE9kGQn2gADaWnjNF3Jpu6vkV53l++mSOTrI7H
	9GIeXp0mWlSH+OknkavDqVci6W+T/GmYUqgjxH0=
X-Google-Smtp-Source: AGHT+IF8QKby4UVhITeo5lye/fsa7ODWM9oNW+OBF1idjQdM/e56+6qE0dI4KbouMxXeyAmwHsUXqTflYEC+VUn7lC0=
X-Received: by 2002:adf:ec91:0:b0:32d:af58:b4e9 with SMTP id
 z17-20020adfec91000000b0032daf58b4e9mr4938478wrn.24.1699545710891; Thu, 09
 Nov 2023 08:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028011741.2400327-1-kuba@kernel.org> <20231031210948.2651866-1-kuba@kernel.org>
 <20231109154934.4saimljtqx625l3v@box.shutemov.name>
In-Reply-To: <20231109154934.4saimljtqx625l3v@box.shutemov.name>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Nov 2023 08:01:39 -0800
Message-ID: <CAADnVQJnMQaFoWxj165GZ+CwJbVtPQBss80o7zYVQwg5MVij3g@mail.gmail.com>
Subject: Re: [GIT PULL v2] Networking for 6.7
To: "Kirill A. Shutemov" <kirill@shutemov.name>, Hou Tao <houtao1@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	"David S. Miller" <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 7:49=E2=80=AFAM Kirill A. Shutemov <kirill@shutemov.=
name> wrote:
>
> On Tue, Oct 31, 2023 at 02:09:48PM -0700, Jakub Kicinski wrote:
> >       bpf: Add support for non-fix-size percpu mem allocation
>
> Recent changes in BPF increased per-CPU memory consumption a lot.
>
> On virtual machine with 288 CPUs, per-CPU consumtion increased from 111 M=
B
> to 969 MB, or 8.7x.
>
> I've bisected it to the commit 41a5db8d8161 ("bpf: Add support for
> non-fix-size percpu mem allocation"), which part of the pull request.

Hmm. This is unexpected. Thank you for reporting.

How did you measure this 111 MB vs 969 MB ?
Pls share the steps to reproduce.

Yonghong, Hou,

please take a look as well.

