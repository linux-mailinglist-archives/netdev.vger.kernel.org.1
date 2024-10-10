Return-Path: <netdev+bounces-134226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A72998735
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06431F2105F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FBA1C8FC7;
	Thu, 10 Oct 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUi3wC+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F71C5781
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565764; cv=none; b=YPMDnG9fwOFkNkdiAUCWWOYp6XQcmXxkV2yMXReFH7vNnflV6xJ8yjwskjs3XtvE7JAjBoaocbKItmrLqMlKLzUxB+IQOcDbtt3Tyo1ivdMv2en+J1OvD5WzlUjeG+amDfQll5I7ZSR1kmCkUpOYhoo/TddVpfIyGPWcCV1LOi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565764; c=relaxed/simple;
	bh=gQT6ZNqTcZvskYRGubnEVkFYIXB5jKNZYlr/scmkNS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwsTWEEByhji7UjVPO/KsuWMCXLuvKnluLIvqwI7Jh7W/VMTTfkAslQjjyhthZzpxIfuE7v/tp6oQd02ALL0DjOW0y9yB3wa9SPaRu9w1M5+DbayagFQrPBfoNimBN3dsGf7/ZimR1Fa3fdXLAWIkbbIQ1dHkYpADjWwuo9KP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUi3wC+N; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c8a2579d94so1089559a12.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728565761; x=1729170561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQT6ZNqTcZvskYRGubnEVkFYIXB5jKNZYlr/scmkNS0=;
        b=dUi3wC+NXbXaFLDooXuXUHx4pY0UeQfC01LxsyBDtB8QgNM+xGEenqhLaZJQmwRgcL
         dgmkNwowweNiA9yQ0EVr5gs8Es0BeDF5DeX1nf3DMZX4sTj1Bxvfg0DfFr3ZoLjRLaN3
         UbjO9zdtWL7LNTbukSou12FheJGOGEdkR147SiA8QyzncEQigON7a7Fhru6gqHk0x8zl
         hdBzX8bGATMrTWaDA9sCCKMretGtWOtQz54wAsyI+wUWyQpZrOmgh9Xv9TO5JImaR0tR
         JYqK6TZsGaEKnLd3Ax2bDqPvI1kcmW1COxVGiaRgB+EQJFAPjlRkly2/SQhjgk/uEghf
         XfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565761; x=1729170561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQT6ZNqTcZvskYRGubnEVkFYIXB5jKNZYlr/scmkNS0=;
        b=wNHF+2OWL9DU9MzQXW4cdozAnBYLJM8/0Q2PfVeqCCgLxw4bHBAVERNHLiQKkiBN5c
         jaM1KRTCoyuyjx1P6nT001su2G5REsIxvsVcwVnYjN8X46tlQrYSyDhtZUKmTMi/gkNa
         AYvyznspWJ4VmYaLw3M2i7asf/g7BNFEgZEP6G2HqtMME9ZDwneiTmgRCzk+Mhmengxp
         ve2D0bQL8oIXQnwEEiAHT//C9UZcxlcAkgAoseUhWnCK6ZWAhu2wMMnLocwFwDsOx81c
         kRr5J4A3HxhKX9MkC2ywZ422X9+WkEHu+POO6W+IXYBNi/4PMjUcjIQdI+5RRC5G4q6G
         OUwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoCfMaKb6+zmB9xcoat1UNichi9FHew2iqGovFtRcftk/lwrQ6nMnXC5UorjRmhFkA7/yHrKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndMiXw0ehZmljJutHBv/WfpPglLf7lWdhGdCnm75+ckqPWUU8
	fKcfpDM6FS/o3TSmnVVOprSa7luIluGFqYpY2UIx35NHNlLLNR1Q4J6IZTB6z0Mmnr/dAkEqM71
	DNuZY5Wis2BtoA6KR60zU9aBGybplEljr0caNQMi+fBfZFHlmJeW7
X-Google-Smtp-Source: AGHT+IEeZr5cDMEk983+++5b9Ojj6VvAeBpHz605dIhdUvBRCpeLg8W6RXose1t9uw1kxwtE8KP8H0ltod7JwwPUYAs=
X-Received: by 2002:a05:6402:34cc:b0:5c5:b90a:5b78 with SMTP id
 4fb4d7f45d1cf-5c91d54303dmr5651176a12.5.1728565760720; Thu, 10 Oct 2024
 06:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009231656.57830-1-kuniyu@amazon.com> <20241009231656.57830-10-kuniyu@amazon.com>
In-Reply-To: <20241009231656.57830-10-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 15:09:09 +0200
Message-ID: <CANn89i+cEnst8vf8iXgqWQFAjtAKmkC0g5S9Eooi1V-FQztZjg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 09/13] rtnetlink: Fetch IFLA_LINK_NETNSID in rtnl_newlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:20=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Another netns option for RTM_NEWLINK is IFLA_LINK_NETNSID and
> is fetched in rtnl_newlink_create().
>
> This must be done before holding rtnl_net_lock().
>
> Let's move IFLA_LINK_NETNSID processing to rtnl_newlink().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

