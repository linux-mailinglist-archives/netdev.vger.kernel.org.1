Return-Path: <netdev+bounces-185676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFDDA9B4F1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83EB31BA136A
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8254284B48;
	Thu, 24 Apr 2025 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQYuQGSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A52820AA
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 17:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514239; cv=none; b=DgFdO2eQ8MM6lmCnbID8JhU+sPN2AyNPKSXl0ue7icT0do2SvC/J5peFnkaeolCocQCPHbAVYJfDtwEI7I2aDU13YCJggjGWbwUk/C5k6+DCy6gkAXrHmZBfeD2r160Fmb2wIRyXFfKJD7TeBW1amYG8PRdNEzaaFg4+38zqW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514239; c=relaxed/simple;
	bh=Eb2pMlDAnrERNzV1bVVJJlRApWRy85vvIbfGqjV49dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNMG3A6bW+LSmJqVUY77ehlqa/BpbMQ62ItUIbr7XRT58ffPa6Dpgha0mX1VdGl3LEZvjcQ8V/7r1K/KpB/fBoFFp1f6rXMn2xjE0s4fKGZvx0GuogMqeqILWQiGPSi+0OGr+NaWe9K1kUB7XQptFJ38fIxA7/mHMDuzvpuvH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQYuQGSb; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4774611d40bso11761cf.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 10:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745514237; x=1746119037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb2pMlDAnrERNzV1bVVJJlRApWRy85vvIbfGqjV49dc=;
        b=JQYuQGSbJIiEElH0tuoEm9yYvK1trrvS2prVTO+Ap1vmbdEetvk6E/quBGTUDmnfNH
         uqQIHpoV4Cw7ZN179LkLliSoabSMoZflMtn3NjNJ54DDFyzsP8DdpoEJIh0ucFia8TmR
         PNVn5C7e35HrnHUxnwTHq/QU6WtMQp7hx0fR5lJ7yypka+FpQVRCbDPft89YbjTdM8Bt
         tXi4WI0ErqX07IsRDVGaiUiLV7wypwb9g/Z8ylXzKPBSiVrNcEcvtPVV3up/0s/eHd4V
         gnimaOF/949LAL7nOYVl2GjvcZVyFrK8yFg22mi4aq2Aod+png48b3FCuIo9M2g9Z5Ne
         csFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745514237; x=1746119037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eb2pMlDAnrERNzV1bVVJJlRApWRy85vvIbfGqjV49dc=;
        b=dwlweF7AL/eJBym5BrZ6nNClfzqf4AryOTLGFPbhmA55IVFdFlDS/fDWXKLA7UbGJS
         9QrH00P8NP3gtkdeD7bq/49gXMFfulovXyFhPpnG3E0f/rGZjlBKpUuI23AQeftYf7Gf
         AC9cGOOcrenszNhr/fnC7yQIrqCqlJmjUWznRdsk5Sx2/sb7W5cecppbwB+jnPYzBgoh
         mZh+0wjTZMPnteXwc8E8MYVhR7MvKtuo/OhAjzXCS2M98OU7OQ/JZYlLTyve44Fe1ala
         f/RSaHm3+TZ4PDNKfU+lWegGt+o+qY9aqobE5jPd9J/CX1FzObe448jLnQrB4SQpaERr
         /mMQ==
X-Gm-Message-State: AOJu0YynwzKtN/H7IRL9nIfyTh/vJ3bavtDxarnQ2gt7n1kiO6mDT2my
	m3z9FKiNAsutWlNmH91lYrNrybfPpLIkJjbjS/C4xZZOB15Rl8FHlGMhJEET95eYBWS1D5Q2zgi
	RQWmeuG9vkn6FkKzvKnbQsGtYgq8b7U/zZy3c
X-Gm-Gg: ASbGncvLh32cf4SBp4p67bto9nsy6Ql7Iyot5eAy/jTBTkX/q0r8SoWcrB1M4SAiZKp
	QOj55CaEOfuIJRW6geVEi5q14XPaN0g+ZIYnOxA+gHl5gMQHGMxMPT19cipyR6VnvaeBJkFGosM
	vrjZP3T3FVzSnLDz+L9ezuX/KNU9wsPltGYx3iNrjGuo3nX9uZqCOQgA==
X-Google-Smtp-Source: AGHT+IGViuNOvs0GoYyFuJAFe1xGUC2/J0+V1k424bxyKy6CzoHJMJU3JL6YsfODdvo+eaL1oKzeGU9+xOoYFrVxBmM=
X-Received: by 2002:ac8:5209:0:b0:47e:a533:f5f3 with SMTP id
 d75a77b69052e-47ea533f7b8mr3288021cf.14.1745514236456; Thu, 24 Apr 2025
 10:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423124334.4916-1-jgh@exim.org> <20250423124334.4916-2-jgh@exim.org>
In-Reply-To: <20250423124334.4916-2-jgh@exim.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 24 Apr 2025 13:03:40 -0400
X-Gm-Features: ATxdqUHO1G4M5oaUdGxMbXwrlt1zEnpBjAj_dJALJ7o6l8l1PnOjcyh9QA4UY6w
Message-ID: <CADVnQykxYu2iEw7+FYN4M=OgGR7wdoRQDiz_EkrtGWE7UV1KHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp: fastopen: note that a child socket was created
To: Jeremy Harris <jgh@exim.org>
Cc: netdev@vger.kernel.org, edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 8:43=E2=80=AFAM Jeremy Harris <jgh@exim.org> wrote:
>
> tcp: fastopen: note that a child socket was created
>
> This uses up the last bit in a field of tcp_sock.
>
> Signed-off-by: Jeremy Harris <jgh@exim.org>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks!
neal

