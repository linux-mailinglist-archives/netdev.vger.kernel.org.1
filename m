Return-Path: <netdev+bounces-116735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F294B836
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685041F25617
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66889188002;
	Thu,  8 Aug 2024 07:49:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EF184114
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103383; cv=none; b=bvbPB2eNX6IuGDJ8j3vOECewZ2XF46ALgmZ/MjWautppl4OyZwY/1UsDdA0AepodLI6hBwvBSCkTIY99WlH6k5mwVvOoMAN8sKpK8iZXl9JErCG9Q7fQcOFPt9GW2wirw3Mw+W4yHAiOUbmQXJlOz5Z2S82rXxOkuGm5gXMInj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103383; c=relaxed/simple;
	bh=gOJr9e4E7br/KPgtRSt4FPMnkhQtTMMdTifCtoMGT7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8zj6g5p9mUWe20CSFKAgya1x1/WW+SeboFcS8xiqq25EYlV4fp9FsSEbizbzb6ujDgzKhO1SUR+M5WgVq82oSSnMcKPzmN3kUggQYl579Ym2/60snEcRJoybf2hvtd5H2USjsrMSsZTzA/RvsYIJTp4Nh6SLsgDaPJVZtyYmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sbxth-0008B1-NK; Thu, 08 Aug 2024 09:49:21 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sbxtf-005NJp-1r; Thu, 08 Aug 2024 09:49:19 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sbxte-008lsq-2w;
	Thu, 08 Aug 2024 09:49:18 +0200
Date: Thu, 8 Aug 2024 09:49:18 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Edward Adam Davis <eadavis@qq.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	kernel@pengutronix.de, leitao@debian.org, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, mkl@pengutronix.de,
	netdev@vger.kernel.org, pabeni@redhat.com, robin@protonic.nl,
	socketcan@hartkopp.net,
	syzbot+ad601904231505ad6617@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] can: j1939: fix uaf warning in
 j1939_session_destroy
Message-ID: <ZrR4fsTgDud3Uyo0@pengutronix.de>
References: <20240807071655.5b230108@kernel.org>
 <tencent_1F473700968236B84AEA74ED76FF67023C09@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_1F473700968236B84AEA74ED76FF67023C09@qq.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Edward,

On Thu, Aug 08, 2024 at 07:08:49AM +0800, Edward Adam Davis wrote:
> The root cause of this problem is when both of the following conditions
> are met simultaneously:
> [1] Introduced commit c9c0ee5f20c5, There are following rules:
> In debug builds (CONFIG_DEBUG_NET set), the reference count is always
> decremented, even when it's 1.
> 
> [2] When executing sendmsg, the newly created session did not increase the
> skb reference count, only added skb to the session's skb_queue.
> 
> The solution is:
> When creating a new session, do not add the skb to the skb_queue.
> Instead, when using skb, uniformly use j1939_session_skb_queue to add
> the skb to the queue and increase the skb reference count through it.
> 
> Reported-and-tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

This patch breaks j1939.
The issue can be reproduced by running following commands:
git clone git@github.com:linux-can/can-tests.git
cd can-tests/j1939/
ip link add type vcan
ip l s dev vcan0 up
./run_all.sh vcan0 vcan0


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

