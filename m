Return-Path: <netdev+bounces-204476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DD5AFAB8D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9783189B5E1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 06:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3032586EA;
	Mon,  7 Jul 2025 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iQ/Dzo15"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F31189919;
	Mon,  7 Jul 2025 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869080; cv=none; b=olGDL2/sXa3Csum7KWVwSQkAMZ4BW0PP2x3KWPEFzuqYaFdtsFjwUUFlsDJL2Z9jsf2rhvIE5jvO1YCmuzkPrFahfYiUgIMNpQWc2UYXEiaUFOR+sRRTBfWvriRBT4xuEofwxAsKhTbNPzIm+xPGW1hvXDXAh3Soq27+0LZ7MsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869080; c=relaxed/simple;
	bh=IWt85/zAdAgAUcn5iduO4+Zv6u2Kp0nMvo4Z4VnG2NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p34Ayz0AXKcJ0NdUuTrOSLF6pd69xU1q5S0vh95SF5x4mFumZQz3MZTt20C3erl2PgfrXnHaAiZqWycB5I3BIoKJLzZulxfzzsH/SBUrfUpkDmyVclJbv78M47y2l3l8MoKKhvG2lVkQRxfCrZTZNVX5yCx/HUYz5OSo4pwtPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iQ/Dzo15; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=VZ
	srLx97tWye6NiKsgqCtHfdvcsi1VEsnd1hn95P6g8=; b=iQ/Dzo15PLGeNQQHJk
	TBb+15iDmp5QKk6YjfDkyqN5rK62SJ3agPAvQyoL0s92f5dNCsPVfZ5eL4rduxdZ
	r/uLOUqCaTYWGT5AiKnpFd4inJKLoslv4QkUqDVNWmtzzc9aZyMDGye8rVBuvE/i
	QDgIH3aX3ChLy+hVqF4dn1zkg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHQKtjZmtoL8xmDA--.4702S2;
	Mon, 07 Jul 2025 14:17:09 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: pabeni@redhat.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	davem@davemloft.net,
	david.laight.linux@gmail.com,
	ebiggers@google.com,
	edumazet@google.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	stfomichev@gmail.com,
	willemb@google.com,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn
Subject: Re: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet transmission
Date: Mon,  7 Jul 2025 14:17:07 +0800
Message-Id: <20250707061707.74848-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1a24a603-b49f-4692-a116-f25605301af6@redhat.com>
References: <1a24a603-b49f-4692-a116-f25605301af6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHQKtjZmtoL8xmDA--.4702S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFykWr4DXry3GF1fGr4xCrg_yoW5Gry8pa
	yUJasFyrs8JF4UCrnrtw48uw4ay3yfKr15X3s8X34F9rn0gw1DWrW3trWj9FykGrnrK34Y
	vr4qgasrCa45ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR75rwUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiYw2DeGhrY+hd3wAAsf

On Sat, 5 Jul 2025 08:16:40 +0100 David Laight <david.laight.linux@gmail.com> wrote:

> On Fri, 4 Jul 2025 17:50:42 +0200
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On 7/4/25 11:26 AM, Feng Yang wrote:
> > > Thu, 3 Jul 2025 12:44:53 +0100 david.laight.linux@gmail.com wrote:
> > >   
> > >> On Thu, 3 Jul 2025 10:48:40 +0200
> > >> Paolo Abeni <pabeni@redhat.com> wrote:
> > >>  
> > >>> On 6/30/25 9:10 AM, Feng Yang wrote:  
> > >>>> From: Feng Yang <yangfeng@kylinos.cn>
> > >>>>
> > >>>> The "MSG_MORE" flag is added to improve the transmission performance of large packets.
> > >>>> The improvement is more significant for TCP, while there is a slight enhancement for UDP.    
> > >>>
> > >>> I'm sorry for the conflicting input, but i fear we can't do this for
> > >>> UDP: unconditionally changing the wire packet layout may break the
> > >>> application, and or at very least incur in unexpected fragmentation issues.  
> > >>
> > >> Does the code currently work for UDP?
> > >>
> > >> I'd have thought the skb being sent was an entire datagram.
> > >> But each semdmsg() is going to send a separate datagram.
> > >> IIRC for UDP MSG_MORE indicates that the next send() will be
> > >> part of the same datagram - so the actual send can't be done
> > >> until the final fragment (without MSG_MORE) is sent.  
> > > 
> > > If we add MSG_MORE, won't the entire skb be sent out all at once? Why doesn't this work for UDP?  
> > 
> > Without MSG_MORE N sendmsg() calls will emit on the wire N (small) packets.
> > 
> > With MSG_MORE on the first N-1 calls, the stack will emit a single
> > packet with larger size.
> > 
> > UDP application may relay on packet size for protocol semantic. i.e. the
> > application level message size could be expected to be equal to the
> > (wire) packet size itself.
> 
> Correct, but the function is __skb_send_sock() - so you'd expect it to
> send the 'message' held in the skb to the socket.
> I don't think that the fact that the skb has fragments should make any
> difference to what is sent.
> In other words it ought to be valid for any code to 'linearize' the skb.
> 
> 	David

Okay, thank you for your explanations.

> > 
> > Unexpectedly aggregating the packets may break the application. Also it
> > can lead to IP fragmentation, which in turn could kill performances.
> > 
> > > If that's not feasible, would the v2 version of the code work for UDP?  
> > 
> > My ask is to explicitly avoid MSG_MORE when the transport is UDP.
> > 
> > /P
> > 

So do I need to resend the v2 version again (https://lore.kernel.org/all/20250627094406.100919-1-yangfeng59949@163.com/), 
or is this version also inapplicable in some cases?


