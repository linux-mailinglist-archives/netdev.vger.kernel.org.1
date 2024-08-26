Return-Path: <netdev+bounces-121992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A442F95F7F2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4512AB218EF
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B3D19412F;
	Mon, 26 Aug 2024 17:23:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8A5192D64;
	Mon, 26 Aug 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692986; cv=none; b=TX960K2r74PtTgqq9Pu5YVGC64mO71n9cH8AnnGQT+ExeqVB9eaiDiiYxyc/Jj3FCCzM83sfX6kDVnPgBYKVcJGt6UJhsVzSWN56Mge9trMe5RPqUY1IkFXwXn6qwVqbD9JlhN4gXjkBi3jxubgDnER99BRMNe6InYO79fUZM74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692986; c=relaxed/simple;
	bh=Tbwceg4mBncecvIJb60omwuuf82G3YGTK9IQSWftNsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiRfTlrfOAFXEVtlwhc9nTYQNJI1ygfAQ4Xi5571mhIxNMNrRWF5KB8kDyPNE+D+Dz7JYuRoLxBqM77e8e1RYyyKl7UbpOBVQgzlvaxAMQOAxwbyJB/V6pU9RlXK61Hn5Aykuyn47Qkg54X9Un6Py1TS0YeRb+jQBXIBJ2GTfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WsyDk0RTZz9sPd;
	Mon, 26 Aug 2024 19:23:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uY71CR5DqUTz; Mon, 26 Aug 2024 19:23:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WsyDj6XDDz9rvV;
	Mon, 26 Aug 2024 19:23:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF4C28B77B;
	Mon, 26 Aug 2024 19:23:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hSYrx2GAOvwj; Mon, 26 Aug 2024 19:23:01 +0200 (CEST)
Received: from [192.168.233.119] (unknown [192.168.233.119])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A01C8B763;
	Mon, 26 Aug 2024 19:23:01 +0200 (CEST)
Message-ID: <c14bc7fa-5692-4952-ac83-ed14c65ed821@csgroup.eu>
Date: Mon, 26 Aug 2024 19:23:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next v2] net: ethtool: fix unheld rtnl lock
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240826180922.730a19ea@fedora-3.home>
 <20240826170105.5544-1-djahchankoike@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240826170105.5544-1-djahchankoike@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Diogo,

Le 26/08/2024 à 19:00, Diogo Jahchan Koike a écrit :
> [Vous ne recevez pas souvent de courriers de djahchankoike@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi Maxime
> 
> Thanks for the clarification, I missed that. Should I resend my first patch
> or should I release the lock before every return (tbh, I feel like that may
> lead to a lot of repeated code) and send a new patch?
> 

Do not duplicate release lock before every return.

See 
https://docs.kernel.org/process/coding-style.html#centralized-exiting-of-functions

Christophe

