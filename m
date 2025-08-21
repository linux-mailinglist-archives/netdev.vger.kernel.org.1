Return-Path: <netdev+bounces-215553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0881B2F320
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B9D3A8D02
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF402ED844;
	Thu, 21 Aug 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34LPbofN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79C2ED845
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766653; cv=none; b=YjaUBuv9+zLSLRiKiObLhnypXOdznAjZQkZQoyCICow2Vw6Wb1WPHHrZlkSPskbYtpxGmqZn5R9d2hnab4y21SH0n6gLSSf1bujXeqJ6xNwjtr1NO9n6Llll15uGpH9NhMTsOFy+1murvXurW2udOMh2DKPqnC7sdUGT/6yZJLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766653; c=relaxed/simple;
	bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnmRMD1Kei32fcWcAZu3JGPgA+/Azazx5tBE9yZ+l08AGBLjQ97ioX2l9F41nEqpTn3c2dxDbtvAhvOEgVROBddHibm5SI69JV0SxGO89Vl9+lH8QLh/AwvPbbR3j1yZbJhJ4WZMWXG2eSbIrCm4CWrpelFYXJRg0nm+LK2cQUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34LPbofN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b2979628f9so9223341cf.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755766650; x=1756371450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
        b=34LPbofN4P393q4BdsajQS+Dcf/7YiXG5o8TTfwaN2xa2Aj05qogAbxjT0AKPYkQ/Y
         9waoL9h0FffDGh9T+d6mnHq2Ki7OvZ13kVeIW0UkZakjsSkicWs39EJTrq6q39FCWepH
         KJ225+pQTIa7n36CaHDZBUo9rRrshfYFezAivhxyjvUPFEdXTFYKpDj7LBsI2207TGG9
         lBw7adFPKXbngAv+misegPBO/2f/FSqyk7AATVNopXqWf8nA7iq4VqWTBram7bKZ228T
         InQV5OcTf4fn4GMMv89cI1VaJQ2TL0Wf+wAL+fRPA6mYEdpFWISIXyhHvRWlfXlis0bl
         xZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766650; x=1756371450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
        b=jADgmwQAUBgnmwd4l1xSUMjbJ7ilktTAZVV6XSkdcY7QMfBwAYDVmcNqf7tM5U1Mv2
         ggH3sid4foHYCstKaS1tfZpzjol94F40sIrRDUI6QWuO3ygW2153aFuThBUtx13yxEx8
         oVsQCvH00KJ15Lo5RWszjlLfgxhHek7OLXUXazTkT7JftK9mXur/dSV/3s4KmPQk+98N
         nvcSg4LUyeWbjmqCSZIPNakvdASn53DeGhJaLm+rUulVOzuMWqebKlbNC99hetYZf1OV
         SfnmM36C0Jd2V4KMHYW4tYAP1/T5dxHixztiSFf269NobyTtcJRZGXeQEcCXR6ziCFPk
         uqNg==
X-Forwarded-Encrypted: i=1; AJvYcCWUXzv4ndBCkq5gSPwB+ngAgx+3PzZJoXe3MxKFMukIYcLcrpdjgcGDIS8OlsQru6faZ9eL8IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPREumZXKlc6o9Htna7fEJQLrN8lLTUgWvbp1CMoGZMvGj2y3
	i9BYDHjleYJn9PRgO2HvgMj9HEvk4UqHpRXDIGJCnXiW9T2Rdg5m2N7IC9lgqKfCkrHVY2cNUa9
	rg2L700x08osHzGO0AL1oGvQ/QeRF0YEerVMX73bG
X-Gm-Gg: ASbGncuJeTy7kBLR4aqPT3hqiV3acAGRXB0XZKvr3x0sVdRdEVTVGA7isiHQT/s6Fma
	qTuSHlq4ryM6jfNGnUw7hiPVdyzKIec1EMUepkDgEHqmID4HenYR07O2miucyTD781Lfx1p8fYi
	1pA7ca88b+BtSKDt9CObLklUlFqF8nb31hlzhRl+K19M9+pwT07nSaK5iXF21sC6J4aTjJRLHbO
	8FuaZ92H4nUY0eCnlCMs5VU7g==
X-Google-Smtp-Source: AGHT+IHFkVfP6J3M/7hhl54OhQNkRmBSxPwdT/1PDEOLJvFDH72XGIwIh7eQr1CXffsV0ym4huij21JS8QYACP49XxI=
X-Received: by 2002:a05:622a:1a08:b0:4b0:b7cf:8cde with SMTP id
 d75a77b69052e-4b29fa3c3femr16301551cf.21.1755766650133; Thu, 21 Aug 2025
 01:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-8-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-8-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 01:57:19 -0700
X-Gm-Features: Ac12FXxEjL-42H9O9a-b_qJb1E8Dwb5jTLFUbV4y5evL7fDRVFtenhZTNyo0XGw
Message-ID: <CANn89iKhAKsoZX-=LkMNTjghoyuZ5r1rT=Pvu=wua4M=DPSWBA@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 07/14] tcp: accecn: add AccECN rx byte counters
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> These three byte counters track IP ECN field payload byte sums for
> all arriving (acceptable) packets for ECT0, ECT1, and CE. The
> AccECN option (added by a later patch in the series) echoes these
> counters back to sender side; therefore, it is placed within the
> group of tcp_sock_write_txrx.
>
> Below are the pahole outcomes before and after this patch, in which
> the group size of tcp_sock_write_txrx is increased from 95 + 4 to
> 107 + 4 and an extra 4-byte hole is created but will be exploited
> in later patches:
>
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

