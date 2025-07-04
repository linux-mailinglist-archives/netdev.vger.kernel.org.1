Return-Path: <netdev+bounces-204033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB9FAF8810
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6CD7AB8BA
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E024260563;
	Fri,  4 Jul 2025 06:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLnk89DL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298325FA10
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 06:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610876; cv=none; b=nSPLYKpsWbEH2DOHsZQI2svIAxAl8A70sm04rEtoa9DlxNG7se1kM+JMFmsWH3OAe8e/wUoe0CECiHyq58KEtMLsZAmkvRCKD1qH2flhWGIOqP5q+xo9wcqZ24FmMoLY/ONAID0k1tuwpzNUXeLTQWp2Ttbz/1kYhQGQPOwA/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610876; c=relaxed/simple;
	bh=PTKBM2MvrI8xS/gZxGuOqlh0CiAi+CbOJZQao5izSfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGTJXlncQ2DbxGDkQFm5XeustqwJVX3sg699ordyjr7ElBCzRuFfJI6cqi5/QCEbUeHEXmUZ7sITbdmltgaWJbKX0+cZ3BAYzqeEx98IDV/UFKqW3JfcuzQBA0tVA8a3sxXoC7IURxOGGYyC8dtf8QlzDXWg++Rfr7BLbxU0AIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLnk89DL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23633a6ac50so9431165ad.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751610874; x=1752215674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTKBM2MvrI8xS/gZxGuOqlh0CiAi+CbOJZQao5izSfA=;
        b=PLnk89DLV2wzXjBXQKppXMTmIz2d0bt2iE1vLrVf3/h0OubtPiPjFRFXV0v2OVp/5O
         HS71DCcxNdnT414uh6MzeVPk+kdMRjgp7Pq2vdC/+5cH2kc0TMaj7NwWpeX/YyGkdUFp
         3KSHCee5uxBDTflDjVDujGe5ql6WbFyBKwlo7hQ+771U4ULthpDTLVZhDsxC1jNK8Kim
         FZpKQmgw3dRIq+w8mjR1vKVczqHNzaVtpvAw9ixLhNn3gDIaFuYEa0Ph1Ur2jPhsE4/P
         WBDJvUzVzdPj5OahDWKEucG4gi/DMh40fUenEvQ7ZYBHSVC7z/zbgljIkR3b4yFVdozW
         4RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751610874; x=1752215674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTKBM2MvrI8xS/gZxGuOqlh0CiAi+CbOJZQao5izSfA=;
        b=wAVA/zImYF4laFQ7G5AM9Su4FlwGDTIrwWr8VdXEM2FA4238f+QSIn5IoQXw3E9oEl
         n5qm7JsG5SE1cSPTs1FkMHtzwA6qPUsCaqTFqpiIZusKcWUBQRqM6aMkCqh4PK3co2P8
         TQcDyrP6hQK8YQsrH2tm/ifZqdsyPCB7cd0YfHHtPoDaSKOZPkVGybL8y9tyxfYuz+vj
         HT24HUAWnJ/9Bo4OEs/B26RVN/eAKf7IZlcPklkxUd6wSJkHXhbh1w3AMvAfTVZb7PA5
         LsM3XlP2n+BI+BFXUAU1gfgV5nm4ou42Bu8SfAQwYifzwCmTk3K4Pd0be5u7h6hiRnv7
         VtXw==
X-Forwarded-Encrypted: i=1; AJvYcCXdxA52Ma3NTSeA0LtyQqKxBTlr5wZbNd6pLC0c4luSc+ZS4pVA8iiiWMfEsA/FxpLtIjrdUjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhw8vwNMLrBjfKhpTySLez96rJ0neJL8dco3ni/R0euUWuenV4
	pJ1BIVtAIgfK1h0veKOs7OGxMZ+6H+JnygUUGE5r7F8UfwAyj1g+SVROH7tiWdo5FvDkTpweej8
	Nb0WEGRZNTKm/EcByI7hLh6aEyjIDrj+GJmBEvTCI
X-Gm-Gg: ASbGncuGwssLulOfTfOzdadP6p4D+jv8MatXH83g3zpcdQKZ9ssDd5T0/ez1uCsvp6H
	ir5T0WK3veRQWMS4NKCBY7tuioSvsFqjfiqpJzdLL/FbS7HRW0F+D83ejLQHuo+ztyrFoMeOMkX
	j1ThgS3K+J2H5DxDqLlkk4x0gCXKgeRPBUs2zp2pu5eQnsboJKceZj0chBituCIVcCLyUKm3HdA
	vzv+rUHa1u1
X-Google-Smtp-Source: AGHT+IF50sojtWR/OHPQMe85A3Y2TrVSryTmAauaim7cZvshqBAfhpF5HZ/qYp0qxljY2BWLM1DeSs2ZS45GPo5dygY=
X-Received: by 2002:a17:902:cccc:b0:23c:77fd:1b84 with SMTP id
 d9443c01a7336-23c8604cc5dmr22078985ad.5.1751610874238; Thu, 03 Jul 2025
 23:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com> <20250703222314.309967-5-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250703222314.309967-5-aleksandr.mikhalitsyn@canonical.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 3 Jul 2025 23:34:22 -0700
X-Gm-Features: Ac12FXz_V0IavjK1yk2oE3zt4iZsFaoFQ3pX3o8C0VokIhE8gtYLdtlpy1uvvaw
Message-ID: <CAAVpQUAmwFsu3PCpvK2y7Ty82X=HhK2z+U4AqnU1YQposrP0Cw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] af_unix/scm: fix whitespace errors
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, 
	Lennart Poettering <mzxreary@0pointer.de>, Luca Boccassi <bluca@debian.org>, 
	David Rheinsberg <david@readahead.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 3:23=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Fix whitespace/formatting errors.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: David Rheinsberg <david@readahead.eu>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

