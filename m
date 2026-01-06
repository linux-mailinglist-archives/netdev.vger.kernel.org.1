Return-Path: <netdev+bounces-247312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B726CCF6DA5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 07:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB88030184EC
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 06:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823B2D97B8;
	Tue,  6 Jan 2026 06:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXSHHI4A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36444503B
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767679880; cv=none; b=ovDj8yYEPm/KhF2ey8R39ZM4s3hysbMfy/wxXbYrwSe5VoYR8qU7ljKKLUg/uNZC49KSV989eCVBYuusRBbNKZK4vhJleQAGkCdtbmM+7QkEtfSBMTnr2bp5LUFCLiXyRYFaoLoiCFEd35wuCDgNvmezPRcUAbSHe6jVzzwcp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767679880; c=relaxed/simple;
	bh=TW1BLGJzUA2HFX2FIZXAcQb4YxgqtvfQYHI7vSpKCPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZFihQAjy8IiXDns4jp8Pn8xMx7VYof6xccah3Q13oI6HH75xHk99Kd6FO8Z+zEaIhUibLPLjB58YMEvmjEJfduIg+OWRo6S42D4Qtsh//PWVv7+FKqch2twSI/F8FmYroW5wTFek1uCKjtb7xjhH9hmqVjg0PjgvyoFpmVNkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXSHHI4A; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-78f89501423so29132997b3.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 22:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767679878; x=1768284678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQeYCmj0O5MJDb4kbZS8NRpXtHGgizN63ghiGVgFoFQ=;
        b=JXSHHI4AEnaMp0F2n8zR9kgFr80GulqK56qKJVzUEdRfScPAsMEu0oXUq5j29+0ult
         H1oEMXtPYmWG1HCLydd2aGLX+4mJRhcucvKwbiE+P1XH4QJy15swn2lc07PZk9YanBaD
         TR/F4+DKC3hqJnus2CPP9S49GZrGCNSaAF9yK0s2MKVnNQiPdhldWfyd8pOjmFIZa62h
         WDv4Ua4ntH0TnHGxYFOoQyQY1QS0QQpQdQI5Eps6S0o2RSw374D9RbQPwnCHJrbRp8sM
         CN/rBxwpBeqjkrtdnLdQk1F09fK9Ahw4wqMkFcUadO23kbOLp1K8KzfxY2e5oZy6PyQR
         pRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767679878; x=1768284678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQeYCmj0O5MJDb4kbZS8NRpXtHGgizN63ghiGVgFoFQ=;
        b=F6yYlXMutk5TczgzUb02GArfMEarH1NaVvnL6j3X95X+dGj2h0Y6UuSnDKXvqNVkj5
         Wlv4POgGDMkPPBfXpbscn/T0Gr65LKwqm4nb3KhLljXBIOC+SWyq2D+W7GcooR20EyBT
         0GtxdoEVXvR1I6F01goRnE189HxHEv/PPFerpjpPjr84fZk4Agcn7k6idOieyWz/UlQe
         rXC/0kfNsrQQo63GGuk+jYnI5eSe4c6Ged9q4fO7eJxjlkYSHSp8jugOGwtsimPnzLma
         /xlOE300hv0LsFwPnTB1zhpSf6vAeIgwH190ZVR6CUBM++iUBhQkhc2QB+7NrP7q2DmI
         zGFg==
X-Gm-Message-State: AOJu0YzlxGneMOW2Zl/w71OYqaW7h0Z0fvq6znpGS1b2PzDDtWHPjLJm
	GdWgqwep6DeyAEJhuytW+W+95q5K960vx1OZlTPMWxGunjmZicGxv7YR/PGs++jNd8rhIry4tY3
	D9hEaAtI7tITrB8mcjf026dVgZkUd7nXVeubW
X-Gm-Gg: AY/fxX6/uWybPzbSdFTik+jsL2QLEFrHYl1er0nJw+hQo42CN3J9j98tuXoaGJtHgMY
	37Ax2WEaa8R/kt0269amzgZC4ntzRvLiuHTa5BBgp01Jq0/MxIfT1//hET0GCcFhwSSgfefdY6d
	Mc2rJtcF6wXmSYaOLQwBC9S/cwUX7gs8fA9UTr3ETiC+6YhmyPoHNQrl8CuDJ6pADQ688mYLNSf
	nrghTgGQLW9AAsnzD8XYSArJiQblaphRUHeOfqvkTyTVLg5f73g3wudYGI6X26pk5WNzyk=
X-Google-Smtp-Source: AGHT+IHuiNxye+6L6PoMKgbjYbKeM3fFtKAFb8aI30W3MHbuvR8+c57QDcpT7Bw8E+kkWuDLpOYsAwHvk91gu7V5U8E=
X-Received: by 2002:a05:690e:4146:b0:640:ca9a:5f5b with SMTP id
 956f58d0204a3-6470d243d39mr1193873d50.1.1767679877795; Mon, 05 Jan 2026
 22:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105114732.140719-1-mahdifrmx@gmail.com> <20260105175406.3bd4f862@kernel.org>
In-Reply-To: <20260105175406.3bd4f862@kernel.org>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Tue, 6 Jan 2026 09:41:04 +0330
X-Gm-Features: AQt7F2rIT2-7EDPtBGKV-s4iuxfBFXZ9xm6J26utFG_x-JB1co6I4b320sq9jWY
Message-ID: <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  5 Jan 2026 15:17:32 +0330 Mahdi Faramarzpour wrote:
> > This commit adds SNMP drop count increment for the packets in
> > per NUMA queues which were introduced in commit b650bf0977d3
> > ("udp: remove busylock and add per NUMA queues").
>
> You must not submit more than one version of a patch within a 24h
> period.
Hi Jakub and sorry for the noise, didn't know that. Is there any way to che=
ck
my patch against all patchwork checks ,specially the AI-reviewer
before submitting it?

