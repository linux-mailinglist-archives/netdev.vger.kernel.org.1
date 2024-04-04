Return-Path: <netdev+bounces-85025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D985E899003
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 23:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C2F1C22259
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5B13B79F;
	Thu,  4 Apr 2024 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CRCX3U5a"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9311C6AF;
	Thu,  4 Apr 2024 21:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265745; cv=none; b=cT8sL6K+BpiGxdRT51sMg3naZCruWKMVBdZUiTs621qTGDuAnZoNulNLsU72tbV9mxEju8kYJLBoBLFP2B5Z53Rw8TThn84xQbJO9yRvMYS+bX3kdCPuJzSkI2UPg7yiMFiiNmNa8DOuScWBLXiWRFWLbqfZphmMqttMsXXZlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265745; c=relaxed/simple;
	bh=RoajnSQo90ahqN07mdhoTv3ubUHzrae//AMQ7eSZHUk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jO+Vb4ueAHocQgDKeGWOpd4YxSKYPiNzq7h2uCou5ywk1YGGxQK8iDoATSrVx5E1RwLFf1aEG+Jhc90own7zcfEualE2p0f6TMH/pTh39g/oLnHZTYX8Eyj+ThRJ3gQad4xCYrARHEeBV0/sjPV6kh1uoi9/V9vjQWVvLerkF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CRCX3U5a; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5eyKcts5tc20PP1aa+1X55nOhcWRUmdTyHy+NxYZWls=; b=CRCX3U5alVOz6DXjGUSMG2+eCm
	qo2wInb1hxXjfsYFMsosksFNxPoto0BZsFp4S38YFpVp8ZmzmBV0Hr7wbQroUMNMprkTTkdwgjDpz
	TzegGM/xIjtMMrew2yaOGKovdaqI0ZeXdddMs/ebguedCY83sNLgC7Poo7gSLTvNwwyMzkJcjXE47
	Zk03l5L8g7xQc7OYiTFBzi3I/RQlfkNOEr48b5gCDAXVMevQ3VFTqVbQvFDZ3MQVqSaKgb39Xpp3Y
	I/5zyoohcLl73FJpp9F9QI/VnWRjlbl4+soSLMkWItcXU99YxtWolNIVfrEMKBjq5wtVXb3Zncp6d
	jOIsvtmQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rsU8F-000FZp-Gb; Thu, 04 Apr 2024 22:56:23 +0200
Received: from [178.197.249.22] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rsU8E-00FjS9-2b;
	Thu, 04 Apr 2024 22:56:22 +0200
Subject: Re: [PATCH net] xsk: validate user input for
 XDP_{UMEM|COMPLETION}_FILL_RING
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot <syzkaller@googlegroups.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, bpf@vger.kernel.org
References: <20240404202738.3634547-1-edumazet@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ea789237-3f4d-267f-4aeb-85ca4d9fc0c4@iogearbox.net>
Date: Thu, 4 Apr 2024 22:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404202738.3634547-1-edumazet@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27235/Thu Apr  4 10:24:59 2024)

On 4/4/24 10:27 PM, Eric Dumazet wrote:
> syzbot reported an illegal copy in xsk_setsockopt() [1]
> 
> Make sure to validate setsockopt() @optlen parameter.
> 
[...]
> 
> Fixes: 423f38329d26 ("xsk: add umem fill queue support and mmap")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: "Björn Töpel" <bjorn@kernel.org>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>
> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
> Cc: bpf@vger.kernel.org

Given bpf tree PR went out, Jakub, feel free to take directly :

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thanks Eric !

