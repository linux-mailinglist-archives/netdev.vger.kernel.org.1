Return-Path: <netdev+bounces-219352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519DBB41094
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8CD5E73B0
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C6D274B57;
	Tue,  2 Sep 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqrhUmai"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015822836C;
	Tue,  2 Sep 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854540; cv=none; b=BPQQjC+zbzEWp7Xh2iFnhoHm4RtUrCtS+UAFiuOfYncObmRiDLvG/vK1kgD+3C45qJxPs9IOUTwE9ayvgULQsHIENQT0YIuhPvkp8+8o8QJFbZtEchD53Wda84H8vPu++hdmJTyJHnwfmRebjS9yg3VfRS0KZaB57PXPxwcd3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854540; c=relaxed/simple;
	bh=T+9KH3+pn/nDfyaZ9EriqR6kxXy6Kzda6bSn8C/VHao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzAL1tG/6Z03Fq4m5Jw1lKzvZ0R121pN88rzM+qyQ3Ii3YB870MrfvGBZcs6GkVFuXd7qxBGIJwbRbroQgVgsYkX8FuSHD8VbA3UPFKUH+OYAhZuFNXWc6YhVTAMUx34ZcBNYR/QyoF8HGa655SnhsWzlL89B8Unvwg/UWM3NxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqrhUmai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6B6C4CEED;
	Tue,  2 Sep 2025 23:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854539;
	bh=T+9KH3+pn/nDfyaZ9EriqR6kxXy6Kzda6bSn8C/VHao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dqrhUmaiZ+z/i/R2Ckeps3Wn/xsAlqXeXgOEkg8frCvjTZ1Z2ydc2KD7vYv0VV+C0
	 OJ5c6yGwAM++FipCWSLWjY3TYHfxVCvSGTgkDtvnIOvNvjVayOCI113e/1zf90XB3m
	 uysz0fobxH7BVh9pFhOOJl4UUykdJJ+9ZBV6yFEtpTKrIIgkrDpWiv7J0i4tI+zzPE
	 EhO3z3ge9/77P65As6m4QuJlhSQyKePf6Ckz6Bo7ttzyo7yYZNXpYn1QZLS8+s9MRo
	 H5xtXvOuvzrYQkMUtbb0FW7IRLUdMcxq+dFk5yZy0Ti/A4uZVmtqanSpbKNSIuBDcW
	 03rMSbt+nGvzg==
Date: Tue, 2 Sep 2025 16:08:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>
Cc: dima@arista.com, Eric Dumazet <edumazet@google.com>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan
 <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, Dmitry
 Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
Message-ID: <20250902160858.0b237301@kernel.org>
In-Reply-To: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
	<20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 05:31:47 +0100 Dmitry Safonov via B4 Relay wrote:
> Now that the destruction of info/keys is delayed until the socket
> destructor, it's safe to use kfree() without an RCU callback.
> As either socket was yet in TCP_CLOSE state or the socket refcounter is
> zero and no one can discover it anymore, it's safe to release memory
> straight away.
> Similar thing was possible for twsk already.

After this patch the rcu members of struct tcp_ao* seem to no longer 
be used?
-- 
pw-bot: cr

