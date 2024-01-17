Return-Path: <netdev+bounces-63907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A6830087
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 08:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2ECB24286
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D6B676;
	Wed, 17 Jan 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fLeek/PA"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E59467
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476650; cv=none; b=kyWO5g1R7Rfcri+eJIkJr48DvO+N2FzD1OzXbWM4jPOPsZNLDGTwDXAVJbVTE6MApSl81SUnYUX7MSh/Isdnvt9JhDEC045ZnWRyJGyKiWF2lXZ1KUzXqQfffkXq5TtvbNUylztkeDuMB3Fn9oB7knIENSiCY90ZW2Hp/Oj3rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476650; c=relaxed/simple;
	bh=gqh8zaPPpa66hDrB75+WefGcuZsR/+/vIoRI55+7Sj4=;
	h=Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 X-EXCLAIMER-MD-CONFIG; b=eXb/cW0vAPv0fJK5wz6nj5PddTi5GWqOXjnzWL+maM92s1QPDPwtLTuLbTolzCcjGDINC8aolMRxA7SRb+PcJy5PVpd4bvh3rhaUZsOMKB25FNMdpIDXRENlQl3TxphwkUmNXMhPPuJG3aUovX8eQNkntqaTJcyUjPdgyjBKdwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fLeek/PA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9E39920519;
	Wed, 17 Jan 2024 08:22:02 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3McMXiSq70to; Wed, 17 Jan 2024 08:22:02 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 265A520520;
	Wed, 17 Jan 2024 08:22:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 265A520520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1705476122;
	bh=cNWTrGAPIcZ70z7LIWlSYDAFNCkyEpU02pHXNPZLQN0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=fLeek/PASIVNxlPg/iY+ABmmLSvJxUQu/8rD4+IQQu/UTzjyjFNM0S8LohoRJfLNW
	 SM/pMUfYD+KqEsAeNAISw0hbpXRxHpdfngc3JEsk/C3is4oSnwRpYz7ilrLkPO/CM5
	 1Hr28/SHufEH/p/9ivNlg8OpxD0oIO2SjK8Zj0LHrnWD58qQ1kP+6mX/J3bU830BvB
	 F2NOHQRXj3TR7VIXXkC40DeagZ7/+GqqoW1XO/hdGeAfVUSdQuzqib9AlQd/l+tEKR
	 LKRtVGx1ykxhV7RCK88edPTJlzy21CGk/0QnW0ozjyadENxNuV4R6j2sc17aOA0u+T
	 9cZ7+z8FJ1HoQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 21D0380004A;
	Wed, 17 Jan 2024 08:22:02 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 08:22:01 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 17 Jan
 2024 08:22:01 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5BB43318033A; Wed, 17 Jan 2024 08:22:01 +0100 (CET)
Date: Wed, 17 Jan 2024 08:22:01 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Guillaume Nault <gnault@redhat.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	<netdev@vger.kernel.org>, Florian Westphal <fw@strlen.de>, Simon Horman
	<horms@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH net] xfrm: Clear low order bits of ->flowi4_tos in
 decode_session4().
Message-ID: <ZaeAGc4AORHQuBGM@gauss3.secunet.de>
References: <73ad04e0f34b17b02d1eca263e4008440cf3b8e4.1704294322.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73ad04e0f34b17b02d1eca263e4008440cf3b8e4.1704294322.git.gnault@redhat.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Jan 03, 2024 at 04:06:32PM +0100, Guillaume Nault wrote:
> Commit 23e7b1bfed61 ("xfrm: Don't accidentally set RTO_ONLINK in
> decode_session4()") fixed a problem where decode_session4() could
> erroneously set the RTO_ONLINK flag for IPv4 route lookups. This
> problem was reintroduced when decode_session4() was modified to
> use the flow dissector.
> 
> Fix this by clearing again the two low order bits of ->flowi4_tos.
> Found by code inspection, compile tested only.
> 
> Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Applied, thanks a lot!

