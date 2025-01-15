Return-Path: <netdev+bounces-158522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1CDA125B6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6903A6D9A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9C24A7CC;
	Wed, 15 Jan 2025 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="inlTyU4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8FA7080A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950546; cv=none; b=X6b9ddUNGYPSUA+LLBpbBIUN1LO8BGd9aRSd5lB75PG/aMPdETiLTeO/jBKAGS3pQ9vlsvpxNH4XkdSyelkUMDoIIUYiMpqhSNeLMUpUlry7vIeJBLhCIto35kcqUszjAW+s9pk+6acRmOVXSb0utDjYVNz1SQQAU4yhzGQppT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950546; c=relaxed/simple;
	bh=Q/i/v9U55no1KQfEEpVduGhXnPWBxbrnCijI3XF9e58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFvEdQFRzNJ6FxfTC24I81SoiZkXH9sfQ5iplxLEy5Yc9uw5KVBLCNb8S59eXtzolNousM5r+5nvzNDDl3Gf6KZWMuV8lwNYa8H+0N0lITctRNIhwXa60Ln9ukWFM6cWeOomafH7wZRBSOhKCWU9Ae3GN+mqu01tKpOj3X2h6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=inlTyU4/; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ef89dbd8eeso8566089a91.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736950544; x=1737555344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYV90okWPUcLQ/pVorEB3PZZCDoVqaWjVNjkYn8/+DA=;
        b=inlTyU4/tN8Ns2AnphHt2maEUk9QXy9FL4GbqTeKb6geakkhPukT4F0OHbhz2MThXy
         9SnCuj5uyhzBYRWlzMjWFAXfjMvwTjNRC1dDy4xPt7GigdNbtG+HT9f4dTd6r+ee1RRb
         5uLIZLhbKBi0h9yG0DW2eyPOrC68v0LdUEXbgwFvGAZ4etFym4OVrfhuDdB9EPlIfG6X
         Fr1T7AEj13NCyoxRWmnN66AG3JcBxepLE95uIxfVYk3Opw0XM+OC4WtlXODOS2ZrRGIZ
         9av17COWYMAGfhw6DeP6nI+EDeVLrAYiTioPoRco75RxBFtVKok+KUr51LeGqmUEhZ49
         7o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736950544; x=1737555344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYV90okWPUcLQ/pVorEB3PZZCDoVqaWjVNjkYn8/+DA=;
        b=vsV6zF/buvJRY4glQsaTeuWrRMrh+4X97LUgVD7757tPYoRLMrRzUm7bavQ8jr/jqb
         5wjS3y+4JQrxBqbWmZ+zyn+rDLg6m8sscdMYIZ7dAVNVI1m2n40LpMLgokEy6OSwfu2l
         AdQ6u8t7YCvF86ud82b0yKuovB12PI4D6Z2lQiuHVPbjHs2j9sKVBjKHUdVQKwLXCjm4
         ZHHx++YzV6GMLiah2bpGEcRDBWshP3VajcPVzogLpNWdVRJA32qP/rZaIhDTv+F206Zu
         T+YBAaSSK5fDRrOHq4UGiNcUoWtHj5TZE8DCnxlOfF7GDa4+0FW+uo6+BAsmmoEXCJ84
         TcSg==
X-Gm-Message-State: AOJu0Yzc8/1plmMMgPLDxvik2t0WrJON4w2/OwzSGrldMzU+l5evnYAT
	hu4Z4Ya1pTbfmsfBdtwP5kTbW6xygMLltbYGh0tbgU5Rkau70SexVWrEJXlZvmfnT+ePK6n2dCs
	7VkgGRM+FbNRsumhFmXgaO95udOxUp+Iq1XwfMmVUEHMsJsiddw==
X-Gm-Gg: ASbGncvqibzYbvXfFVpZFgKts9akM87RvKAeIknW2M32om1juHuGkBXYDsguhZqeycs
	tV9u0Zr6yBbN+/UBno+4Pj2TIB/TFHAn0gmOC
X-Google-Smtp-Source: AGHT+IHi7GwKvh7gqN6187Skddxfc/YKq2SZVG/E53dI16R8Yys4QvMYqtLvu/BWJLmVP1TMSdcEpjYKI2rmBjC3XtU=
X-Received: by 2002:a17:90b:2dc2:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-2f548ee5378mr38038650a91.21.1736950542539; Wed, 15 Jan 2025
 06:15:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111151455.75480-1-jhs@mojatatu.com> <20250114172620.7e7e97b4@kernel.org>
In-Reply-To: <20250114172620.7e7e97b4@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Jan 2025 09:15:31 -0500
X-Gm-Features: AbW1kva_EsSp8ds8o6RbQ6lZ2L4LNxlWI6TJbkUym0feaFyM-Z8sb_D43oLjTSs
Message-ID: <CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com>
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child qdisc
 from one parent to another
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, security@kernel.org, 
	nnamrec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 8:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 11 Jan 2025 10:14:55 -0500 Jamal Hadi Salim wrote:
> > The semantics of "replace" is for a del/add _on the same node_ and not
> > a delete from one node(3:1) and add to another node (1:3) as in step10.
> > While we could "fix" with a more complex approach there could be
> > consequences to expectations so the patch takes the preventive approach=
 of
> > "disallow such config".
>
> Your explanation reads like you want to prevent a qdisc changing
> from one parent to another.
>

Yes.

> > +                             if (leaf_q && leaf_q->parent !=3D q->pare=
nt) {
> > +                                     NL_SET_ERR_MSG(extack, "Invalid P=
arent for operation");
> > +                                     return -EINVAL;
> > +                             }
>
> But this test looks at the full parent path, not the major.
> So the only case you allow is replacing the node.. with itself?
>

Yes.

> Did you mean to wrap these in TC_H_MAJ() || the parent comparison
> is redundant || I misunderstand?

I may be missing something - what does TC_H_MAJ() provide?
The 3:1 and 1:3 in that example are both descendants of the same
parent. It could have been 1:3 vs 1:2 and the same rules would apply.

cheers,
jamal

