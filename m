Return-Path: <netdev+bounces-134204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA750998647
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D351C20E5A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A181C57BA;
	Thu, 10 Oct 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZezvnIBi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF41C57AD
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564002; cv=none; b=efFC/XhNRNwJqPi+YDdjiX4rqv2uABaa6dL/SalL2aqBcnZ35auyQVJxjClNrD812yqi9RjaXpZwtcYepL3U1PkWBI6XKRZ5AzjpgcZ8rzto5+bTevCNB1WORtQIWP/ZmyI8cWl6QIE0jdQS14bD147o0r3Sn+L1sowSpneCa58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564002; c=relaxed/simple;
	bh=+2OjwkJZLl6XXi5IMcc8eMd/qUG2tnfEj44HAryBP+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pJGbESn2wdXSA+J3kYb2TETDzFFl9fl9Zq+yUYxDV4qkfnET4SFkb+gSkMa5+Tyt/quHTvI+f6vri8lAlfki0l6Ofnz/aU/QzeNdo0BOgbPcuPrIiUDH53OS37CXWzED1CrZ4LkuVTicqVlnK/oFYW1VFK2qoqUa0A48m3Rr8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZezvnIBi; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so1035213a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563999; x=1729168799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2OjwkJZLl6XXi5IMcc8eMd/qUG2tnfEj44HAryBP+g=;
        b=ZezvnIBiOKlbtD0FMcMiVSfBiRKQPGSa+loWZn2eRVK92bwuBsIHWpUUpxIv0Bd1SG
         YVkwWLpkUQ5txTYRzaLOkp6tI9XCzrzQ1rHBoc392Et2Dg4DlOShm+0xXA0P81n3/BG8
         lzVqJtxcy0QfQj5UVQchZiH2/kwxb/Gsy3iwWnY6mzxhA5HDuSRpvLTwxfDwE38jM20M
         vtYIvcJm2TMK0JLa90o/oMApzlZCc6QarFflXkqtaeXVVS62w64nkNdo/BeDSiDjKt5e
         +j/YK/JC0DwWcaGRDpglMgnrvw0rcDTDfQMJtrTbm7wDCzAfcqAFpaRt2u3etwnhpsgb
         ziYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563999; x=1729168799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2OjwkJZLl6XXi5IMcc8eMd/qUG2tnfEj44HAryBP+g=;
        b=clPdlZSOFgAgPVo+oxqSsCZAV9x3hh41aLS+tjBiEO/djFLa0STSYuoqpqDfAkBRYO
         Mlnb7E9O+F5f35yktxLg66SNy1Z3MVsq0CHMZ6p6iJr4MEOB5yWOXIw7f7FwlTY5Tmzw
         AjwiLJV3JqpKLsnQo/MVrfSxor3Jr/OJWDi1AkW6LdIjzWqrZBJu2BstEcv44J/Qx7aH
         PSwUXKHvt9XEacZapiM5+GmqqpTnfI7gGChUJ4X69BhM0Ki6zisjZqQ3p9FM5L35FixR
         4DvU+6CKYlDrFPmZHWm+aC7L3oAtb/wMeLEiLRlipSsR6hESckfZb4kKB6orD1fyftIT
         3nVg==
X-Forwarded-Encrypted: i=1; AJvYcCUKXE5XzBH3odxeiMdwN6jSY0j5GfPakFBHSp3LiIJfBF6H3eJIaXKuIBMVZiv2lLMqrX6eJTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ1b6E5zlJMAxtwS0SEf2lPMj/rqxrXdYFGmrJFyf3NISdyOlD
	x3UMT1ov7Ztnwbevj751Re8VNpuLOtSpdK13R2o+hLSYZ8kI8RxD+s7JSRsQZ6Z5Gmj4eRDHGhO
	FISbvJY4CYyvZo41FV4yKbFm8lEkpBcrHNi1f
X-Google-Smtp-Source: AGHT+IHVFnzgwdK4PcIpVittvcTXubUHFXpjv8LQDrM+hhzU+AWbXCgdvmAkl0bR5CynPaqjCvXxFtB289c3/jx2QXU=
X-Received: by 2002:a05:6402:34cc:b0:5c4:2343:1227 with SMTP id
 4fb4d7f45d1cf-5c91d5377a2mr5554745a12.5.1728563998795; Thu, 10 Oct 2024
 05:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-4-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-4-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 14:39:47 +0200
Message-ID: <CANn89iKQxHAFxPPMAjZFbqJ6_cS3V5yeHAJNoC++iinBaY-A1Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 03/13] rtnetlink: Factorise do_setlink() path
 from __rtnl_newlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:18=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> __rtnl_newlink() got too long to maintain.
>
> For example, netdev_master_upper_dev_get()->rtnl_link_ops is fetched even
> when IFLA_INFO_SLAVE_DATA is not specified.
>
> Let's factorise the single dev do_setlink() path to a separate function.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

