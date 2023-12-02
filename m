Return-Path: <netdev+bounces-53253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B6801D0D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 14:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B451C20860
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 13:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B8218047;
	Sat,  2 Dec 2023 13:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="nn5VIFBf"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1181107;
	Sat,  2 Dec 2023 05:32:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701523896; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=GCwTnRFk6e80ShO3FX6v7rdJQSMX0/X1ovgySTMGf+n+RcIoiWf/xObfJcHxnq8gKodT31SK4Q/lMd9etxZXLBSwa+PMq8iEpXzw1lOjDT/YcTsWQF1oU/TKqAK/ZYPpL5HE1+SWyIfiICar7sh2ikKp0IyLwRz34of83WrrwtI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1701523896; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8/lJzpQ0l1BXHMNEoi4VijDBQ6ZH4sNvHefkNZ5BWIg=; 
	b=J/jZRMh9jwQWchU5mwN1r6kze5pzBmXb0lnERl8FI1Ks+nKKDEvGVlayonl0GyUw1EDoKz0vc/F5S3MCShIcD+iN694l0q3AOWbjjeGz49nu45BRh27UbQ7u9A2MBATQbhoFQ1lKfnNOkpvUGr/T37uIOk+c4jFcldwjrW9QftQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701523896;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8/lJzpQ0l1BXHMNEoi4VijDBQ6ZH4sNvHefkNZ5BWIg=;
	b=nn5VIFBf8sEFJbAUnNZKhWK8SW/lMvGaBuDXlZXoGxJy70UGKOWl4OVuaWxRSYfk
	C+p8z0l9ReNbOcv7f7uMRR7auhhG+vn1x+2U5UwWAFFaxeI9hz/GzYd5NtMMNJrYntW
	lyzCgi7hdQgI/4wShA2fUJgjIJhiyd6CLWA57y60=
Received: from mail.zoho.in by mx.zoho.in
	with SMTP id 1701523864503746.4314823257985; Sat, 2 Dec 2023 19:01:04 +0530 (IST)
Date: Sat, 02 Dec 2023 19:01:04 +0530
From: Siddh Raman Pant <code@siddh.me>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <18c2ab9bba5.26abdb8f38744.5002982123699219766@siddh.me>
In-Reply-To: <ae2aae77-c194-4924-b698-4a499eabec5d@linaro.org>
References: <cover.1700943019.git.code@siddh.me>
 <ba18da37e48b5c473e5b8bd76d6460017342f968.1700943019.git.code@siddh.me> <ae2aae77-c194-4924-b698-4a499eabec5d@linaro.org>
Subject: Re: [PATCH 1/4] nfc: Extract nfc_dev access from
 nfc_alloc_send_skb() into the callers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On Mon, 27 Nov 2023 15:40:51 +0530, Krzysztof Kozlowski wrote:
> On 25/11/2023 21:26, Siddh Raman Pant wrote:
> > The only reason why nfc_dev was accessed inside nfc_alloc_send_skb() is
> > for getting the headroom and tailroom values.
> > 
> > This can cause UAF to be reported from nfc_alloc_send_skb(), but the
> > callers are responsible for managing the device access, and thus the
> > UAF being reported, as the callers (like nfc_llcp_send_ui_frame()) may
> > repeatedly call this function, and this function will repeatedly try
> > to get the same headroom and tailroom values.
> 
> I don't understand this sentence.
> 
> "This can cause ..., but ...". But starts another clause which should be
> in contradictory to previous one.

Sorry about that, I should have phrased it better.

> > Thus, put the nfc_dev access responsibility on the callers and accept
> > the headroom and tailroom values directly.
> 
> Is this a fix or improvement? If fix, is the UAF real? If so, you miss
> Fixes tag.

I intended to remove access to nfc_dev (accessing which causes UAF) inside
this function, as it is used only for fetching headroom and tailroom integral
values.

nfc_llcp_send_ui_frame() called this function in a do-while loop, so
I thought of extracting the values before the loop, so that in the next
patch where I used locking, I would have to lock only once*.

Since these are two units of changes, I separated them into two patches.

Though since the next patch is shit anyways, this patch is not needed.

Thanks,
Siddh

