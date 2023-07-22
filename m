Return-Path: <netdev+bounces-20096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8AB75DA52
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE682824B1
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A14711C81;
	Sat, 22 Jul 2023 06:23:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1020D10E4
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23582C433C8;
	Sat, 22 Jul 2023 06:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690006987;
	bh=ATt0mJH63hD11NsGO1CXJNXu6h7gACVARO144Twht50=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=lrpv8S0y1i61UKW0kJN2SmXvdtQ/2eVs6CPM3ouaiY6RVD+ZLeJxE7aP/2isQU2GF
	 YFGYStBGddsuVfDatpCqMKzbx0QNXobSYPnlKMs3Bg0FbOdh11jVqsIPsxioIoZuSa
	 /BgqmsVhNXiPa+8l8kp8ZT1Ly0zvuy1OKFun3kLtTYwfVXlSr3jbghQKfpR704HR8V
	 WnWQWjZs/0uTSBPcM7ABIoPTX9KDnJDcAVfXE3dnnw8IYLecATEUgsG4rEw2EcJqyt
	 4BIXlDOb3YMbp1CDz9t6AvjVpangT9xN/jPvz1EqkRxyf4Ef3Wbud7I3agYId9YiSe
	 rLvvNZqdHkbMQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>,  Paul Fertser <fercerpav@gmail.com>,
  linux-wireless@vger.kernel.org,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Ryder Lee <ryder.lee@mediatek.com>,  Shayne Chen
 <shayne.chen@mediatek.com>,  Sean Wang <sean.wang@mediatek.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Paolo Abeni <pabeni@redhat.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-mediatek@lists.infradead.org,  Rani Hod <rani.hod@gmail.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7615: do not advertise 5 GHz on first phy of
 MT7615D (DBDC)
References: <20230605073408.8699-1-fercerpav@gmail.com>
	<00a2f5ba-7f46-641c-2c0e-e8ecb1356df8@nbd.name>
	<20230721073701.38f8479c@kernel.org>
Date: Sat, 22 Jul 2023 09:23:03 +0300
In-Reply-To: <20230721073701.38f8479c@kernel.org> (Jakub Kicinski's message of
	"Fri, 21 Jul 2023 07:37:01 -0700")
Message-ID: <87jzus1n3s.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 21 Jul 2023 10:03:49 +0200 Felix Fietkau wrote:
>> On 05.06.23 09:34, Paul Fertser wrote:
>> > On DBDC devices the first (internal) phy is only capable of using
>> > 2.4 GHz band, and the 5 GHz band is exposed via a separate phy object,
>> > so avoid the false advertising.
>> > 
>> > Reported-by: Rani Hod <rani.hod@gmail.com>
>> > Closes: https://github.com/openwrt/openwrt/pull/12361
>> > Fixes: 7660a1bd0c22 ("mt76: mt7615: register ext_phy if DBDC is detected")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Paul Fertser <fercerpav@gmail.com>  
>> Acked-by: Felix Fietkau <nbd@nbd.name>
>> 
>> Jakub, could you please pick this one up for 6.5?
>
> Kalle reported that he's back to wireless duties a few hours after you
> posted so just to avoid any confusion - I'll leave this one to Kalle
> unless told otherwise.

Yup, I'm back. I assigned this to me on patchwork and planning to queue
for v6.5.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

