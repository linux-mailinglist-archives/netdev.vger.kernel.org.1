Return-Path: <netdev+bounces-99430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6A98D4DA1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28FB61F22569
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B577E176233;
	Thu, 30 May 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyqbK50U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C41E186E26
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078392; cv=none; b=NZHM4b6xgAicEWwF9HldqnlPdv2PvOyYRIat/s8fMUNdl1jCTdcb/HC1ZqD40r7PXMMtS8/PUjm/dw1Uqtlw1b3h5RzW2PF7+v9t+dhhRUUsSeocB/5fJg+s1m6v1pM2FpNNiNDTs33V73/1rLOPv5iW226o7s47uWEzWxOPGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078392; c=relaxed/simple;
	bh=r5a0FVlFB8dVilFIOOoYFbQUjONqa/y/kOAP8TysiEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQTX7rRAp8WTGSy7w/tSglFtXonguqt6SzXaANSP9bS9T/Sfs257sfDIbT32pWtDdHyui+HQbDkMriMqfjbEwSOFSehZXkRTjIUrxqZO6CHfr7jvEiLq5nbU3eEKBo+/9cpwr4S0oRp22Yj4m0WSQcACVc2pT9XcHxrHmnvSZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyqbK50U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717078390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5a0FVlFB8dVilFIOOoYFbQUjONqa/y/kOAP8TysiEk=;
	b=YyqbK50Uf5Xt6oKYmai/VJDgMy4CjKGm6QTrILpyUCKBQ41gC+c2itjY1kFzgFETvRFJxV
	mvJpIUHCUd3P+vdHKuW3iD9s0AuHPaMBc0L6L7gkA+jcNl135NdzHi03zSFxwRepTY5Vrm
	rmFK8NCKRpSKoQxi0vveXCfKVo/Wy38=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-obrYYhtqPWON3sCjan7oEA-1; Thu, 30 May 2024 10:13:06 -0400
X-MC-Unique: obrYYhtqPWON3sCjan7oEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D47C0800CA5;
	Thu, 30 May 2024 14:13:05 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 78FAA40C6CB2;
	Thu, 30 May 2024 14:13:02 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: yongqin.liu@linaro.org
Cc: amit.pundir@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jstultz@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	sumit.semwal@linaro.org
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set to down/up
Date: Thu, 30 May 2024 16:13:00 +0200
Message-ID: <20240530141301.434601-1-jtornosm@redhat.com>
In-Reply-To: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
References: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hello Yongqin,

> is there any message that I could check to make sure if the
> initialization is finished?
> or like with adding some printk lines for some kernel functions to hack
>
>> Anyway, I will try to reproduce here and analyze it.
>
> Thanks very much! And please feel free to let me know if there is
> anything I could help with on the Android build.

I have finally managed to reproduce an error similar to the one mentioned
during the boot stage. I created a systemd service with a similar
configuration script to do the same and it works (I can reconfigure the
mac address at boot time, the ip address is configured and the interface
works), because the driver is completely initialized. In order to reproduce,
I have introduced a big delay in the probe operation to get closer in time
to the configuration script and the problem is there.
Maybe, the script set_ethaddr.sh could be synchronized with the driver, but
I think, if possible, it is better to check in a better way in the driver;
I will try it. When I have something I can comment you, if you can test it,
to be sure about the solution.

By the way, I have tried with my other fix to avoid the spurious link
messages, but it didn't help.

Best regards
José Ignacio


