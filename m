Return-Path: <netdev+bounces-209652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D99B102BC
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 10:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33B11CE1A8E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4C21D5BC;
	Thu, 24 Jul 2025 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAERuU3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21742153F1
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344205; cv=none; b=V31T/BC8YsW73Pks1SJviA9M9kjYTXygk7cPGjPmzUMb0lGRTbJvX/uI5A2DutM4uwky5lyWLkkfy2foX1rvrPr7t1Z9ozIG/ACJUa3TQSVqQXIeIDTGeHQPDSZ2GiiuuzTpIo07YvQgx0QCPPIucWJI5sKrAes6yZNr9Ac8cMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344205; c=relaxed/simple;
	bh=UJieD3EE3q0kc+37pyAjaBrkau4zswjG7oQNF3HamPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVK5Q7x5Xk1sn29/n505PrOVNQxxwbbVysY+w+FKtXb49bEWtSVFRnXXzOMqv+9aM9xoSB7UPL8QiVSJxDF0btjNVEH/4sAsaL9oMZNrxTxXPlt9RA5zwLS0esRlJfAQB8BA9hDhPozHjB0FX/8Ck0PR4tGMqX4vqXRPz1fQ+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAERuU3D; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab53fce526so10468081cf.2
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753344203; x=1753949003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJieD3EE3q0kc+37pyAjaBrkau4zswjG7oQNF3HamPs=;
        b=GAERuU3DfDLJjC32xjU6lqLAJNgdwMC+cPnpn5o4YDZ9p6GxRzB2YtYEy2yvI/KL6X
         sE8qCowiJuKsHCF76YDGzdVznj1uA2RLHiVzJ8T54EXiK5xWvoUm+INsuMUzylMj/6e0
         VwPGgH0Z1Lb6v1Wm9y/E872MJjItDGuvC29fq2Rf2Vd3+uymEofCjRErxytfSQpFFCMP
         aMHLRl+51M6XVhewC0DFyngqRsWJ9dg7H3SRwVdWR5Jyo0KJx9w9Jic8T9+e/SrWqxRi
         904RG67IjURmg6b0CWg+LpkFBShFdCJp8j1ZNPA3mo5GWXm3eVBwXEIAW+SDo/+hkoGD
         1PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344203; x=1753949003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJieD3EE3q0kc+37pyAjaBrkau4zswjG7oQNF3HamPs=;
        b=iLEI6/54w6DnfMGhjqWng6dRAAo0FuUOlFfhqYNHOoi34djEh0YB7bdVZ7QDTqEe/8
         VT5oRVxsUzGYd+Z1uR0zrdge4glu/afFVa2Erl7wWGqQjRpDkIDw9FduiTjCqEIw3y7P
         SCvbk8kBm2NGMjGVWByxQeHl3vQ/NWK7xQQUZAfpHVqfpJYbxUuB7GSsPY/1p0U8RkEf
         i2XbE2BzC7S7Dkgnmr+vRW+xHIsTPHztR2+zEqvfWuCa+hIav5TyfcV6cgE93GixaYI1
         H1YiFCf3/xkOdn2E8BY28RkYnJ8juNyLQI8lHAWH7Mi0EvZIci7+Ok09CKuY6nRcKSlZ
         taZg==
X-Forwarded-Encrypted: i=1; AJvYcCXqVPoZOWO+HqjE2e//eB4m39vI7bCLWHeJSkPn+MuO47iuWZFN9Uv7SmTcjZwlJ1mqvj4f4Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoH9rKXclZfvt2Mfq3++tPXYocvDFf7TOihnS8OLBg2IMU+Dhy
	zbCGsZldkb9fuLT8/MUKzfq0Nv9F4dgzw+Qq3y+VMn99fgrShUijtUQS5C3sf12qWYOoZ8OdbEl
	j4iBuQMZ+pyiQ6G+5kGrQuKl0XxsBrFDEFERbSIX2
X-Gm-Gg: ASbGnctXjHHIe5bVo1djAdsxxn3BzGT7IQePRsAUS8S8H3LD5OdrAvF7Y5N6MKKNxWq
	OUIhIvY48Ub6FQHhMPw0QjZroUVZ5OCSvNCc2aPlNVS0ZQIm0F4M+VkoBbg7UQRMwhwnzwh4IJM
	rIwXxxJFqc5djSFeejmSIGbSzTiLx10mwHUWNjQvzIXroVvhyCRyOQeDtDecfY2/dinGl6r1eH2
	Jnv8r64gweUHAbPGw==
X-Google-Smtp-Source: AGHT+IFl+oT1jF7k/9kW1TUUtdhW5Kibpj0coT3C4jfrr8flV4/eU2Q2qfxVAhDslrYzyWWRcnR4dIMOVpUk7b5NvR8=
X-Received: by 2002:ac8:5f8e:0:b0:4ae:6b72:2ae9 with SMTP id
 d75a77b69052e-4ae6df8a4d9mr81016401cf.43.1753344202234; Thu, 24 Jul 2025
 01:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723082201.GA14090@hu-sharathv-hyd.qualcomm.com>
 <CANn89iLx29ovUNTp9DjzzeeAOZfKvsokztp_rj6qo1+aSjvrgw@mail.gmail.com> <7ffcb4d4-a5b4-4c87-8c92-ef87269bfd07@quicinc.com>
In-Reply-To: <7ffcb4d4-a5b4-4c87-8c92-ef87269bfd07@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 24 Jul 2025 01:03:11 -0700
X-Gm-Features: Ac12FXyrVFqHSu-_ClF5-JvN6QWWlq8ElHrMSLpKYWIT9YmGy6cJaULEsLkaWhU
Message-ID: <CANn89iJwM2-rueNzEdOOUuTF7DV=yT+qAFUJsEDqiMJzdjf=-g@mail.gmail.com>
Subject: Re: [PATCH] net: Add locking to protect skb->dev access in ip_output
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, quic_kapandey@quicinc.com, 
	quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:16=E2=80=AFPM Sharath Chandra Vurukala
<quic_sharathv@quicinc.com> wrote:
>
>
> Thanks Eric for the review, as this work is already underway on your end,=
 I=E2=80=99ll pause and wait for your changes to become available.

Hi Sharath

I think you definitely can send a patch, I was not trying to say you
could not do it.

Just pointing out what the plan was :)

Feel free to use my suggested patch, test it and send a V2

Thanks.

