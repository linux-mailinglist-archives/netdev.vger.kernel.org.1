Return-Path: <netdev+bounces-142940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854EC9C0B89
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5961F21A41
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C0C21A4CA;
	Thu,  7 Nov 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKuYkjVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EE21A4CC
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996466; cv=none; b=chDvDmLj55Qus2ntPr2UiBPgY1H2TxWzWxZLG4CMxs/FHQVbgW0270P+jzgxfLPgTb+HFyt41LnHntynUhy9ZjgNvFJcFeT33x+kDi+Hd4JEr16xkdM1jHmq0S1w5vcfIed+gyk9jcitto3QK2n7vls9u7ZWgTyiy6fBmkdfzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996466; c=relaxed/simple;
	bh=DhAozGC2/E2LQSCmRsFqNes+D8qly939kJIRCT0vWdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ec9zjOFAq+DuJBurZYCcb5JPGmFAy3a2voG/OUtpmyv2Bb9drGzxVHWwJd7sPFoRSCjjN9nVsVVU61gAsK3PFNH2tKtxTVoUe/ilgR60515oSHrVBqJmQ9/haPlUlFrTsLXKsowaIMipT8SIY8wb7i73cY6QxkDkdM5fM3buLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKuYkjVf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so1507666a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 08:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996463; x=1731601263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhAozGC2/E2LQSCmRsFqNes+D8qly939kJIRCT0vWdM=;
        b=RKuYkjVfwNyDQUhsSsVnGkG8VeVxASEke8YC+IAcTz6pKJZGhNOm922HVZL7V4EEku
         HAh2jum/BTvXVUnhwq97qr0pbTOdHpZkQQy5KyX6/WOavrYgQuiqd/gs0z7wEKucekUL
         jJIxtn2DoUquLI81FWIPa1IEwRr/Anm2VFbxIbwJMOu1Oze0xnyBE82isamm5hfFwyde
         EGtwx01BHFHZCdrBAGox5geo04jds182AdyoXf/E2I3ZyAv3n0YMZtvxFC+d85zjmVl2
         XKUv/VN+/aeDjZaKK3Mvl3qV2bI9cZ9bhg2NJhpgnr6fqlpXuz4ksfQ6sdOyTJEkXa7R
         MAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996463; x=1731601263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhAozGC2/E2LQSCmRsFqNes+D8qly939kJIRCT0vWdM=;
        b=PnRrsVyYcZ2VKzHOxScIKARs+0cQfk6J7xZHiFeh/opGfFfahBxo8IsS8Um7HHjcXI
         BzBf3X3+pwI4ULEv1m700ky621EFjo9m8BRjwyXRZ9nJ9PIWP+VTiR8E8W84JeT6q8t9
         ULUjk4cEfPRXbTSoPumLX4ZuW+mk4uKPFGjScLrJd87euGzLv6ZFcZJat7UrI9AW4J+H
         8nO4CiaHMcI/OkDpOFPfkqOiA9Zprr/TG9kq1rkDQF/Nt8yUVK18/t9hr4oVSwVW5zOz
         ulxLzN+6qBjIeUrdYVzMuh6RqKx9PBsyqgt977MXG1LeVzqwkJeH0IOVu/QYZCtKpNvB
         CyAw==
X-Gm-Message-State: AOJu0Yzok4Y76Sw3oczWPaE2Uv/aXauKEX9iYtXplfRSGYtH2vvkN1c0
	XHzP1eTw9J9b7seUjjf8vEHU23clgHQ6AU3Y3J31Vnmu0tviQQi0h27Hc2iWy7wtgA0MdjEczQQ
	IT0HSi3Tq/Dg5SJ+cjxnYOe/qnAuDslCoo0zn
X-Google-Smtp-Source: AGHT+IGUnS47jH/PAqnd7HBTd9+RFIXBJe1Hs0XEKOWMw7rBJ0ZGhQwh4vLiAUGUST6zSIqWq/pa60TUU+68ismDazA=
X-Received: by 2002:a05:6402:d0e:b0:5c9:76f3:7d46 with SMTP id
 4fb4d7f45d1cf-5ceb928c9damr16345120a12.21.1730996462524; Thu, 07 Nov 2024
 08:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160444.2913124-1-gnaaman@drivenets.com> <20241107160444.2913124-6-gnaaman@drivenets.com>
In-Reply-To: <20241107160444.2913124-6-gnaaman@drivenets.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 17:20:51 +0100
Message-ID: <CANn89iL7h+_--4fbv3AFNG13LrWfL0t5MQPJ-kYf3Wckihbfhg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] neighbour: Remove bare neighbour::next pointer
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:05=E2=80=AFPM Gilad Naaman <gnaaman@drivenets.com>=
 wrote:
>
> Remove the now-unused neighbour::next pointer, leaving struct neighbour
> solely with the hlist_node implementation.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

