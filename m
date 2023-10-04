Return-Path: <netdev+bounces-37970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677B7B815E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 0C9EDB2084A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFAA15E8C;
	Wed,  4 Oct 2023 13:52:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38413FF9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 13:52:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC2BC433C7;
	Wed,  4 Oct 2023 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696427528;
	bh=E6la+ND/liIx04hiE6s2YZ6l/Rh2sF2dmgmyPKZ4bQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aADBBAsq8K0ILCUB24zupmsF0EDPkCpmSL4ioXD5QeJKYLg9qDAdZmyUkSECOMHp3
	 /vN7UZeTWhZrhKg2Emzn/4ANPCnQGAOrZrPNjxYlW1RnPVZWVIp4wNJwcPiOEGKzmy
	 NZRI7ozcdSvEWsRTVN11pPGoI5BbAb3k8z7A+G9+7qEWsv17QFLlLlj6FFtqzDnH4B
	 dQYqDUMQDB3s+QqpLT++Fcpn3pXlnKuycn8omZY73/utqZ3bo1EJ/2ByOp183ah9pw
	 O8UurlqboulQUJ+ks52l4P/d+YEKexxeIo2ZkmEUlzSYWO9kYExG6pFFI6WhjNjY4r
	 PTkmeJY4nMCGg==
Date: Wed, 4 Oct 2023 06:52:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 jiri@resnulli.us, netdev@vger.kernel.org,
 syzbot+9bbbacfbf1e04d5221f7@syzkaller.appspotmail.com,
 syzbot+1c71587a1a09de7fbde3@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: team: get rid of team->lock in team module
Message-ID: <20231004065207.5fe143ad@kernel.org>
In-Reply-To: <20230916131115.488756-1-ap420073@gmail.com>
References: <20230916131115.488756-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Sep 2023 13:11:15 +0000 Taehee Yoo wrote:
> The purpose of team->lock is to protect the private data of the team
> interface. But RTNL already protects it all well.
> The precise purpose of the team->lock is to reduce contention of
> RTNL due to GENL operations such as getting the team port list, and
> configuration dump.

FTR I like this patch. My understanding is that team has relatively
low adoption (RHEL dropped the support completely?). The granular
lock is not necessary.

We're spending time trying to preserve and unnecessary optimization
in rarely used driver :(

