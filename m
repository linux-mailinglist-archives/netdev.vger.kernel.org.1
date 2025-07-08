Return-Path: <netdev+bounces-204978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953C0AFCBBF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1DC485C00
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C392DEA78;
	Tue,  8 Jul 2025 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IneVmk6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB92DCF74
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980803; cv=none; b=juZH0vp5d1iZ5mEqAQPO/d7DfW2H6gC4+cOURBWaihQOG3ONEgzcDmGqxa+0e1Z+RwlciDNp7ox+7dU0V/KG8in8q3lQkr+RQmlYq1v2TrdO24dXiGa8Der17930kOmjTpJ5yZFydAgvZcydkZuZhS2q01kGkGbjN+cs8EFoNVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980803; c=relaxed/simple;
	bh=MjMOKNuEzXDZsWvnWojLws130RcwunrKbZ96sFHwCh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPpqfj64cPH9tGcmmRf4XG6Mx/4N01BCZmR8ZpPbnhpPDvPLNm0ucP+bH1Jec1iFRMg/N57HPdJdAwWc8dSdsdB3YwQNXvHvM51VLhxFQiPe18wfnZDB1NjKCi1fUnH0q9LkGdZEvin5XK5k6LPBxYi3PyPT3cE4L5ySsJMZG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=IneVmk6G; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-879d2e419b9so3324275a12.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 06:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1751980802; x=1752585602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjMOKNuEzXDZsWvnWojLws130RcwunrKbZ96sFHwCh4=;
        b=IneVmk6GZ9EsWuCznx89Nto//NMf8fD2vexCQx4A/+FavaBeu/TA4Y9WKmNpY1zTcU
         hksx2Yuc+en3BzS59oNVigexbAkQLTmi/Qpx4BcyDy0M7v6Ri5fAJTIxHiYjAmVYAxD2
         5v8Gp4myzs3Q8xslIjUa32X9Pl0YEKW3nbEbVH7oWBvjnkBz+W0OtP5B7XPcXQH8jzVA
         dL6tDdW6Qk4Z/PLiwRk5iQGgKLaXpCGfjKRYH/k3hwkYRFhtejhxvdaSa1rC9GZfHApr
         WONE367lE1uEsvWgNDflUgYksFULnpw+m3yIw3Oxup2xlWKMV+BTc1zS1FYENvUSHhQD
         tgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980802; x=1752585602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjMOKNuEzXDZsWvnWojLws130RcwunrKbZ96sFHwCh4=;
        b=svM+IZKohRQHTvDldWUEFkWbSLT3AX8ttfE3LL6FTh2A4QL4PjktYwUNdNSG5Oq+bX
         JFbVQEScCzDvKJWJCOIZbPPuHRaZAWgX6D+PCNtvVTIgk3O4Cs/+OCD/TqSmZDcuOLWr
         1k01C2d7bCzrS++SidkLWqmBJkk/RG+WWFLfg8XT9/wXzpeUXmV7fEnOJbwgglhVXzQJ
         iZdycUjubpaVafjaWIQ3l8jlOo4cmhybMARDyNlNjdT3yiCvupGiS1LK08JrDEKxFv6c
         z/27+20bGsmXIBbKysz0Yr4dcYmZ8Snushs6bdhuUl70N9K9ZTOaJA0LtyYiyyIes80Y
         VHgA==
X-Forwarded-Encrypted: i=1; AJvYcCWvPKwqasOsg9FLv1Zv8ONaYLLvRUrCbN/+UYxtbrASO+jL5oMqO+wL0UrsDpfGzePB6RQuUBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9ROpDPSTRzEWzukRVkiABKIBjzBPi2Dn9k2Y4e9nrfdyAll5
	rzJV/mdARmW8oWgCfO1AhD57jPy9Bui35qBGP9pdD70BWNLfYkeUDZHF3C+on3RqQiIEY9fS8lf
	siseKOGL+sn78/9Elpn/NCxOTOyryTlCLAO26OvmG
X-Gm-Gg: ASbGncs0OZe9K55cdcPeZ0goENePlPM5DRGiZDaZeK88Wpyq8sfYm6rT9XhZLdbhkRV
	5DUyOYt2mOYqTt1LDQaR5vgtnmqe89pE5RzX+boBQnrdyZjKNUnjUNxlHzwnhpkcxfyHGCC8KH9
	yyBFpy9vM6McCY/2yYxr36yhuwikM+mY8AeDr2l1Zy+5CZHZJBBaYV
X-Google-Smtp-Source: AGHT+IFthBY67L/EqZyQBnq7Z/wkyS24+uLojpgbYxG2+5bMXfMmCtUxTOXjHlrV+hSiob2f4c96SQZEd/hAhL2STSg=
X-Received: by 2002:a05:6a20:9184:b0:227:a91c:624a with SMTP id
 adf61e73a8af0-22b4449d6b5mr4313843637.19.1751980801723; Tue, 08 Jul 2025
 06:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
 <20250707195015.823492-2-xiyou.wangcong@gmail.com> <20250708131822.GJ452973@horms.kernel.org>
In-Reply-To: <20250708131822.GJ452973@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 8 Jul 2025 09:19:50 -0400
X-Gm-Features: Ac12FXziBK5R_Uq_hIC44qQXwUbKtEcKPoA7d6XDpmSpC-LTLd9KjW6aFBLEqQA
Message-ID: <CAM0EoMmToF2ihqsSGEDyG3NAcy4rjO5pzXjShD2ac7VrjDNwvA@mail.gmail.com>
Subject: Re: [Patch v2 net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
To: Simon Horman <horms@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org, will@willsroot.io, 
	stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 9:18=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Jul 07, 2025 at 12:50:14PM -0700, Cong Wang wrote:
> > This patch refines the packet duplication handling in netem_enqueue() t=
o ensure
> > that only newly cloned skbs are marked as duplicates. This prevents sce=
narios
> > where nested netem qdiscs with 100% duplication could cause infinite lo=
ops of
> > skb duplication.
> >
> > By ensuring the duplicate flag is properly managed, this patch maintain=
s skb
> > integrity and avoids excessive packet duplication in complex qdisc setu=
ps.
> >
> > Now we could also get rid of the ugly temporary overwrite of
> > q->duplicate.
> >
> > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > Reported-by: William Liu <will@willsroot.io>
> > Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Simon,
This patch wont work - see the sample config i presented.

cheers,
jamal

