Return-Path: <netdev+bounces-194706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC544ACC023
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EA73A475D
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 06:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5D25D201;
	Tue,  3 Jun 2025 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMPTIKKq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91F4A35
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931925; cv=none; b=nT5Bc3dtzNHQnY+Ic1IDCD+4WPgb19U6qA2RtinK757v+Okuth0cWUzmS1fr51z6aSoYCHu5UxOWq5GiYCAbf8V+sCT/ewBS2EmyCho6N1X4Cp9F+rS6Eu9CAZJ/41BVvGh0L2bYIf6CM6o7ArwkIVIb8ebWnDk1lETBuRq2wgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931925; c=relaxed/simple;
	bh=fgvjIxoXjQOIyx+Lmwb3aWBAOOPAF1Ad2zK+juTXm20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ou3b/+g72cyTHnDb0P9emiz9pDQkSKEgBOFkbe/5fE44iCVKTYqfeW5XZMMd7GFDZuznWJ5NhPjC55MnWUNor8Oh8q9ylN1aggZRqNZQTJBOdkzFbfJnqgALPiaFZrEqsVr/wWldF3ARtQCKYp/v8qsLfhyAw4CGELD/Xsia3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cMPTIKKq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a442a3a2bfso69446421cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748931923; x=1749536723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgvjIxoXjQOIyx+Lmwb3aWBAOOPAF1Ad2zK+juTXm20=;
        b=cMPTIKKqul93GHXljjVDndboOqMKMcvjI7LBZrZzUxn5TzNzUI/Ja5dirl7EVJYBtJ
         9zRGG2NMEa3uDcdxNzXZyRnS/rELSN2IRl57YuamRfJV8WHD2UsTWl3nb34OEMCBofu6
         /1VGovSvVXi9DbKPe1cv+Czcor6qurWUVKITocAztRBkQNim2Qaifcjuhcq8DohRsttB
         FJg+xBIaBYrnOpuO6ngDCSKlE0fcA1eJfanXGlscf5iNhRwQN9qot+fn1kzRzbncKFwe
         a6ocBH5Bz0mUN7oOOeNmRKLzpx6D6LVNMeugT0Yy/dKvTNOCNZKE5EG7QFF8gdaHa86J
         eG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748931923; x=1749536723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgvjIxoXjQOIyx+Lmwb3aWBAOOPAF1Ad2zK+juTXm20=;
        b=DP0IDibQVHIIKU3tVnlGUh0fhnQTSu8+X1rBFD0KqmPtTOpk5Oj3fkS0P+wWAb906R
         1jMFID0tswX3NaTLbSQZSfxoEpooAj7JiVRaauglFVaIBOxMYdO73dPWx2kTmSI6Dwno
         8F/p6jJ2cBDUREnTdWh1xcxDctpKg4cwD/W3uiSMMILj3R6VEZzK2DovtxjNTq5VIyqC
         NDQ3LGU50LHq5QgkFXChJPClRuyr1U5E/K6aafSuQM4q1cQGZOc+Agfg1nFT2UNmudtT
         cTcguJmCbP+7n4R+QvZUuYFtuIeYwydWzbWWsl3E325upynvEXZ/CYQXlcbDtx4KYC5+
         0a4g==
X-Gm-Message-State: AOJu0Ywc8DUAxGa++b7ayxUTt6r747QH6lpfUVaI3EcSGXStCilmG3Tp
	8eghSukq1OwfeKQdOtEACbsELEmMeE51bgX1WGSz1DQRCI/lHd5C2jHn54/5txVrjmGTEAAUrT2
	AK8iGaP4a2vmb8XdJ2g/bVG4V0fFd72CSKE1iQdu0
X-Gm-Gg: ASbGnctTt7rRcRNIs/DuXTo8dbdfWYqYYbB7lzQ8nF1WNBSucLPqlttrunHjx8fSltA
	jGraIQ0aqZ953Ym465necbv1fFsj1wOhZ7vm5s91opABccqk003MjE2qZB7wwbLsKGxKIpWziVY
	od+5fC3N2MeYdc8ci80ifOiYfBazu7Vf1DBtAX6Dtunx8=
X-Google-Smtp-Source: AGHT+IHFfwRF3tYPXQ/VL91tBn9XCuarRKHuhLqW/yyoTW/vkmX0wo0HoX51ts8ezDr8dx/GzpSTz4C2u5gmsYYoG8U=
X-Received: by 2002:a05:622a:544a:b0:472:1aed:c8b4 with SMTP id
 d75a77b69052e-4a443ef855fmr261872071cf.34.1748931922839; Mon, 02 Jun 2025
 23:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1748922042-32491-1-git-send-email-vmalla@linux.microsoft.com>
In-Reply-To: <1748922042-32491-1-git-send-email-vmalla@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Jun 2025 23:25:11 -0700
X-Gm-Features: AX0GCFsHCbKNO1rU3NqhVg3qbMccKW6KbAG1rzvbpGFa_zWl8K3FbdyKgHjeeaQ
Message-ID: <CANn89iJW7oSi3NzAyJpTVD1==1Ms0OOerLtif75=jnYF1rcNXg@mail.gmail.com>
Subject: Re: [PATCH iproute2-next] Parse FQ band weights correctly
To: vmalla@linux.microsoft.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org, 
	vmalla@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 8:41=E2=80=AFPM <vmalla@linux.microsoft.com> wrote:
>
> From: Hemanth Malla <vmalla@microsoft.com>
>
> Currently, NEXT_ARG() is called twice resulting in the first
> weight being skipped. This results in the following errors:
>
> $ sudo tc qdisc replace dev enP64183s1 root fq weights 589824 196608 6553=
6
> Not enough elements in weights
>
> $ sudo tc qdisc replace dev enP64183s1 root fq weights 589824 196608 6553=
6 nopacing
> Illegal "weights" element, positive number expected
>
> Fixes: 567eb4e41045 ("tc: fq: add TCA_FQ_WEIGHTS handling")
> Signed-off-by: Hemanth Malla <vmalla@microsoft.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

