Return-Path: <netdev+bounces-176389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8792AA6A01E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC6F462CAF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835171EBFEB;
	Thu, 20 Mar 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPceKs6s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E191C3F02
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454480; cv=none; b=QOp6bjAjUO4PngavQ0Ju7wdt4eaNFhjY6ui7CAv3RShjsOwU5vOnPgicz4TounVkrPLvSKCXPJ3xmDdTLUD/5IxoPTe8URZByhyTXirNVhjxDi/msXSeSN8iKO7ISp8TnddfoVlXmC8YrEI8vQEaUQCBtLIwTtyHurkhbHkfCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454480; c=relaxed/simple;
	bh=hUYZEjpWM0eldTi/QjxoQuBaJ2Hj5sIaiNtjIVKAzXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em/LMClJxFS43cNprIQfXgkvuq5txKhBFUFbxJJ5nIpmL74xSBpGTmulQloY3depLcXoWVbCxD0vM/2wb0S+3LH0MIB53tb4DgAogu/LIq7Rw4KQYk+b7IolKu+BBKB9jMjs0NCvERITHxMLDYpVYcM8yl18ljOqvJUuIIpUfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPceKs6s; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476775df2f0so14633461cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742454478; x=1743059278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUYZEjpWM0eldTi/QjxoQuBaJ2Hj5sIaiNtjIVKAzXo=;
        b=zPceKs6sfpj8xDTN1iYb3PqaXofQUeRhSVs1tb+ovMHoSrGpHUv+fmbow97o8F3DDL
         w4UWST9VjiBUI+3O9X4YoVhTKlNFh8RjMP/mYIBZ7GRyaURqvF8uezlaZ0pP+VTvOxzi
         WysatHMPruanEduGRLCDu2U4RxqHIIFUMqL2gm4hRkVwArjIquSacoS2L3ZSKDUWhGqz
         +ELD89CHafpHkVUf4EChsFwESvCw7JAB3kdrleX/XhkMaidG1usTtxI4Pw1ELeQ+KUUJ
         rB7ECZyN7i8lKgGrvQcS+Swpzet94M5imro0yYRrohXBfkQb6tj9Q2dn8navB/kCECpa
         RjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454478; x=1743059278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUYZEjpWM0eldTi/QjxoQuBaJ2Hj5sIaiNtjIVKAzXo=;
        b=CKYHmifYp399TLFEqHH0Om1joTaBbVElpm8r54tFRdZdY2U+0bFA6rI8po0dDY69Nk
         V3nW5g4UPciskFEzpoWDWKR3e/jSdW0CWZGnVwPOkqWL1+FdQVZrEGagDByppOGw0s7j
         pNgfRYMaUZLrzACnswHrlZ65ZzUN34NTkDwXYFh9UirTiamiD9kO9q/6252ubr5YF4Yc
         2bbjEL3U+qK8J0nZy3PCriAy7aP+Gb1479Bz/GJ+1beF3ew/FVeY0oq+yjsIfYddqBg+
         bePyeLNXTzORaxZCuotezMJw0eIz2DkWfkOQoYIvoUaoKzAdyQY5modihS6hpMM7OQNp
         7EWA==
X-Forwarded-Encrypted: i=1; AJvYcCWMaYokV+IcK0WF/qIPJxPIVlVM4RgyqbSR9bUo8kjWfORZZnf9jOhqVtempK1tzwkHQkgGWPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WMXiKq24M6FG7iLiTIUWl5rwa/+vAp9AqGlfLptSx8FbzwRq
	KEjOSHtFh5QPHWOn4dSLalrocsnZSBBjrmboiR27b/5w/A9Fe6IxP3tLrb7q5W58ULqQ/h2lfal
	AngsFgjK/0ah7qD/J9sTgQThkkZ5SgFP2wEi4
X-Gm-Gg: ASbGncsi3TBtahHMbTU0sYykYywxCLyYM2Qn4vLVkvvZU515HHPTJRoNMp4Uqhtk8G1
	OslSXi71VAGMl44Fh4T9j6RLX8GKTiG6Grbyu0j0ey9SuXcqVc9d3CSnqYiMilHh+G7xpLoYIQl
	jorhVbyIj8Hfk6ebscRlP50FrI
X-Google-Smtp-Source: AGHT+IG+/gbKlplA7yCg4ukXELrO17e9AOhWATD56Z51url70YoB3wSrrchPV0r/UeEtWN69qpxFv/g2S1YqIjwM8kg=
X-Received: by 2002:a05:622a:1a01:b0:474:f9f2:ecb with SMTP id
 d75a77b69052e-47710c9fec1mr35802601cf.18.1742454477670; Thu, 20 Mar 2025
 00:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319230743.65267-1-kuniyu@amazon.com> <20250319230743.65267-6-kuniyu@amazon.com>
In-Reply-To: <20250319230743.65267-6-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Mar 2025 08:07:46 +0100
X-Gm-Features: AQ5f1Jp0Orh2BlUuCMNFEPoYjHw0d0W4C5OtTTD8maXSAhBy6qdVWTZto2wMa70
Message-ID: <CANn89iL8cBj1jVzEy5+z+DoMX61kYEwGq9V3U87gLoncMur0BQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/7] nexthop: Remove redundant group len check
 in nexthop_create_group().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 12:10=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> The number of NHA_GROUP entries is guaranteed to be non-zero in
> nh_check_attr_group().
>
> Let's remove the redundant check in nexthop_create_group().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

