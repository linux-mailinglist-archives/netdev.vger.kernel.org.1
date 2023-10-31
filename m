Return-Path: <netdev+bounces-45415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4A7DCC98
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 13:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75589B20E40
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB02D1DA26;
	Tue, 31 Oct 2023 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lsMjC9JH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FF1D553
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:08:56 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F810F
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 05:08:54 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1efb9571b13so1646082fac.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 05:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698754131; x=1699358931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sa4dxp7DarHg06flvsXo+XgZKM1Mrx7I4Ds9fXuezI=;
        b=lsMjC9JHZjqitX1Sa46cwFldossKfZP6Ez6fmk0eW5sa9pcYy6H8qOTl5VVYHM3BZH
         ow8ErlQmsk5sjuVtkxwP+LRAyC0/2h6hw05pJLWpM1yoWG4h9cze5Hh9bwTwHPbJ0qKm
         VjK/APAnuk3U+R91I74yGsI+62ZjWTBVnsgVyviAnq0GKzhhYCEZZfxP+5Ix8FswnE7Y
         I17iXZxdMr98CPD6/e7ukTX+sdKswn7i9GkWmnrQY/q4kAkMp5pwH0TNkj3s/1SkUjj0
         MbgQ+W1eQU1TomUjr5a/TLKQy5NFJd2XqjgMugvU8G7ts8DD2eWSygAU2GHWhnB+rQ+4
         4Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698754131; x=1699358931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/sa4dxp7DarHg06flvsXo+XgZKM1Mrx7I4Ds9fXuezI=;
        b=SKT0iilPCxtzT4eHvx8PYRTYa03E7/IHHqmlkk2bD+6fKZV9V4Jvt0TvJ2nO/o4M5J
         VtOHCB5+U6gXHgFhpeQsIfBd7/+Vjxxwh3qxgF5SoxGUiuGOtmXB72xXrtEjnnUSrTPI
         bobsoKmlf15cUyKXURQTWByKI7YisdpDkAvdX6EAm5xCfsD9Em48GZBD4Us2mIdYlPd+
         9hPpKYHqUeM7V7c82WdpQOnrtWk3y+HU2Mi/dt9eJAsMS3aWkRfyEF3BsCkGZmrhMFPc
         DdNTlLoimxuNaTrEueoOTyCXdZ5OFDBxDFELjPbhkhicXKi96qIpPXToC66zQyvo+FZ8
         LSjg==
X-Gm-Message-State: AOJu0Yzr+EgClsNOYjXSBkB918on0IRulzaF4Mxvu08VcwbClaAZOiQ6
	siz6B70AVwSSBj5OO1PJlsNLGl6NAQlWfA12WlITjg==
X-Google-Smtp-Source: AGHT+IFJNfpoKjZbsKMGqd2OBm4hmRMfr/00ArmxGiC+YLEGigULy6VeQOna6gydcVVFbvneBi63IBxQF0qtmuo8YE8=
X-Received: by 2002:a05:6870:1199:b0:1bf:787c:411b with SMTP id
 25-20020a056870119900b001bf787c411bmr13732233oau.10.1698754131116; Tue, 31
 Oct 2023 05:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031111720.2871511-1-edumazet@google.com>
In-Reply-To: <20231031111720.2871511-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 31 Oct 2023 08:08:34 -0400
Message-ID: <CADVnQy=xO_=Zno_r2uV+g9do49V3bHey8pW=Rxkxdxr+EHYBZw@mail.gmail.com>
Subject: Re: [PATCH iproute2] ss: add support for rcv_wnd and rehash
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 7:17=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcpi_rcv_wnd and tcpi_rehash were added in linux-6.2.
>
> $ ss -ti
> ...
>  cubic wscale:7,7 ... minrtt:0.01 snd_wnd:65536 rcv_wnd:458496
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Thanks, Eric, for implementing this!

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

