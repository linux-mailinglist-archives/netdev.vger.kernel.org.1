Return-Path: <netdev+bounces-160309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A802EA19399
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6457A115A
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 14:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4321421D;
	Wed, 22 Jan 2025 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Lqj3YvY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B02116FF
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737555328; cv=none; b=WU8mo+714VmXSJgnQczxAXWJ4xHohRNjgORJtaqnhIw/FmxznGTbBq9Jr6n8JuQFgr9MzdEtFRGGp97rdZ5oUw1WM7K3hAYO8o37ttNpzZo/lQHukewgcGO8w497TLs8eRlhY3BEllB3myeCyc/4St1HJiFVGiiM16ryq+FEkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737555328; c=relaxed/simple;
	bh=dLgX5KrOmozoD/qn76X002auAtPZmJiiXEh607otEm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DuMTtaF6hBNqYW8E6GRal7ciS7epxQE1rikxpDRjBoCQh54ApKWAaC/YAkvtyrrHqxk39n/uqPmS6wxaBz2KJkMbC5OZeEA8u4OBwxoW2VWXBwhgMLwzwXRsFV4TA86O6q8wcF94TGDRWC0A16bbB23VAZ8USVywiv3yTnnWI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Lqj3YvY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa689a37dd4so1266862766b.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 06:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737555325; x=1738160125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLgX5KrOmozoD/qn76X002auAtPZmJiiXEh607otEm4=;
        b=0Lqj3YvY9NOSPypA6A5v8RlgiJzLmPjKf5PxK988ggD5J4erqD1Vdd005ULWCp2KW+
         1DLCYPw6yjDku5ebU4DLjXRhBbcfPKPaUwj5RL9JyFYg/myRZDl+QElz2LRFXSJ+sL76
         DnVLkPwirMZ0eWiHJw8T0XFBmdkmtgBBOeNdRv7eZS8hmao8LKFufGl9O9/FYdYgp+zT
         ccfUBuGwj2TDzjHhgjI0OfxrKuPNlUkSeWqkHiD9eDEy0fSNOA7a9+/PF2EfFQLIJoo4
         lyvp1GZBitttMEoYyxzwtXEcL5qDSbB4G0CEpwxEvEhbB3ov5UAjI1QvI7MrFB4SA4Ab
         oxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737555325; x=1738160125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLgX5KrOmozoD/qn76X002auAtPZmJiiXEh607otEm4=;
        b=oVxM0cw01AFFSzLCF5htUVu16UXVAx4yD9qOBM3qdnUlALmtHd+HnA56UMRbCCVuJI
         yL6LtWO5Yzw1tmBxrRV8rP0IM242ZjmWOd7iYvB4F5sltT67V6oK9WAce6X7mTSYTCEe
         49Y7aQmll4KG3tHaMxnqwAVsc6WzPle6Jezl9ro07cAviyogHgrCIQlmC2sEhUYqf1iO
         I/J4fHIHxGIF+xmPMedSd6ypm73T7srKkYZBKb5dV6O/SnW9Q6xTBo19toWNGaJanZYJ
         ihQqGjyy/5yvC1pwt03rNuDPS+RLDVL3rpMqLXFJTxZlvf1PWB8vVusWhphOpqZ4gwRz
         dnAA==
X-Forwarded-Encrypted: i=1; AJvYcCVSrYLbakE9koshtGit7U6q+cC5lkok9rI/bGetyx5vYxnfYqDfBm4mAa7oygO9gM49BDWbm7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg/h0EznCrF87riw4YpyzAH4Br2B6BV7UsyxABnPCRbwRcebIO
	w8x1eB/IMqHh89HtvvFV08r1EMHC9Y8dmnTsTzXx6JN8pOAEbzSYWBbCIAHiJpMOQ4EHF9kIJ36
	oRgNb74oKRhqKaSn66Y3e/iAoQmzIQMe3Ydku
X-Gm-Gg: ASbGnct1duQZjzkOhh6EAKP4NJhqgoy6It0nH3UByHcNCufrA/S+JboAYwGQir9QKQU
	LvUFwjLhMvGxFXk3ELMFtQa4MEbs9uBLpG/TMgtcxL4Wg4QS4rg==
X-Google-Smtp-Source: AGHT+IGpDVyd/yt5SSWEsvx7ZMkHZJiWdBPVl0iUHaHNmFiysLysA0qZIxVb0TpDaULVZa7bXW0fDxzECXdMvDpHYYo=
X-Received: by 2002:a17:906:f1d2:b0:ab6:5143:6889 with SMTP id
 a640c23a62f3a-ab6514368b9mr327817166b.16.1737555324462; Wed, 22 Jan 2025
 06:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121221519.392014-1-kuba@kernel.org> <20250121221519.392014-6-kuba@kernel.org>
In-Reply-To: <20250121221519.392014-6-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jan 2025 15:15:13 +0100
X-Gm-Features: AbW1kvaqyYqbveUnT3h9mC1DeXFAqalBeuVlN0teeg1CDDMPfVyERAoptsbnUes
Message-ID: <CANn89iJAHzQ_5BhFVhLtXO0PHUsggEp8EkVi3v6OU7=1cjsciw@mail.gmail.com>
Subject: Re: [PATCH net-next 5/7] eth: niu: fix calling napi_enable() in
 atomic context
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, dan.carpenter@linaro.org, 
	willy@infradead.org, romieu@fr.zoreil.com, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 11:15=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> napi_enable() may sleep now, take netdev_lock() before np->lock.
>
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/dcfd56bc-de32-4b11-9e19-d8bd1543745d@stanle=
y.mountain
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

